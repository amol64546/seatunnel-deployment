kubectl create ns seatunnel

kubectl create configmap seatunnel-config \
  --from-file=hazelcast-master.yaml \
  --from-file=hazelcast-worker.yaml \
  --from-file=hazelcast-client.yaml \
  --from-file=log4j2.properties \
  --from-file=seatunnel.yaml \
  --namespace=seatunnel


kubectl apply -f seatunnel-pvc.yaml -n seatunnel
kubectl apply -f seatunnel-master-pvc.yaml -n seatunnel

kubectl apply -f seatunnel-master.yaml -n seatunnel
kubectl apply -f seatunnel-worker.yaml -n seatunnel

kubectl apply -f seatunnel-master-service.yaml -n seatunnel
kubectl apply -f seatunnel-worker-service.yaml -n seatunnel
kubectl apply -f seatunnel-master-external-service.yaml -n seatunnel

kubectl apply -f seatunnel-worker-hpa.yaml -n seatunnel

# bash bin/install-plugin.sh

# kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.11/connectors/plugin-mapping.properties \
#   seatunnel-master-0:/opt/seatunnel/connectors -n seatunnel

kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.11/connectors/. \
  seatunnel-master-0:/opt/seatunnel/connectors -n seatunnel

kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.11/lib/. \
  seatunnel-master-0:/opt/seatunnel/lib -n seatunnel
