<template>
  <header class="bg-white shadow-md sticky top-0 z-40">
    <nav class="container mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between h-16">
        <!-- Logo -->
        <div class="flex-shrink-0">
          <a href="/" class="text-2xl font-bold text-primary-600">StoreWeb</a>
        </div>

        <!-- Menu cho Desktop -->
        <div class="hidden md:block">
          <div class="ml-10 flex items-baseline space-x-4">
            <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Điện tử</a>
            <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Thời trang</a>
            <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Nhà cửa</a>
            <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Khuyến mãi</a>
          </div>
        </div>

        <!-- Thanh tìm kiếm và Icons -->
        <div class="hidden md:flex items-center space-x-4">
           <div class="relative">
              <input type="search" placeholder="Tìm kiếm sản phẩm..." class="w-full md:w-64 pl-10 pr-4 py-2 border rounded-full text-sm focus:outline-none focus:ring-2 focus:ring-primary-500">
              <div class="absolute top-0 left-0 inline-flex items-center p-2">
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" /></svg>
              </div>
          </div>
          <a href="#" class="p-2 rounded-full text-gray-500 hover:bg-gray-100 hover:text-primary-600">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
          </a>
          <a href="#" class="relative p-2 rounded-full text-gray-500 hover:bg-gray-100 hover:text-primary-600">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
            <span class="absolute top-0 right-0 block h-4 w-4 rounded-full bg-red-500 text-white text-xs text-center">3</span>
          </a>
        </div>

        <!-- Nút menu cho Mobile -->
        <div class="md:hidden flex items-center">
          <button @click="mobileMenuOpen = !mobileMenuOpen" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-primary-500 focus:outline-none">
            <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
              <path :class="{'hidden': mobileMenuOpen, 'inline-flex': !mobileMenuOpen }" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7" />
              <path :class="{'hidden': !mobileMenuOpen, 'inline-flex': mobileMenuOpen }" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>

      <!-- Menu cho Mobile (hiện khi click) -->
      <div v-show="mobileMenuOpen" class="md:hidden">
        <div class="px-2 pt-2 pb-3 space-y-1 sm:px-3">
          <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Điện tử</a>
          <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Thời trang</a>
          <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Nhà cửa</a>
          <a href="#" class="text-gray-700 hover:bg-primary-500 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Khuyến mãi</a>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { ref } from 'vue';

const mobileMenuOpen = ref(false);
</script>