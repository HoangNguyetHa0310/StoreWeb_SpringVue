package dev.phanhoang.storeweb_springvue.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {
    private Long id;
    private String name;
    private String slug;
    private String description;
    private String shortDescription;
    private String sku;
    private BigDecimal price;
    private BigDecimal salePrice;
    private String status;
    private Boolean isFeatured;
    private Boolean isDigital;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Nested objects
    private CategoryDTO category;
    private BrandDTO brand;
    private List<ProductImageDTO> images;

    // For display
    private String primaryImageUrl;
    private BigDecimal displayPrice; // sale_price if available, else price
}