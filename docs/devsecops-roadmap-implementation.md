# 🧭 DEVSECOPS ROADMAP - IMPLEMENTATION GUIDE
**For Backend Engineer | 6-9 months**

---

## 📋 QUICK SUMMARY
```
Phase 1 (1.5-2 tháng)  → AWS Foundation + Networking
Phase 2 (2 tháng)      → Terraform + CI/CD
Phase 3 (2 tháng)      → Kubernetes
Phase 4 (1.5-2 tháng)  → Security Foundation
Phase 5 (1 tháng)      → DevSecOps Integration (Final Project)
```

---

# 🔵 PHASE 1: AWS FOUNDATION + NETWORKING (1.5-2 tháng)

## 🎯 Mục tiêu
- Hiểu **cloud computing** cơ bản
- Biết **infra** gồm những gì
- Làm được các tác vụ **AWS basic** hands-on

## 📚 LEARNING PATH

### Week 1-2: Cloud Fundamentals + Networking
| Topic | Resource | Thời gian | Deliverable |
|-------|----------|----------|-------------|
| **Cloud Computing 101** | AWS Skill Builder (Free) | 3h | Hiểu IaaS/PaaS/SaaS |
| **TCP/IP, HTTP, HTTPS, DNS** | Udemy: "The Complete Networking Course" hoặc AWS Fundamentals | 8h | Vẽ diagram: request flow từ browser → server |
| **TLS/SSL, Certificates** | YouTube: NetworkChuck TLS | 2h | Biết certificate chain, handshake |

### Week 3-4: AWS Core Services
| Service | Concept | Hands-on | Time |
|---------|---------|----------|------|
| **EC2** | Compute, AMI, Security Groups, Keypairs | Launch instance, SSH, stop/start | 6h |
| **VPC** | Networks, subnets, CIDR, route tables | Create VPC, add subnets, NAT | 5h |
| **RDS** | Managed database, backups | Create DB instance, connect | 3h |
| **IAM** | Users, roles, policies, permissions | Create users, attach policies | 4h |
| **S3** | Object storage, buckets, access | Upload, versioning, bucket policy | 2h |

### Week 5: Docker Basics
| Task | Resource | Time |
|------|----------|------|
| Docker concepts | Udemy: "Docker Mastery" (section 1-3) | 6h |
| Write Dockerfile | Practice: build a simple Node app | 3h |
| Docker Compose | Practice: multi-container setup | 2h |

## 🧠 HANDS-ON PROJECTS

### Project 1.1: Build a 3-Tier Architecture (AWS Console)
**Duration**: 1 week
**Output**: Working application with ALB + EC2 + RDS

```
Internet Gateway
    ↓
ALB (Application Load Balancer)
    ↓
EC2 instances (Auto Scaling Group)
    ↓
RDS (Private subnet)
```

**Steps**:
1. Create VPC with public + private subnets (2 AZs)
2. Launch 2 EC2 instances dengan security group
3. Deploy simple backend app (Node/Python)
4. Create RDS instance di private subnet
5. Configure ALB
6. Test: load balancing + database connection

**Acceptance Criteria**:
- [ ] ALB resolves to EC2 instances
- [ ] EC2 dapat query RDS
- [ ] Health check working
- [ ] Database accessible from app

---

### Project 1.2: Docker-ify Your App
**Duration**: 3 days
**Output**: Docker image + docker-compose

```dockerfile
# Dockerfile example
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
```

**Steps**:
1. Viết Dockerfile cho backend app của bạn
2. Build image, test locally
3. Write docker-compose.yml (app + database)
4. Chạy full stack locally: `docker-compose up`

**Acceptance Criteria**:
- [ ] App chạy trong container
- [ ] Database connection working
- [ ] Logs visible
- [ ] Can stop/start containers

---

## 🎓 CERTIFICATION TRACK

### AWS Certified Solutions Architect – Associate
- **Exam code**: SAA-C03
- **Duration**: 130 minutes
- **Cost**: $150 USD
- **Pass score**: 720/1000

**Study materials**:
- Udemy: "Ultimate AWS Certified Solutions Architect Associate" (30h)
- AWS Skill Builder: SAA practice exams
- ExamTopics (review, not primary source)

**Timeline**: 
- Week 1-3: Learn AWS services
- Week 4: Practice exams
- Week 5: Review weak areas
- Week 6: Schedule & take exam

---

## ✅ PHASE 1 COMPLETION CHECKLIST

### Knowledge Checkpoints
- [ ] Explain OSI model (7 layers)
- [ ] Draw VPC topology: public + private subnets
- [ ] Explain security group vs NACL
- [ ] Understand IAM policy structure
- [ ] Explain RDS backup strategies
- [ ] Write Dockerfile from scratch

### Hands-on Checkpoints
- [ ] Launch EC2 instance từ console (< 5 phút)
- [ ] Create VPC + subnets + route table
- [ ] Deploy app to EC2
- [ ] Query RDS from EC2
- [ ] Build Docker image
- [ ] Run docker-compose stack locally

### Exam Checkpoint
- [ ] Score 80%+ on 3 SAA practice exams
- [ ] Pass official SAA exam

---

---

# 🟣 PHASE 2: TERRAFORM + CI/CD (2 tháng)

## 🎯 Mục tiêu
- Viết **infra bằng code** (Infrastructure as Code)
- Automate **deployment** với CI/CD
- Manage **multiple environments** (dev/staging/prod)

## 📚 LEARNING PATH

### Week 1-2: Terraform Fundamentals
| Topic | Resource | Time | Deliverable |
|-------|----------|------|-------------|
| **HCL syntax** | Terraform docs + tutorial | 4h | Write variable, output, locals |
| **State management** | Terraform state docs | 3h | Understand `.tfstate` file |
| **Remote state (S3)** | AWS + Terraform docs | 3h | Setup S3 backend |
| **Modules** | Terraform modules registry | 4h | Write reusable module |

### Week 3: CI/CD Basics
| Topic | Resource | Time |
|------|----------|------|
| **GitHub Actions** | Official docs + tutorial | 5h |
| **Workflows** | Practice: build + test + deploy | 4h |
| **Secrets management** | GitHub Secrets | 2h |

### Week 4: Advanced Terraform
| Topic | Task | Time |
|-------|------|------|
| **Environment separation** | Create dev/staging/prod | 5h |
| **State locking** | DynamoDB state lock | 2h |
| **Terraform validation** | `terraform validate`, `terraform plan` | 2h |

---

## 🧠 HANDS-ON PROJECTS

### Project 2.1: Refactor Phase 1 Architecture to Terraform
**Duration**: 2 weeks
**Output**: Complete IaC for 3-tier architecture

