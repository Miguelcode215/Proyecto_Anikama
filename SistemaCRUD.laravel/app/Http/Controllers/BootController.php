<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\productoModel;
use App\Models\VentaModel;
use Carbon\Carbon;

class BootController extends Controller
{
    public function mensajeBoot(Request $request)
    {
        // Resepciona el mensaje del usuario que interactua con el bot
        $mensajeUser = $request->input('mensaje');
        
        // Inicializa la respuesta y las opciones
        $response = '';
        $opciones = [];
        $mensajeInicial = '';

        // Si no hay mensaje o es el inicio de la conversación
        if (!$mensajeUser) {
            $mensajeInicial = '¡Hola! Bienvenido.';
            $response = 'Mi nombre es SLASH. ¿En qué te puedo ayudar hoy?';
            $opciones = $this->opcionesGenerales();
        } else {
            // Respuesta basada en la opción seleccionada
            switch ($mensajeUser) {
                case '1':
                    $response = 'Claro, quires aca te muestro las opciones que tienes para la gestion de Stock';
                    $opciones = $this->opcionesStock($request);
                    break;
                case '2':
                    $response = 'Esta bien, deseas ver las ganacias mensuales o semanales';
                    $opciones = $this->opcionesGanancias($request);
                    break;
                case '3':
                    $numero = '51939210888'; // Número de WhatsApp
                    $mensajePredefinido = 'Hola, tengo una consulta sobre el sistema'; // Mensaje predefinido
                    $response = 'Para contactarte con nosotros deja tu mensaje en: ';
                    $response .= "<a href='https://wa.me/$numero?text=" . urlencode($mensajePredefinido) . "' target='_blank' style='text-decoration: none; color: inherit;'>";
                    $response .= "<img src='https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg' alt='WhatsApp' style='width: 20px; height: 20px; vertical-align: middle;'> ";
                    $response .= "<span style='color: #25D366; text-decoration: underline;'>Chat de WhatsApp</span></a>"; // Estilo para el texto
                break;
                default:
                    $response = 'Lo siento, no entiendo esa opción. Por favor, selecciona una de las opciones disponibles.';
                    $opciones = $this->opcionesGenerales();
                    break;
            }
        }

        // Retorna la respuesta en formato JSON
        return response()->json([
            'mensajeInicial' => $mensajeInicial,
            'response' => $response,
            'opciones' => $opciones
        ]);
    }

    // Función que devuelve las opciones del chatbot
    private function opcionesGenerales()
    {
        return [
            '1. Gestion de stock',
            '2. Consultar ganancias',
            '3. Contactar a soprte'
        ];
    }

    private function opcionesStock(Request $request){
        // Obtener el mensaje del usuario
        $mensajeStock = $request->input('mensajeOption');
        
        // Inicializa las variables para la respuesta
        $response = '';
        $opciones=[];
        if(!$mensajeStock){
            $response = '';
            $opciones = [
                '1. Productos sin stock',
                '2. Productos por agotarse'
            ];
        }
        else{
            switch($mensajeStock){
                case 1:
                    $productosSinStock = productoModel::where('Stock', 0)->get(); // Consulta a la base de datos

                    if ($productosSinStock->isEmpty()) {
                        $response = 'No hay productos sin stock en este momento.';
                    } else {
                        $response = "Productos sin stock:\n";
                        foreach ($productosSinStock as $producto) {
                            $response .= "- {$producto->NombrePro}\n"; // Agregar el nombre del producto a la respuesta
                        }
                    }
                break;
                case 2:
                    $productosPorAgotarse = productoModel::where('Stock', '<=', 5)->get(); // Consulta a la base de datos

                    if ($productosPorAgotarse->isEmpty()) {
                        $response = 'No hay productos por agotarse en este momento.';
                    } else {
                        $response = "Productos por agotarse (stock <= 5):\n";
                        foreach ($productosPorAgotarse as $producto) {
                            $response .= "- {$producto->NombrePro} (Stock: {$producto->Stock})\n"; // Mostrar nombre y cantidad de stock
                        }
                    }
                    break;
                default:
                $response = 'Opción no válida. Por favor selecciona una de las opciones.';
            }
        }
        return response()->json([
            'opciones'=>$opciones,
            'respuesta'=>$response
        ]);
    }

    private function opcionesGanancias(Request $request){
        //Inicializamos la variable que obtendra la respuesta del user 
        $mensajeGanacias = $request->input('mensajeOption');
        // inizializamos las vaiables
        $respuesta = '';
        $opciones = [];

        // if, que evalua si el mensaje esta basio, solo mostrara las opciones
        if(!$mensajeGanacias){
            $respuesta='';
            $opciones = [
                '1. Ganancias Semanales',
                '2. Ganancias Mensuales'
            ];
        }
        //en el else, se aplican el flujo del switch, que maneja las respuestas
        else{
            switch($mensajeGanacias){
                case 1:
                    $haceUnaSemana = Carbon::now()->subDays(7);
                    $consultaGanancias = VentaModel::where('FechaEmicion', '>=', $haceUnaSemana)
                                                    ->sum('Total');
                    if($consultaGanancias >0){
                        $respuesta= "las ganacias de esta semana es de: S/{$consultaGanancias}.";
                    }
                    else{
                        $respuesta = "esta semana aun  no se registrro ninguna ganacia";
                    }
                break;
                case 2:
                    $inicioMes = Carbon::now()->startOfMonth();
                    $consultamensual = VentaModel::where('FechaEmicion', '>=', $inicioMes)
                                                  ->sum('Total');
                    if($consultamensual>0){
                        $respuesta = "las ganacias de este mes es de: S/{$consultamensual}.";
                    }
                    else{
                        $respuesta = "No se registro ganacias este mes";
                    }
                break;
                default:
                    $respuesta='No puedo ayudarlo, lo siento';
            }
        }

        return response()->json([
            'respuesta'=>$respuesta,
            'opciones'=>$opciones
        ]);
    }
    
}
