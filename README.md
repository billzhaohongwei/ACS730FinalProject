git clone git@github.com:billzhaohongwei/ACS730FinalProject.git
alias tf=terraform
cd ACS730FinalProject/terraform/environments/prod/network/
tf init
tf validate
tf plan
tf apply --auto-approve
cd ../webservers/
tf init
tf validate
tf plan
tf apply --auto-approve
