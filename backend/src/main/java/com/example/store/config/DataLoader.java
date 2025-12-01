package com.example.store.config;

import com.example.store.model.Product;
import com.example.store.repository.ProductRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataLoader {

    @Bean
    CommandLineRunner init(ProductRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                repository.save(new Product(null, "Apple iPhone 14", "Apple smartphone", 799.99));
                repository.save(new Product(null, "Nike Sneakers", "Comfortable running shoes", 120.00));
                repository.save(new Product(null, "Coffee Mug", "Blue ceramic mug", 9.99));
            }
        };
    }
}
