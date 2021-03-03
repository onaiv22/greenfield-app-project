pipelineJob(femi) {
    agent any
    tools {
       terraform 'terraform'
    }
    environment {
        AWS_ACESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_KEY_ID =credentials('jenkins-aws-secret-key-id')
        TF_HOME = tool('terraform')
    }
    stages {
        stage('checkout SCM') {
            steps {
                echo "my build number is ${env.BUILD_NUMBER}"
                echo "My branch is ${env.BRANCH_NAME}"
                checkout scm
            }

        }
        stage('terraform init') {
            steps {
                sh 'terraform init'
            }
        }
    }
}