# Delve Demo

## Prerequisit

- Install delve with `go install github.com/go-delve/delve/cmd/dlv@latest`

## Create a kind cluster

```bash
$ kubectl create cluster
```

## Install the pod and expose the ports
```bash
# Deploy the pod
$ kubectl apply -f deploy

# Expose the delve endpoint at port 40000, expose "hello, world!" endpoint at port 8000.
# Must be ran in its own terminal or as a background process.
$ kubectl port-forward pods/delve-demo 8000:8000 40000:40000
```

## Configure VS Code to connect to the exposed delve port

You'll need to use [VS Code to configure a breakpoint](https://code.visualstudio.com/Docs/editor/debugging) on [line 14 of main.go](https://github.com/awgreene/delve-remote-debugging-demo/blob/673188ba3c8f06cb740856a229d833b311752777/main.go#L14) and then run the debugger using the Remote Debugging launch profile.

## Curl the http endpoint

```bash
$ curl localhost:8000
Hello, visitor! # Will not appear until you instruct delve to move past the breakpoint via vs code
```