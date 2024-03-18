
provider "helm" {
  kubernetes {
  config_path = var.path_to_kubconfig
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-monitoring-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "56.9.0"
  create_namespace = true
  namespace = "kube-monitoring"
  values = ["${file("./values/chart-monitoring.yaml")}"]
  depends_on = [
    yandex_kubernetes_node_group.node_group
  ]
}

resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = "kube-system"
  version = "4.10.0"
  depends_on = [
    helm_release.kube_prometheus_stack,
  yandex_kubernetes_cluster.kuber-cluster,
  yandex_kubernetes_node_group.node_group
  ]
  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "false"
  }
}

resource "helm_release" "test-app" {
  name       = "test-app"
  repository = "https://midokura.github.io/helm-charts-community/"
  chart      = "nginx-static"
  version    = "0.1.3"
#  create_namespace = true
#  namespace = "test-app"
  values = ["${file("./values/test-app.yaml")}"]
  depends_on = [
    yandex_kubernetes_node_group.node_group
  ]
}
