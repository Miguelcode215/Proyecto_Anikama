<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\VentaModel;
use Carbon\Carbon;
use App\Models\productoModel;
use Illuminate\Support\Facades\DB;

class graficosContoller extends Controller
{
    public function getMonthlySales() {
        // Configurar el locale para Windows
        setlocale(LC_TIME, 'Spanish_Spain.1252'); // Forzar el locale en Windows
        Carbon::setLocale('es');
    }
    // Grafico lineal de Ventas por mes
    public function Ventas_Mes(){
        $Ventas_Mes = VentaModel::selectRaw('YEAR(FechaEmicion) as anio, MONTH(FechaEmicion) as mes, SUM(Total) as total_sales')
                                ->groupBy('anio', 'mes')
                                ->orderBy('anio', 'asc') // Ordenar por año descendente
                                ->orderBy('mes', 'asc') // Ordenar por mes ascendente
                                ->get();

    // Formatear los datos para el gráfico (opcional)
        $formattedData = [
            'labels' => $Ventas_Mes->map(function($sale) {
                return Carbon::create($sale->anio, $sale->mes)->locale('es')->isoFormat('MMMM Y');  // Ejemplo: "Julio 2023"
        }),
        'data' => $Ventas_Mes->pluck('total_sales')
    ];

    return response()->json($formattedData);

    }

    // Obtener el total de productos y el porcentaje por categoría
    public function getProductosPorCategoria()
    {
        // Obtener el total de productos
        $totalProductos = productoModel::count();

        // Obtener el número de productos por categoría
        // Usamos una subconsulta para asegurarnos de obtener todas las categorías
        $productosPorCategoria = DB::table('categoria')
            ->leftJoin('productos', 'categoria.idCategoria', '=', 'productos.idCategoria')
            ->select('categoria.nombreCat as categoria', DB::raw('COUNT(productos.idProducto) as cantidad'))
            ->groupBy('categoria.nombreCat')
            ->get();

        // Calcular el porcentaje por categoría
        $data = [];
        foreach ($productosPorCategoria as $item) {
            $porcentaje = ($totalProductos > 0) ? round(($item->cantidad / $totalProductos) * 100, 2) : 0;

            $data[] = [
                'categoria' => $item->categoria,
                'cantidad' => $item->cantidad,
                'porcentaje' => $porcentaje . '%', // Agrega el símbolo de porcentaje
            ];
        }

        // También podemos incluir el total de productos en la respuesta
        return response()->json([
            'totalProductos' => $totalProductos,
            'data' => $data,
        ]);
    }
}
