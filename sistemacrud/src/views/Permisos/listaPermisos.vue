<template>
  <div>
    <!-- Card para agrupar los permisos -->
    <div class="card">
      <div class="card-header bg-success text-white text-center">
        <h5>Asiganr Permisos a: {{name}}</h5>
      </div>
      <div class="card-body">
        <!-- Grid para dividir los permisos en dos columnas -->
        <div class="row">
          <!-- Primera columna -->
          <div class="col-md-6">
            <ul class="list-group">
              <li v-for="(permiso, index) in permisosColumna1" :key="index" class="list-group-item">
                <input
                  class="form-check-input me-1"
                  type="checkbox"
                  :value="permiso.name"
                  :id="'permiso-' + index"
                  v-model="permisosSeleccionados"
                />
                <label class="form-check-label" :for="'permiso-' + index">{{ permiso.name }}</label>
              </li>
            </ul>
          </div>
          <!-- Segunda columna -->
          <div class="col-md-6">
            <ul class="list-group">
              <li v-for="(permiso, index) in permisosColumna2" :key="index" class="list-group-item">
                <input
                  class="form-check-input me-1"
                  type="checkbox"
                  :value="permiso.name"
                  :id="'permiso-' + (index + permisosColumna1.length)"
                  v-model="permisosSeleccionados"
                />
                <label class="form-check-label" :for="'permiso-' + (index + permisosColumna1.length)">
                  {{ permiso.name }}
                </label>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!-- Botones de acción -->
    <div class="mt-3">
      <button class="btn btn-warning" @click="actualizarpermisos(usuarioId)">Actualizar permisos</button>
      &nbsp; &nbsp; &nbsp;
      <router-link><button class="btn btn-secondary">Volver</button></router-link>
    </div>
  </div>
</template>

<script>
import { enviarSolicitud } from '@/funcionesJS/funcionesAxios';

export default {
  data() {
    return {
      name: this.$route.params.name ,
      permisos: [],  // Lista completa de permisos
      permisosSeleccionados: [],  // Permisos seleccionados por el usuario
      permisosIniciales: [],  // Permisos actuales del usuario (antes de hacer cambios)
      cargando: false,
      usuarioId: this.$route.params.id || null, // ID del usuario actual
    };
  },
  computed: {
    // Dividir los permisos en dos columnas para mostrar en dos listas
    permisosColumna1() {
      return this.permisos.slice(0, Math.ceil(this.permisos.length / 2));
    },
    permisosColumna2() {
      return this.permisos.slice(Math.ceil(this.permisos.length / 2));
    }
  },
  watch: {
    usuarioId(newVal) {
      // Cuando el usuario cambia, recarga los permisos
      this.getPermisosUsuario(newVal);
    }
  },
  mounted() {
    this.getPermisos();  // Obtener la lista de todos los permisos disponibles
    this.getPermisosUsuario(this.usuarioId);  // Obtener los permisos del usuario actual al cargar la vista
  },
  methods: {
    // Función para obtener todos los permisos disponibles
    getPermisos() {
      this.cargando = true;
      enviarSolicitud('GET', 'listaPermisos', {}, '', (data) => {
        this.permisos = data.permisos; // Asegúrate de que 'permisos' sea la clave correcta en el backend
        this.cargando = false;
      }, (error) => {
        console.error('Error al obtener permisos:', error);
        this.cargando = false;
      });
    },

    // Función para obtener los permisos ya asignados a un usuario
    getPermisosUsuario(usuarioId) {
      this.cargando = true;
      this.permisosSeleccionados = []; // Limpia la selección de permisos para evitar conflictos
      enviarSolicitud('GET', `usuarioPermisos/${usuarioId}`, {}, '', (data) => {
        this.permisosSeleccionados = data.permisos.map(p => p.name); // Asegúrate de que 'permisos' sea la clave correcta
        this.permisosIniciales = [...this.permisosSeleccionados]; // Guardar los permisos iniciales
        this.cargando = false;
      }, (error) => {
        console.error('Error al obtener los permisos del usuario:', error);
        this.cargando = false;
      });
    },

    // Actualizar permisos del usuario
    actualizarpermisos(usuarioId) {
      // Permisos a agregar: presentes en `permisosSeleccionados` pero no en `permisosIniciales`
      const add_permissions = this.permisosSeleccionados.filter(p => !this.permisosIniciales.includes(p));

      // Permisos a eliminar: presentes en `permisosIniciales` pero no en `permisosSeleccionados`
      const remove_permissions = this.permisosIniciales.filter(p => !this.permisosSeleccionados.includes(p));

      const payload = {
        add_permissions: add_permissions,
        remove_permissions: remove_permissions
      };

      enviarSolicitud('PUT', `ActualizarPermisos/${usuarioId}`, payload, null, (response) => {
        this.getPermisosUsuario(usuarioId); // Actualiza los permisos iniciales después de la actualización
      }, (error) => {
        console.error('Error al actualizar permisos:', error);
        alert('Error al actualizar permisos');
      });
    }
  }
};
</script>