**Directory Structure**:
```
terraform/
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── rds/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── alb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf (root)
├── variables.tf
├── outputs.tf
├── backend.tf (S3 + DynamoDB)
└── terraform.tfvars
```

**Modules to create**:

#### Module 1: VPC
```hcl
# modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  
  tags = {
    Name = var.environment
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 2, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# NAT Gateway
resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}
```

#### Module 2: EC2 (Auto Scaling)
```hcl
# modules/ec2/main.tf
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

  tag {
    key                 = "Name"
    value               = "${var.environment}-app-asg"
    propagate_launch_template = true
  }
}
```

#### Module 3: RDS
```hcl
# modules/rds/main.tf
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-db-subnet"
  }
}

resource "aws_db_instance" "main" {
  identifier     = "${var.environment}-db"
  engine         = "postgres"
  engine_version = "15.3"
  instance_class = var.instance_class

  db_name  = var.database_name
  username = var.master_username
  password = var.master_password

  allocated_storage = var.allocated_storage
  storage_encrypted = true

  db_subnet_group_name            = aws_db_subnet_group.main.name
  vpc_security_group_ids          = [aws_security_group.rds.id]
  publicly_accessible             = false
  skip_final_snapshot             = var.environment != "prod"
  final_snapshot_identifier       = "${var.environment}-db-snapshot"
  backup_retention_period         = var.backup_retention_days
  multi_az                        = var.environment == "prod"

  tags = {
    Name = "${var.environment}-db"
  }
}
```

#### Module 4: ALB
```hcl
# modules/alb/main.tf
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
```

**Root Module (main.tf)**:
```hcl
# main.tf
module "vpc" {
  source = "./modules/vpc"

  environment          = var.environment
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"

  environment         = var.environment
  private_subnet_ids  = module.vpc.private_subnet_ids
  ami_id              = data.aws_ami.amazon_linux.id
  instance_type       = var.instance_type
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
}

module "rds" {
  source = "./modules/rds"

  environment         = var.environment
  private_subnet_ids  = module.vpc.private_subnet_ids
  vpc_id              = module.vpc.vpc_id
  instance_class      = var.db_instance_class
  allocated_storage   = var.db_allocated_storage
  database_name       = var.database_name
  master_username     = var.master_username
  master_password     = var.master_password
}

module "alb" {
  source = "./modules/alb"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
}
```

**Environment-specific variables** (dev/staging/prod):
```hcl
# environments/dev/terraform.tfvars
environment            = "dev"
vpc_cidr              = "10.0.0.0/16"
instance_type         = "t3.micro"
min_size              = 1
max_size              = 2
desired_capacity      = 1
db_instance_class     = "db.t3.micro"
db_allocated_storage  = 20

# environments/prod/terraform.tfvars
environment            = "prod"
vpc_cidr              = "10.0.0.0/16"
instance_type         = "t3.small"
min_size              = 2
max_size              = 6
desired_capacity      = 3
db_instance_class     = "db.t3.small"
db_allocated_storage  = 100
```

**Remote State Setup** (backend.tf):
```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "devsecops/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

**Setup commands**:
```bash
# 1. Create S3 bucket for state
aws s3 mb s3://my-terraform-state --region us-east-1
aws s3api put-bucket-versioning --bucket my-terraform-state --versioning-configuration Status=Enabled

# 2. Create DynamoDB table for locking
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1

# 3. Initialize Terraform
cd environments/dev
terraform init
terraform plan
terraform apply

# 4. Deploy to staging/prod
cd ../staging
terraform init
terraform plan
terraform apply
```

**Acceptance Criteria**:
- [ ] Terraform code is modular (separate modules for each component)
- [ ] Remote state configured with S3 + DynamoDB
- [ ] Can deploy dev/staging/prod with different tfvars
- [ ] terraform validate passes
- [ ] terraform plan shows expected changes
- [ ] Full infrastructure deploys in < 5 minutes
- [ ] Output shows ALB DNS, RDS endpoint, EC2 IDs
- [ ] Infrastructure identical to Phase 1 manual setup

---

### Project 2.2: CI/CD Pipeline with GitHub Actions
**Duration**: 1.5 weeks
**Output**: Automated build, test, and deploy workflow

**Workflow structure**:
```
code push
    ↓
GitHub Actions triggered
    ↓
Build docker image
    ↓
Run tests
    ↓
Push to ECR
    ↓
