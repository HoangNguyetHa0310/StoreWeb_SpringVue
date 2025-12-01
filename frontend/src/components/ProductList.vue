<template>
  <div>
    <h2>Products</h2>
    <ul>
      <li v-for="product in products" :key="product.id">
        <strong>{{ product.name }}</strong> - {{ product.price }}$<br>
        <small>{{ product.description }}</small>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '../services/api'

const products = ref([])

onMounted(async () => {
  products.value = await api.getProducts()
})
</script>

<style scoped>
li { margin-bottom: 10px; }
</style>
