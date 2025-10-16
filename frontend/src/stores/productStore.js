import { defineStore } from 'pinia';
import { productService } from '@/services/productService';

export const useProductStore = defineStore('product', {
  state: () => ({
    products: [],
    product: null,
    loading: false,
    error: null
  }),
  actions: {
    async fetchProducts() {
      this.loading = true;
      this.error = null;
      try {
        const response = await productService.getProducts();
        this.products = response.data;
      } catch (err) {
        this.error = err.response?.data?.message || 'Failed to fetch products.';
        console.error(err);
      } finally {
        this.loading = false;
      }
    },
    async fetchProduct(id) {
      this.loading = true;
      this.product = null;
      this.error = null;
      try {
        const response = await productService.getProduct(id);
        this.product = response.data;
      } catch (err) {
        this.error = err.response?.data?.message || 'Failed to fetch product.';
        console.error(err);
      } finally {
        this.loading = false;
      }
    },
    async createProduct(product) {
      this.loading = true;
      this.error = null;
      try {
        const response = await productService.createProduct(product);
        this.products.push(response.data);
        return response.data;
      } catch (err) {
        this.error = err.response?.data?.message || 'Failed to create product.';
        throw err;
      } finally {
        this.loading = false;
      }
    },
    async updateProduct(id, product) {
      this.loading = true;
      this.error = null;
      try {
        const response = await productService.updateProduct(id, product);
        const idx = this.products.findIndex(p => p.id === id);
        if (idx !== -1) this.products[idx] = response.data;
        return response.data;
      } catch (err) {
        this.error = err.response?.data?.message || 'Failed to update product.';
        throw err;
      } finally {
        this.loading = false;
      }
    },
    async deleteProduct(id) {
      this.loading = true;
      this.error = null;
      try {
        await productService.deleteProduct(id);
        this.products = this.products.filter(p => p.id !== id);
      } catch (err) {
        this.error = err.response?.data?.message || 'Failed to delete product.';
        throw err;
      } finally {
        this.loading = false;
      }
    }
  }
});