aws cloudformation create-stack \
  --stack-name k8s-cluster-stack \
  --template-body file://k8s-cluster.yaml \
  --region eu-west-1 \
  --parameters ParameterKey=KeyName,ParameterValue=defaultAWSkey ParameterKey=AMIId,ParameterValue=ami-0e9085e60087ce171 \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

# To show output:
# aws cloudformation describe-stacks --stack-name k8s-cluster-stack --region eu-west-1