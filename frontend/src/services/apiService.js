import axios from 'axios';

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8080/api',
  headers: {
    'Content-Type': 'application/json'
  }
});

// --- Product Services ---
export const getProducts = () => {
  return apiClient.get('/products');
};

export const getProductById = (id) => {
  return apiClient.get(`/products/${id}`);
};

// --- Cart Services ---
export const getCart = (userId) => {
  // Cần logic xác thực, tạm thời dùng userId
  return apiClient.get(`/cart/${userId}`);
};

export const addToCart = (userId, productId, quantity) => {
  return apiClient.post(`/cart/${userId}`, { productId, quantity });
};

export const updateCartItem = (userId, cartItemId, quantity) => {
  return apiClient.put(`/cart/${userId}/items/${cartItemId}`, { quantity });
};

export const removeFromCart = (userId, cartItemId) => {
  return apiClient.delete(`/cart/${userId}/items/${cartItemId}`);
};

// --- Auth Services ---
export const login = (credentials) => apiClient.post('/auth/login', credentials);
export const register = (userData) => apiClient.post('/auth/register', userData);