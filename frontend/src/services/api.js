import axios from 'axios'

const BASE_URL = import.meta.env.VITE_API_BASE_URL || ''

const api = axios.create({
  baseURL: BASE_URL,
  headers: { 'Content-Type': 'application/json' }
})

export default {
  async getProducts() {
    const res = await api.get('/api/products')
    return res.data
  },
  async getProduct(id) {
    const res = await api.get(`/api/products/${id}`)
    return res.data
  },
  async createProduct(product) {
    const res = await api.post('/api/products', product)
    return res.data
  }
}
