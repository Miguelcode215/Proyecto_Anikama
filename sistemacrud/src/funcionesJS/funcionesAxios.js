import axios from '@/axios'; // Importa axios desde el archivo configurado
import Swal from "sweetalert2";

// Función genérica para mostrar alertas
export function mostrarAlerta(titulo, icono, foco = "") {
    if (foco != "") {
        document.getElementById(foco).focus();
    }

    Swal.fire({
        title: titulo,
        icon: icono,
        customClass: { confirmButton: 'btn btn-primary', popup: 'animated zoomIn' },
        buttonsStyling: false
    });
}

// Función genérica para manejar solicitudes HTTP
export async function enviarSolicitud(metodo, url, data = {}, mensajeExito = '', callback = null) {
    try {
        // Solo envía data si no es GET o DELETE
        const config = {
            method: metodo,
            url: url,
            data: (metodo === 'GET' || metodo === 'DELETE') ? null : data,
            headers: {
                'Content-Type': 'application/json',
            }
        };

        if (metodo === 'DELETE') {
            config.data = data; // Envía los datos para DELETE si es necesario
        }

        const res = await axios(config);
        
        // Verifica el estado de la respuesta
        if (res.status === 200 || res.status === 201) {
            if (mensajeExito) {
                mostrarAlerta(mensajeExito, 'success');
            }
            if (callback) {
                callback(res.data);  // Pasa los datos de la respuesta al callback
            }
            return res.data; // Devuelve los datos si es necesario
        } else {
            mostrarAlerta('No se pudo recuperar la respuesta', 'error');
            throw new Error('Respuesta con estado no exitoso');
        }
    } catch (error) {
        console.error('Error en la solicitud:', error.message);
        mostrarAlerta('Error en la operación', 'error');
        throw error; // Lanza el error para manejarlo en la llamada de la función
    }
}

// Función genérica para confirmaciones de eliminación
export function confirmarEliminacion(url, datos, titulo, mensaje, callback = null) {
    const SwalWithBootstrapButton = Swal.mixin({
        customClass: { confirmButton: 'btn btn-success me-3', cancelButton: 'btn btn-danger' },
    });

    SwalWithBootstrapButton.fire({
        title: titulo,
        text: mensaje,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '<i class="fa-solid fa-check"></i> Sí, eliminar',
        cancelButtonText: '<i class="fa-solid fa-ban"></i> Cancelar'
    }).then((res) => {
        if (res.isConfirmed) {
            enviarSolicitud(
                'DELETE', 
                url, 
                datos, 
                'Eliminado correctamente', 
                callback
            );
        } else {
            mostrarAlerta('Operación Cancelada', 'info');
        }
});
}

//Funcion para manejar errores
export function ErroresRespuesta(error) {
    let mensaje = '';

    if (!error.response) {
        // Error sin respuesta del servidor (problemas de red, etc.)
        mensaje = 'No se pudo conectar con el servidor. Por favor, verifica tu conexión a internet.';
    } else {
        // Error con respuesta del servidor
        switch (error.response.status) {
            case 412:
                mensaje = 'Solicitud incorrecta. Por favor, verifica los datos enviados.';
                break;
            case 401:
                mensaje = 'No autorizado. Por favor, inicia sesión nuevamente.';
                break;
            case 403:
                mensaje = 'Prohibido. No tienes permiso para realizar esta acción.';
                break;
            case 404:
                mensaje = 'Recurso no encontrado. Por favor, verifica la URL.';
                break;
            case 409:
                mensaje = 'Prohibido. No se puede eliminar un registro que esta relacionado con otra tabla';
                break;
            case 500:
                mensaje = 'Error interno del servidor. Por favor, intenta nuevamente más tarde.';
                break;
            default:
                mensaje = 'Ocurrió un error inesperado. Por favor, intenta nuevamente.';
        }
    }
    Swal.fire({
        title: '¡¡ERROR!!',
        icon: 'error',
        text: mensaje,
        confirmButton:'Aceptar'
    })

    return mensaje;
}
