<template>
  <div class="row mt-3">
    <div class="col-md-6 offset-md-3">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          Nueva Venta
        </div>
        <div class="card-body">
          <form id="Formulario" @submit.prevent="nuevaVenta">
            <div class="input-group mb-2">
              <span class="input-group-text"><i class="fa-solid fa-calendar"></i></span>
              <input type="date" v-model="venta.FechaEmicion" id="FechaEmicion" class="form-control" placeholder="Fecha de Emisión">
              &nbsp;&nbsp;&nbsp;&nbsp;
              <span class="input-group-text"><i class="fa-solid fa-info-circle"></i></span>
              <input type="text" v-model="venta.Estado" id="Estado" class="form-control" placeholder="Estado de la venta">
            </div>
            <br>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-box"></i></span>
              <select v-model="Producto" id="Producto" class="form-control">
                <option value="" disabled>Seleccione productos</option>
                <option v-for="pro in productos" :key="pro.idProducto" 
                        :value="pro.idProducto" 
                        :disabled="pro.Stock <= 0" 
                        :style="{ opacity: pro.Stock <= 0 ? 0.5 : 1 }">
                  {{ pro.NombrePro }} - Stock: {{ pro.Stock }}
                </option>
              </select>
              &nbsp;&nbsp;&nbsp;
              <span class="input-group-text"><i class="fa-solid fa-cubes"></i></span>
              <input type="number" v-model="Unidades" id="Unidades" class="form-control" placeholder="Unidades" min="1">
              &nbsp;&nbsp;&nbsp;
              <span class="input-group-text"><i class="fa-solid fa-dollar-sign"></i></span>
              <input type="number" v-model="Precio" id="Precio" class="form-control" placeholder="Precio unitario" step="0.01" readonly>
              <button type="button" @click="agregarProducto" class="btn btn-success"><i class="fa-solid fa-plus"></i> Agregar</button>
            </div>
            <br>
            <table id="detalles" class="table table-striped table-bordered table-condensed table-hover">
              <thead>
                <tr>
                  <th>Productos</th>
                  <th>Unidades</th>
                  <th>Sub Total</th>
                  <th>Acción</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(detalle, index) in detalles" :key="index">
                  <td><input type="hidden" :name="'productos[]'" :value="detalle.productoId">{{ detalle.productoNombre }}</td>
                  <td><input type="hidden" :name="'Unidades[]'" :value="detalle.unidades">{{ detalle.unidades }}</td>
                  <td><input type="hidden" :name="'subtotal'" :value="detalle.subtotal">{{ detalle.subtotal.toFixed(2) }}</td>
                  <td><button type="button" @click="removeDetalle(index)" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button></td>
                </tr>
              </tbody>
            </table>
            <div>
              <button type="submit" class="btn btn-success"><i class="fa-solid fa-floppy-disk"></i> Pagar</button>
              &nbsp;&nbsp;&nbsp;
              <button type="button" @click="cancelar" class="btn btn-danger"><i class="fa-solid fa-ban"></i> Cancelar</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mostrarAlerta, enviarSolicitud } from '@/funcionesJS/funcionesAxios';

export default {
  data() {
    return {
      venta: {
        FechaEmicion: new Date().toISOString().substr(0, 10),
        Estado: '',
      },
      productos: [],
      Producto: '',
      Unidades: '',
      Precio: '',
      detalles: [],
    };
  },
  mounted() {
    this.obtenerProductos();
  },
  methods: {
    obtenerProductos() {
      enviarSolicitud('GET', 'producto', {}, '', (data) => {
        this.productos = data.filter(producto => producto.Estado == 'disponible');
      });
    },
    agregarProducto() {
      if (this.Producto === '' || this.Unidades <= 0) {
        mostrarAlerta('Seleccione un producto y coloque una cantidad válida', 'warning', 'Producto');
        return;
      }

      const selectedProducto = this.productos.find(producto => producto.idProducto === this.Producto);
      
      if (selectedProducto.Stock < this.Unidades) {
        mostrarAlerta(`No hay suficiente stock para el producto ${selectedProducto.NombrePro}`, 'error', 'Stock');
        return;
      }

      if (selectedProducto) {
        const detalle = {
          productoId: this.Producto,
          productoNombre: selectedProducto.NombrePro,
          unidades: this.Unidades,
          precioUnitario: selectedProducto.Precio,
          subtotal: this.Unidades * selectedProducto.Precio,
        };
        this.detalles.push(detalle);
        this.resDetalleForm();
      }
    },
    removeDetalle(index) {
      this.detalles.splice(index, 1);
    },
    nuevaVenta() {
      if (this.venta.FechaEmicion === '' || this.venta.Estado.trim() === '' || this.detalles.length === 0) {
        mostrarAlerta('Complete todos los campos y agregue al menos un producto', 'warning', 'Formulario');
        return;
      }

      const parametros = {
        FechaEmicion: this.venta.FechaEmicion,
        Estado: this.venta.Estado,
        productos: this.detalles.map(detalle => detalle.productoId),
        cantidades: this.detalles.map(detalle => detalle.unidades),
        subtotales: this.detalles.map(detalle => detalle.subtotal),
      };

      enviarSolicitud('POST', 'ventas', parametros, 'La venta se registró correctamente', () => {
        this.resetForm();
      });
    },
    cancelar() {
      this.resetForm();
    },
    resetForm() {
      this.venta = { FechaEmicion: '', Estado: '' };
      this.Producto = '';
      this.Unidades = '';
      this.Precio = '';
      this.detalles = [];
    },
    resDetalleForm() {
      this.Producto = '';
      this.Unidades = '';
      this.Precio = '';
    },
  },
  watch: {
    Producto(newVal) {
      const selectedProducto = this.productos.find(producto => producto.idProducto === newVal);
      this.Precio = selectedProducto ? selectedProducto.Precio : '';
    },
  },
};
</script>
