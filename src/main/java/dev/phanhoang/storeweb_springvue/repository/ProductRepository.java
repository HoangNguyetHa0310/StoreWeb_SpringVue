package dev.phanhoang.storeweb_springvue.repository;



import dev.phanhoang.storeweb_springvue.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Find by slug
    Optional<Product> findBySlug(String slug);

    // Find by SKU
    Optional<Product> findBySku(String sku);

    // Find by status
    List<Product> findByStatus(Product.ProductStatus status);

    // Find featured products
    List<Product> findByIsFeaturedTrue();

    // Find by category
    List<Product> findByCategoryId(Long categoryId);

    // Find products with pagination and search
    @Query("SELECT p FROM Product p WHERE " +
            "(:name IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :name, '%'))) AND " +
            "(:categoryId IS NULL OR p.category.id = :categoryId) AND " +
            "(:status IS NULL OR p.status = :status)")
    Page<Product> findProductsWithFilters(
            @Param("name") String name,
            @Param("categoryId") Long categoryId,
            @Param("status") Product.ProductStatus status,
            Pageable pageable
    );

    // Check if slug exists (for validation)
    boolean existsBySlug(String slug);

    // Check if SKU exists (for validation)
    boolean existsBySku(String sku);

    // Check if slug exists excluding current product id
    @Query("SELECT COUNT(p) > 0 FROM Product p WHERE p.slug = :slug AND p.id != :id")
    boolean existsBySlugAndIdNot(@Param("slug") String slug, @Param("id") Long id);

    // Check if SKU exists excluding current product id
    @Query("SELECT COUNT(p) > 0 FROM Product p WHERE p.sku = :sku AND p.id != :id")
    boolean existsBySkuAndIdNot(@Param("sku") String sku, @Param("id") Long id);

    // Find products with low stock
    @Query("SELECT p FROM Product p WHERE p.stockQuantity <= :threshold")
    List<Product> findProductsWithLowStock(@Param("threshold") Integer threshold);
}