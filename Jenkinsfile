pipeline {
    agent any
    stages{
        stage("Code Clone") {
            steps{
                git branch: 'main', url: 'https://github.com/nixhal33/ecom-web.git' 
            }
        }
        stage("Build Docker Images") {
            steps{
                sh "docker rmi -f ecommerce-webapp:latest"
                sh "docker build -t e-com-webapp ."
            }
        }
        stage("Deploy Docker Images") {
            steps{
                sh "docker compose up -d" 
            }
        }
    }
}