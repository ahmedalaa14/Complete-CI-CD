pipeline {
    agent any
    environment {
        Docker_Image = "ahmedalaa14/flask-app-mini"  // Docker Image Name       
        Docker_Credential = "DockerHub-Credentail"  // Docker ID  
        Python_Path = "/usr/bin/python3"           // python3 path
        APP_PATH = "app"                          // application path
    }
    stages {
        stage('Build and Test App') {
            steps {
                script {
                    sh """ 
                        cd ${env.APP_PATH}
                        ${env.Python_Path} -m pip install pytest
                        ${env.Python_Path} -m pytest --junitxml=report.xml    // generate test report
                       """
                }
            }
        }
        stage('Unit Tests') {
            steps {
                script {
                    sh """ 
                        cd ${env.APP_PATH}
                        ${env.Python_Path} -m pip install coverage
                        ${env.Python_Path} -m coverage run -m pytest --junitxml=unit_test_report.xml              // run unit tests with coverage and generate report
                        ${env.Python_Path} -m coverage xml -o coverage.xml                                         // generate coverage report in xml format
                       """
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'report.xml, unit_test_report.xml, coverage.xml', fingerprint: true
        }
    }
}