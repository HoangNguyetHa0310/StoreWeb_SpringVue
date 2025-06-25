<template>
  <div>
    <h5>Product Images</h5>

    <!-- Danh sách ảnh hiện có -->
    <div v-for="img in images" :key="img.id" class="mb-3 d-flex align-items-center">
      <img :src="img.imageUrl" width="80" height="80" class="me-2 border" />
      <div class="flex-grow-1">
        <div><strong>Alt:</strong> {{ img.altText }}</div>
        <div><strong>Sort:</strong> {{ img.sortOrder }}</div>
        <div><strong>Primary:</strong> {{ img.isPrimary ? 'Yes' : 'No' }}</div>
      </div>
      <div>
        <button @click="startEdit(img)" class="btn btn-sm btn-outline-secondary me-2">Edit</button>
        <button @click="removeImage(img.id)" class="btn btn-sm btn-outline-danger">Delete</button>
      </div>
    </div>

    <!-- Thêm ảnh mới -->
    <div class="mt-4">
      <h6>Add New Image</h6>
      <input v-model="newImage.imageUrl" placeholder="Image URL" class="form-control mb-2" />
      <input v-model="newImage.altText" placeholder="Alt text" class="form-control mb-2" />
      <input v-model.number="newImage.sortOrder" type="number" placeholder="Sort order" class="form-control mb-2" />
      <div class="form-check mb-2">
        <input type="checkbox" class="form-check-input" v-model="newImage.isPrimary" id="newIsPrimary">
        <label class="form-check-label" for="newIsPrimary">Is Primary</label>
      </div>
      <button @click="addImage" class="btn btn-primary">Add Image</button>
    </div>

    <!-- Chỉnh sửa ảnh -->
    <div v-if="editingImage" class="mt-5">
      <h6>Edit Image</h6>
      <input v-model="editingImage.imageUrl" placeholder="Image URL" class="form-control mb-2" />
      <input v-model="editingImage.altText" placeholder="Alt text" class="form-control mb-2" />
      <input v-model.number="editingImage.sortOrder" type="number" placeholder="Sort order" class="form-control mb-2" />
      <div class="form-check mb-2">
        <input type="checkbox" class="form-check-input" v-model="editingImage.isPrimary" id="editIsPrimary">
        <label class="form-check-label" for="editIsPrimary">Is Primary</label>
      </div>
      <button @click="submitEdit" class="btn btn-success me-2">Save</button>
      <button @click="cancelEdit" class="btn btn-secondary">Cancel</button>
    </div>
  </div>
</template>

<script>
import { getImagesByProduct, addImage, updateImage, deleteImage } from '@/services/productImageService';

export default {
  props: ['productId'],
  data() {
    return {
      images: [],
      newImage: {
        imageUrl: '',
        altText: '',
        isPrimary: false,
        sortOrder: 0,
      },
      editingImage: null,
    };
  },
  methods: {
    fetchImages() {
      if (this.productId) {
        getImagesByProduct(this.productId).then(res => {
          this.images = res.data;
          this.$emit('images-updated', this.images); // 👈 Thêm dòng này
        });
      }
    },
    addImage() {
      const payload = { ...this.newImage, productId: this.productId };
      addImage(payload).then(() => {
        this.fetchImages();
        this.newImage = {
          imageUrl: '',
          altText: '',
          isPrimary: false,
          sortOrder: 0,
        };
      });
    },
    removeImage(id) {
      deleteImage(id).then(() => {
        this.fetchImages();
      });
    },
    startEdit(image) {
      this.editingImage = { ...image };
    },
    cancelEdit() {
      this.editingImage = null;
    },
    submitEdit() {
      updateImage(this.editingImage.id, this.editingImage).then(() => {
        this.fetchImages();
        this.editingImage = null;
      });
    },
  },
  mounted() {
    this.fetchImages();
  },
  watch: {
    productId() {
      this.fetchImages();
    },
  },
};
</script>
