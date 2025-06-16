package dev.phanhoang.storeweb_springvue.service;

import dev.phanhoang.storeweb_springvue.dto.ProductDTO;
import dev.phanhoang.storeweb_springvue.entity.Product;
import dev.phanhoang.storeweb_springvue.entity.ProductStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;

public interface ProductService {
    Page<ProductDTO> getAllProducts(Pageable pageable);
    ProductDTO getProductById(Long id);
    ProductDTO getProductBySlug(String slug);
    ProductDTO createProduct(ProductDTO productDTO);
    ProductDTO updateProduct(Long id, ProductDTO productDTO);
    void deleteProduct(Long id);

    Page<ProductDTO> getProductsByCategory(Long categoryId, Pageable pageable);
    Page<ProductDTO> getProductsByBrand(Long brandId, Pageable pageable);
    List<ProductDTO> getFeaturedProducts();

    Page<ProductDTO> searchProducts(String keyword, Pageable pageable);
    Page<ProductDTO> filterProducts(Long categoryId, Long brandId,
                                    BigDecimal minPrice, BigDecimal maxPrice,
                                    String keyword, Pageable pageable);
}