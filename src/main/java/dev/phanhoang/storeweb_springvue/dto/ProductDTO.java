package dev.phanhoang.storeweb_springvue.dto;

import lombok.*;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
    private Long id;
    private String name;
    private String slug;
    private String description;
    private String shortDescription;
    private String sku;
    private Long brandId;
    private Long categoryId;
    private BigDecimal price;
    private BigDecimal salePrice;
    private BigDecimal costPrice;
    private BigDecimal weight;
    private String dimensions;
    private String status;
    private Boolean isFeatured;
    private Boolean isDigital;
    private String metaTitle;
    private String metaDescription;
}
