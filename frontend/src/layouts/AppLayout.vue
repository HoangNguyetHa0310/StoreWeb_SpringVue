<template>
  <div class="flex flex-col min-h-screen bg-gray-50">
    <!-- Header của trang web -->
    <Header />

    <!-- Phần nội dung chính, nơi các trang con sẽ được hiển thị -->
    <main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <router-view />
    </main>

    <!-- Footer của trang web -->
    <Footer />
  </div>
</template>

<script setup>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
</script>