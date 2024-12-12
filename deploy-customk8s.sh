aws cloudformation create-stack --stack-name k8s-cluster --template-body file://k8s-cluster-defaultVPC.yaml --parameters \
ParameterKey=KeyName,ParameterValue=defaultAWSkey \
ParameterKey=InstanceType,ParameterValue=t2.medium \
ParameterKey=AMIId,ParameterValue=ami-0e9085e60087ce171 \
ParameterKey=VPCId,ParameterValue=vpc-0ea24c41641f8b4f4 \
ParameterKey=SubnetId1,ParameterValue=subnet-0d81403dcff5a6858 \
ParameterKey=SubnetId2,ParameterValue=subnet-0a0ef163cd4eff5a4 \
ParameterKey=SubnetId3,ParameterValue=subnet-079ed1af3f26fadd6 \
--region eu-west-1