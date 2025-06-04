package dev.phanhoang.storeweb_springvue.service;

import dev.phanhoang.storeweb_springvue.entity.Employee;
import dev.phanhoang.storeweb_springvue.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
public class EmployeeService {
    private final EmployeeRepository employeeRepository;

    public List<Employee> getEmployees() {
        return employeeRepository.findAll();
    }

    public Employee getEmployeeById (Long id) {
        return employeeRepository.findById(id).orElse(null);
    }

    public Employee addEmployee (Employee employee) {
        return employeeRepository.save(employee);
    }

    public Employee updateEmployee (Employee employee) {
        return employeeRepository.save(employee);
    }

    public void deleteEmployee (Long id) {
        employeeRepository.deleteById(id);
    }

}
