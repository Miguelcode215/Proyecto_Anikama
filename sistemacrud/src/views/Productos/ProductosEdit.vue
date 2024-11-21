<template>
  <div class="row mt-3">
    <div class="col-md-6 offset-md-3">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          Editar Producto
        </div>
        <div class="card-body">
          <form @submit.prevent="actualizar">
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-cart-plus"></i></span>
              <input type="text" v-model="NombrePro" id="NombrePro" placeholder="Nombre del Producto" class="form-control" required>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-comment"></i></span>
              <input type="text" v-model="Descripcion" id="Descripcion" placeholder="Descripción del Producto" class="form-control" required>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-dollar-sign"></i></span>
              <input type="number" v-model="Precio" id="Precio" placeholder="Precio del Producto" class="form-control" step="0.01" required>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-cubes"></i></span>
              <input type="number" v-model="Stock" id="Stock" placeholder="Stock de los Productos" class="form-control" required>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-calendar"></i></span>
              <input type="date" v-model="FechaVencimiento" id="FechaVencimiento" class="form-control">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-check"></i></span>
              <select v-model="idCategoria" id="idCategoria" class="form-control" required>
                <option value="" disabled>Seleccione la categoría</option>
                <option v-for="cat in categorias" :key="cat.idCategoria" :value="cat.idCategoria">
                  {{ cat.NombreCat }}
                </option>
              </select>
            </div>
            <div>
              <button class="btn btn-success" :disabled="cargando">
                <i class="fa-solid fa-floppy-disk"></i> Guardar
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mostrarAlerta, enviarSolicitud } from '@/funcionesJS/funcionesAxios';
import { useRoute } from 'vue-router';
import axios from '@/axios';

export default {
  data() {
    return {
      NombrePro: '',
      Descripcion: '',
      Precio: '',
      Stock: '',
      FechaVencimiento: '',
      idCategoria: '',
      categorias: [],
      productoUrl: '',
      categoriasUrl: 'categorias',
      cargando: false
    };
  },
  async mounted() {
    const route = useRoute();
    this.productoUrl = `producto/${route.params.idProducto}`;

    await this.cargarDatos();
  },
  methods: {
    async cargarDatos() {
      try {
        const [categoriasRes, productoRes] = await Promise.all([
          axios.get(this.categoriasUrl),
          axios.get(this.productoUrl)
        ]);

        this.categorias = categoriasRes.data;
        const producto = productoRes.data;
        this.NombrePro = producto.NombrePro;
        this.Descripcion = producto.Descripcion;
        this.Precio = producto.Precio;
        this.Stock = producto.Stock;
        this.FechaVencimiento = producto.FechaVencimiento;
        this.idCategoria = producto.idCategoria;
      } catch (error) {
        console.error('Error al cargar los datos:', error);
        mostrarAlerta('Error al cargar los datos', 'error');
      }
    },
    async actualizar() {
      if (
        this.NombrePro.trim() === '' || 
        this.Descripcion.trim() === '' || 
        this.Precio <= 0 || 
        this.Stock <= 0 || 
        !this.idCategoria
      ) {
        mostrarAlerta('Por favor, complete todos los campos obligatorios', 'warning');
        return;
      }

      const parametros = {
        NombrePro: this.NombrePro.trim(),
        Descripcion: this.Descripcion.trim(),
        Precio: parseFloat(this.Precio),
        Stock: parseInt(this.Stock, 10),
        FechaVencimiento: this.FechaVencimiento,
        idCategoria: this.idCategoria
      };

      this.cargando = true;
      try {
        await enviarSolicitud('PUT', this.productoUrl, parametros, 'Producto actualizado correctamente');
        this.$router.push({ name: 'Productos' });
      } catch (error) {
        console.error('Error en la solicitud:', error);
        mostrarAlerta('Error al actualizar el producto', 'error');
      } finally {
        this.cargando = false;
      }
    }
  }
};
</script>
