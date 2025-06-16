import './assets/main.css'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap/dist/js/bootstrap.bundle.min'

import { createApp } from 'vue'
import App from './App.vue'
import { createPinia } from 'pinia'  // Import createPinia từ pinia

// Khởi tạo Pinia và thêm nó vào ứng dụng Vue
createApp(App)
    .use(createPinia())  // Sử dụng Pinia
    .mount('#app')
