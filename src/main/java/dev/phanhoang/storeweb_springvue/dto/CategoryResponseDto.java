package dev.phanhoang.storeweb_springvue.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class CategoryResponseDto {
    private Long id;
    private String name;
    private String slug;
    private String description;
    private Boolean isActive;
    private LocalDateTime createdAt;

    // explicit constructor matching fields used elsewhere
    public CategoryResponseDto(Long id, String name, String slug, String description, Boolean isActive, LocalDateTime createdAt) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.description = description;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }
}