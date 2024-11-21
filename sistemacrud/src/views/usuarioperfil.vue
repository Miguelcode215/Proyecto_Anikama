<template>
    <div class="container mt-5">
      <div class="card">
        <div class="card-header">
          <div class="d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0">Perfil de Usuario</h5>
            <router-link to="home" class="btn btn-secondary">Inicio</router-link>
          </div>
        </div>
        <div class="card-body">
          <!-- Información del perfil del usuario -->
          <div class="d-flex align-items-center mb-4">
            <div class="me-3">
              <i class="bi bi-person-circle" style="font-size: 3rem; color: #0d6efd;"></i>
            </div>
            <div>
              <p class="mb-1"><span class="fw-bold">Nombre de Usuario:</span> {{ user.name }}</p>
              <p class="mb-1"><span class="fw-bold">Correo:</span> {{ user.email }}</p>
            </div>
          </div>
          <!-- Botones para acceder a otras vistas -->
          <div class="d-flex">
            <router-link to="actualizarcontraseña" class="btn btn-primary me-2">Actualizar Contraseña</router-link>
            <router-link to="eliminar-cuenta-desde-sistema" class="btn btn-danger">Eliminar Cuenta</router-link>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { enviarSolicitud } from '@/funcionesJS/funcionesAxios';
  
  export default {
    data() {
      return {
        user: {
          name: '',
          email: ''
        }
      };
    },
    async created() {
      try {
        // Solicita los datos del usuario autenticado
        const response = await enviarSolicitud('GET', 'user');
        this.user = response;
      } catch (error) {
        console.error('Error al obtener los datos del usuario:', error.message);
      }
    }
  };
  </script>
  
  <style scoped>
  /* Estilos personalizados para mejorar la apariencia */
  .card {
    border-radius: 0.5rem;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  
  .card-header {
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
  }
  
  .card-body {
    padding: 2rem;
  }
  
  .d-flex {
    display: flex;
    align-items: center;
  }
  
  .btn-secondary {
    margin-left: auto;
  }
  
  .btn-primary, .btn-danger {
    margin-top: 1rem;
  }
  
  .card-text {
    margin-bottom: 0;
  }
  
  .fw-bold {
    font-weight: 700; /* Bootstrap font-weight bold class */
  }
  </style>
  