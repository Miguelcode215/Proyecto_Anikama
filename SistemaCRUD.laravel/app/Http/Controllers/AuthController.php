<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Usuarios;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class AuthController extends Controller
{
    // Registro de usuario
    public function register(Request $request)
    {
        
    
        // Verificar si ya existe un usuario con el rol dueño_Sistema
        if ($request->role === 'dueño_Sistema' && Usuarios::role('dueño_Sistema')->exists()) {
            return response()->json([
                'status' => 409,
                'message' => 'Ya existe un usuario con el rol de dueño del sistema. No se puede registrar otro.'
            ], 409);
        }
    
        // Validar los datos de entrada
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|string|in:dueño_Sistema,Administrador,vendedor,sin_permisos', 
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'errors' => $validator->errors()
            ], 422);
        }
    
        // Crear el usuario
        $user = Usuarios::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);
    
        // Asignar el rol al usuario
        $role = $request->role;
        if (Role::where('name', $role)->exists()) {
            $user->assignRole($role);
        } else {
            return response()->json([
                'status' => 404,
                'message' => 'El rol no existe.'
            ], 404);
        }
    
        return response()->json([
            'status' => 201,
            'user' => $user
        ], 201);
    }
    

    // Inicio de sesión
    public function login(Request $request)
{
    $credentials = $request->only('email', 'password');

    // Verificar si el usuario existe
    $user = Usuarios::where('email', $request->email)->first();

    //verifica si el usuario esta ACTIVO o INACTIVO
    if($user->Estado === 'inactivo' || $user->Estado === '' || $user->Estado === null)
    if (!$user) {
        return response()->json([
            'status' => 404,
            'message' => 'La cuenta no existe.'
        ], 404);
    }

    // Verificar las credenciales
    if (!Auth::attempt($credentials)) {
        return response()->json([
            'status' => 412,
            'message' => 'Correo electrónico o contraseña incorrectos.'
        ], 412);
    }

    // Obtener el usuario autenticado
    $user = Auth::user();

    // Generar el token
    $token = $user->createToken('Personal Access Token')->plainTextToken;

    // Obtener roles del usuario
    $roles = $user->roles()->pluck('name');

    /// Obtener los permisos del usuario
    
    return response()->json([
        'status' => 200,
        'token' => $token,
        'roles' => $roles,
    ], 200);
}


    // Cierre de sesión
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
    
        return response()->json(['message' => 'Sesión cerrada correctamente'], 200);
    }

    // Obtener usuario autenticado
    public function getUser(Request $request)
    {
        $loggedInUserId = $request->user()->id; // Obtener el ID del usuario autenticado
        $users = Usuarios::where('id', '!=', $loggedInUserId)->get(); // Obtener todos los usuarios excepto el logueado
        
        return response()->json( $users);
    }
    
    public function mostraUser(Request $request)
    {
        // Obtener el usuario autenticado
        $user = $request->user();
    
        // Obtener los permisos del usuario
        $permisos = $user->getAllPermissions()->pluck('name'); // Obtiene solo los nombres de los permisos
    
        // Retornar el usuario y sus permisos en la respuesta JSON
        return response()->json([
            'user' => $user,
            'permissions' => $permisos
        ]);
    }
    
    // Eliminar cuenta desde la vista protegida
    public function deleteAccount(Request $request, $id)
    {
        $admin = Auth::user();
    
        // Solo administradores pueden eliminar cuentas
        if (!$admin->hasRole('Administrador') && !$admin->hasRole('dueño_Sistema')) {
            return response()->json([
                'status' => 403,
                'message' => 'No tienes permiso para eliminar cuentas.'
            ], 403);
        }
    
        $userToDelete = Usuarios::find($id); 
    
        if (!$userToDelete) {
            return response()->json([
                'status' => 404,
                'message' => 'Usuario no encontrado.'
            ], 404);
        }
    
        // Impedir la eliminación del administrador maestro
        if ($userToDelete->hasRole('Administrador')) {
            return response()->json([
                'status' => 403,
                'message' => 'La cuenta del Dueño del sistema no puede ser eliminada.'
            ], 403);
        }
    
        // Validar email, contraseña y confirmación
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string|min:8',
            'password_confirmation' => 'required|string|min:8|same:password'
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'errors' => $validator->errors()
            ], 422);
        }
    
        // Verificar la contraseña del usuario a eliminar
        if (!Hash::check($request->password, $userToDelete->password)) {
            return response()->json([
                'status' => 401,
                'message' => 'Contraseña incorrecta.'
            ], 401);
        }
    
        // Eliminar el usuario
        $userToDelete->delete();
    
        return response()->json([
            'status' => 200,
            'message' => 'Cuenta eliminada correctamente.'
        ],200);

    }
    


    // Actualizar contraseña
    public function updatePassword(Request $request, $id)
    {
        $currentUser = $request->user();
    
        // Verificar que el usuario autenticado sea dueño o administrador
        if (!$currentUser->hasRole('dueño_Sistema') && !$currentUser->hasRole('Administrador')) {
            return response()->json([
                'status' => 403,
                'message' => 'No tienes permiso para actualizar contraseñas.'
            ], 403);
        }
    
        // Buscar el usuario al que se le quiere actualizar la contraseña
        $userToUpdate = Usuarios::find($id);
    
        // Verificar si el usuario a actualizar existe
        if (!$userToUpdate) {
            return response()->json([
                'status' => 404,
                'message' => 'Usuario no encontrado.'
            ], 404);
        }
    
        // Verificar si el usuario autenticado es el dueño
        if ($currentUser->hasRole('dueño_Sistema') && $currentUser->id !== $id) {
            // El dueño puede actualizar la contraseña de otros usuarios
            // Validación de la solicitud
            $validator = Validator::make($request->all(), [
                'current_password' => 'required|string|min:8',
                'new_password' => 'required|string|min:8|different:current_password',
                'new_password_confirmation' => 'required|string|min:8|same:new_password',
            ]);
    
            if ($validator->fails()) {
                return response()->json([
                    'status' => 422,
                    'errors' => $validator->errors()
                ], 422);
            }
    
            // Verificación de la contraseña actual para el usuario a actualizar
            if (!Hash::check($request->current_password, $userToUpdate->password)) {
                return response()->json([
                    'status' => 401,
                    'message' => 'Contraseña actual incorrecta.'
                ], 401);
            }
    
            // Actualizar la contraseña
            $userToUpdate->password = Hash::make($request->new_password);
            $userToUpdate->save();
    
            return response()->json([
                'status' => 200,
                'message' => 'Contraseña actualizada correctamente.'
            ], 200);
        }
    
        // Validación para el administrador
        if ($currentUser->hasRole('Administrador')) {
            // Administradores pueden actualizar la contraseña de otros usuarios, pero no pueden actualizar la contraseña del dueño
            if ($userToUpdate->hasRole('dueño_Sistema')) {
                return response()->json([
                    'status' => 403,
                    'message' => 'No puedes actualizar la contraseña del dueño del sistema.'
                ], 403);
            }
    
            // Validación de la solicitud
            $validator = Validator::make($request->all(), [
                'current_password' => 'required|string|min:8',
                'new_password' => 'required|string|min:8|different:current_password',
                'new_password_confirmation' => 'required|string|min:8|same:new_password',
            ]);
    
            if ($validator->fails()) {
                return response()->json([
                    'status' => 422,
                    'errors' => $validator->errors()
                ], 422);
            }
    
            // Verificación de la contraseña actual para el usuario a actualizar
            if (!Hash::check($request->current_password, $userToUpdate->password)) {
                return response()->json([
                    'status' => 401,
                    'message' => 'Contraseña actual incorrecta.'
                ], 401);
            }
    
            // Actualizar la contraseña
            $userToUpdate->password = Hash::make($request->new_password);
            $userToUpdate->save();
    
            return response()->json([
                'status' => 200,
                'message' => 'Contraseña actualizada correctamente.'
            ], 200);
        }
    
        return response()->json([
            'status' => 403,
            'message' => 'No tienes permiso para actualizar contraseñas.'
        ], 403);
    }

    // Dar permisos a los usuarios
    public function asigPermission(Request $request, $id) 
    {
        // Verificar que el usuario autenticado sea dueño o administrador
        $currentUser = Auth::user();
        if (!$currentUser->hasRole('dueño_Sistema|Administrador')) {
            return response()->json([
                'status' => 403,
                'message' => 'No tienes permiso para registrar nuevos usuarios.'
            ], 403);
        }

        // Validar la solicitud
        $request->validate([
            'permissions' => 'required|array',
            'permissions.*' => 'exists:permissions,name', // Asegura que los permisos existan
        ]);
    
        // Obtener el usuario
        $user = Usuarios::find($id);
    
        // Asignar permisos al usuario
        $user->syncPermissions($request->permissions); // O usar $user->givePermissionTo() para agregar sin eliminar permisos existentes
    
        return response()->json([
            'message' => 'Permisos asignados correctamente.',
            'user' => $user->load('permissions') // Retorna el usuario con sus permisos
        ]);
    }

    // Actualizar permisos
    public function editPermission(Request $request, $id) {
        // Verificar si el usuario tiene permisos
        $user = Usuarios::find($id);
        $hasPermissions = $user->permissions()->exists();
    
        // Si no tiene permisos, considerarlo como una asignación inicial
        if (!$hasPermissions && empty($request->add_permissions)) {
            return response()->json([
                'status' => 400,
                'message' => 'No se puede actualizar permisos porque el usuario no tiene permisos asignados aún.'
            ], 400);
        }
    
        // Continua con la lógica de agregar o quitar permisos
        if (!empty($request->add_permissions)) {
            $user->givePermissionTo($request->add_permissions);
        }
        if (!empty($request->remove_permissions)) {
            $user->revokePermissionTo($request->remove_permissions);
        }
    
        return response()->json([
            'message' => 'Permisos actualizados correctamente.',
            'user' => $user->load('permissions')
        ]);
    }
    

    // Lista de permisos
    public function ListaPermission(){
        $permission = Permission::all();
        return response()->json([
            'mensaje' => 200,
            'permisos' => $permission
        ]);
    }

    //Trae los permisos de un usuario
    public function listarPermisosUsuario($id)
{
    // Buscar el usuario por ID
    $usuario = Usuarios::find($id);

    // Verificar si el usuario existe
    if (!$usuario) {
        return response()->json([
            'status' => 404,
            'message' => 'Usuario no encontrado.'
        ], 404);
    }

    // Obtener los permisos del usuario
    $permisos = $usuario->permissions;

    return response()->json([
        'status' => 200,
        'usuario' => $usuario->name, // Devuelve el nombre del usuario
        'permisos' => $permisos
    ]);
}

    // Actualizar estado de usuario
    public function UpdateUser(Request $request, $id){

        // Validar la solicitud
        $request->validate([
            'Estado' => 'required|boolean', // El estado debe ser booleano (true = activo, false = inactivo)
        ]);

        $EstadoUser = Usuarios::find($id);

        // Actualizar el estado de la categoría
        $EstadoUser->Estado = $request->Estado ? 'activo' : 'inactivo';
        $EstadoUser->save();

        return response()->json([
            'message' => 'Estado de la categoría actualizado correctamente',
            'Ususario' => $EstadoUser,
        ]);
    }
}
