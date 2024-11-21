<template>
  <div class="row mt-3">
    <div class="col-md-6 offset-md-3">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          Editar Categoría
        </div>
        <div class="card-body">
          <br>
          <form @submit.prevent="actualizar">
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-solid fa-plus" style="color: #63E6BE;"></i></span>
              <input type="text" v-model="NombreCat" id="NombreCat" placeholder="Nombre de la Categoría" class="form-control">
            </div>
            <div>
              <button class="btn btn-success"><i class="fa-solid fa-floppy-disk"> Guardar</i></button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mostrarAlerta, enviarSolicitud } from '@/funcionesJS/funcionesAxios';
import { useRoute, useRouter } from 'vue-router';
export default {
  data() {
    return {
      idCat: 0,
      NombreCat: '',
      url: 'categorias',
      cargando: false,
    };
  },
  mounted() {
    const route = useRoute();
    this.idCat = route.params.idCategoria;
    this.url += '/' + this.idCat;
    this.obtenerCategoria();
  },
  methods: {
    obtenerCategoria() {
  this.cargando = true;
  enviarSolicitud('GET', this.url, {}, '', (data) => {
    if (data && data.NombreCat) {
      this.NombreCat = data.NombreCat;
    } else {
      mostrarAlerta('No se pudo obtener la categoría', 'error');
    }
    this.cargando = false;
  });
},
    actualizar() {
    event.preventDefault();  // Asegúrate de evitar el comportamiento predeterminado del formulario
    if (this.NombreCat.trim() === '') {
        mostrarAlerta('Ingrese una categoría', 'warning', 'NombreCat');
    } else {
        const parametros = { NombreCat: this.NombreCat.trim() };
        console.log('URL que se enviará:', this.url);  // Depuración
        enviarSolicitud('PUT', this.url, parametros, 'La categoría se actualizó correctamente', () => {
            this.$router.push({ name: 'Categorias' });
        });
    }
},
  },
};
</script>
