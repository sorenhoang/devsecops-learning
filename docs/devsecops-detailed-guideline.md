# 🧭 DevSecOps Roadmap - DETAILED GUIDELINE + WEEKLY PLAN

> For Backend Engineer | 6-9 months | Real-world production system

---

## 📊 OVERVIEW AT A GLANCE

| Phase | Duration | Focus | Status |
|-------|----------|-------|--------|
| **Phase 1** | 1.5-2 mo | AWS Foundation | ⬜ Not started |
| **Phase 2** | 2 mo | Terraform + CI/CD | ⬜ Not started |
| **Phase 3** | 2 mo | Kubernetes | ⬜ Not started |
| **Phase 4** | 1.5-2 mo | Security | ⬜ Not started |
| **Phase 5** | 1 mo | Integration | ⬜ Not started |
| **TOTAL** | 7.5-9 mo | Production System | ⬜ Not started |

---

---

# 🔵 PHASE 1: AWS FOUNDATION (1.5-2 tháng)

**Goal**: Hiểu cloud + infra + containers cơ bản  
**Certification**: AWS Solutions Architect Associate (SAA-C03)  
**Projects**: 2 (3-tier + Docker)

---

## 📅 WEEK-BY-WEEK BREAKDOWN

### **WEEK 1: Cloud Fundamentals + Networking**

#### Goals
- [ ] Hiểu cloud computing là gì
- [ ] Học networking cơ bản (HTTP, TLS, DNS)
- [ ] Biết AWS architecture

#### Learning (8-10h)
| Topic | Resource | Time | Notes |
|-------|----------|------|-------|
| **Cloud 101** | AWS Skill Builder (free) | 2h | IaaS, PaaS, SaaS |
| **Networking Basics** | YouTube NetworkChuck | 3h | TCP/IP, HTTP/HTTPS |
| **DNS & TLS** | AWS docs + video | 2h | Domain, certificates |
| **AWS Overview** | AWS Architecture Center | 1h | Global infrastructure |

#### Hands-on Tasks
- [ ] Watch AWS global infra explanation (10 min)
- [ ] Understand ping/traceroute (practical demo)
- [ ] Know TLS handshake process
- [ ] Draw network diagram: browser → server

#### Deliverable
📝 **1-page diagram**: Request flow from browser to database

---

### **WEEK 2: AWS Core Services Deep Dive**

#### Goals
- [ ] Master EC2, VPC, RDS, IAM basics
- [ ] Know security groups, subnets, routing

#### Learning (12-14h)
| Service | Concept | Time | Hands-on |
|---------|---------|------|----------|
| **EC2** | Instances, AMI, types | 2h | Launch instance from console |
| **VPC** | Networks, subnets, CIDR | 2h | Create custom VPC |
| **RDS** | Managed DB, backups | 2h | Create RDS instance |
| **IAM** | Users, roles, policies | 2h | Create IAM user + policy |
| **S3** | Object storage | 1h | Create bucket, upload |
| **Security Groups** | Firewall rules | 1h | Configure SG rules |
| **Route Tables** | Network routing | 1h | Setup routing |
| **NAT Gateway** | Private subnet internet | 1h | Configure NAT |

#### Hands-on Tasks (⏱️ 6-8h)
- [ ] Launch EC2 instance (< 5 min, with SSH)
- [ ] Create VPC from scratch
  - [ ] 1 public subnet
  - [ ] 1 private subnet
  - [ ] Internet Gateway
  - [ ] Route table for public
  - [ ] Security group
- [ ] Connect to EC2, install basic tools
- [ ] Create RDS instance
- [ ] Create IAM user with S3 permissions
- [ ] Test security group rules

#### Deliverable
📊 **VPC Diagram**: Show all components + connections

---

### **WEEK 3: Docker Fundamentals**

#### Goals
- [ ] Understand Docker architecture
- [ ] Write Dockerfile
- [ ] Run multi-container apps

