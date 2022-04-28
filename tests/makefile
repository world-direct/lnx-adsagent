file="dind20-context-tcp.yaml"

drop: 
	kubectl delete pod dind20-test

create:
	kubectl apply -f $(file)

recreate: drop create

describe:
	kubectl describe pod dind20-test

logs: 
	kubectl logs dind20-test -c dind
	kubectl logs dind20-test -c cmd

exec:
	 kubectl exec dind20-test -it -c cmd -- sh
