<template>
  <div class="row mt-3">
    <div class="col-md-6 offset-md-3">
      <div class="card">
        <div class="card-header bg-dark text-white text-center">
          Registrar nueva categoría
        </div>
        <div class="card-body">
          <br>
          <form v-on:submit="guardar">
            <div class="input-group mb-3">
              <span class="input-group-text"><i class="fa-sharp fa-solid fa-pen"></i></span>
              <input type="text" v-model="NombreCat" id="NombreCat" placeholder="Ingrese el nombre de la categoría" required maxlength="50" class="form-control">
            </div>
            <div>
              <button class="btn btn-success"><i class="fa-solid fa-floppy-disk"></i> Guardar</button>
            </div>
            <br>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mostrarAlerta, enviarSolicitud } from '@/funcionesJS/funcionesAxios'; // Asegúrate de que la ruta sea correcta

export default {
  data() {
    return {
      NombreCat: '',
      url: 'categorias',
      cargando: false
    };
  },
  methods: {
    guardar(event) {
      event.preventDefault();
      if (this.NombreCat.trim() === '') {
        mostrarAlerta('Ingrese un nombre para la categoría', 'warning', 'NombreCat');
      } else {
        const parametros = { NombreCat: this.NombreCat.trim() };
        enviarSolicitud('POST', this.url, parametros, 'Categoría registrada', () => {
          this.$router.push({ name: 'Categorias' });
        });
      }
      this.cargando = true;
    }
  }
};
</script>
