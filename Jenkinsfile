pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = "eu-west-1"
        AWS_ACCESS_KEY_ID  = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        TF_LOG = ""
        PATH = "$TF_HOME:$PATH"
    }

    stages {
        stage('Hello') {
            steps {
                sh """
                git credentialsId: 'github-creds', url: 'https://github.com/onaiv22/greenfield-app-project.git'
                """
            }
        }
    }
    stage('Terraform Init') {
            steps {
                sh '''
                    terraform init
                '''
            }
        }
    stage('Terrfom Validate') {
        steps {
            sh '''
                terraform validate
            '''
        }
    }
    stage('Terraform Plan') {
        steps {
                sh "terraform plan -out greenfield-dev-test.tfplan;echo \$? > status"
                stash name: "greenfield-dev-test", includes: "greenfield-dev-test.tfplan"
        }
    }
}