#### Learning (10-12h)
| Topic | Resource | Time |
|-------|----------|------|
| **Docker Concepts** | Udemy (section 1-3) | 6h |
| **Dockerfile** | Docker docs + tutorial | 2h |
| **Docker Compose** | Udemy (section 4) | 2h |
| **Docker Networking** | Docker docs | 1h |

#### Hands-on Tasks (⏱️ 4-6h)
- [ ] Install Docker locally
- [ ] Run hello-world container
- [ ] Write Dockerfile for Node.js app
- [ ] Build & run image locally
- [ ] Write docker-compose.yml (app + DB)
- [ ] Run: `docker-compose up -d`
- [ ] Access app from browser
- [ ] View logs: `docker-compose logs -f`
- [ ] Stop containers: `docker-compose down`

#### Deliverable
📦 **Working Dockerfile + docker-compose.yml** (commit to git)

---

### **WEEK 4: Project 1.1 - Build 3-Tier Architecture (AWS Console)**

#### Project Overview
Deploy a **production-like 3-tier application** on AWS manually (not infrastructure-as-code yet).

```
Internet
  ↓
Internet Gateway
  ↓
ALB (public subnet) 
  ↓
EC2 instances x2 (private subnet)
  ↓
RDS (private subnet)
```

#### Tasks (⏱️ 10-15h)

**1. Network Setup (2-3h)**
- [ ] Create VPC (10.0.0.0/16)
- [ ] Create 2 public subnets (different AZs)
  - Public 1A: 10.0.1.0/24
  - Public 1B: 10.0.2.0/24
- [ ] Create 2 private subnets (different AZs)
  - Private 1A: 10.0.11.0/24
  - Private 1B: 10.0.12.0/24
- [ ] Create Internet Gateway, attach to VPC
- [ ] Create 2 NAT Gateways (one per AZ, in public subnets)
- [ ] Create route tables
  - Public: 0.0.0.0/0 → IGW
  - Private: 0.0.0.0/0 → NAT

**2. Security Setup (1-2h)**
- [ ] Create ALB Security Group
  - Inbound: HTTP (80) + HTTPS (443) from 0.0.0.0/0
  - Outbound: All
- [ ] Create App Server Security Group
  - Inbound: 3000 from ALB SG only
  - Outbound: 5432 to RDS SG + 443 to internet (patches)
- [ ] Create RDS Security Group
  - Inbound: 5432 from App SG only
  - Outbound: None needed

**3. Database Setup (2-3h)**
- [ ] Create DB subnet group (private subnets)
- [ ] Create RDS PostgreSQL instance
  - Engine: PostgreSQL 15
  - Instance: db.t3.micro
  - Multi-AZ: Yes
  - Backup: 7 days
  - Encrypted: Yes
  - Public access: **NO**
  - Security group: RDS SG
- [ ] Note down endpoint: `mydb.xxxxx.us-east-1.rds.amazonaws.com`
- [ ] Create test table

**4. Application Setup (3-4h)**
- [ ] Create EC2 Security Group
- [ ] Launch 2 EC2 instances (t3.micro)
  - AMI: Amazon Linux 2
  - Availability Zone: different AZs
  - Subnet: private subnet
  - IAM role: allow S3 read (for app code)
  - User data script:
    ```bash
    #!/bin/bash
    yum update -y
    yum install nodejs -y
    yum install git -y
    git clone https://github.com/yourrepo/app.git /app
    cd /app
    npm install
    npm start
    ```
- [ ] SSH through Bastion (or Session Manager)
- [ ] Verify app running: `curl localhost:3000`
- [ ] Check DB connection

**5. Load Balancer Setup (2-3h)**
- [ ] Create Application Load Balancer
  - Subnets: 2 public subnets
  - Security group: ALB SG
  - Port: 80 (HTTP for testing)
- [ ] Create target group
  - Protocol: HTTP
  - Port: 3000
  - Health check: GET /health
  - Interval: 30s
  - Healthy threshold: 2
