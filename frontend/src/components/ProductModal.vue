<template>
  <div v-if="show" class="modal-overlay" @click="closeModal">
    <div class="modal-content" @click.stop>
      <div class="modal-header">
        <h3>{{ product ? 'Chỉnh sửa sản phẩm' : 'Thêm sản phẩm mới' }}</h3>
        <button @click="closeModal" class="close-btn">
          <i class="fas fa-times"></i>
        </button>
      </div>

      <form @submit.prevent="handleSubmit" class="modal-body">
        <div class="form-row">
          <div class="form-group">
            <label for="name">Tên sản phẩm *</label>
            <input
                id="name"
                v-model="form.name"
                type="text"
                class="form-control"
                :class="{ 'is-invalid': errors.name }"
                required
            />
            <div v-if="errors.name" class="invalid-feedback">{{ errors.name }}</div>
          </div>

          <div class="form-group">
            <label for="sku">SKU *</label>
            <input
                id="sku"
                v-model="form.sku"
                type="text"
                class="form-control"
                :class="{ 'is-invalid': errors.sku }"
                required
            />
            <div v-if="errors.sku" class="invalid-feedback">{{ errors.sku }}</div>
          </div>
        </div>

        <div class="form-group">
          <label for="slug">Slug *</label>
          <input
              id="slug"
              v-model="form.slug"
              type="text"
              class="form-control"
              :class="{ 'is-invalid': errors.slug }"
              required
          />
          <div v-if="errors.slug" class="invalid-feedback">{{ errors.slug }}</div>
          <small class="form-text">URL thân thiện cho sản phẩm</small>
        </div>

        <div class="form-group">
          <label for="description">Mô tả sản phẩm</label>
          <textarea
              id="description"
              v-model="form.description"
              class="form-control"
              rows="4"
              placeholder="Nhập mô tả chi tiết về sản phẩm..."
          ></textarea>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label for="categoryId">Danh mục</label>
            <select
                id="categoryId"
                v-model="form.categoryId"
                class="form-control"
            >
              <option value="">Chọn danh mục</option>
              <option v-for="category in categories" :key="category.id" :value="category.id">
                {{ category.name }}
              </option>
            </select>
          </div>

          <div class="form-group">
            <label for="status">Trạng thái</label>
            <select
                id="status"
                v-model="form.status"
                class="form-control"
            >
              <option value="ACTIVE">Hoạt động</option>
              <option value="INACTIVE">Không hoạt động</option>
            </select>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label for="price">Giá bán *</label>
            <input
                id="price"
                v-model.number="form.price"
                type="number"
                step="0.01"
                min="0"
                class="form-control"
                :class="{ 'is-invalid': errors.price }"
                required
            />
            <div v-if="errors.price" class="invalid-feedback">{{ errors.price }}</div>
          </div>

          <div class="form-group">
            <label for="salePrice">Giá khuyến mãi</label>
            <input
                id="salePrice"
                v-model.number="form.salePrice"
                type="number"
                step="0.01"
                min="0"
                class="form-control"
            />
          </div>
        </div>

        <div class="form-group">
          <label for="stockQuantity">Số lượng tồn kho</label>
          <input
              id="stockQuantity"
              v-model.number="form.stockQuantity"
              type="number"
              min="0"
              class="form-control"
          />
        </div>

        <div class="form-group">
          <label for="imageUrl">URL hình ảnh</label>
          <input
              id="imageUrl"
              v-model="form.imageUrl"
              type="url"
              class="form-control"
              placeholder="https://example.com/image.jpg"
          />
          <div v-if="form.imageUrl" class="image-preview">
            <img :src="form.imageUrl" alt="Preview" @error="handleImageError" />
          </div>
        </div>

        <div class="form-group">
          <label class="checkbox-label">
            <input
                v-model="form.isFeatured"
                type="checkbox"
                class="checkbox"
            />
            <span class="checkmark"></span>
            Sản phẩm nổi bật
          </label>
        </div>

        <div class="modal-footer">
          <button type="button" @click="closeModal" class="btn btn-secondary">
            Hủy
          </button>
          <button type="submit" :disabled="submitting" class="btn btn-primary">
            <i v-if="submitting" class="fas fa-spinner fa-spin"></i>
            {{ submitting ? 'Đang lưu...' : 'Lưu' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, watch, computed } from 'vue'

const props = defineProps({
  show: Boolean,
  product: Object,
  categories: Array
})

const emit = defineEmits(['close', 'save'])

const submitting = ref(false)
const errors = ref({})

const form = reactive({
  name: '',
  slug: '',
  description: '',
  sku: '',
  categoryId: '',
  price: 0,
  salePrice: null,
  stockQuantity: 0,
  imageUrl: '',
  status: 'ACTIVE',
  isFeatured: false
})

// Watch for product changes
watch(() => props.product, (newProduct) => {
  if (newProduct) {
    Object.assign(form, {
      name: newProduct.name || '',
      slug: newProduct.slug || '',
      description: newProduct.description || '',
      sku: newProduct.sku || '',
      categoryId: newProduct.categoryId || '',
      price: newProduct.price || 0,
      salePrice: newProduct.salePrice || null,
      stockQuantity: newProduct.stockQuantity || 0,
      imageUrl: newProduct.imageUrl || '',
      status: newProduct.status || 'ACTIVE',
      isFeatured: newProduct.isFeatured || false
    })
  } else {
    resetForm()
  }
}, { immediate: true })

// Auto-generate slug from name
watch(() => form.name, (newName) => {
  if (newName && !props.product) {
    form.slug = generateSlug(newName)
  }
})

const generateSlug = (text) => {
  return text
      .toLowerCase()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^a-z0-9\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .trim()
}

const validateForm = () => {
  errors.value = {}

  if (!form.name.trim()) {
    errors.value.name = 'Tên sản phẩm không được để trống'
  }

  if (!form.slug.trim()) {
    errors.value.slug = 'Slug không được để trống'
  }

  if (!form.sku.trim()) {
    errors.value.sku = 'SKU không được để trống'
  }

  if (!form.price || form.price <= 0) {
    errors.value.price = 'Giá sản phẩm phải lớn hơn 0'
  }

  if (form.salePrice && form.salePrice >= form.price) {
    errors.value.salePrice = 'Giá khuyến mãi phải nhỏ hơn giá bán'
  }

  return Object.keys(errors.value).length === 0
}

const handleSubmit = async () => {
  if (!validateForm()) return

  submitting.value = true
  try {
    await emit('save', { ...form })
  } finally {
    submitting.value = false
  }
}

const closeModal = () => {
  resetForm()
  emit('close')
}

const resetForm = () => {
  Object.assign(form, {
    name: '',
    slug: '',
    description: '',
    sku: '',
    categoryId: '',
    price: 0,
    salePrice: null,
    stockQuantity: 0,
    imageUrl: '',
    status: 'ACTIVE',
    isFeatured: false
  })
  errors.value = {}
}

const handleImageError = (event) => {
  event.target.style.display = 'none'
}
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 600px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid #eee;
}

