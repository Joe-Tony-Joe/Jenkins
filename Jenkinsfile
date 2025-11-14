pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'openjdk:17-jre'
    }
   
    stages {
        stage('Checkout') {
            steps {
                script {
                    echo 'Checking out code...'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo 'Building...'
                    // 示例：mvn clean package
                   
                }
            }
        }
        stage('Run Script') {
            steps {
                script {
                    echo 'Making script executable...'
                    sh 'chmod +x hello_world.sh'
                    echo 'Running script...'
                    sh './hello_world.sh'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying...'
                    // 可以部署到测试环境
                }
            }
        }
    }
}