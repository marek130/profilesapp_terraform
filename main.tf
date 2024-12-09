resource "aws_amplify_app" "profilesapp" {
  name                 = "profilesapp_terraform"
  repository           = var.repository
  oauth_token          = var.token
  iam_service_role_arn = var.iam_service_role_arn
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.profilesapp.id
  branch_name = var.branch_name
}

# workaround for https://github.com/hashicorp/terraform-provider-aws/issues/19870
resource "null_resource" "trigger_amplify_deployment" {
  depends_on = [aws_amplify_branch.main]

  # Force this command to be triggered every time this terraform file is ran
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws amplify start-job --app-id ${aws_amplify_app.profilesapp.id} --branch-name ${aws_amplify_branch.main.branch_name} --job-type RELEASE"
  }
}
