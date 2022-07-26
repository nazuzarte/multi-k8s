#build the images
docker build -t nazuzarte/multi-client:latest -t nazuzarte/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nazuzarte/multi-server:latest -t nazuzarte/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nazuzarte/multi-worker:latest -t nazuzarte/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#push specific tagged images to docker hub
docker push nazuzarte/multi-client:latest
docker push nazuzarte/multi-server:latest
docker push nazuzarte/multi-worker:latest

docker push nazuzarte/multi-client:$SHA
docker push nazuzarte/multi-server:$SHA
docker push nazuzarte/multi-worker:$SHA

#apply latest version of config files inside k8s directory
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nazuzarte/multi-client:$SHA
kubectl set image deployments/server-deployment server=nazuzarte/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nazuzarte/multi-worker:$SHA