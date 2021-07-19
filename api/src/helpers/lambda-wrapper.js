const {
  _construct,
  _200
} = require('./responses')

const lambdaWrapper = (fn) => {
  return async (event, context, next) => {
    
    try{      
      const body = event.body ? JSON.parse(event.body) : {}
      event.body = body;

      const result = await fn(event)
    
      return next(null, _200(result))
    }catch(error) {
      if(error.isTreated) {
        return next(null, _construct(error.statusCode, {
          status: "error",
          message: error.message,
          details: error.details || []
        }))
      }

      console.error({
        message: error.message,
        stack: error.stack
      })
      
      return next(null, _construct(500, {
        status: "error",
        message: error.message || "Internal server error"
      }))
    }
  }
}

module.exports = lambdaWrapper;