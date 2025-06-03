package dev.phanhoang.storeweb_springvue.repository;

import dev.phanhoang.storeweb_springvue.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
}
