package dev.phanhoang.storeweb_springvue.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductImageDTO {
    private Long id;
    private Long productId;
    private String imageUrl;
    private String altText;
    private Boolean isPrimary;
    private Integer sortOrder;
}
