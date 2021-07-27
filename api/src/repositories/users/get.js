const AWS = require('aws-sdk')
const dynamodb = new AWS.DynamoDB.DocumentClient()

const getUser = async ({
  id
}) => {
  const dep = getUser.dependencies()

  const { Item } = await dep.dynamodb.get({
    TableName: process.env.DYNAMODB_TABLE_USERS,
    Key: {
      id
    },
  }).promise()

  return Item;
}

getUser.dependencies = () => ({
  dynamodb
})

module.exports = getUser;