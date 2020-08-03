docker build -t olester/multi-client:latest -t olester/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olester/multi-server:latest -t olester/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olester/multi-worker:latest -t olester/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olester/multi-client:latest
docker push olester/multi-server:latest
docker push olester/multi-worker:latest

docker push olester/multi-client:$SHA
docker push olester/multi-server:$SHA
docker push olester/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olester/multi-server:$SHA
kubectl set image deployments/client-deployment client=olester/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olester/multi-worker:$SHA
