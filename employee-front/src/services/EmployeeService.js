import axios from "axios";

const BASE_URL = "http://localhost:8080/api/v1/employees"


export default {
    getEmployees() {
        return axios.get(BASE_URL);
    },
    getEmployeeById(id) {
        return axios.get(`${BASE_URL}/${id}`);
    },
    addEmployee(employees) {
        return axios.post(`${BASE_URL}/add`, employees);
    },
    updateEmployee(employees) {
        return axios.put(`${BASE_URL}/update`, employees);
    },
    deleteEmployee(id) {
        return axios.delete(`${BASE_URL}/delete/${id}`);
    },
}