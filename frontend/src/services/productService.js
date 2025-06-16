import axios from 'axios'

const API_BASE_URL = 'http://localhost:8080/api/products'

export const productService = {
    // Get all products with pagination
    getAllProducts(page = 0, size = 12, sortBy = 'createdAt', sortDir = 'desc') {
        return axios.get(`${API_BASE_URL}/products`, {
            params: { page, size, sortBy, sortDir }
        })
    },

    // Get product by ID
    getProductById(id) {
        return axios.get(`${API_BASE_URL}/products/${id}`)
    },

    // Get product by slug
    getProductBySlug(slug) {
        return axios.get(`${API_BASE_URL}/products/slug/${slug}`)
    },

    // Get featured products
    getFeaturedProducts() {
        return axios.get(`${API_BASE_URL}/products/featured`)
    },

    // Search products
    searchProducts(keyword, page = 0, size = 12) {
        return axios.get(`${API_BASE_URL}/products/search`, {
            params: { keyword, page, size }
        })
    },

    // Filter products
    filterProducts(filters = {}) {
        return axios.get(`${API_BASE_URL}/products/filter`, {
            params: filters
        })
    }
}
