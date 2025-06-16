<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-3xl font-bold">Products</h1>

      <!-- Sort Options -->
      <select
          v-model="sortOption"
          @change="handleSortChange"
          class="border rounded px-3 py-2"
      >
        <option value="createdAt,desc">Newest First</option>
        <option value="createdAt,asc">Oldest First</option>
        <option value="price,asc">Price: Low to High</option>
        <option value="price,desc">Price: High to Low</option>
        <option value="name,asc">Name: A to Z</option>
      </select>
    </div>

    <!-- Loading -->
    <div v-if="productStore.isLoading" class="text-center py-8">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
      <p class="mt-2">Loading products...</p>
    </div>

    <!-- Products Grid -->
    <div v-else-if="productStore.hasProducts" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
      <ProductCard
          v-for="product in productStore.products"
          :key="product.id"
          :product="product"
      />
    </div>

    <!-- No Products -->
    <div v-else class="text-center py-8">
      <p class="text-gray-500 text-lg">No products found.</p>
    </div>

    <!-- Pagination -->
    <div v-if="productStore.pagination.totalPages > 1" class="mt-8 flex justify-center">
      <nav class="flex space-x-2">
        <button
            v-for="page in visiblePages"
            :key="page"
            @click="changePage(page - 1)"
            :class="[ 'px-3 py-2 border rounded', page - 1 === productStore.pagination.currentPage
            ? 'bg-blue-600 text-white border-blue-600' : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-50' ]"
        >
          {{ page }}
        </button>
      </nav>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useProductStore } from '@/stores/productStore'
import ProductCard from '@/components/product/ProductCard.vue'

const productStore = useProductStore()
const sortOption = ref('createdAt,desc')

const visiblePages = computed(() => {
  const current = productStore.pagination.currentPage + 1
  const total = productStore.pagination.totalPages
  const delta = 2

  let start = Math.max(1, current - delta)
  let end = Math.min(total, current + delta)

  const pages = []
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }

  return pages
})

const handleSortChange = () => {
  const [sortBy, sortDir] = sortOption.value.split(',')
  productStore.setFilters({ sortBy, sortDir })
  productStore.fetchProducts(0)
}

const changePage = (page) => {
  productStore.fetchProducts(page)
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => {
  productStore.fetchProducts()
})
</script>
