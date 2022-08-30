provider "aws" {
    access_key = "${var.AWS_ACESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "us-east-1"
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = "teste${var.VERS}"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  security_group_ids = [var.SG_TESTE]
}
resource "time_sleep" "wait_10_seconds" {
  depends_on = [aws_elasticache_cluster.main]

  create_duration = "10s"
}

resource "aws_instance" "main" {
	ami = var.AMI_123MILHAS
	instance_type = var.instance_type
<<<<<<< HEAD
	SSH_KEY = var.SSH_KEY
=======
	key_name = var.SSH_KEY
>>>>>>> main
	user_data = data.template_file.init.rendered
    lifecycle {
    create_before_destroy = true
    }
    tags = {
    Name = "123Milhas - Teste${var.VERS}"
    }
  depends_on = [time_sleep.wait_10_seconds]  
  }

resource "aws_eip" "lb" {
  instance = aws_instance.main.id
  vpc      = true
  tags = {
    Name = "123Milhas - Teste${var.VERS}"
  }
}
resource "cloudflare_record" "dns-teste" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "teste${var.VERS}"
  value   = "${aws_eip.lb.public_ip}"
  type    = "A"
  proxied = true
  depends_on = [aws_eip.lb]
  }  