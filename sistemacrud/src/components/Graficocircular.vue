<template>
    <Pie
      id="my-chart-id"
      :options="chartOptions"
      :data="chartData"
    />
  </template>
  
  <script>
  import { Pie } from 'vue-chartjs'
  import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js'
  import { enviarSolicitud, mostrarAlerta } from '@/funcionesJS/funcionesAxios';
  
  ChartJS.register(ArcElement, Tooltip, Legend)
  
  export default {
    name: 'PieChart',
    components: { Pie },
    data() {
      return {
        chartData: {
          labels: [], // Inicialmente vacío
          datasets: [{
            label: 'Productos por Categorias',
            data: [], // Inicialmente vacío
            backgroundColor: [] // Vacío para llenarlo dinámicamente
          }]
        },
        chartOptions: {
          responsive: true,
          maintainAspectRatio: false,
        }
      }
    },
    mounted() {
      this.getProductosData()
    },
    methods: {
      async getProductosData() {
        try {
          const response = await enviarSolicitud('GET', 'graficoProductos');
          const productos = response.data; // Corregir para acceder al array 'data'
    
          if (!Array.isArray(productos)) {
            throw new Error('Estructura de datos inesperada en la respuesta');
          }
    
          // Extraer las categorías y porcentajes
          const categorias = productos.map(item => item.categoria);
          const porcentajes = productos.map(item => {
            // Remover el símbolo % y convertir a número
            return parseFloat(item.porcentaje.replace('%', ''));
          });
  
          // Generar colores dinámicos
          const backgroundColors = categorias.map(() => this.getRandomColor());
    
          // Asigna los datos a chartData
          this.chartData = {
            labels: categorias,
            datasets: [
              {
                label: 'Productos por Categorias',
                data: porcentajes,
                backgroundColor: backgroundColors, // Colores generados dinámicamente
                borderColor: '#ffffff', // Color del borde
                borderWidth: 0
              }
            ]
          };
        } catch (error) {
          console.error('Error al obtener categorías y datos:', error.message);
          mostrarAlerta(error.message, 'error', '');
        }
      },
  
      // Método para generar colores aleatorios
      getRandomColor() {
        const letters = '0123456789ABCDEF';
        let color = '#';
        for (let i = 0; i < 6; i++) {
          color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
      }
    }
  }
  </script>
  