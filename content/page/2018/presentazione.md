+++
title = "Premio Arte e Cultura 2018"
date = 2018-05-22T12:59:38+02:00
[menu.2018]
+++
Generate sitemaps and their index at request by bot or browser alike, using Content Collector as a source

### Env

Environment variables passed to startup commands or set in an .env file override values set in docker-compose file.
Default behavior is using production Content Collector.

### Local development

```
docker-compose -f docker-compose.yml -f docker-compose-dev.yml build
```
```
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```

### Run tests

Test on a running local instance in another shell:

```
virtualenv -p python3.5 v
```

```
source v/bin/activate
```
```
pip install -r requirements.txt
```
```
python -m test
```

### Deploy

```
eval $(docker-machine env isdoc01)
```

```
docker-compose build
```

```
docker-compose up -d
```
![La Mascotte ufficiale del premio](/img/coniglio_mannaro.png)
