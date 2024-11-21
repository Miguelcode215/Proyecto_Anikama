<?php

use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\productoController;
use App\Http\Controllers\Ventacontroller;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

//Ruta para el Dashboard
Route::get('index', function(){
    return view('indexB');
});

//Rutas de categoria
// Route::get('cat', [CategoriaController::class,'mostrarCat']);
// Route::post('NuevaCategoria', [CategoriaController::class,'NewCat']);
// Route::get('categoria/{idCategoria}',[CategoriaController::class,'traeCat']);
// Route::put('NuevaCategoria', [CategoriaController::class,'EditCat']);
// Route::delete('DeleteCat', [CategoriaController::class,'Deletecat']);

//Rutas para los Productos
// Route::get('productos',[productoController::class,'indexPro']);
// Route::post('NuevoPro', [productoController::class,'NewPro']);
// Route::get('producto/{idProducto}', [productoController::class,'selectPro']);
// Route::put('EditarProducto', [productoController::class,'EditPro']);
// Route::delete('EliminarPro', [productoController::class,'deletePro']);

//Rutas para Ventas
// Route::get('indexV', [Ventacontroller::class,'listarVenta']);
// Route::post('Venta', [Ventacontroller::class,'NewVenta']);