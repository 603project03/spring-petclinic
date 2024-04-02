pipeline {
    agent any

    tools {
        jdk "jdk17"
        maven "M3"
    }
    environment {
        AWS_CREDENTIAL_NAME = "AWSCredentials"
        REGION = "ap-northeast-2"
        DOCKER_IMAGE_NAME="project03-ecr"
        ECR_REPOSITORY = "257307634175.dkr.ecr.ap-northeast-2.amazonaws.com"
        ECR_DOCKER_IMAGE = "${ECR_REPOSITORY}/${DOCKER_IMAGE_NAME}"
        EKS_API = "https://20CE5E4E50D8FB55833828E944CCFBAA.gr7.ap-northeast-2.eks.amazonaws.com"
        EKS_CLUSTER_NAME = "project03-eks-cluster"
        
    }
    
    stages {
        stage('Git Clone') {
            steps {
                echo 'Git Clone'
                git url: 'https://github.com/603project03/spring-petclinic.git',
                branch: 'main', credentialsId: 'github_access_token'
            }
            post {
                success {
                    echo 'success clone project'
                }
                failure {
                    error 'fail clone project' // exit pipeline
                }
            }
        }        
        stage ('mvn Build') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true install' 
            }
            post {
                success {
                    junit '**/target/surefire-reports/TEST-*.xml' 
                }
            }
        }        
        stage ('Docker Build') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh """
                      docker build -t $ECR_DOCKER_IMAGE:$BUILD_NUMBER .
                    """
                }
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                echo "Push Docker Image to ECR"
                script{
                    // cleanup current user docker credentials
                    sh 'rm -f ~/.dockercfg ~/.docker/config.json || true' 
                    docker.withRegistry("https://${ECR_REPOSITORY}", "ecr:${REGION}:${AWS_CREDENTIAL_NAME}") {
                        docker.image("${ECR_DOCKER_IMAGE}:${BUILD_NUMBER}").push()
                    }
                }
            }
            post {
                success {
                    echo "Push Docker Image success!"
                }
            }
        }
        stage('Clean Up Docker Images on Jenkins Server') {
            steps {
                echo 'Cleaning up unused Docker images on Jenkins server'

                // Clean up unused Docker images, including those created within the last hour
                sh "docker image prune -f --all --filter \"until=1h\""
            }
        }
    }
}
