package dev.phanhoang.storeweb_springvue.dto;

import dev.phanhoang.storeweb_springvue.entity.Product;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductRequestDto {
    @NotBlank(message = "Product name is required")
    @Size(max = 255, message = "Product name must not exceed 255 characters")
    private String name;

    @NotBlank(message = "Product slug is required")
    @Size(max = 255, message = "Product slug must not exceed 255 characters")
    private String slug;

    private String description;

    @NotBlank(message = "SKU is required")
    @Size(max = 100, message = "SKU must not exceed 100 characters")
    private String sku;

    private Long categoryId;

    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    private BigDecimal price;

    @DecimalMin(value = "0.0", message = "Sale price must be greater than or equal to 0")
    private BigDecimal salePrice;

    @Min(value = 0, message = "Stock quantity must be greater than or equal to 0")
    private Integer stockQuantity = 0;

    @Size(max = 500, message = "Image URL must not exceed 500 characters")
    private String imageUrl;

    private Product.ProductStatus status = Product.ProductStatus.ACTIVE;

    private Boolean isFeatured = false;
}