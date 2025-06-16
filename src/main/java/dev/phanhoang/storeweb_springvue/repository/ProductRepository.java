package dev.phanhoang.storeweb_springvue.repository;

import dev.phanhoang.storeweb_springvue.entity.Product;
import dev.phanhoang.storeweb_springvue.entity.ProductStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Tìm theo slug
    Optional<Product> findBySlug(String slug);

    // Tìm theo SKU
    Optional<Product> findBySku(String sku);

    // Tìm theo status
    List<Product> findByStatus(ProductStatus status);

    // Tìm sản phẩm active
    Page<Product> findByStatusOrderByCreatedAtDesc(ProductStatus status, Pageable pageable);

    // Tìm theo category
    Page<Product> findByCategoryIdAndStatus(Long categoryId, ProductStatus status, Pageable pageable);

    // Tìm theo brand
    Page<Product> findByBrandIdAndStatus(Long brandId, ProductStatus status, Pageable pageable);

    // Tìm sản phẩm featured
    List<Product> findByIsFeaturedTrueAndStatus(ProductStatus status);

    // Tìm theo khoảng giá
    Page<Product> findByStatusAndPriceBetween(ProductStatus status, BigDecimal minPrice, BigDecimal maxPrice, Pageable pageable);

    // Tìm kiếm theo tên
    @Query("SELECT p FROM Product p WHERE p.status = :status AND (p.name LIKE %:keyword% OR p.description LIKE %:keyword%)")
    Page<Product> searchByKeyword(@Param("keyword") String keyword, @Param("status") ProductStatus status, Pageable pageable);

    // Tìm kiếm nâng cao
    @Query("SELECT p FROM Product p WHERE p.status = :status " +
            "AND (:categoryId IS NULL OR p.category.id = :categoryId) " +
            "AND (:brandId IS NULL OR p.brand.id = :brandId) " +
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
            "AND (:keyword IS NULL OR p.name LIKE %:keyword% OR p.description LIKE %:keyword%)")
    Page<Product> findWithFilters(@Param("status") ProductStatus status,
                                  @Param("categoryId") Long categoryId,
                                  @Param("brandId") Long brandId,
                                  @Param("minPrice") BigDecimal minPrice,
                                  @Param("maxPrice") BigDecimal maxPrice,
                                  @Param("keyword") String keyword,
                                  Pageable pageable);
}