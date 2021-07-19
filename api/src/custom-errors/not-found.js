class NotFoundError extends Error {
  isTreated = true
  constructor(message) {
    super(message)
    this.message = message;
    this.statusCode = 404;
  }
}

module.exports = NotFoundError;