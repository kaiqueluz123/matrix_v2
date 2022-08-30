data "template_file" "init"{
template = "${file("launcher.tpl")}"
vars = {
  VERS = var.VERS
  DB_HOST   = var.DB_HOST
  DB_USER   = var.DB_USER
  DB_PASS   = var.DB_PASS
  ENV_REDIS = var.ENV_REDIS
  RESULT_PASS_DB = random_password.db_password.result
  AWS_ACESS_KEY = var.AWS_ACESS_KEY
  AWS_SECRET_KEY = var.AWS_SECRET_KEY
  CLOUDFLARE_EMAIL = var.CLOUDFLARE_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_ZONE_ID = var.CLOUDFLARE_ZONE_ID
  AMI_123MILHAS = var.AMI_123MILHAS
  SG_TESTE = var.SG_TESTE
  SSH_KEY = var.SSH_KEY
 }
}
variable "AMI_123MILHAS" {
  description     = "Imagem ami padrao 123milhas"
  type            = string
}

variable "SSH_KEY" {
  description     = "Chave SSH "
}


variable "instance_type" {
  default = "c5a.large"
}

variable "VERS" {
  description     = "Nome do ambiente/variaveis"
  type            = string
  default = "42"
}

variable "DB_HOST" {
  description     = "host do banco de dados"
}

variable "DB_USER" {
  description     = "Usuario do banco de dados"
}
variable "DB_PASS" {
  description     = "Senha do Banco de dados"
}
variable "ENV_REDIS" {
  description     = "Nome do Redis"
}

variable "SG_TESTE" {
  description     = " Security group ambiente"
}

variable "CLOUDFLARE_API_KEY" {
  description     = "token"
}
variable "CLOUDFLARE_ZONE_ID" {
  description     = "id"
}

variable "AWS_ACESS_KEY" {
  description     = "Acess AWS"
}

variable "AWS_SECRET_KEY" {
  description     = "Secret AWS"
}

variable "CLOUDFLARE_EMAIL" {
  description     = "Email"
}

