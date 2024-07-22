import gql from "graphql-tag";
import { useQuery, useMutation } from "@vue/apollo-composable";

export const QUERY_EMPLOYEE_LIST = gql`
  query MyQuery {
    usersList {
      items {
        __typename
        age
        dOJ
        designation
        displayName
        email
        firstName
        lastName
        salary
        id
      }
    }
  }
`;


export const useGetEmployeesQuery = () => useQuery(QUERY_EMPLOYEE_LIST);

export const useDeleteEmployeeMutation = () => {
    const { mutate: deleteEmployee } = useMutation( gql`
        mutation UserDeleteMutation($id: ID!) {
          userDelete(data: {id: $id}) {
            success
          }
    }`)

    return function(id){
      console.log(id);
        return deleteEmployee({
          id,
        },
        {
        update: (cache, { data }) => {
          console.log("data.id", data);
          if (data?.userDelete?.success) {
            const existingData = cache.readQuery({ query: QUERY_EMPLOYEE_LIST });
            if (existingData) {
              const newData = {
                usersList: {
                  ...existingData.usersList,
                  items: existingData.usersList.items.filter(employee => employee.id !== id)
                }
              };
              cache.writeQuery({ query: QUERY_EMPLOYEE_LIST, data: newData });
            }
          }
        }
      })
    }
}


export const useUpdateEmployeeMutation = () => {
  const { mutate: updateEmployee } = useMutation( gql`mutation UpdateEmployeeMutation(
    $id: ID,
    $age: Int,
    $dOJ: Date,
    $designation: String,
    $displayName: String,
    $email: String!,
    $firstName: String,
    $lastName: String,
    $salary: Int
) {
userUpdate(data: {
  id: $id,
  age: $age,
  dOJ: $dOJ,
  designation: $designation,
  displayName: $displayName,
  email: $email,
  firstName: $firstName,
  lastName: $lastName,
  salary: $salary
}) {
  id
}
}`)

  return function(employee){
      return updateEmployee(employee,
      {
      update: (cache, { data }) => {
        console.log("data.id", data);
        if (data?.userUpdate?.id) {
          const existingData = cache.readQuery({ query: QUERY_EMPLOYEE_LIST });
          if (existingData) {
            const newData = {
              usersList: {
                ...existingData.usersList,
                items: existingData.usersList.items.map(e => {
                  if(e.id === employee.id){
                    return employee
                  }
                  return e;
                })
              }
            };
            cache.writeQuery({ query: QUERY_EMPLOYEE_LIST, data: newData });
          }
        }
      }
    })
  }
}




export const useCreateEmployeeMutation = () => {
  const { mutate: createEmployee } = useMutation( gql`mutation CreateEmployeeMutation(
    $age: Int,
    $dOJ: Date,
    $designation: String,
    $displayName: String,
    $email: String!,
    $firstName: String,
    $lastName: String,
    $salary: Int
) {
userCreate(data: {
  age: $age,
  dOJ: $dOJ,
  designation: $designation,
  displayName: $displayName,
  email: $email,
  firstName: $firstName,
  lastName: $lastName,
  salary: $salary
}) {
  id
}
}`)

  return function(newEmployee){
      return createEmployee(newEmployee,
      {
      update: (cache, { data }) => {
        console.log("data.id", data);
        if (data?.userCreate?.id) {
          const existingData = cache.readQuery({ query: QUERY_EMPLOYEE_LIST });
          if (existingData) {
            const newData = {
              usersList: {
                ...existingData.usersList,
                items: existingData.usersList.items.concat({...newEmployee, id: data.userCreate.id})
              }
            };
            cache.writeQuery({ query: QUERY_EMPLOYEE_LIST, data: newData });
          }
        }
      }
    })
  }
}



export const getEmployeeDataHandlers = () => {
  const { result, loading } = useGetEmployeesQuery();
  const deleteEmployee = useDeleteEmployeeMutation();
  const updateEmployee = useUpdateEmployeeMutation();
  const createEmployee = useCreateEmployeeMutation();
  return {
    result, 
    loading,
    deleteEmployee,
    updateEmployee,
    createEmployee
  }
}