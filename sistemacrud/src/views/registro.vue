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
      <label class="form-label" for="email">Email:</label>
      <input
        v-model="email"
        class="form-input"
        type="email"
        id="email"
        required
        placeholder="Email"
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
      <input class="form-submit" type="submit" value="Sign Up" />
      <router-link to="/" class="btn btn-secondary mt-3">Back to Login</router-link>
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
        password_confirmation: this.passwordRepeat
      };

      try {
        // Asegúrate de que estás pasando la URL como segundo argumento y sea una cadena
        await enviarSolicitud('POST', 'registrar', parametros, 'Te has registrado exitosamente');
        
        // Redirigir a la página de login si todo fue exitoso
        this.$router.push({ name: 'login' });
      } catch (error) {
        mostrarAlerta(error.response?.data?.message || '', 'error');
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.register {
  padding: 2rem;
}
.title {
  text-align: center;
}
.form {
  margin: 3rem auto;
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 20%;
  min-width: 350px;
  max-width: 100%;
  background: rgba(19, 35, 47, 0.9);
  border-radius: 5px;
  padding: 40px;
  box-shadow: 0 4px 10px 4px rgba(0, 0, 0, 0.3);
}
.form-label {
  margin-top: 2rem;
  color: white;
  margin-bottom: 0.5rem;
  &:first-of-type {
    margin-top: 0rem;
  }
}
.form-input {
  padding: 10px 15px;
  background: none;
  background-image: none;
  border: 1px solid white;
  color: white;
  &:focus {
    outline: 0;
    border-color: #1ab188;
  }
}
.form-submit {
  background: #1ab188;
  border: none;
  color: white;
  margin-top: 3rem;
  padding: 1rem 0;
  cursor: pointer;
  transition: background 0.2s;
  &:hover {
    background: #0b9185;
  }
}
</style>
