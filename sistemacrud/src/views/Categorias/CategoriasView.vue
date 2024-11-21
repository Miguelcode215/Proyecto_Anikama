<template>
  <div class="row mt-3 justify-content-center">
    <div class="col-md-10">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          <h2>Categorías</h2>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table id="categoriasTable" class="table table-bordered">
              <thead>
                <tr>
                  <th>#</th>
                  <th>ID</th>
                  <th>Categoría</th>
                  <th>Acciones</th>
                  <th>Estado</th>
                </tr>
              </thead>
              <tbody>
                <tr v-if="cargando">
                  <td colspan="5">
                    <h4>Cargando...</h4>
                  </td>
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
import { enviarSolicitud, ErroresRespuesta} from '@/funcionesJS/funcionesAxios';
import Swal from 'sweetalert2';
import $ from 'jquery';
import 'datatables.net';
import 'datatables.net-bs5';

export default {
  data() {
    return {
      categorias: [],
      cargando: false,
    };
  },
  mounted() {
    this.getCategorias();
  },
  methods: {
    // Verificar permisos antes de realizar acciones
    tienePermiso(permiso) {
      const permisos = JSON.parse(localStorage.getItem('permissions') || '[]');
      return permisos.includes(permiso);
    },

    initializeDataTable() {
      this.$nextTick(() => {
        if ($.fn.DataTable.isDataTable('#categoriasTable')) {
          $('#categoriasTable').DataTable().destroy();
        }

        $('#categoriasTable').DataTable({
          paging: true,
          searching: true,
          ordering: true,
          autoWidth: false,
          data: this.categorias,
          columns: [
            { data: null, render: (data, type, row, meta) => meta.row + 1 }, // Número de fila
            { data: 'idCategoria' }, // ID de la categoría
            { data: 'NombreCat' }, // Nombre de la categoría
            {
              data: null,
              render: (data, type, row) => {
                return `
                  <button class="btn btn-warning edit-btn" data-id="${row.idCategoria}">
                    <i class="fa-solid fa-pen-to-square"></i>
                  </button>
                  &nbsp;
                  <button class="btn btn-danger delete-btn" data-id="${row.idCategoria}" data-name="${row.NombreCat}">
                    <i class="fa-solid fa-trash"></i>
                  </button>
                `;
              },
            },
            {
              data: null,
              render: (data, type, row) => {
                const checked = row.estado === 'activo' ? 'checked' : '';
                return `
                  <div class="form-check form-switch">
                    <input class="form-check-input switch-estado" type="checkbox" ${checked} data-id="${row.idCategoria}">
                    <label class="form-check-label">${row.estado === 'activo' ? 'Activo' : 'Inactivo'}</label>
                  </div>
                `;
              },
            },
          ],
          createdRow: (row, data) => {
            if (data.estado === 'inactivo') {
              $(row).addClass('table-inactive'); // Aplica la clase si la categoría está inactiva
            }
          },
        });

        // Manejador de eventos para editar categoría
        $('#categoriasTable').off('click').on('click', '.edit-btn', (event) => {
          const id = $(event.currentTarget).data('id');
          if (this.tienePermiso('Editar Categorias')) {
            this.$router.push({ path: `editarC/${id}` });
          } else {
            Swal.fire({
              icon: 'error',
              title: 'Acceso Denegado',
              text: 'No tienes permiso para editar categorías.',
            });
          }
        });

        // Manejador de eventos para cambiar estado
        $('#categoriasTable').on('change', '.switch-estado', (event) => {
          const switchElement = event.currentTarget;
          const idCategoria = $(switchElement).data('id');
          const estadoActual = $(switchElement).prop('checked') ? 'true' : 'false';
          
          this.cambiarEstado(idCategoria, estadoActual, switchElement);
        });

        // Manejador de eventos para eliminar categoría
        $('#categoriasTable').on('click', '.delete-btn', (event) => {
          const id = $(event.currentTarget).data('id');
          const nombre = $(event.currentTarget).data('name');
          if (this.tienePermiso('Eliminar Categorias')) {
            Swal.fire({
              title: 'Eliminar Categoría',
              text: `¿Realmente desea eliminar a ${nombre}?`,
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Sí, eliminar',
              cancelButtonText: 'Cancelar',
            }).then((result) => {
              if (result.isConfirmed) {
                this.eliminarCategoria(id);
              }
            });
          } else {
            Swal.fire({
              icon: 'error',
              title: 'Acceso Denegado',
              text: 'No tienes permiso para eliminar categorías.',
            });
          }
        });
      });
    },

    getCategorias() {
      this.cargando = true;
      enviarSolicitud('GET', 'categorias', {}, '', (data) => {
        this.categorias = data;
        this.cargando = false;
        this.initializeDataTable();
      });
    },

    cambiarEstado(idCategoria, estadoActual) {
      // Convertir el estado a booleano
      const estadoBooleano = estadoActual === 'true';
      
      // Guardar el estado anterior por si hay que revertirlo en caso de error
      const estadoAnterior = !estadoBooleano;

      enviarSolicitud('PUT', `estadoCat/${idCategoria}`, { estado: estadoBooleano }, '', (response) => {
        const table = $('#categoriasTable').DataTable();
        const rowIndex = table.rows().indexes().filter((idx) => table.row(idx).data().idCategoria == idCategoria);
        
        // Actualizar el estado en la tabla
        const rowData = table.row(rowIndex).data();
        rowData.estado = estadoBooleano ? 'activo' : 'inactivo';
        table.row(rowIndex).data(rowData).draw();
      }).catch(error => {
        console.error('Error al cambiar el estado:', error.response.data);
        Swal.fire('Error', 'Hubo un error al cambiar el estado.', 'error');
        
        // Revertir el cambio en el switch al estado anterior
        const table = $('#categoriasTable').DataTable();
        const rowIndex = table.rows().indexes().filter((idx) => table.row(idx).data().idCategoria == idCategoria);
        const switchElement = $(table.cell(rowIndex, 4).node()).find('.switch-estado');
        switchElement.prop('checked', estadoAnterior);
      });
    },

    eliminarCategoria(id) {
      enviarSolicitud('DELETE', `categorias/${id}`, {}, '')
        .then(() => {
          // Si la solicitud fue exitosa, eliminamos la categoría de la tabla
          const table = $('#categoriasTable').DataTable();
          this.categorias = this.categorias.filter((cat) => cat.idCategoria !== id);
          table.clear().rows.add(this.categorias).draw();
        })
        .catch((error) => {
          // Manejo de errores
          ErroresRespuesta(error)
        });
    }
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
  font-size: 0.80rem;
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


