<script>
import { Modal } from 'bootstrap';
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
    modalTitle(){
      return this.editing ? 'Edit Employee' : 'Add Employee';
    },
    buttonLabel() {
      return this.editing ? 'Update' : 'Save';
    }
  },
  methods: {
    showModal (employee ) {
      if (employee) {
        this.employeeFrom = {...employee};
        this.editing = true;
      } else {
        this.resetFrom();
      }

      console.log('1111', this.modalinstance)

      if (!this.modalinstance) {
        this.modalinstance = new Modal(document.getElementById('employeeModal'));
        console.log('222222222', this.modalinstance)

      }

      this.modalinstance.show();
    },
    saveEmployee() {
      const action = this.editing ? 'updateEmployee' : 'addEmployee';
      EmployeeService[action](this.employeeFrom).then(() => {
        this.loadEmployees();
        this.modalinstance.hide();
        this.resetFrom();
      })
    },
    loadEmployees() {
      EmployeeService.getEmployees().then((response) => {
        this.employees = response.data;
      });
    },

    deleteEmployee(id) {
      if (confirm('Bạn có chắc bạn muốn xóa nhân viên này không?')) {
        EmployeeService.deleteEmployee(id).then(this.loadEmployees);
      }
    },


    resetFrom() {
      this.employeeFrom = {
        id: null,
        firstName: "",
        lastName: "",
        email: "",
      };
      this.editing = false;
    },


  },
  mounted() {
    this.loadEmployees();
  },
};
</script>

<template>
  <div class="container mt-3">
    <button @click="showModal(null)" class="btn btn-primary">Add Employees</button>

    <table class="table table-striped mt-3">
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
            <button @click="showModal(employee)" class="btn btn-warning">Edit</button>
            <button @click="deleteEmployee(employee.id)" class="btn btn-danger">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="modal fade" id="employeeModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <div class="modal-title"> {{ modalTitle }} </div>
            <button
              class="btn-close"
              type="button"
              data-bs-dismiss="modal"
            ></button>
          </div>

          <div class="modal-body">
            <form @submit.prevent="saveEmployee" >
              <div class="mb-3">
                <label class="form-label"> First name </label>
                <input type="text" class="form-control" v-model="employeeFrom.firstName" required />
              </div>

              <div class="mb-3">
                <label class="form-label"> Last name </label>
                <input type="text" class="form-control" v-model="employeeFrom.lastName" required />
              </div>

              <div class="mb-3">
                <label class="form-label"> Email </label>
                <input type="text" class="form-control" v-model="employeeFrom.email" required />
              </div>

              <button type="submit" class="btn btn-primary">{{ buttonLabel }}</button>

            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