Deploy to Kubernetes (Phase 3)
```

**GitHub Actions Workflow**:
```yaml
# .github/workflows/deploy.yml
name: Build & Deploy

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  AWS_REGION: us-east-1
  ECR_REPOSITORY: my-app
  IMAGE_TAG: ${{ github.sha }}

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions-role
          role-session-name: github-actions
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build & push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: ${{ github.event_name == 'push' && github.ref == 'refs/heads/main' }}
          tags: |
            ${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}:${{ env.IMAGE_TAG }}
            ${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max

      - name: Run tests
        run: |
          docker run --rm \
            ${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}:${{ env.IMAGE_TAG }} \
            npm test

  deploy:
    needs: build
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Deploy to prod
        env:
          KUBECONFIG: ${{ secrets.KUBECONFIG }}
        run: |
          kubectl set image deployment/my-app \
            my-app=${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}:${{ env.IMAGE_TAG }} \
            --record

      - name: Verify deployment
        run: |
          kubectl rollout status deployment/my-app -n default --timeout=5m
```

**Acceptance Criteria**:
- [ ] GitHub Actions workflow triggers on push/PR
- [ ] Docker image builds successfully
- [ ] Tests run in CI
- [ ] Image pushed to ECR
- [ ] Can deploy to multiple environments (dev/staging)
- [ ] Deployment history tracked

---

## 🎓 CERTIFICATION TRACK

### HashiCorp Certified: Terraform Associate (Optional)
- **Exam code**: HashiCorp Certified: Terraform Associate
- **Duration**: 60 minutes
- **Cost**: $70 USD
- **Pass score**: 70%

**Study materials**:
- Terraform Official Docs
- Udemy: "Terraform Associate Certification" (20h)
- Practice exam: ExamTopics

---

## ✅ PHASE 2 COMPLETION CHECKLIST

### Knowledge Checkpoints
- [ ] Explain Terraform state & why remote state matters
- [ ] Write module for VPC, EC2, RDS
- [ ] Explain different variable types (string, map, list, object)
- [ ] Understand data sources vs resources
- [ ] Explain `for_each` and `count`
- [ ] GitHub Actions workflow concepts

### Hands-on Checkpoints
- [ ] Create Terraform workspace for dev/staging/prod
- [ ] Deploy 3-tier architecture using Terraform
- [ ] Modify tfvars and re-deploy (infrastructure changes)
- [ ] Destroy infrastructure with `terraform destroy`
- [ ] Write GitHub Actions workflow
- [ ] Push code & see CI/CD pipeline run
- [ ] Docker image builds and tests pass

### Automation Checkpoints
- [ ] Can deploy entire infra to new AWS region in < 10 minutes
- [ ] CI/CD pipeline auto-tests on every push
- [ ] Multiple environments managed with same Terraform code

---

---

# 🔵 PHASE 3: KUBERNETES (2 tháng)

## 🎯 Mục tiêu
- Deploy application trên **Kubernetes**
- Manage **scaling**, **updates**, **rollbacks**
- Understand **cluster operations**

## 📚 LEARNING PATH

### Week 1-2: Kubernetes Fundamentals
| Topic | Resource | Time | Deliverable |
|-------|----------|------|-------------|
| **K8s architecture** | Kubernetes docs + LFS201 | 6h | Draw control plane + nodes |
| **Pods, Deployments, Services** | Kubernetes tutorial | 8h | Deploy app, expose via LB |
| **ConfigMaps, Secrets** | Kubernetes docs | 4h | Manage configs externally |
| **Volumes, Persistent Volumes** | Kubernetes storage | 4h | Mount volumes to pods |

### Week 3: Advanced Kubernetes
| Topic | Task | Time |
|-------|------|------|
| **StatefulSets** | Deploy database cluster | 3h |
| **Ingress** | Route traffic by hostname | 3h |
| **Network Policies** | Restrict pod communication | 3h |
| **RBAC** | Role-based access control | 3h |

### Week 4: Cluster Management
| Topic | Task | Time |
|-------|------|------|
| **EKS (AWS Kubernetes)** | Create managed K8s cluster | 5h |
| **Helm** | Package manager for K8s | 5h |
| **Observability** | Logs, metrics, monitoring | 3h |

---

## 🧠 HANDS-ON PROJECTS

### Project 3.1: Deploy Application on Local Kubernetes (minikube/Kind)
**Duration**: 1 week
**Output**: Multi-container app running on K8s locally

**Setup**:
```bash
# Install kind or minikube
curl -L https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 -o kind
chmod +x kind
./kind create cluster --name devsecops

# Verify
kubectl get nodes
kubectl get pods -A
```

**Kubernetes manifests**:

#### 1. Namespace
```yaml
# k8s/namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: devsecops
```

#### 2. ConfigMap (Database credentials)
```yaml
# k8s/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: devsecops
data:
  DB_HOST: postgres.devsecops.svc.cluster.local
  DB_PORT: "5432"
  DB_NAME: appdb
  APP_ENV: production
```

#### 3. Secret (Sensitive data)
```yaml
# k8s/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
  namespace: devsecops
type: Opaque
stringData:
  DB_PASSWORD: yourpassword
  JWT_SECRET: yoursecret
```

#### 4. PostgreSQL Deployment
```yaml
# k8s/postgres-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  namespace: devsecops
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:15-alpine
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secret
              key: DB_PASSWORD
        - name: POSTGRES_DB
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: DB_NAME
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

#### 5. PostgreSQL Service
```yaml
# k8s/postgres-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: postgres
  namespace: devsecops
spec:
  selector:
    app: postgres
  ports:
  - port: 5432
    targetPort: 5432
  type: ClusterIP
```

#### 6. Application Deployment (Rolling Update)
```yaml
# k8s/app-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: devsecops
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "3000"
        prometheus.io/path: "/metrics"
    spec:
      containers:
      - name: my-app
        image: my-app:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 3000
          name: http
        env:
        - name: DB_HOST
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: DB_HOST
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secret
              key: DB_PASSWORD
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 10
          periodSeconds: 5
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - my-app
              topologyKey: kubernetes.io/hostname
```

#### 7. Application Service (LoadBalancer)
```yaml
# k8s/app-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app
  namespace: devsecops
spec:
  selector:
    app: my-app
  ports:
  - port: 80
    targetPort: 3000
  type: LoadBalancer
```

#### 8. Ingress (Multiple services)
```yaml
# k8s/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: devsecops
spec:
  ingressClassName: nginx
  rules:
  - host: app.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
```

**Deployment commands**:
```bash
# Apply manifests
kubectl apply -f k8s/

# Check status
kubectl get all -n devsecops
kubectl get pods -n devsecops -w
kubectl describe pod <pod-name> -n devsecops

# Get logs
kubectl logs deployment/my-app -n devsecops
kubectl logs deployment/my-app -n devsecops --tail=50 -f

# Scale deployment
kubectl scale deployment my-app --replicas=5 -n devsecops

# Rolling update
kubectl set image deployment/my-app my-app=my-app:v2 -n devsecops --record

# Check rollout history
kubectl rollout history deployment/my-app -n devsecops

# Rollback if needed
kubectl rollout undo deployment/my-app -n devsecops

# Port forward to test locally
kubectl port-forward svc/my-app 3000:80 -n devsecops
```

**Acceptance Criteria**:
- [ ] All pods running successfully
- [ ] App accessible via LoadBalancer
- [ ] Database connection working
- [ ] ConfigMap and Secret injected correctly
- [ ] Probes (liveness/readiness) passing
- [ ] Can scale replicas
- [ ] Rolling update working
- [ ] Logs accessible
- [ ] Rollback successful

---

### Project 3.2: Deploy on AWS EKS (Production-like)
**Duration**: 1.5 weeks
**Output**: EKS cluster with autoscaling, monitoring

**Create EKS cluster** (using eksctl or Terraform):

```bash
# Using eksctl (simplest)
eksctl create cluster \
  --name devsecops \
  --region us-east-1 \
  --version 1.28 \
  --nodegroup-name worker-nodes \
  --node-type t3.medium \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 10

# Update kubeconfig
aws eks update-kubeconfig --name devsecops --region us-east-1
```

**Or with Terraform** (for IaC):
```hcl
# modules/eks/main.tf
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = "1.28"

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids

  instance_types = [var.instance_type]
  
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [aws_iam_role_policy_attachment.node_policy]
}
```

**Install Helm & Deploy apps**:
```bash
# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Add Helm repos
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install nginx-ingress
helm install nginx-ingress bitnami/nginx-ingress \
  --namespace ingress-nginx \
  --create-namespace

# Install Prometheus + Grafana
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace

# Deploy application from ECR
kubectl set image deployment/my-app my-app=<ECR_URI>/my-app:latest -n devsecops
```

**Auto Scaling**:
```yaml
# k8s/hpa.yaml (Horizontal Pod Autoscaler)
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-app-hpa
  namespace: devsecops
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

**Acceptance Criteria**:
- [ ] EKS cluster created (2+ nodes)
- [ ] Application deployed to EKS
- [ ] Ingress controller installed
- [ ] HPA working (test with load)
- [ ] Monitoring set up (Prometheus + Grafana)
- [ ] Can access app via Ingress
- [ ] Pods scale up under load

---

## 🎓 CERTIFICATION TRACK

### Certified Kubernetes Administrator (CKA)
- **Exam code**: CKA
- **Duration**: 2 hours
- **Cost**: $395 USD
- **Pass score**: 66%
- **Hands-on**: 17-19 practical problems

**Study materials**:
- Linux Academy: "Kubernetes the Hard Way"
- Udemy: "Certified Kubernetes Administrator (CKA)" (40h)
- Practice labs: KodeKloud

**Timeline**:
- Week 1-2: Learn basics
- Week 3: Advanced topics
- Week 4-5: Practice labs
- Week 6: Mock exams + review

---

## ✅ PHASE 3 COMPLETION CHECKLIST

### Knowledge Checkpoints
- [ ] Explain Pod, Deployment, Service, Ingress
- [ ] Difference between ClusterIP, NodePort, LoadBalancer
- [ ] What is ConfigMap vs Secret
- [ ] Explain liveness & readiness probes
- [ ] How rolling updates work
- [ ] RBAC concepts (Role, RoleBinding, ClusterRole)

### Hands-on Checkpoints
- [ ] Deploy app locally on minikube/kind
- [ ] Create ConfigMaps and Secrets
- [ ] Deploy database (PostgreSQL) on K8s
- [ ] Expose app via Service
- [ ] Set up Ingress
- [ ] Scale deployment
- [ ] Rolling update with zero downtime
- [ ] View logs & debug pods
- [ ] Deploy on AWS EKS
- [ ] Set up HPA (auto-scaling)
- [ ] Monitor with Prometheus + Grafana

### Verification
- [ ] Can go from code to deployed app in < 15 minutes
- [ ] Understand resource requests/limits
- [ ] Can troubleshoot pod issues

---

---

# 🔴 PHASE 4: SECURITY FOUNDATION (1.5-2 tháng)

## 🎯 Mục tiêu
- Hiểu **security fundamentals**
- Apply security **best practices** trong infra
- Implement **IAM**, **secrets management**, **scanning**

## 📚 LEARNING PATH

### Week 1: Security Fundamentals
| Topic | Resource | Time | Deliverable |
|-------|----------|------|-------------|
| **OWASP Top 10** | OWASP website + YouTube videos | 6h | Understand each vulnerability |
| **Encryption (symmetric/asymmetric)** | Cybrary course | 4h | Know TLS, certificates |
| **Authentication vs Authorization** | Security+  course | 3h | Implement in app |
| **Secure coding** | OWASP Secure Coding | 3h | Code review checklist |

### Week 2: AWS Security
| Topic | Task | Time |
|-------|------|------|
| **IAM best practices** | Apply least privilege | 4h |
| **Secrets management** | AWS Secrets Manager | 3h |
| **VPC security** | Security groups, NACLs | 3h |
| **S3 security** | Bucket policies, encryption | 2h |
| **Encryption at rest/transit** | EBS, S3, RDS encryption | 3h |

### Week 3: DevSecOps Tools
| Tool | Purpose | Time |
|------|---------|------|
| **SonarQube** | Code quality + security | 4h |
| **Snyk** | Dependency scanning | 3h |
| **TFLint** | Terraform linting | 2h |
| **Trivy** | Container vulnerability scanning | 3h |

### Week 4: Apply Security in Practice
| Task | Deliverable | Time |
|------|-------------|------|
| **Secure Terraform code** | Remove hardcoded secrets | 5h |
| **Secure K8s manifests** | Network policies, RBAC | 5h |
| **Integrate scanning in CI/CD** | SonarQube + Snyk in GitHub Actions | 5h |

---

## 🧠 HANDS-ON PROJECTS

### Project 4.1: Secure Terraform Code
**Duration**: 1 week
**Output**: IaC with security best practices

**Secure patterns**:

#### 1. Secrets Management (AWS Secrets Manager)
```hcl
# modules/rds/main.tf
# Generate random password
resource "random_password" "db_password" {
  length  = 32
  special = true
}

# Store in Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.environment}-db-password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

# RDS uses the secret
resource "aws_db_instance" "main" {
  # ... other config ...
  password = random_password.db_password.result
}
```

#### 2. Private Database (No Public Access)
```hcl
resource "aws_db_instance" "main" {
  # ... other config ...
  publicly_accessible = false  # ✅ Private only
  
  vpc_security_group_ids = [aws_security_group.rds_private.id]
}

resource "aws_security_group" "rds_private" {
  name = "${var.environment}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_servers.id]  # Only app servers
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### 3. IAM Least Privilege (EC2 to RDS)
```hcl
# Create IAM role for EC2
resource "aws_iam_role" "app_role" {
  name = "${var.environment}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Policy: only read RDS secrets
resource "aws_iam_policy" "app_secrets_policy" {
  name = "${var.environment}-app-secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          aws_secretsmanager_secret.db_password.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_secrets" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.app_secrets_policy.arn
}

# Attach role to EC2
resource "aws_iam_instance_profile" "app" {
  name = "${var.environment}-app-profile"
  role = aws_iam_role.app_role.name
}
```

#### 4. Encryption at Rest (EBS, RDS, S3)
```hcl
# EBS encryption
resource "aws_launch_template" "app" {
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 30
      volume_type           = "gp3"
      encrypted             = true  # ✅ Enable encryption
      delete_on_termination = true
    }
  }
}

# RDS encryption
resource "aws_db_instance" "main" {
  # ... other config ...
  storage_encrypted = true  # ✅ Enable encryption
  kms_key_id        = aws_kms_key.rds.arn
}

# KMS key for RDS
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# S3 encryption
resource "aws_s3_bucket" "logs" {
  bucket = "${var.environment}-app-logs"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

#### 5. VPC & Network Security
```hcl
# Deny all by default
resource "aws_security_group" "app_servers" {
  name = "${var.environment}-app-sg"

  # Only allow from ALB
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # Only outbound to RDS + internet (patches)
  egress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.rds_private.id]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTPS only
  }
}
```

**Checklist**:
- [ ] No hardcoded passwords/secrets
- [ ] Database is private (no public access)
- [ ] IAM roles follow least privilege
- [ ] Encryption enabled for all data stores
- [ ] Security groups deny by default
- [ ] VPC has private subnets for DBs
- [ ] KMS keys configured for encryption
- [ ] Secrets stored in AWS Secrets Manager

---

### Project 4.2: Secure Kubernetes Manifests
**Duration**: 1 week
**Output**: K8s configs with security best practices

**Security controls**:

#### 1. Network Policies (Deny all by default)
```yaml
# k8s/network-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: devsecops
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress

