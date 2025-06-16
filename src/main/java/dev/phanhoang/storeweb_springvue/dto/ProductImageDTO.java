package dev.phanhoang.storeweb_springvue.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductImageDTO {
    private Long id;
    private String imageUrl;
    private String altText;
    private Boolean isPrimary;
    private Integer sortOrder;
}
