logserver cookbook CHANGELOG
============================
This file is used to list changes made in each version of the logserver cookbook.

v1.6.1 (2014-06-03)
-------------------

* Fix template compatibility problems with new version of rsyslog cookbook

v1.6.0 (2014-05-13)
-------------------

* Ping rsyslog dependency to v1.12.2
* Remove rsyslog.conf.erb template & adjust attributes as needed to maintain current functionality
* Set up Test Kitchen, Berkshelf 3, and Rake tasks for testing


v1.5.0 (2014-01-09)
------------------

* add support for multiple index names for _aliases call
* New ref for kibana: cf87e131b08071bf846b253cc49146da76077ef6
* Lock in a specific kibana UI release

v1.4.0 (2014-01-09)
------------------

* Enable udp injection

v1.3.7 (2014-01-08)
------------------

* Set custom config value bulk.udp.enabled to true
* Pre-create redis log file

v1.3.6: (2013-12-19)
-------------------

* Clean up default dashboard display

v1.3.5: (2013-12-17)
-------------------

* Clean up Logstash Kibana dashboard JSON

v1.3.4: (2013-12-17)
-------------------

* Upgrade to Redis 2.8.3

v1.3.3: (2013-12-17)
-------------------

* Use correct path to Kibana dashboards to install our custom dashboard

v1.3.2: (2013-12-12)
-------------------

* Use bleeding-edge version of Kibana cookbook & Redis cookbook to fix some bugs
* Use built source of Kibana instead of cloning entire repository
* Clean up some code (Ruby style, Vagrantfile, etc.)
* Pin Berkshelf to ~> 2.0.10
* Remove unused attributes

v1.3.1: (2013-09-12)
-------------------

* Disable debug logging

v1.3.0: (2013-08-23)
-------------------

* Disable redundant logrotate_app resource instance
* Fix column width on Kibana dashboard
* Fix FC002: Avoid string interpolation where not required: recipes/ui.rb:15
* Added loadbalancer settings to attributes

v1.2.0: (2013-08-19)
-------------------

* Added basic auth to UI
* Changed below version from 1.0.2 (incorrect) to 1.1.0

v1.1.0: (2013-08-13)
-------------------

* Moved UI stuff to its own recipe
* Started managing Kibana dashboard from Chef
* Removed extraneous SYSLOG5424PRI and SYSLOG5424SD lines from rsyslog Grok pattern

v1.0.1: (2013-08-09)
-------------------

* First revision!
