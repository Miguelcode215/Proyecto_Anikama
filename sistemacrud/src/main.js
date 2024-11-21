import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import '@fortawesome/fontawesome-free/css/all.min.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from './axios'; // Importa el archivo axios desde el directorio actual
import vPermission from './directives/v-permission';

const app = createApp(App);

app.config.globalProperties.$axios = axios; // Configura axios como una propiedad global

// Registra la directiva personalizada
app.directive('permissions', vPermission);

app.use(store);
app.use(router);

app.mount('#app');

import 'bootstrap/dist/js/bootstrap.bundle.min';
