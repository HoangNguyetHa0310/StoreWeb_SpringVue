<!-- ProductList.vue -->
<template>
  <div class="product-management">
    <div class="header">
      <h1>Quản lý sản phẩm</h1>
      <button @click="showCreateModal = true" class="btn btn-primary">
        <i class="fas fa-plus"></i> Thêm sản phẩm
      </button>
    </div>

    <!-- Filters -->
    <div class="filters">
      <div class="filter-group">
        <input
            v-model="filters.name"
            @input="debouncedSearch"
            type="text"
            placeholder="Tìm kiếm theo tên sản phẩm..."
            class="form-control"
        />
      </div>
      <div class="filter-group">
        <select v-model="filters.categoryId" @change="searchProducts" class="form-control">
          <option value="">Tất cả danh mục</option>
          <option v-for="category in categories" :key="category.id" :value="category.id">
            {{ category.name }}
          </option>
        </select>
      </div>
      <div class="filter-group">
        <select v-model="filters.status" @change="searchProducts" class="form-control">
          <option value="">Tất cả trạng thái</option>
          <option value="ACTIVE">Hoạt động</option>
          <option value="INACTIVE">Không hoạt động</option>
        </select>
      </div>
    </div>

    <!-- Loading -->
    <div v-if="loading" class="loading">
      <i class="fas fa-spinner fa-spin"></i> Đang tải...
    </div>

    <!-- Products Table -->
    <div v-else class="table-container">
      <table class="table">
        <thead>
        <tr>
          <th @click="sort('id')">
            ID
            <i :class="getSortIcon('id')"></i>
          </th>
          <th>Hình ảnh</th>
          <th @click="sort('name')">
            Tên sản phẩm
            <i :class="getSortIcon('name')"></i>
          </th>
          <th>SKU</th>
          <th>Danh mục</th>
          <th @click="sort('price')">
            Giá
            <i :class="getSortIcon('price')"></i>
          </th>
          <th @click="sort('stockQuantity')">
            Tồn kho
            <i :class="getSortIcon('stockQuantity')"></i>
          </th>
          <th>Trạng thái</th>
          <th>Nổi bật</th>
          <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="product in products" :key="product.id">
          <td>{{ product.id }}</td>
          <td>
            <img
                :src="product.imageUrl || '/placeholder.jpg'"
                :alt="product.name"
                class="product-image"
                @error="handleImageError"
            />
          </td>
          <td>
            <div class="product-name">{{ product.name }}</div>
            <div class="product-description">{{ truncateText(product.description, 50) }}</div>
          </td>
          <td>{{ product.sku }}</td>
          <td>{{ product.categoryName || 'N/A' }}</td>
          <td>
            <div class="price">
              <span class="current-price">{{ formatPrice(product.price) }}</span>
              <span v-if="product.salePrice" class="sale-price">{{ formatPrice(product.salePrice) }}</span>
            </div>
          </td>
          <td>
              <span :class="['stock', { 'low-stock': product.stockQuantity <= 10 }]">
                {{ product.stockQuantity }}
              </span>
          </td>
          <td>
              <span :class="['status', product.status.toLowerCase()]">
                {{ product.status === 'ACTIVE' ? 'Hoạt động' : 'Không hoạt động' }}
              </span>
          </td>
          <td>
              <span :class="['featured', { active: product.isFeatured }]">
                <i :class="product.isFeatured ? 'fas fa-star' : 'far fa-star'"></i>
              </span>
          </td>
          <td>
            <div class="actions">
              <button @click="editProduct(product)" class="btn btn-sm btn-secondary">
                <i class="fas fa-edit"></i>
              </button>
              <button @click="deleteProduct(product)" class="btn btn-sm btn-danger">
                <i class="fas fa-trash"></i>
              </button>
            </div>
          </td>
        </tr>
        </tbody>
      </table>

      <!-- Empty State -->
      <div v-if="products.length === 0" class="empty-state">
        <i class="fas fa-box-open"></i>
        <p>Không có sản phẩm nào</p>
      </div>
    </div>

    <!-- Pagination -->
    <div v-if="pagination.totalPages > 1" class="pagination">
      <button
          @click="changePage(pagination.currentPage - 1)"
          :disabled="!pagination.hasPrevious"
          class="btn btn-outline"
      >
        <i class="fas fa-chevron-left"></i>
      </button>

      <span class="page-info">
        Trang {{ pagination.currentPage + 1 }} / {{ pagination.totalPages }}
        ({{ pagination.totalItems }} sản phẩm)
      </span>

      <button
          @click="changePage(pagination.currentPage + 1)"
          :disabled="!pagination.hasNext"
          class="btn btn-outline"
      >
        <i class="fas fa-chevron-right"></i>
      </button>
    </div>

    <!-- Product Modal -->
    <ProductModal
        v-if="showCreateModal || showEditModal"
        :show="showCreateModal || showEditModal"
        :product="selectedProduct"
        :categories="categories"
        @close="closeModal"
        @save="handleSave"
    />

    <!-- Delete Confirmation Modal -->
    <ConfirmModal
        v-if="showDeleteModal"
        :show="showDeleteModal"
        title="Xác nhận xóa sản phẩm"
        :message="`Bạn có chắc chắn muốn xóa sản phẩm '${productToDelete?.name}'?`"
        @confirm="confirmDelete"
        @cancel="showDeleteModal = false"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
