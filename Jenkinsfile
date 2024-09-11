pipeline {
    agent any
    environment {
        Docker_Image = "ahmedalaa14/flask-app-mini"                                  // Docker Image Name       
        Docker_Credential = "DockerHub-Credentail"                                  // Docker ID  
        Python_Path = "/usr/bin/python3"                                           // Python 3 path
        APP_PATH = "app"                                                          // Application path
        VENV_PATH = "venv"                                                       // Virtual environment path
        SONAR_SCANNER_HOME = tool name: 'sonarqube'                             // SonarQube home path
        OWASP_HOME = tool name: 'owasp'                                        // OWASP Dependency Check home path
        Trivy_Path = "/usr/bin/trivy"                                         // Trivy path
        Grype_path = "/usr/local/bin/grype"                                  // Grype path
        Terrascan_path = "/usr/local/bin/terrascan"                         // Terrascan path
        Terraform_path = "terraform"                                       // Terraform path
        AWS_Credential = "aws-credentails"                                // AWS Credential ID
        Kubeconfig_Path = "${env.WORKSPACE}\\kubeconfig"                  // Kubeconfig path
        kubernetes_Path = "${env.WORKSPACE}\\kubernetes"                 // Kubernetes path
        monitoring_Path = "${env.WORKSPACE}\\monitoring"                // Monitoring path
        aws_cli_Path = "/usr/local/bin/aws"                           // AWS CLI path
        namespace = "library"                                        // Namespace
        kubectl_path = "/usr/local/bin/kubectl"                     // Kubectl path
        AWS_REGION = "eu-north-1"                                  // AWS Region
        EKS_CLUSTER_NAME = "team6-cluster"                        // EKS Cluster Name
        slack_channel = "banque-misr"                           // Slack Channel
    }   

    stages {
        
        stage('Notify Slack') {
            steps {
                script {
                    echo "Sending notification to Slack"
                }
            }
        }
    
        /*
        stage('Setup Virtual Environment') {
            steps {
                script {
                    sh """
                        cd ${env.APP_PATH}
                        ${env.Python_Path} -m venv ${env.VENV_PATH}
                        . ${env.VENV_PATH}/bin/activate
                    """
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                        cd ${env.APP_PATH}
                        . ${env.VENV_PATH}/bin/activate
                        pip install flask pytest
                    """
                }
            }
        }
        stage('Build and Test App') {
            steps {
                script {
                    sh """
                        cd ${env.APP_PATH}
                        . ${env.VENV_PATH}/bin/activate
                        pytest --junitxml=report.xml  # Generate test report
                    """
                }
            }
        }
        stage('Unit Tests') {
            steps {
                script {
                    sh """
                        cd ${env.APP_PATH}
                        . ${env.VENV_PATH}/bin/activate
                        pip install coverage
                        coverage run -m pytest --junitxml=unit_test_report.xml  # Run unit tests with coverage and generate report
                        coverage xml -o coverage.xml                           # Generate coverage report in XML format
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'app/report.xml, app/unit_test_report.xml, app/coverage.xml', fingerprint: true
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'jenkins-sonar', variable: 'SONARQUBE_TOKEN')]) {
                        withSonarQubeEnv('sonarqube') {
                            sh """
                                cd ${env.APP_PATH}
                                ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                                -Dsonar.projectKey=ahmed-sonarqube \
                                -Dsonar.sources=. \
                                -Dsonar.host.url=http://192.168.1.21:9000 \
                                -Dsonar.login=${SONARQUBE_TOKEN}
                            """
                        }
                    }
                }
            }
        }
        stage('OWASP Scan') {
            steps {
                script {
                    dependencyCheck additionalArguments: '--noupdate --exclude venv --scan app --format XML --out owasp-report.xml', odcInstallation: 'owasp'
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'owasp-report.xml', fingerprint: true
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "cd ${env.APP_PATH} && docker build -t ${env.Docker_Image}:${env.BUILD_NUMBER} ."
                }
            }
        }
        stage('Update Trivy DB and Scan Docker Image with Trivy') {
            steps {
                script {
                    sh "${env.Trivy_Path} image --format table --no-progress -o trivy-report.txt ${env.Docker_Image}:${env.BUILD_NUMBER}"
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'trivy-report.txt', fingerprint: true
                }
            }
        }
        stage('Scan Docker Image with Grype') {
            steps {
                script {
                    sh """
                    ${env.Grype_path} ${env.Docker_Image}:${env.BUILD_NUMBER} > grype.txt 
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'grype.txt', fingerprint: true
                }
            }
        }
        stage('Scan Terraform Code with Terrascan') {
            steps {
                script {
                    dir("${env.Terraform_path}") {
                        sh """
                        # Scan only .tf files and set IaC type to terraform
                        find . -name "*.tf" | xargs ${env.Terrascan_path} scan -i terraform -d . > terrascan.txt
                        """
                    }
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'terrascan.txt', fingerprint: true
                }
            }
        }
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "DockerHub-Credentail", usernameVariable:"username", passwordVariable:"password")]) {
                        sh '''
                        echo "${password}" | docker login -u "${username}" --password-stdin
                        docker push ${env.Docker_Image}:${env.BUILD_NUMBER}
                        '''
                    }
                }
            }
        }
        stage('Deploy Infrastructure') {
            steps {
                script {
                    withAWS(credentials: "${AWS_Credential}") {
                        dir("${env.Terraform_path}") {
                            sh """
                            terraform init
                            terraform apply -auto-approve
                            """
                        }
                    }
                }
            }
        }
        stage('Update Kubeconfig') {
            steps {
                script {
                    withAWS(credentials: "${AWS_Credential}") {
                        sh """
                        ${env.aws_cli_Path} eks update-kubeconfig --region ${env.AWS_REGION} --name ${env.EKS_CLUSTER_NAME} --kubeconfig ${env.Kubeconfig_Path}
                        """
                    }
                }
            }
        }
        stage('Deploy Kubernetes files to EKS') {
            steps {
                script {
                    sh """
                    ${env.kubectl_path} create namespace ${env.namespace}
                    ${env.kubectl_path} apply -f ${env.kubernetes_Path} --namespace ${env.namespace}
                    """
                }
            }
        }
        stage('Deploy Monitoring Grafana and Prometheus to EKS') {
            steps {
                script {
                    sh """
                    ${env.kubectl_path} apply -f ${env.monitoring_Path} --namespace ${env.namespace}
                    """
                }
            }
        }
    */
    post{
        failure {
           slacksend (channel: "${env.slack_channel}" , color: '#FF0000' , message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        success {
           slacksend (channel: "${env.slack_channel}" , color: '#00FF00' , message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

        }
    }
    }
}
