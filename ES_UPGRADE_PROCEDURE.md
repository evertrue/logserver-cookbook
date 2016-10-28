# Elasticsearch Upgrade Procedure for 2.3 -> 2.4:

1. Converge Chef
2. Install the new version of ElasticSearch:
```
$ dpkg -i /var/chef/cache/elasticsearch-2.4.0.deb
```
3. Delete all of the old plugins:
```
rm -rf /usr/share/elasticsearch/plugins/*
```
4. Converge chef again
5. Restart Elasticsearch (one node at a time, only when the cluster is in green state!):
```
service elasticsearch restart
```
