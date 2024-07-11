echo "******************************************************"
echo "Checking the plan for s3 backeng module"
echo "******************************************************"
cd resources/s3-replication
terraform init
terraform fmt
terraform plan
cd -

echo "******************************************************"
echo "Checking the plan for vpc module"
echo "******************************************************"
cd resources/vpc
terraform init
terraform fmt
terraform plan
cd -

echo "******************************************************"
echo "Checking the plan for ec2 module for bastion host"
echo "******************************************************"
cd resources/ec2
terraform init
terraform fmt
terraform plan
cd -