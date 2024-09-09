pipeline {
    agent any
    environment {
        Docker_Image = "ahmedalaa14/flask-app-mini"  // Docker Image Name       
        Docker_Credential = "DockerHub-Credentail"  // Docker ID  
        Python_Path = "/usr/bin/python3"           // python3 path
        APP_PATH = "app"                          // application path
        VENV_PATH = "venv"                       // virtual environment path
        sonar_home = "sonarqube"                // sonarqube home path
    }
    stages {
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
                        coverage xml -o coverage.xml  # generate coverage report in xml format
                    """
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('sonarqube', credentialsId: 'jenkins-sonar', installationName: 'sonarqube') {
                        sh """
                            cd ${env.APP_PATH}
                            . ${env.VENV_PATH}/bin/activate
                            sonar-scanner \
                            -Dsonar.projectKey=ahmed-sonarqube \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://localhost:9000
                        """
                    }
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'app/report.xml, app/unit_test_report.xml, app/coverage.xml', fingerprint: true
        }
    }
}
