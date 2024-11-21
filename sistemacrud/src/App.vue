<template>
  <div id="app" v-if="isAuthenticated">
    <nav id="sidebar" :class="{'sidebar-collapsed': !sidebarVisible, 'sidebar-expanded': sidebarVisible}">
      <div class="sidebar-header">
        <h4>Sistema CRUD Anikama</h4>
      </div>
      <ul class="nav flex-column">
        <li class="nav-item">
          <router-link class="nav-link" to="/home">
            <i class="fa-solid fa-home"></i> Inicio
          </router-link>
        </li>
        <!-- Mostrar si el rol es 'dueño_Sistema' -->
        <li class="nav-item dropdown" v-permissions="['Listar Categorias', 'Registrar Categorias']">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-cogs"></i>Gestion de Categorías
          </a>
          <ul class="dropdown-menu">
            <li><router-link class="dropdown-item" to="/categorias" v-permissions="['Listar Categorias']">Lista Categorías</router-link></li>
            <li><router-link class="dropdown-item" to="/nuevaCategoria" v-permissions="['Registrar Categorias']">Nueva Categoría</router-link></li>
          </ul>
        </li>
        <!-- Mostrar si el rol es 'dueño_Sistema' -->
        <li class="nav-item dropdown" v-permissions="['Listar Productos', 'Registrar Productos']">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-box"></i>Gestion de Productos
          </a>
          <ul class="dropdown-menu">
            <li><router-link class="dropdown-item" to="/productos" v-permissions="['Listar Productos']">Lista Productos</router-link></li>
            <li><router-link class="dropdown-item" to="/nuevoproducto" v-permissions="['Registrar Productos']">Nuevo Producto</router-link></li>
          </ul>
        </li>
        <!-- Mostrar si el rol es 'Administrador' -->
        <li class="nav-item dropdown" v-permissions="['Listar Ventas', 'Listar Detalle de Venta', 'Realizar Ventas']">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-receipt"></i> Gestion de Ventas
          </a>
          <ul class="dropdown-menu">
            <li><router-link class="dropdown-item" to="/realizarventa" v-permissions="['Realizar Ventas', 'Listar Productos']" >Nueva Venta</router-link></li>
            <li><router-link class="dropdown-item" to="/ventas" v-permissions="['Listar Detalle de Venta', 'Listar Ventas']">Lista de Ventas</router-link></li>
          </ul>
        </li>
        <!-- Opciones adicionales para 'dueño_Sistema' -->
        <li class="nav-item dropdown" v-permissions="['Listar Usuarios', 'Listar Permisos', 'Asignar y Eliminar Permisos', 'Eliminar Usuarios', 'Actualizar Credenciales', 'Registrar Usuarios']">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-users"></i> Gestion de Usuarios
          </a>
          <ul class="dropdown-menu">
            <li><router-link class="dropdown-item" to="/usuarios" v-permission="['Listar Usuarios', 'Listar Permisos', 'Asignar y Eliminar Permisos', 'Eliminar Usuarios', 'Actualizar Credenciales']">Lista de Usuarios</router-link></li>
            <li><router-link class="dropdown-item" to="/register" v-permissions="['Registrar Usuarios']">Nuevo Usuario</router-link></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-users"></i> Escaner de texto
          </a>
          <ul class="dropdown-menu">
            <li><router-link class="dropdown-item" to="/video">Escaner</router-link></li>
          </ul>
        </li>
      </ul>
    </nav>

    <div id="content-wrapper">
      <nav id="navbar-container" class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container-fluid">
          <button class="btn btn-dark me-3" type="button" @click="toggleSidebar">
            <i class="fa-solid fa-bars"></i>
          </button>
          <div class="d-flex ms-auto">
            <router-link class="btn btn-dark me-3" :to="{ name: 'perfil' }"> {{ userName }} <i class="fa-solid fa-user fa-beat"></i></router-link>
            <button class="btn btn-warning" @click="logout">Cerrar sesión</button>
          </div>
        </div>
      </nav>

      <main id="main-content">
        <div class="container-fluid">
          <router-view/>
        </div>
      </main>
    </div>
  </div>

  <div v-else>
    <router-view/>
  </div>
</template>

<script>
import axios from '@/axios';
import { mostrarAlerta } from '@/funcionesJS/funcionesAxios';
import { EventBus } from './directives/eventBus';
import Swal from 'sweetalert2';

