%packages

# Exclude unwanted groups that fedora-live-base.ks pulls in
-@dial-up
-@input-methods
-@standard

# Make sure to sync any additions / removals done here with
# enablement-gateway in comps


# Exclude unwanted packages from @anaconda-tools group
-gfs2-utils
-reiserfs-utils

# Dependencies
autossh
create_ap
dnsmasq
ifdokccid
libselinux-python
libsemanage-python
mariadb-server
mysql-connector-python
NetworkManager
NetworkManager-wifi
nginx
python
python-firewall
python2-dnf
python2-mysql
tar

#
enablement-repo
enablement-gateway

%end