---

# Allow only app to db
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-app-to-db
  namespace: devsecops
spec:
  podSelector:
    matchLabels:
      app: postgres
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: my-app
    ports:
    - protocol: TCP
      port: 5432
```

#### 2. Pod Security Policy (Non-root, read-only filesystem)
```yaml
# k8s/pod-security-policy.yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted
spec:
  privileged: false
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
  - ALL
  volumes:
  - 'configMap'
  - 'emptyDir'
  - 'projected'
  - 'secret'
  - 'downwardAPI'
  - 'persistentVolumeClaim'
  hostNetwork: false
  hostIPC: false
  hostPID: false
  runAsUser:
    rule: 'MustRunAsNonRoot'
  fsGroup:
    rule: 'RunAsAny'
  readOnlyRootFilesystem: true
```

#### 3. RBAC (Role-Based Access Control)
```yaml
# k8s/rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-sa
  namespace: devsecops

---

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-role
  namespace: devsecops
rules:
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["get", "list"]
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get"]  # Only get, no list

---

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: app-rolebinding
  namespace: devsecops
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: app-role
subjects:
- kind: ServiceAccount
  name: app-sa
  namespace: devsecops
```

#### 4. Secure Pod Spec
```yaml
# k8s/secure-app-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: devsecops
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      serviceAccountName: app-sa
      
      # Security context
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
        seccompProfile:
          type: RuntimeDefault

      containers:
      - name: my-app
        image: my-app:latest
        imagePullPolicy: Always
        
        # Security context for container
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          runAsUser: 1000
          capabilities:
            drop:
            - ALL
        
        ports:
        - containerPort: 3000
        
        # Mount read-only filesystem
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: cache
          mountPath: /app/cache
        
        # Resource limits
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        
        # Health checks
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 10

      # Volumes for writable directories
      volumes:
      - name: tmp
        emptyDir: {}
      - name: cache
        emptyDir: {}
