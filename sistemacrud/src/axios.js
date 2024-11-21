import axios from 'axios';
import Swal from 'sweetalert2';
import router from './router/index';

// URL base del API
const instance = axios.create({
  baseURL: 'http://localhost:8000/api/',
});

// Interceptor para añadir el token en cada solicitud
instance.interceptors.request.use(
  (config) => {
    // Obtén el token de localStorage
    const token = localStorage.getItem('token'); 
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Interceptor para manejar respuestas y detectar la expiración del token
instance.interceptors.response.use(
  (response) => {
    // Si la respuesta es exitosa, devuélvela
    return response;
  },
  (error) => {
    // Si el error es 401 (Unauthorized), el token ha expirado o es inválido
    if (error.response && error.response.status === 401) {
      // Elimina el token de localStorage
      localStorage.removeItem('token');
      localStorage.removeItem('roles'); // Elimina roles también
      
      // Muestra la alerta de sesión expirada
      Swal.fire({
        icon: 'warning',
        title: 'Sesión expirada',
        text: 'Tu sesión ha expirado. Por favor, inicia sesión nuevamente.',
        confirmButtonText: 'OK',
        allowOutsideClick: false,  // Evita cerrar la alerta al hacer clic fuera
        allowEscapeKey: false,  // Evita cerrar la alerta con la tecla Escape
      }).then((result) => {
        // Redirige solo si el usuario ha presionado "OK"
        if (result.isConfirmed) {
          router.push({ name: 'login' });
        }
      });

      // Retorna una promesa rechazada vacía para detener la propagación de otros errores
      return Promise.reject(error); 
    }

    // Permite que otros errores se manejen de la manera usual
    return Promise.reject(error);
  }
);

export default instance;
