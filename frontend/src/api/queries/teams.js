import gql from "graphql-tag";

export function teamsQuery(payload, fragment='') {
    return gql`
    query($first:Int, $skip:Int) {
        teams(first: $first, skip: $skip) {
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