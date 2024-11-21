<?php

namespace App\Http\Controllers;

use App\Models\DetalleModel;
use App\Models\productoModel;
use App\Models\VentaModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Ventacontroller extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }
    // Método para listar las ventas
    public function listarVenta()
    {
        $Lventa = DB::table("detalleventa as DV")
            ->join("venta as V", "DV.idVenta", "=", "V.idVenta")
            ->join("productos as P", "DV.idProducto", "=", "P.idProducto")
            ->select('V.idVenta', 'V.FechaEmicion', 'V.Estado', 'V.Total', 'P.NombrePro as Producto', 'DV.Unidades', 'DV.Total as Subtotal')
            ->get();

        return response()->json($Lventa);
    }

    public function obtenerDetallesVenta($id){
    $detallesVenta = DB::table("detalleventa as DV")
        ->join("productos as P", "DV.idProducto", "=", "P.idProducto")
        ->select('DV.idVenta', 'P.NombrePro as Producto', 'DV.Unidades', 'DV.Total as Subtotal')
        ->where('DV.idVenta', $id)
        ->get();

    return response()->json($detallesVenta);
    }   

    // Método para crear una nueva venta
    public function NewVenta(Request $request)
    {
        // Validar la solicitud
        $request->validate([
            'FechaEmicion' => 'required|date',
            'Estado' => 'required|string|max:255',
            'productos' => 'required|array',
            'productos.*' => 'required|exists:productos,idProducto',
            'cantidades' => 'required|array',
            'cantidades.*' => 'required|integer|min:1',
            'subtotales' => 'required|array',
            'subtotales.*' => 'required|numeric|min:0',
        ]);
    
        // Verificar si todos los productos tienen stock suficiente
        foreach ($request->productos as $index => $idProducto) {
            $producto = productoModel::find($idProducto);
            if ($producto) {
                if ($producto->Stock < $request->cantidades[$index]) {
                    return response()->json(['error' => "No hay suficiente stock para el producto con ID {$idProducto}"], 400);
                }
            } else {
                return response()->json(['error' => "El producto con ID {$idProducto} no fue encontrado"], 404);
            }
        }
    
        // Crear la venta
        $venta = VentaModel::create([
            'FechaEmicion' => $request->FechaEmicion,
            'Estado' => $request->Estado,
            'Total' => array_sum($request->subtotales),
        ]);
    
        // Crear los detalles de la venta y actualizar el stock
        foreach ($request->productos as $index => $idProducto) {
            $producto = productoModel::find($idProducto);
            if ($producto) {
                // Reducir el stock
                $producto->Stock -= $request->cantidades[$index];
                $producto->saveOrFail();
    
                // Crear el detalle de la venta
                DetalleModel::create([
                    'idVenta' => $venta->idVenta,
                    'idProducto' => $idProducto,
                    'Unidades' => $request->cantidades[$index],
                    'Total' => $request->subtotales[$index],
                ]);
            }
        }
    
        return response()->json($venta);
    }
    
}
