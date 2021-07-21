#!/bin/bash

function install() {
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo add bitnami https://charts.bitnami.com/bitnami

  helm install prom prometheus-community/kube-prometheus-stack -f prometheus.yml
  helm install postgres bitnami/postgresql -f ./postgresql.yml
  helm install userservice ./userservice-chart
  return
}

function test() {
  local i=1
  while true
  do
    curl -X POST http://arch.homework/user -H "Content-Type: application/json" -d '{"username": "ttttt"}'
    curl -X GET "http://arch.homework/user/$i"
    curl -X PUT "http://arch.homework/user/$i" -H "Content-Type: application/json" -d '{"username": "ttttt2"}'
    curl -X DELETE "http://arch.homework/user/$i"
    ((i++))
    sleep 1
  done
  return
}

function destroy() {
  helm uninstall userservice
  helm uninstall postgres
  helm uninstall prom
  return
}

function loaddashboards() {
    curl -X POST http://arch.homework.grafana/api/dashboards/import -H "Content-Type: application/json" -d ./user-service-dashboard-request.json
    curl -X POST http://arch.homework.grafana/api/dashboards/import -H "Content-Type: application/json" -d ./postgres-dashboard-request.json
}

case "$1" in
"install")
  install
  ;;
"destroy")
  destroy
  ;;
"test")
  test
  ;;
"loaddashboards")
  loaddashboards
  ;;
esac