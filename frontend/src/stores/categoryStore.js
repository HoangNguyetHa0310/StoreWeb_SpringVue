import { defineStore } from 'pinia'
import { categoryService } from '@/services/categoryService'

export const useCategoryStore = defineStore('category', {
    state: () => ({
        categories: [],
        loading: false,
        error: null
    }),

    getters: {
        activeCategories: (state) => state.categories.filter(cat => cat.isActive)
    },

    actions: {
        async fetchCategories() {
            this.loading = true
            this.error = null

            try {
                const response = await categoryService.getCategories()
                this.categories = response.data
            } catch (error) {
                this.error = error.response?.data?.message || 'Failed to fetch categories'
            } finally {
                this.loading = false
            }
        }
    }
})