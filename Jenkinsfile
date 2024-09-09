pipeline {
    agent any
    environment {
        Docker_Image = "ahmedalaa14/flask-app-mini"                // Docker Image Name       
        Docker_Credential = "DockerHub-Credentail"                // Docker ID  
        Python_Path = "/usr/bin/python3"                         // python3 path
        APP_PATH = "app"                                        // application path
        VENV_PATH = "venv"                                     // virtual environment path
        SONAR_SCANNER_HOME = tool name: 'sonarqube'           // sonarqube home path
        OWASP_HOME = tool name: 'owasp'                      // OWASP scanner home path
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
                        pip install flask
                        pip install pytest
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
                        pytest --junitxml=report.xml  # generate test report
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
                        coverage run -m pytest --junitxml=unit_test_report.xml  # run unit tests with coverage and generate report
                        coverage xml -o coverage.xml                           # generate coverage report in xml format
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'app/report.xml, app/unit_test_report.xml, app/coverage.xml', fingerprint: true
                }
            }
        }
        /*
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
        */

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
    }
}
