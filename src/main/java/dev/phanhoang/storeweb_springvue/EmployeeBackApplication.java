package dev.phanhoang.storeweb_springvue;

import dev.phanhoang.storeweb_springvue.entity.Employee;
import dev.phanhoang.storeweb_springvue.service.EmployeeService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@RequiredArgsConstructor
public class EmployeeBackApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(dev.phanhoang.storeweb_springvue.EmployeeBackApplication.class, args);
	}

	private final EmployeeService employeeService;

	@Override
	public void run(String... args) throws Exception {
		Employee employee1 = Employee.builder()
				.firstName("Phan")
				.lastName("Hoang")
				.email("phanHoang@gmail.com")
				.build();

		Employee employee2 = Employee.builder()
				.firstName("Phan1")
				.lastName("Hoang2")
				.email("phanHoang2@gmail.com")
				.build();

	employeeService.addEmployee(employee1);
	employeeService.addEmployee(employee2);


	}

}
