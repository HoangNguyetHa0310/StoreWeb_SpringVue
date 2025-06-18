import { createRouter, createWebHistory } from 'vue-router'
import ProductPage from '@/views/ProductPage.vue'

const routes = [
    { path: '/products', name: 'Products', component: ProductPage },
    // thêm các route khác nếu cần
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router
