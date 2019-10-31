This is in no way the right way to run this site in kubernetes as the images used is not lightweight etc.

But it is used to learn something about k8s.

# Build DDB

```
docker run --rm -v ${PWD}:/app itkdev/drush6:latest make --concurrency=1 --contrib-destination=profiles/ding2/ --working-copy --force-complete https://raw.githubusercontent.com/ding2/ding2/master/drupal.make htdocs
```

```
docker run --rm -v ${PWD}/htdocs:/app -it node:6 /bin/bash -c "cd /app/profiles/ding2/themes/ddbasic/ && npm install"
```

```
docker run --rm -v ${PWD}/htdocs:/app -it node:6 /bin/bash -c "cd /app/profiles/ding2/themes/ddbasic/ && node_modules/.bin/gulp uglify sass"
```

```
rm -rf htdocs/profiles/ding2/themes/ddbasic/node_modules
```



# Build php application container

```
docker build --tag=itkdev/ddb-cms .
docker push itkdev/ddb-cms
```

# Deployment

Change the default namespace so you don't have to have `--namespace=ddbcms` on every kubectl command.

```
kubectl apply -f k8s/ddbcms-namespace.yaml
kubectl config set-context --current --namespace=ddbcms
```

Start the deployment.
```
kubeclt apply -f ddbcms-pvc.yaml -f ddbcms-database.yaml -f ddbcms-deployment.yaml -f ddbcms-nginx-deployment.yaml 
kubectl create secret generic ddbcms --from-literal=password="db" --from-literal=username="db"
```

# Hacks
You might need to go into the ddbcms pod(s) and install drush and do a `drush cgen` to make DDB CMS generate the theme corretly to be able to login.

```
kubectl exec -it <POD NAME> -- /bin/bash
```