import { defineStore } from 'pinia';
import * as productService from '@/services/productService';

export const useProductStore = defineStore('product', {
    state: () => ({
        products: [],
        loading: false,
        error: null,
    }),

    actions: {
        async fetchProducts() {
            this.loading = true;
            try {
                const res = await productService.getProducts();
                this.products = res.data;
            } catch (err) {
                this.error = err;
            } finally {
                this.loading = false;
            }
        },

        async addProduct(product) {
            await productService.createProduct(product);
            await this.fetchProducts();
        },

        async updateProduct(id, product) {
            await productService.updateProduct(id, product);
            await this.fetchProducts();
        },

        async deleteProduct(id) {
            await productService.deleteProduct(id);
            await this.fetchProducts();
        }
    }
});
