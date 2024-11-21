<template>
  <div class="row mt-3">
    <div class="col-md-8 offset-md-2">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          <h2>Detalles de la Venta {{ id }}</h2>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Producto</th>
                  <th>Unidades</th>
                  <th>Subtotal</th>
                </tr>
              </thead>
              <tbody>
                <tr v-if="cargando">
                  <td colspan="3"><h4>Cargando...</h4></td>
                </tr>
                <tr v-else v-for="detalle in detalles" :key="detalle.id">
                  <td>{{ detalle.Producto }}</td>
                  <td>{{ detalle.Unidades }}</td>
                  <td>{{ detalle.Subtotal }}</td>
                </tr>
              </tbody>
            </table>
          </div>
          <router-link to="/ventas" class="btn btn-secondary mt-3">
            <i class="fa-solid fa-left-long"></i> Volver
          </router-link>
          &nbsp; &nbsp;
          <button class="btn btn-info mt-3">
            <i class="fa-solid fa-print"></i> Imprimir
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { enviarSolicitud } from '@/funcionesJS/funcionesAxios'; // Importa la función global para manejar solicitudes

export default {
  props: ['id'],
  data() {
    return {
      detalles: [],
      cargando: true,
    };
  },
  mounted() {
    this.cargarDetallesVenta(); // Llama a la función para obtener los detalles cuando el componente se monta
  },
  methods: {
    cargarDetallesVenta() {
      enviarSolicitud('GET', `ventas/${this.id}/detalles`, {}, '', (data) => {
        this.detalles = data;
        this.cargando = false;
      });
    },
  },
};
</script>
