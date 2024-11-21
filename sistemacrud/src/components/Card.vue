<template>
  <div class="card shadow-sm">
    <i :class="icon" class="icon"></i> <!-- Agrega el icono aquí -->
    <div class="card-body">
      <h5 class="card-title">{{ title }}</h5>
      <p class="card-text display-4">{{ value }}</p>
      <p class="card-text text-muted">{{ description }}</p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    },
    value: {
      type: [String, Number],
      required: true,
    },
    description: {
      type: String,
      default: '',
    },
    icon: {
      type: String, // Nueva propiedad para el icono
      required: true,
    },
  },
};
</script>

<style scoped>
.card {
  border-radius: 8px;
  padding: 1rem;
  text-align: center;
  background-color: #f8f9fa;
  position: relative;
}

.icon {
  font-size: 36px;
  position: absolute;
  top: 10px;
  left: 10px;
  opacity: 0.7;
}

.card-body {
  padding: 1.5rem;
}

.card-text {
  font-weight: bold;
}
</style>
