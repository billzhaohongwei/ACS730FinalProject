# First, create an S3 bucket named prod-acs730-final-hongweizhao
git clone git@github.com:billzhaohongwei/ACS730FinalProject.git
alias tf=terraform
cd ACS730FinalProject/terraform/environments/prod/network/
tf init
tf validate
tf plan
tf apply --auto-approve
# The VPC and subnets are now provisioned.
cd ../webservers/
tf init
ssh-keygen -t rsa -f final
tf validate
tf plan
tf apply --auto-approve
# The VMs and elastic load balancers are provisioned, Apache Webserver installed on webserver 1, 2, 5
cp -f final /home/ec2-user/.ssh/final
cd ../../../../ansible/
ansible-playbook -i aws_ec2.yaml  playbook.yaml
# Ansible install Apache Webserver on webserver 3, 4
# Now we can start testing the webservers and Bastion
# Check connection from Bastion to VM5 and 6 in private subnets
cd -
scp -i final final ec2-user@<public_ip_of_bastion>:~/.ssh/
ssh -i final ec2-user@<public_ip_of_bastion>
ssh -i ~/.ssh/final ec2-user@<webserver5_private_ip>
sudo systemctl status httpd
curl localhost
exit
ssh -i ~/.ssh/final ec2-user@<webserver6_private_ip>
exit
exit
