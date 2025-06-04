<script>
import EmployeeService from "@/services/EmployeeService";

export default {
  data() {
    return {
      employees: [],
      employeeFrom: {
        id: null,
        firstName: "",
        lastName: "",
        email: "",
      },
      editing:false,
      modalinstance:null,
    };
  },
  computed: {
    
  },
  methods: {
    loadEmployees() {
      EmployeeService.getEmployees().then((response) => {
        this.employees = response.data;
      });
    },
  },
  mounted() {
    this.loadEmployees();
  },
};
</script>

<template>
  <div class="container mt-3">
    <button class="btn btn-primary">Add Employees</button>

    <table class="table table-stripped mt-3">
      <thead>
        <tr>
          <td>ID</td>
          <td>First name</td>
          <td>Last name</td>
          <td>Email</td>
          <td>Actions</td>
        </tr>
      </thead>

      <tbody>
        <tr v-for="employee in employees" :key="employee.id">
          <td>{{ employee.id }}</td>
          <td>{{ employee.firstName }}</td>
          <td>{{ employee.lastName }}</td>
          <td>{{ employee.email }}</td>
          <td>
            <button class="btn btn-warning">Edit</button>
            <button class="btn btn-danger">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="modal fade" id="employeeModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <div class="modal-title">Employee List</div>
            <button
              class="btn-close"
              type="button"
              data-bs-dismiss="modal"
            ></button>
          </div>

          <div class="modal-body">
            <form action="">
              <div class="mb-3">
                <label class="form-label"> First name </label>
                <input type="text" class="form-control" required />
              </div>

              <div class="mb-3">
                <label class="form-label"> Last name </label>
                <input type="text" class="form-control" required />
              </div>

              <div class="mb-3">
                <label class="form-label"> Email </label>
                <input type="text" class="form-control" required />
              </div>

              <button type="submit" class="btn btn-primary">Comfirm</button>

            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
