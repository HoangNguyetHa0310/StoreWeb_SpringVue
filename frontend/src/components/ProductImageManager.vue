<template>
  <div>
    <h5>Product Images</h5>
    <div v-for="img in images" :key="img.id" class="mb-2">
      <img :src="img.imageUrl" width="80" height="80" class="me-2" />
      <button @click="removeImage(img.id)">Delete</button>
    </div>

    <div class="mt-3">
      <input v-model="newImage.imageUrl" placeholder="Image URL" class="form-control mb-2" />
      <input v-model="newImage.altText" placeholder="Alt text" class="form-control mb-2" />
      <button @click="addImage" class="btn btn-primary">Add Image</button>
    </div>
  </div>
</template>

<script>
import { getProductImages, addProductImage, deleteProductImage } from '@/services/productImageService';

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
    };
  },
  methods: {
    fetchImages() {
      if (this.productId) {
        getProductImages(this.productId).then(res => {
          this.images = res.data;
        });
      }
    },
    addImage() {
      addProductImage({ ...this.newImage, productId: this.productId }).then(() => {
        this.fetchImages();
        this.newImage.imageUrl = '';
        this.newImage.altText = '';
      });
    },
    removeImage(id) {
      deleteProductImage(id).then(() => {
        this.fetchImages();
      });
    },
  },
  mounted() {
    this.fetchImages();
  },
  watch: {
    productId(newId) {
      this.fetchImages();
    },
  },
};
</script>
