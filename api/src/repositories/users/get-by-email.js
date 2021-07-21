const AWS = require('aws-sdk')
const dynamodb = new AWS.DynamoDB.DocumentClient()

const getUserByEmail = async ({
  email
}) => {
  const params = {
    TableName: process.env.DYNAMODB_TABLE_USERS,
    IndexName: process.env.TABLE_USERS_EMAIL_GSI,
    KeyConditionExpression: "email = :email",
    ExpressionAttributeValues: {
      ":email": email
    }
  }

  const { Items } = await dynamodb.query({
    ...params
  }).promise()

  return Items[0];
}

module.exports = getUserByEmail;