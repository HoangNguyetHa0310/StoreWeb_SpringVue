<template>
  <div class="min-h-full flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 p-10 bg-white rounded-xl shadow-lg">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Đăng nhập vào tài khoản
        </h2>
        <p class="mt-2 text-center text-sm text-gray-600">
          Hoặc
          <router-link to="/register" class="font-medium text-primary-600 hover:text-primary-500">
            tạo tài khoản mới
          </router-link>
        </p>
      </div>
      <form class="mt-8 space-y-6" @submit="handleLogin">
        <div class="rounded-md shadow-sm -space-y-px">
          <div>
            <label for="email-address" class="sr-only">Địa chỉ email</label>
            <input id="email-address" name="email" type="email" v-model="email" autocomplete="email" required
                   class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-primary-500 focus:border-primary-500 focus:z-10 sm:text-sm"
                   placeholder="Địa chỉ email">
          </div>
          <div>
            <label for="password" class="sr-only">Mật khẩu</label>
            <input id="password" name="password" type="password" v-model="password" autocomplete="current-password" required
                   class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-primary-500 focus:border-primary-500 focus:z-10 sm:text-sm"
                   placeholder="Mật khẩu">
          </div>
        </div>
        <div>
          <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">
            Đăng nhập
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import api from '../services/api';

const router = useRouter();
const email = ref('');
const password = ref('');

const handleLogin = async (e) => {
  e.preventDefault();
  try {
    const res = await api.post('/auth/login', { email: email.value, password: password.value });
    localStorage.setItem('token', res.data.token);
    alert('Đăng nhập thành công!');
    router.push('/');
  } catch (err) {
    alert('Đăng nhập thất bại: ' + (err.response?.data?.message || err.message));
  }
};
</script>

<style scoped>
/* Add any component-specific styles here */
</style>