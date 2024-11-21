<template>
  <div class="row mt-3 justify-content-center">
    <div class="col-md-10">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          Lista de Ventas
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table id="ventasTable" class="table table-bordered">
              <thead>
                <tr>
                  <th>#</th>
                  <th>ID</th>
                  <th>Fecha de Emisión</th>
                  <th>Total</th>
                  <th>Estado</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <tr v-if="cargando">
                  <td colspan="6"><h4>Cargando...</h4></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { enviarSolicitud } from '@/funcionesJS/funcionesAxios'; // Importa la función global para manejar solicitudes
import $ from 'jquery';
import 'datatables.net';
import 'datatables.net-bs5';
import Swal from 'sweetalert2';

export default {
  data() {
    return {
      ventas: [],
      cargando: false,
    };
  },
  mounted() {
    this.cargarVentas(); // Llama a la función para obtener las ventas cuando el componente se monta
  },
  methods: {
    tienePermiso(permiso) {
        const permisos = JSON.parse(localStorage.getItem('permissions') || '[]');
        return permisos.includes(permiso);
        },
    initializeDataTable() {
      this.$nextTick(() => {
        if ($.fn.DataTable.isDataTable('#ventasTable')) {
          $('#ventasTable').DataTable().destroy(); // Destruye la tabla existente si ya está inicializada
        }

        $('#ventasTable').DataTable({
          paging: true,
          searching: true,
          ordering: true,
          data: this.ventas,
          columns: [
            { data: null, render: (data, type, row, meta) => meta.row + 1 },
            { data: 'idVenta' },
            { data: 'FechaEmicion' },
            { data: 'Total' },
            { data: 'Estado' },
            {
              data: null,
              render: (data, type, row) => `
                <div class="d-flex">
                  <button class="btn btn-info details-btn" data-id="${row.idVenta}">
                    <i class="fa-regular fa-eye"></i>
                  </button>
                </div>
              `,
            },
          ],
        });

        $('#ventasTable').on('click', '.details-btn', (event) => {
          const id = $(event.currentTarget).data('id');
          if (this.tienePermiso('Listar Detalle de Venta')){
          this.$router.push({ name: 'DetalleVenta', params: { id } });
          } else{
            Swal.fire({
                        icon: 'error',
                        title: 'Acceso Denegado',
                        text: 'No tienes permiso para listar los detalles de esta venta.',
                    });
          }
        });
      });
    },

    cargarVentas() {
      this.cargando = true;
      enviarSolicitud('GET', 'ventas', {}, '', (data) => {
        this.ventas = data;
        this.cargando = false;
        this.initializeDataTable(); // Inicializa el DataTable con los datos obtenidos
      });
    },
 },
};
</script>
<style scoped>
/* Estilos generales */
.card {
  border-radius: 1px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card-header {
  background-color: #4b4f56;
  color: #ffffff;
  font-size: 1.25rem;
  font-weight: bold;
  padding: 15px;
}


.table th {
  background-color: #f1f1f1;
  color: #333;
  text-align: left;
  padding: 50px;
}

.table {
  table-layout: auto; /* Permite que las columnas se ajusten al contenido */
  width: 100%; /* Hace que la tabla ocupe todo el ancho disponible */
}

.table th{
  white-space: nowrap; /* Evita que el texto se divida en varias líneas */
  padding: 1px; /* Ajusta el espaciado en las celdas */
  vertical-align: middle;
  font-size: 1rem;
}
.table td {
  white-space: nowrap; /* Evita que el texto se divida en varias líneas */
  padding: 5px; /* Ajusta el espaciado en las celdas */
  vertical-align: middle;
  font-size: 0.70rem;
}

/* Tamaño de los iconos */
.btn .fa-pen-to-square,
.btn .fa-trash {
  font-size: 0.50rem;
}

/* Estilos de botones */
.btn-warning {
  color: #ffffff;
  background-color: #ffc107;
  border: none;
  white-space: nowrap;
  font-size: 0.10rem
}

.btn-danger {
  color: #ffffff;
  background-color: #dc3545;
  border: none;
  white-space: nowrap;
}

/* Fila de carga */
.cargando-message {
  text-align: right;
  color: #6c757d;
  font-size: 1.1rem;
}

</style>

