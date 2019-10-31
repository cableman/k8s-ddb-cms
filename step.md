# Build DDB

docker run --rm -v ${PWD}:/app itkdev/drush6:latest make --concurrency=1 --contrib-destination=profiles/ding2/ --working-copy --force-complete https://raw.githubusercontent.com/ding2/ding2/master/drupal.make htdocs

docker run --rm -v ${PWD}/htdocs:/app -it node:6 /bin/bash -c "cd /app/profiles/ding2/themes/ddbasic/ && npm install"

docker run --rm -v ${PWD}/htdocs:/app -it node:6 /bin/bash -c "cd /app/profiles/ding2/themes/ddbasic/ && node_modules/.bin/gulp uglify sass"

rm -rf htdocs/profiles/ding2/themes/ddbasic/node_modules



# Build php application container

docker build --tag=itkdev/ddb-cms .
docker push itkdev/ddb-cms

# Deployment

kubectl config set-context --current --namespace=ddbcms

kubectl create secret generic ddbcms --from-literal=password="db" --from-literal=username="db"

