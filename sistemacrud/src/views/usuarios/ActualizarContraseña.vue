<template>
    <div class="container mt-4">
        <h2>Editar Contraseña</h2>
        <p>Estás a punto de cambiar la contraseña del siguiente usuario:</p>
        <ul>
            <li><strong>Nombre:</strong> {{ userName }}</li>
        </ul>
        <form @submit.prevent="updatePassword">
            <div class="mb-3">
                <label for="current_password" class="form-label">Contraseña Actual</label>
                <input type="password" class="form-control" id="current_password" v-model="currentPassword" required />
            </div>
            <div class="mb-3">
                <label for="new_password" class="form-label">Nueva Contraseña</label>
                <input type="password" class="form-control" id="new_password" v-model="newPassword" required />
            </div>
            <div class="mb-3">
                <label for="new_password_confirmation" class="form-label">Confirmar Nueva Contraseña</label>
                <input type="password" class="form-control" id="new_password_confirmation" v-model="newPasswordConfirmation" required />
            </div>
            <button type="submit" class="btn btn-primary">Actualizar Contraseña</button>
            <router-link to="/usuarios" class="btn btn-secondary">Cancelar</router-link>
        </form>
    </div>
</template>

<script>
import { enviarSolicitud, mostrarAlerta } from '@/funcionesJS/funcionesAxios';

export default {
    data() {
        return {
            currentPassword: '',
            newPassword: '',
            newPasswordConfirmation: '',
            userName: this.$route.params.name || 'Nombre no disponible', // Obtener el nombre del usuario desde route params
            userId: this.$route.params.id || null // Obtener el ID del usuario desde route params
        };
    },
    methods: {
        async updatePassword() {
            try {
                if (!this.userId) {
                    mostrarAlerta('ID del usuario no disponible', 'error');
                    return;
                }

                await enviarSolicitud(
                    'PUT',
                    `Actualizar-contraseña/${this.userId}`, // Usar el ID del usuario para la ruta
                    {
                        current_password: this.currentPassword,
                        new_password: this.newPassword,
                        new_password_confirmation: this.newPasswordConfirmation
                    },
                    '' // No mostramos mensaje de éxito aquí, lo haremos con mostrarAlerta
                );

                // Mostrar la alerta de éxito usando la función mostrarAlerta
                mostrarAlerta('Contraseña actualizada correctamente', 'success');

                // Redirigir a la vista de usuarios después de cerrar la alerta
                setTimeout(() => {
                    this.$router.push({ name: 'usuarios' });
                }, 2000);

            } catch (error) {
                if (error.response && error.response.status === 401) {
                    mostrarAlerta('Contraseña actual incorrecta.', 'error', 'current_password');
                } else if (error.response && error.response.status === 422) {
                    mostrarAlerta('Error en la validación de los datos.', 'error');
                } else {
                    mostrarAlerta('Error al actualizar la contraseña.', 'error');
                }
            }
        }
    }
};
</script>

<style scoped>
.container {
    max-width: 100%; /* Ya no está centrado */
    margin: 20px; /* Espaciado alrededor */
}

ul {
    list-style: none;
    padding: 0;
}

li {
    margin-bottom: 10px;
}

button {
    margin-right: 10px;
}
</style>