- [ ] Register 2 EC2 instances
- [ ] Get ALB DNS: `my-alb-123.us-east-1.elb.amazonaws.com`

**6. Testing (1-2h)**
- [ ] Access app via ALB DNS
- [ ] Verify health checks passing
- [ ] Stop one EC2 instance → traffic goes to other
- [ ] Restart → traffic returns
- [ ] Test database operations work
- [ ] Check RDS backups configured

#### Acceptance Criteria ✅
- [ ] Access app via ALB DNS (from browser)
- [ ] Health checks 200 status
- [ ] Database connectivity working
- [ ] Can reach app from both EC2 instances
- [ ] Security groups properly configured
- [ ] No public database access
- [ ] Data persists in RDS

#### Deliverable
📸 **Screenshots**:
1. VPC diagram (AWS console)
2. ALB status (healthy targets)
3. RDS instance (encrypted, backup enabled)
4. Security group rules
5. App working (browser screenshot)

---

### **WEEK 5: Project 1.2 - Docker-ify App + AWS SAA Prep**

#### Part A: Containerize Application (3-4h)

**1. Write Dockerfile**
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install production dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Create non-root user
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser && \
    chown -R appuser:appuser /app

USER appuser

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1

CMD ["node", "index.js"]
```

**2. Write docker-compose.yml**
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_NAME: appdb
      DB_USER: postgres
      DB_PASSWORD: postgres123
    depends_on:
      - postgres
    networks:
      - app-network
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost:3000/health"]
      interval: 30s
      timeout: 3s
      retries: 3

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: postgres123
      POSTGRES_DB: appdb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - app-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:

networks:
  app-network:
```

**3. Test Locally**
- [ ] Build image: `docker build -t my-app:1.0 .`
- [ ] Run compose: `docker-compose up -d`
- [ ] Check logs: `docker-compose logs -f app`
- [ ] Test health: `curl localhost:3000/health`
- [ ] Test API: `curl localhost:3000/api/data`
- [ ] Check DB connection
- [ ] Stop: `docker-compose down`

#### Part B: AWS SAA Exam Preparation (5-8h)

| Week | Focus | Time | Action |
|------|-------|------|--------|
| **Week 5** | Services overview | 3h | Watch course sections 1-3 |
| **Week 6** | Architecture patterns | 3h | Study design patterns |
| **Week 7** | Practice exams | 4h | 2 practice exams (50q each) |
| **Week 8** | Review weak areas | 3h | Focus on low-score topics |
| **Week 9** | Final exam prep | 2h | 1 full practice exam |
| **Week 10** | Schedule exam | 1h | Book exam slot |

#### SAA Exam Topics to Focus
- [ ] EC2 (types, pricing, placement groups)
- [ ] VPC (subnets, routing, NAT, VPN)
- [ ] RDS (backups, Multi-AZ, failover)
- [ ] S3 (storage classes, encryption, versioning)
- [ ] IAM (policies, roles, permissions)
- [ ] CloudFront (CDN, distributions)
- [ ] ELB (ALB, NLB, CLB)
- [ ] Auto Scaling
- [ ] AWS Well-Architected Framework

#### Deliverable
📦 **Docker working locally** + 📝 **SAA exam scheduled**

---

### **WEEK 6-7: AWS SAA Exam Completion**

#### Tasks
- [ ] Complete SAA course (all sections)
- [ ] Take 3 practice exams
  - [ ] Score ≥ 75% on all 3
- [ ] Review low-score areas
- [ ] Take actual exam
- [ ] **Goal: PASS (720+/1000)**

#### Deliverable
🏅 **AWS Certified Solutions Architect Associate certificate**

---

## ✅ PHASE 1 COMPLETION CHECKLIST

### Knowledge
- [ ] Explain OSI model (7 layers)
- [ ] Understand TCP/IP, HTTP/HTTPS, DNS
- [ ] Know VPC architecture
- [ ] Understand security groups vs NACL
- [ ] Know RDS backup strategies
- [ ] Write Dockerfile from scratch

