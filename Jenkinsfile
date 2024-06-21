pipeline {
    agent any
    enviroment {
        registry = 'albonio/lanza_dados'
        registryCredentials = 'dockerhub'
        project = 'practica-devops'
        projectVersion = '1.0'
        repository = 'https://github.com/albonio/practica_git'
        repositoryCredentials = 'github'
    }

    stages {
        stage('Se limpia el workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout del código del repositorio') {
            steps {
                git branch: 'main',
                    credentialsId: repositoryCredentials,
                    url: repository
            }
        }
        stage('Se construye la imagen del contenedor') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        stage('Se hace un test para ver que todo ha ido bien') {
            steps {
                script {
                    try {
                        sh 'docker run --name $project $registry'
                    }
                    finally {
                        sh 'docker rm $project'
                    }
                }
            }
        }
        stage('Subimos la imagen a Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'El pipeline ha fallado.'
        }
    }
}
