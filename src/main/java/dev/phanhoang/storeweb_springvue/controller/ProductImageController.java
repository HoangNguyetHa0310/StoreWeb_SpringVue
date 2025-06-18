package dev.phanhoang.storeweb_springvue.controller;

import dev.phanhoang.storeweb_springvue.dto.ProductImageDTO;
import dev.phanhoang.storeweb_springvue.service.ProductImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product-images")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ProductImageController {

    private final ProductImageService service;

    @GetMapping("/product/{productId}")
    public List<ProductImageDTO> getByProductId(@PathVariable Long productId) {
        return service.getImagesByProductId(productId);
    }

    @PostMapping
    public ProductImageDTO add(@RequestBody ProductImageDTO dto) {
        return service.addImage(dto);
    }

    @PutMapping("/{id}")
    public ProductImageDTO update(@PathVariable Long id, @RequestBody ProductImageDTO dto) {
        return service.updateImage(id, dto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.deleteImage(id);
    }
}
