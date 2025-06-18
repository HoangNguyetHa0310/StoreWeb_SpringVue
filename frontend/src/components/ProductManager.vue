<template>
  <div class="card shadow">
    <div class="card-header bg-primary text-white">
      <h3>Quản lý sản phẩm</h3>
    </div>

    <div class="card-body">
      <form @submit.prevent="onSubmit">
        <div class="row g-3">
          <!-- Các input cơ bản -->
          <div class="col-md-6">
            <label class="form-label">Tên sản phẩm</label>
            <input v-model="form.name" class="form-control" required />
          </div>
          <div class="col-md-6">
            <label class="form-label">Slug</label>
            <input v-model="form.slug" class="form-control" required />
          </div>
          <div class="col-md-6">
            <label class="form-label">SKU</label>
            <input v-model="form.sku" class="form-control" required />
          </div>
          <div class="col-md-6">
            <label class="form-label">Giá</label>
            <input v-model="form.price" type="number" class="form-control" required />
          </div>

          <!-- Select hình ảnh chính -->
          <div class="col-md-6">
            <label class="form-label">Ảnh đại diện</label>
            <select v-model="form.thumbnail" class="form-select">
              <option disabled value="">-- Chọn ảnh đại diện --</option>
              <option v-for="img in productImages" :key="img.id" :value="img.imageUrl">
                {{ img.altText || img.imageUrl }}
              </option>
            </select>
            <div v-if="form.thumbnail" class="mt-2">
              <img :src="form.thumbnail" class="img-thumbnail" width="100" />
            </div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Trạng thái</label>
            <input v-model="form.status" class="form-control" />
          </div>

          <div class="col-md-12">
            <label class="form-label">Mô tả</label>
            <textarea v-model="form.description" rows="3" class="form-control"></textarea>
          </div>

          <div class="col-12">
            <button type="submit" class="btn btn-success me-2">
              {{ form.id ? 'Cập nhật' : 'Thêm mới' }}
            </button>
            <button type="button" class="btn btn-secondary" @click="resetForm">Reset</button>
          </div>
        </div>
      </form>
    </div>

    <ProductImageManager v-if="form.id" :productId="form.id" />

    <!-- Danh sách sản phẩm -->
    <div class="mt-4">
      <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
          <th>ID</th>
          <th>Tên</th>
          <th>Giá</th>
          <th>Ảnh</th>
          <th>Trạng thái</th>
          <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="product in productStore.products" :key="product.id">
          <td>{{ product.id }}</td>
          <td>{{ product.name }}</td>
          <td>{{ product.price }}</td>
          <td>
            <img v-if="product.thumbnail" :src="product.thumbnail" width="60" />
          </td>
          <td>{{ product.status }}</td>
          <td>
            <button class="btn btn-warning btn-sm me-1" @click="edit(product)">Sửa</button>
            <button class="btn btn-danger btn-sm" @click="remove(product.id)">Xoá</button>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { reactive, onMounted, ref, watch } from 'vue';
import { useProductStore } from '@/stores/productStore';
import { getImagesByProduct } from '@/services/productImageService';
import ProductImageManager from './ProductImageManager.vue';

const productStore = useProductStore();

const form = reactive({
  id: null,
  name: '',
  slug: '',
  sku: '',
  price: 0,
  status: 'active',
  description: '',
  thumbnail: ''
});

const productImages = ref([]);

onMounted(() => {
  productStore.fetchProducts();
});

watch(() => form.id, async (newId) => {
  if (newId) {
    const res = await getImagesByProduct(newId);
    productImages.value = res.data;
  }
});

const onSubmit = async () => {
  if (form.id) {
    await productStore.updateProduct(form.id, { ...form });
  } else {
    await productStore.addProduct({ ...form });
  }
  resetForm();
};

const edit = (product) => {
  Object.assign(form, product);
};

const remove = async (id) => {
  if (confirm('Xác nhận xoá?')) {
    await productStore.deleteProduct(id);
  }
};

const resetForm = () => {
  Object.assign(form, {
    id: null,
    name: '',
    slug: '',
    sku: '',
    price: 0,
    status: 'active',
    description: '',
    thumbnail: ''
  });
};
</script>
