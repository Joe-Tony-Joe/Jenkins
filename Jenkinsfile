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
                    sh 'mvn clean package'
                }
            }
        }
        tools {
            maven 'Maven-3.27'  // 名字必须和 Global Tool Configuration 中一致
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