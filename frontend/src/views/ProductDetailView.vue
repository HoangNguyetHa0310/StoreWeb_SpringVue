<script setup>
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import { useProductStore } from '@/stores/productStore';
import { useCartStore } from '@/stores/cartStore';
import { storeToRefs } from 'pinia';
import ToastNotification from '@/components/ToastNotification.vue';

const route = useRoute();
const productStore = useProductStore();
const cartStore = useCartStore();
const { product, loading } = storeToRefs(productStore);

const toast = ref({ show: false, message: '', type: 'success' });

onMounted(() => {
  productStore.fetchProduct(route.params.id);
});

const addToCart = () => {
  if (product.value) {
    cartStore.addItem(product.value);
    toast.value = { show: true, message: `${product.value.name} đã được thêm vào giỏ hàng!`, type: 'success' };
    setTimeout(() => (toast.value.show = false), 2000);
  }
};
</script>

<template>
  <div class="container mx-auto py-8">
    <div v-if="loading" class="text-center py-8 text-gray-500">Đang tải sản phẩm...</div>
    <div v-if="product" class="max-w-2xl mx-auto bg-white rounded-lg shadow p-6">
      <h1 class="text-2xl font-bold mb-4">{{ product.name }}</h1>
      <img :src="product.image_url" :alt="product.name" class="w-full max-w-xs mx-auto rounded mb-4" />
      <p class="mb-2 text-gray-700">{{ product.description }}</p>
      <h3 class="text-xl font-bold text-indigo-600 mb-4">{{ new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(product.price) }}</h3>
      <button @click="addToCart" class="bg-indigo-600 text-white px-6 py-2 rounded hover:bg-indigo-700 transition">Thêm vào giỏ hàng</button>
    </div>
    <ToastNotification :show="toast.show" :message="toast.message" :type="toast.type" @close="toast.show = false" />
  </div>
</template>