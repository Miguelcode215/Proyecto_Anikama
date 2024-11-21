<template>
    <div class="row mt-3">
        <div class="col-md-30">
            <div class="card">
                <div class="card-header bg-dark text-white text-center">
                    Lista de Productos
                </div>
                <div class="card-body">
                    <table id="productosTable" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Producto</th>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Fecha </th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <tr v-if="cargando">
                                <td colspan="9"><h4>Cargando...</h4></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { ErroresRespuesta, enviarSolicitud, confirmarEliminacion } from '@/funcionesJS/funcionesAxios';
import $ from 'jquery';
import 'datatables.net';
import 'datatables.net-bs5';
import Swal from 'sweetalert2';

export default {
    data() {
        return {
            productos: [],
            cargando: false
        };
    },
    mounted() {
        this.getproductos();
    },
    methods: {
        tienePermiso(permiso) {
            const permisos = JSON.parse(localStorage.getItem('permissions') || '[]');
            return permisos.includes(permiso);
        },
        initializeDataTable() {
            this.$nextTick(() => {
                if ($.fn.DataTable.isDataTable('#productosTable')) {
                    $('#productosTable').DataTable().destroy();
                }

                $('#productosTable').DataTable({
                    paging: true,
                    searching: true,
                    ordering: true,
                    autoWidth: false,
                    data: this.productos,
                    columns: [
                        { data: 'idProducto' },
                        { data: 'NombrePro' },
                        { data: 'Descripcion' },
                        { data: 'Precio' },
                        { data: 'Stock' },
                        { data: 'FechaRegistro' },
                        {
                            data: null,
                            render: (data, type, row) => {
                                const editButton = `<button class="btn btn-warning edit-btn" data-id="${row.idProducto}">
                                                        <i class="icono fa-solid fa-pen-to-square"></i>
                                                    </button>`;
                                const deleteButton = `<button class="btn btn-danger delete-btn" data-id="${row.idProducto}" data-name="${row.NombrePro}">
                                                        <i id ='icono' class="fa-solid fa-trash"></i>
                                                    </button>`;
                                return `${editButton} ${deleteButton}`;
                            }
                        }
                    ],
                    createdRow: (row, data) => {
                        if (data.Estado === 'disponible') {
                            $(row).addClass('table-light');
                        } else if (data.Estado === 'agotado') {
                            $(row).addClass('table-danger');
                        }
                    }
                });

                $('#productosTable').on('click', '.edit-btn', (event) => {
                    const id = $(event.currentTarget).data('id');
                    if (this.tienePermiso('Editar Productos')){
                        this.$router.push({ path: `editarP/${id}` })
                    } else{
                        Swal.fire({
                            icon: 'error',
                            title: 'Acceso Denegado',
                            text: 'No tienes permiso para editar este producto.',
                        });
                    }
                });

                $('#productosTable').on('click', '.delete-btn', (event) => {
                    const id = $(event.currentTarget).data('id');
                    const nombre = $(event.currentTarget).data('name');
                    if (this.tienePermiso('Eliminar Productos')){
                        Swal.fire({
                            title: 'Eliminar Producto',
                            text: `¿Realmente desea eliminar a ${nombre}?`,
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Sí, eliminar',
                            cancelButtonText: 'Cancelar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                this.eliminar(id, nombre);
                            }
                        });
                    } else{
                        Swal.fire({
                            icon: 'error',
                            title: 'Acceso Denegado',
                            text: 'No tienes permiso para eliminar este producto.',
                        });
                    }
                });
            });
        },

        getproductos() {
            this.cargando = true;
            enviarSolicitud('GET', 'producto', {}, '', (data) => {
                // Filtrar productos para que solo se muestren los que no están inactivos
                this.productos = data
                this.cargando = false;
                this.initializeDataTable();
            });
        },
        eliminar(id, nombre) {
            enviarSolicitud('DELETE', `producto/${id}`, {}, '')
            .then(() => {
          // Si la solicitud fue exitosa, eliminamos la categoría de la tabla
            this.productos = this.productos.filter(prod => prod.idProducto !== id);
            const table = $('#productosTable').DataTable();
            table.clear().rows.add(this.productos).draw();
        })
        .catch((error) => {
          // Manejo de errores
          ErroresRespuesta(error)
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
  font-size: 0.80rem;
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
.btn .icono {
    font-size: 0.20rem !important; /* Ajusta el tamaño y usa !important para forzar el estilo */
}
</style>

