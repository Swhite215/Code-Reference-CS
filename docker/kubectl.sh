kubectl run
kubectl create
kubectl apply
kubectl version

kubectl run my-nginx --image nginx
kubectl get pods
kubectl get all

kubectl create deployment my-nginx --image nginx
kubectl create deployment my-apache --image httpd
kubectl scale deploy/my-apache --replicas 2
kubectl scale deploy my-apache --replicas 2

kubectl logs deployment/my-apache --follow --tail 1
kubectl logs -l run=my-apache
kuebctl describe pod my-apache-xxxxxx-xxx
kubectl delete pod my-apache-xxxxxx-xxxw
