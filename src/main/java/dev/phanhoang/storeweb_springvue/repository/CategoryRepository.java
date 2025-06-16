package dev.phanhoang.storeweb_springvue.repository;

import dev.phanhoang.storeweb_springvue.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    Optional<Category> findBySlug(String slug);
    List<Category> findByParentIsNullAndIsActiveTrue();
    List<Category> findByParentIdAndIsActiveTrue(Long parentId);
    List<Category> findByIsActiveTrueOrderBySortOrder();
}