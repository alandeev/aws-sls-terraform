const jwt = require('jsonwebtoken')

const generateToken = (payload) => {
  return jwt.sign(payload, process.env.SECRET_KEY_LOGIN, {
    expiresIn: '1d'
  });
}

const decryptToken = (token) => new Promise(resolve => 
  jwt.verify(token, process.env.SECRET_KEY_LOGIN, (error, decoded) => {
    resolve(error ? null : decoded)
  })
)

module.exports = {
  generateToken,
  decryptToken
};