package dev.phanhoang.storeweb_springvue.repository;

import dev.phanhoang.storeweb_springvue.entity.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BrandRepository extends JpaRepository<Brand, Long> {
    Optional<Brand> findBySlug(String slug);
    List<Brand> findByIsActiveTrueOrderByName();
}