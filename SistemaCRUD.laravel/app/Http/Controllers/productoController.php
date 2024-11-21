<?php

namespace App\Http\Controllers;

use App\Models\productoModel;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpParser\Node\Stmt\TryCatch;

class productoController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }
    //controlador para mostrar datos
    public function indexPro(){
        $productos = DB::table("productos as P")
        ->join("categoria as C", "P.idCategoria", "=", "C.idCategoria")
        ->select('P.idProducto', 'P.NombrePro', 'P.Descripcion', 'P.Precio', 'P.Stock', 'P.FechaRegistro', 'P.FechaVencimiento', 'P.Estado', 'C.NombreCat')->get();
    
        return response()->json($productos);
    }

    public function NewPro(Request $request){
        $producto = new productoModel($request->all());
        $producto->FechaRegistro = Carbon::now()->format('Y-m-d');
        $producto->Estado = $producto->Stock <= 0 ? 'SIN STOCK' : 'DISPONIBLE';
        $producto->saveOrFail();

        return response()->json([$producto,200]);
    }

    public function selectPro($id){
        $producto = productoModel::findOrFail($id);
        return response()->json($producto);
    }

    public function EditPro(Request $request, $id){
        $productoE = productoModel::findOrFail($id);
        $productoE->update($request->all());
        $productoE->Estado = $productoE->Stock <= 0 ? 'SIN STOCK' : 'DISPONIBLE';
        $productoE->saveOrFail();


        return response()->json([
            'data'=>$productoE,
            'mensaje'=>"producto actualizado correctemente"
        ]);
    }

    public function deletePro($id){
       try{
        // Busca el id del producto
        $productoD = productoModel::findOrFail($id);
        // Elimina el producto 
        $productoD->delete();
        return response()->json([
            'data' => true,
            'mensaje' => "El Producto fue eliminado correctamente"
        ],200);
       }
       catch(\Illuminate\Database\QueryException $e){
        if($e->getCode()=="23000"){
            return response()->json([
                'data' => false,
                'mensaje' => 'El producto no se puede eliminar por que esta relacionada con alguna otra tabla'
            ], 409);
        }
        else{
            return response()->json([
                'data' => false,
                'mensaje' => 'el producto no se puede eliminar, hubo un error'
            ], 500);
        }
       }
    }
}