### Hands-on
- [ ] Launch EC2 in < 5 minutes
- [ ] Create VPC + subnets + route tables
- [ ] Deploy app to EC2
- [ ] Query RDS from EC2
- [ ] Build Docker image
- [ ] Run docker-compose stack
- [ ] Access 3-tier app via ALB

### Certification
- [ ] Pass AWS SAA exam (720+/1000)

### Time Investment
- **Learning**: 30-35 hours
- **Projects**: 15-20 hours
- **Exam prep**: 20-25 hours
- **Total**: ~65-80 hours over 6-7 weeks

---

---

# 🟣 PHASE 2: TERRAFORM + CI/CD (2 tháng)

**Goal**: Infrastructure as Code + Automation  
**Certification**: HashiCorp Terraform Associate (optional)  
**Projects**: 2 (Refactor to Terraform + GitHub Actions CI/CD)

---

## 📅 WEEK-BY-WEEK BREAKDOWN

### **WEEK 1: Terraform Fundamentals**

#### Goals
- [ ] Understand HCL syntax
- [ ] Know state management
- [ ] Grasp variables & outputs

#### Learning (8h)
| Topic | Resource | Time |
|-------|----------|------|
| **HCL Syntax** | Terraform docs | 2h |
| **Variables & Outputs** | Terraform docs + course | 2h |
| **State Management** | Terraform docs | 2h |
| **Modules Intro** | Terraform docs | 2h |

#### Hands-on Tasks
- [ ] Install Terraform locally
- [ ] Write simple VPC terraform
- [ ] Use variables.tf
- [ ] Use outputs.tf
- [ ] Run: terraform plan, apply, destroy
- [ ] Examine terraform.tfstate

#### Deliverable
📝 **Simple Terraform code**: VPC + subnet (local state)

---

### **WEEK 2: Remote State + Modules**

#### Goals
- [ ] Setup S3 backend
- [ ] Write reusable modules
- [ ] Understand module composition

#### Learning (8h)
| Topic | Resource | Time |
|-------|----------|------|
| **S3 Backend** | Terraform docs + video | 2h |
| **DynamoDB Locks** | Terraform docs | 1h |
| **Module Structure** | Terraform registry | 2h |
| **Module Variables** | Terraform docs | 1h |
| **Module Outputs** | Terraform docs | 1h |
| **Data Sources** | Terraform docs | 1h |

#### Hands-on Tasks
- [ ] Create S3 bucket for state
- [ ] Create DynamoDB table for locks
- [ ] Configure backend.tf
- [ ] Migrate state to S3
- [ ] Write VPC module
- [ ] Write EC2 module
- [ ] Test: terraform init, plan, apply

#### Deliverable
📂 **Terraform modules** (vpc, ec2, rds) + S3 backend

---

### **WEEK 3: Multi-Environment Setup**

#### Goals
- [ ] Separate dev/staging/prod
- [ ] Use workspaces OR separate directories
- [ ] Template infrastructure

#### Learning (6h)
| Topic | Resource | Time |
|-------|----------|------|
| **Workspaces** | Terraform docs | 1h |
| **Environment Pattern** | Terraform best practices | 2h |
| **Locals & Data** | Terraform docs | 1h |
| **Conditional Logic** | Terraform docs | 1h |
| **Count & for_each** | Terraform docs | 1h |

#### Hands-on Tasks
- [ ] Create environments/dev/, environments/staging/, environments/prod/
- [ ] Each has terraform.tfvars with different values
- [ ] Create root main.tf that uses modules
- [ ] Deploy to dev: smaller instances, backups disabled
- [ ] Deploy to staging: medium instances, backups 7 days
- [ ] Deploy to prod: large instances, backups 30 days, multi-AZ

