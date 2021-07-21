class UnauthorizedError extends Error {
  isTreated = true
  constructor(message, details=[]) {
    super(message)
    this.message = message;
    this.details = details;
    this.statusCode = 401;
  }
}

module.exports = UnauthorizedError;