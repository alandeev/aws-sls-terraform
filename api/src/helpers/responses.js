const _construct = (statusCode=500, body) => ({
  statusCode,
  body: JSON.stringify(body)
})

const _200 = (body) => _construct(200, body)

module.exports = {
  _construct,
  _200
}