#### Directory Structure
```
terraform/
├── environments/
│   ├── dev/
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── prod/
│       ├── terraform.tfvars
│       └── backend.tf
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   └── alb/
├── main.tf
├── variables.tf
└── outputs.tf
```

#### Deliverable
📊 **Multi-environment Terraform setup** (works for all 3 envs)

---

### **WEEK 4-5: Project 2.1 - Refactor to Terraform**

#### Project Overview
Convert Phase 1 manual 3-tier architecture to **complete Infrastructure as Code**.

**Duration**: 2 weeks (20-25 hours)

#### Tasks

**1. Module: VPC (3-4h)**
```hcl
# modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Public subnets
resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.environment}-public-${count.index + 1}"
  }
}

# Private subnets
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 2, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name = "${var.environment}-private-${count.index + 1}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.environment}-igw"
  }
}

# Elastic IPs for NAT
resource "aws_eip" "nat" {
  count  = length(var.availability_zones)
  domain = "vpc"
  
  tags = {
    Name = "${var.environment}-eip-${count.index + 1}"
  }
  
  depends_on = [aws_internet_gateway.main]
}

# NAT Gateways
resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = {
    Name = "${var.environment}-nat-${count.index + 1}"
  }
  
  depends_on = [aws_internet_gateway.main]
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private route tables (one per AZ for NAT)
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.environment}-private-rt-${count.index + 1}"
  }
}

resource "aws_route" "private_nat" {
  count              = length(var.availability_zones)
  route_table_id     = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id     = aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index % length(var.availability_zones)].id
}
```

**2. Module: RDS (2-3h)**
```hcl
# modules/rds/main.tf
resource "random_password" "db_password" {
  length  = 32
  special = true
}

resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.environment}-db-password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet"
  subnet_ids = var.private_subnet_ids
  
  tags = {
    Name = "${var.environment}-db-subnet"
  }
}

resource "aws_security_group" "rds" {
  name   = "${var.environment}-rds-sg"
  vpc_id = var.vpc_id
  
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.environment}-rds-sg"
  }
}

resource "aws_db_instance" "main" {
  identifier     = "${var.environment}-postgres"
  engine         = "postgres"
  engine_version = "15.3"
  instance_class = var.instance_class
  
  db_name  = var.database_name
  username = "postgres"
  password = random_password.db_password.result
  
  allocated_storage = var.allocated_storage
  storage_encrypted = true
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  
  publicly_accessible       = false
  skip_final_snapshot       = var.environment != "prod"
  final_snapshot_identifier = "${var.environment}-db-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  
  backup_retention_period = var.backup_retention_days
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"
  
  multi_az = var.environment == "prod" ? true : false
  
  tags = {
    Name = "${var.environment}-postgres"
  }
}

# Output endpoint without storing password
output "rds_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "RDS endpoint"
}

output "rds_database_name" {
  value = aws_db_instance.main.db_name
}
```

**3. Module: EC2 + ALB (4-5h)**
```hcl
# modules/alb/main.tf
resource "aws_security_group" "alb" {
  name   = "${var.environment}-alb-sg"
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.environment}-alb-sg"
  }
}

resource "aws_lb" "main" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids
  
  enable_deletion_protection = var.environment == "prod"
  
  tags = {
    Name = "${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "app" {
  name        = "${var.environment}-app-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }
  
  tags = {
    Name = "${var.environment}-app-tg"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# EC2 instances
resource "aws_security_group" "app" {
  name   = "${var.environment}-app-sg"
  vpc_id = var.vpc_id
  
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.environment}-app-sg"
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  
  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }
  
  user_data = base64encode(var.user_data_script)
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.environment}-app"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  
  vpc_zone_identifier = var.private_subnet_ids
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  target_group_arns   = [aws_lb_target_group.app.arn]
  health_check_type   = "ELB"
  health_check_grace_period = 300
  
  tag {
    key                 = "Name"
    value               = "${var.environment}-app-asg"
    propagate_launch_template = true
  }
}

output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "ALB DNS name"
}
```

