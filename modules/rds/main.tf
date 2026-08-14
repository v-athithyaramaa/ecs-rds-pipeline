# 1. DB Subnet Group (Using name_prefix prevents collision)
resource "aws_db_subnet_group" "this" {
  name_prefix = "${var.environment}-db-subgrp-"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 2. Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name_prefix = "${var.environment}-rds-sg-"
  description = "Allow inbound traffic from within VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Micro RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  identifier_prefix      = "${var.environment}-postgres-"
  allocated_storage      = 20
  max_allocated_storage  = 20
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t4g.micro"
  db_name                = "appdb"
  username               = "postgres"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
}
