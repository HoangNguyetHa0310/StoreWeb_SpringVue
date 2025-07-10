package dev.phanhoang.storeweb_springvue.dto;

import dev.phanhoang.storeweb_springvue.entity.Product;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

// DTO for Product Response
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponseDto {
    private Long id;
    private String name;
    private String slug;
    private String description;
    private String sku;
    private CategoryResponseDto category;
    private BigDecimal price;
    private BigDecimal salePrice;
    private Integer stockQuantity;
    private String imageUrl;
    private Product.ProductStatus status;
    private Boolean isFeatured;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}