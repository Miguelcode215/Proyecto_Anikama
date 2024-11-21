<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use App\Models\Usuarios;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Crear los roles
        $roles = [
            'dueño_Sistema',
            'Administrador',
            'vendedor',
            'sin_permisos'
        ];

        foreach ($roles as $role) {
            Role::firstOrCreate(['name' => $role]);
        }

        // Asignar el rol de dueño_Sistema a un usuario específico
        $user = Usuarios::where('email', 'miguelsilva@example.com')->first();

        if ($user) {
            $user->assignRole('dueño_Sistema');
        } else {
            // Crear un nuevo usuario si no existe y asignarle el rol de dueño_Sistema
            $user = Usuarios::create([
                'name' => 'Dueño del Sistema',
                'email' => 'dueño@example.com',
                'password' => bcrypt('password123') // Cambia la contraseña según necesites
            ]);

            $user->assignRole('dueño_Sistema');
        }
    }
}
