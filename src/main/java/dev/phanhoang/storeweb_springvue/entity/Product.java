package dev.phanhoang.storeweb_springvue.entity;


import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Product name is required")
    @Size(max = 255, message = "Product name must not exceed 255 characters")
    @Column(nullable = false)
    private String name;

    @NotBlank(message = "Product slug is required")
    @Size(max = 255, message = "Product slug must not exceed 255 characters")
    @Column(unique = true, nullable = false)
    private String slug;

    @Column(columnDefinition = "TEXT")
    private String description;

    @NotBlank(message = "SKU is required")
    @Size(max = 100, message = "SKU must not exceed 100 characters")
    @Column(unique = true, nullable = false)
    private String sku;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal price;

    @DecimalMin(value = "0.0", message = "Sale price must be greater than or equal to 0")
    @Column(name = "sale_price", precision = 10, scale = 2)
    private BigDecimal salePrice;

    @Min(value = 0, message = "Stock quantity must be greater than or equal to 0")
    @Column(name = "stock_quantity")
    private Integer stockQuantity = 0;

    @Size(max = 500, message = "Image URL must not exceed 500 characters")
    @Column(name = "image_url")
    private String imageUrl;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private ProductStatus status = ProductStatus.ACTIVE;

    @Column(name = "is_featured")
    private Boolean isFeatured = false;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public enum ProductStatus {
        ACTIVE, INACTIVE
    }
}