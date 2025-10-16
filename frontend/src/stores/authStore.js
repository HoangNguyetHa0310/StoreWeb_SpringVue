import { defineStore } from 'pinia';
import { authService } from '@/services/authService';
import router from '@/router';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')),
    token: localStorage.getItem('token'),
    error: null,
    loading: false,
  }),
  getters: {
    isAuthenticated: (state) => !!state.token,
  },
  actions: {
    async login(credentials) {
      this.loading = true;
      this.error = null;
      try {
        const response = await authService.login(credentials);
        // Backend trả về: { token, email, firstName, lastName }
        this.user = {
          email: response.data.email,
          firstName: response.data.firstName,
          lastName: response.data.lastName
        };
        this.token = response.data.token;
        localStorage.setItem('user', JSON.stringify(this.user));
        localStorage.setItem('token', this.token);
        router.push('/');
      } catch (err) {
        this.error = 'Login failed. Please check your credentials.';
        console.error(err);
      } finally {
        this.loading = false;
      }
    },
    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('user');
      localStorage.removeItem('token');
      router.push('/login');
    },
  },
});