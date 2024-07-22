<script setup lang="ts">
import { reactive } from 'vue';
import { getEmployeeDataHandlers } from './graphql/hooks';

const EMPLOYEE_OBJECT = {
        age: '',
        dOJ: '',
        designation: '',
        displayName: '',
        email: '',
        firstName: '',
        lastName: '',
        salary: '',
        id: ''
}

const state = reactive({
  employee: {...EMPLOYEE_OBJECT},
  showForm: false,
  error: false
});

const { result, loading, deleteEmployee, updateEmployee, createEmployee } = getEmployeeDataHandlers();


const handleEdit = (employeeData: any ) => {
  state.employee = {...employeeData};
  state.showForm = true;

}

const handleSubmit = (data: any) => {  
  const {id, ...employeeData } = data;
  if(id) {
    updateEmployee(data)
    .then((res: any) => {
      console.log('updateEmployee Response', res);
      state.employee = EMPLOYEE_OBJECT;
      state.showForm = false;
      state.error = false;
    })
    .catch((err: any) => {
      console.log('updateEmployee Error', err);
      state.error = err.message || 'An error occurred';
    });
  } else {
    createEmployee(employeeData)
    .then((res: any) => {
      console.log('createEmployee Response', res);
      state.employee = EMPLOYEE_OBJECT;
      state.showForm = false;
      state.error = false;
    }) 
    .catch((err: any) => {
      console.log('createEmployee Error', err);
      state.error = err.message || 'An error occurred';
    });
  }
}



  const handleDelete = (id: String) => { 
    deleteEmployee(id)
    .then((res: any) => {
      console.log('deleteEmployee Response', res);
      state.error = false;
    })
    .catch((err: any) => {
      console.log('deleteEmployee Error', err);
      state.error = err;
    });
    
  }

  const handleCancel = () => {
    state.employee = EMPLOYEE_OBJECT;
    state.showForm = false;
  }
</script>

<template>
  <div class="container pt-5">
    <div class="alert alert-danger" v-if="state.error">{{state.error}}</div>
    <div v-show="!state.showForm">
      <table width="100%" class="table table-bordered" v-if="result">
        <thead class="table-light">
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>DisplayName</th>
            <th>Email</th>
            <th>Age</th>
            <th>Designation</th>
            <th>Salary</th>
            <th>DOJ</th>
            <th>Actions</th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="employee in result.usersList.items" :key="employee.id">
            <td>{{ employee.firstName }}</td>
            <td>{{ employee.lastName }}</td>
            <td>{{ employee.displayName }}</td>
            <td>{{ employee.email }}</td>
            <td>{{ employee.age }}</td>
            <td>{{ employee.designation }}</td>
            <td>{{ employee.salary }}</td>
            <td>{{ employee.dOJ }}</td>
            <td>
              <div class="btn-group">
                <button class="btn btn-warning btn-sm" @click="handleEdit(employee)">
                  <i class="bi bi-pencil"></i>
                </button>
                <button class="btn btn-danger btn-sm" @click="handleDelete(employee.id)">
                  <i class="bi bi-trash"></i>
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <button class="btn btn-primary" @click="state.showForm=true">Add Employee</button>
    </div>

    <div class="card" v-show="state.showForm">
      <div class="card-header">
      <h3> {{ state.employee.id ? "Edit" : "Add" }} Employee </h3>
      </div>
      <div class="card-body">
        <div class="employee-form" >
      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="displayname" v-model="state.employee.displayName" />
        <label for="displayname">Display Name</label>
      </div>

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="firstname" v-model="state.employee.firstName" />
        <label for="firstname">First Name</label>
      </div>

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="lastName" v-model="state.employee.lastName" />
        <label for="lastName">Last Name</label>
      </div>

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="email" v-model="state.employee.email" />
        <label for="email">Email</label>
      </div>

      <div class="form-floating mb-3">
        <input type="number" class="form-control" id="age" v-model="state.employee.age" />
        <label for="age">Age</label>
      </div>

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="designation" v-model="state.employee.designation" />
        <label for="designation">Designation</label>
      </div>

      <div class="form-floating mb-3">
        <input type="number" class="form-control" id="salary" v-model="state.employee.salary" />
        <label for="salary">Salary</label>
      </div>

      <div class="form-floating mb-3">
        <input type="date" class="form-control" id="dOJ" v-model="state.employee.dOJ" />
        <label for="dOJ">DOJ</label>
      </div>

      <button class="btn btn-success" @click="handleSubmit(state.employee)">Submit</button>
      <button class="btn btn-secondary ms-3" @click="handleCancel" >Cancel</button>
    </div>
      </div>
    </div>

    <div v-if="loading">Loading...</div>
  </div>
</template>

<style scoped></style>