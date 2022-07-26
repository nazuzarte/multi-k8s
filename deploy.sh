#build the images
docker build -t nzuzarte/multi-client:latest -t nzuzarte/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nzuzarte/multi-server:latest -t nzuzarte/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nzuzarte/multi-worker:latest -t nzuzarte/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#push specific tagged images to docker hub
docker push nzuzarte/multi-client:latest
docker push nzuzarte/multi-server:latest
docker push nzuzarte/multi-worker:latest

docker push nzuzarte/multi-client:$SHA
docker push nzuzarte/multi-server:$SHA
docker push nzuzarte/multi-worker:$SHA

#apply latest version of config files inside k8s directory
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nzuzarte/multi-client:$SHA
kubectl set image deployments/server-deployment server=nzuzarte/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nzuzarte/multi-worker:$SHA