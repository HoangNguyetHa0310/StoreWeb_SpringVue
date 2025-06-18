// Import CSS
import './assets/main.css'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap/dist/js/bootstrap.bundle.min'

// Import thư viện
import { createApp } from 'vue'
import { createPinia } from 'pinia'

// Component gốc
import App from './App.vue'

// Tạo ứng dụng Vue
const app = createApp(App)

// Dùng plugin
app.use(createPinia())

// Mount vào DOM
app.mount('#app')
