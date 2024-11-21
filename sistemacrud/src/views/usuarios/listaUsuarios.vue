<template>
    <div class="row mt-10">
      <div class="col-md-20">
        <div class="card">
          <div class="card-header bg-dark text-white text-center">
            Lista de Usuarios
          </div>
          <div class="card-body">
            <table id="usuariosTable" class="table table-bordered">
              <thead>
                <tr>
                  <th>#</th>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Email</th>
                  <th>Fecha de Creación</th>
                  <th>Acciones</th>
                  <th>Estado</th>
                </tr>
              </thead>
              <tbody class="table-group-divider">
                <tr v-if="cargando">
                  <td colspan="7"><h4>Cargando...</h4></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { mostrarAlerta, enviarSolicitud, confirmarEliminacion } from '@/funcionesJS/funcionesAxios';
  import $ from 'jquery';
  import 'datatables.net';
  import 'datatables.net-bs5';
  import Swal from 'sweetalert2';
  
  export default {
    data() {
      return {
        usuarios: [],
        cargando: false
      };
    },
    mounted() {
      this.getUser();
    },
    methods: {
      initializeDataTable() {
        this.$nextTick(() => {
          if ($.fn.DataTable.isDataTable('#usuariosTable')) {
            $('#usuariosTable').DataTable().destroy();
          }
  
          $('#usuariosTable').DataTable({
            paging: true,
            searching: true,
            ordering: true,
            autoWidth: false,
            data: this.usuarios,
            columns: [
              { data: null, render: (data, type, row, meta) => meta.row + 1 },
              { data: 'id' },
              { data: 'name' },
              { data: 'email' },
              { data: 'created_at',
              render: date => new Date(date).toLocaleDateString() // Formato de fecha convertido

              },
              {
                data: null,
                render: (data, type, row) => `
                  <button class="btn btn-warning edit-btn" data-id="${row.id}" data-name="${row.name}">
                    <i class="fa-solid fa-key"></i>
                  </button>
                  &nbsp;
                  <button class="btn btn-danger delete-btn" data-id="${row.id}" data-name="${row.name}" data-email="${row.email}">
                    <i class="fa-solid fa-trash"></i>
                  </button>
                  &nbsp;
                  <button class="btn btn-info permisos" data-id="${row.id}" data-name="${row.name}" data-email="${row.email}">
                    <i class="fa-solid fa-user-lock"></i>
                  </button>
                `
              },
              {
              data: null,
              render: (data, type, row) => {
                const checked = row.Estado === 'activo' ? 'checked' : '';
                return `
                  <div class="form-check form-switch">
                    <input class="form-check-input switch-estado" type="checkbox" ${checked} data-id="${row.id}">
                    <label class="form-check-label">${row.Estado === 'activo' ? 'Activo' : 'Inactivo'}</label>
                  </div>
                `;
              },
            },
            ]
          });
  
          // Al hacer clic en editar, redirigimos a la vista de editar contraseña
          $('#usuariosTable').on('click', '.edit-btn', (event) => {
                    const button = $(event.currentTarget);
                    this.userToEdit = {
                        id: button.data('id'),
                        name: button.data('name')
                    };
                    this.$router.push({ name: 'editar-contraseña', params: this.userToEdit });
                  });
          $('#usuariosTable').on('click', '.permisos', (event) => {
                    const button = $(event.currentTarget);
                    this.userToEdit = {
                        id: button.data('id'),
                        name: button.data('name'),
                        email: button.data('email')
                    };
                    this.$router.push({ name: 'lista-permisos', params: this.userToEdit });
                  });
                // Al hacer clic en eliminar, redirigimos a la vista de confirmación
          $('#usuariosTable').on('click', '.delete-btn', (event) => {
                    const button = $(event.currentTarget);
                    this.userToDelete = {
                        id: button.data('id'),
                        name: button.data('name'),
                        email: encodeURIComponent(button.data('email')) // Codifica el email
                    };
                    this.$router.push({ name: 'usuarios.confirmarEliminar', params: this.userToDelete });
                });
            });
          $('#usuariosTable').on('change', '.switch-estado', (event) => {
              const switchElement = event.currentTarget;
              const id = $(switchElement).data('id');
              const estadoActual = $(switchElement).prop('checked') ? 'true' : 'false';
          
          this.cambiarEstado(id, estadoActual, switchElement);
        });
      },
      getUser() {
        this.cargando = true;
        enviarSolicitud('GET', 'user', {}, '', (data) => {
          this.usuarios = data;
          this.cargando = false;
          this.initializeDataTable();
        });
      },
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      cambiarEstado(id, estadoActual, switchElement) {
          const estadoBooleano = estadoActual === 'true';
          // obtiene el estado anteriro
          const estadoAnterior = !estadoBooleano;

          enviarSolicitud('PUT', `estadoUser/${id}`, { Estado: estadoBooleano }, '', (response) => {
              // Actualizar el estado directamente en el switch
              $(switchElement).prop('checked', estadoBooleano);

              // Buscar la fila en DataTable y actualizar solo el texto del estado sin volver a dibujar toda la tabla
              const table = $('#usuariosTable').DataTable();
              const rowIndex = table.rows().indexes().filter((idx) => table.row(idx).data().id == id);
              const rowData = table.row(rowIndex).data();
              rowData.Estado = estadoBooleano ? 'activo' : 'inactivo';
              
              // Actualizar solo el contenido visible sin volver a dibujar toda la tabla
              table.row(rowIndex).data(rowData).invalidate('data');

          }).catch(error => {
              console.error('Error al cambiar el estado:', error.response.data);
              Swal.fire('Error', 'Hubo un error al cambiar el estado.', 'error');

              // Revertir el cambio en el switch al estado anterior
              $(switchElement).prop('checked', estadoAnterior);

          });
       }

    }
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
  font-size: 0.10rem !important;
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

  