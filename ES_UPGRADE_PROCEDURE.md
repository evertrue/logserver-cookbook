# Elasticsearch Upgrade Procedure:

1. Converge new Chef version
2. Install the new version of ElasticSearch:
```
$ dpkg -i /var/chef/cache/elasticsearch-2.4.0.deb
```
3. Delete all of the old plugins:
```
rm -rf /usr/share/elasticsearch/plugins/*
```
4. Converge chef again
