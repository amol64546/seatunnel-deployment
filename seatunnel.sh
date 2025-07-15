kubectl create ns seatunnel

kubectl create configmap seatunnel-config \
  --from-file=hazelcast-master.yaml \
  --from-file=hazelcast-worker.yaml \
  --from-file=hazelcast-client.yaml \
  --from-file=log4j2.properties \
  --from-file=seatunnel.yaml \
  --namespace=seatunnel


kubectl apply -f seatunnel-pvc.yaml
kubectl apply -f seatunnel-master-pvc.yaml

kubectl apply -f seatunnel-master.yaml
kubectl apply -f seatunnel-worker.yaml

kubectl apply -f seatunnel-master-service.yaml
kubectl apply -f seatunnel-worker-service.yaml
kubectl apply -f seatunnel-master-external-service.yaml

kubectl apply -f seatunnel-worker-hpa.yaml



kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.11/connectors/. \
  seatunnel-master-0:/opt/seatunnel/connectors -n seatunnel

kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.11/lib/. \
  seatunnel-master-0:/opt/seatunnel/lib -n seatunnel

kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.9/connectors/. \
  seatunnel-master-0:/opt/seatunnel/connectors -n seatunnel

kubectl cp /home/gaian/Downloads/seatunnel/apache-seatunnel-2.3.9/lib/. \
  seatunnel-master-0:/opt/seatunnel/lib -n seatunnel