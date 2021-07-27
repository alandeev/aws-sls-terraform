const { decryptToken } = require("../utils/jwt");

const generatePolicy = (user, effect, resource) => {
  const authResponse = {
    principalId: user.id,
    context: {
      userId: user.id,
      email: user.email
    }
  }
  
  if (effect && resource) {
    const policyDocument = {
      Version: '2012-10-17',
      Statement: [{
        Action: 'execute-api:Invoke',
        Effect: effect,
        Resource: resource
      }]
    }

    authResponse.policyDocument = policyDocument;
  }

  return authResponse;
}


const main = async (event, context, callback) => {
  var token = event.authorizationToken;
  if(!token) {
    console.warn("Token not found")
    return callback(null);
  }


  const decoded = await decryptToken(token)
  if(!decoded) {
    console.warn("Token invalid")
    return callback(null)
  } 

  callback(null, generatePolicy(decoded, 'Allow', event.methodArn));
}

module.exports = {
  handler: main
}