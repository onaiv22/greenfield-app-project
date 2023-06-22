variable "display_name" {
    description = "Name shown in confirmation emails"
    default ="Femi"
}

I have manually created the s3 bucket for statefile.

Also created the dynamodb table for locking the statfile with the following cli command

aws dynamodb create-table --table-name TerraformStateLocks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --tags Key=Environment,Value=DevEnvironment \
  --region eu-west-1


output is below


aws dynamodb create-table --table-name TerraformStateLocks \
>   --attribute-definitions AttributeName=LockID,AttributeType=S \
>   --key-schema AttributeName=LockID,KeyType=HASH \
>   --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
>   --tags Key=Environment,Value=DevEnvironment \
>   --region eu-west-1
{
    "TableDescription": {
        "AttributeDefinitions": [
            {
                "AttributeName": "LockID",
                "AttributeType": "S"
            }
        ],
        "TableName": "TerraformStateLocks",
        "KeySchema": [
            {
                "AttributeName": "LockID",
                "KeyType": "HASH"
            }
        ],
        "TableStatus": "CREATING",
        "CreationDateTime": "2023-06-22T02:26:40.799000+01:00",
        "ProvisionedThroughput": {
            "NumberOfDecreasesToday": 0,
            "ReadCapacityUnits": 5,
            "WriteCapacityUnits": 5
        },
        "TableSizeBytes": 0,
        "ItemCount": 0,
        "TableArn": "arn:aws:dynamodb:eu-west-1:396254537602:table/TerraformStateLocks",
        "TableId": "1667a6bc-6fe1-4a0a-8fe5-e7edbe4a386c"
    }
}


After bastion is set up to ssh into instances in private subnet do the follwinf

sg - 
Go to sg of ec2 instance in private subnet
add a rule allowing traffic on port 22 from sg of the bastion.

copy keypair to bastion host
chmod 400 keypairname

then ssh using that key pair