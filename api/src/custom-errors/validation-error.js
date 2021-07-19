class ValidationError extends Error {
  isTreated = true
  constructor(message, details=[]) {
    super(message)
    this.message = message;
    this.details = details;
    this.statusCode = 400;
  }
}

module.exports = ValidationError;