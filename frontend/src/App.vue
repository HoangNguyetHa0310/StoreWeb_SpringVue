<template>
  <main>
    <h1>Store Web</h1>
    <ProductList />
  </main>
</template>

<script setup>
import ProductList from './components/ProductList.vue'
</script>

<style>
body { font-family: system-ui, sans-serif; }
main { max-width: 960px; margin: 20px auto; padding: 10px; }
</style>