.modal-header h3 {
  margin: 0;
  color: #333;
}

.close-btn {
  background: none;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: #666;
  padding: 5px;
}

.close-btn:hover {
  color: #333;
}

.modal-body {
  padding: 20px;
}

.form-row {
  display: flex;
  gap: 15px;
}

.form-row .form-group {
  flex: 1;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: 600;
  color: #333;
}

.form-control {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  transition: border-color 0.2s;
}

.form-control:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.form-control.is-invalid {
  border-color: #dc3545;
}

.invalid-feedback {
  display: block;
  color: #dc3545;
  font-size: 12px;
  margin-top: 5px;
}

.form-text {
  font-size: 12px;
  color: #6c757d;
  margin-top: 5px;
}

.image-preview {
  margin-top: 10px;
}

.image-preview img {
  max-width: 200px;
  max-height: 200px;
  object-fit: cover;
  border-radius: 4px;
  border: 1px solid #ddd;
}

.checkbox-label {
  display: flex;
  align-items: center;
  cursor: pointer;
  font-weight: normal;
}

.checkbox {
  margin-right: 8px;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  padding-top: 20px;
  border-top: 1px solid #eee;
  margin-top: 20px;
}

.btn {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s;
  display: inline-flex;
  align-items: center;
  gap: 5px;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background-color: #0056b3;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #545b62;
}

@media (max-width: 768px) {
  .modal-content {
    width: 95%;
    margin: 10px;
  }

  .form-row {
    flex-direction: column;
  }

  .modal-header,
  .modal-body {
    padding: 15px;
  }
}
</style>
