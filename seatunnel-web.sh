helm install mysql bitnami/mysql \
  --set auth.rootPassword=mysql \
  --set auth.username=mysql \
  --set auth.password=mysql \
  --set auth.database=seatunnel \
  -n seatunnel
  
kubectl create configmap seatunnel-web-config \
  --from-file=application.yml \
  --from-file=hazelcast-client.yaml \
  --from-file=plugin-mapping.properties \
  --from-file=connector-datasource-mapper.yaml \
  --namespace=seatunnel
  

kubectl apply -f seatunnel-web-pvc.yaml
kubectl apply -f seatunnel-web.yaml
kubectl apply -f seatunnel-web-service.yaml



kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-web-1.0.2-bin/libs/. \
  seatunnel-web-54659c7f78-xx6f6:/opt/seatunnel-web/libs -n seatunnel

