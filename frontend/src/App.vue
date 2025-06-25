

<template>
  <div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
      <a class="navbar-brand" href="#">StoreWeb</a>
      <div class="collapse navbar-collapse">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <RouterLink to="/products" class="nav-link">Quản lý sản phẩm</RouterLink>
          </li>

          <li class="nav-item">
            <RouterLink to="/products/productModal" class="nav-link">Quản lý chi tiết sản phẩm</RouterLink>
          </li>

        </ul>
      </div>
    </nav>

    <div class="container mt-4">
      <RouterView />
    </div>
  </div>
</template>

<script setup>

</script>