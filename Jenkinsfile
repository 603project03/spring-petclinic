// pipeline {
//     agent any

//     tools {
//         jdk "jdk17"
//         maven "M3"
//     }
//     environment {
//         AWS_CREDENTIAL_NAME = "AWSCredentials"
//         REGION = "ap-northeast-2"
//     }
    
//     stages {
//         stage('Git Clone') {
//             steps {
//                 echo 'Git Clone'
//                 git url: 'https://github.com/603project03/spring-petclinic.git',
//                 branch: 'wavefront', credentialsId: 'github_access_token'
//             }
//             post {
//                 success {
//                     echo 'success clone project'
//                 }
//                 failure {
//                     error 'fail clone project' // exit pipeline
//                 }
//             }
//         }        
      
//         stage ('mvn Build') {
//             steps {
//                 sh 'mvn -Dmaven.test.failure.ignore=true install' 
//             }
//             post {
//                 success {
//                     junit '**/target/surefire-reports/TEST-*.xml' 
//                 }
//             }
//         }
      
//         stage('upload') {
//             steps {
//                 sh 'aws s3 cp /var/jenkins_home/workspace/test/target/*.jar s3://project03-bucket-codedeploy/test.jar --region ap-northeast-2'
//             }
//         }
//     }
// }