**4. Root Module (main.tf)**
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  
  environment         = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "rds" {
  source = "./modules/rds"
  
  environment              = var.environment
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  app_security_group_id   = module.alb.app_security_group_id
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  database_name           = var.database_name
  backup_retention_days   = var.db_backup_retention_days
}

module "alb" {
  source = "./modules/alb"
  
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  ami_id              = data.aws_ami.amazon_linux.id
  instance_type       = var.instance_type
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  user_data_script    = file("${path.module}/user-data.sh")
}

# Data source for latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
```

**5. Environment Variables (dev/terraform.tfvars)**
```hcl
environment            = "dev"
aws_region            = "us-east-1"
availability_zones    = ["us-east-1a", "us-east-1b"]
vpc_cidr              = "10.0.0.0/16"

instance_type         = "t3.micro"
min_size              = 1
max_size              = 2
desired_capacity      = 1

db_instance_class     = "db.t3.micro"
db_allocated_storage  = 20
db_backup_retention_days = 7
database_name         = "appdb"
```

**6. Setup Remote State**
```bash
# Create S3 bucket
aws s3 mb s3://my-company-terraform-state-$(date +%s) --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket my-company-terraform-state-123456 \
  --versioning-configuration Status=Enabled

# Create DynamoDB table
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1

