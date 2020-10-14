#!/usr/bin/bash
echo "Install PostgreSQL 11 Server"
dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf module disable -y postgresql
dnf clean all
dnf -y install postgresql11-server postgresql11

echo "Install PostGIS"
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install -y dnf-plugins-core 
dnf config-manager --set-enabled PowerTools
dnf config-manager --set-enabled PowerTools
dnf module disable postgresql
dnf install -y postgis30_11
dnf downgrade gdal31-libs.x86_64 3.1.3-1.rhel8
dnf install 'dnf-command(versionlock)'
dnf versionlock add gdal31-libs.x86_64