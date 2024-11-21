<template>
    <div class="container mt-4">
        <h2>Confirmar Eliminación</h2>
        <p>Estás a punto de eliminar el siguiente usuario:</p>
        <ul>
            <li><strong>Nombre:</strong> {{ name }}</li>
            <li><strong>Email:</strong> {{ email }}</li>
        </ul>
        <form @submit.prevent="confirmarEliminacion">
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="password" v-model="password" required>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirmar Contraseña</label>
                <input type="password" class="form-control" id="confirmPassword" v-model="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-danger">Eliminar Usuario</button>
            <router-link to="/usuarios" class="btn btn-secondary">Cancelar</router-link>
        </form>
    </div>
</template>

<script>
import { mostrarAlerta, enviarSolicitud } from '@/funcionesJS/funcionesAxios';

export default {
    data() {
        return {
            email: decodeURIComponent(this.$route.params.email || ''),
            name: this.$route.params.name || '', // Asegúrate de que name no sea undefined
            password: '',
            confirmPassword: '',
            userId: this.$route.params.id || null // Asegúrate de que id no sea undefined
        };
    },
    methods: {
        async confirmarEliminacion() {
            if (!this.userId) {
                mostrarAlerta('ID del usuario no disponible', 'error');
                return;
            }

            try {
                await enviarSolicitud(
                    'DELETE',
                    `eliminar-cuentas/${this.userId}`, // Usamos el ID del usuario para la ruta
                    {
                        email: this.email, // Incluye el email en el cuerpo de la solicitud
                        password: this.password,
                        password_confirmation: this.confirmPassword
                    },
                    'Usuario eliminado correctamente'
                );

                mostrarAlerta('Usuario eliminado correctamente', 'success');
                this.$router.push('/usuarios');
            } catch (error) {
                if (error.response && error.response.status === 422) {
                    mostrarAlerta('Error en la solicitud: Datos inválidos', 'error');
                } else if (error.response && error.response.status === 401) {
                    mostrarAlerta('Contraseña incorrecta', 'error');
                } else if (error.response && error.response.status === 403) {
                    mostrarAlerta('Las cuentas de administrador no se pueden eliminar', 'error');
                } else {
                    mostrarAlerta('Error al eliminar usuario', 'error');
                }
            }
        }
    }
};
</script>

<style scoped>
/* Estilos adicionales si es necesario */
</style>