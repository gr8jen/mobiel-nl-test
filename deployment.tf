#
#resource "kubernetes_deployment" "ror-hello" {
#  metadata {
#    name = "ror-hello-example"
#    labels = {
#      App = "ScalableRoRExample"
#    }
#  }
#  spec {
#    replicas = 1
#    selector {
#      match_labels = {
#        App = "ScalableRoRExample"
#      }
#    }
#    template {
#      metadata {
#        labels = {
#          App = "hello-app"
#        }
#      }
#      spec {
#        container {
#          image = "europe-west4-docker.pkg.dev/mobiel-nl-test/hello-repo/helloworld-gke:latest"
#          name  = "hello-app"
#
#          port {
#            container_port = 8080
#          }
#
#          resources {
#            limits = {
#              cpu    = "0.5"
#              memory = "512Mi"
#            }
#            requests = {
#              cpu    = "250m"
#              memory = "50Mi"
#            }
#          }
#        }
#      }
#    }
#  }
#}
#
#
#
#resource "kubernetes_deployment" "nginx" {
#  metadata {
#    name = "scalable-nginx-example"
#    labels = {
#      App = "ScalableNginxExample"
#    }
#  }
#
#  spec {
#    replicas = 2
#    selector {
#      match_labels = {
#        App = "ScalableNginxExample"
#      }
#    }
#    template {
#      metadata {
#        labels = {
#          App = "ScalableNginxExample"
#        }
#      }
#      spec {
#        container {
#          image = "nginx:1.7.8"
#          name  = "example"
#
#          port {
#            container_port = 80
#          }
#
#          resources {
#            limits = {
#              cpu    = "0.5"
#              memory = "512Mi"
#            }
#            requests = {
#              cpu    = "250m"
#              memory = "50Mi"
#            }
#          }
#        }
#      }
#    }
#  }
#}