package dev.phanhoang.storeweb_springvue.service;

import dev.phanhoang.storeweb_springvue.dto.CategoryResponseDto;
import dev.phanhoang.storeweb_springvue.dto.ProductRequestDto;
import dev.phanhoang.storeweb_springvue.dto.ProductResponseDto;
import dev.phanhoang.storeweb_springvue.entity.Category;
import dev.phanhoang.storeweb_springvue.entity.Product;
import dev.phanhoang.storeweb_springvue.exception.DuplicateResourceException;
import dev.phanhoang.storeweb_springvue.exception.ResourceNotFoundException;
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

    // Get all products (no pagination)
    @Transactional(readOnly = true)
    public List<ProductResponseDto> getAllProducts() {
        List<Product> products = productRepository.findAll();
        return products.stream()
                .map(this::convertToResponseDto)
                .collect(Collectors.toList());
    }

    // Get all products with pagination and filters
    @Transactional(readOnly = true)
    public Page<ProductResponseDto> getAllProducts(String name, Long categoryId,
                                                   Product.ProductStatus status, Pageable pageable) {
        Page<Product> products = productRepository.findProductsWithFilters(name, categoryId, status, pageable);
        return products.map(this::convertToResponseDto);
    }

    // Get product by ID
    @Transactional(readOnly = true)
    public ProductResponseDto getProductById(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + id));
        return convertToResponseDto(product);
    }

    // Get product by slug
    @Transactional(readOnly = true)
    public ProductResponseDto getProductBySlug(String slug) {
        Product product = productRepository.findBySlug(slug)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with slug: " + slug));
        return convertToResponseDto(product);
    }

    // Create new product
    public ProductResponseDto createProduct(ProductRequestDto requestDto) {
        // Validate unique constraints
        if (productRepository.existsBySlug(requestDto.getSlug())) {
            throw new DuplicateResourceException("Product with slug '" + requestDto.getSlug() + "' already exists");
        }
        if (productRepository.existsBySku(requestDto.getSku())) {
            throw new DuplicateResourceException("Product with SKU '" + requestDto.getSku() + "' already exists");
        }

        Product product = convertToEntity(requestDto);
        Product savedProduct = productRepository.save(product);
        return convertToResponseDto(savedProduct);
    }

    // Update product
    public ProductResponseDto updateProduct(Long id, ProductRequestDto requestDto) {
        Product existingProduct = productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + id));

        // Validate unique constraints (excluding current product)
        if (productRepository.existsBySlugAndIdNot(requestDto.getSlug(), id)) {
            throw new DuplicateResourceException("Product with slug '" + requestDto.getSlug() + "' already exists");
        }
        if (productRepository.existsBySkuAndIdNot(requestDto.getSku(), id)) {
            throw new DuplicateResourceException("Product with SKU '" + requestDto.getSku() + "' already exists");
        }

        updateProductFields(existingProduct, requestDto);
        Product updatedProduct = productRepository.save(existingProduct);
        return convertToResponseDto(updatedProduct);
    }

    // Delete product
    public void deleteProduct(Long id) {
        if (!productRepository.existsById(id)) {
            throw new ResourceNotFoundException("Product not found with id: " + id);
        }
        productRepository.deleteById(id);
    }

    // Get featured products
    @Transactional(readOnly = true)
    public List<ProductResponseDto> getFeaturedProducts() {
        List<Product> products = productRepository.findByIsFeaturedTrue();
        return products.stream()
                .map(this::convertToResponseDto)
                .collect(Collectors.toList());
    }

    // Get products by category
    @Transactional(readOnly = true)
    public List<ProductResponseDto> getProductsByCategory(Long categoryId) {
        List<Product> products = productRepository.findByCategoryId(categoryId);
        return products.stream()
                .map(this::convertToResponseDto)
                .collect(Collectors.toList());
    }

    // Get all products (no pagination)
    @Transactional(readOnly = true)
    public List<ProductResponseDto> getAllProductsNoPaging() {
        List<Product> products = productRepository.findAll();
        return products.stream()
                .map(this::convertToResponseDto)
                .collect(Collectors.toList());
    }

    // Helper method to convert Entity to Response DTO
    private ProductResponseDto convertToResponseDto(Product product) {
        ProductResponseDto dto = new ProductResponseDto();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setSlug(product.getSlug());
        dto.setDescription(product.getDescription());
        dto.setSku(product.getSku());
        dto.setPrice(product.getPrice());
        dto.setSalePrice(product.getSalePrice());
        dto.setStockQuantity(product.getStockQuantity());
        dto.setImageUrl(product.getImageUrl());
        dto.setStatus(product.getStatus());
        dto.setIsFeatured(product.getIsFeatured());
        dto.setCreatedAt(product.getCreatedAt());
        dto.setUpdatedAt(product.getUpdatedAt());

        if (product.getCategory() != null) {
            Category category = product.getCategory();
            CategoryResponseDto categoryDto = new CategoryResponseDto(
                category.getId(),
                category.getName(),
                category.getSlug(),
                category.getDescription(),
                category.getIsActive(),
                category.getCreatedAt()
            );
            dto.setCategory(categoryDto);
        }

        return dto;
    }

    // Helper method to convert Request DTO to Entity
    private Product convertToEntity(ProductRequestDto requestDto) {
        Product product = new Product();
        updateProductFields(product, requestDto);
        return product;
    }

    // Helper method to update product fields
    private void updateProductFields(Product product, ProductRequestDto requestDto) {
        product.setName(requestDto.getName());
        product.setSlug(requestDto.getSlug());
        product.setDescription(requestDto.getDescription());
        product.setSku(requestDto.getSku());
        product.setPrice(requestDto.getPrice());
        product.setSalePrice(requestDto.getSalePrice());
        product.setStockQuantity(requestDto.getStockQuantity());
        product.setImageUrl(requestDto.getImageUrl());
        product.setStatus(requestDto.getStatus());
        product.setIsFeatured(requestDto.getIsFeatured());

        if (requestDto.getCategoryId() != null) {
            Category category = categoryRepository.findById(requestDto.getCategoryId())
                    .orElseThrow(() -> new ResourceNotFoundException("Category not found with id: " + requestDto.getCategoryId()));
            product.setCategory(category);
        } else {
            product.setCategory(null);
        }
    }
}