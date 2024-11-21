<template>
    <div class="chart-container">
      <Line
        id="my-chart-id"
        :options="chartOptions"
        :data="chartData"
      />
    </div>
</template>
  
  <script>
  import { Line } from 'vue-chartjs';
  import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js';
  import axios from '@/axios'; // Asegúrate de tener axios instalado
  
  ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);
  
  export default {
    name: 'LineChart',
    components: { Line },
    data() {
      return {
        chartData: {
          labels: [], // Aquí puedes agregar tus propias etiquetas
          datasets: [
            {
              label: 'Ventas Mensuales', // Título del dataset
              data: [], // Tus datos
              borderColor: 'rgba(75, 192, 192, 1)', // Color de la línea
              backgroundColor: 'rgba(75, 192, 192, 0.2)', // Color de fondo (relleno)
              borderWidth: 2, // Ancho de la línea
              pointBackgroundColor: 'rgba(255, 99, 132, 1)', // Color de los puntos
              pointBorderColor: '#fff', // Color del borde de los puntos
              pointHoverBackgroundColor: '#fff', // Color de fondo de los puntos cuando pasas el mouse
              pointHoverBorderColor: 'rgba(255, 99, 132, 1)' // Color del borde de los puntos al pasar el mouse
            }
          ]
        },
        chartOptions: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              display: true, // Mostrar leyenda
              position: 'top', // Posición de la leyenda (top, bottom, left, right)
              labels: {
                color: '#333', // Color de los textos de la leyenda
                font: {
                  size: 14 // Tamaño de la fuente de la leyenda
                }
              }
            },
            title: {
              display: true,
              text: 'Gráfico de Ventas',
              font: {
                size: 18
              },
              color: '#000'
            }
          },
          scales: {
            y: {
              beginAtZero: true, // Comenzar el eje Y en 0
              ticks: {
                color: '#333', // Color de los números del eje Y
                font: {
                  size: 12 // Tamaño de la fuente de los números del eje Y
                }
              }
            },
            x: {
              ticks: {
                color: '#333', // Color de los números del eje X
                font: {
                  size: 12 // Tamaño de la fuente de los números del eje X
                }
              }
            }
          }
        }
      }
    },
    mounted() {
      this.fetchSalesData(); // Llama a la función para obtener los datos al montar el componente
    },
    methods: {
      async fetchSalesData() {
        try {
          const response = await axios.get('Ventasdata'); // Cambia la URL según tu backend
          const { labels, data } = response.data; // Desestructura la respuesta
  
          // Asigna los datos a chartData
          this.chartData = {
            labels: labels,
            datasets: [
              {
                label: 'Ventas Mensuales',
                data: data,
                borderColor: 'rgba(75, 192, 192, 1)', // Color de la línea
                backgroundColor: 'rgba(75, 192, 192, 0.2)', // Color de fondo (relleno)
                borderWidth: 2,
                pointBackgroundColor: 'rgba(255, 99, 132, 1)', // Color de los puntos
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: 'rgba(255, 99, 132, 1)'
              }
            ]
          };
        } catch (error) {
          console.error('Error al obtener los datos de ventas:', error);
        }
      },
    },
  };
  </script>
  
 <!-- Aquí aplicas los estilos -->
<style scoped>
.chart-container {
  /* Ajustar tamaño del gráfico */
  width: 100%; /* O un valor específico como 600px */
  height: 300px; /* Ajusta según lo que necesites */

  /* Para centrar el gráfico dentro de su contenedor */
  display: flex;
  justify-content: Left;
  align-items: center;

  /* Puedes aplicar un borde o márgenes si lo deseas */
  margin: 0 auto;
}
</style>
  