export default {
  data() {
    return {
      isAuthenticated: !!localStorage.getItem('token'),
      userName: '',
      sidebarVisible: true,
      isChatbotOpen: false,     // Control del modal de chatbot
      isBotTyping: false,
      messages: [],             // Mensajes que se muestran en el chat
      options: [],              // Opciones actuales del chatbot
      selectedMainOption: null,  // Almacena el valor de la opción principal
      selectedSubOption: null,   // Almacena el valor de la subopción seleccionada
      currentMessage: null,      // Almacena el mensaje actual para enviar al seleccionar una subopción           // También inicializa esto como un array vacío
    };
  },
  methods: {async fetchBotResponse(mensaje = null, mensajeOption = null, mostrarOpcionesPrincipales = false) {
  try {
    // Mostrar indicador de que el bot está escribiendo
    this.isBotTyping = true;
    this.options = [];  // Limpiar las opciones mientras se espera la respuesta del bot

    // Imprimir los mensajes que se envían para verificar

    // Llamada al servidor para obtener la respuesta del bot
    const response = await axios.post('ChatBoot', { 
      mensaje,
      mensajeOption  // Enviar mensaje y mensajeOption si están definidos
    });

    console.log('response', response, 'mensaje:', mensaje, 'mensajeOption:', mensajeOption);

    if (mostrarOpcionesPrincipales) {
      // Solo mostrar las opciones principales sin el mensaje de bienvenida
      if (Array.isArray(response.data.opciones)) {
        this.options = response.data.opciones;  // Mostrar opciones principales
      } else {
        this.options = [];  // Limpiar si no hay opciones
      }

      // Reiniciar los valores de mensaje y mensajeOption
      mensaje = null;      // Reiniciar mensaje
      mensajeOption = null; // Reiniciar mensajeOption
    } else if (!mensajeOption) {
      // Opción principal
      this.messages.push({
        text: response.data.response,  // Mostrar el mensaje en "response"
        type: 'bot'  // Mensaje del bot
      });

      // Verificar si hay opciones principales
      if (Array.isArray(response.data.opciones)) {
        this.options = response.data.opciones;  // Mostrar opciones principales
      } else if (response.data.opciones?.original?.opciones) {
        this.options = response.data.opciones.original.opciones;  // Subopciones
      } else {
        this.options = [];  // Si no hay opciones, limpiar
      }
    } else {
      // Subopción
      let respuestaSubopcion = response.data.opciones?.original?.respuesta || 'No hay respuesta disponible';

      // Reemplazar saltos de línea '\n' con etiquetas HTML <br> para mostrar correctamente en el frontend
      respuestaSubopcion = respuestaSubopcion.replace(/\n/g, '<br>');

      this.messages.push({
        text: respuestaSubopcion,  // Mostrar el mensaje en "respuesta" con los saltos de línea procesados
        type: 'bot'  // Mensaje del bot
      });

      this.options = [];  // Limpiar opciones después de procesar la subopción

      // Volver a mostrar opciones principales si no hay más opciones o subopciones
      if (!response.data.opciones?.original?.opciones || response.data.opciones.original.opciones.length === 0) {
        // Mostrar mensaje de retorno al menú principal
        this.messages.push({
          text: 'Puedes segir preguntando',
          type: 'bot'
        });

        // Reiniciar mensaje y mensajeOption aquí antes de llamar a la API
        this.currentMessage = null;  // Reiniciar currentMessage
        this.selectedMainOption = null; // Reiniciar selectedMainOption
        this.selectedSubOption = null; // Reiniciar selectedSubOption

        // Llamar de nuevo a la API solo para mostrar las opciones principales sin el saludo inicial
        this.fetchBotResponse(null, null, true); // Enviar null para obtener las opciones principales sin el mensaje inicial
      }
    }

    // Ocultar los puntos de escritura
    this.isBotTyping = false;

  } catch (error) {
    console.error('Error fetching bot response:', error);
    this.isBotTyping = false;  // Asegurarse de que el indicador de "escribiendo" se oculta en caso de error
  }
},

selectOption(option) {
  // Obtener el número de la opción principal seleccionada (por ejemplo, "1. Gestion de stock" se convierte en "1")
  const mensaje = option.split('.')[0].trim();  // Extraer el número de la opción principal

  // Guardar el valor de la opción principal para usarlo en subopciones
  this.selectedMainOption = mensaje;
  this.currentMessage = mensaje; // Establecer el mensaje actual

  // Añadimos el mensaje del usuario con la opción seleccionada
  this.messages.push({
    text: option,
    type: 'user'  // Diferenciamos el mensaje del usuario
  });

  // Llamar a la función para obtener la respuesta del bot (enviar solo mensaje principal)
  this.fetchBotResponse(mensaje, null); // Aquí, mensajeOption es null
},

selectSubOption(option) {
  // Obtener el número de la subopción seleccionada (por ejemplo, "1. Productos sin stock" se convierte en "1")
  const mensajeOption = option.split('.')[0].trim();  // Extraer el número de la subopción

  // Guardar el valor de la subopción
  this.selectedSubOption = mensajeOption;

  // Añadimos el mensaje del usuario con la subopción seleccionada
  this.messages.push({
    text: option,
    type: 'user'  // Diferenciamos el mensaje del usuario
  });

  // Llamar a la función para obtener la respuesta del bot (enviar mensaje principal y subopción)
  this.fetchBotResponse(this.currentMessage, mensajeOption);
},


toggleChatbot() {
  this.isChatbotOpen = !this.isChatbotOpen;
},

closeChatbot() {
  this.isChatbotOpen = false;
},

restartChat() {
  // Reiniciar la conversación al estado inicial
  this.messages = [];              // Limpiar los mensajes del chat
  this.options = [];               // Limpiar las opciones
  this.selectedMainOption = null;  // Resetear la opción principal seleccionada
  this.selectedSubOption = null;   // Resetear la subopción seleccionada
  this.currentMessage = null;      // Resetear el mensaje actual para no mantener el estado previo
  
  // Llamamos al bot sin mensaje para que envíe el saludo inicial
  this.fetchBotResponse(null, null); // Enviar null para que el bot inicie la conversación
},

    toggleSidebar() {
      this.sidebarVisible = !this.sidebarVisible;
      this.updateSidebarStyles();
    },
    updateSidebarStyles() {
  const sidebar = document.getElementById('sidebar');
  const navbarContainer = document.getElementById('navbar-container');
  const mainContent = document.getElementById('main-content');

  if (sidebar && navbarContainer && mainContent) {
    if (this.sidebarVisible) {
      sidebar.classList.remove('sidebar-collapsed');
      sidebar.classList.add('sidebar-expanded');
      navbarContainer.style.marginLeft = '250px';
      mainContent.style.marginLeft = '250px';
    } else {
      sidebar.classList.remove('sidebar-expanded');
      sidebar.classList.add('sidebar-collapsed');
      navbarContainer.style.marginLeft = '0';
      mainContent.style.marginLeft = '0';
    }
  }
},
    async fetchUserName() {
      try {
        const response = await axios.get('mostarUser');
        if (response && response.status === 200) {
          this.userName = response.data.user.name;
          const permisos = response.data.permissions; // Asegúrate de acceder a response.data.permissions

          // Guarda los permisos en el localStorage
          localStorage.setItem('permissions', JSON.stringify(permisos));
          console.log("permisos del usuario: " + JSON.stringify(permisos));
          // Emitir el evento para actualizar los permisos en toda la app
          EventBus.emit('permissionsUpdated');
        }
      } catch (error) {
        console.error('Error fetching user data:', error);
      }
    },
    checkAuthentication() {
      this.isAuthenticated = !!localStorage.getItem('token');
      if (this.isAuthenticated) {
        this.fetchUserName();
      }
    },
    async logout() {
  try {
    await axios.post('logout');
    localStorage.removeItem('token');
    localStorage.removeItem('roles');
    localStorage.removeItem('permissions');


    // Eliminar los scripts del chatbot
    this.$root.removeChatbotScripts();
    Swal.fire({
      title: 'Has cerrado sesión correctamente',
      icon: 'success',
      confirmButtonText: 'ok',
      customClass: { confirmButton: 'btn btn-primary', popup: 'animated zoomIn' },
      buttonsStyling: false
    }).then((result) => {
      if (result.isConfirmed) {
        // Redirigir después de que el usuario haga clic en 'OK'
        this.redirectToHome();
      }
    });

  } catch (error) {
    console.error('Logout failed:', error);
    mostrarAlerta('Hubo un problema al cerrar la sesión. Inténtalo de nuevo.', 'error');
  }
},

loadChatbotScripts() {
      const token = localStorage.getItem('token');

      if (token) {
        // Verificar si los scripts ya están presentes para evitar duplicados
        if (!document.getElementById('injectScript') && !document.getElementById('botScript')) {
          const injectScript = document.createElement('script');
          injectScript.src = 'https://cdn.botpress.cloud/webchat/v2.2/inject.js';
          injectScript.async = true;
          injectScript.id = 'injectScript';

          injectScript.onload = () => {
            const botScript = document.createElement('script');
            botScript.src = 'https://files.bpcontent.cloud/2024/10/17/20/20241017200004-J17N8H70.js';
            botScript.async = true;
            botScript.id = 'botScript';
            document.body.appendChild(botScript);
          };

          document.body.appendChild(injectScript);
        }
      }
    },
    removeChatbotScripts() {
      const injectScript = document.getElementById('injectScript');
      const botScript = document.getElementById('botScript');

      if (injectScript) injectScript.remove();
      if (botScript) botScript.remove();
    } ,
    
    redirectToHome() {
    window.location.href = '/'; // Redirige a la ruta '/home'
    },

},

  watch: {
    '$route': 'checkAuthentication'
  },
  created() {
    this.checkAuthentication();
    // Cargar el chatbot si el usuario ya está autenticado
    this.loadChatbotScripts();
  },
  mounted() {
    this.fetchBotResponse(null);
    this.updateSidebarStyles();
    window.addEventListener('resize', this.updateSidebarStyles);

    
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.updateSidebarStyles);
  }
};
</script>

