pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'openjdk:17-jre'
    }
    tools {
        maven 'Maven-3.9.11'  // 正确位置：pipeline 的直接子项
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