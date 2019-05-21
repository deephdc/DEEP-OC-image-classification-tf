#!/usr/bin/groovy

@Library(['github.com/indigo-dc/jenkins-pipeline-library@1.2.3']) _

pipeline {
    agent {
        label 'docker-build'
    }

    environment {
        dockerhub_repo = "deephdc/deep-oc-image-classification-tf"
        tf_ver = "1.12.0"
        py_ver = "py3"
    }

    stages {
        stage('Docker image building') {
            when {
                anyOf {
                    branch 'master'
                    branch 'test'
                    buildingTag()
                }
            }
            steps{
                checkout scm
                script {
                    id = "${env.dockerhub_repo}"
                    
                    if (env.BRANCH_NAME == 'master') {
                        // CPU
                        id_cpu = DockerBuild(
                            id,
                            tag: ['latest', 'cpu'],
                            build_args: [
                                "tag=${env.tf_ver}",
                                "pyVer=${env.py_ver}",
                                "branch=master"
                            ]
                        )
                        // GPU
                        id_gpu = DockerBuild(
                            id,
                            tag: ['gpu'],
                            build_args: [
                                "tag=${env.tf_ver}-gpu",
                                "pyVer=${env.py_ver}",
                                "branch=master"
                            ]                            
                        )
                    }
                    if (env.BRANCH_NAME == 'test') {
                        // CPU
                        id_cpu = DockerBuild(
                            id,
                            tag: ['test', 'cpu-test'],
                            build_args: [
                                "tag=${env.tf_ver}",
                                "pyVer=${env.py_ver}",
                                "branch=test"
                            ]
                        )
                        // GPU
                        id_gpu = DockerBuild(
                            id,
                            tag: ['gpu-test'],
                            build_args: [
                                "tag=${env.tf_ver}-gpu",
                                "pyVer=${env.py_ver}",
                                "branch=test"
                            ]                            
                        )
                    }
                }
            }
        }
          
        stage('Docker Hub delivery') {
            when {
                anyOf {
                    branch 'master'
                    branch 'test'
                    buildingTag()
                }
            }
            steps {
                script {
                    DockerPush(id_cpu)
                    DockerPush(id_gpu)
                }
            }
            post {
                failure {
                    DockerClean()
                }
                always {
                    cleanWs()
                }
            }
        }

        stage("Render metadata on the marketplace") {
            when {
                allOf {
                    branch 'master'
                    changeset 'metadata.json'
                }
            }
            steps {
                script {
                    def job_result = JenkinsBuildJob("Pipeline-as-code/deephdc.github.io/pelican")
                    job_result_url = job_result.absoluteUrl
                }
            }
        }
    }
}