<style scoped>
/* Contenedor Principal que contiene el Sidebar y el Navbar Superior */
#content-wrapper {
  display: flex; /* Utiliza flexbox para organizar los elementos hijos */
  flex-direction: column; /* Organiza los elementos hijos en una columna */
  min-height: 100vh; /* Asegura que el contenedor tenga al menos la altura de la ventana */
  position: relative; /* Posiciona el contenedor en relación con su contenedor padre */
}

/* Sidebar (Navbar Vertical) */
#sidebar {
  color: #ffffff;
  width: 250px; /* Ancho del sidebar */
  background-color: #06b664; /* Color de fondo del sidebar */
  padding: 15px; /* Espaciado interno del sidebar */
  position: fixed; /* Posiciona el sidebar de forma fija */
  top: 0; /* Alinea el sidebar en la parte superior */
  left: 0; /* Alinea el sidebar a la izquierda */
  height: 100%; /* Altura del sidebar igual a la altura de la ventana */
  overflow-y: auto; /* Permite el desplazamiento vertical si el contenido es largo */
  transition: width 0.3s, transform 0.3s; /* Transición suave para cambios de ancho y transformación */
  z-index: 1000; /* Asegura que el sidebar esté sobre el contenido principal */
}

/* Sidebar Colapsado */
.sidebar-collapsed {
  width: 0; /* Ancho del sidebar colapsado */
  transform: translateX(-100%); /* Mueve el sidebar fuera de la vista horizontalmente */
  z-index: 500; /* Reduce el z-index para que el contenido principal se superponga cuando está colapsado */
}