```

**Checklist**:
- [ ] Network policies deny by default
- [ ] Pods run as non-root
- [ ] Read-only root filesystem
- [ ] RBAC configured (least privilege)
- [ ] Service accounts created
- [ ] Resource limits set
- [ ] Security context applied
- [ ] No privileged containers

---

### Project 4.3: Security Scanning in CI/CD
**Duration**: 1 week
**Output**: Automated scanning in GitHub Actions

**Updated CI/CD workflow**:

```yaml
# .github/workflows/security-scan.yml
name: Security Scan & Build

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      # 1. Scan Terraform code
      - name: TFLint
        uses: terraform-linters/setup-tflint@v4
      
      - name: Run TFLint
        run: |
          tflint --init
          tflint --format compact

      # 2. SAST (Static Analysis)
      - name: SonarQube Scan
        uses: sonarsource/sonarqube-scan-action@master
        env:
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

      # 3. Dependency Scanning with Snyk
      - name: Run Snyk scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: --severity-threshold=high

      # 4. Build Docker image
      - name: Build Docker image
        run: docker build -t my-app:${{ github.sha }} .

      # 5. Scan Docker image for vulnerabilities
      - name: Trivy vulnerability scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: my-app:${{ github.sha }}
          format: 'sarif'
          output: 'trivy-results.sarif'

      # 6. Upload SARIF to GitHub
      - name: Upload Trivy results to GitHub
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  build:
    needs: security-scan
    runs-on: ubuntu-latest
    if: success()
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run tests
        run: npm test

      - name: Push to ECR
        # ... ECR push logic ...
```

**Setup SonarQube locally** (for development):
```bash
# Run SonarQube in Docker
docker run -d --name sonarqube \
  -p 9000:9000 \
  sonarqube:latest

# SonarQube will be at http://localhost:9000
# Default: admin/admin
```

**Scan code locally**:
```bash
# Install SonarScanner
curl -o sonar-scanner.zip \
  https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip
unzip sonar-scanner.zip

# Run scan
./sonar-scanner-4.8.0.2856-linux/bin/sonar-scanner \
  -Dsonar.projectKey=my-app \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<TOKEN>
```

**Checklist**:
- [ ] Terraform code scanned with TFLint
- [ ] Source code scanned with SonarQube
- [ ] Dependencies scanned with Snyk
- [ ] Container images scanned with Trivy
- [ ] Scan results block PRs if critical issues found
- [ ] CI/CD pipeline shows security status
- [ ] Developers can fix issues locally before push

---

## 🎓 CERTIFICATION TRACK

### CompTIA Security+ (SY0-701)
- **Duration**: 90 minutes
- **Cost**: $380 USD
- **Pass score**: 750/900
- **Topics**: CIA triad, cryptography, network security, application security, cloud security

**Study materials**:
- CompTIA Security+ Study Guide (Sybex)
- Udemy: "CompTIA Security+ Certification" (25h)
- Professor Messer: YouTube videos (free)

**Timeline**:
- Week 1-2: Cryptography & network security
- Week 3: IAM & access control
- Week 4: Application & cloud security
- Week 5: Practice exams
- Week 6: Review & test

---

## ✅ PHASE 4 COMPLETION CHECKLIST

### Knowledge Checkpoints
- [ ] Explain each OWASP Top 10 vulnerability
- [ ] Know difference between encryption types
- [ ] Understand authentication vs authorization
- [ ] IAM policy structure in AWS
- [ ] Secret management best practices
- [ ] Secure coding principles

### Hands-on Checkpoints
- [ ] Terraform code has no hardcoded secrets
- [ ] All databases are private
- [ ] IAM roles follow least privilege
- [ ] Network security groups configured
- [ ] Encryption enabled at rest & transit
- [ ] Kubernetes manifests pass security checks
- [ ] Network policies configured
- [ ] RBAC implemented
- [ ] CI/CD pipeline scans code, dependencies, containers

### Verification
- [ ] Can explain security decisions to stakeholders
- [ ] Can audit infrastructure for vulnerabilities
- [ ] Identify and fix OWASP issues in code
- [ ] Understand risk vs compliance tradeoffs

---

---

# 🚀 PHASE 5: DEVSECOPS INTEGRATION (1 tháng)

## 🎯 Mục tiêu
👉 **Combine tất cả** thành 1 **production-ready system**

## 🧱 FINAL PROJECT: Complete DevSecOps Pipeline

**System Architecture**:
```
┌─────────────────────────────────────────────────────┐
│                  DEVELOPER                          │
│              git push to main                       │
└─────────────────┬───────────────────────────────────┘
                  │
        ┌─────────▼──────────┐
        │  GitHub Repository  │
        │  + Webhooks         │
        └─────────┬──────────┘
                  │
        ┌─────────▼────────────────────────┐
        │  GitHub Actions (CI/CD Pipeline)  │
        └─────────┬────────────────────────┘
                  │
        ┌─────────▼──────────────────┐
        │ SECURITY SCANNING STAGE    │
        ├────────────────────────────┤
        │ 1. Code: SonarQube        │
        │ 2. Deps: Snyk            │
        │ 3. IaC: TFLint           │
        │ 4. Secrets: git-secrets  │
        └─────────┬──────────────────┘
                  │
        ┌─────────▼──────────────────┐
        │ BUILD STAGE                │
        ├────────────────────────────┤
        │ 1. Build Docker image     │
        │ 2. Scan image: Trivy      │
        │ 3. Push to ECR            │
        └─────────┬──────────────────┘
                  │
        ┌─────────▼──────────────────┐
        │ DEPLOY STAGE               │
        ├────────────────────────────┤
        │ 1. Terraform plan          │
        │ 2. Apply Terraform         │
        │ 3. Deploy to Kubernetes    │
        │ 4. Health check            │
        └─────────┬──────────────────┘
                  │
        ┌─────────▼──────────────────┐
        │ AWS Prod Environment       │
        │ (EKS + RDS + ALB)          │
        └────────────────────────────┘