// import { debounce } from 'lodash-es'
import ProductModal from './ProductModal.vue'
// import ConfirmModal from './ConfirmModal.vue'
// import { productService } from '../services/productService'
// import { categoryService } from '../services/categoryService'
// import { useToast } from '../composables/useToast'

const { showToast } = useToast()

// State
const loading = ref(false)
const products = ref([])
const categories = ref([])
const selectedProduct = ref(null)
const productToDelete = ref(null)

// Modals
const showCreateModal = ref(false)
const showEditModal = ref(false)
const showDeleteModal = ref(false)

// Filters and Pagination
const filters = reactive({
  name: '',
  categoryId: '',
  status: ''
})

const sorting = reactive({
  sortBy: 'id',
  sortDir: 'desc'
})

const pagination = reactive({
  currentPage: 0,
  pageSize: 10,
  totalItems: 0,
  totalPages: 0,
  hasNext: false,
  hasPrevious: false
})

// Computed
const getSortIcon = computed(() => (field) => {
  if (sorting.sortBy !== field) return 'fas fa-sort'
  return sorting.sortDir === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'
})

// Methods
const loadProducts = async () => {
  loading.value = true
  try {
    const params = {
      page: pagination.currentPage,
      size: pagination.pageSize,
      sortBy: sorting.sortBy,
      sortDir: sorting.sortDir,
      ...filters
    }

    const response = await productService.getProducts(params)
    products.value = response.products

    // Update pagination
    Object.assign(pagination, {
      currentPage: response.currentPage,
      totalItems: response.totalItems,
      totalPages: response.totalPages,
      pageSize: response.pageSize,
      hasNext: response.hasNext,
      hasPrevious: response.hasPrevious
    })
  } catch (error) {
    showToast('Lỗi khi tải danh sách sản phẩm', 'error')
    console.error('Error loading products:', error)
  } finally {
    loading.value = false
  }
}

const loadCategories = async () => {
  try {
    categories.value = await categoryService.getActiveCategories()
  } catch (error) {
    console.error('Error loading categories:', error)
  }
}

const searchProducts = () => {
  pagination.currentPage = 0
  loadProducts()
}

const debouncedSearch = debounce(searchProducts, 500)

const sort = (field) => {
  if (sorting.sortBy === field) {
    sorting.sortDir = sorting.sortDir === 'asc' ? 'desc' : 'asc'
  } else {
    sorting.sortBy = field
    sorting.sortDir = 'asc'
  }
  searchProducts()
}

const changePage = (page) => {
  pagination.currentPage = page
  loadProducts()
}

const editProduct = (product) => {
  selectedProduct.value = { ...product }
  showEditModal.value = true
}

const deleteProduct = (product) => {
  productToDelete.value = product
  showDeleteModal.value = true
}

