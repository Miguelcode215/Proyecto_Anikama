<template>
  <div class="row mt-3">
    <div class="col-md-6 offset-md-3">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          Registrar nuevo Producto
        </div>
        <div class="card-body">
          <form @submit.prevent="guardar">
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-cart-plus"></i></span>
              <input type="text" v-model="NombrePro" id="NombrePro" placeholder="Nombre del Producto" class="form-control">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-comment"></i></span>
              <input type="text" v-model="Descripcion" id="Descripcion" placeholder="Descripción del Producto" class="form-control">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-dollar-sign"></i></span>
              <input type="number" v-model="Precio" id="Precio" placeholder="Precio del Producto" class="form-control" step="0.01">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-cubes"></i></span>
              <input type="number" v-model="Stock" id="Stock" placeholder="Stock de los Productos" class="form-control">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-calendar"></i></span>
              <input type="date" v-model="FechaRegistro" id="FechaVencimiento" class="form-control">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-check"></i></span>
              <select v-model="idCategoria" id="idCategoria" class="form-control">
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
import axios from '@/axios'; // Importa axios desde el archivo configurado

export default {
  data() {
    return {
      NombrePro: '',
      Descripcion: '',
      Precio: '',
      Stock: '',
      FechaRegistro: '',
      idCategoria: '',
      categorias: [],
      url: 'categorias',
      cargando: false
    };
  },
  mounted() {
    this.obtenerCategorias();
  },
  methods: {
    async obtenerCategorias() {
      try {
        const res = await axios.get(this.url);
        // Filtrar las categorías activas
        this.categorias = res.data.filter(categoria => categoria.estado === 'activo');
      } catch (error) {
        console.error('Error al cargar las categorías:', error);
      }
    },
    async guardar() {
      if (this.NombrePro.trim() === '' || 
          this.Descripcion.trim() === '' || 
          this.Precio <= 0 || 
          this.Stock <= 0 || 
          !this.idCategoria) {
        mostrarAlerta('Hay un campo vacío', 'warning', 'Formulario');
        return;
      }

      const parametros = {
        NombrePro: this.NombrePro.trim(),
        Descripcion: this.Descripcion.trim(),
        Precio: parseFloat(this.Precio),
        Stock: parseInt(this.Stock, 10),
        FechaRegistro: this.FechaRegistro,
        idCategoria: this.idCategoria
      };

      this.cargando = true;

      try {
        await enviarSolicitud('POST', 'producto', parametros , 'El producto se guardó correctamente');
        this.$router.push({ name: 'Productos' });
      } catch (error) {
        console.error('Error al guardar el producto:', error);
        mostrarAlerta('Error al guardar el producto', 'danger', 'Formulario');
      } finally {
        this.cargando = false;
      }
    }
  }
};
</script>
