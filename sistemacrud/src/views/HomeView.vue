<template>
  <!-- Contenedor de los gráficos -->
  <div class="chart-container">
    <div class="chart-item">
      <LineChart />
    </div>
    <div class="chart-item">
      <PieChart />
    </div>
  </div>
</template>

<script>
import LineChart from "@/components/Graficoventas.vue"; // Asegúrate de que la ruta es correcta
import PieChart from "@/components/Graficocircular.vue"; // Asegúrate de que la ruta es correcta

export default {
  components: {
    LineChart,
    PieChart,
  },
};
</script>


<style scoped>
.chart-container {
  display: flex;
  justify-content: space-between; /* Añadir espacio entre los gráficos */
  align-items: center;
  gap: 20px; /* Espacio entre los gráficos */
  padding: 20px;
  background-color: #f5f5f5;
  border-radius: 8px;
}

.chart-item {
  flex: 1; /* Para que ambos gráficos tomen el mismo ancho */
  height: 400px; /* Altura uniforme para ambos gráficos */
  padding: 10px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  display: flex;
  justify-content: center;
  align-items: center;
}

.chart-item canvas {
  width: 100% !important; /* Asegura que el gráfico use todo el espacio disponible */
  height: 100% !important; /* Asegura que el gráfico use todo el espacio disponible */
}
</style>
