import gql from "graphql-tag";

export function challengesQuery(payload, fragment='') {
    return gql`
    query($first:Int, $skip:Int) {
        challenges(first: $first, skip: $skip) {
          ${payload}
        }
      }
      ${fragment}
    `
}

export function challengeQuery(payload, fragment='') {
    return gql`
    query($id: Int) {
      challenge(id:$id) {
        ${payload}
      }
    }
    ${fragment}
    `
}

export function challengeCountQuery() {
    return gql`
    query {
        challengeCount
      }
    `
}