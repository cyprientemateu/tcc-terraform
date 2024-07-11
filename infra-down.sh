echo "******************************************************"
echo "Deleting the ec2 module"
echo "******************************************************"
sleep 3
cd resources/ec2
terraform init
terraform destroy --auto-approve
cd -

echo "******************************************************"
echo "Deleting vpc module"
echo "******************************************************"
sleep 3
cd resources/vpc
terraform init 
terraform destroy --auto-approve
cd -

echo "******************************************************"
echo "Deleting s3 backeng module"
echo "******************************************************"
cd resources/s3-replication
terraform init
terraform destroy --auto-approve
