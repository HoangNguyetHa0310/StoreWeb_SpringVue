<template>
  <div class="flex flex-col items-center justify-center min-h-screen bg-gray-100">
    <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
      <h2 class="text-2xl font-bold mb-6 text-center">Đăng ký tài khoản</h2>
      <form @submit.prevent="handleRegister">
        <div class="mb-4">
          <label class="block mb-1">Email</label>
          <input v-model="form.email" type="email" class="w-full border rounded px-3 py-2" required />
        </div>
        <div class="mb-4">
          <label class="block mb-1">Mật khẩu</label>
          <input v-model="form.password" type="password" class="w-full border rounded px-3 py-2" required autocomplete="new-password" />
        </div>
        <div class="mb-4">
          <label class="block mb-1">Họ</label>
          <input v-model="form.firstName" type="text" class="w-full border rounded px-3 py-2" required />
        </div>
        <div class="mb-4">
          <label class="block mb-1">Tên</label>
          <input v-model="form.lastName" type="text" class="w-full border rounded px-3 py-2" required />
        </div>
        <div class="mb-4">
          <label class="block mb-1">Số điện thoại</label>
          <input v-model="form.phone" type="text" class="w-full border rounded px-3 py-2" />
        </div>
        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">Đăng ký</button>
      </form>
      <p class="mt-4 text-center">
        Đã có tài khoản? <router-link to="/login" class="text-blue-600">Đăng nhập</router-link>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import api from '../services/api';

const router = useRouter();
const form = ref({
  email: '',
  password: '',
  firstName: '',
  lastName: '',
  phone: ''
});

const handleRegister = async () => {
  try {
    await api.post('/auth/register', form.value);
    alert('Đăng ký thành công!');
    router.push('/login');
  } catch (e) {
    alert('Đăng ký thất bại: ' + (e.response?.data?.message || e.message));
  }
};
</script>
