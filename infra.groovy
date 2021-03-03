node ('any') {
    def TF_HOME = tool 'terraform'
    def terraform = TF_HOME
    def AWS_ACESS_KEY_ID = build.getEnvironment(jenkins-aws-secret-key-id)
    environment {
        AWS_ACESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_KEY_ID =credentials('jenkins-aws-secret-key-id')
    }

    }
    stage('checkout scm') {
        git 'https://github.com/onaiv22/greenfield-app-project.git'
    }
    stage('terraform init') {
        sh "'${terraform}' init"
    }
}