## 1.5.0

* add support for multiple index names for _aliases call
* New ref for kibana: cf87e131b08071bf846b253cc49146da76077ef6
* Lock in a specific kibana UI release

## 1.4.0

* Enable udp injection

## 1.3.7

* Set custom config value bulk.udp.enabled to true
* Pre-create redis log file

## 1.3.6:

* Clean up default dashboard display

## 1.3.5:

* Clean up Logstash Kibana dashboard JSON

## 1.3.4:

* Upgrade to Redis 2.8.3

## 1.3.3:

* Use correct path to Kibana dashboards to install our custom dashboard

## 1.3.2:

* Use bleeding-edge version of Kibana cookbook & Redis cookbook to fix some bugs
* Use built source of Kibana instead of cloning entire repository
* Clean up some code (Ruby style, Vagrantfile, etc.)
* Pin Berkshelf to ~> 2.0.10
* Remove unused attributes

## 1.3.1:

* Disable debug logging

## 1.3.0:

* Disable redundant logrotate_app resource instance
* Fix column width on Kibana dashboard
* Fix FC002: Avoid string interpolation where not required: recipes/ui.rb:15
* Added loadbalancer settings to attributes

## 1.2.0:

* Added basic auth to UI
* Changed below version from 1.0.2 (incorrect) to 1.1.0

## 1.1.0:

* Moved UI stuff to its own recipe
* Started managing Kibana dashboard from Chef
* Removed extraneous SYSLOG5424PRI and SYSLOG5424SD lines from rsyslog Grok pattern
*

## 1.0.1:

* First revision!
