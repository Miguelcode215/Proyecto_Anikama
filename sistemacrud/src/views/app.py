import cv2
import pytesseract
import numpy as np
import re
from flask import Flask, request, jsonify
from flask_cors import CORS

# Configurar Tesseract
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# Crear la aplicación Flask y habilitar CORS
app = Flask(__name__)
CORS(app)

def extract_receipt_data(image_path):
    # Leer la imagen
    image = cv2.imread(image_path)

    # Convertir a escala de grises
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Corrección de iluminación usando Homomorphic Filtering
    gray = cv2.log(np.float32(gray) + 1)
    mean, std = cv2.meanStdDev(gray)
    gray = (gray - mean) / (std + 1e-6)
    gray = cv2.normalize(gray, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)

    # Eliminar ruido
    denoised = cv2.fastNlMeansDenoising(gray, h=30)

    # Sharpening
    blurred = cv2.GaussianBlur(denoised, (9, 9), 10.0)
    sharpened = cv2.addWeighted(denoised, 1.5, blurred, -0.5, 0)

    # Corrección de perspectiva
    edges = cv2.Canny(sharpened, 50, 150)
    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contours = sorted(contours, key=cv2.contourArea, reverse=True)[:1]

    if contours:
        contour = contours[0]
        epsilon = 0.02 * cv2.arcLength(contour, True)
        approx = cv2.approxPolyDP(contour, epsilon, True)
        if len(approx) == 4:
            pts = approx.reshape(4, 2)
            rect = np.zeros((4, 2), dtype="float32")

            # Ordenar puntos
            s = pts.sum(axis=1)
            rect[0] = pts[np.argmin(s)]
            rect[2] = pts[np.argmax(s)]
            diff = np.diff(pts, axis=1)
            rect[1] = pts[np.argmin(diff)]
            rect[3] = pts[np.argmax(diff)]

            # Dimensiones del documento
            (tl, tr, br, bl) = rect
            width = max(int(np.linalg.norm(br - bl)), int(np.linalg.norm(tr - tl)))
            height = max(int(np.linalg.norm(tr - br)), int(np.linalg.norm(tl - bl)))

            dst = np.array([[0, 0], [width - 1, 0], [width - 1, height - 1], [0, height - 1]], dtype="float32")
            M = cv2.getPerspectiveTransform(rect, dst)
            warped = cv2.warpPerspective(sharpened, M, (width, height))
        else:
            warped = sharpened
    else:
        warped = sharpened

    # Resaltar texto
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (2, 2))
    morph = cv2.morphologyEx(warped, cv2.MORPH_CLOSE, kernel)
    binary = cv2.adaptiveThreshold(morph, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 15, 10)

    # Extraer texto
    custom_config = r'--oem 3 --psm 6'
    text = pytesseract.image_to_string(binary, config=custom_config)

    # Procesar texto extraído
    # Patrón para detectar productos
    product_pattern = re.compile(r'(?P<code>\d{10,13})\s+(?P<name>.+?)\s+(?P<price>\d+\.\d{2})')

    # Procesar texto línea por línea
    lines = text.splitlines()
    combined_lines = []
    buffer = ""

    for line in lines:
        # Si la línea parece ser un producto, procesarla
        if re.match(r'^\d{10,13}', line):  # Empieza con un código (10-13 dígitos)
            if buffer:  # Si hay contenido previo, agregarlo antes de continuar
                combined_lines.append(buffer.strip())
            buffer = line  # Comenzar nueva línea de producto
        elif buffer:  # Si es una continuación del producto, agregarla al buffer
            buffer += " " + line
        else:
            continue

# Agregar la última línea procesada
    if buffer:
        combined_lines.append(buffer.strip())


    # Regex para metadatos básicos
    metadata_patterns = {
        'store_name': re.search(r'([^\n]*(S\.A\.C|S\.A\.S|S\.A\.)[^\n]*)', text, re.IGNORECASE),
        'ruc': re.search(r'\b\d{9,11}\b', text),
        'address': re.search(r'(Av|Calle|Jirón|Jr|Pasaje|Pje|Blvd|Carretera|Carr)[^\n]*', text, re.IGNORECASE),
        'phone': re.search(r'\b\d{9}\b', text),
        'total': re.search(r'Total[^\d]*(\d+(\.\d{2})?)', text, re.IGNORECASE),
        'dni': re.search(r'\b(?:DMI|DNI)\b[^\d]*(\d{8})', text, re.IGNORECASE)
    }

    # Extraer metadatos
    extracted_data = {key: (match.group(1).strip() if key == 'dni' and match else match.group(0).strip() if match else 'No encontrado')
    for key, match in metadata_patterns.items()}


    # Extraer productos
    # Filtrar productos con la expresión regular
    products = []
    for line in combined_lines:
        match = product_pattern.search(line)
        if match:
            products.append({
                'code': match.group('code'),
                'name': match.group('name').strip(),
                'price': float(match.group('price'))
            })

    extracted_data['products'] = products
    return extracted_data


@app.route('/extract', methods=['POST'])
def extract():
    if 'image' not in request.files:
        return jsonify({'error': 'No se encontró una imagen en la solicitud'}), 400

    image_file = request.files['image']
    image_path = f"./{image_file.filename}"
    image_file.save(image_path)

    try:
        extracted_data = extract_receipt_data(image_path)
        return jsonify({'data': extracted_data}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Iniciar el servidor
if __name__ == '__main__':
    app.run(debug=True)