/* Sidebar Expandido */
.sidebar-expanded {
  width: 250px; /* Ancho del sidebar expandido */
  transform: translateX(0); /* Asegura que el sidebar esté visible */
}

/* Estilo para el encabezado del sidebar */
.sidebar-header {
  padding: 15px; /* Espaciado interno del encabezado del sidebar */
  border-bottom: 2px solid #000000; /* Línea divisoria en la parte inferior del encabezado */
}

/* Estilo para enlaces en el sidebar */
#sidebar .nav-link {
  color: #ffffff; /* Color del texto de los enlaces en el sidebar */
  margin-bottom: 10px; /* Espacio entre los enlaces */
  font-weight: 500; /* Grosor del texto de los enlaces */
  display: block; /* Asegura que los enlaces se muestren como bloques para llenar el ancho disponible */
  padding: 10px; /* Espaciado interno de los enlaces */
  text-decoration: none; /* Elimina el subrayado de los enlaces */
}

/* Estilo para el enlace activo en el sidebar */
#sidebar .nav-link.active,
#sidebar .nav-link:hover {
  background-color: #ffffff; /* Color de fondo del enlace cuando está activo o al pasar el ratón sobre él */
  color: #000000; /* Color del texto del enlace cuando está activo o al pasar el ratón sobre él */
  border-radius: 4px; /* Bordes redondeados del enlace cuando está activo o al pasar el ratón sobre él */
}

