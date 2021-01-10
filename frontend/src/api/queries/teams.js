import gql from "graphql-tag";

export function teamsQuery(payload, fragment='') {
    return gql`
    query($first: Int, $after:String, $search:String) {
      teams(first:$first, after:$after, search:$search) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function teamNameQuery(payload, fragment='') {
    return gql`
    query($name: String) {
        teamName(name: $name) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function teamsCountQuery() {
    return gql`
    query {
        teamCount
      }
    `
}