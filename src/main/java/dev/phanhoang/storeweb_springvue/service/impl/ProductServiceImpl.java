package dev.phanhoang.storeweb_springvue.service.impl;

import dev.phanhoang.storeweb_springvue.dto.ProductDTO;
import dev.phanhoang.storeweb_springvue.entity.Product;
import dev.phanhoang.storeweb_springvue.repository.ProductRepository;
import dev.phanhoang.storeweb_springvue.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    private ProductDTO mapToDTO(Product product) {
        return ProductDTO.builder()
                .id(product.getId())
                .name(product.getName())
                .slug(product.getSlug())
                .description(product.getDescription())
                .shortDescription(product.getShortDescription())
                .sku(product.getSku())
                .brandId(product.getBrandId())
                .categoryId(product.getCategoryId())
                .price(product.getPrice())
                .salePrice(product.getSalePrice())
                .costPrice(product.getCostPrice())
                .weight(product.getWeight())
                .dimensions(product.getDimensions())
                .status(product.getStatus())
                .isFeatured(product.getIsFeatured())
                .isDigital(product.getIsDigital())
                .metaTitle(product.getMetaTitle())
                .metaDescription(product.getMetaDescription())
                .build();
    }

    private Product mapToEntity(ProductDTO dto) {
        return Product.builder()
                .id(dto.getId())
                .name(dto.getName())
                .slug(dto.getSlug())
                .description(dto.getDescription())
                .shortDescription(dto.getShortDescription())
                .sku(dto.getSku())
                .brandId(dto.getBrandId())
                .categoryId(dto.getCategoryId())
                .price(dto.getPrice())
                .salePrice(dto.getSalePrice())
                .costPrice(dto.getCostPrice())
                .weight(dto.getWeight())
                .dimensions(dto.getDimensions())
                .status(dto.getStatus())
                .isFeatured(dto.getIsFeatured())
                .isDigital(dto.getIsDigital())
                .metaTitle(dto.getMetaTitle())
                .metaDescription(dto.getMetaDescription())
                .build();
    }

    @Override
    public List<ProductDTO> getAllProducts() {
        return productRepository.findAll().stream().map(this::mapToDTO).collect(Collectors.toList());
    }

    @Override
    public ProductDTO getProductById(Long id) {
        return productRepository.findById(id)
                .map(this::mapToDTO)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Override
    public ProductDTO createProduct(ProductDTO dto) {
        Product product = mapToEntity(dto);
        return mapToDTO(productRepository.save(product));
    }

    @Override
    public ProductDTO updateProduct(Long id, ProductDTO dto) {
        Product existing = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        Product updated = mapToEntity(dto);
        updated.setId(existing.getId());
        return mapToDTO(productRepository.save(updated));
    }

    @Override
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
}
