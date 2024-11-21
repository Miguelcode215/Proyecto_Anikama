<template>
  <div class="container">
    <h1>Subir Boleta para Escaneo</h1>

    <input type="file" @change="uploadInvoice" accept="image/*" class="upload-input" />

    <!-- Indicador de carga -->
    <div v-if="loading" class="loading">Cargando...</div>

    <!-- Datos de la Boleta -->
    <div v-if="invoiceData" class="invoice-data">
      <h3>Datos de la Boleta:</h3>
      <table>
        <thead>
          <tr><th>Campo</th><th>Valor</th></tr>
        </thead>
        <tbody>
          <tr><td>Nombre de la Tienda</td><td>{{ invoiceData.store_name }}</td></tr>
          <tr><td>RUC</td><td>{{ invoiceData.ruc }}</td></tr>
          <tr><td>Dirección</td><td>{{ invoiceData.address }}</td></tr>
          <tr><td>Teléfono</td><td>{{ invoiceData.phone }}</td></tr>
          <tr><td>DNI</td><td>{{ invoiceData.dni }}</td></tr>
          <tr><td>Total</td><td>{{ invoiceData.total }}</td></tr>
        </tbody>
      </table>

      <!-- Detalle de productos -->
      <h3>Detalle de Productos:</h3>
      <table>
        <thead>
          <tr><th>Código</th><th>Producto</th><th>Precio</th></tr>
        </thead>
        <tbody>
          <tr v-for="(product, index) in invoiceData.products" :key="index">
            <td>{{ product.code }}</td>
            <td>{{ product.name }}</td>
            <td>{{ product.price }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Mensaje de error -->
    <div v-if="errorMessage" class="error-message">
      <p>{{ errorMessage }}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      invoiceData: null,
      loading: false,
      errorMessage: null
    };
  },
  methods: {
    uploadInvoice(event) {
      const file = event.target.files[0];
      
      // Validación de tipo de archivo
      if (!file || !file.type.startsWith('image/')) {
        this.errorMessage = 'Por favor sube un archivo de imagen válido.';
        return;
      }

      const formData = new FormData();
      formData.append('image', file); // Cambiar 'file' a 'image' para que coincida con el backend

      this.loading = true;
      this.errorMessage = null;

      fetch('http://localhost:5000/extract', { // Asegurar que este endpoint coincide
        method: 'POST',
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        if (data.data) {
          this.invoiceData = data.data; // Asignar solo los datos relevantes
        } else {
          this.errorMessage = 'No se encontraron datos en la boleta.';
        }
        this.loading = false;
      })
      .catch(error => {
        console.error('Error en OCR:', error);
        this.errorMessage = 'Hubo un problema al procesar la boleta. Intenta nuevamente.';
        this.loading = false;
      });
    }
  }
}
</script>

<style scoped>
.container {
  margin: 20px;
  font-family: Arial, sans-serif;
}

.upload-input {
  margin-bottom: 20px;
  padding: 10px;
  font-size: 16px;
}

.loading {
  font-size: 18px;
  font-weight: bold;
  color: blue;
}

.invoice-data {
  margin-top: 20px;
}

table {
  width: 100%;
  margin: 20px 0;
  border-collapse: collapse;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

th, td {
  padding: 10px;
  text-align: left;
  border: 1px solid #ddd;
}

th {
  background-color: #f4f4f4;
}

.error-message {
  margin-top: 20px;
  color: red;
  font-weight: bold;
}
</style>