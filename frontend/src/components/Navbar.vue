<script setup>
import { useCartStore } from '@/stores/cartStore';
import { useAuthStore } from '@/stores/authStore';
import { storeToRefs } from 'pinia';

const cartStore = useCartStore();
const { itemCount } = storeToRefs(cartStore);

const authStore = useAuthStore();
const { isAuthenticated, user } = storeToRefs(authStore);
</script>

<template>
  <nav class="bg-white shadow-md sticky top-0 z-50">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between h-16">
        <!-- Logo -->
        <router-link to="/" class="flex items-center text-2xl font-bold text-indigo-600 hover:text-indigo-800">
          <svg class="h-8 w-8 mr-2 text-indigo-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0h6" /></svg>
          StoreWeb
        </router-link>
        <!-- Menu -->
        <div class="hidden md:flex space-x-6">
          <router-link to="/" class="text-gray-700 hover:text-indigo-600 font-medium transition">Trang chủ</router-link>
          <router-link to="/products" class="text-gray-700 hover:text-indigo-600 font-medium transition">Sản phẩm</router-link>
        </div>
        <!-- Actions -->
        <div class="flex items-center space-x-4">
          <router-link to="/cart" class="relative p-2 rounded-full text-gray-500 hover:bg-gray-100 hover:text-indigo-600 transition">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
            <span v-if="itemCount > 0" class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full px-1">{{ itemCount }}</span>
          </router-link>
          <div>
            <span v-if="isAuthenticated" class="flex items-center space-x-2">
              <span class="text-gray-700 font-medium">Xin chào, {{ user.first_name }}</span>
              <button @click="authStore.logout()" class="ml-2 px-3 py-1 bg-gray-200 hover:bg-red-500 hover:text-white rounded transition">Đăng xuất</button>
            </span>
            <router-link v-else to="/login" class="px-4 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700 transition">Đăng nhập</router-link>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<style scoped>
/* Đã chuyển toàn bộ style sang Tailwind, không cần style cục bộ */
</style>