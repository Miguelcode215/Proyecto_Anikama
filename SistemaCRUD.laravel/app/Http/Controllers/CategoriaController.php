<?php

namespace App\Http\Controllers;

use App\Models\CategoriaModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\support\Facades\Auth;
use App\Models\productoModel;
class CategoriaController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }
    // Listar las categorías
    public function mostrarCat(){
        $categorias = CategoriaModel::all();
        return response()->json($categorias);
    }

    // Crear una nueva categoría
    public function NewCat(Request $request){
        $categoria = new CategoriaModel($request->all());
        $categoria->saveOrFail();
        return response()->json([
            'data'=>$categoria,
            'mensaje'=>"se guardo correctamente la nueva categoria"
        ]);
    }  
    public function traeCat($id){
        $categoria = CategoriaModel::findOrFail($id);
        return response()->json($categoria);
    }


    public function EditCat(Request $request, $id){
        $categoria = CategoriaModel::findOrFail($id);
        $categoria->update($request->all());
        return response()->json($categoria);
    }

    public function Deletecat($id){
    try {
        // Buscar la categoría
        $categoria = CategoriaModel::findOrFail($id);

        // Intentar eliminarla
        $categoria->delete();

        return response()->json([
            'data' => true,
            'mensaje' => "Categoría eliminada con éxito"
        ], 200); // Código de respuesta 200 (OK)

    } catch (\Illuminate\Database\QueryException $e) {
        // Capturar el error de restricción de integridad referencial (foreign key)
        if ($e->getCode() == "23000") {
            return response()->json([
                'data' => false,
                'mensaje' => "No se puede eliminar la categoría porque está relacionada con productos."
            ], 409); // Código de respuesta 409 (Conflict)
        }

        // Otros errores de consulta
        return response()->json([
            'data' => false,
            'mensaje' => "Ocurrió un error al intentar eliminar la categoría."
        ], 500); // Código de respuesta 500 (Error del servidor)
    }
}


    public function actualizarEstado(Request $request, $id)
    {
        // Validar la solicitud
        $request->validate([
            'estado' => 'required|boolean', // El estado debe ser booleano (true = activo, false = inactivo)
        ]);
        

        // Encontrar la categoría por su ID
        $categoria = CategoriaModel::findOrFail($id);
        
        // Actualizar el estado de la categoría
        $categoria->estado = $request->estado ? 'activo' : 'inactivo';
        $categoria->save();

         // Actualizar los productos asociados según el nuevo estado de la categoría
        if ($request->estado) {
            // Si la categoría se activa, actualizar los productos asociados a 'disponible'
            productoModel::where('idCategoria', $id)
                ->update(['Estado' => 'disponible']);
        } else {
            // Si la categoría se desactiva, actualizar los productos a 'agotado'
            productoModel::where('idCategoria', $id)
                ->update(['Estado' => 'inactivo']);
        }

        return response()->json([
            'message' => 'Estado de la categoría actualizado correctamente',
            'categoria' => $categoria,
        ]);
    }
}

