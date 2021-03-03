pipeline {
    agent any
    stages {
        stage('seed job') {
            steps {
                jobDsl failOnMissingPlugin: true, removedConfigFilesAction: 'DELETE', removedJobAction: 'DELETE', removedViewAction: 'DELETE', targets: '*.groovy'
            }
        }
    }
}