<script setup>
import { onMounted, ref } from 'vue';
import { useProductStore } from '@/stores/productStore';
import { storeToRefs } from 'pinia';
import ProductCard from '@/components/ProductCard.vue';
import ToastNotification from '@/components/ToastNotification.vue';

const productStore = useProductStore();
const { products, loading, error } = storeToRefs(productStore);

const showModal = ref(false);
const isEdit = ref(false);
const formProduct = ref({ id: null, name: '', price: '', image_url: '', description: '' });
const toast = ref({ show: false, message: '', type: 'success' });

onMounted(() => {
  productStore.fetchProducts();
});

function openAddModal() {
  isEdit.value = false;
  formProduct.value = { id: null, name: '', price: '', image_url: '', description: '' };
  showModal.value = true;
}
function openEditModal(product) {
  isEdit.value = true;
  formProduct.value = { ...product };
  showModal.value = true;
}
function closeModal() {
  showModal.value = false;
}
function showToast(message, type = 'success') {
  toast.value = { show: true, message, type };
  setTimeout(() => (toast.value.show = false), 2500);
}
async function saveProduct() {
  try {
    if (isEdit.value) {
      await productStore.updateProduct(formProduct.value.id, formProduct.value);
      showToast('Cập nhật sản phẩm thành công!', 'success');
    } else {
      await productStore.createProduct(formProduct.value);
      showToast('Thêm sản phẩm thành công!', 'success');
    }
    closeModal();
  } catch (err) {
    showToast(productStore.error || 'Có lỗi xảy ra!', 'error');
  }
}
async function deleteProduct(product) {
  if (!confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) return;
  try {
    await productStore.deleteProduct(product.id);
    showToast('Xóa sản phẩm thành công!', 'success');
  } catch (err) {
    showToast(productStore.error || 'Có lỗi xảy ra!', 'error');
  }
}
</script>

<template>
  <div class="container mx-auto py-8">
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-2xl font-bold text-gray-800">Danh sách sản phẩm</h1>
      <button @click="openAddModal" class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700 transition">+ Thêm sản phẩm</button>
    </div>
    <div v-if="loading" class="text-center py-8 text-gray-500">Đang tải sản phẩm...</div>
    <div v-if="error" class="text-center text-red-500">{{ error }}</div>
    <div v-if="products.length" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
      <div v-for="product in products" :key="product.id" class="relative">
        <ProductCard :product="product" />
        <div class="absolute top-2 right-2 flex space-x-2">
          <button @click="openEditModal(product)" class="bg-yellow-400 hover:bg-yellow-500 text-white px-2 py-1 rounded text-xs">Sửa</button>
          <button @click="deleteProduct(product)" class="bg-red-500 hover:bg-red-600 text-white px-2 py-1 rounded text-xs">Xóa</button>
        </div>
      </div>
    </div>

    <!-- Modal Thêm/Sửa -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
        <h2 class="text-xl font-bold mb-4">{{ isEdit ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm mới' }}</h2>
        <form @submit.prevent="saveProduct" class="space-y-4">
          <div>
            <label class="block text-gray-700">Tên sản phẩm</label>
            <input v-model="formProduct.name" required class="w-full border rounded px-3 py-2 mt-1 focus:ring-2 focus:ring-indigo-500" />
          </div>
          <div>
            <label class="block text-gray-700">Giá</label>
            <input v-model="formProduct.price" type="number" required class="w-full border rounded px-3 py-2 mt-1 focus:ring-2 focus:ring-indigo-500" />
          </div>
          <div>
            <label class="block text-gray-700">Ảnh (URL)</label>
            <input v-model="formProduct.image_url" class="w-full border rounded px-3 py-2 mt-1 focus:ring-2 focus:ring-indigo-500" />
          </div>
          <div>
            <label class="block text-gray-700">Mô tả</label>
            <textarea v-model="formProduct.description" class="w-full border rounded px-3 py-2 mt-1 focus:ring-2 focus:ring-indigo-500"></textarea>
          </div>
          <div class="flex justify-end space-x-2">
            <button type="button" @click="closeModal" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Hủy</button>
            <button type="submit" class="px-4 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700">{{ isEdit ? 'Cập nhật' : 'Thêm mới' }}</button>
          </div>
        </form>
        <button @click="closeModal" class="absolute top-2 right-2 text-gray-400 hover:text-gray-600 text-2xl">&times;</button>
      </div>
    </div>

    <!-- Toast Notification -->
    <ToastNotification :show="toast.show" :message="toast.message" :type="toast.type" @close="toast.show = false" />
  </div>
</template>

<style scoped>
/* Xóa style cũ, dùng Tailwind hoàn toàn */
</style>