<template>
  <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
    <!-- Product Image -->
    <div class="relative pb-2/3 overflow-hidden">
      <img
          :src="product.primaryImageUrl || '/placeholder-image.jpg'"
          :alt="product.name"
          class="absolute inset-0 w-full h-full object-cover hover:scale-105 transition-transform duration-300"
      />
      <div v-if="product.isFeatured" class="absolute top-2 left-2 bg-red-500 text-white px-2 py-1 text-xs rounded">
        Featured
      </div>
      <div v-if="product.salePrice" class="absolute top-2 right-2 bg-green-500 text-white px-2 py-1 text-xs rounded">
        Sale
      </div>
    </div>

    <!-- Product Info -->
    <div class="p-4">
      <h3 class="font-semibold text-lg mb-2 line-clamp-2">{{ product.name }}</h3>
      <p class="text-gray-600 text-sm mb-3 line-clamp-2">{{ product.shortDescription }}</p>

      <!-- Price -->
      <div class="flex items-center justify-between mb-3">
        <div class="flex items-center space-x-2">
          <span class="text-lg font-bold text-blue-600">
            {{ formatPrice(product.displayPrice) }}
          </span>
          <span
              v-if="product.salePrice"
              class="text-sm text-gray-500 line-through"
          >
            {{ formatPrice(product.price) }}
          </span>
        </div>
      </div>

      <!-- Actions -->
      <div class="flex space-x-2">
        <button
            @click="viewProduct"
            class="flex-1 bg-blue-600 text-white py-2 px-4 rounded hover:bg-blue-700 transition-colors"
        >
          View Details
        </button>
        <button
            @click="addToCart"
            class="bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700 transition-colors"
        >
          Add to Cart
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const props = defineProps({
  product: {
    type: Object,
    required: true
  }
})

const router = useRouter()

const formatPrice = (price) => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
  }).format(price)
}

const viewProduct = () => {
  router.push(`/products/${props.product.slug}`)
}

const addToCart = () => {
  // TODO: Implement add to cart functionality
  console.log('Add to cart:', props.product.id)
}
</script>