const confirmDelete = async () => {
  try {
    await productService.deleteProduct(productToDelete.value.id)
    showToast('Xóa sản phẩm thành công', 'success')
    showDeleteModal.value = false
    productToDelete.value = null
    loadProducts()
  } catch (error) {
    showToast('Lỗi khi xóa sản phẩm', 'error')
    console.error('Error deleting product:', error)
  }
}

const closeModal = () => {
  showCreateModal.value = false
  showEditModal.value = false
  selectedProduct.value = null
}

const handleSave = async (productData) => {
  try {
    if (selectedProduct.value) {
      await productService.updateProduct(selectedProduct.value.id, productData)
      showToast('Cập nhật sản phẩm thành công', 'success')
    } else {
      await productService.createProduct(productData)
      showToast('Tạo sản phẩm thành công', 'success')
    }
    closeModal()
    loadProducts()
  } catch (error) {
    showToast('Lỗi khi lưu sản phẩm', 'error')
    console.error('Error saving product:', error)
  }
}

const handleImageError = (event) => {
  event.target.src = '/placeholder.jpg'
}

const truncateText = (text, maxLength) => {
  if (!text) return ''
  return text.length > maxLength ? text.substring(0, maxLength) + '...' : text
}

const formatPrice = (price) => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
  }).format(price)
}

// Lifecycle
onMounted(() => {
  loadProducts()
  loadCategories()
})
</script>

<style scoped>
.product-management {
  padding: 20px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header h1 {
  margin: 0;
  color: #333;
}

.filters {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

.filter-group {
  flex: 1;
  min-width: 200px;
}

.form-control {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.form-control:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.table-container {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow-x: auto;
}

.table {
  width: 100%;
  border-collapse: collapse;
}

.table th,
.table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.table th {
  background-color: #f8f9fa;
  font-weight: 600;
  color: #495057;
  cursor: pointer;
  position: relative;
}

.table th:hover {
  background-color: #e9ecef;
}

.table th i {
  margin-left: 5px;
  color: #6c757d;
}

.product-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
  border-radius: 4px;
}

.product-name {
  font-weight: 600;
  margin-bottom: 2px;
}

.product-description {
  font-size: 12px;
  color: #6c757d;
}

.price {
  display: flex;
  flex-direction: column;
}

.current-price {
  font-weight: 600;
}

.sale-price {
  font-size: 12px;
  color: #dc3545;
  text-decoration: line-through;
}

.stock {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
  background-color: #d4edda;
  color: #155724;
}

.stock.low-stock {
  background-color: #f8d7da;
  color: #721c24;
}

.status {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
}

.status.active {
  background-color: #d4edda;
  color: #155724;
}

.status.inactive {
  background-color: #f8d7da;
  color: #721c24;
}

.featured i {
  color: #ffc107;
}

.featured.active i {
  color: #ff6b35;
}

.actions {
  display: flex;
  gap: 5px;
}

.btn {
  padding: 8px 16px;
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

.btn:hover {
  transform: translateY(-1px);
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-primary:hover {
  background-color: #0056b3;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #545b62;
}

.btn-danger {
  background-color: #dc3545;
  color: white;
}

.btn-danger:hover {
  background-color: #c82333;
}

.btn-outline {
  background-color: transparent;
  border: 1px solid #ddd;
  color: #495057;
}

.btn-outline:hover {
  background-color: #f8f9fa;
}

.btn-outline:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-sm {
  padding: 4px 8px;
  font-size: 12px;
}

.loading {
  text-align: center;
  padding: 40px;
  font-size: 16px;
  color: #6c757d;
}

.empty-state {
  text-align: center;
  padding: 40px;
  color: #6c757d;
}

.empty-state i {
  font-size: 48px;
  margin-bottom: 16px;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
  margin-top: 20px;
}

.page-info {
  font-size: 14px;
  color: #6c757d;
}

@media (max-width: 768px) {
  .filters {
    flex-direction: column;
  }

  .filter-group {
    min-width: auto;
  }

  .header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }

  .table-container {
    overflow-x: scroll;
  }

  .table {
    min-width: 800px;
  }
}
</style>