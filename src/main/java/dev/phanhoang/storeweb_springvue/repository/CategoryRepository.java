package dev.phanhoang.storeweb_springvue.repository;

import dev.phanhoang.storeweb_springvue.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    Optional<Category> findBySlug(String slug);

    List<Category> findByIsActiveTrue();

    List<Category> findByParentIsNull();

    List<Category> findByParentId(Long parentId);

    boolean existsBySlug(String slug);

    @Query("SELECT COUNT(c) > 0 FROM Category c WHERE c.slug = :slug AND c.id != :id")
    boolean existsBySlugAndIdNot(String slug, Long id);
}