<?php

use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\VentaController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BootController;
use App\Http\Controllers\graficosContoller;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->group(function () {
    // Ruta para las categorias
    Route::get('categorias', [CategoriaController::class, 'mostrarCat'])->middleware('permission:Listar Categorias');
    Route::post('categorias', [CategoriaController::class, 'NewCat'])->middleware('permission:Registrar Categorias');
    Route::get('categorias/{id}', [CategoriaController::class, 'traeCat'])->middleware('permission:Traer Categoria');
    Route::put('categorias/{id}', [CategoriaController::class, 'EditCat'])->middleware('permission:Editar Categorias');
    Route::delete('categorias/{id}', [CategoriaController::class, 'Deletecat'])->middleware('permission:Eliminar Categorias');
    Route::put('estadoCat/{id}',[CategoriaController::class,'actualizarEstado']);
    
    // Ruta para las ventas
    Route::get('ventas', [Ventacontroller::class, 'listarVenta'])->middleware('permission:Listar Ventas');
    Route::get('ventas/{id}/detalles', [VentaController::class, 'obtenerDetallesVenta'])->middleware('permission:Listar Detalle de Venta');
    Route::post('ventas', [Ventacontroller::class, 'NewVenta'])->middleware('permission:Realizar Ventas');
    
    // Rutas de los productos Productos
    Route::get('producto',[productoController::class, 'indexPro'])->middleware('permission:Listar Productos');
    Route::post('producto',[productoController::class, 'NewPro'])->middleware('permission:Registrar Productos');
    Route::get('producto/{id}',[productoController::class, 'selectPro'])->middleware('permission:Traer Producto');
    Route::put('producto/{id}',[productoController::class,'EditPro'])->middleware('permission:Editar Productos');
    Route::delete('producto/{id}',[productoController::class,'deletePro'])->middleware('permission:Eliminar Productos');   
    
    //ruta para traer al usuario/eliminar/actualizar
    Route::get('user', [AuthController::class,'getUser'])->middleware('permission:Listar Usuarios');
    Route::delete('eliminar-cuentas/{id}',[AuthController::class,'deleteAccount'])->middleware('permission:Eliminar Usuarios');
    Route::put('Actualizar-contraseña/{id}',[AuthController::class,'updatePassword'])->middleware('permission:Actualizar Credenciales');
    Route::post('registrar', [AuthController::class, 'register'])->middleware('permission:Registrar Usuarios');
    Route::get('mostarUser', [AuthController::class,'mostraUser']);
    Route::put('estadoUser/{id}',[AuthController::class, 'UpdateUser']);

    // Rutas para permisos
    Route::put('ActualizarPermisos/{id}',[AuthController::class,'editPermission'])->middleware('permission:Asignar y Eliminar Permisos');    
    Route::get('listaPermisos',[AuthController::class,'ListaPermission'])->middleware('permission:Listar Permisos');
    Route::get('usuarioPermisos/{id}', [AuthController::class, 'listarPermisosUsuario'])->middleware('role:Administrador|dueño_Sistema');
});
    
    
    // rutas para usuariso
    Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
    Route::post('login', [AuthController::class, 'login']);
    Route::get('Ventasdata',[graficosContoller::class,'Ventas_Mes']);
    Route::get('graficoProductos',[graficosContoller::class,'getProductosPorCategoria']);
    Route::post('ChatBoot',[BootController::class,'mensajeBoot']);
