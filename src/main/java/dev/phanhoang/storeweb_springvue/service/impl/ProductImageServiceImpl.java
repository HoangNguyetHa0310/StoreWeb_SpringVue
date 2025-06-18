package dev.phanhoang.storeweb_springvue.service.impl;

import dev.phanhoang.storeweb_springvue.dto.ProductImageDTO;
import dev.phanhoang.storeweb_springvue.entity.ProductImage;
import dev.phanhoang.storeweb_springvue.repository.ProductImageRepository;
import dev.phanhoang.storeweb_springvue.service.ProductImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductImageServiceImpl implements ProductImageService {

    private final ProductImageRepository repository;

    private ProductImageDTO toDTO(ProductImage entity) {
        return ProductImageDTO.builder()
                .id(entity.getId())
                .productId(entity.getProductId())
                .imageUrl(entity.getImageUrl())
                .altText(entity.getAltText())
                .isPrimary(entity.getIsPrimary())
                .sortOrder(entity.getSortOrder())
                .build();
    }

    private ProductImage toEntity(ProductImageDTO dto) {
        return ProductImage.builder()
                .id(dto.getId())
                .productId(dto.getProductId())
                .imageUrl(dto.getImageUrl())
                .altText(dto.getAltText())
                .isPrimary(dto.getIsPrimary())
                .sortOrder(dto.getSortOrder())
                .build();
    }

    @Override
    public List<ProductImageDTO> getImagesByProductId(Long productId) {
        return repository.findByProductIdOrderBySortOrderAsc(productId)
                .stream().map(this::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public ProductImageDTO addImage(ProductImageDTO dto) {
        return toDTO(repository.save(toEntity(dto)));
    }

    @Override
    public ProductImageDTO updateImage(Long id, ProductImageDTO dto) {
        ProductImage existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy ảnh sản phẩm"));
        ProductImage updated = toEntity(dto);
        updated.setId(existing.getId());
        return toDTO(repository.save(updated));
    }

    @Override
    public void deleteImage(Long id) {
        repository.deleteById(id);
    }
}
