import { defineStore } from 'pinia'
import { productService } from '@/services/productService'

export const useProductStore = defineStore('product', {
    state: () => ({
        products: [],
        currentProduct: null,
        featuredProducts: [],
        loading: false,
        error: null,
        pagination: {
            currentPage: 0,
            totalPages: 0,
            totalElements: 0,
            size: 12
        },
        filters: {
            keyword: '',
            categoryId: null,
            brandId: null,
            minPrice: null,
            maxPrice: null,
            sortBy: 'createdAt',
            sortDir: 'desc'
        }
    }),

    getters: {
        hasProducts: (state) => state.products.length > 0,
        isLoading: (state) => state.loading,
        getCurrentProduct: (state) => state.currentProduct,
        getFeaturedProducts: (state) => state.featuredProducts
    },

    actions: {
        async fetchProducts(page = 0) {
            this.loading = true
            this.error = null

            try {
                const response = await productService.getAllProducts(
                    page,
                    this.pagination.size,
                    this.filters.sortBy,
                    this.filters.sortDir
                )

                this.products = response.data.content
                this.pagination = {
                    currentPage: response.data.number,
                    totalPages: response.data.totalPages,
                    totalElements: response.data.totalElements,
                    size: response.data.size
                }
            } catch (error) {
                this.error = error.message
                console.error('Error fetching products:', error)
            } finally {
                this.loading = false
            }
        },

        async fetchProductById(id) {
            this.loading = true
            this.error = null

            try {
                const response = await productService.getProductById(id)
                this.currentProduct = response.data
            } catch (error) {
                this.error = error.message
                console.error('Error fetching product:', error)
            } finally {
                this.loading = false
            }
        },

        async fetchFeaturedProducts() {
            try {
                const response = await productService.getFeaturedProducts()
                this.featuredProducts = response.data
            } catch (error) {
                console.error('Error fetching featured products:', error)
            }
        },

        async searchProducts(keyword, page = 0) {
            this.loading = true
            this.filters.keyword = keyword

            try {
                const response = await productService.searchProducts(keyword, page)
                this.products = response.data.content
                this.pagination.currentPage = response.data.number
                this.pagination.totalPages = response.data.totalPages
            } catch (error) {
                this.error = error.message
            } finally {
                this.loading = false
            }
        },

        setFilters(newFilters) {
            this.filters = { ...this.filters, ...newFilters }
        },

        clearFilters() {
            this.filters = {
                keyword: '',
                categoryId: null,
                brandId: null,
                minPrice: null,
                maxPrice: null,
                sortBy: 'createdAt',
                sortDir: 'desc'
            }
        }
    }
})
