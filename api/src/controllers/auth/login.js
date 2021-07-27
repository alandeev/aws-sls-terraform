const Joi = require('joi')

const { 
  ValidationError,
  UnauthorizedError
} = require("../../custom-errors")
const bcrypt = require('bcryptjs')

const lambdaWrapper = require("../../helpers/lambda-wrapper")
const getUserByEmail = require("../../repositories/users/get-by-email")
const { generateToken } = require('../../utils/jwt')

const Schema = Joi.object({
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
  const {
    email,
    password
  } = validateBody(event.body)

  const user = await getUserByEmail({ email })
  if(!user) {
    console.warn("Email não encontrado")
    throw new UnauthorizedError('Email/password is invalid')
  }

  const isPassword = await bcrypt.compare(password, user.password);
  if(!isPassword) {
    console.warn("Senha invalida")
    throw new UnauthorizedError('Email/password is invalid')
  }

  const token = generateToken({
    id: user.id,
    email: user.email
  })

  console.info({
    message: 'Response register user',
    user
  })
  
  return {
    message: "authenticated",
    token: `Bearer ${token}`
  }
}

module.exports = {
  handler: lambdaWrapper(main)
}