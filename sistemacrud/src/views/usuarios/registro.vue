<template>
    <div class="register">
      <form @submit.prevent="register" class="form">
        <label class="form-label" for="name">Name:</label>
        <input
          v-model="name"
          class="form-input"
          type="text"
          id="name"
          required
          placeholder="Name"
        />
        
        <label class="form-lable" for="email">Email:</label>
        <input
        v-model="email"
        class="form-input"
        type="email"
        id="email"
        required
        placeholder="email@elemplo.com"
        />
        
        <label class="form-label" for="password">Password:</label>
        <input
          v-model="password"
          class="form-input"
          type="password"
          id="password"
          required
          placeholder="Password"
        />
        
        <label class="form-label" for="password-repeat">Repeat Password:</label>
        <input
          v-model="passwordRepeat"
          class="form-input"
          type="password"
          id="password-repeat"
          required
          placeholder="Repeat Password"
        />
        
        <!-- Select para Roles -->
        <label class="form-label" for="role">Seleccionar Rol:</label>
        <select v-model="role" class="form-input" id="role" required>
          <option disabled value="">Selecciona un rol</option>
          <option value="Administrador">Administrador</option>
          <option value="vendedor">vendedor</option>
        </select>
        
        <input class="form-submit" type="submit" value="Registrar" />
        <router-link to="/usuarios" class="btn btn-secondary mt-3">vista de usuarios</router-link>
      </form>
    </div>
  </template>
  
  <script>
  import { mostrarAlerta, enviarSolicitud } from '@/funcionesJS/funcionesAxios';
  
  export default {
    data() {
      return {
        name: '',
        email: '',
        password: '',
        passwordRepeat: '',
        role: '', // Agregamos un estado para el rol seleccionado
      };
    },
    methods: {
      async register() {
        // Validar si las contraseñas coinciden
        if (this.password !== this.passwordRepeat) {
          mostrarAlerta('Las contraseñas no coinciden.', 'error', 'password');
          return;
        }
  
        const parametros = {
          name: this.name,
          email: this.email,
          password: this.password,
          password_confirmation: this.passwordRepeat,
          role: this.role // Pasamos el rol seleccionado al backend
        };
  
        try {
          await enviarSolicitud('POST', 'registrar', parametros, 'Te has registrado exitosamente');
          this.$router.push({ name: 'usuarios' });
        } catch (error) {
          mostrarAlerta(error.response?.data?.message || 'Error en el registro, vuelva a intentarlo de nuevo', 'error');
        }
      }
    }
  };
  </script>
  
  
  <style scoped>
  .register {
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background-color: #f9f9f9;
  }
  
  .form {
    display: flex;
    flex-direction: column;
  }
  
  .form-label {
    margin-bottom: 5px;
    font-weight: bold;
  }
  
  .form-input {
    margin-bottom: 15px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
  }
  
  .form-submit {
    padding: 10px;
    border: none;
    border-radius: 5px;
    background-color: #28a745;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  
  .form-submit:hover {
    background-color: #155923;
  }
  
  .btn-secondary {
    display: block;
    text-align: center;
    margin-top: 10px;
    color: white;
    text-decoration: none;
  }
  
  .btn-secondary:hover {
    text-decoration: underline;
  }
  </style>
  