echo "******************************************************"
echo "Deploying s3 backeng module"
echo "******************************************************"
sleep 3
cd resources/s3-replication
terraform init
terraform fmt
terraform apply --auto-approve
cd -

echo "******************************************************"
echo "Deploying vpc module"
echo "******************************************************"
sleep 3
cd resources/vpc
terraform init -reconfigure
terraform fmt
terraform apply --auto-approve
cd -

echo "******************************************************"
echo "Deploying ec2 module for bastion host"
echo "******************************************************"
sleep 3
cd resources/ec2
terraform init
terraform fmt
terraform apply --auto-approve
cd -