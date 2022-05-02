image=lnx-adsagent
tag=dev

build-image:
	cd image && \
	docker build -t $(image):$(tag) .

kind-install: build-image
	kind load docker-image $(image):$(tag)
	kustomize build ./kustomize/dev | kubectl apply -f -
	kubectl describe pod 

kind-uninstall: 
	kustomize build ./kustomize/dev | kubectl delete -f -

kind-logs:
	kubectl logs lnx-adsagent-dev-0 -c ads-agent

kind-exec-it:
	kubectl exec lnx-adsagent-dev-0 -c ads-agent -it -- bash

