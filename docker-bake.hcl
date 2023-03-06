variable "GIT_SHA" {
  default = "latest"
}

variable "GIT_COMMIT_MESSAGE" {
  default = "No info available"
}


variable "REPO" {
  default = "registry.docker.home.stackpwn.in:80/ariang"
}

function "tag" {
  params = [tag]
  result = "${REPO}:${tag}"
}

group "default" {
  targets = ["ariang"]
}

target "ariang" {
  dockerfile = "Dockerfile"
  tags       = [
    tag("latest"),
    tag("${GIT_SHA}")
  ]
  labels = {
    changes = "${GIT_COMMIT_MESSAGE}"
    git_sha = "${GIT_SHA}"
  }
}
