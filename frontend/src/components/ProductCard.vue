<template>
  <!-- Sử dụng các class của Tailwind để tạo card sản phẩm -->
  <div class="group relative border border-gray-200 rounded-lg overflow-hidden bg-white hover:shadow-2xl transition-shadow duration-300 ease-in-out">
    <div class="aspect-w-1 aspect-h-1 w-full overflow-hidden bg-gray-200">
      <!-- Hiệu ứng zoom ảnh khi hover -->
      <img :src="product.image_url" :alt="product.name" class="h-full w-full object-cover object-center group-hover:scale-105 transition-transform duration-300" />
    </div>
    <div class="p-4 flex flex-col flex-grow">
      <h3 class="text-sm text-gray-700 font-medium truncate">
        <router-link :to="{ name: 'ProductDetail', params: { id: product.id } }">
          <span aria-hidden="true" class="absolute inset-0"></span>
          {{ product.name }}
        </router-link>
      </h3>
      <div class="mt-2 flex-grow">
        <p class="text-lg font-bold text-gray-900">{{ formatCurrency(product.price) }}</p>
      </div>
      <button class="mt-4 w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition-colors">
        Thêm vào giỏ
      </button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  product: {
    type: Object,
    required: true
  }
});

const formatCurrency = (value) => {
  if (!value) return '';
  return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
};
</script>