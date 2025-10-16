import api from './api'

export const productService = {
    // Get all products (no pagination)
    getProducts() {
        return api.get('/products/all')
    },

    // Get product by ID
    getProduct(id) {
        return api.get(`/products/${id}`)
    },

    // Get product by slug
    getProductBySlug(slug) {
        return api.get(`/products/slug/${slug}`)
    },

    // Create new product
    createProduct(data) {
        return api.post('/products', data)
    },

    // Update product
    updateProduct(id, data) {
        return api.put(`/products/${id}`, data)
    },

    // Delete product
    deleteProduct(id) {
        return api.delete(`/products/${id}`)
    },

    // Get featured products
    getFeaturedProducts() {
        return api.get('/products/featured')
    },

    // Get products by category
    getProductsByCategory(categoryId) {
        return api.get(`/products/category/${categoryId}`)
    }
}