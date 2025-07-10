import { defineStore } from 'pinia';
import { getCart, addToCart, updateCartItem, removeFromCart } from '@/services/apiService';

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [],
    loading: false,
    error: null
  }),
  getters: {
    itemCount: (state) => state.items.reduce((count, item) => count + item.quantity, 0),
    cartTotal: (state) => state.items.reduce((total, item) => total + item.price * item.quantity, 0).toFixed(2)
  },
  actions: {
    // Giả định userId được lấy từ authStore sau khi đăng nhập
    async fetchCart(userId) {
      this.loading = true;
      this.error = null;
      try {
        const response = await getCart(userId);
        this.items = response.data.items; // Giả định API trả về { items: [...] }
      } catch (err) {
        this.error = 'Failed to fetch cart.';
        console.error(err);
      } finally {
        this.loading = false;
      }
    },

    async addItem(product, quantity = 1, userId = 1 /* Tạm thời */) {
      const existingItem = this.items.find(item => item.productId === product.id);
      if (existingItem) {
        existingItem.quantity += quantity;
        // await updateCartItem(userId, existingItem.id, existingItem.quantity);
      } else {
        this.items.push({ productId: product.id, name: product.name, price: product.sale_price || product.price, quantity });
        // await addToCart(userId, product.id, quantity);
      }
    },

    async removeItem(productId, userId = 1 /* Tạm thời */) {
      this.items = this.items.filter(item => item.productId !== productId);
      // const cartItem = ... // tìm cart item id để gọi API
      // await removeFromCart(userId, cartItem.id);
    },

    async updateQuantity(productId, quantity, userId = 1 /* Tạm thời */) {
      if (quantity < 1) {
        this.removeItem(productId, userId);
        return;
      }
      const item = this.items.find(item => item.productId === productId);
      if (item) {
        item.quantity = quantity;
        // await updateCartItem(userId, item.id, item.quantity);
      }
    }
  }
});