const Joi = require('joi')
const { ValidationError } = require("../../custom-errors")
const lambdaWrapper = require("../../helpers/lambda-wrapper")
const createUser = require("../../repositories/users/create")

const Schema = Joi.object({
  name: Joi.string().required(),
  email: Joi.string().email().required(),
  password: Joi.string().required()
}).required()

const validateBody = (body) => {
  const { value, error } = Schema.validate(body)
  if(error) {
    throw new ValidationError(error.message, error.details)
  }

  return value;
}

const main = async (event, context, next) => {
  const data = validateBody(event.body)

  const user = await createUser(data);

  return user;
}

module.exports = {
  handler: lambdaWrapper(main)
}