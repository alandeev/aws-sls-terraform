const { NotFoundError } = require('../../custom-errors')
const lambdaWrapper = require("../../helpers/lambda-wrapper")
const getUser = require('../../repositories/users/get')


const main = async (event) => {
  const {
    requestContext: {
      authorizer: {
        userId
      }
    }
  } = event;

  const dep = main.dependencies();

  const user = await dep.getUser({
    id: userId
  })

  if(!user) {
    console.warn("User not found")

    throw new NotFoundError("User not found")
  }

  return {
    id: user.id,
    name: user.name,
    email: user.email,
    created_at: user.created_at,
    updated_at: user.updated_at
  }
}

main.dependencies = () => ({
  getUser
})

module.exports = {
  handler: lambdaWrapper(main)
}