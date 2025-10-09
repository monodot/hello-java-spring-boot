// Based on:
// https://raw.githubusercontent.com/redhat-cop/container-pipelines/master/basic-spring-boot/Jenkinsfile
pipeline {
    options {
        // set a timeout of 60 minutes for this pipeline
        timeout(time: 5, unit: 'MINUTES')
    }

    environment {
        DEV_PROJECT = "mavc23-dev"
        APP_NAME = "hello-java-spring-boot"        
        APP_GIT_URL = "https://github.com/m1k3dcdc/hello-java-spring-boot.git"
    }
    
    agent any
    
    stages {
        stage('Create Container Image') {
          steps {
            echo '### Create Container Image... ###'
            
            script {
              openshift.withCluster() {
                openshift.withProject("$DEV_PROJECT") {
                    echo "### Using project: ${openshift.project()}"
                    def buildConfigExists = openshift.selector("bc", "hello-java-spring-boot-bc").exists()
                    
                    echo "### BuildConfig: " + APP_NAME + " exists, start new build to update app ..."
                    if (!buildConfigExists) {
                        echo "### newBuild " + APP_NAME + " does not exist" 
                        openshift.newBuild("--name=hello-java-spring-boot-bc", "--image=docker.io/m1k3pjem/hello-java-spring-boot", "--binary")

                        if (!openshift.selector("route", APP_NAME).exists()) {
                            echo "### Route " + APP_NAME + " does not exist, exposing service ..." 
                            //def service = openshift.selector("service", APP_NAME)
                            //service.expose()
                        } else {
                            echo "### Route " + APP_NAME + " exist" 
                        }    
                    }    
                    openshift.selector("bc", "hello-java-spring-boot-bc").startBuild("--from-dir=.", "--follow")    
                }    
              }
            }
          }
        }

        stage('Deploy') {
          steps {
            echo 'Deploying....'
            script {
              openshift.withCluster() {
                openshift.withProject("mavc23-dev") {
    
                  def deployment = openshift.selector("dc", "hello-java-spring-boot")
    
                  if(!deployment.exists()){
                    //openshift.newApp('hello-java-spring-boot', "--as-deployment-config").narrow('svc').expose()
                    sh "oc apply -f . -n mavc23-dev"
                  }
    
                }
              }
            }
          }
        }

    }
}
