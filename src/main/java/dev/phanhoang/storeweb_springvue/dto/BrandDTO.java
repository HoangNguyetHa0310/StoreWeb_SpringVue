package dev.phanhoang.storeweb_springvue.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BrandDTO {
    private Long id;
    private String name;
    private String slug;
    private String description;
    private String logoUrl;
    private String websiteUrl;
}