```

---

## 📁 Repository Structure

```
my-devsecops-project/
│
├── .github/
│   └── workflows/
│       └── devsecops-pipeline.yml    # Complete CI/CD pipeline
│
├── app/
│   ├── src/
│   │   ├── index.js
│   │   ├── server.js
│   │   └── db.js
│   ├── tests/
│   │   └── test.js
│   ├── Dockerfile
│   ├── package.json
│   └── sonar-project.properties
│
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── rds/
│   │   └── alb/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── backend.tf
│
├── k8s/
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── postgres-deployment.yaml
│   ├── app-deployment.yaml
│   ├── app-service.yaml
│   ├── ingress.yaml
│   ├── network-policy.yaml
│   ├── rbac.yaml
│   ├── hpa.yaml
│   └── pod-security-policy.yaml
│
├── scripts/
│   ├── deploy.sh         # Deploy to AWS
│   ├── rollback.sh       # Rollback deployment
│   ├── health-check.sh   # Verify system health
│   └── setup-ci-cd.sh    # Setup GitHub Actions secrets
│
├── docs/
│   ├── architecture.md
│   ├── security.md
│   ├── runbook.md
│   └── troubleshooting.md
│
├── .gitignore
├── README.md
└── docker-compose.yml    # Local development
```

---

## 🔧 IMPLEMENTATION

### Step 1: Application (Node.js Backend)

**app/src/index.js**:
```javascript
const express = require('express');
const { Pool } = require('pg');

const app = express();
const PORT = process.env.PORT || 3000;

// Database connection
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'OK' });
});

// Ready check
app.get('/ready', async (req, res) => {
  try {
    const result = await pool.query('SELECT 1');
    res.json({ status: 'Ready' });
  } catch (err) {
    res.status(503).json({ status: 'Not Ready', error: err.message });
  }
});

