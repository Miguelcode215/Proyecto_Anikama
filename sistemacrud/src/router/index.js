import { createRouter, createWebHistory } from 'vue-router';
import Login from '@/views/Login.vue'; // Ajusta la ruta según tu estructura de carpetas
import Register from '@/views/usuarios/registro.vue'; // Ajusta la ruta según tu estructura de carpetas
import Home from '@/views/HomeView.vue'; // Ajusta la ruta según tu estructura de carpetas
import Perfil from '@/views/usuarioperfil.vue'; // perfil del usuario-----------------------------------
import VentasView from '@/views/Ventas/VentasView.vue';
import VentasNew from '@/views/Ventas/VentasNew.vue';
import ListaDetalles from '@/views/Ventas/ListaDetalles.vue';
import CategoriasEdit from '@/views/Categorias/CategoriasEdit.vue';
import CategoriasNew from '@/views/Categorias/CategoriasNew.vue';
import CategoriasView from '@/views/Categorias/CategoriasView.vue';
import ProductosEdit from '@/views/Productos/ProductosEdit.vue';
import ProductosNew from '@/views/Productos/ProductosNew.vue';
import ProductosView from '@/views/Productos/ProductosView.vue';
import listaUsuarios from '@/views/usuarios/listaUsuarios.vue';
//rutas para usuarios
import ActualizarContraseña from '@/views/usuarios/ActualizarContraseña.vue';
import eliminarCuenta from '@/views/usuarios/eliminarCuenta.vue';
import { mostrarAlerta } from '@/funcionesJS/funcionesAxios';
// rutas para permisos-usuarios
import listaPermisos from '@/views/Permisos/listaPermisos.vue';
import Camara from '@/views/Camara.vue';

const routes = [
  {
    path: '/',
    name: 'login',
    component: Login,
    meta: { requiresAuth: false }
  },
  {
    path: '/register',
    name: 'register',
    component: Register,
    meta: { requiresAuth: true }
  },
  {
    path: '/home',
    name: 'home',
    component: Home,
    meta: { requiresAuth: true }
  },
  {
    path: '/perfil',
    name: 'perfil',
    component: Perfil,
    meta: { requiresAuth: true }
  },
  {
    path: '/:catchAll(.*)',
    redirect: '/' // Redirige a la página de login si la ruta no existe
  },
  {
    path: '/ventas', // Define la nueva ruta
    name: 'Venta',
    component: VentasView,
    meta: { requiresAuth: true, PermisosPermitidos:['Listar Ventas'] }
  }, 
  {
    path: '/realizarventa', // Define la nueva ruta
    name: 'Realizar venta',
    component: VentasNew,
    meta: { requiresAuth: true, PermisosPermitidos:['Realizar Ventas'] }
  }, 
  {
  path: '/listaDetalle/:id',
   name: 'DetalleVenta',
   component: ListaDetalles,
   props: true,
   meta: { requiresAuth: true, PermisosPermitidos:['Listar Detalle de Venta']}
  },
  {
    path: '/categorias', // Define la nueva ruta
    name: 'Categorias',
    component: CategoriasView,
    meta: { requiresAuth: true, PermisosPermitidos:['Listar Categorias'] }
  },
  {
    path: '/nuevaCategoria', // Define la nueva ruta
    name: 'Nueva Categoria',
    component: CategoriasNew,
    meta: { requiresAuth: true, PermisosPermitidos: ['Registrar Categorias']}
  },
  {
    path: '/editarC/:idCategoria', // Define la nueva ruta
    name: 'Editar Categoria',
    component: CategoriasEdit,
    meta: { requiresAuth: true, PermisosPermitidos:['Editar Categorias', 'Traer Categoria'] }
  },
  {
    path: '/productos', // Define la nueva ruta
    name: 'Productos',
    component: ProductosView,
    meta: { requiresAuth: true, PermisosPermitidos:['Listar Productos'] }
  },
  {
    path: '/nuevoproducto', // Define la nueva ruta
    name: 'nuevo producto',
    component: ProductosNew,
    meta: { requiresAuth: true, PermisosPermitidos:['Registrar Productos'] }
  },
  {
    path: '/editarP/:idProducto', // Define la nueva ruta
    name: 'Editar producto',
    component: ProductosEdit,
    meta: { requiresAuth: true, PermisosPermitidos:['Editar Productos', 'Traer Producto'] }
  },
  //rutas usuarios
  {
    path: '/usuarios', // Define la nueva ruta
    name: 'usuarios',
    component: listaUsuarios,
    meta: { requiresAuth: true, PermisosPermitidos:['Listar Usuarios'] }
  },
  {
    path: '/editar-contraseña/:id/:name',
    name: 'editar-contraseña',
    component: ActualizarContraseña,
    props: true, // Esto pasará las props como this.$route.params
    meta: { requiresAuth: true, PermisosPermitidos: ['Actualizar Credenciales']}
},
  {
    path: '/usuarios/:id/:name/:email',
    name: 'usuarios.confirmarEliminar',
    component: eliminarCuenta,
    props: true,
    meta: { requiresAuth: true, PermisosPermitidos: ['Eliminar Usuarios'] }
  },
  {
    path: '/permisos/:id/:name/:email',
    name: 'lista-permisos',
    component: listaPermisos,
    props: true,
    meta: { requiresAuth: true,PermisosPermitidos: ['Listar Permisos'] }
  },
  {
    path: '/permisos',
    name: 'lista-volver',
    component: listaPermisos,
    props: true,
    meta: { requiresAuth: true, PermisosPermitidos: ['Listar Permisos']}
  },
  {
    path: '/video',
    name: 'video',
    component: Camara,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  const isAuthenticated = !!localStorage.getItem('token');
  const userPermissions = JSON.parse(localStorage.getItem('permissions')) || [];

  // Verificar si la ruta requiere autenticación
  if (to.meta.requiresAuth) {
    if (!isAuthenticated) {
      // Si no está autenticado, redirigir al login
      next({ name: 'login' });
    } else {
      // Verificar si tiene los permisos adecuados
      const PermisosPermitidos = to.meta.PermisosPermitidos || [];

      if (PermisosPermitidos.length === 0 || PermisosPermitidos.some(permission => userPermissions.includes(permission))) {
        next(); // Si tiene los permisos permitidos, continuar
      } else {
        mostrarAlerta(`No tienes permiso para ingresar a ${to.name}`, 'error'); // Mostrar alerta si no tiene permiso
        next({ name: 'home' }); // Redirigir al home si no tiene permisos
      }
    }
  } else {
    // Rutas que no requieren autenticación
    if (isAuthenticated && (to.name === 'login' || to.name === 'register')) {
      next({ name: 'home' }); // Si ya está autenticado, redirigir al home
    } else {
      next();
    }
  }
});
export default router;
