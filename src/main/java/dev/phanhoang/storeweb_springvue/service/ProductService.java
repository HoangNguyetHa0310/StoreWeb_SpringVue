package dev.phanhoang.storeweb_springvue.service;



import dev.phanhoang.storeweb_springvue.dto.ProductDTO;
import dev.phanhoang.storeweb_springvue.dto.ProductRequestDTO;
import dev.phanhoang.storeweb_springvue.entity.Product;
import dev.phanhoang.storeweb_springvue.repository.CategoryRepository;
import dev.phanhoang.storeweb_springvue.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;

    public Page<ProductDTO> getAllProducts(String name, Long categoryId, String status, Pageable pageable) {
        Product.ProductStatus productStatus = status != null ? Product.ProductStatus.valueOf(status) : null;
        return productRepository.findByFilters(name, categoryId, productStatus, pageable)
                .map(this::convertToDTO);
    }

    public ProductDTO getProductById(Long id) {
        return convertToDTO(productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với ID: " + id)));
    }

    public ProductDTO getProductBySlug(String slug) {
        return convertToDTO(productRepository.findBySlug(slug)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với slug: " + slug)));
    }

    public ProductDTO createProduct(ProductRequestDTO request) {
        if (productRepository.findBySlug(request.getSlug()).isPresent())
            throw new RuntimeException("Slug đã tồn tại: " + request.getSlug());

        if (productRepository.findBySku(request.getSku()).isPresent())
            throw new RuntimeException("SKU đã tồn tại: " + request.getSku());

        return convertToDTO(productRepository.save(convertToEntity(request)));
    }

    public ProductDTO updateProduct(Long id, ProductRequestDTO request) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với ID: " + id));

        productRepository.findBySlug(request.getSlug())
                .filter(p -> !p.getId().equals(id))
                .ifPresent(p -> { throw new RuntimeException("Slug đã tồn tại: " + request.getSlug()); });

        productRepository.findBySku(request.getSku())
                .filter(p -> !p.getId().equals(id))
                .ifPresent(p -> { throw new RuntimeException("SKU đã tồn tại: " + request.getSku()); });

        updateFromRequest(product, request);
        return convertToDTO(productRepository.save(product));
    }

    public void deleteProduct(Long id) {
        if (!productRepository.existsById(id))
            throw new RuntimeException("Không tìm thấy sản phẩm với ID: " + id);
        productRepository.deleteById(id);
    }

    public List<ProductDTO> getFeaturedProducts() {
        return productRepository.findByIsFeaturedTrue().stream()
                .map(this::convertToDTO).collect(Collectors.toList());
    }

    public Long getLowStockCount(Integer threshold) {
        return productRepository.countLowStockProducts(threshold);
    }

    private ProductDTO convertToDTO(Product product) {
        ProductDTO dto = new ProductDTO();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setSlug(product.getSlug());
        dto.setDescription(product.getDescription());
        dto.setSku(product.getSku());
        dto.setCategoryId(product.getCategoryId());
        dto.setPrice(product.getPrice());
        dto.setSalePrice(product.getSalePrice());
        dto.setStockQuantity(product.getStockQuantity());
        dto.setImageUrl(product.getImageUrl());
        dto.setStatus(product.getStatus().name());
        dto.setIsFeatured(product.getIsFeatured());
        dto.setCreatedAt(product.getCreatedAt());
        dto.setUpdatedAt(product.getUpdatedAt());

        if (product.getCategoryId() != null) {
            categoryRepository.findById(product.getCategoryId())
                    .ifPresent(c -> dto.setCategoryName(c.getName()));
        }
        return dto;
    }

    private Product convertToEntity(ProductRequestDTO request) {
        Product product = new Product();
        updateFromRequest(product, request);
        return product;
    }

    private void updateFromRequest(Product product, ProductRequestDTO request) {
        product.setName(request.getName());
        product.setSlug(request.getSlug());
        product.setDescription(request.getDescription());
        product.setSku(request.getSku());
        product.setCategoryId(request.getCategoryId());
        product.setPrice(request.getPrice());
        product.setSalePrice(request.getSalePrice());
        product.setStockQuantity(request.getStockQuantity());
        product.setImageUrl(request.getImageUrl());
        product.setStatus(Product.ProductStatus.valueOf(request.getStatus()));
        product.setIsFeatured(request.getIsFeatured());
    }
}
