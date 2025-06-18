package dev.phanhoang.storeweb_springvue.service;

import dev.phanhoang.storeweb_springvue.dto.ProductImageDTO;

import java.util.List;

public interface ProductImageService {
    List<ProductImageDTO> getImagesByProductId(Long productId);
    ProductImageDTO addImage(ProductImageDTO dto);
    ProductImageDTO updateImage(Long id, ProductImageDTO dto);
    void deleteImage(Long id);
}