// API endpoint
app.get('/api/data', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users LIMIT 10');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

**app/Dockerfile**:
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY src ./src

# Create non-root user
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser

# Change ownership
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

CMD ["node", "src/index.js"]
```

---

### Step 2: Complete GitHub Actions Workflow

**.github/workflows/devsecops-pipeline.yml**:
```yaml
name: 🚀 DevSecOps Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  AWS_REGION: us-east-1
  ECR_REPOSITORY: my-app
  EKS_CLUSTER_NAME: devsecops
  EKS_NAMESPACE: devsecops

jobs:
  # ============== SECURITY SCANNING ==============
  security-scan:
    name: 🔐 Security Scanning
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
      security-events: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0  # For SonarQube

      # 1. Check for secrets
      - name: Scan for hardcoded secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD

      # 2. Terraform linting
      - name: Setup TFLint
        uses: terraform-linters/setup-tflint@v4
      
      - name: TFLint - Terraform security
        run: |
          cd terraform
          tflint --init
          tflint --format compact --minimum-failure-level warning

      # 3. SAST - SonarQube
      - name: SonarQube code analysis
        uses: sonarsource/sonarqube-scan-action@master
        env:
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

      # 4. Dependency scanning - Snyk
      - name: Run Snyk dependency scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: --severity-threshold=high --exit-code=1

      # 5. Check Snyk results
      - name: Upload Snyk results to GitHub
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: 'snyk.sarif'

  # ============== BUILD ==============
  build:
    name: 🏗️ Build & Test
    runs-on: ubuntu-latest
    needs: security-scan
    permissions:
      id-token: write
      contents: read
      packages: write

    outputs:
      image-tag: ${{ steps.meta.outputs.tags }}
      image-digest: ${{ steps.build.outputs.digest }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Generate coverage
        run: npm run test:coverage
        continue-on-error: true

      # Docker build
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions-role
          role-session-name: github-actions
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Docker meta
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: |
            ${{ steps.login-ecr.outputs.registry }}/${{ env.ECR_REPOSITORY }}
          tags: |
            type=ref,event=branch
            type=semver,pattern={{version}}
            type=sha,prefix={{branch}}-

      - name: Build and push Docker image
        id: build
        uses: docker/build-push-action@v5
        with:
          context: ./app
          push: ${{ github.event_name == 'push' && github.ref == 'refs/heads/main' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

      # Container image scanning
      - name: Trivy vulnerability scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ${{ steps.meta.outputs.tags }}
          format: 'sarif'
          output: 'trivy-results.sarif'
          severity: 'CRITICAL,HIGH'

      - name: Upload Trivy results
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: 'trivy-results.sarif'

  # ============== INFRASTRUCTURE ==============
  terraform-plan:
    name: 📋 Terraform Plan
    runs-on: ubuntu-latest
    needs: security-scan
    if: github.event_name == 'pull_request'

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions-role
          aws-region: ${{ env.AWS_REGION }}

      - name: Terraform Init
        working-directory: terraform
        run: terraform init

      - name: Terraform Format Check
        working-directory: terraform
        run: terraform fmt -check

      - name: Terraform Validate
        working-directory: terraform
        run: terraform validate

      - name: Terraform Plan (Dev)
        working-directory: terraform/environments/dev
        run: |
          terraform init
          terraform plan -out=tfplan

      - name: Terraform Plan (Prod)
        working-directory: terraform/environments/prod
        if: github.base_ref == 'main'
        run: |
          terraform init
          terraform plan -out=tfplan

  # ============== DEPLOY ==============
  deploy:
    name: 🚀 Deploy to EKS
    runs-on: ubuntu-latest
    needs: [build, terraform-plan]
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/github-actions-role
          aws-region: ${{ env.AWS_REGION }}

      - name: Update kubeconfig
        run: |
          aws eks update-kubeconfig \
            --name ${{ env.EKS_CLUSTER_NAME }} \
            --region ${{ env.AWS_REGION }}

      - name: Deploy Kubernetes manifests
        run: |
          kubectl apply -f k8s/namespace.yaml
          kubectl apply -f k8s/configmap.yaml
          kubectl apply -f k8s/secret.yaml
          kubectl apply -f k8s/postgres-deployment.yaml
          kubectl apply -f k8s/app-deployment.yaml

      - name: Update image in deployment
        run: |
          kubectl set image deployment/my-app \
            my-app=${{ needs.build.outputs.image-tag }} \
            --record \
            -n ${{ env.EKS_NAMESPACE }}

      - name: Verify rollout
        run: |
          kubectl rollout status deployment/my-app \
            -n ${{ env.EKS_NAMESPACE }} \
            --timeout=5m

      - name: Health check
        run: |
          kubectl run healthcheck \
            --image=curlimages/curl:latest \
            --rm -it \
            --restart=Never \
            -- curl http://my-app/health

  # ============== NOTIFICATIONS ==============
  notify:
    name: 📢 Notifications
    runs-on: ubuntu-latest
    needs: [build, deploy]
    if: always()

    steps:
      - name: Send Slack notification
        uses: slackapi/slack-github-action@v1.24.0
        with:
          webhook-url: ${{ secrets.SLACK_WEBHOOK_URL }}
          payload: |
            {
              "text": "DevSecOps Pipeline - ${{ job.status }}",
              "blocks": [
                {
                  "type": "section",
                  "text": {
                    "type": "mrkdwn",
                    "text": "*DevSecOps Pipeline* - ${{ job.status }}\n*Ref:* ${{ github.ref }}\n*Commit:* ${{ github.sha }}"
                  }
                }
              ]
            }
```

---

### Step 3: Deployment Scripts

**scripts/deploy.sh**:
```bash
#!/bin/bash
set -e

ENVIRONMENT=${1:-prod}
REGION=${2:-us-east-1}
CLUSTER_NAME="devsecops"

echo "🚀 Deploying to $ENVIRONMENT..."

# 1. Configure AWS
aws eks update-kubeconfig \
  --name $CLUSTER_NAME \
  --region $REGION

# 2. Apply Kubernetes manifests
echo "📦 Deploying Kubernetes resources..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/postgres-deployment.yaml
kubectl apply -f k8s/app-deployment.yaml
kubectl apply -f k8s/app-service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/network-policy.yaml
kubectl apply -f k8s/rbac.yaml
kubectl apply -f k8s/hpa.yaml

# 3. Verify deployment
echo "✅ Verifying deployment..."
kubectl rollout status deployment/my-app -n devsecops --timeout=5m

# 4. Get service info
echo "🔗 Service endpoints:"
kubectl get svc -n devsecops
kubectl get ingress -n devsecops

echo "✨ Deployment complete!"
```

**scripts/health-check.sh**:
```bash
#!/bin/bash

NAMESPACE="devsecops"

echo "🏥 Health Check Report"
echo "======================"

# 1. Pod status
echo ""
echo "📦 Pods:"
kubectl get pods -n $NAMESPACE -o wide

# 2. Services
echo ""
echo "🔌 Services:"
kubectl get svc -n $NAMESPACE

# 3. Deployments
echo ""
echo "⚙️ Deployments:"
kubectl get deployment -n $NAMESPACE

# 4. Resource usage
echo ""
echo "💾 Resource Usage:"
kubectl top nodes
kubectl top pods -n $NAMESPACE

# 5. Recent events
echo ""
echo "📋 Recent Events:"
kubectl get events -n $NAMESPACE --sort-by='.lastTimestamp'

# 6. Health probes
echo ""
echo "🫀 Health Probes:"
kubectl describe deployment my-app -n $NAMESPACE | grep -A 10 "Probe"
```

---

### Step 4: Documentation

**docs/architecture.md**:
```markdown
# Architecture Overview

## System Components

### Infrastructure (AWS)
- **VPC**: Isolated network (10.0.0.0/16)
  - Public subnets: ALB, NAT Gateway
  - Private subnets: EKS nodes, RDS
- **EKS**: Kubernetes cluster (2-10 nodes)
- **RDS**: PostgreSQL database (encrypted, backup enabled)
- **ALB**: Application Load Balancer
- **ECR**: Container image registry

### Application (Kubernetes)
- **Namespace**: `devsecops`
- **Deployment**: `my-app` (3-10 replicas with HPA)
- **StatefulSet**: `postgres` (primary database)
- **Service**: `my-app` (LoadBalancer)
- **Ingress**: Route external traffic

### Security
- Network policies: Deny all by default
- RBAC: Service accounts with minimal permissions
- Pod security: Non-root, read-only filesystem
- Secrets: AWS Secrets Manager integration
- Encryption: TLS in transit, AES-256 at rest

## Data Flow

```
Internet
  ↓
Internet Gateway (VPC)
  ↓
ALB (public subnet)
  ↓
EKS Ingress Controller
  ↓
my-app Service (ClusterIP)
  ↓
my-app Pods (private subnet)
  ↓
PostgreSQL Service (ClusterIP)
  ↓
PostgreSQL Pod (RDS backup in private subnet)
```

## Scaling

### Horizontal Pod Autoscaler
- Min: 3 replicas
- Max: 10 replicas
- Trigger: CPU > 70% OR Memory > 80%
- Scale up time: ~30 seconds
- Scale down time: ~5 minutes

### Kubernetes Node Autoscaler
- Min: 2 nodes
- Max: 10 nodes
- Triggered by pod scheduling failures
```

**docs/runbook.md**:
```markdown
# Operations Runbook

## Common Tasks

### View Logs
```bash
# Last 100 lines
kubectl logs deployment/my-app -n devsecops --tail=100

# Live logs
kubectl logs deployment/my-app -n devsecops -f

# Specific pod
kubectl logs pod/my-app-xxx -n devsecops
```

### Scale Deployment
```bash
# Manual scale
kubectl scale deployment my-app --replicas=5 -n devsecops

# Check HPA status
kubectl get hpa -n devsecops
```

### Rolling Update
```bash
# Update image
kubectl set image deployment/my-app \
  my-app=my-app:v2.0 \
  --record \
  -n devsecops

# Watch rollout
kubectl rollout status deployment/my-app -n devsecops

# Rollback if needed
kubectl rollout undo deployment/my-app -n devsecops
```

### Database Access
```bash
# Get database credentials
kubectl get secret app-secret -n devsecops -o jsonpath='{.data.DB_PASSWORD}' | base64 -d

# Port forward to localhost
kubectl port-forward svc/postgres 5432:5432 -n devsecops

# Connect
psql -h localhost -U postgres -d appdb -W
```

### Check Resource Usage
```bash
kubectl top nodes
kubectl top pods -n devsecops
```
```

---

## ✅ PROJECT COMPLETION CHECKLIST

### Development
- [ ] Code compiles and tests pass
- [ ] Docker image builds successfully
- [ ] Application runs in Docker locally
- [ ] docker-compose stack works

### Security
- [ ] No hardcoded secrets in code
- [ ] SonarQube: No critical issues
- [ ] Snyk: No high-severity dependencies
- [ ] Trivy: No critical container vulnerabilities
- [ ] TFLint: No compliance issues
- [ ] All git-secrets checks pass

### Infrastructure
- [ ] Terraform code modules modular
- [ ] Terraform plan succeeds for all environments
- [ ] Can deploy via terraform apply
- [ ] S3 + DynamoDB configured for state
- [ ] IAM roles follow least privilege

### Kubernetes
- [ ] All manifests validated
- [ ] Pods run as non-root
- [ ] Network policies enabled
- [ ] RBAC roles created
- [ ] Health probes configured
- [ ] Resource limits set

### CI/CD
- [ ] GitHub Actions workflow runs on push
- [ ] All scanning jobs complete
- [ ] Build succeeds and pushes to ECR
- [ ] Deployment to EKS successful
- [ ] Rollback mechanism tested
- [ ] Slack notifications working

### Operations
- [ ] Health check endpoint responding
- [ ] Database connectivity verified
- [ ] Logs accessible
- [ ] Monitoring (Prometheus) collecting metrics
- [ ] Alerts configured
- [ ] Runbook documentation complete

---

## 🎯 FINAL VALIDATION

Can you now:

✅ **Explain the full system** to a senior engineer
- Architecture decisions
- Security tradeoffs
- Scaling strategy

✅ **Deploy infrastructure** from scratch
- Run Terraform, get AWS resources
- Deploy Kubernetes manifests
- Verify health

✅ **Respond to incidents**
- Read logs to identify issues
- Scale up/down as needed
- Rollback deployment if necessary
- Update secrets without downtime

✅ **Implement security**
- Scan code for vulnerabilities
- Update dependencies safely
- Apply least privilege
- Audit access controls

---

---

# 📊 OVERALL ROADMAP PROGRESS TRACKING

## Timeline Overview

```
Phase 1 (1.5-2m)  ████████████████░░░░░░░░░░░░░░░░░░░░ AWS Foundation
Phase 2 (2m)      ██████████████████░░░░░░░░░░░░░░░░░░░ Terraform + CI/CD
Phase 3 (2m)      ██████████████████░░░░░░░░░░░░░░░░░░░ Kubernetes
Phase 4 (1.5-2m)  ██████████████████░░░░░░░░░░░░░░░░░░░ Security
Phase 5 (1m)      ████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Integration

Total: 7.5-9 months
```

## Monthly Checkpoints

### Month 1 (End of Phase 1)
- [ ] AWS SAA certification obtained
- [ ] Can launch EC2, VPC, RDS from console
- [ ] Docker basics understood
- [ ] Project 1.1 & 1.2 complete

### Month 2-3 (End of Phase 2)
- [ ] Terraform modules written
- [ ] GitHub Actions pipeline working
- [ ] Can deploy infra with `terraform apply`
- [ ] Dev/staging/prod environments separated
- [ ] Project 2.1 & 2.2 complete

### Month 4-5 (End of Phase 3)
- [ ] EKS cluster created
- [ ] Application deployed to Kubernetes
- [ ] HPA working
- [ ] Can do rolling updates
- [ ] Project 3.1 & 3.2 complete

### Month 6-7 (End of Phase 4)
- [ ] Security scanning integrated in CI/CD
- [ ] Terraform code is secure (no secrets)
- [ ] Kubernetes manifests hardened
- [ ] CompTIA Security+ certification
- [ ] Project 4.1, 4.2, 4.3 complete

### Month 8-9 (End of Phase 5)
- [ ] Complete DevSecOps system deployed
- [ ] Full CI/CD pipeline working
- [ ] Can explain architecture to seniors
- [ ] Incident response procedures documented
- [ ] Final project complete

---

## Key Success Metrics

### By end of Phase 5, you should be able to:

| Metric | Benchmark |
|--------|-----------|
| Deploy new infrastructure | < 10 minutes |
| CI/CD pipeline completion | < 5 minutes |
| Container image scan | < 2 minutes |
| Kubernetes deployment | < 3 minutes |
| Database backup | < 1 minute |
| Security audit (automated) | < 30 seconds |
| Incident response time | < 15 minutes |

---

# 🎓 CERTIFICATIONS TIMELINE

```
Month 1-2: AWS Certified Solutions Architect (SAA-C03)
Month 3:   HashiCorp Certified Terraform (Optional)
Month 5:   Certified Kubernetes Administrator (CKA)
Month 6-7: CompTIA Security+ (SY0-701)
```

---

# 📚 RECOMMENDED RESOURCES

## Free Resources
- AWS Free Tier (1 year)
- Kubernetes official documentation
- Linux Academy courses (some free)
- Professor Messer (Security+ YouTube)
- Terraform official registry

## Paid Resources
- Udemy courses ($10-20 each)
- Linux Academy ($29-49/month)
- A Cloud Guru ($45/month)
- Exam vouchers ($70-400 each)

## Total Cost Estimate
- Exam vouchers: $1,000-1,200
- Online courses: $200-400
- AWS usage: $50-100/month (~ 9 months = $450-900)
- **Total: ~$2,000-2,500**

---

# 🏁 CONCLUSION

After 7.5-9 months, you will have:

✅ **Technical skills**
- Cloud infrastructure (AWS)
- Infrastructure as code (Terraform)
- Container orchestration (Kubernetes)
- CI/CD automation (GitHub Actions)
- Application security (SonarQube, Snyk, Trivy)

✅ **Practical experience**
- Built production-like system
- Implemented security best practices
- Automated deployments
- Managed multiple environments

✅ **Certifications**
- AWS Solutions Architect
- Terraform Associate (optional)
- Certified Kubernetes Administrator
- CompTIA Security+

✅ **Senior-level mindset**
- Think in systems (not just code)
- Security-first approach
- Infrastructure automation
- Scalability & reliability
- Incident response

---

## Next Steps After Roadmap

1. **Production deployment**: Use roadmap as template for real systems
2. **Continuous learning**: Keep up with new AWS features, K8s updates
3. **Advanced topics**: 
   - Service mesh (Istio, Linkerd)
   - GitOps (ArgoCD, Flux)
   - Cost optimization
   - Disaster recovery
4. **Contribute to community**: Open source DevOps tools
5. **Mentor others**: Share knowledge with junior engineers

---

**Good luck with your DevSecOps journey! 🚀**
