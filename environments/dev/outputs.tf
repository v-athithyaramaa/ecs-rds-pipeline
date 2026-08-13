output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value     = module.rds.db_endpoint
  sensitive = true
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}