pipeline {
    agent any
    environment {
        Docker_Image = "ahmedalaa14/flask-app-mini"                // Docker Image Name       
        Docker_Credential = "DockerHub-Credentail"                // Docker ID  
        Python_Path = "/usr/bin/python3"                         // Python 3 path
        APP_PATH = "app"                                        // Application path
        VENV_PATH = "venv"                                     // Virtual environment path
        SONAR_SCANNER_HOME = tool name: 'sonarqube'           // SonarQube home path
        OWASP_HOME = tool name: 'owasp'                      // OWASP Dependency Check home path
        Trivy_Path = "/usr/bin/trivy"                             // Trivy path
    }   
    
    stages {
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
        */
        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        cd ${env.APP_PATH}
                        docker build -t ${env.Docker_Image} .
                    """
                }
            }
        }
        stage('Scan Docker Image') {
            steps {
                script {
                    sh """
                        ${env.Trivy_Path} image --format table -o trivy-report.txt ${env.Docker_Image}
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'trivy-report.txt', fingerprint: true
                }
            }
        }
    }
}    

