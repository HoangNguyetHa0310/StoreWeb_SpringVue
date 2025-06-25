



import { createRouter, createWebHistory } from 'vue-router';
import ProductManager from "@/components/ProductManager.vue";
import ProductImageManager from "@/components/ProductImageManager.vue";
import ProductList from "@/components/ProductList.vue";
import ProductModal from "@/components/ProductModal.vue";

const routes = [
    { path: '/', redirect: '/products' },
    { path: '/products', name: 'Products', component: ProductList },
    { path: '/products/productModal', name: 'ProductModal', component: ProductModal },
    // bạn có thể thêm các trang khác ở đây
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
