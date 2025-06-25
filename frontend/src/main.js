// Import CSS
import './assets/main.css'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap/dist/js/bootstrap.bundle.min'

// Import thư viện
import { createApp } from 'vue'
import { createPinia } from 'pinia'

// Component gốc
import App from './App.vue'

// ✅ Thêm dòng này để import router
import router from './router';

// Tạo ứng dụng Vue
const app = createApp(App)

// ✅ Khởi tạo Pinia và dùng nó
const pinia = createPinia();
app.use(pinia);

// ✅ Dùng router nếu chưa có
app.use(router);

// Mount vào DOM
app.mount('#app')
