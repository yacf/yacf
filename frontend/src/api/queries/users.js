import gql from "graphql-tag";

export function usersQuery(payload, fragment='') {
    return gql`
    query($first:Int, $skip:Int) {
        users(first: $first, skip: $skip) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function userQuery(payload, fragment='') {
    return gql`
    query($id: Int) {
        user(id: $id) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function userCountQuery() {
  return gql`
    query {
      userCount
    }
  `
}