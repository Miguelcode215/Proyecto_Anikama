<template>
  <div class="login-container">
    <div class="login-form">
      <div class="logo">
        <i class="fas fa-camera"></i>
      </div>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="username">Correo de usuario</label>
          <input type="text" id="username" placeholder="Nombre de usuario" v-model="email" autocomplete="username">
        </div>
        <div class="form-group">
          <label for="password">Contraseña</label>
          <input type="password" id="password" placeholder="Contraseña" v-model="password" autocomplete="current-password">
        </div>
        <button type="submit" class="btn btn-primary">Iniciar sesión</button>
      </form>
    </div>
  </div>
</template>

<script>
import { enviarSolicitud, mostrarAlerta, ErroresRespuesta } from '@/funcionesJS/funcionesAxios'; // Importa las funciones generales

export default {
  data() {
    return {
      email: "",
      password: "",
    };
  },
  created() {
    const token = localStorage.getItem('token');
    if (token) {
      mostrarAlerta('Usted ya tiene una sesión iniciada', 'warning');
      this.$router.push({ name: 'home' });
    }
  },
  methods: {
  async login() {
    try {
      const response = await enviarSolicitud('post', 'login', {
        email: this.email,
        password: this.password
      });

      if (response && response.status === 200 && response.token) {
        const token = response.token;
        const roles = response.roles;

        localStorage.setItem('token', token);
        localStorage.setItem('role', JSON.stringify(roles));

        this.$store.dispatch('saveEmail', this.email);

        // Cargar el chatbot inmediatamente
        this.$root.loadChatbotScripts();

        this.$router.push({ name: 'home' });
      } else {
        throw new Error('Token no encontrado en la respuesta');
      }
    } catch (error) {
      ErroresRespuesta(error);
    }
  }
}
};
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 90vh;
}

.login-form {
  background: #efeef1;
  padding: 50px;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
  text-align: center;
}

.logo {
  font-size: 40px;
  margin-bottom: 20px;
  color: #24aa80;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 3px;
  box-sizing: border-box;
}

.btn {
  padding: 10px 20px;
  border: none;
  border-radius: 3px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary {
  background: #24aa6e;
  color: #000;
}

.btn-primary:hover {
  background: #247daa;
}
</style>
