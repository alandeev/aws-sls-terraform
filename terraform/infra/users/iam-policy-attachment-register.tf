resource "aws_iam_role_policy_attachment" "register_policy_attachment" {
  role       = aws_iam_role.register_role.name
  policy_arn = aws_iam_policy.register_policy.arn

  depends_on = [
    aws_iam_policy.register_policy,
    aws_iam_role.register_role
  ]
}