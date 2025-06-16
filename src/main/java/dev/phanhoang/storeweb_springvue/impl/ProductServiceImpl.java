package dev.phanhoang.storeweb_springvue.service.impl;

import dev.phanhoang.storeweb_springvue.dto.ProductDTO;
import dev.phanhoang.storeweb_springvue.entity.Product;
import dev.phanhoang.storeweb_springvue.entity.ProductStatus;
import dev.phanhoang.storeweb_springvue.repository.ProductRepository;
import dev.phanhoang.storeweb_springvue.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final ModelMapper modelMapper;

    @Override
    public Page<ProductDTO> getAllProducts(Pageable pageable) {
        return productRepository.findByStatusOrderByCreatedAtDesc(ProductStatus.ACTIVE, pageable)
                .map(this::convertToDTO);
    }

    @Override
    public ProductDTO getProductById(Long id) {
        return productRepository.findById(id)
                .map(this::convertToDTO)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Override
    public ProductDTO getProductBySlug(String slug) {
        return productRepository.findBySlug(slug)
                .map(this::convertToDTO)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Override
    public ProductDTO createProduct(ProductDTO productDTO) {
        Product product = modelMapper.map(productDTO, Product.class);
        product = productRepository.save(product);
        return convertToDTO(product);
    }

    @Override
    public ProductDTO updateProduct(Long id, ProductDTO productDTO) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        modelMapper.map(productDTO, product);
        product = productRepository.save(product);
        return convertToDTO(product);
    }

    @Override
    public void deleteProduct(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        productRepository.delete(product);
    }

    @Override
    public Page<ProductDTO> getProductsByCategory(Long categoryId, Pageable pageable) {
        return productRepository.findByCategoryIdAndStatus(categoryId, ProductStatus.ACTIVE, pageable)
                .map(this::convertToDTO);
    }

    @Override
    public Page<ProductDTO> getProductsByBrand(Long brandId, Pageable pageable) {
        return productRepository.findByBrandIdAndStatus(brandId, ProductStatus.ACTIVE, pageable)
                .map(this::convertToDTO);
    }

    @Override
    public List<ProductDTO> getFeaturedProducts() {
        return productRepository.findByIsFeaturedTrueAndStatus(ProductStatus.ACTIVE)
                .stream()
                .map(this::convertToDTO)
                .toList();
    }

    @Override
    public Page<ProductDTO> searchProducts(String keyword, Pageable pageable) {
        return productRepository.searchByKeyword(keyword, ProductStatus.ACTIVE, pageable)
                .map(this::convertToDTO);
    }

    @Override
    public Page<ProductDTO> filterProducts(Long categoryId, Long brandId, BigDecimal minPrice, BigDecimal maxPrice, String keyword, Pageable pageable) {
        return productRepository.findWithFilters(ProductStatus.ACTIVE, categoryId, brandId, minPrice, maxPrice, keyword, pageable)
                .map(this::convertToDTO);
    }

    private ProductDTO convertToDTO(Product product) {
        return modelMapper.map(product, ProductDTO.class);
    }
}
