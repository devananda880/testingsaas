variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "instance_name" {
  description = "Name of instances"
  type        = string
  default     = "bcuisaas"
}

variable "instance_volume_size" {
  description = "volume size of instances"
  type        = number
  default     = 60
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.large"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "ovaledgechakri"
}

variable "DNS_name" {
  description = "Name of domain you want to take from aws"
  type        = string
  default     = "bcuisaas.ovaledge.net"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-03a0c45ebc70f98ea"
}

variable "security_group_name" {
  description = "name of the security group"
  type        = string
  default     = "bcuisaas"
}

############################################################
#variable "internet_gateway" {
#  description = "name of the security group"
#  type        = string
#  default     = "testingSAAS"
#}
#variable "route_table" {
#  description = "name of the security group"
#  type        = string
#  default     = "testingSAAS"
#}


###############################################################
variable "subnet1_name" {
  description = "name of the subnet1"
  type        = string
  default     = "bcuisaassubnet1"
}

variable "subnet1_cidr_block" {	
  description = "cidr block of the subnet1"
  type        = string
  default     = "10.0.50.0/24"
}

variable "subnet2_name" {
  description = "name of the subnet2"
  type        = string
  default     = "bcuisaassubnet2"
}

variable "subnet2_cidr_block" {
  description = "cidr block of the subnet2"
  type        = string
  default     = "10.0.60.0/24"
}


variable "target_group_name" {
  description = "name of the target group"
  type        = string
  default     = "bcuisaas"
}

variable "load_balancer_name" {
  description = "name of the load balancer"
  type        = string
  default     = "bcuisaas"
}

variable "WAF_ip_address_to_allow_access" {
  description = "ip address range to allow access to ovaledge app"
  type        = string
  default     = "49.37.131.46/32"
}

variable "WAF_rule_name" {
  description = "name of the WAF rule"
  type        = string
  default     = "bcuisaas"
}

variable "WAF_ipset_name" {
  description = "name of the WAF ipset"
  type        = string
  default     = "bcuisaas"
}

variable "WAF_web_acl_name" {
  description = "name of the WAF web acl"
  type        = string
  default     = "bcuisaas"
}

variable "health_check" {
   type = map(string)
   default = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "8080"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }
}


########################################### RDS #################

variable "db_name" {
  type        = string
  description = "rds mysql name to identify"
  default     = "ovaledgerds"
}

variable "db_identifier" {
  type        = string
  description = "rds mysql name to identify "
  default     = "bcuisaas"
}
variable "engine" {
  type        = string
  description = "specify mysql or aurora-mysql"
  default     = "mysql"
}
variable "db_class" {
  type        = string
  description = "RDS hardware configurations"
  default     = "db.t2.micro"
}

variable "secretmanager_name" {
  type = string
  description = "secret manager name"
  default = "bcuisaas"
}

variable "db_subnetgroupname" {
  type        = string
  description = "db subnet group name belongs to"
  default     = "bcuisaas"
}

variable "db_username" {
  type        = string
  description = "database root username"
  default     = "admin"
}

variable "db_port" {
  type        = number
  description = "port to open"
  default     = 3306
}
variable "db_region" {
  type        = string
  description = "region to deploy rds"
  default     = "us-east-2"
}
variable "engine_version" {
  type        = string
  description = "specify a engine version 5.7.34 if it is mysql aurora 5.7.mysql_aurora.2.03.2"
  default     = "5.7"
}
variable "db_allocated_storage" {
  type        = number
  description = "minimum storage"
  default     = 20
}

variable "db_backup_retention_period" {
  type        = number
  description = "backup for how many days"
  default     = 14
}

variable "oe_secret_managername" {
  type        = string
  description = "Secret manager name to create"
  default     = "bcuisaas"
}

variable "db_final_snapshot_identifier" {
  type = string
  description = "wgile destroying final snapshot identifier"
  default = "bcuisaas"
}



