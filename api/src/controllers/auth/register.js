const Joi = require('joi')
const { ValidationError } = require("../../custom-errors")
const lambdaWrapper = require("../../helpers/lambda-wrapper")
const bcrypt = require('bcryptjs')

const createUser = require("../../repositories/users/create")
const getUserByEmail = require("../../repositories/users/get-by-email")

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
  console.debug('Request register user')
  const data = validateBody(event.body)
  
  const userExist = await getUserByEmail({ 
    email: data.email 
  })

  if(userExist) {
    console.warn({
      message: "Email already exist",
      email: data.email
    })

    throw new ValidationError('User already exist')
  }

  const hashPassword = await bcrypt.hash(data.password, 8)

  const user = await createUser({
    name: data.name,
    email: data.email,
    password: hashPassword
  });

  console.info({
    message: 'Response register user',
    user
  })
  
  return {
    message: "Register with success"
  };
}

module.exports = {
  handler: lambdaWrapper(main)
}