/* Eliminar puntos en las opciones del sidebar */
#sidebar .nav-item ul {
  padding-left: 0; /* Elimina el espaciado izquierdo en las listas */
}

#sidebar .nav-item ul li {
  list-style-type: none; /* Elimina los puntos de las listas */
}

/* Navbar Superior (Horizontal) */
#navbar-container {
  margin-left: 250px; /* Margen izquierdo igual al ancho del sidebar para dejar espacio para el contenido principal */
  position: fixed; /* Posiciona el navbar de forma fija en la parte superior */
  top: 0; /* Alinea el navbar en la parte superior */
  left: 0; /* Alinea el navbar a la izquierda */
  right: 0; /* Alinea el navbar a la derecha */
  height: 65px; /* Altura del navbar */
  background-color: #d0eadb; /* Color de fondo del navbar */
  border-bottom: 1px solid #000000; /* Línea divisoria en la parte inferior del navbar */
  z-index: 1000; /* Asegura que el navbar esté sobre el contenido principal */
  display: flex; /* Utiliza flexbox para organizar los elementos hijos */
  align-items: center; /* Centra verticalmente los elementos hijos */
  padding: 0 15px; /* Espaciado interno del navbar */
  box-sizing: border-box; /* Incluye el espaciado interno en el ancho y alto del elemento */
  transition: margin-left 0.3s; /* Transición suave para el margen izquierdo */
}

/* Ajusta el margen cuando el sidebar está oculto */
#sidebar.sidebar-collapsed ~ #navbar-container {
  margin-left: 0; /* Elimina el margen izquierdo cuando el sidebar está oculto */
}

/* Contenido Principal */
#main-content {
  flex: 1; /* Permite que el contenido principal ocupe el espacio restante */
  margin-left: 250px; /* Margen izquierdo igual al ancho del sidebar para dejar espacio para el contenido principal */
  padding: 76px 20px 20px; /* Espaciado interno del contenido principal */
  transition: margin-left 0.3s; /* Transición suave para el margen izquierdo */
  position: relative; /* Asegura que el contenido principal esté en la misma capa de apilamiento que el sidebar */
  z-index: 1; /* Asegura que el contenido principal esté por encima del sidebar cuando está oculto */
}

/* Ajusta el margen cuando el sidebar está oculto */
#sidebar.sidebar-collapsed ~ #main-content {
  margin-left: 0; /* Elimina el margen izquierdo cuando el sidebar está oculto */
}
/* Modal del chatbot */
.chatbot-modal {
    position: fixed;
    bottom: 80px;
    right: 20px;
    width: 300px;
    height: 400px; /* Fijamos la altura del modal */
    background-color: white;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    display: flex;
    flex-direction: column;
    z-index: 4000;
  }

  /* Cabecera del chatbot */
  .chatbot-header {
    background-color: #4CAF50;
    padding: 10px;
    color: white;
    font-size: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
  }

  /* Contenedor de mensajes */
  .chatbot-body {
    flex: 1;
    padding: 10px;
    overflow-y: auto;
    scrollbar-width: none; /* Ocultamos el scrollbar */
    justify-content: flex-end;
  }

  /* Ocultamos el scrollbar en navegadores webkit */
  .chatbot-body::-webkit-scrollbar {
    display: none;
  }

  /* Mensajes */
  .message {
    margin-bottom: 10px;
    max-width: 80%;
    padding: 10px;
    border-radius: 10px;
  }

  /* Mensajes del bot */
  .message.bot {
    background-color: #e0e0e0;
    align-self: flex-start;
  }

  /* Mensajes del usuario */
  .message.user {
    background-color: #4CAF50;
    color: white;
    align-self: flex-end;
  }

  .chat-options {
  margin-top: 10px;
  display: flex;
  justify-content: flex-start;
  flex-wrap: wrap;
}
.bot-icon {
  width: 30px;
  height: 30px;
}
.typing-indicator {
  display: flex;
  align-items: center;
  font-size: 18px;
  color: #4CAF50;
}

.typing-indicator span {
  display: inline-block;
  width: 8px;
  height: 8px;
  margin: 0 2px;
  background-color: #4CAF50;
  border-radius: 50%;
  animation: typing 1s infinite ease-in-out;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes typing {
  0%, 100% {
    opacity: 0.3;
  }
  50% {
    opacity: 1;
  }
}

</style>

