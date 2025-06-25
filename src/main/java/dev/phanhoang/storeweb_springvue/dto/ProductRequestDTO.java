package dev.phanhoang.storeweb_springvue.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ProductRequestDTO {
    @NotBlank
    @Size(max = 255)
    private String name;

    @NotBlank
    @Size(max = 255)
    private String slug;

    private String description;

    @NotBlank
    @Size(max = 100)
    private String sku;

    private Long categoryId;

    @NotNull
    @DecimalMin(value = "0.0", inclusive = false)
    private BigDecimal price;

    @DecimalMin(value = "0.0")
    private BigDecimal salePrice;

    @Min(0)
    private Integer stockQuantity = 0;

    @Size(max = 500)
    private String imageUrl;

    private String status = "ACTIVE";

    private Boolean isFeatured = false;
}