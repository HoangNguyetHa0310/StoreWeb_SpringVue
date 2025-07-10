<script setup>
import { useCartStore } from '@/stores/cartStore';
import { storeToRefs } from 'pinia';

const cartStore = useCartStore();
const { items, itemCount, cartTotal } = storeToRefs(cartStore);
</script>

<template>
  <div>
    <h1>Your Shopping Cart</h1>
    <div v-if="itemCount > 0">
      <ul>
        <li v-for="item in items" :key="item.productId" class="cart-item">
          <span>{{ item.name }} - {{ new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(item.price) }}</span>
          <div class="item-controls">
            <input type="number" :value="item.quantity" @change="cartStore.updateQuantity(item.productId, +$event.target.value)" min="1">
            <button @click="cartStore.removeItem(item.productId)">Remove</button>
          </div>
        </li>
      </ul>
      <h3>Total: {{ new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(cartTotal) }}</h3>
      <button>Proceed to Checkout</button>
    </div>
    <div v-else>
      <p>Your cart is empty.</p>
    </div>
  </div>
</template>

<style scoped>
.cart-item {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}
.item-controls {
  display: flex;
  gap: 10px;
}
</style>