pipeline {
    agent any
    // environment {
    //     DOCKERHUB_CREDENTIALS = credentials('dockerhub') not required current
    // } DOCKER IMAGES MUST BE PULLED FROM kubenix docker hub
    stages {
        stage("Clone code") {
            steps {
                echo "cloning"
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/nixhal33/ecom-web.git'
            }
        }
        stage("Build Image") {
            steps {
                echo "Building"
                sh "docker build -t ecom-webapp ."
            }
        }
        stage("Push Image to repository") {
            steps {
                echo "Pushing Image"
                withCredentials([usernamePassword(credentialsId:"docker", passwordVariable:"password", usernameVariable:"user")]){
                    sh "docker tag ecom-webapp ${env.user}/ecom-webapp:dev"
                    sh "docker login -u ${env.user} -p ${env.password}"
                    sh "docker push ${env.user}/ecom-webapp:dev"
                }
            }
        }
        stage("ssh into server") {
            steps {
                sshagent(['ssh-deployment']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@3.92.173.79 "cd /home/ubuntu/ecom-web && docker compose up -d"'
                }
            }
        }
    }
}