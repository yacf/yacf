import gql from "graphql-tag";

export function usersQuery(payload, fragment='') {
    return gql`
    query($first: Int, $after:String, $search:String) {
        users(first:$first, after:$after, search:$search) {
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