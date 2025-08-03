#!/bin/bash
# Deploy Script for Terraform + Ansible Website Project
# Author: Nir Avitbul
# Date: August 2024

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check Terraform
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed!"
        exit 1
    fi
    
    # Check Ansible
    if ! command -v ansible &> /dev/null; then
        print_error "Ansible is not installed!"
        exit 1
    fi
    
    # Check AWS CLI
    if ! command -v aws &> /dev/null; then
        print_error "AWS CLI is not installed!"
        exit 1
    fi
    
    # Check SSH keys
    if [ ! -f ~/.ssh/id_rsa ]; then
        print_warning "SSH key not found. Generating new key pair..."
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
    fi
    
    print_status "All prerequisites are met!"
}

# Deploy infrastructure
deploy_infrastructure() {
    print_status "Deploying infrastructure with Terraform..."
    
    cd terraform
    
    # Initialize Terraform
    print_status "Initializing Terraform..."
    terraform init
    
    # Validate configuration
    print_status "Validating Terraform configuration..."
    terraform validate
    
    # Plan deployment
    print_status "Planning infrastructure deployment..."
    terraform plan -out=tfplan
    
    # Apply deployment
    print_status "Applying infrastructure changes..."
    terraform apply -auto-approve tfplan
    
    # Get outputs
    print_status "Infrastructure deployed successfully!"
    echo -e "\n${GREEN}=== Deployment Outputs ===${NC}"
    terraform output
    
    cd ..
}

# Run Ansible manually (optional)
run_ansible() {
    print_status "Running Ansible configuration..."
    
    cd ansible
    
    # Set environment variable to skip host key checking
    export ANSIBLE_HOST_KEY_CHECKING=False
    
    # Run playbook
    ansible-playbook -i inventory/hosts playbook.yml
    
    cd ..
}

# Destroy infrastructure
destroy_infrastructure() {
    print_warning "This will destroy all infrastructure!"
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd terraform
        terraform destroy -auto-approve
        cd ..
        print_status "Infrastructure destroyed."
    else
        print_status "Destruction cancelled."
    fi
}

# Main menu
show_menu() {
    echo -e "\n${GREEN}=== Terraform + Ansible Deployment Script ===${NC}"
    echo "1. Check prerequisites"
    echo "2. Deploy infrastructure (Full deployment)"
    echo "3. Run Ansible only"
    echo "4. Show infrastructure outputs"
    echo "5. Destroy infrastructure"
    echo "6. Exit"
    echo
    read -p "Select an option: " choice
    
    case $choice in
        1) check_prerequisites ;;
        2) check_prerequisites && deploy_infrastructure ;;
        3) run_ansible ;;
        4) cd terraform && terraform output && cd .. ;;
        5) destroy_infrastructure ;;
        6) exit 0 ;;
        *) print_error "Invalid option!" && show_menu ;;
    esac
}

# Main execution
if [ "$1" == "--deploy" ]; then
    check_prerequisites
    deploy_infrastructure
elif [ "$1" == "--destroy" ]; then
    destroy_infrastructure
elif [ "$1" == "--help" ]; then
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  --deploy    Deploy infrastructure automatically"
    echo "  --destroy   Destroy infrastructure"
    echo "  --help      Show this help message"
    echo "  (no option) Show interactive menu"
else
    while true; do
        show_menu
    done
fi