# Create backend.tf in each environment directory
# backend.tf:
terraform {
  backend "s3" {
    bucket         = "my-company-terraform-state-123456"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

**7. Deploy**
```bash
cd terraform/environments/dev

# Initialize
terraform init

# Plan (review changes)
terraform plan -out=tfplan

# Apply (deploy)
terraform apply tfplan

# Get outputs
terraform output alb_dns
terraform output rds_endpoint
```

#### Acceptance Criteria ✅
- [ ] Terraform code is modular
- [ ] All 3 environments can deploy independently
- [ ] Remote state working (S3 + DynamoDB)
- [ ] terraform validate passes
- [ ] terraform plan shows expected changes
- [ ] Deployment completes < 10 minutes
- [ ] ALB DNS accessible
- [ ] RDS credentials in AWS Secrets Manager
- [ ] Identical to Phase 1 manual setup

#### Deliverable
📦 **Complete IaC** for all 3 environments

---

### **WEEK 6: GitHub Actions CI/CD**

#### Goals
- [ ] Automate build & test
- [ ] Push to ECR
- [ ] Deploy to EKS (Phase 3)

#### Learning (6h)
| Topic | Resource | Time |
|-------|----------|------|
| **GitHub Actions** | GitHub docs + tutorial | 2h |
| **Workflows** | GitHub docs | 1h |
| **Secrets** | GitHub docs | 1h |
| **OIDC** | AWS docs | 1h |
| **Docker + Registry** | AWS ECR docs | 1h |

#### Hands-on Tasks
- [ ] Create GitHub Actions workflow
- [ ] Setup AWS credentials with OIDC
- [ ] Build Docker image on push
- [ ] Run tests in CI
- [ ] Push to ECR
- [ ] Test on branch → ECR tag
- [ ] Test on main → ECR latest

#### Workflow File (.github/workflows/build.yml)
```yaml
name: Build & Push

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  AWS_REGION: us-east-1
  ECR_REPOSITORY: my-app

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install & test
        run: |
          npm ci
          npm test

      - name: Configure AWS
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build & push image
        uses: docker/build-push-action@v5
        with:
          context: ./app
          push: true
          tags: |
            ${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}:${{ github.sha }}
            ${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}:latest
```

#### Deliverable
✅ **Working CI/CD pipeline** (tests + build + push)

---

### **WEEK 7: Terraform + CI/CD Integration**

#### Goals
- [ ] Plan Terraform on PR
- [ ] Apply on merge to main
- [ ] Auto-deploy infrastructure

#### Hands-on Tasks
- [ ] Add Terraform plan step to CI
- [ ] Add comment to PR with plan output
- [ ] Apply on merge to main
- [ ] Auto-deploy to dev/staging
- [ ] Test: push → terraform plan → review → merge → apply

#### Workflow Addition (.github/workflows/terraform.yml)
```yaml
name: Terraform

on:
  push:
    branches: [main]
    paths: ['terraform/**']
  pull_request:
    branches: [main]
    paths: ['terraform/**']

jobs:
  terraform:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
      pull-requests: write

    steps:
      - uses: actions/checkout@v4

      - uses: hashicorp/setup-terraform@v3

      - name: Configure AWS
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions
          aws-region: us-east-1

      - name: Terraform init (dev)
        working-directory: terraform/environments/dev
        run: terraform init

      - name: Terraform validate
        working-directory: terraform/environments/dev
        run: terraform validate

      - name: Terraform plan
        id: plan
        working-directory: terraform/environments/dev
        run: terraform plan -no-color
        continue-on-error: true

      - name: Comment PR
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v6
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '```\n${{ steps.plan.outputs.stdout }}\n```'
            })

      - name: Terraform apply (main only)
        if: github.event_name == 'push' && github.ref == 'refs/heads/main'
        working-directory: terraform/environments/dev
        run: terraform apply -auto-approve
```

#### Deliverable
🤖 **Automated infrastructure deployment** (infrastructure as code in CI/CD)

---

### **WEEK 8: Final Integration + Exam Prep**

#### Tasks
- [ ] Complete all CI/CD pipelines
- [ ] Test: code push → tests → build → push to ECR → TF plan → deploy
- [ ] Study for Terraform exam (optional)
- [ ] Take Terraform Associate exam

#### Deliverable
✅ **Full CI/CD pipeline working** + 📜 **Terraform certificate (optional)**

---

## ✅ PHASE 2 COMPLETION CHECKLIST

### Knowledge
- [ ] Explain Terraform state & remote state benefits
- [ ] Write HCL: variables, outputs, locals
- [ ] Understand modules & module composition
- [ ] Know for_each, count, conditionals
- [ ] Understand GitHub Actions workflows
- [ ] Know ECR + Docker integration

### Hands-on
- [ ] Write modules for VPC, EC2, RDS, ALB
- [ ] Deploy dev/staging/prod independently
- [ ] Modify tfvars & re-deploy (infrastructure changes)
- [ ] Destroy & re-create infrastructure
- [ ] GitHub Actions workflow builds & tests
- [ ] Docker image pushes to ECR
- [ ] terraform plan shown in PR
- [ ] terraform apply on merge

### Automation
- [ ] Deploy full infra in < 10 minutes
- [ ] CI/CD auto-tests every push
- [ ] Multi-environment management

### Time Investment
- **Learning**: 30-35 hours
- **Projects**: 25-30 hours
- **Exam (optional)**: 15 hours
- **Total**: ~70-80 hours over 8 weeks

---

---

# [Continue with PHASE 3, 4, 5...]

> **Note**: Due to length, detailed week-by-week breakdowns for Phase 3-5 follow same structure as Phase 1-2 above. See full implementation guide for complete details.

---

## 📊 OVERALL TIMELINE SUMMARY

```
Month 1     (Weeks 1-4):    Phase 1 - AWS Foundation
Month 2     (Weeks 5-8):    Phase 1 completion + Phase 2 start
Month 3     (Weeks 9-12):   Phase 2 - Terraform + CI/CD
Month 4     (Weeks 13-16):  Phase 3 - Kubernetes (part 1)
Month 5     (Weeks 17-20):  Phase 3 - Kubernetes (part 2)
Month 6     (Weeks 21-24):  Phase 4 - Security
Month 7     (Weeks 25-28):  Phase 4 completion + Phase 5 start
Month 8-9   (Weeks 29-36):  Phase 5 - Integration + refinement
```

---

## 🎯 KEY MILESTONES

| Milestone | Target Date | Criteria |
|-----------|------------|----------|
| **M1: AWS Foundation** | Week 7 | AWS SAA exam passed |
| **M2: IaC Ready** | Week 15 | Deploy dev/staging/prod with Terraform |
| **M3: K8s Cluster** | Week 20 | App running on EKS with HPA |
| **M4: Secure System** | Week 24 | Security scanning in CI/CD |
| **M5: Production Ready** | Week 36 | Complete DevSecOps system working |

---

## 💰 COST ESTIMATION

| Item | Cost | Notes |
|------|------|-------|
| AWS usage (9 months) | $200-300 | Free tier covers most |
| Exam vouchers (4) | $1,000-1,200 | SAA, CKA, Security+, Terraform |
| Online courses | $200-400 | Udemy, Linux Academy |
| **Total** | ~$1,400-1,900 | Reasonable investment |

---

## 📚 RESOURCES BY PHASE

### Phase 1
- AWS Skill Builder (free)
- Udemy: AWS SAA course (~$15)
- YouTube: NetworkChuck, Linux Academy
- Docker docs & tutorial

### Phase 2
- Terraform official docs
- HashiCorp Learn platform
- GitHub Actions docs
- Udemy courses ($15-20 each)

### Phase 3
- Kubernetes official docs
- Linux Academy: Kubernetes course
- KodeKloud practice labs
- EKS documentation

### Phase 4
- OWASP Top 10 docs
- AWS security docs
- CompTIA Security+ course
- SonarQube, Snyk, Trivy docs

### Phase 5
- All previous resources
- Production DevOps blogs
- GitHub Actions best practices
- AWS Well-Architected Framework

---

## ✅ WEEKLY CHECKLIST TEMPLATE

Use this for each week:

```
WEEK X: [PHASE - TOPIC]

Learning (target: X hours)
- [ ] Topic 1 (Xh)
- [ ] Topic 2 (Xh)
- [ ] Topic 3 (Xh)

Hands-on (target: X hours)
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

Deliverable
- [ ] [What you should have at end of week]

Time tracking
- Learning: ___h
- Hands-on: ___h
- Total: ___h
- Status: ✅ On track / ⚠️ Behind / ⛔ Blocked
```

---

## 🚀 SUCCESS TIPS

1. **Code First**: Don't just watch videos, write code every day
2. **Public Repo**: Push to GitHub, share progress
3. **Build Projects**: Complete all hands-on projects, don't skip
4. **Exams Matter**: Schedule exams in advance, don't just "study"
5. **Document**: Write README, architecture docs as you go
6. **Review Weekly**: Check off checklist, adjust pace if needed
7. **Join Community**: DevOps communities, Discord servers for support
8. **Blog About It**: Write blog posts on what you learned (forces clarity)
9. **Network**: Talk to engineers doing similar things
10. **Stay Consistent**: 10-15 hours per week is sustainable (not 40h sprint then nothing)

---

## 📞 GETTING UNSTUCK

If you're blocked:
1. **Search**: Google + Stack Overflow usually has answer
2. **Docs**: Official docs first (AWS, Terraform, K8s)
3. **Videos**: YouTube tutorial for specific error
4. **Communities**: Reddit (r/devops), Discord servers, forums
5. **Debug**: Read error messages carefully (usually tells you what's wrong)
6. **Ask**: If truly stuck > 30min, ask on forums/communities

---

## 🎓 AFTER ROADMAP

Once you complete the 9-month roadmap:

1. **Use it in production**: Apply learnings to real systems
2. **Specialize**: Pick one area (container security, service mesh, etc)
3. **Certifications+**: AWS Solutions Architect Pro, CKS
4. **Open Source**: Contribute to DevOps tools (Terraform, ArgoCD, etc)
5. **Mentor**: Help others with roadmap
6. **Stay Current**: Follow AWS blog, KubeCon talks, DevOps news

---

**Your roadmap is a marathon, not a sprint. Consistency beats intensity. Good luck! 🚀**
