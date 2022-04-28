.ONESHELL: # make cd work

image=lnx-adsagent
tag=dev

dev-build-image:
	cd image
	docker build -t $(image):$(tag) .

dev-install-kind: dev-build-image
	kind load docker-image $(image):$(tag)
	kustomize build ./kustomize/dev | kubectl apply -f -

dev-uninstall-kind: 
	kustomize build ./kustomize/dev | kubectl delete -f -
