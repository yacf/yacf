import gql from "graphql-tag";

export function categoriesQuery(payload, fragment='') {
    return gql`
    query($first:Int, $skip:Int) {
        categories(first: $first, skip: $skip) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function categoryQuery(payload, fragment='') {
    return gql`
    query($id:Int) {
        category(id: $id) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function categoriesCountQuery() {
    return gql`
    query {
        categoriesCount
      }
    `
}