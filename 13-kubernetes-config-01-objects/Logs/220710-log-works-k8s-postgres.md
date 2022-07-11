### Ход работ 220710

```
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ifconfig
bash: ifconfig: command not found
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt install net-tools
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package net-tools
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt install net tools
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package net
E: Unable to locate package tools
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit                 
logout
command terminated with exit code 100
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# cat /etc/*release
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@fb-pod-65b9777746-5ztxd:/app# apt installing list
E: Invalid operation installing
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt --help
apt 1.8.2.3 (amd64)
Usage: apt [options] command

apt is a commandline package manager and provides commands for
searching and managing as well as querying information about packages.
It provides the same functionality as the specialized APT tools,
like apt-get and apt-cache, but enables options more suitable for
interactive use by default.

Most used commands:
  list - list packages based on package names
  search - search in package descriptions
  show - show package details
  install - install packages
  reinstall - reinstall packages
  remove - remove packages
  autoremove - Remove automatically all unused packages
  update - update list of available packages
  upgrade - upgrade the system by installing/upgrading packages
  full-upgrade - upgrade the system by removing/installing/upgrading packages
  edit-sources - edit the source information file

See apt(8) for more information about the available commands.
Configuration options and syntax is detailed in apt.conf(5).
Information about how to configure sources can be found in sources.list(5).
Package and version choices can be expressed via apt_preferences(5).
Security details are available in apt-secure(8).
                                        This APT has Super Cow Powers.
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt list
Listing... Done
adduser/now 3.118 all [installed,local]
apt/now 1.8.2.3 amd64 [installed,local]
autoconf/now 2.69-11 all [installed,local]
automake/now 1:1.16.1-4 all [installed,local]
autotools-dev/now 20180224.1 all [installed,local]
base-files/now 10.3+deb10u12 amd64 [installed,local]
base-passwd/now 3.5.46 amd64 [installed,local]
bash/now 5.0-4 amd64 [installed,local]
binutils-common/now 2.31.1-16 amd64 [installed,local]
binutils-x86-64-linux-gnu/now 2.31.1-16 amd64 [installed,local]
binutils/now 2.31.1-16 amd64 [installed,local]
bsdutils/now 1:2.33.1-0.1 amd64 [installed,local]
bzip2/now 1.0.6-9.2~deb10u1 amd64 [installed,local]
ca-certificates/now 20200601~deb10u2 all [installed,local]
comerr-dev/now 2.1-1.44.5-1+deb10u3 amd64 [installed,local]
coreutils/now 8.30-3 amd64 [installed,local]
cpp-8/now 8.3.0-6 amd64 [installed,local]
cpp/now 4:8.3.0-1 amd64 [installed,local]
curl/now 7.64.0-4+deb10u2 amd64 [installed,local]
dash/now 0.5.10.2-5 amd64 [installed,local]
debconf/now 1.5.71+deb10u1 all [installed,local]
debian-archive-keyring/now 2019.1+deb10u1 all [installed,local]
debianutils/now 4.8.6.1 amd64 [installed,local]
default-libmysqlclient-dev/now 1.0.5 amd64 [installed,local]
diffutils/now 1:3.7-3 amd64 [installed,local]
dirmngr/now 2.2.12-1+deb10u1 amd64 [installed,local]
dpkg-dev/now 1.19.8 all [installed,local]
dpkg/now 1.19.8 amd64 [installed,local]
e2fsprogs/now 1.44.5-1+deb10u3 amd64 [installed,local]
fdisk/now 2.33.1-0.1 amd64 [installed,local]
file/now 1:5.35-4+deb10u2 amd64 [installed,local]
findutils/now 4.6.0+git+20190209-2 amd64 [installed,local]
fontconfig-config/now 2.13.1-2 all [installed,local]
fontconfig/now 2.13.1-2 amd64 [installed,local]
fonts-dejavu-core/now 2.37-1 all [installed,local]
g++-8/now 8.3.0-6 amd64 [installed,local]
g++/now 4:8.3.0-1 amd64 [installed,local]
gcc-8-base/now 8.3.0-6 amd64 [installed,local]
gcc-8/now 8.3.0-6 amd64 [installed,local]
gcc/now 4:8.3.0-1 amd64 [installed,local]
gir1.2-freedesktop/now 1.58.3-2 amd64 [installed,local]
gir1.2-gdkpixbuf-2.0/now 2.38.1+dfsg-1 amd64 [installed,local]
gir1.2-glib-2.0/now 1.58.3-2 amd64 [installed,local]
gir1.2-rsvg-2.0/now 2.44.10-2.1 amd64 [installed,local]
git-man/now 1:2.20.1-2+deb10u3 all [installed,local]
git/now 1:2.20.1-2+deb10u3 amd64 [installed,local]
gnupg-l10n/now 2.2.12-1+deb10u1 all [installed,local]
gnupg-utils/now 2.2.12-1+deb10u1 amd64 [installed,local]
gnupg/now 2.2.12-1+deb10u1 all [installed,local]
gpg-agent/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpg-wks-client/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpg-wks-server/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpg/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpgconf/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpgsm/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpgv/now 2.2.12-1+deb10u1 amd64 [installed,local]
grep/now 3.3-1 amd64 [installed,local]
gzip/now 1.9-3+deb10u1 amd64 [installed,local]
hicolor-icon-theme/now 0.17-2 all [installed,local]
hostname/now 3.21 amd64 [installed,local]
icu-devtools/now 63.1-6+deb10u3 amd64 [installed,local]
imagemagick-6-common/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
imagemagick-6.q16/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
imagemagick/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
init-system-helpers/now 1.56+nmu1 all [installed,local]
iproute2/now 4.20.0-2+deb10u1 amd64 [installed,local]
iputils-ping/now 3:20180629-2+deb10u2 amd64 [installed,local]
krb5-multidev/now 1.17-3+deb10u3 amd64 [installed,local]
libacl1/now 2.2.53-4 amd64 [installed,local]
libapr1/now 1.6.5-1+b1 amd64 [installed,local]
libaprutil1/now 1.6.1-4 amd64 [installed,local]
libapt-pkg5.0/now 1.8.2.3 amd64 [installed,local]
libasan5/now 8.3.0-6 amd64 [installed,local]
libassuan0/now 2.5.2-1 amd64 [installed,local]
libatomic1/now 8.3.0-6 amd64 [installed,local]
libattr1/now 1:2.4.48-4 amd64 [installed,local]
libaudit-common/now 1:2.8.4-3 all [installed,local]
libaudit1/now 1:2.8.4-3 amd64 [installed,local]
libbinutils/now 2.31.1-16 amd64 [installed,local]
libblkid-dev/now 2.33.1-0.1 amd64 [installed,local]
libblkid1/now 2.33.1-0.1 amd64 [installed,local]
libbluetooth-dev/now 5.50-1.2~deb10u2 amd64 [installed,local]
libbluetooth3/now 5.50-1.2~deb10u2 amd64 [installed,local]
libbsd0/now 0.9.1-2+deb10u1 amd64 [installed,local]
libbz2-1.0/now 1.0.6-9.2~deb10u1 amd64 [installed,local]
libbz2-dev/now 1.0.6-9.2~deb10u1 amd64 [installed,local]
libc-bin/now 2.28-10+deb10u1 amd64 [installed,local]
libc-dev-bin/now 2.28-10+deb10u1 amd64 [installed,local]
libc6-dev/now 2.28-10+deb10u1 amd64 [installed,local]
libc6/now 2.28-10+deb10u1 amd64 [installed,local]
libcairo-gobject2/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcairo-script-interpreter2/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcairo2-dev/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcairo2/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcap-ng0/now 0.7.9-2 amd64 [installed,local]
libcap2-bin/now 1:2.25-2 amd64 [installed,local]
libcap2/now 1:2.25-2 amd64 [installed,local]
libcc1-0/now 8.3.0-6 amd64 [installed,local]
libcom-err2/now 1.44.5-1+deb10u3 amd64 [installed,local]
libcroco3/now 0.6.12-3 amd64 [installed,local]
libcurl3-gnutls/now 7.64.0-4+deb10u2 amd64 [installed,local]
libcurl4-openssl-dev/now 7.64.0-4+deb10u2 amd64 [installed,local]
libcurl4/now 7.64.0-4+deb10u2 amd64 [installed,local]
libdatrie1/now 0.2.12-2 amd64 [installed,local]
libdb-dev/now 5.3.1+nmu1 amd64 [installed,local]
libdb5.3-dev/now 5.3.28+dfsg1-0.5 amd64 [installed,local]
libdb5.3/now 5.3.28+dfsg1-0.5 amd64 [installed,local]
libde265-0/now 1.0.3-1+b1 amd64 [installed,local]
libdebconfclient0/now 0.249 amd64 [installed,local]
libdjvulibre-dev/now 3.5.27.1-10+deb10u1 amd64 [installed,local]
libdjvulibre-text/now 3.5.27.1-10+deb10u1 all [installed,local]
libdjvulibre21/now 3.5.27.1-10+deb10u1 amd64 [installed,local]
libdpkg-perl/now 1.19.8 all [installed,local]
libedit2/now 3.1-20181209-1 amd64 [installed,local]
libelf1/now 0.176-1.1 amd64 [installed,local]
liberror-perl/now 0.17027-2 all [installed,local]
libevent-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-core-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-dev/now 2.1.8-stable-4 amd64 [installed,local]
libevent-extra-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-openssl-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-pthreads-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libexif-dev/now 0.6.21-5.1+deb10u5 amd64 [installed,local]
libexif12/now 0.6.21-5.1+deb10u5 amd64 [installed,local]
libexpat1-dev/now 2.2.6-2+deb10u4 amd64 [installed,local]
libexpat1/now 2.2.6-2+deb10u4 amd64 [installed,local]
libext2fs2/now 1.44.5-1+deb10u3 amd64 [installed,local]
libfdisk1/now 2.33.1-0.1 amd64 [installed,local]
libffi-dev/now 3.2.1-9 amd64 [installed,local]
libffi6/now 3.2.1-9 amd64 [installed,local]
libfftw3-double3/now 3.3.8-2 amd64 [installed,local]
libfontconfig1-dev/now 2.13.1-2 amd64 [installed,local]
libfontconfig1/now 2.13.1-2 amd64 [installed,local]
libfreetype6-dev/now 2.9.1-3+deb10u2 amd64 [installed,local]
libfreetype6/now 2.9.1-3+deb10u2 amd64 [installed,local]
libfribidi0/now 1.0.5-3.1+deb10u1 amd64 [installed,local]
libgcc-8-dev/now 8.3.0-6 amd64 [installed,local]
libgcc1/now 1:8.3.0-6 amd64 [installed,local]
libgcrypt20/now 1.8.4-5+deb10u1 amd64 [installed,local]
libgdbm-compat4/now 1.18.1-4 amd64 [installed,local]
libgdbm-dev/now 1.18.1-4 amd64 [installed,local]
libgdbm6/now 1.18.1-4 amd64 [installed,local]
libgdk-pixbuf2.0-0/now 2.38.1+dfsg-1 amd64 [installed,local]
libgdk-pixbuf2.0-bin/now 2.38.1+dfsg-1 amd64 [installed,local]
libgdk-pixbuf2.0-common/now 2.38.1+dfsg-1 all [installed,local]
libgdk-pixbuf2.0-dev/now 2.38.1+dfsg-1 amd64 [installed,local]
libgirepository-1.0-1/now 1.58.3-2 amd64 [installed,local]
libglib2.0-0/now 2.58.3-2+deb10u3 amd64 [installed,local]
libglib2.0-bin/now 2.58.3-2+deb10u3 amd64 [installed,local]
libglib2.0-data/now 2.58.3-2+deb10u3 all [installed,local]
libglib2.0-dev-bin/now 2.58.3-2+deb10u3 amd64 [installed,local]
libglib2.0-dev/now 2.58.3-2+deb10u3 amd64 [installed,local]
libgmp-dev/now 2:6.1.2+dfsg-4+deb10u1 amd64 [installed,local]
libgmp10/now 2:6.1.2+dfsg-4+deb10u1 amd64 [installed,local]
libgmpxx4ldbl/now 2:6.1.2+dfsg-4+deb10u1 amd64 [installed,local]
libgnutls-dane0/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutls-openssl27/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutls28-dev/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutls30/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutlsxx28/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgomp1/now 8.3.0-6 amd64 [installed,local]
libgpg-error0/now 1.35-1 amd64 [installed,local]
libgraphite2-3/now 1.3.13-7 amd64 [installed,local]
libgssapi-krb5-2/now 1.17-3+deb10u3 amd64 [installed,local]
libgssrpc4/now 1.17-3+deb10u3 amd64 [installed,local]
libharfbuzz0b/now 2.3.1-1 amd64 [installed,local]
libheif1/now 1.3.2-2~deb10u1 amd64 [installed,local]
libhogweed4/now 3.4.1-1+deb10u1 amd64 [installed,local]
libice-dev/now 2:1.0.9-2 amd64 [installed,local]
libice6/now 2:1.0.9-2 amd64 [installed,local]
libicu-dev/now 63.1-6+deb10u3 amd64 [installed,local]
libicu63/now 63.1-6+deb10u3 amd64 [installed,local]
libidn2-0/now 2.0.5-1+deb10u1 amd64 [installed,local]
libidn2-dev/now 2.0.5-1+deb10u1 amd64 [installed,local]
libilmbase-dev/now 2.2.1-2 amd64 [installed,local]
libilmbase23/now 2.2.1-2 amd64 [installed,local]
libisl19/now 0.20-2 amd64 [installed,local]
libitm1/now 8.3.0-6 amd64 [installed,local]
libjbig-dev/now 2.1-3.1+b2 amd64 [installed,local]
libjbig0/now 2.1-3.1+b2 amd64 [installed,local]
libjpeg-dev/now 1:1.5.2-2+deb10u1 all [installed,local]
libjpeg62-turbo-dev/now 1:1.5.2-2+deb10u1 amd64 [installed,local]
libjpeg62-turbo/now 1:1.5.2-2+deb10u1 amd64 [installed,local]
libk5crypto3/now 1.17-3+deb10u3 amd64 [installed,local]
libkadm5clnt-mit11/now 1.17-3+deb10u3 amd64 [installed,local]
libkadm5srv-mit11/now 1.17-3+deb10u3 amd64 [installed,local]
libkdb5-9/now 1.17-3+deb10u3 amd64 [installed,local]
libkeyutils1/now 1.6-6 amd64 [installed,local]
libkrb5-3/now 1.17-3+deb10u3 amd64 [installed,local]
libkrb5-dev/now 1.17-3+deb10u3 amd64 [installed,local]
libkrb5support0/now 1.17-3+deb10u3 amd64 [installed,local]
libksba8/now 1.3.5-2 amd64 [installed,local]
liblcms2-2/now 2.9-3 amd64 [installed,local]
liblcms2-dev/now 2.9-3 amd64 [installed,local]
libldap-2.4-2/now 2.4.47+dfsg-3+deb10u7 amd64 [installed,local]
libldap-common/now 2.4.47+dfsg-3+deb10u7 all [installed,local]
liblqr-1-0-dev/now 0.4.2-2.1 amd64 [installed,local]
liblqr-1-0/now 0.4.2-2.1 amd64 [installed,local]
liblsan0/now 8.3.0-6 amd64 [installed,local]
libltdl-dev/now 2.4.6-9 amd64 [installed,local]
libltdl7/now 2.4.6-9 amd64 [installed,local]
liblz4-1/now 1.8.3-1+deb10u1 amd64 [installed,local]
liblzma-dev/now 5.2.4-1+deb10u1 amd64 [installed,local]
liblzma5/now 5.2.4-1+deb10u1 amd64 [installed,local]
liblzo2-2/now 2.10-0.1 amd64 [installed,local]
libmagic-mgc/now 1:5.35-4+deb10u2 amd64 [installed,local]
libmagic1/now 1:5.35-4+deb10u2 amd64 [installed,local]
libmagickcore-6-arch-config/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-6-headers/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmagickcore-6.q16-6-extra/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-6.q16-6/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-6.q16-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmagickwand-6-headers/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmagickwand-6.q16-6/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickwand-6.q16-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickwand-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmariadb-dev-compat/now 1:10.3.34-0+deb10u1 amd64 [installed,local]
libmariadb-dev/now 1:10.3.34-0+deb10u1 amd64 [installed,local]
libmariadb3/now 1:10.3.34-0+deb10u1 amd64 [installed,local]
libmaxminddb-dev/now 1.3.2-1+deb10u1 amd64 [installed,local]
libmaxminddb0/now 1.3.2-1+deb10u1 amd64 [installed,local]
libmnl0/now 1.0.4-2 amd64 [installed,local]
libmount-dev/now 2.33.1-0.1 amd64 [installed,local]
libmount1/now 2.33.1-0.1 amd64 [installed,local]
libmpc3/now 1.1.0-1 amd64 [installed,local]
libmpdec2/now 2.4.2-2 amd64 [installed,local]
libmpfr6/now 4.0.2-1 amd64 [installed,local]
libmpx2/now 8.3.0-6 amd64 [installed,local]
libncurses-dev/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncurses5-dev/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncurses6/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncursesw5-dev/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncursesw6/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libnettle6/now 3.4.1-1+deb10u1 amd64 [installed,local]
libnghttp2-14/now 1.36.0-2+deb10u1 amd64 [installed,local]
libnpth0/now 1.6-1 amd64 [installed,local]
libnuma1/now 2.0.12-1 amd64 [installed,local]
libopenexr-dev/now 2.2.1-4.1+deb10u1 amd64 [installed,local]
libopenexr23/now 2.2.1-4.1+deb10u1 amd64 [installed,local]
libopenjp2-7-dev/now 2.3.0-2+deb10u2 amd64 [installed,local]
libopenjp2-7/now 2.3.0-2+deb10u2 amd64 [installed,local]
libp11-kit-dev/now 0.23.15-2+deb10u1 amd64 [installed,local]
libp11-kit0/now 0.23.15-2+deb10u1 amd64 [installed,local]
libpam-modules-bin/now 1.3.1-5 amd64 [installed,local]
libpam-modules/now 1.3.1-5 amd64 [installed,local]
libpam-runtime/now 1.3.1-5 all [installed,local]
libpam0g/now 1.3.1-5 amd64 [installed,local]
libpango-1.0-0/now 1.42.4-8~deb10u1 amd64 [installed,local]
libpangocairo-1.0-0/now 1.42.4-8~deb10u1 amd64 [installed,local]
libpangoft2-1.0-0/now 1.42.4-8~deb10u1 amd64 [installed,local]
libpcre16-3/now 2:8.39-12 amd64 [installed,local]
libpcre2-8-0/now 10.32-5 amd64 [installed,local]
libpcre3-dev/now 2:8.39-12 amd64 [installed,local]
libpcre32-3/now 2:8.39-12 amd64 [installed,local]
libpcre3/now 2:8.39-12 amd64 [installed,local]
libpcrecpp0v5/now 2:8.39-12 amd64 [installed,local]
libperl5.28/now 5.28.1-6+deb10u1 amd64 [installed,local]
libpixman-1-0/now 0.36.0-1 amd64 [installed,local]
libpixman-1-dev/now 0.36.0-1 amd64 [installed,local]
libpng-dev/now 1.6.36-6 amd64 [installed,local]
libpng16-16/now 1.6.36-6 amd64 [installed,local]
libpq-dev/now 11.16-0+deb10u1 amd64 [installed,local]
libpq5/now 11.16-0+deb10u1 amd64 [installed,local]
libprocps7/now 2:3.3.15-2 amd64 [installed,local]
libpsl5/now 0.20.2-2 amd64 [installed,local]
libpthread-stubs0-dev/now 0.4-1 amd64 [installed,local]
libpython-stdlib/now 2.7.16-1 amd64 [installed,local]
libpython2-stdlib/now 2.7.16-1 amd64 [installed,local]
libpython2.7-minimal/now 2.7.16-2+deb10u1 amd64 [installed,local]
libpython2.7-stdlib/now 2.7.16-2+deb10u1 amd64 [installed,local]
libpython3-stdlib/now 3.7.3-1 amd64 [installed,local]
libpython3.7-minimal/now 3.7.3-2+deb10u3 amd64 [installed,local]
libpython3.7-stdlib/now 3.7.3-2+deb10u3 amd64 [installed,local]
libquadmath0/now 8.3.0-6 amd64 [installed,local]
libreadline-dev/now 7.0-5 amd64 [installed,local]
libreadline7/now 7.0-5 amd64 [installed,local]
librsvg2-2/now 2.44.10-2.1 amd64 [installed,local]
librsvg2-common/now 2.44.10-2.1 amd64 [installed,local]
librsvg2-dev/now 2.44.10-2.1 amd64 [installed,local]
librtmp1/now 2.4+20151223.gitfa8646d.1-2 amd64 [installed,local]
libsasl2-2/now 2.1.27+dfsg-1+deb10u2 amd64 [installed,local]
libsasl2-modules-db/now 2.1.27+dfsg-1+deb10u2 amd64 [installed,local]
libseccomp2/now 2.3.3-4 amd64 [installed,local]
libselinux1-dev/now 2.8-1+b1 amd64 [installed,local]
libselinux1/now 2.8-1+b1 amd64 [installed,local]
libsemanage-common/now 2.8-2 all [installed,local]
libsemanage1/now 2.8-2 amd64 [installed,local]
libsepol1-dev/now 2.8-1 amd64 [installed,local]
libsepol1/now 2.8-1 amd64 [installed,local]
libserf-1-1/now 1.3.9-7+b10 amd64 [installed,local]
libsigsegv2/now 2.12-2 amd64 [installed,local]
libsm-dev/now 2:1.2.3-1 amd64 [installed,local]
libsm6/now 2:1.2.3-1 amd64 [installed,local]
libsmartcols1/now 2.33.1-0.1 amd64 [installed,local]
libsqlite3-0/now 3.27.2-3+deb10u1 amd64 [installed,local]
libsqlite3-dev/now 3.27.2-3+deb10u1 amd64 [installed,local]
libss2/now 1.44.5-1+deb10u3 amd64 [installed,local]
libssh2-1/now 1.8.0-2.1 amd64 [installed,local]
libssl-dev/now 1.1.1n-0+deb10u2 amd64 [installed,local]
libssl1.1/now 1.1.1n-0+deb10u2 amd64 [installed,local]
libstdc++-8-dev/now 8.3.0-6 amd64 [installed,local]
libstdc++6/now 8.3.0-6 amd64 [installed,local]
libsvn1/now 1.10.4-1+deb10u3 amd64 [installed,local]
libsystemd0/now 241-7~deb10u8 amd64 [installed,local]
libtasn1-6-dev/now 4.13-3 amd64 [installed,local]
libtasn1-6/now 4.13-3 amd64 [installed,local]
libtcl8.6/now 8.6.9+dfsg-2 amd64 [installed,local]
libthai-data/now 0.1.28-2 all [installed,local]
libthai0/now 0.1.28-2 amd64 [installed,local]
libtiff-dev/now 4.1.0+git191117-2~deb10u4 amd64 [installed,local]
libtiff5/now 4.1.0+git191117-2~deb10u4 amd64 [installed,local]
libtiffxx5/now 4.1.0+git191117-2~deb10u4 amd64 [installed,local]
libtinfo6/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libtk8.6/now 8.6.9-2 amd64 [installed,local]
libtool/now 2.4.6-9 all [installed,local]
libtsan0/now 8.3.0-6 amd64 [installed,local]
libubsan1/now 8.3.0-6 amd64 [installed,local]
libudev1/now 241-7~deb10u8 amd64 [installed,local]
libunbound8/now 1.9.0-2+deb10u2 amd64 [installed,local]
libunistring2/now 0.9.10-1 amd64 [installed,local]
libutf8proc2/now 2.3.0-1 amd64 [installed,local]
libuuid1/now 2.33.1-0.1 amd64 [installed,local]
libwebp-dev/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwebp6/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwebpdemux2/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwebpmux3/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwmf-dev/now 0.2.8.4-14 amd64 [installed,local]
libwmf0.2-7/now 0.2.8.4-14 amd64 [installed,local]
libx11-6/now 2:1.6.7-1+deb10u2 amd64 [installed,local]
libx11-data/now 2:1.6.7-1+deb10u2 all [installed,local]
libx11-dev/now 2:1.6.7-1+deb10u2 amd64 [installed,local]
libx265-165/now 2.9-4 amd64 [installed,local]
libxau-dev/now 1:1.0.8-1+b2 amd64 [installed,local]
libxau6/now 1:1.0.8-1+b2 amd64 [installed,local]
libxcb-render0-dev/now 1.13.1-2 amd64 [installed,local]
libxcb-render0/now 1.13.1-2 amd64 [installed,local]
libxcb-shm0-dev/now 1.13.1-2 amd64 [installed,local]
libxcb-shm0/now 1.13.1-2 amd64 [installed,local]
libxcb1-dev/now 1.13.1-2 amd64 [installed,local]
libxcb1/now 1.13.1-2 amd64 [installed,local]
libxdmcp-dev/now 1:1.1.2-3 amd64 [installed,local]
libxdmcp6/now 1:1.1.2-3 amd64 [installed,local]
libxext-dev/now 2:1.3.3-1+b2 amd64 [installed,local]
libxext6/now 2:1.3.3-1+b2 amd64 [installed,local]
libxft-dev/now 2.3.2-2 amd64 [installed,local]
libxft2/now 2.3.2-2 amd64 [installed,local]
libxml2-dev/now 2.9.4+dfsg1-7+deb10u4 amd64 [installed,local]
libxml2/now 2.9.4+dfsg1-7+deb10u4 amd64 [installed,local]
libxrender-dev/now 1:0.9.10-1 amd64 [installed,local]
libxrender1/now 1:0.9.10-1 amd64 [installed,local]
libxslt1-dev/now 1.1.32-2.2~deb10u1 amd64 [installed,local]
libxslt1.1/now 1.1.32-2.2~deb10u1 amd64 [installed,local]
libxss-dev/now 1:1.2.3-1 amd64 [installed,local]
libxss1/now 1:1.2.3-1 amd64 [installed,local]
libxt-dev/now 1:1.1.5-1+b3 amd64 [installed,local]
libxt6/now 1:1.1.5-1+b3 amd64 [installed,local]
libxtables12/now 1.8.2-4 amd64 [installed,local]
libyaml-0-2/now 0.2.1-1 amd64 [installed,local]
libyaml-dev/now 0.2.1-1 amd64 [installed,local]
libzstd1/now 1.3.8+dfsg-3+deb10u2 amd64 [installed,local]
linux-libc-dev/now 4.19.235-1 amd64 [installed,local]
login/now 1:4.5-1.1 amd64 [installed,local]
lsb-base/now 10.2019051400 all [installed,local]
m4/now 1.4.18-2 amd64 [installed,local]
make/now 4.2.1-1.2 amd64 [installed,local]
mariadb-common/now 1:10.3.34-0+deb10u1 all [installed,local]
mawk/now 1.3.3-17+b3 amd64 [installed,local]
mercurial-common/now 4.8.2-1+deb10u1 all [installed,local]
mercurial/now 4.8.2-1+deb10u1 amd64 [installed,local]
mime-support/now 3.62 all [installed,local]
mount/now 2.33.1-0.1 amd64 [installed,local]
mysql-common/now 5.8+1.0.5 all [installed,local]
ncurses-base/now 6.1+20181013-2+deb10u2 all [installed,local]
ncurses-bin/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
netbase/now 5.6 all [installed,local]
nettle-dev/now 3.4.1-1+deb10u1 amd64 [installed,local]
openssh-client/now 1:7.9p1-10+deb10u2 amd64 [installed,local]
openssl/now 1.1.1n-0+deb10u2 amd64 [installed,local]
passwd/now 1:4.5-1.1 amd64 [installed,local]
patch/now 2.7.6-3+deb10u1 amd64 [installed,local]
perl-base/now 5.28.1-6+deb10u1 amd64 [installed,local]
perl-modules-5.28/now 5.28.1-6+deb10u1 all [installed,local]
perl/now 5.28.1-6+deb10u1 amd64 [installed,local]
pinentry-curses/now 1.1.0-2 amd64 [installed,local]
pkg-config/now 0.29-6 amd64 [installed,local]
procps/now 2:3.3.15-2 amd64 [installed,local]
python-minimal/now 2.7.16-1 amd64 [installed,local]
python2-minimal/now 2.7.16-1 amd64 [installed,local]
python2.7-minimal/now 2.7.16-2+deb10u1 amd64 [installed,local]
python2.7/now 2.7.16-2+deb10u1 amd64 [installed,local]
python2/now 2.7.16-1 amd64 [installed,local]
python3-distutils/now 3.7.3-1 all [installed,local]
python3-lib2to3/now 3.7.3-1 all [installed,local]
python3-minimal/now 3.7.3-1 amd64 [installed,local]
python3.7-minimal/now 3.7.3-2+deb10u3 amd64 [installed,local]
python3.7/now 3.7.3-2+deb10u3 amd64 [installed,local]
python3/now 3.7.3-1 amd64 [installed,local]
python/now 2.7.16-1 amd64 [installed,local]
readline-common/now 7.0-5 all [installed,local]
sed/now 4.7-1 amd64 [installed,local]
sensible-utils/now 0.0.12 all [installed,local]
shared-mime-info/now 1.10-1 amd64 [installed,local]
subversion/now 1.10.4-1+deb10u3 amd64 [installed,local]
sysvinit-utils/now 2.93-8 amd64 [installed,local]
tar/now 1.30+dfsg-6 amd64 [installed,local]
tcl-dev/now 8.6.9+1 amd64 [installed,local]
tcl8.6-dev/now 8.6.9+dfsg-2 amd64 [installed,local]
tcl8.6/now 8.6.9+dfsg-2 amd64 [installed,local]
tcl/now 8.6.9+1 amd64 [installed,local]
tk-dev/now 8.6.9+1 amd64 [installed,local]
tk8.6-dev/now 8.6.9-2 amd64 [installed,local]
tk8.6/now 8.6.9-2 amd64 [installed,local]
tk/now 8.6.9+1 amd64 [installed,local]
tzdata/now 2021a-0+deb10u5 all [installed,local]
ucf/now 3.0038+nmu1 all [installed,local]
unzip/now 6.0-23+deb10u2 amd64 [installed,local]
util-linux/now 2.33.1-0.1 amd64 [installed,local]
uuid-dev/now 2.33.1-0.1 amd64 [installed,local]
wget/now 1.20.1-1.1 amd64 [installed,local]
x11-common/now 1:7.7+19 all [installed,local]
x11proto-core-dev/now 2018.4-4 all [installed,local]
x11proto-dev/now 2018.4-4 all [installed,local]
x11proto-scrnsaver-dev/now 2018.4-4 all [installed,local]
x11proto-xext-dev/now 2018.4-4 all [installed,local]
xorg-sgml-doctools/now 1:1.11-1 all [installed,local]
xtrans-dev/now 1.3.5-1 all [installed,local]
xz-utils/now 5.2.4-1+deb10u1 amd64 [installed,local]
zlib1g-dev/now 1:1.2.11.dfsg-1+deb10u1 amd64 [installed,local]
zlib1g/now 1:1.2.11.dfsg-1+deb10u1 amd64 [installed,local]
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c frontend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt list
Listing... Done
adduser/now 3.118 all [installed,local]
apt/now 2.2.4 amd64 [installed,local]
base-files/now 11.1+deb11u3 amd64 [installed,local]
base-passwd/now 3.5.51 amd64 [installed,local]
bash/now 5.1-2+b3 amd64 [installed,local]
bsdutils/now 1:2.36.1-8+deb11u1 amd64 [installed,local]
ca-certificates/now 20210119 all [installed,local]
coreutils/now 8.32-4+b1 amd64 [installed,local]
curl/now 7.74.0-1.3+deb11u1 amd64 [installed,local]
dash/now 0.5.11+git20200708+dd9ef66-5 amd64 [installed,local]
debconf/now 1.5.77 all [installed,local]
debian-archive-keyring/now 2021.1.1 all [installed,local]
debianutils/now 4.11.2 amd64 [installed,local]
diffutils/now 1:3.7-5 amd64 [installed,local]
dpkg/now 1.20.10 amd64 [installed,local]
e2fsprogs/now 1.46.2-2 amd64 [installed,local]
findutils/now 4.8.0-1 amd64 [installed,local]
fontconfig-config/now 2.13.1-4.2 all [installed,local]
fonts-dejavu-core/now 2.37-2 all [installed,local]
gcc-10-base/now 10.2.1-6 amd64 [installed,local]
gcc-9-base/now 9.3.0-22 amd64 [installed,local]
gettext-base/now 0.21-4 amd64 [installed,local]
gpgv/now 2.2.27-2+deb11u1 amd64 [installed,local]
grep/now 3.6-1 amd64 [installed,local]
gzip/now 1.10-4+deb11u1 amd64 [installed,local]
hostname/now 3.23 amd64 [installed,local]
init-system-helpers/now 1.60 all [installed,local]
libacl1/now 2.2.53-10 amd64 [installed,local]
libapt-pkg6.0/now 2.2.4 amd64 [installed,local]
libattr1/now 1:2.4.48-6 amd64 [installed,local]
libaudit-common/now 1:3.0-2 all [installed,local]
libaudit1/now 1:3.0-2 amd64 [installed,local]
libblkid1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libbrotli1/now 1.0.9-2+b2 amd64 [installed,local]
libbsd0/now 0.11.3-1 amd64 [installed,local]
libbz2-1.0/now 1.0.8-4 amd64 [installed,local]
libc-bin/now 2.31-13+deb11u3 amd64 [installed,local]
libc6/now 2.31-13+deb11u3 amd64 [installed,local]
libcap-ng0/now 0.7.9-2.2+b1 amd64 [installed,local]
libcom-err2/now 1.46.2-2 amd64 [installed,local]
libcrypt1/now 1:4.4.18-4 amd64 [installed,local]
libcurl4/now 7.74.0-1.3+deb11u1 amd64 [installed,local]
libdb5.3/now 5.3.28+dfsg1-0.8 amd64 [installed,local]
libdebconfclient0/now 0.260 amd64 [installed,local]
libdeflate0/now 1.7-1 amd64 [installed,local]
libexpat1/now 2.2.10-2+deb11u3 amd64 [installed,local]
libext2fs2/now 1.46.2-2 amd64 [installed,local]
libffi7/now 3.3-6 amd64 [installed,local]
libfontconfig1/now 2.13.1-4.2 amd64 [installed,local]
libfreetype6/now 2.10.4+dfsg-1 amd64 [installed,local]
libgcc-s1/now 10.2.1-6 amd64 [installed,local]
libgcrypt20/now 1.8.7-6 amd64 [installed,local]
libgd3/now 2.3.0-2 amd64 [installed,local]
libgeoip1/now 1.6.12-7 amd64 [installed,local]
libgmp10/now 2:6.2.1+dfsg-1+deb11u1 amd64 [installed,local]
libgnutls30/now 3.7.1-5 amd64 [installed,local]
libgpg-error0/now 1.38-2 amd64 [installed,local]
libgssapi-krb5-2/now 1.18.3-6+deb11u1 amd64 [installed,local]
libhogweed6/now 3.7.3-1 amd64 [installed,local]
libicu67/now 67.1-7 amd64 [installed,local]
libidn2-0/now 2.3.0-5 amd64 [installed,local]
libjbig0/now 2.1-3.1+b2 amd64 [installed,local]
libjpeg62-turbo/now 1:2.0.6-4 amd64 [installed,local]
libk5crypto3/now 1.18.3-6+deb11u1 amd64 [installed,local]
libkeyutils1/now 1.6.1-2 amd64 [installed,local]
libkrb5-3/now 1.18.3-6+deb11u1 amd64 [installed,local]
libkrb5support0/now 1.18.3-6+deb11u1 amd64 [installed,local]
libldap-2.4-2/now 2.4.57+dfsg-3+deb11u1 amd64 [installed,local]
liblz4-1/now 1.9.3-2 amd64 [installed,local]
liblzma5/now 5.2.5-2.1~deb11u1 amd64 [installed,local]
libmd0/now 1.0.3-3 amd64 [installed,local]
libmount1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libnettle8/now 3.7.3-1 amd64 [installed,local]
libnghttp2-14/now 1.43.0-1 amd64 [installed,local]
libnsl2/now 1.3.0-2 amd64 [installed,local]
libp11-kit0/now 0.23.22-1 amd64 [installed,local]
libpam-modules-bin/now 1.4.0-9+deb11u1 amd64 [installed,local]
libpam-modules/now 1.4.0-9+deb11u1 amd64 [installed,local]
libpam-runtime/now 1.4.0-9+deb11u1 all [installed,local]
libpam0g/now 1.4.0-9+deb11u1 amd64 [installed,local]
libpcre2-8-0/now 10.36-2 amd64 [installed,local]
libpcre3/now 2:8.39-13 amd64 [installed,local]
libpng16-16/now 1.6.37-3 amd64 [installed,local]
libpsl5/now 0.21.0-1.2 amd64 [installed,local]
libreadline8/now 8.1-1 amd64 [installed,local]
librtmp1/now 2.4+20151223.gitfa8646d.1-2+b2 amd64 [installed,local]
libsasl2-2/now 2.1.27+dfsg-2.1+deb11u1 amd64 [installed,local]
libsasl2-modules-db/now 2.1.27+dfsg-2.1+deb11u1 amd64 [installed,local]
libseccomp2/now 2.5.1-1+deb11u1 amd64 [installed,local]
libselinux1/now 3.1-3 amd64 [installed,local]
libsemanage-common/now 3.1-1 all [installed,local]
libsemanage1/now 3.1-1+b2 amd64 [installed,local]
libsepol1/now 3.1-1 amd64 [installed,local]
libsmartcols1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libss2/now 1.46.2-2 amd64 [installed,local]
libssh2-1/now 1.9.0-2 amd64 [installed,local]
libssl1.1/now 1.1.1n-0+deb11u2 amd64 [installed,local]
libstdc++6/now 10.2.1-6 amd64 [installed,local]
libsystemd0/now 247.3-7 amd64 [installed,local]
libtasn1-6/now 4.16.0-2 amd64 [installed,local]
libtiff5/now 4.2.0-1+deb11u1 amd64 [installed,local]
libtinfo6/now 6.2+20201114-2 amd64 [installed,local]
libtirpc-common/now 1.3.1-1 all [installed,local]
libtirpc3/now 1.3.1-1 amd64 [installed,local]
libudev1/now 247.3-7 amd64 [installed,local]
libunistring2/now 0.9.10-4 amd64 [installed,local]
libuuid1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libwebp6/now 0.6.1-2.1 amd64 [installed,local]
libx11-6/now 2:1.7.2-1 amd64 [installed,local]
libx11-data/now 2:1.7.2-1 all [installed,local]
libxau6/now 1:1.0.9-1 amd64 [installed,local]
libxcb1/now 1.14-3 amd64 [installed,local]
libxdmcp6/now 1:1.1.2-3 amd64 [installed,local]
libxml2/now 2.9.10+dfsg-6.7+deb11u2 amd64 [installed,local]
libxpm4/now 1:3.5.12-1 amd64 [installed,local]
libxslt1.1/now 1.1.34-4 amd64 [installed,local]
libxxhash0/now 0.8.0-2 amd64 [installed,local]
libzstd1/now 1.4.8+dfsg-2.1 amd64 [installed,local]
login/now 1:4.8.1-1 amd64 [installed,local]
logsave/now 1.46.2-2 amd64 [installed,local]
lsb-base/now 11.1.0 all [installed,local]
mawk/now 1.3.4.20200120-2 amd64 [installed,local]
mount/now 2.36.1-8+deb11u1 amd64 [installed,local]
ncurses-base/now 6.2+20201114-2 all [installed,local]
ncurses-bin/now 6.2+20201114-2 amd64 [installed,local]
nginx-module-geoip/now 1.23.0-1~bullseye amd64 [installed,local]
nginx-module-image-filter/now 1.23.0-1~bullseye amd64 [installed,local]
nginx-module-njs/now 1.23.0+0.7.5-1~bullseye amd64 [installed,local]
nginx-module-xslt/now 1.23.0-1~bullseye amd64 [installed,local]
nginx/now 1.23.0-1~bullseye amd64 [installed,local]
openssl/now 1.1.1n-0+deb11u2 amd64 [installed,local]
passwd/now 1:4.8.1-1 amd64 [installed,local]
perl-base/now 5.32.1-4+deb11u2 amd64 [installed,local]
readline-common/now 8.1-1 all [installed,local]
sed/now 4.7-1 amd64 [installed,local]
sensible-utils/now 0.0.14 all [installed,local]
sysvinit-utils/now 2.96-7+deb11u1 amd64 [installed,local]
tar/now 1.34+dfsg-1 amd64 [installed,local]
tzdata/now 2021a-1+deb11u4 all [installed,local]
ucf/now 3.0043 all [installed,local]
util-linux/now 2.36.1-8+deb11u1 amd64 [installed,local]
zlib1g/now 1:1.2.11.dfsg-2+deb11u1 amd64 [installed,local]
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt install update
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package update
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ls -lha
total 420K
drwxr-xr-x 1 root root 4.0K Jul  4 12:30 .
drwxr-xr-x 1 root root 4.0K Jul  5 16:12 ..
-rw-r--r-- 1 root root   30 Jul  4 09:09 .env
-rw-r--r-- 1 root root   30 Jul  4 09:09 .env.example
-rw-r--r-- 1 root root  387 Jul  4 09:09 Dockerfile
drwxr-xr-x 2 root root 4.0K Jul  4 09:09 build
-rw-r--r-- 1 root root  344 Jul  4 09:09 demo.conf
-rw-r--r-- 1 root root  448 Jul  4 09:09 index.html
-rw-r--r-- 1 root root  344 Jul  4 09:09 item.html
drwxr-xr-x 2 root root 4.0K Jul  4 09:09 js
-rw-r--r-- 1 root root   80 Jul  4 09:09 list.json
-rw-r--r-- 1 root root 357K Jul  4 09:09 package-lock.json
-rw-r--r-- 1 root root 1.1K Jul  4 09:09 package.json
drwxr-xr-x 2 root root 4.0K Jul  4 09:09 static
drwxr-xr-x 3 root root 4.0K Jul  4 09:09 styles
-rw-r--r-- 1 root root 2.8K Jul  4 09:09 webpack.config.js
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod fb-pod-65b9777746-5ztxd 
Name:         fb-pod-65b9777746-5ztxd
Namespace:    default
Priority:     0
Node:         node1/10.128.0.23
Start Time:   Tue, 05 Jul 2022 20:12:55 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: 271035e70868fe385bb0d184b83dfb330b00ab2961805be7a1875c36c0ea443e
              cni.projectcalico.org/podIP: 10.233.90.8/32
              cni.projectcalico.org/podIPs: 10.233.90.8/32
Status:       Running
IP:           10.233.90.8
IPs:
  IP:           10.233.90.8
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://b09be2c662873735b4cff1273342f68cbf16c4cc977773a7f7ebcfa801c7e9bb
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 05 Jul 2022 20:12:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrdhr (ro)
  backend:
    Container ID:   containerd://e26ddfa7a7f6d3c2654c06a561672a97448b3fda9081505448e1c9d70aa223a7
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 20:12:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrdhr (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-vrdhr:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ping 10.233.90.8
PING 10.233.90.8 (10.233.90.8) 56(84) bytes of data.
^C
--- 10.233.90.8 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1031ms

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          11h   10.233.96.12   node2   <none>           <none>
fb-pod-65b9777746-5ztxd   2/2     Running   0          12h   10.233.90.8    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -i -t -- bash -il
db-0:/# 
db-0:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if19: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1430 qdisc noqueue state UP 
    link/ether 0e:e6:b4:ce:ff:22 brd ff:ff:ff:ff:ff:ff
    inet 10.233.96.12/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::ce6:b4ff:fece:ff22/64 scope link 
       valid_lft forever preferred_lft forever
db-0:/# 
db-0:/# curl 127.1:5432
bash: curl: command not found
db-0:/# 
db-0:/# apt install curl
bash: apt: command not found
db-0:/# 
db-0:/# cat /etc/*release
3.16.0
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.16.0
PRETTY_NAME="Alpine Linux v3.16"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
db-0:/# 
db-0:/# 
db-0:/# ap list
bash: ap: command not found
db-0:/# 
db-0:/# apt list
bash: apt: command not found
db-0:/# 
db-0:/# yum
bash: yum: command not found
db-0:/# 
db-0:/# ps -aux
ps: unrecognized option: u
BusyBox v1.35.0 (2022-05-09 17:27:12 UTC) multi-call binary.

Usage: ps [-o COL1,COL2=HEADER] [-T]

Show list of processes

	-o COL1,COL2=HEADER	Select columns for display
	-T			Show threads
db-0:/# 
db-0:/# ps
PID   USER     TIME  COMMAND
    1 postgres  0:00 postgres
   50 postgres  0:00 postgres: checkpointer 
   51 postgres  0:00 postgres: background writer 
   52 postgres  0:00 postgres: walwriter 
   53 postgres  0:00 postgres: autovacuum launcher 
   54 postgres  0:00 postgres: stats collector 
   55 postgres  0:00 postgres: logical replication launcher 
  766 root      0:00 bash -il
  789 root      0:00 ps
db-0:/# 
db-0:/# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# cd
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 10.233.96.12:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-5ztxd:~# curl 10.233.96.12:30159
curl: (7) Failed to connect to 10.233.96.12 port 30159: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping 10.233.0.124
PING 10.233.0.124 (10.233.0.124) 56(84) bytes of data.
64 bytes from 10.233.0.124: icmp_seq=1 ttl=64 time=0.074 ms
64 bytes from 10.233.0.124: icmp_seq=2 ttl=64 time=0.067 ms
^C
--- 10.233.0.124 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 22ms
rtt min/avg/max/mdev = 0.067/0.070/0.074/0.009 ms
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 10.233.0.124:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ^C
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping backend
ping: backend: Name or service not known
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# hostname
fb-pod-65b9777746-5ztxd
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping fb-pod
ping: fb-pod: Name or service not known
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping fb-pod-65b9777746-5ztxd
PING fb-pod-65b9777746-5ztxd (10.233.90.8) 56(84) bytes of data.
64 bytes from fb-pod-65b9777746-5ztxd (10.233.90.8): icmp_seq=1 ttl=64 time=0.020 ms
64 bytes from fb-pod-65b9777746-5ztxd (10.233.90.8): icmp_seq=2 ttl=64 time=0.043 ms
64 bytes from fb-pod-65b9777746-5ztxd (10.233.90.8): icmp_seq=3 ttl=64 time=0.037 ms
^C
--- fb-pod-65b9777746-5ztxd ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 49ms
rtt min/avg/max/mdev = 0.020/0.033/0.043/0.010 ms
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:9000
curl: (7) Failed to connect to 127.1 port 9000: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:9001
curl: (7) Failed to connect to 127.1 port 9001: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:8000
curl: (7) Failed to connect to 127.1 port 8000: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:80
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ host -t A google.com
google.com has address 216.58.211.14
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   24m   v1.24.2
node1   Ready    <none>          23m   v1.24.2
node2   Ready    <none>          23m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 .
drwxrwxr-x 4 maestro maestro 4,0K июн 28 10:45 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  5 15:24 main
drwxrwxr-x 2 maestro maestro 4,0K июл  5 20:31 postgres
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ cd postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 24K
drwxrwxr-x 2 maestro maestro 4,0K июл  5 20:31 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  761 июл  5 20:31 db.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  774 июл  5 19:00 web-services.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mv web-services.yaml web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 24K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:16 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  761 июл  5 20:31 db.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  774 июл  5 19:00 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat web-app.yaml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-svc
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 31000
  selector:
    app: fb


maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 28K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:31 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  761 июл  5 20:31 db.yaml
-rw-rw-r-- 1 maestro maestro  187 июл  6 12:20 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat db.yaml 
# Config PostgreSQL StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: db-svc
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 32K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:35 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro  187 июл  6 12:20 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-app.yaml 
deployment.apps/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-65b9777746-4bnxq   2/2     Running   0          95s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   61m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe po fb-pod-65b9777746-4bnxq 
Name:         fb-pod-65b9777746-4bnxq
Namespace:    default
Priority:     0
Node:         node2/10.128.0.11
Start Time:   Wed, 06 Jul 2022 12:47:04 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: baf7cf62c528742c8e7b5e9ac4b054d06a4d70206304e9d5822b652097dbb954
              cni.projectcalico.org/podIP: 10.233.96.1/32
              cni.projectcalico.org/podIPs: 10.233.96.1/32
Status:       Running
IP:           10.233.96.1
IPs:
  IP:           10.233.96.1
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://31553e0dc4b6d025d77dbfcfe279e486a2ee2331f9021d297e38e8f028887738
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 06 Jul 2022 12:47:15 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8hbtd (ro)
  backend:
    Container ID:   containerd://1705f4cde30a711f7725a5f382af83d9f859b4776a62ac7fe8ad230fcb915b95
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 06 Jul 2022 12:47:42 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8hbtd (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-8hbtd:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  2m5s  default-scheduler  Successfully assigned default/fb-pod-65b9777746-4bnxq to node2
  Normal  Pulling    2m3s  kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     114s  kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 8.854779289s
  Normal  Created    114s  kubelet            Created container frontend
  Normal  Started    114s  kubelet            Started container frontend
  Normal  Pulling    114s  kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     87s   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 26.723509834s
  Normal  Created    87s   kubelet            Created container backend
  Normal  Started    86s   kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   90m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -- curl backend
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: backend
command terminated with exit code 6
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -- ip a
Defaulted container "frontend" out of: frontend, backend
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "93e84ed28571c2224cb417daea9abd3bbb8ce7965aa234a30caba96ea81838e4": OCI runtime exec failed: exec failed: unable to start container process: exec: "ip": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1430 qdisc noqueue state UP group default 
    link/ether 6e:f0:dc:0e:a4:85 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.233.96.1/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::6cf0:dcff:fe0e:a485/64 scope link 
       valid_lft forever preferred_lft forever
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c frontend -- ip a
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "69b8014037cd412577c88edda962552eb491547732f8590f148ba081b95b289a": OCI runtime exec failed: exec failed: unable to start container process: exec: "ip": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c frontend -- cat /etc/*release
cat: /etc/lsb-release: No such file or directory
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
command terminated with exit code 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- cat /etc/*release
cat: /etc/lsb-release: No such file or directory
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
command terminated with exit code 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
100   448  100   448    0     0  16000      0 --:--:-- --:--:-- --:--:-- 16000
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1:9000
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (7) Failed to connect to 127.1 port 9000: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1:8000
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (7) Failed to connect to 127.1 port 8000: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   109k      0 --:--:-- --:--:-- --:--:--  109k
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=60 time=109 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=60 time=21.2 ms
^C
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c frontend -- ping 8.8.8.8
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "3586c8e7f729156009c70994dde4669353e99756cdfa34f2ba255f66729907b3": OCI runtime exec failed: exec failed: unable to start container process: exec: "ping": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c frontend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/06 08:47:15 [notice] 1#1: using the "epoll" event method
2022/07/06 08:47:15 [notice] 1#1: nginx/1.23.0
2022/07/06 08:47:15 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/06 08:47:15 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/06 08:47:15 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/06 08:47:15 [notice] 1#1: start worker processes
2022/07/06 08:47:15 [notice] 1#1: start worker process 30
2022/07/06 08:47:15 [notice] 1#1: start worker process 31
127.0.0.1 - - [06/Jul/2022:09:23:35 +0000] "GET / HTTP/1.1" 200 448 "-" "curl/7.64.0" "-"
127.0.0.1 - - [06/Jul/2022:09:24:04 +0000] "GET / HTTP/1.1" 200 448 "-" "curl/7.64.0" "-"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get po - o wide
Error from server (NotFound): pods "-" not found
Error from server (NotFound): pods "o" not found
Error from server (NotFound): pods "wide" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod - o wide
Error from server (NotFound): pods "-" not found
Error from server (NotFound): pods "o" not found
Error from server (NotFound): pods "wide" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
fb-pod-65b9777746-4bnxq   2/2     Running   0          88m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 32K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:37 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro  195 июл  6 12:37 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db.yaml 
statefulset.apps/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS              RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      0/1     ContainerCreating   0          7s    <none>        node1   <none>           <none>
fb-pod-65b9777746-4bnxq   2/2     Running             0          97m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          11s   10.233.90.2   node1   <none>           <none>
fb-pod-65b9777746-4bnxq   2/2     Running   0          97m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db-svc.yaml 
service/db-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          43s   10.233.90.2   node1   <none>           <none>
fb-pod-65b9777746-4bnxq   2/2     Running   0          97m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   14s    app=db
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          158m   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs -c backend
error: expected 'logs [-f] [-p] (POD | TYPE/NAME) [-c CONTAINER]'.
POD or TYPE/NAME is a required argument for the logs command
See 'kubectl logs -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs -c backend
error: expected 'logs [-f] [-p] (POD | TYPE/NAME) [-c CONTAINER]'.
POD or TYPE/NAME is a required argument for the logs command
See 'kubectl logs -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   3m37s   app=db
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          161m    <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl 10.233.30.200:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl 10.233.30.200:31655
curl: (7) Failed to connect to 10.233.30.200 port 31655: Connection refused
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          5m48s
fb-pod-65b9777746-4bnxq   2/2     Running   0          102m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe db-0
error: the server doesn't have a resource type "db-0"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe po db-0
Name:         db-0
Namespace:    default
Priority:     0
Node:         node1/10.128.0.12
Start Time:   Wed, 06 Jul 2022 14:24:14 +0400
Labels:       app=db
              controller-revision-hash=db-58b74bf99f
              statefulset.kubernetes.io/pod-name=db-0
Annotations:  cni.projectcalico.org/containerID: 1dba360f4c89f0e98c6b849fff1df33295abd2d4b551aef4fe7d1439db7ab706
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://3c845496b80d15e55eddb95c3d872f130e627af0301cd3254e97a3813a47540c
    Image:          zakharovnpa/k8s-database:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-database@sha256:f58e501e198aed05774e84dc82048c61b48039afa69e73bc614ee66628a916b5
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 06 Jul 2022 14:24:24 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4666k (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4666k:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  6m4s   default-scheduler  Successfully assigned default/db-0 to node1
  Normal  Pulling    6m3s   kubelet            Pulling image "zakharovnpa/k8s-database:05.07.22"
  Normal  Pulled     5m55s  kubelet            Successfully pulled image "zakharovnpa/k8s-database:05.07.22" in 7.96756096s
  Normal  Created    5m55s  kubelet            Created container db
  Normal  Started    5m55s  kubelet            Started container db
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe statefulsets.apps db 
Name:               db
Namespace:          default
CreationTimestamp:  Wed, 06 Jul 2022 14:24:14 +0400
Selector:           app=db
Labels:             <none>
Annotations:        <none>
Replicas:           1 desired | 1 total
Update Strategy:    RollingUpdate
  Partition:        0
Pods Status:        1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=db
  Containers:
   db:
    Image:      zakharovnpa/k8s-database:05.07.22
    Port:       <none>
    Host Port:  <none>
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:               <none>
  Volumes:                <none>
Volume Claims:            <none>
Events:
  Type    Reason            Age    From                    Message
  ----    ------            ----   ----                    -------
  Normal  SuccessfulCreate  7m29s  statefulset-controller  create Pod db-0 in StatefulSet db successful
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs po db-0
Error from server (NotFound): pods "po" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs pod db
Error from server (NotFound): pods "pod" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs db
Error from server (NotFound): pods "db" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs db-0
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-07-06 10:24:24.936 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-07-06 10:24:26.717 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-06 10:24:26.721 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-06 10:24:26.736 UTC [37] LOG:  database system was shut down at 2022-07-06 10:24:26 UTC
2022-07-06 10:24:26.743 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down....2022-07-06 10:24:27.157 UTC [36] LOG:  received fast shutdown request
2022-07-06 10:24:27.161 UTC [36] LOG:  aborting any active transactions
2022-07-06 10:24:27.163 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-07-06 10:24:27.163 UTC [38] LOG:  shutting down
2022-07-06 10:24:27.188 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-07-06 10:24:27.283 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-06 10:24:27.283 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-07-06 10:24:27.283 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-07-06 10:24:27.290 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-06 10:24:27.297 UTC [50] LOG:  database system was shut down at 2022-07-06 10:24:27 UTC
2022-07-06 10:24:27.303 UTC [1] LOG:  database system is ready to accept connections
2022-07-06 10:29:10.964 UTC [61] LOG:  invalid length of startup packet
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ psql -h 10.233.30.200 -U
Error: You must install at least one postgresql-client-<version> package
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# psql -h 10.233.30.200 -U
bash: psql: command not found
root@fb-pod-65b9777746-4bnxq:~# psql
bash: psql: command not found
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# apt install psql
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package psql
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# type psql
bash: type: psql: not found
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# whereis psql
psql:
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# psql -h 10.233.30.200 -U
psql: option requires an argument: U
Try "psql --help" for more information.
db-0:/# psql -h 10.233.30.200
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# 
db-0:/# psql -h 10.233.30.200
Password for user root: 
psql: error: fe_sendauth: no password supplied
db-0:/# 
db-0:/# psql -h 10.233.30.200
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# 
db-0:/# sudo -i
bash: sudo: command not found
db-0:/# 
db-0:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if9: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1430 qdisc noqueue state UP 
    link/ether 9a:1e:f7:9b:94:cd brd ff:ff:ff:ff:ff:ff
    inet 10.233.90.2/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::981e:f7ff:fe9b:94cd/64 scope link 
       valid_lft forever preferred_lft forever
db-0:/# 
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: fe_sendauth: no password supplied
db-0:/# 
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# 
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: fe_sendauth: no password supplied
db-0:/# 
db-0:/# psql 10.233.90.2
psql: error: FATAL:  role "root" does not exist
db-0:/# 
db-0:/# psql
psql: error: FATAL:  role "root" does not exist
db-0:/# 
db-0:/# psql --verson
psql: unrecognized option: verson
Try "psql --help" for more information.
db-0:/# type psql
psql is hashed (/usr/local/bin/psql)
db-0:/# 
db-0:/# whereis psql
bash: whereis: command not found
db-0:/# 
db-0:/# 
db-0:/# curl 127.1:5432
bash: curl: command not found
db-0:/# 
db-0:/# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=60 time=18.498 ms
64 bytes from 8.8.8.8: seq=1 ttl=60 time=18.170 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 18.170/18.334/18.498 ms
db-0:/# 
db-0:/# apt 
bash: apt: command not found
db-0:/# 
db-0:/# yum
bash: yum: command not found
db-0:/# 
db-0:/# cat /etc/*release
3.16.0
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.16.0
PRETTY_NAME="Alpine Linux v3.16"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
db-0:/# 
db-0:/# 
db-0:/# 
db-0:/# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME         ENDPOINTS          AGE
db-svc       10.233.90.2:5432   28m
kubernetes   10.128.0.30:6443   3h6m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl het svc
error: unknown command "het" for "kubectl"

Did you mean this?
	set
	get
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   28m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          3h6m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc db-svc 
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc   NodePort   10.233.30.200   <none>        5432:31655/TCP   28m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc db-svc -o wide
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
db-svc   NodePort   10.233.30.200   <none>        5432:31655/TCP   29m   app=db
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe svc db-svc 
Name:                     db-svc
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=db
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.30.200
IPs:                      10.233.30.200
Port:                     <unset>  5432/TCP
TargetPort:               5432/TCP
NodePort:                 <unset>  31655/TCP
Endpoints:                10.233.90.2:5432
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod db-0 
Name:         db-0
Namespace:    default
Priority:     0
Node:         node1/10.128.0.12
Start Time:   Wed, 06 Jul 2022 14:24:14 +0400
Labels:       app=db
              controller-revision-hash=db-58b74bf99f
              statefulset.kubernetes.io/pod-name=db-0
Annotations:  cni.projectcalico.org/containerID: 1dba360f4c89f0e98c6b849fff1df33295abd2d4b551aef4fe7d1439db7ab706
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://3c845496b80d15e55eddb95c3d872f130e627af0301cd3254e97a3813a47540c
    Image:          zakharovnpa/k8s-database:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-database@sha256:f58e501e198aed05774e84dc82048c61b48039afa69e73bc614ee66628a916b5
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 06 Jul 2022 14:24:24 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4666k (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4666k:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  30m   default-scheduler  Successfully assigned default/db-0 to node1
  Normal  Pulling    30m   kubelet            Pulling image "zakharovnpa/k8s-database:05.07.22"
  Normal  Pulled     30m   kubelet            Successfully pulled image "zakharovnpa/k8s-database:05.07.22" in 7.96756096s
  Normal  Created    30m   kubelet            Created container db
  Normal  Started    30m   kubelet            Started container db
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep db-svc
Name:         db-svc
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-06T10:24:51Z
Subsets:
  Addresses:          10.233.90.2
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   36m     app=db
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          3h14m   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep -o wide
NAME         ENDPOINTS          AGE
db-svc       10.233.90.2:5432   36m
kubernetes   10.128.0.30:6443   3h14m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim ep-db-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep db-svc -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-06T10:24:51Z"
  creationTimestamp: "2022-07-06T10:24:51Z"
  name: db-svc
  namespace: default
  resourceVersion: "16888"
  uid: 3d72e63b-d18e-4a9e-af1d-d0c571e50b91
subsets:
- addresses:
  - hostname: db-0
    ip: 10.233.90.2
    nodeName: node1
    targetRef:
      kind: Pod
      name: db-0
      namespace: default
      uid: 3031027c-ed4c-40f9-8778-770bcce5eb12
  ports:
  - port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc db-svc -o yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"db-svc","namespace":"default"},"spec":{"ports":[{"port":5432,"targetPort":5432}],"selector":{"app":"db"},"type":"NodePort"}}
  creationTimestamp: "2022-07-06T10:24:51Z"
  name: db-svc
  namespace: default
  resourceVersion: "16887"
  uid: 708ae447-ded6-4323-ad3e-da584b7a2b1c
spec:
  clusterIP: 10.233.30.200
  clusterIPs:
  - 10.233.30.200
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - nodePort: 31655
    port: 5432
    protocol: TCP
    targetPort: 5432
  selector:
    app: db
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat db-svc.yaml 
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: db-svc
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl
curl: try 'curl --help' or 'curl --manual' for more information
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# ping 10.233.90.2
PING 10.233.90.2 (10.233.90.2) 56(84) bytes of data.
64 bytes from 10.233.90.2: icmp_seq=1 ttl=62 time=0.640 ms
64 bytes from 10.233.90.2: icmp_seq=2 ttl=62 time=0.613 ms
64 bytes from 10.233.90.2: icmp_seq=3 ttl=62 time=0.588 ms
64 bytes from 10.233.90.2: icmp_seq=4 ttl=62 time=0.533 ms
64 bytes from 10.233.90.2: icmp_seq=5 ttl=62 time=0.621 ms
^C
--- 10.233.90.2 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 87ms
rtt min/avg/max/mdev = 0.533/0.599/0.640/0.036 ms
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# shutdown -r now
bash: shutdown: command not found
db-0:/# 
db-0:/# reload now
bash: reload: command not found
db-0:/# 
db-0:/# restart
bash: restart: command not found
db-0:/# 
db-0:/# reboot
db-0:/# command terminated with exit code 137
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# reload
bash: reload: command not found
db-0:/# 
db-0:/# reboot
db-0:/# command terminated with exit code 137
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# exit
logout
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl --help
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources.
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL.

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh or fish)

Other Commands:
  alpha           Commands for features in alpha
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl api-resources
NAME                              SHORTNAMES   APIVERSION                             NAMESPACED   KIND
bindings                                       v1                                     true         Binding
componentstatuses                 cs           v1                                     false        ComponentStatus
configmaps                        cm           v1                                     true         ConfigMap
endpoints                         ep           v1                                     true         Endpoints
events                            ev           v1                                     true         Event
limitranges                       limits       v1                                     true         LimitRange
namespaces                        ns           v1                                     false        Namespace
nodes                             no           v1                                     false        Node
persistentvolumeclaims            pvc          v1                                     true         PersistentVolumeClaim
persistentvolumes                 pv           v1                                     false        PersistentVolume
pods                              po           v1                                     true         Pod
podtemplates                                   v1                                     true         PodTemplate
replicationcontrollers            rc           v1                                     true         ReplicationController
resourcequotas                    quota        v1                                     true         ResourceQuota
secrets                                        v1                                     true         Secret
serviceaccounts                   sa           v1                                     true         ServiceAccount
services                          svc          v1                                     true         Service
mutatingwebhookconfigurations                  admissionregistration.k8s.io/v1        false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io/v1        false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io/v1                false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io/v1              false        APIService
controllerrevisions                            apps/v1                                true         ControllerRevision
daemonsets                        ds           apps/v1                                true         DaemonSet
deployments                       deploy       apps/v1                                true         Deployment
replicasets                       rs           apps/v1                                true         ReplicaSet
statefulsets                      sts          apps/v1                                true         StatefulSet
tokenreviews                                   authentication.k8s.io/v1               false        TokenReview
localsubjectaccessreviews                      authorization.k8s.io/v1                true         LocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io/v1                false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io/v1                false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io/v1                false        SubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling/v2                         true         HorizontalPodAutoscaler
cronjobs                          cj           batch/v1                               true         CronJob
jobs                                           batch/v1                               true         Job
certificatesigningrequests        csr          certificates.k8s.io/v1                 false        CertificateSigningRequest
leases                                         coordination.k8s.io/v1                 true         Lease
bgpconfigurations                              crd.projectcalico.org/v1               false        BGPConfiguration
bgppeers                                       crd.projectcalico.org/v1               false        BGPPeer
blockaffinities                                crd.projectcalico.org/v1               false        BlockAffinity
caliconodestatuses                             crd.projectcalico.org/v1               false        CalicoNodeStatus
clusterinformations                            crd.projectcalico.org/v1               false        ClusterInformation
felixconfigurations                            crd.projectcalico.org/v1               false        FelixConfiguration
globalnetworkpolicies                          crd.projectcalico.org/v1               false        GlobalNetworkPolicy
globalnetworksets                              crd.projectcalico.org/v1               false        GlobalNetworkSet
hostendpoints                                  crd.projectcalico.org/v1               false        HostEndpoint
ipamblocks                                     crd.projectcalico.org/v1               false        IPAMBlock
ipamconfigs                                    crd.projectcalico.org/v1               false        IPAMConfig
ipamhandles                                    crd.projectcalico.org/v1               false        IPAMHandle
ippools                                        crd.projectcalico.org/v1               false        IPPool
ipreservations                                 crd.projectcalico.org/v1               false        IPReservation
kubecontrollersconfigurations                  crd.projectcalico.org/v1               false        KubeControllersConfiguration
networkpolicies                                crd.projectcalico.org/v1               true         NetworkPolicy
networksets                                    crd.projectcalico.org/v1               true         NetworkSet
endpointslices                                 discovery.k8s.io/v1                    true         EndpointSlice
events                            ev           events.k8s.io/v1                       true         Event
flowschemas                                    flowcontrol.apiserver.k8s.io/v1beta2   false        FlowSchema
prioritylevelconfigurations                    flowcontrol.apiserver.k8s.io/v1beta2   false        PriorityLevelConfiguration
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
ingresses                         ing          networking.k8s.io/v1                   true         Ingress
networkpolicies                   netpol       networking.k8s.io/v1                   true         NetworkPolicy
runtimeclasses                                 node.k8s.io/v1                         false        RuntimeClass
poddisruptionbudgets              pdb          policy/v1                              true         PodDisruptionBudget
podsecuritypolicies               psp          policy/v1beta1                         false        PodSecurityPolicy
clusterrolebindings                            rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io/v1           false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io/v1           true         RoleBinding
roles                                          rbac.authorization.k8s.io/v1           true         Role
priorityclasses                   pc           scheduling.k8s.io/v1                   false        PriorityClass
csidrivers                                     storage.k8s.io/v1                      false        CSIDriver
csinodes                                       storage.k8s.io/v1                      false        CSINode
csistoragecapacities                           storage.k8s.io/v1                      true         CSIStorageCapacity
storageclasses                    sc           storage.k8s.io/v1                      false        StorageClass
volumeattachments                              storage.k8s.io/v1                      false        VolumeAttachment
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl api-resources | grep dns
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl api-resources | grep name
namespaces                        ns           v1                                     false        Namespace
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help | grep dns
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help | grep DNS
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help | grep name
 Prints a table of the most important information about the specified resources. You can filter the list using a label selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current namespace unless you pass --all-namespaces.
  # List all pods in ps output format with more information (such as node name)
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  # List one or more resources by their type and names
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even if specified with --namespace.
    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath, jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns [https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template [https://kubernetes.io/docs/reference/kubectl/jsonpath/].
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests organized within the same directory.
	If non-empty, sort list types using this field specification.  The field specification is expressed as a JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath expression must be an integer or a string.
  kubectl get [(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide] (TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   18m   v1.24.2
node1   Ready    <none>          16m   v1.24.2
node2   Ready    <none>          16m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 36K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 15:02 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro    2 июл  6 15:02 ep-db-svc.yaml
-rw-rw-r-- 1 maestro maestro  195 июл  6 12:37 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db.yaml 
statefulset.apps/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db-svc.yaml 
service/db-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          22s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME         ENDPOINTS          AGE
db-svc       10.233.90.1:5432   18s
kubernetes   10.128.0.11:6443   29m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs db-0 
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-07-07 02:14:51.431 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-07-07 02:14:52.742 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-07 02:14:52.748 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-07 02:14:52.773 UTC [37] LOG:  database system was shut down at 2022-07-07 02:14:52 UTC
2022-07-07 02:14:52.782 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down...2022-07-07 02:14:53.190 UTC [36] LOG:  received fast shutdown request
.2022-07-07 02:14:53.194 UTC [36] LOG:  aborting any active transactions
2022-07-07 02:14:53.194 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-07-07 02:14:53.195 UTC [38] LOG:  shutting down
2022-07-07 02:14:53.215 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-07-07 02:14:53.317 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-07 02:14:53.317 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-07-07 02:14:53.317 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-07-07 02:14:53.330 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-07 02:14:53.341 UTC [50] LOG:  database system was shut down at 2022-07-07 02:14:53 UTC
2022-07-07 02:14:53.347 UTC [1] LOG:  database system is ready to accept connections
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# psql 127.1
psql: error: FATAL:  role "root" does not exist
db-0:/# 
db-0:/# psql -h 127.1:5432 -U postgres
psql: error: could not translate host name "127.1:5432" to address: Name does not resolve
db-0:/# 
db-0:/# psql -h 127.0.0.1:5432 -U postgres
psql: error: could not translate host name "127.0.0.1:5432" to address: Name does not resolve
db-0:/# 
db-0:/# exit
logout
command terminated with exit code 2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME         ENDPOINTS          AGE
db-svc       10.233.90.1:5432   4m32s
kubernetes   10.128.0.11:6443   34m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep db-svc 
Name:         db-svc
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-07T02:14:51Z
Subsets:
  Addresses:          10.233.90.1
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# psql -h 10.233.90.1:5432 -U postgres
psql: error: could not translate host name "10.233.90.1:5432" to address: Name does not resolve
db-0:/# 
db-0:/# psql -h db-svc 10.233.90.1:5432 -U postgres -d news
psql: warning: extra command-line argument "10.233.90.1:5432" ignored
Password for user postgres: 
psql (13.7)
Type "help" for help.

news=# exit
db-0:/# 
db-0:/# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-app.yaml 
deployment.apps/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f fb-svc.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS              RESTARTS   AGE
db-0                      1/1     Running             0          10m
fb-pod-65b9777746-lcflx   0/2     ContainerCreating   0          21s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS              RESTARTS   AGE
db-0                      1/1     Running             0          10m
fb-pod-65b9777746-lcflx   0/2     ContainerCreating   0          26s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS              RESTARTS   AGE
db-0                      1/1     Running             0          10m
fb-pod-65b9777746-lcflx   0/2     ContainerCreating   0          33s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          10m
fb-pod-65b9777746-lcflx   2/2     Running   0          40s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-lcflx -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
Error from server (NotFound): pods "fb-pod-65b9777746-4bnxq" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-lcflx -c backend -i -t -- bash -il
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# ping frontend
ping: frontend: Name or service not known
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# ping fb-svc
PING fb-svc.default.svc.cluster.local (10.233.61.157) 56(84) bytes of data.
64 bytes from fb-svc.default.svc.cluster.local (10.233.61.157): icmp_seq=1 ttl=64 time=0.053 ms
64 bytes from fb-svc.default.svc.cluster.local (10.233.61.157): icmp_seq=2 ttl=64 time=0.070 ms
64 bytes from fb-svc.default.svc.cluster.local (10.233.61.157): icmp_seq=3 ttl=64 time=0.072 ms
64 bytes from fb-svc.default.svc.cluster.local (10.233.61.157): icmp_seq=4 ttl=64 time=0.065 ms
64 bytes from fb-svc.default.svc.cluster.local (10.233.61.157): icmp_seq=5 ttl=64 time=0.065 ms
^C
--- fb-svc.default.svc.cluster.local ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 84ms
rtt min/avg/max/mdev = 0.053/0.065/0.072/0.006 ms
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# ping db-svc
PING db-svc.default.svc.cluster.local (10.233.50.101) 56(84) bytes of data.
64 bytes from db-svc.default.svc.cluster.local (10.233.50.101): icmp_seq=1 ttl=64 time=0.045 ms
64 bytes from db-svc.default.svc.cluster.local (10.233.50.101): icmp_seq=2 ttl=64 time=0.069 ms
^C
--- db-svc.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2ms
rtt min/avg/max/mdev = 0.045/0.057/0.069/0.012 ms
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe svc fb-svc 
Name:                     fb-svc
Namespace:                default
Labels:                   app=fb-app
Annotations:              <none>
Selector:                 app=fb-pod
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.61.157
IPs:                      10.233.61.157
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:                <none>
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          53m
fb-pod-65b9777746-lcflx   2/2     Running   0          43m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc fb-svc 
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
fb-svc   NodePort   10.233.61.157   <none>        80:30080/TCP   47m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl edit svc fb-svc 
service/fb-svc edited
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc fb-svc 
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
fb-svc   NodePort   10.233.61.157   <none>        80:30080/TCP   48m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl edit svc fb-svc 
Edit cancelled, no changes made.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-lcflx -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f fb-svc.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-lcflx -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-lcflx -c backend -- reload
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "03f209774128a08be787c18d8ee5eb3eb10f1a7b953c05948d0cc1ddc5105e91": OCI runtime exec failed: exec failed: unable to start container process: exec: "reload": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-lcflx -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-lcflx -c backend -i -t -- bash -il
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# reload
bash: reload: command not found
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# reboot
bash: reboot: command not found
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# shutdown -r now
bash: shutdown: command not found
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# ping db
ping: db: Name or service not known
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# restart
bash: restart: command not found
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# cd
root@fb-pod-65b9777746-lcflx:~# 
root@fb-pod-65b9777746-lcflx:~# reboot
bash: reboot: command not found
root@fb-pod-65b9777746-lcflx:~# 
root@fb-pod-65b9777746-lcflx:~# restart
bash: restart: command not found
root@fb-pod-65b9777746-lcflx:~# 
root@fb-pod-65b9777746-lcflx:~# exit
logout
command terminated with exit code 127
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete pod fb-pod-65b9777746-lcflx 
pod "fb-pod-65b9777746-lcflx" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          67m
fb-pod-65b9777746-nt8bq   2/2     Running   0          82s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-nt8bq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          68m
fb-pod-65b9777746-nt8bq   2/2     Running   0          2m11s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod fb-pod-65b9777746-nt8bq 
Name:         fb-pod-65b9777746-nt8bq
Namespace:    default
Priority:     0
Node:         node1/10.128.0.32
Start Time:   Thu, 07 Jul 2022 07:21:05 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: 46fc754c87f8cffc9aa239a4b5e2a3d8fa78a3002030f01e792b76dbba5ed825
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://5c9bd8964166df6204b256c693af3d114ef5bd6b10c74847d9a8718139b2035c
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 07 Jul 2022 07:21:15 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dg822 (ro)
  backend:
    Container ID:   containerd://8822072c657586a5a27004ad65ceed91c96fe3f417532f86fec90da96acf7563
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 07 Jul 2022 07:21:40 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dg822 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-dg822:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  2m27s  default-scheduler  Successfully assigned default/fb-pod-65b9777746-nt8bq to node1
  Normal  Pulling    2m24s  kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     2m17s  kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 6.993787316s
  Normal  Created    2m17s  kubelet            Created container frontend
  Normal  Started    2m17s  kubelet            Started container frontend
  Normal  Pulling    2m17s  kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     113s   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 24.630521978s
  Normal  Created    112s   kubelet            Created container backend
  Normal  Started    112s   kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubetl edit pod fb-svc.yaml 

Команда «kubetl» не найдена. Возможно, вы имели в виду:

  command 'kubectl' from snap kubectl (1.24.2)

See 'snap info <snapname>' for additional versions.

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubetl edit pod fb-svc

Команда «kubetl» не найдена. Возможно, вы имели в виду:

  command 'kubectl' from snap kubectl (1.24.2)

See 'snap info <snapname>' for additional versions.

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl edit pod fb-svc
Error from server (NotFound): pods "fb-svc" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl edit pod fb-pod-65b9777746-nt8bq 
Edit cancelled, no changes made.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 36K
drwxrwxr-x 2 maestro maestro 4,0K июл  7 07:27 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro    2 июл  6 15:02 ep-db-svc.yaml
-rw-rw-r-- 1 maestro maestro  204 июл  7 07:11 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  601 июл  7 07:27 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply fb-svc.yaml
error: must specify one of -f and -k
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f fb-svc.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-app.yaml 
The Deployment "fb-pod" is invalid: 
* spec.template.metadata.labels: Invalid value: map[string]string{"app":"fb-app"}: `selector` does not match template `labels`
* spec.selector: Invalid value: v1.LabelSelector{MatchLabels:map[string]string{"app":"fb"}, MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-app.yaml 
deployment.apps/fb-pod unchanged
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod fb-pod-65b9777746-nt8bq 
Name:         fb-pod-65b9777746-nt8bq
Namespace:    default
Priority:     0
Node:         node1/10.128.0.32
Start Time:   Thu, 07 Jul 2022 07:21:05 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: 46fc754c87f8cffc9aa239a4b5e2a3d8fa78a3002030f01e792b76dbba5ed825
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://5c9bd8964166df6204b256c693af3d114ef5bd6b10c74847d9a8718139b2035c
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 07 Jul 2022 07:21:15 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dg822 (ro)
  backend:
    Container ID:   containerd://8822072c657586a5a27004ad65ceed91c96fe3f417532f86fec90da96acf7563
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 07 Jul 2022 07:21:40 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dg822 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-dg822:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  10m   default-scheduler  Successfully assigned default/fb-pod-65b9777746-nt8bq to node1
  Normal  Pulling    10m   kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     10m   kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 6.993787316s
  Normal  Created    10m   kubelet            Created container frontend
  Normal  Started    10m   kubelet            Started container frontend
  Normal  Pulling    10m   kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     10m   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 24.630521978s
  Normal  Created    10m   kubelet            Created container backend
  Normal  Started    10m   kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod fb-pod-65b9777746-nt8bq | grep elector
Node-Selectors:              <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f fb-svc.yaml 
service/fb-svc configured
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc       NodePort    10.233.50.101   <none>        5432:30308/TCP   89m
fb-svc       NodePort    10.233.7.60     <none>        80:30080/TCP     14m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          118m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-nt8bq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc       NodePort    10.233.50.101   <none>        5432:30308/TCP   90m
fb-svc       NodePort    10.233.7.60     <none>        80:30080/TCP     15m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          119m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-lcflx -c backend -i -t -- bash -il
Error from server (NotFound): pods "fb-pod-65b9777746-lcflx" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          91m
fb-pod-65b9777746-nt8bq   2/2     Running   0          24m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-nt8bq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-nt8bq:/app# 
root@fb-pod-65b9777746-nt8bq:/app# cd
root@fb-pod-65b9777746-nt8bq:~# 
root@fb-pod-65b9777746-nt8bq:~# ping db-svc
PING db-svc.default.svc.cluster.local (10.233.50.101) 56(84) bytes of data.
64 bytes from db-svc.default.svc.cluster.local (10.233.50.101): icmp_seq=1 ttl=64 time=0.048 ms
64 bytes from db-svc.default.svc.cluster.local (10.233.50.101): icmp_seq=2 ttl=64 time=0.065 ms
^C
--- db-svc.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3ms
rtt min/avg/max/mdev = 0.048/0.056/0.065/0.011 ms
root@fb-pod-65b9777746-nt8bq:~# 
root@fb-pod-65b9777746-nt8bq:~# 
root@fb-pod-65b9777746-nt8bq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db-svc.yaml 
service/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc 
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db           NodePort    10.233.2.152    <none>        5432:32602/TCP   20s
db-svc       NodePort    10.233.50.101   <none>        5432:30308/TCP   93m
fb-svc       NodePort    10.233.7.60     <none>        80:30080/TCP     18m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          122m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-lcflx -c backend -i -t -- bash -il
Error from server (NotFound): pods "fb-pod-65b9777746-lcflx" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-nt8bq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-nt8bq:/app# 
root@fb-pod-65b9777746-nt8bq:/app# ping db
PING db.default.svc.cluster.local (10.233.2.152) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.2.152): icmp_seq=1 ttl=64 time=0.042 ms
64 bytes from db.default.svc.cluster.local (10.233.2.152): icmp_seq=2 ttl=64 time=0.086 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2ms
rtt min/avg/max/mdev = 0.042/0.064/0.086/0.022 ms
root@fb-pod-65b9777746-nt8bq:/app# 
root@fb-pod-65b9777746-nt8bq:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-nt8bq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc 
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db           NodePort    10.233.2.152    <none>        5432:32602/TCP   72s
db-svc       NodePort    10.233.50.101   <none>        5432:30308/TCP   94m
fb-svc       NodePort    10.233.7.60     <none>        80:30080/TCP     19m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          123m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete svc db-svc 
service "db-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc 
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
db           NodePort    10.233.2.152   <none>        5432:32602/TCP   92s
fb-svc       NodePort    10.233.7.60    <none>        80:30080/TCP     19m
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          124m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          95m
fb-pod-65b9777746-nt8bq   2/2     Running   0          28m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-nt8bq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          95m
fb-pod-65b9777746-nt8bq   2/2     Running   0          29m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete pod fb-pod-65b9777746-nt8bq 
pod "fb-pod-65b9777746-nt8bq" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          98m
fb-pod-65b9777746-b2sl2   2/2     Running   0          2m25s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-b2sl2 -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
INFO:     Started server process [9]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-b2sl2 -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
INFO:     Started server process [9]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          122m
fb-pod-65b9777746-b2sl2   2/2     Running   0          26m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE    IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          122m   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-b2sl2   2/2     Running   0          26m    10.233.96.3   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ^C
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl create ingress --help
Create an ingress with the specified name.

Aliases:
ingress, ing

Examples:
  # Create a single ingress called 'simple' that directs requests to foo.com/bar to svc
  # svc1:8080 with a tls secret "my-cert"
  kubectl create ingress simple --rule="foo.com/bar=svc1:8080,tls=my-cert"
  
  # Create a catch all ingress of "/path" pointing to service svc:port and Ingress Class as "otheringress"
  kubectl create ingress catch-all --class=otheringress --rule="/path=svc:port"
  
  # Create an ingress with two annotations: ingress.annotation1 and ingress.annotations2
  kubectl create ingress annotated --class=default --rule="foo.com/bar=svc:port" \
  --annotation ingress.annotation1=foo \
  --annotation ingress.annotation2=bla
  
  # Create an ingress with the same host and multiple paths
  kubectl create ingress multipath --class=default \
  --rule="foo.com/=svc:port" \
  --rule="foo.com/admin/=svcadmin:portadmin"
  
  # Create an ingress with multiple hosts and the pathType as Prefix
  kubectl create ingress ingress1 --class=default \
  --rule="foo.com/path*=svc:8080" \
  --rule="bar.com/admin*=svc2:http"
  
  # Create an ingress with TLS enabled using the default ingress certificate and different path types
  kubectl create ingress ingtls --class=default \
  --rule="foo.com/=svc:https,tls" \
  --rule="foo.com/path/subpath*=othersvc:8080"
  
  # Create an ingress with TLS enabled using a specific secret and pathType as Prefix
  kubectl create ingress ingsecret --class=default \
  --rule="foo.com/*=svc:8080,tls=secret1"
  
  # Create an ingress with a default backend
  kubectl create ingress ingdefault --class=default \
  --default-backend=defaultsvc:http \
  --rule="foo.com/*=svc:8080,tls=secret1"

Options:
    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --annotation=[]:
	Annotation to insert in the ingress object, in the format annotation=value

    --class='':
	Ingress Class to be used

    --default-backend='':
	Default service for backend, in format of svcname:port

    --dry-run='none':
	Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
	sending it. If server strategy, submit server-side request without persisting the resource.

    --field-manager='kubectl-create':
	Name of the manager used to track field ownership.

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file).

    --rule=[]:
	Rule in format host/path=service:port[,tls=secretname]. Paths containing the leading character '*' are
	considered pathType=Prefix. tls argument is optional.

    --save-config=false:
	If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
	be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --validate='strict':
	Must be one of: strict (or true), warn, ignore (or false). 		"true" or "strict" will use a schema to validate
	the input and fail the request if invalid. It will perform server side validation if ServerSideFieldValidation
	is enabled on the api-server, but will fall back to less reliable client-side validation if not. 		"warn" will
	warn about unknown or duplicate fields without blocking the request if server-side field validation is enabled
	on the API server, and behave as "ignore" otherwise. 		"false" or "ignore" will not perform any schema
	validation, silently dropping any unknown or duplicate fields.

Usage:
  kubectl create ingress NAME --rule=host/path=service:port[,tls[=secret]]  [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ingress
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl port-forward fb-pod-65b9777746-b2sl2 80:80
Unable to listen on port 80: Listeners failed to create with the following errors: [unable to create listener: Error listen tcp4 127.0.0.1:80: bind: permission denied unable to create listener: Error listen tcp6 [::1]:80: bind: permission denied]
error: unable to listen on any of the requested ports: [{80 80}]
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl port-forward fb-pod-65b9777746-b2sl2 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
^Cmaestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          144m
fb-pod-65b9777746-b2sl2   2/2     Running   0          48m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -c backend -i -t -- bash -il
root@fb-pod-65b9777746-b2sl2:/app# cd
root@fb-pod-65b9777746-b2sl2:~# 
root@fb-pod-65b9777746-b2sl2:~# 
root@fb-pod-65b9777746-b2sl2:~# curl bd
curl: (6) Could not resolve host: bd
root@fb-pod-65b9777746-b2sl2:~# 
root@fb-pod-65b9777746-b2sl2:~# ping db
PING db.default.svc.cluster.local (10.233.2.152) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.2.152): icmp_seq=1 ttl=64 time=0.039 ms
64 bytes from db.default.svc.cluster.local (10.233.2.152): icmp_seq=2 ttl=64 time=0.066 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 19ms
rtt min/avg/max/mdev = 0.039/0.052/0.066/0.015 ms
root@fb-pod-65b9777746-b2sl2:~# 
root@fb-pod-65b9777746-b2sl2:~# curl db
curl: (7) Failed to connect to db port 80: Connection refused
root@fb-pod-65b9777746-b2sl2:~# 
root@fb-pod-65b9777746-b2sl2:~# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-b2sl2:~# 
root@fb-pod-65b9777746-b2sl2:~# exit
logout
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get all
NAME                          READY   STATUS    RESTARTS   AGE
pod/db-0                      1/1     Running   0          4h13m
pod/fb-pod-65b9777746-b2sl2   2/2     Running   0          157m

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/db           NodePort    10.233.2.152    <none>        5432:32602/TCP   160m
service/fb-pod       NodePort    10.233.54.126   <none>        80:30080/TCP     81m
service/kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          4h43m

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod   1/1     1            1           4h4m

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/fb-pod-65b9777746   1         1         1       4h4m

NAME                  READY   AGE
statefulset.apps/db   1/1     4h13m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get all -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
pod/db-0                      1/1     Running   0          4h30m   10.233.90.1   node1   <none>           <none>
pod/fb-pod-65b9777746-b2sl2   2/2     Running   0          174m    10.233.96.3   node2   <none>           <none>

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
service/db           NodePort    10.233.2.152    <none>        5432:32602/TCP   177m   app=db
service/fb-pod       NodePort    10.233.54.126   <none>        80:30080/TCP     98m    app=fb-pod
service/kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          5h     <none>

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS         IMAGES                                                               SELECTOR
deployment.apps/fb-pod   1/1     1            1           4h21m   frontend,backend   zakharovnpa/k8s-frontend:05.07.22,zakharovnpa/k8s-backend:05.07.22   app=fb-app

NAME                                DESIRED   CURRENT   READY   AGE     CONTAINERS         IMAGES                                                               SELECTOR
replicaset.apps/fb-pod-65b9777746   1         1         1       4h21m   frontend,backend   zakharovnpa/k8s-frontend:05.07.22,zakharovnpa/k8s-backend:05.07.22   app=fb-app,pod-template-hash=65b9777746

NAME                  READY   AGE     CONTAINERS   IMAGES
statefulset.apps/db   1/1     4h30m   db           zakharovnpa/k8s-database:05.07.22
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -c backend -i -t -- bash -il
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# ping frontend
ping: frontend: Name or service not known
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# curl 127.1
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -- curl 127.1
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   437k      0 --:--:-- --:--:-- --:--:--  437k
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -- curl 127.1:9000
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    22  100    22    0     0  11000      0 --:--:-- --:--:-- --:--:-- 11000
{"detail":"Not Found"}maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -- curl 127.1:9001
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (7) Failed to connect to 127.1 port 9001: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -- curl 127.1:9000
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    22  100    22    0     0   7333      0 --:--:-- --:--:-- --:--:--  7333
{"detail":"Not Found"}maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -c backend -i -t -- bash -il
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# psql
bash: psql: command not found
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# apt
apt 1.8.2.3 (amd64)
Usage: apt [options] command

apt is a commandline package manager and provides commands for
searching and managing as well as querying information about packages.
It provides the same functionality as the specialized APT tools,
like apt-get and apt-cache, but enables options more suitable for
interactive use by default.

Most used commands:
  list - list packages based on package names
  search - search in package descriptions
  show - show package details
  install - install packages
  reinstall - reinstall packages
  remove - remove packages
  autoremove - Remove automatically all unused packages
  update - update list of available packages
  upgrade - upgrade the system by installing/upgrading packages
  full-upgrade - upgrade the system by removing/installing/upgrading packages
  edit-sources - edit the source information file

See apt(8) for more information about the available commands.
Configuration options and syntax is detailed in apt.conf(5).
Information about how to configure sources can be found in sources.list(5).
Package and version choices can be expressed via apt_preferences(5).
Security details are available in apt-secure(8).
                                        This APT has Super Cow Powers.
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# apropos psql
bash: apropos: command not found
root@fb-pod-65b9777746-b2sl2:/app# 
root@fb-pod-65b9777746-b2sl2:/app# apt install psql
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package psql
root@fb-pod-65b9777746-b2sl2:/app# command terminated with exit code 137
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-b2sl2 -c backend -i -t -- bash -il
Error from server (NotFound): pods "fb-pod-65b9777746-b2sl2" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          5h39m
fb-pod-65b9777746-54942   2/2     Running   0          32m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-54942 -c backend -i -t -- bash -il
root@fb-pod-65b9777746-54942:/app# ping db
PING db.default.svc.cluster.local (10.233.2.152) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.2.152): icmp_seq=1 ttl=64 time=0.041 ms
64 bytes from db.default.svc.cluster.local (10.233.2.152): icmp_seq=2 ttl=64 time=0.067 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3ms
rtt min/avg/max/mdev = 0.041/0.054/0.067/0.013 ms
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# curl db
curl: (7) Failed to connect to db port 80: Connection refused
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# telnet db:5432
bash: telnet: command not found
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# apt install net tools
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package net
E: Unable to locate package tools
root@fb-pod-65b9777746-54942:/app# apt install net-tools
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package net-tools
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# apt install net-tool
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package net-tool
root@fb-pod-65b9777746-54942:/app# 
root@fb-pod-65b9777746-54942:/app# exit
logout
command terminated with exit code 100
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-54942 -- curl db:5432
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-54942 -c backend -- curl db:5432
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 .
drwxrwxr-x 5 maestro maestro 4,0K июл  7 19:54 ..
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:16 prod
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 stage
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd prod/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:16 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:16 main
drwxrwxr-x 4 maestro maestro 4,0K июл  8 15:37 training
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod$ cd training/v-01/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ ls -lha
итого 28K
drwxr-xr-x 2 root    root    4,0K июл  8 16:38 .
drwxrwxr-x 4 maestro maestro 4,0K июл  8 15:37 ..
-rw-r--r-- 1 root    root     490 июл  8 15:40 backup-deployment.yml
-rw-r--r-- 1 root    root     875 июл  8 15:27 front-deployment.yml
-rw-r--r-- 1 root    root     440 июл  8 15:27 svc-back-prod.yaml
-rw-r--r-- 1 root    root     404 июл  8 15:46 svc-db.yaml
-rw-r--r-- 1 root    root     592 июл  8 16:38 svc-endpoint.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl apply -f front-deployment.yml 
error: error validating "front-deployment.yml": error validating data: ValidationError(Deployment.spec.template): unknown field "terminationGracePeriodSeconds" in io.k8s.api.core.v1.PodTemplateSpec; if you choose to ignore these errors, turn validation off with --validate=false
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim front-deployment.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim front-deployment.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ sudo mc
[sudo] пароль для maestro: 

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim front-deployment.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim backup-deployment.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl apply -f backup-deployment.yml 
deployment.apps/back-prod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
back-prod-8547767c9-rcd2w   0/1     ContainerCreating   0          13s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
back-prod-8547767c9-rcd2w   0/1     ContainerCreating   0          18s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
back-prod-8547767c9-rcd2w   0/1     ContainerCreating   0          21s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
back-prod-8547767c9-rcd2w   0/1     ContainerCreating   0          23s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
back-prod-8547767c9-rcd2w   0/1     ContainerCreating   0          25s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ ls -lha
итого 28K
drwxr-xr-x 2 root    root    4,0K июл  8 16:38 .
drwxrwxr-x 4 maestro maestro 4,0K июл  8 15:37 ..
-rw-rw-rw- 1 root    root     492 июл  8 18:13 backup-deployment.yml
-rw-rw-rw- 1 root    root     876 июл  8 18:13 front-deployment.yml
-rw-rw-rw- 1 root    root     440 июл  8 15:27 svc-back-prod.yaml
-rw-rw-rw- 1 root    root     404 июл  8 15:46 svc-db.yaml
-rw-rw-rw- 1 root    root     592 июл  8 16:38 svc-endpoint.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl apply -f svc-db.yaml 
service/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl apply -f svc-endpoint.yml 
Warning: resource endpoints/db is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
endpoints/db configured
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
back-prod-8547767c9-rcd2w   1/1     Running   0          81s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
db           ClusterIP   10.233.46.8   <none>        5432/TCP   3m1s
kubernetes   ClusterIP   10.233.0.1    <none>        443/TCP    59m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep
NAME         ENDPOINTS          AGE
db           10.128.0.21:5432   3m10s
kubernetes   10.128.0.31:6443   59m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o wide
NAME         ENDPOINTS          AGE
db           10.128.0.21:5432   3m30s
kubernetes   10.128.0.31:6443   60m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Endpoints
  metadata:
    annotations:
      endpoints.kubernetes.io/last-change-trigger-time: "2022-07-08T14:14:47Z"
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Endpoints","metadata":{"annotations":{},"name":"db","namespace":"default"},"subsets":[{"addresses":[{"ip":"10.128.0.21"}],"ports":[{"port":5432}]}]}
    creationTimestamp: "2022-07-08T14:14:47Z"
    name: db
    namespace: default
    resourceVersion: "6565"
    uid: 7e83255b-698b-44c5-a0c5-0ad43213fd5c
  subsets:
  - addresses:
    - ip: 10.128.0.21
    ports:
    - port: 5432
      protocol: TCP
- apiVersion: v1
  kind: Endpoints
  metadata:
    creationTimestamp: "2022-07-08T13:18:00Z"
    labels:
      endpointslice.kubernetes.io/skip-mirror: "true"
    name: kubernetes
    namespace: default
    resourceVersion: "200"
    uid: 4cdea0e9-587a-4e82-8f84-4a739b11816e
  subsets:
  - addresses:
    - ip: 10.128.0.31
    ports:
    - name: https
      port: 6443
      protocol: TCP
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl edit ep db
endpoints/db edited
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Endpoints
  metadata:
    annotations:
      endpoints.kubernetes.io/last-change-trigger-time: "2022-07-08T14:14:47Z"
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Endpoints","metadata":{"annotations":{},"name":"db","namespace":"default"},"subsets":[{"addresses":[{"ip":"10.128.0.32"}],"ports":[{"port":5432}]}]}
    creationTimestamp: "2022-07-08T14:14:47Z"
    name: db
    namespace: default
    resourceVersion: "7093"
    uid: 7e83255b-698b-44c5-a0c5-0ad43213fd5c
  subsets:
  - addresses:
    - ip: 10.128.0.32
    ports:
    - port: 5432
      protocol: TCP
- apiVersion: v1
  kind: Endpoints
  metadata:
    creationTimestamp: "2022-07-08T13:18:00Z"
    labels:
      endpointslice.kubernetes.io/skip-mirror: "true"
    name: kubernetes
    namespace: default
    resourceVersion: "200"
    uid: 4cdea0e9-587a-4e82-8f84-4a739b11816e
  subsets:
  - addresses:
    - ip: 10.128.0.31
    ports:
    - name: https
      port: 6443
      protocol: TCP
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl exec back-prod-8547767c9-rcd2w -c backend -it bash -il
error: unknown shorthand flag: 'l' in -l
See 'kubectl exec --help' for usage.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl exec back-prod-8547767c9-rcd2w -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# cd
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# ping db
PING db.default.svc.cluster.local (10.233.46.8) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=1 ttl=64 time=0.048 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=2 ttl=64 time=0.068 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=3 ttl=64 time=0.073 ms
^C
--- db.default.svc.cluster.local ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 19ms
rtt min/avg/max/mdev = 0.048/0.063/0.073/0.010 ms
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1430 qdisc noqueue state UP group default 
    link/ether 3a:14:48:d4:06:38 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.233.90.1/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::3814:48ff:fed4:638/64 scope link 
       valid_lft forever preferred_lft forever
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get -A
You must specify the type of resource to get. Use "kubectl api-resources" for a complete list of supported resources.

error: Required resource not specified.
Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
See 'kubectl get -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
db           ClusterIP   10.233.46.8   <none>        5432/TCP   10m
kubernetes   ClusterIP   10.233.0.1    <none>        443/TCP    66m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc db
NAME   TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
db     ClusterIP   10.233.46.8   <none>        5432/TCP   10m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl describe svc db
Name:              db
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          app=web-app
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.46.8
IPs:               10.233.46.8
Port:              db  5432/TCP
TargetPort:        5432/TCP
Endpoints:         
Session Affinity:  None
Events:            <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep
NAME         ENDPOINTS          AGE
db           10.128.0.32:5432   11m
kubernetes   10.128.0.31:6443   68m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl exec back-prod-8547767c9-rcd2w -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# cd
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# curl db
curl: (7) Failed to connect to db port 80: Connection refused
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# ping db
PING db.default.svc.cluster.local (10.233.46.8) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=1 ttl=64 time=0.044 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=2 ttl=64 time=0.077 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=3 ttl=64 time=0.068 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=4 ttl=64 time=0.066 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=5 ttl=64 time=0.067 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=6 ttl=64 time=0.069 ms
^C
--- db.default.svc.cluster.local ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 109ms
rtt min/avg/max/mdev = 0.044/0.065/0.077/0.011 ms
root@back-prod-8547767c9-rcd2w:~# 
root@back-prod-8547767c9-rcd2w:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ ls -lha
итого 28K
drwxr-xr-x 2 root    root    4,0K июл  8 16:38 .
drwxrwxr-x 4 maestro maestro 4,0K июл  8 15:37 ..
-rw-rw-rw- 1 root    root     492 июл  8 18:13 backup-deployment.yml
-rw-rw-rw- 1 root    root     876 июл  8 18:13 front-deployment.yml
-rw-rw-rw- 1 root    root     440 июл  8 15:27 svc-back-prod.yaml
-rw-rw-rw- 1 root    root     404 июл  8 15:46 svc-db.yaml
-rw-rw-rw- 1 root    root     592 июл  8 16:38 svc-endpoint.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim svc-endpoint.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl exec back-prod-8547767c9-rcd2w -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# ping 10.128.0.32
PING 10.128.0.32 (10.128.0.32) 56(84) bytes of data.
64 bytes from 10.128.0.32: icmp_seq=1 ttl=62 time=1.52 ms
64 bytes from 10.128.0.32: icmp_seq=2 ttl=62 time=0.637 ms
64 bytes from 10.128.0.32: icmp_seq=3 ttl=62 time=0.617 ms
^C
--- 10.128.0.32 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 8ms
rtt min/avg/max/mdev = 0.617/0.924/1.519/0.421 ms
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.32:5432
curl: (7) Failed to connect to 10.128.0.32 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# exit
exit
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl logs back-prod-8547767c9-rcd2w -c backup
error: container backup is not valid for pod back-prod-8547767c9-rcd2w
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl logs back-prod-8547767c9-rcd2w
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
back-prod-8547767c9-rcd2w   1/1     Running   0          18m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
db           ClusterIP   10.233.46.8   <none>        5432/TCP   17m
kubernetes   ClusterIP   10.233.0.1    <none>        443/TCP    74m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc,ep
NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/db           ClusterIP   10.233.46.8   <none>        5432/TCP   17m
service/kubernetes   ClusterIP   10.233.0.1    <none>        443/TCP    74m

NAME                   ENDPOINTS          AGE
endpoints/db           10.128.0.32:5432   17m
endpoints/kubernetes   10.128.0.31:6443   74m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep db -o wide
NAME   ENDPOINTS          AGE
db     10.128.0.32:5432   18m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep db -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-08T14:14:47Z"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Endpoints","metadata":{"annotations":{},"name":"db","namespace":"default"},"subsets":[{"addresses":[{"ip":"10.128.0.32"}],"ports":[{"port":5432}]}]}
  creationTimestamp: "2022-07-08T14:14:47Z"
  name: db
  namespace: default
  resourceVersion: "7093"
  uid: 7e83255b-698b-44c5-a0c5-0ad43213fd5c
subsets:
- addresses:
  - ip: 10.128.0.32
  ports:
  - port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl logs back-prod-8547767c9-rcd2w
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl exec back-prod-8547767c9-rcd2w -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.32:5432
curl: (7) Failed to connect to 10.128.0.32 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.32:5432
curl: (7) Failed to connect to 10.128.0.32 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# exit
exit
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
back-prod-8547767c9-rcd2w   1/1     Running   0          29m   10.233.90.1   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ ls -lha
итого 28K
drwxr-xr-x 2 root    root    4,0K июл  8 16:38 .
drwxrwxr-x 4 maestro maestro 4,0K июл  8 15:37 ..
-rw-rw-rw- 1 root    root     492 июл  8 18:13 backup-deployment.yml
-rw-rw-rw- 1 root    root     876 июл  8 18:13 front-deployment.yml
-rw-rw-rw- 1 root    root     440 июл  8 15:27 svc-back-prod.yaml
-rw-rw-rw- 1 root    root     404 июл  8 15:46 svc-db.yaml
-rw-rw-rw- 1 root    root     592 июл  8 16:38 svc-endpoint.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl apply -f svc-endpoint.yml 
endpoints/db configured
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o wide
NAME         ENDPOINTS          AGE
db           10.128.0.21:5432   33m
kubernetes   10.128.0.31:6443   90m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Endpoints",
            "metadata": {
                "annotations": {
                    "endpoints.kubernetes.io/last-change-trigger-time": "2022-07-08T14:14:47Z",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Endpoints\",\"metadata\":{\"annotations\":{},\"name\":\"db\",\"namespace\":\"default\"},\"subsets\":[{\"addresses\":[{\"ip\":\"10.128.0.21\"}],\"ports\":[{\"port\":5432}]}]}\n"
                },
                "creationTimestamp": "2022-07-08T14:14:47Z",
                "name": "db",
                "namespace": "default",
                "resourceVersion": "9950",
                "uid": "7e83255b-698b-44c5-a0c5-0ad43213fd5c"
            },
            "subsets": [
                {
                    "addresses": [
                        {
                            "ip": "10.128.0.21"
                        }
                    ],
                    "ports": [
                        {
                            "port": 5432,
                            "protocol": "TCP"
                        }
                    ]
                }
            ]
        },
        {
            "apiVersion": "v1",
            "kind": "Endpoints",
            "metadata": {
                "creationTimestamp": "2022-07-08T13:18:00Z",
                "labels": {
                    "endpointslice.kubernetes.io/skip-mirror": "true"
                },
                "name": "kubernetes",
                "namespace": "default",
                "resourceVersion": "200",
                "uid": "4cdea0e9-587a-4e82-8f84-4a739b11816e"
            },
            "subsets": [
                {
                    "addresses": [
                        {
                            "ip": "10.128.0.31"
                        }
                    ],
                    "ports": [
                        {
                            "name": "https",
                            "port": 6443,
                            "protocol": "TCP"
                        }
                    ]
                }
            ]
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Endpoints
  metadata:
    annotations:
      endpoints.kubernetes.io/last-change-trigger-time: "2022-07-08T14:14:47Z"
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Endpoints","metadata":{"annotations":{},"name":"db","namespace":"default"},"subsets":[{"addresses":[{"ip":"10.128.0.21"}],"ports":[{"port":5432}]}]}
    creationTimestamp: "2022-07-08T14:14:47Z"
    name: db
    namespace: default
    resourceVersion: "9950"
    uid: 7e83255b-698b-44c5-a0c5-0ad43213fd5c
  subsets:
  - addresses:
    - ip: 10.128.0.21
    ports:
    - port: 5432
      protocol: TCP
- apiVersion: v1
  kind: Endpoints
  metadata:
    creationTimestamp: "2022-07-08T13:18:00Z"
    labels:
      endpointslice.kubernetes.io/skip-mirror: "true"
    name: kubernetes
    namespace: default
    resourceVersion: "200"
    uid: 4cdea0e9-587a-4e82-8f84-4a739b11816e
  subsets:
  - addresses:
    - ip: 10.128.0.31
    ports:
    - name: https
      port: 6443
      protocol: TCP
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim svc-endpoint.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl apply -f svc-endpoint.yml 
endpoints/db configured
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Endpoints
  metadata:
    annotations:
      endpoints.kubernetes.io/last-change-trigger-time: "2022-07-08T14:14:47Z"
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Endpoints","metadata":{"annotations":{},"name":"db","namespace":"default"},"subsets":[{"addresses":[{"ip":"10.128.0.32"}],"ports":[{"port":5432}]}]}
    creationTimestamp: "2022-07-08T14:14:47Z"
    name: db
    namespace: default
    resourceVersion: "10107"
    uid: 7e83255b-698b-44c5-a0c5-0ad43213fd5c
  subsets:
  - addresses:
    - ip: 10.128.0.32
    ports:
    - port: 5432
      protocol: TCP
- apiVersion: v1
  kind: Endpoints
  metadata:
    creationTimestamp: "2022-07-08T13:18:00Z"
    labels:
      endpointslice.kubernetes.io/skip-mirror: "true"
    name: kubernetes
    namespace: default
    resourceVersion: "200"
    uid: 4cdea0e9-587a-4e82-8f84-4a739b11816e
  subsets:
  - addresses:
    - ip: 10.128.0.31
    ports:
    - name: https
      port: 6443
      protocol: TCP
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
back-prod-8547767c9-rcd2w   1/1     Running   0          36m   10.233.90.1   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl describe endpoints
Name:         db
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-08T14:14:47Z
Subsets:
  Addresses:          10.128.0.32
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>


Name:         kubernetes
Namespace:    default
Labels:       endpointslice.kubernetes.io/skip-mirror=true
Annotations:  <none>
Subsets:
  Addresses:          10.128.0.31
  NotReadyAddresses:  <none>
  Ports:
    Name   Port  Protocol
    ----   ----  --------
    https  6443  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl delete endpoints
error: resource(s) were provided, but no name was specified
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl describe endpoints
Name:         db
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-08T14:14:47Z
Subsets:
  Addresses:          10.128.0.32
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>


Name:         kubernetes
Namespace:    default
Labels:       endpointslice.kubernetes.io/skip-mirror=true
Annotations:  <none>
Subsets:
  Addresses:          10.128.0.31
  NotReadyAddresses:  <none>
  Ports:
    Name   Port  Protocol
    ----   ----  --------
    https  6443  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl exec back-prod-8547767c9-rcd2w -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.32:5432
curl: (7) Failed to connect to 10.128.0.32 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.31:5432
curl: (7) Failed to connect to 10.128.0.31 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# ping db
PING db.default.svc.cluster.local (10.233.46.8) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=1 ttl=64 time=0.042 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=2 ttl=64 time=0.072 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=3 ttl=64 time=0.048 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=4 ttl=64 time=0.068 ms
^C
--- db.default.svc.cluster.local ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 34ms
rtt min/avg/max/mdev = 0.042/0.057/0.072/0.014 ms
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.233.46.8:5432
curl: (7) Failed to connect to 10.233.46.8 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.233.46.8:5432
curl: (7) Failed to connect to 10.233.46.8 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# ping db
PING db.default.svc.cluster.local (10.233.46.8) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=1 ttl=64 time=0.043 ms
64 bytes from db.default.svc.cluster.local (10.233.46.8): icmp_seq=2 ttl=64 time=0.068 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3ms
rtt min/avg/max/mdev = 0.043/0.055/0.068/0.014 ms
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.32:5432
curl: (7) Failed to connect to 10.128.0.32 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl 10.128.0.31:5432
curl: (7) Failed to connect to 10.128.0.31 port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# 
root@back-prod-8547767c9-rcd2w:/app# exit
exit
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep
NAME         ENDPOINTS          AGE
db           10.128.0.32:5432   50m
kubernetes   10.128.0.31:6443   107m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep db -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-08T14:14:47Z"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Endpoints","metadata":{"annotations":{},"name":"db","namespace":"default"},"subsets":[{"addresses":[{"ip":"10.128.0.32"}],"ports":[{"port":5432}]}]}
  creationTimestamp: "2022-07-08T14:14:47Z"
  name: db
  namespace: default
  resourceVersion: "10107"
  uid: 7e83255b-698b-44c5-a0c5-0ad43213fd5c
subsets:
- addresses:
  - ip: 10.128.0.32
  ports:
  - port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
db           ClusterIP   10.233.46.8   <none>        5432/TCP   52m
kubernetes   ClusterIP   10.233.0.1    <none>        443/TCP    109m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ ls -lha
итого 28K
drwxr-xr-x 2 root    root    4,0K июл  8 16:38 .
drwxrwxr-x 4 maestro maestro 4,0K июл  8 15:37 ..
-rw-rw-rw- 1 root    root     492 июл  8 18:13 backup-deployment.yml
-rw-rw-rw- 1 root    root     876 июл  8 18:13 front-deployment.yml
-rw-rw-rw- 1 root    root     440 июл  8 15:27 svc-back-prod.yaml
-rw-rw-rw- 1 root    root     404 июл  8 15:46 svc-db.yaml
-rw-rw-rw- 1 root    root     593 июл  8 18:49 svc-endpoint.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ vim svc-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get svc
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
db           ClusterIP   10.233.46.8   <none>        5432/TCP   53m
kubernetes   ClusterIP   10.233.0.1    <none>        443/TCP    110m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get ep
NAME         ENDPOINTS          AGE
db           10.128.0.32:5432   53m
kubernetes   10.128.0.31:6443   110m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
back-prod-8547767c9-rcd2w   1/1     Running   0          56m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl descr pod backup-deployment
error: unknown command "descr" for "kubectl"

Did you mean this?
	describe
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl describe pod back-prod-8547767c9-rcd2w 
Name:         back-prod-8547767c9-rcd2w
Namespace:    default
Priority:     0
Node:         node1/10.128.0.28
Start Time:   Fri, 08 Jul 2022 18:13:56 +0400
Labels:       app=web-app
              pod-template-hash=8547767c9
Annotations:  cni.projectcalico.org/containerID: 373f594f5c611917f922ea08ad1764a14807b0a30dc7029938d00e98b59c1413
              cni.projectcalico.org/podIP: 10.233.90.1/32
              cni.projectcalico.org/podIPs: 10.233.90.1/32
Status:       Running
IP:           10.233.90.1
IPs:
  IP:           10.233.90.1
Controlled By:  ReplicaSet/back-prod-8547767c9
Containers:
  backend:
    Container ID:   containerd://3c02abc6f6673fd89788af1131713e54183ff0907fe07da29f7c6f64ce49b691
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 08 Jul 2022 18:14:27 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      PSQL_PORT:  5432
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6z2hc (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-6z2hc:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  56m   default-scheduler  Successfully assigned default/back-prod-8547767c9-rcd2w to node1
  Normal  Pulling    56m   kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     56m   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 27.938034498s
  Normal  Created    56m   kubelet            Created container backend
  Normal  Started    56m   kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
back-prod-8547767c9-rcd2w   1/1     Running   0          61m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl delete po back-prod-8547767c9-rcd2w 
pod "back-prod-8547767c9-rcd2w" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
back-prod-8547767c9-l8qrw   1/1     Running   0          46s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ kubectl logs back-prod-8547767c9-l8qrw 
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not connect to server: Connection refused
	Is the server running on host "db" (10.233.46.8) and accepting
	TCP/IP connections on port 5432?


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not connect to server: Connection refused
	Is the server running on host "db" (10.233.46.8) and accepting
	TCP/IP connections on port 5432?

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-01$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 .
drwxrwxr-x 5 maestro maestro 4,0K июл  7 19:54 ..
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:16 prod
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 stage
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd stage/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 main
drwxrwxr-x 2 maestro maestro 4,0K июл  7 12:47 training
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ cd main/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ ls -lha
итого 16K
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
-rw-rw-r-- 1 maestro maestro  776 июл  7 17:49 db-app.yaml
-rw-rw-r-- 1 maestro maestro  821 июл  7 08:45 web-fb-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/stage/main/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get nodes 
NAME    STATUS   ROLES           AGE     VERSION
cp1     Ready    control-plane   10m     v1.24.2
node1   Ready    <none>          9m16s   v1.24.2
node2   Ready    <none>          9m16s   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ ls -lha
итого 16K
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
-rw-rw-r-- 1 maestro maestro  776 июл  7 17:49 db-app.yaml
-rw-rw-r-- 1 maestro maestro  821 июл  7 08:45 web-fb-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cat web-fb-app.yaml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
#      app: fb
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-svc
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
#    app: fb-app
#    app: fb
    app: fb-pod
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cat db-app.yaml 
# Config PostgreSQL StatefulSet
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
#  name: db-svc
  name: db
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ ^C
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubrctl get pod

Команда «kubrctl» не найдена. Возможно, вы имели в виду:

  command 'kubectl' from snap kubectl (1.24.2)

See 'snap info <snapname>' for additional versions.

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get namespaces 
NAME              STATUS   AGE
default           Active   76m
kube-node-lease   Active   76m
kube-public       Active   76m
kube-system       Active   76m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -n kube-system
NAME                              READY   STATUS    RESTARTS   AGE
calico-node-bmgmz                 1/1     Running   0          77m
calico-node-dvbft                 1/1     Running   0          77m
calico-node-rz7h4                 1/1     Running   0          77m
coredns-666959ff67-c5hk8          1/1     Running   0          76m
coredns-666959ff67-lhvbr          1/1     Running   0          75m
dns-autoscaler-59b8867c86-mnc9b   1/1     Running   0          75m
kube-apiserver-cp1                1/1     Running   1          79m
kube-controller-manager-cp1       1/1     Running   1          79m
kube-proxy-9wc4h                  1/1     Running   0          78m
kube-proxy-fxwsp                  1/1     Running   0          78m
kube-proxy-xddwl                  1/1     Running   0          78m
kube-scheduler-cp1                1/1     Running   1          79m
nginx-proxy-node1                 1/1     Running   0          77m
nginx-proxy-node2                 1/1     Running   0          77m
nodelocaldns-qjljl                1/1     Running   0          75m
nodelocaldns-wllfz                1/1     Running   0          75m
nodelocaldns-xxk2l                1/1     Running   0          75m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -n kube-public 
No resources found in kube-public namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -n kube-node-lease 
No resources found in kube-node-lease namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   82m   v1.24.2
node1   Ready    <none>          80m   v1.24.2
node2   Ready    <none>          80m   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get nodes -o wide
NAME    STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
cp1     Ready    control-plane   82m   v1.24.2   10.128.0.7    <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node1   Ready    <none>          81m   v1.24.2   10.128.0.31   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node2   Ready    <none>          81m   v1.24.2   10.128.0.29   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl apply -f .
statefulset.apps/db created
service/db created
deployment.apps/fb-pod created
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -o wide
NAME                      READY   STATUS              RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running             0          33s   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-mtgh5   0/2     ContainerCreating   0          33s   <none>        node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          47s   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-mtgh5   2/2     Running   0          47s   10.233.96.2   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get service -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
db           NodePort    10.233.38.124   <none>        5432:32285/TCP   2m11s   app=db
fb-svc       NodePort    10.233.30.110   <none>        80:30080/TCP     2m11s   app=fb-pod
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          88m     <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get endpoints -o wide
NAME         ENDPOINTS          AGE
db           10.233.90.1:5432   2m27s
fb-svc       <none>             2m27s
kubernetes   10.128.0.7:6443    88m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl exec fb-pod-65b9777746-mtgh5 -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-65b9777746-mtgh5:/app# 
root@fb-pod-65b9777746-mtgh5:/app# 
root@fb-pod-65b9777746-mtgh5:/app# cd
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# ping db
PING db.default.svc.cluster.local (10.233.38.124) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.38.124): icmp_seq=1 ttl=64 time=0.074 ms
64 bytes from db.default.svc.cluster.local (10.233.38.124): icmp_seq=2 ttl=64 time=0.073 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1ms
rtt min/avg/max/mdev = 0.073/0.073/0.074/0.008 ms
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# ping frontend
ping: frontend: Name or service not known
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# ping front
ping: front: Name or service not known
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# exit
exit
command terminated with exit code 2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl describe endpoints
Name:         db
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-09T10:29:56Z
Subsets:
  Addresses:          10.233.90.1
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>


Name:         fb-svc
Namespace:    default
Labels:       app=fb
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-09T10:29:44Z
Subsets:
Events:  <none>


Name:         kubernetes
Namespace:    default
Labels:       endpointslice.kubernetes.io/skip-mirror=true
Annotations:  <none>
Subsets:
  Addresses:          10.128.0.7
  NotReadyAddresses:  <none>
  Ports:
    Name   Port  Protocol
    ----   ----  --------
    https  6443  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get endpoints -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Endpoints
  metadata:
    annotations:
      endpoints.kubernetes.io/last-change-trigger-time: "2022-07-09T10:29:56Z"
    creationTimestamp: "2022-07-09T10:29:44Z"
    name: db
    namespace: default
    resourceVersion: "9659"
    uid: a6cf1804-e53c-4ad1-93fa-c216c5108c0a
  subsets:
  - addresses:
    - ip: 10.233.90.1
      nodeName: node1
      targetRef:
        kind: Pod
        name: db-0
        namespace: default
        uid: 5bd01f9b-cad2-4d87-8a8b-43df87f65edd
    ports:
    - port: 5432
      protocol: TCP
- apiVersion: v1
  kind: Endpoints
  metadata:
    annotations:
      endpoints.kubernetes.io/last-change-trigger-time: "2022-07-09T10:29:44Z"
    creationTimestamp: "2022-07-09T10:29:44Z"
    labels:
      app: fb
    name: fb-svc
    namespace: default
    resourceVersion: "9619"
    uid: 3d4bda46-a056-4c00-b3a0-15b48b573943
- apiVersion: v1
  kind: Endpoints
  metadata:
    creationTimestamp: "2022-07-09T09:03:23Z"
    labels:
      endpointslice.kubernetes.io/skip-mirror: "true"
    name: kubernetes
    namespace: default
    resourceVersion: "202"
    uid: 2be23faa-c8e8-4a89-bec1-b5308ebaa32c
  subsets:
  - addresses:
    - ip: 10.128.0.7
    ports:
    - name: https
      port: 6443
      protocol: TCP
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db           NodePort    10.233.38.124   <none>        5432:32285/TCP   14m
fb-svc       NodePort    10.233.30.110   <none>        80:30080/TCP     14m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          101m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get svc db
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db     NodePort   10.233.38.124   <none>        5432:32285/TCP   14m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl describe svc db
Name:                     db
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=db
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.38.124
IPs:                      10.233.38.124
Port:                     <unset>  5432/TCP
TargetPort:               5432/TCP
NodePort:                 <unset>  32285/TCP
Endpoints:                10.233.90.1:5432
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl describe svc fb-svc
Name:                     fb-svc
Namespace:                default
Labels:                   app=fb
Annotations:              <none>
Selector:                 app=fb-pod
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.30.110
IPs:                      10.233.30.110
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:                <none>
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl --help
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources.
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL.

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh or fish)

Other Commands:
  alpha           Commands for features in alpha
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl expose service db 
Error from server (AlreadyExists): services "db" already exists
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl explain 
error: You must specify the type of resource to explain. Use "kubectl api-resources" for a complete list of supported resources.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl explain svc
KIND:     Service
VERSION:  v1

DESCRIPTION:
     Service is a named abstraction of software service (for example, mysql)
     consisting of local port (for example 3306) that the proxy listens on, and
     the selector that determines which pods will answer requests sent through
     the proxy.

FIELDS:
   apiVersion	<string>
     APIVersion defines the versioned schema of this representation of an
     object. Servers should convert recognized schemas to the latest internal
     value, and may reject unrecognized values. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources

   kind	<string>
     Kind is a string value representing the REST resource this object
     represents. Servers may infer this from the endpoint the client submits
     requests to. Cannot be updated. In CamelCase. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

   metadata	<Object>
     Standard object's metadata. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata

   spec	<Object>
     Spec defines the behavior of a service.
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

   status	<Object>
     Most recently observed status of the service. Populated by the system.
     Read-only. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl explain svc.spec
KIND:     Service
VERSION:  v1

RESOURCE: spec <Object>

DESCRIPTION:
     Spec defines the behavior of a service.
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

     ServiceSpec describes the attributes that a user creates on a service.

FIELDS:
   allocateLoadBalancerNodePorts	<boolean>
     allocateLoadBalancerNodePorts defines if NodePorts will be automatically
     allocated for services with type LoadBalancer. Default is "true". It may be
     set to "false" if the cluster load-balancer does not rely on NodePorts. If
     the caller requests specific NodePorts (by specifying a value), those
     requests will be respected, regardless of this field. This field may only
     be set for services with type LoadBalancer and will be cleared if the type
     is changed to any other type.

   clusterIP	<string>
     clusterIP is the IP address of the service and is usually assigned
     randomly. If an address is specified manually, is in-range (as per system
     configuration), and is not in use, it will be allocated to the service;
     otherwise creation of the service will fail. This field may not be changed
     through updates unless the type field is also being changed to ExternalName
     (which requires this field to be blank) or the type field is being changed
     from ExternalName (in which case this field may optionally be specified, as
     describe above). Valid values are "None", empty string (""), or a valid IP
     address. Setting this to "None" makes a "headless service" (no virtual IP),
     which is useful when direct endpoint connections are preferred and proxying
     is not required. Only applies to types ClusterIP, NodePort, and
     LoadBalancer. If this field is specified when creating a Service of type
     ExternalName, creation will fail. This field will be wiped when updating a
     Service to type ExternalName. More info:
     https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies

   clusterIPs	<[]string>
     ClusterIPs is a list of IP addresses assigned to this service, and are
     usually assigned randomly. If an address is specified manually, is in-range
     (as per system configuration), and is not in use, it will be allocated to
     the service; otherwise creation of the service will fail. This field may
     not be changed through updates unless the type field is also being changed
     to ExternalName (which requires this field to be empty) or the type field
     is being changed from ExternalName (in which case this field may optionally
     be specified, as describe above). Valid values are "None", empty string
     (""), or a valid IP address. Setting this to "None" makes a "headless
     service" (no virtual IP), which is useful when direct endpoint connections
     are preferred and proxying is not required. Only applies to types
     ClusterIP, NodePort, and LoadBalancer. If this field is specified when
     creating a Service of type ExternalName, creation will fail. This field
     will be wiped when updating a Service to type ExternalName. If this field
     is not specified, it will be initialized from the clusterIP field. If this
     field is specified, clients must ensure that clusterIPs[0] and clusterIP
     have the same value.

     This field may hold a maximum of two entries (dual-stack IPs, in either
     order). These IPs must correspond to the values of the ipFamilies field.
     Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field.
     More info:
     https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies

   externalIPs	<[]string>
     externalIPs is a list of IP addresses for which nodes in the cluster will
     also accept traffic for this service. These IPs are not managed by
     Kubernetes. The user is responsible for ensuring that traffic arrives at a
     node with this IP. A common example is external load-balancers that are not
     part of the Kubernetes system.

   externalName	<string>
     externalName is the external reference that discovery mechanisms will
     return as an alias for this service (e.g. a DNS CNAME record). No proxying
     will be involved. Must be a lowercase RFC-1123 hostname
     (https://tools.ietf.org/html/rfc1123) and requires `type` to be
     "ExternalName".

   externalTrafficPolicy	<string>
     externalTrafficPolicy denotes if this Service desires to route external
     traffic to node-local or cluster-wide endpoints. "Local" preserves the
     client source IP and avoids a second hop for LoadBalancer and Nodeport type
     services, but risks potentially imbalanced traffic spreading. "Cluster"
     obscures the client source IP and may cause a second hop to another node,
     but should have good overall load-spreading.

     Possible enum values:
     - `"Cluster"` specifies node-global (legacy) behavior.
     - `"Local"` specifies node-local endpoints behavior.

   healthCheckNodePort	<integer>
     healthCheckNodePort specifies the healthcheck nodePort for the service.
     This only applies when type is set to LoadBalancer and
     externalTrafficPolicy is set to Local. If a value is specified, is
     in-range, and is not in use, it will be used. If not specified, a value
     will be automatically allocated. External systems (e.g. load-balancers) can
     use this port to determine if a given node holds endpoints for this service
     or not. If this field is specified when creating a Service which does not
     need it, creation will fail. This field will be wiped when updating a
     Service to no longer need it (e.g. changing type).

   internalTrafficPolicy	<string>
     InternalTrafficPolicy specifies if the cluster internal traffic should be
     routed to all endpoints or node-local endpoints only. "Cluster" routes
     internal traffic to a Service to all endpoints. "Local" routes traffic to
     node-local endpoints only, traffic is dropped if no node-local endpoints
     are ready. The default value is "Cluster".

   ipFamilies	<[]string>
     IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this
     service. This field is usually assigned automatically based on cluster
     configuration and the ipFamilyPolicy field. If this field is specified
     manually, the requested family is available in the cluster, and
     ipFamilyPolicy allows it, it will be used; otherwise creation of the
     service will fail. This field is conditionally mutable: it allows for
     adding or removing a secondary IP family, but it does not allow changing
     the primary IP family of the Service. Valid values are "IPv4" and "IPv6".
     This field only applies to Services of types ClusterIP, NodePort, and
     LoadBalancer, and does apply to "headless" services. This field will be
     wiped when updating a Service to type ExternalName.

     This field may hold a maximum of two entries (dual-stack families, in
     either order). These families must correspond to the values of the
     clusterIPs field, if specified. Both clusterIPs and ipFamilies are governed
     by the ipFamilyPolicy field.

   ipFamilyPolicy	<string>
     IPFamilyPolicy represents the dual-stack-ness requested or required by this
     Service. If there is no value provided, then this field will be set to
     SingleStack. Services can be "SingleStack" (a single IP family),
     "PreferDualStack" (two IP families on dual-stack configured clusters or a
     single IP family on single-stack clusters), or "RequireDualStack" (two IP
     families on dual-stack configured clusters, otherwise fail). The ipFamilies
     and clusterIPs fields depend on the value of this field. This field will be
     wiped when updating a service to type ExternalName.

   loadBalancerClass	<string>
     loadBalancerClass is the class of the load balancer implementation this
     Service belongs to. If specified, the value of this field must be a
     label-style identifier, with an optional prefix, e.g. "internal-vip" or
     "example.com/internal-vip". Unprefixed names are reserved for end-users.
     This field can only be set when the Service type is 'LoadBalancer'. If not
     set, the default load balancer implementation is used, today this is
     typically done through the cloud provider integration, but should apply for
     any default implementation. If set, it is assumed that a load balancer
     implementation is watching for Services with a matching class. Any default
     load balancer implementation (e.g. cloud providers) should ignore Services
     that set this field. This field can only be set when creating or updating a
     Service to type 'LoadBalancer'. Once set, it can not be changed. This field
     will be wiped when a service is updated to a non 'LoadBalancer' type.

   loadBalancerIP	<string>
     Only applies to Service Type: LoadBalancer. This feature depends on whether
     the underlying cloud-provider supports specifying the loadBalancerIP when a
     load balancer is created. This field will be ignored if the cloud-provider
     does not support the feature. Deprecated: This field was under-specified
     and its meaning varies across implementations, and it cannot support
     dual-stack. As of Kubernetes v1.24, users are encouraged to use
     implementation-specific annotations when available. This field may be
     removed in a future API version.

   loadBalancerSourceRanges	<[]string>
     If specified and supported by the platform, this will restrict traffic
     through the cloud-provider load-balancer will be restricted to the
     specified client IPs. This field will be ignored if the cloud-provider does
     not support the feature." More info:
     https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/

   ports	<[]Object>
     The list of ports that are exposed by this service. More info:
     https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies

   publishNotReadyAddresses	<boolean>
     publishNotReadyAddresses indicates that any agent which deals with
     endpoints for this Service should disregard any indications of
     ready/not-ready. The primary use case for setting this field is for a
     StatefulSet's Headless Service to propagate SRV DNS records for its Pods
     for the purpose of peer discovery. The Kubernetes controllers that generate
     Endpoints and EndpointSlice resources for Services interpret this to mean
     that all endpoints are considered "ready" even if the Pods themselves are
     not. Agents which consume only Kubernetes generated endpoints through the
     Endpoints or EndpointSlice resources can safely assume this behavior.

   selector	<map[string]string>
     Route service traffic to pods with label keys and values matching this
     selector. If empty or not present, the service is assumed to have an
     external process managing its endpoints, which Kubernetes will not modify.
     Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if
     type is ExternalName. More info:
     https://kubernetes.io/docs/concepts/services-networking/service/

   sessionAffinity	<string>
     Supports "ClientIP" and "None". Used to maintain session affinity. Enable
     client IP based session affinity. Must be ClientIP or None. Defaults to
     None. More info:
     https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies

     Possible enum values:
     - `"ClientIP"` is the Client IP based.
     - `"None"` - no session affinity.

   sessionAffinityConfig	<Object>
     sessionAffinityConfig contains the configurations of session affinity.

   type	<string>
     type determines how the Service is exposed. Defaults to ClusterIP. Valid
     options are ExternalName, ClusterIP, NodePort, and LoadBalancer.
     "ClusterIP" allocates a cluster-internal IP address for load-balancing to
     endpoints. Endpoints are determined by the selector or if that is not
     specified, by manual construction of an Endpoints object or EndpointSlice
     objects. If clusterIP is "None", no virtual IP is allocated and the
     endpoints are published as a set of endpoints rather than a virtual IP.
     "NodePort" builds on ClusterIP and allocates a port on every node which
     routes to the same endpoints as the clusterIP. "LoadBalancer" builds on
     NodePort and creates an external load-balancer (if supported in the current
     cloud) which routes to the same endpoints as the clusterIP. "ExternalName"
     aliases this service to the specified externalName. Several other fields do
     not apply to ExternalName services. More info:
     https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types

     Possible enum values:
     - `"ClusterIP"` means a service will only be accessible inside the cluster,
     via the cluster IP.
     - `"ExternalName"` means a service consists of only a reference to an
     external name that kubedns or equivalent will return as a CNAME record,
     with no exposing or proxying of any pods involved.
     - `"LoadBalancer"` means a service will be exposed via an external load
     balancer (if the cloud provider supports it), in addition to 'NodePort'
     type.
     - `"NodePort"` means a service will be exposed on one port of every node,
     in addition to 'ClusterIP' type.

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ ls -lha
итого 16K
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
-rw-rw-r-- 1 maestro maestro  776 июл  7 17:49 db-app.yaml
-rw-rw-r-- 1 maestro maestro  821 июл  7 08:45 web-fb-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 main
drwxrwxr-x 2 maestro maestro 4,0K июл  7 12:47 training
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ cd training/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ ls -lha
итого 36K
drwxrwxr-x 2 maestro maestro 4,0K июл  7 12:47 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  206 июл  7 07:47 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro    2 июл  6 15:02 ep-db-svc.yaml
-rw-rw-r-- 1 maestro maestro  236 июл  7 09:06 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  601 июл  7 07:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ mkdir -p multitool && cd multitool
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ vim multitool.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ ping 51.250.79.255
PING 51.250.79.255 (51.250.79.255) 56(84) bytes of data.
64 bytes from 51.250.79.255: icmp_seq=1 ttl=53 time=25.6 ms
64 bytes from 51.250.79.255: icmp_seq=2 ttl=53 time=25.2 ms
^C
--- 51.250.79.255 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 25.202/25.406/25.610/0.204 ms
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ curl 51.250.79.255:5432
curl: (7) Failed to connect to 51.250.79.255 port 5432: В соединении отказано
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ ls -lha
итого 20K
drwxrwxr-x 5 maestro maestro 4,0K июл  7 19:54 .
drwxrwxr-x 6 maestro maestro 4,0K июл  7 17:51 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  5 15:24 main
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 postgres
drwxr-xr-x 2 root    root    4,0K июл  9 12:28 template
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ cd postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 .
drwxrwxr-x 5 maestro maestro 4,0K июл  7 19:54 ..
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:16 prod
drwxrwxr-x 5 maestro maestro 4,0K июл 10 08:02 stage
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd stage/main/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ ls -lha
итого 16K
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 .
drwxrwxr-x 5 maestro maestro 4,0K июл 10 08:02 ..
-rw-rw-r-- 1 maestro maestro  776 июл  7 17:49 db-app.yaml
-rw-rw-r-- 1 maestro maestro  821 июл  7 08:45 web-fb-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cat web-fb-app.yaml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
#      app: fb
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-svc
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
#    app: fb-app
#    app: fb
    app: fb-pod
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cat db-app.yaml 
# Config PostgreSQL StatefulSet
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
#  name: db-svc
  name: db
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ curl ipconfig.me
Moved Permanently. Redirecting to https://ifconfig.me/maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ curl ifconfig.me
128.69.71.165maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ curl 51.250.79.255:5432
curl: (7) Failed to connect to 51.250.79.255 port 5432: В соединении отказано
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/stage/m
bash: cd: learning-kubernetes/Betta/manifest/postgres/stage/m: Нет такого файла или каталога
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/stage/main/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   17m   v1.24.2
node1   Ready    <none>          15m   v1.24.2
node2   Ready    <none>          15m   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ cd multitool/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ l
multitool.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ ll
итого 12
drwxrwxr-x 2 maestro maestro 4096 июл 10 08:08 ./
drwxrwxr-x 5 maestro maestro 4096 июл 10 08:02 ../
-rw-rw-r-- 1 maestro maestro  550 июл 10 08:08 multitool.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl apply -f multitool.yaml 
deployment.apps/multitool created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl -get pod
Error: flags cannot be placed before plugin name: -get
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl get pod
NAME                         READY   STATUS              RESTARTS   AGE
multitool-86dd874c4c-9snbd   0/2     ContainerCreating   0          16s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
multitool-86dd874c4c-9snbd   2/2     Running   0          19s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
multitool-86dd874c4c-9snbd   2/2     Running   0          22s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl get pod -o wide
NAME                         READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
multitool-86dd874c4c-9snbd   2/2     Running   0          52s   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl describe pod multitool-86dd874c4c-9snbd 
Name:         multitool-86dd874c4c-9snbd
Namespace:    default
Priority:     0
Node:         node2/10.128.0.23
Start Time:   Sun, 10 Jul 2022 13:13:10 +0400
Labels:       app=multitool
              pod-template-hash=86dd874c4c
Annotations:  cni.projectcalico.org/containerID: 3f885a9d1978297035f852c6c0ca8421634cee0ad7ec20dc47eb6f49e5680283
              cni.projectcalico.org/podIP: 10.233.96.1/32
              cni.projectcalico.org/podIPs: 10.233.96.1/32
Status:       Running
IP:           10.233.96.1
IPs:
  IP:           10.233.96.1
Controlled By:  ReplicaSet/multitool-86dd874c4c
Containers:
  nginx:
    Container ID:   containerd://83f1f2350161c744203e8371b6b7a57375c14ec601d253a97c1434d8ced00016
    Image:          nginx:1.20
    Image ID:       docker.io/library/nginx@sha256:38f8c1d9613f3f42e7969c3b1dd5c3277e635d4576713e6453c6193e66270a6d
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 10 Jul 2022 13:13:20 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n69kf (ro)
  multitool:
    Container ID:   containerd://e6a72038b76f36dda003b0ddd0d4b1590c4415b7c70e5f19b38fecddde4a9034
    Image:          praqma/network-multitool:alpine-extra
    Image ID:       docker.io/praqma/network-multitool@sha256:5662f8284f0dc5f5e5c966e054d094cbb6d0774e422ad9031690826bc43753e5
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 10 Jul 2022 13:13:28 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      HTTP_PORT:  8080
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n69kf (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-n69kf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  80s   default-scheduler  Successfully assigned default/multitool-86dd874c4c-9snbd to node2
  Normal  Pulling    78s   kubelet            Pulling image "nginx:1.20"
  Normal  Pulled     71s   kubelet            Successfully pulled image "nginx:1.20" in 7.713604696s
  Normal  Created    71s   kubelet            Created container nginx
  Normal  Started    71s   kubelet            Started container nginx
  Normal  Pulling    71s   kubelet            Pulling image "praqma/network-multitool:alpine-extra"
  Normal  Pulled     63s   kubelet            Successfully pulled image "praqma/network-multitool:alpine-extra" in 7.250343026s
  Normal  Created    63s   kubelet            Created container multitool
  Normal  Started    63s   kubelet            Started container multitool
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl get pod -o wide
NAME                         READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
multitool-86dd874c4c-9snbd   2/2     Running   0          3m52s   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl exec multitool-86dd874c4c-9snbd -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
Defaulted container "nginx" out of: nginx, multitool
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# docker ps
bash: docker: command not found
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# ps -aux  
bash: ps: command not found
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# ping
bash: ping: command not found
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# ip a
bash: ip: command not found
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# who
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# whoami
root
root@multitool-86dd874c4c-9snbd:/# 
root@multitool-86dd874c4c-9snbd:/# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl exec multitool-86dd874c4c-9snbd -c multitool -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
bash-5.1# 
bash-5.1# 
bash-5.1# ping 
ping: usage error: Destination address required
bash-5.1# 
bash-5.1# ping nginx
ping: nginx: Name does not resolve
bash-5.1# 
bash-5.1# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1430 qdisc noqueue state UP group default 
    link/ether 5a:ba:3e:a2:b1:83 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.233.96.1/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::58ba:3eff:fea2:b183/64 scope link 
       valid_lft forever preferred_lft forever
bash-5.1# 
bash-5.1# cat /etc/*release
3.13.6
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.13.6
PRETTY_NAME="Alpine Linux v3.13"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://bugs.alpinelinux.org/"
bash-5.1# 
bash-5.1# curl
curl: try 'curl --help' or 'curl --manual' for more information
bash-5.1# 
bash-5.1# telnet
BusyBox v1.32.1 () multi-call binary.

Usage: telnet [-a] [-l USER] HOST [PORT]

Connect to telnet server

	-a	Automatic login with $USER variable
	-l USER	Automatic login as USER
bash-5.1# 
bash-5.1# 
bash-5.1# traceroute
BusyBox v1.32.1 () multi-call binary.

Usage: traceroute [-46FIlnrv] [-f 1ST_TTL] [-m MAXTTL] [-q PROBES] [-p PORT]
	[-t TOS] [-w WAIT_SEC] [-s SRC_IP] [-i IFACE]
	[-z PAUSE_MSEC] HOST [BYTES]

Trace the route to HOST

	-4,-6	Force IP or IPv6 name resolution
	-F	Set don't fragment bit
	-I	Use ICMP ECHO instead of UDP datagrams
	-l	Display TTL value of the returned packet
	-n	Print numeric addresses
	-r	Bypass routing tables, send directly to HOST
	-v	Verbose
	-f N	First number of hops (default 1)
	-m N	Max number of hops
	-q N	Number of probes per hop (default 3)
	-p N	Base UDP port number used in probes
		(default 33434)
	-s IP	Source address
	-i IFACE Source interface
	-t N	Type-of-service in probe packets (default 0)
	-w SEC	Time to wait for a response (default 3)
	-g IP	Loose source route gateway (8 max)
bash-5.1# 
bash-5.1# 
bash-5.1# 
bash-5.1# 
bash-5.1# 
bash-5.1# 
bash-5.1# cat /etc/*release
3.13.6
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.13.6
PRETTY_NAME="Alpine Linux v3.13"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://bugs.alpinelinux.org/"
bash-5.1# 
bash-5.1# curl
curl: try 'curl --help' or 'curl --manual' for more information
bash-5.1# 
bash-5.1# 
bash-5.1# ping 10.128.0.8
PING 10.128.0.8 (10.128.0.8) 56(84) bytes of data.
64 bytes from 10.128.0.8: icmp_seq=1 ttl=62 time=1.71 ms
64 bytes from 10.128.0.8: icmp_seq=2 ttl=62 time=0.453 ms
^C
--- 10.128.0.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 0.453/1.080/1.707/0.627 ms
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# ping 10.233.0.1
PING 10.233.0.1 (10.233.0.1) 56(84) bytes of data.
64 bytes from 10.233.0.1: icmp_seq=1 ttl=64 time=0.054 ms
64 bytes from 10.233.0.1: icmp_seq=2 ttl=64 time=0.048 ms
^C
--- 10.233.0.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.048/0.051/0.054/0.003 ms
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8
curl: (7) Failed to connect to 10.128.0.8 port 80 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:8000
curl: (7) Failed to connect to 10.128.0.8 port 8000 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# ping 10.128.0.8
PING 10.128.0.8 (10.128.0.8) 56(84) bytes of data.
64 bytes from 10.128.0.8: icmp_seq=1 ttl=62 time=1.02 ms
64 bytes from 10.128.0.8: icmp_seq=2 ttl=62 time=0.459 ms
64 bytes from 10.128.0.8: icmp_seq=3 ttl=62 time=0.558 ms
^C
--- 10.128.0.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 0.459/0.678/1.018/0.243 ms
bash-5.1# 
bash-5.1# 
bash-5.1# traceroute 10.128.0.8
traceroute to 10.128.0.8 (10.128.0.8), 30 hops max, 46 byte packets
 1  node2.ru-central1.internal (10.128.0.23)  0.007 ms  0.005 ms  0.002 ms
 2  10.128.0.1 (10.128.0.1)  0.597 ms  0.272 ms  0.292 ms
 3  *  *^C
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8
curl: (7) Failed to connect to 10.128.0.8 port 80 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:8000
curl: (7) Failed to connect to 10.128.0.8 port 8000 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:8000
curl: (7) Failed to connect to 10.128.0.8 port 8000 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:9000
curl: (7) Failed to connect to 10.128.0.8 port 9000 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.233.53.214:5432
curl: (7) Failed to connect to 10.233.53.214 port 5432 after 1006 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5433
curl: (7) Failed to connect to 10.128.0.8 port 5433 after 0 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
curl: (7) Failed to connect to 10.128.0.8 port 5432 after 1 ms: Connection refused
bash-5.1# 
bash-5.1# curl 10.128.0.8:5432
^C
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ kubectl exec multitool-86dd874c4c-9snbd -c multitool -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# uptime
 14:59:01 up  8:50,  0 users,  load average: 0.00, 0.00, 0.00
bash-5.1# 
bash-5.1# 
bash-5.1# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1430 qdisc noqueue state UP group default 
    link/ether 5a:ba:3e:a2:b1:83 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.233.96.1/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::58ba:3eff:fea2:b183/64 scope link 
       valid_lft forever preferred_lft forever
bash-5.1# 
bash-5.1# curl 10.128.0.10:5432
curl: (52) Empty reply from server
bash-5.1# 
bash-5.1# maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   33m   v1.24.2
node1   Ready    <none>          32m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/stage
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ ls -lha
итого 20K
drwxrwxr-x 5 maestro maestro 4,0K июл 10 08:02 .
drwxrwxr-x 4 maestro maestro 4,0K июл  7 17:15 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  7 17:49 main
drwxrwxr-x 3 maestro maestro 4,0K июл 10 18:22 multitool
drwxrwxr-x 4 maestro maestro 4,0K июл 11 08:22 training
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage$ cd training/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ ls -lha
итого 44K
drwxrwxr-x 4 maestro maestro 4,0K июл 11 08:22 .
drwxrwxr-x 5 maestro maestro 4,0K июл 10 08:02 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  206 июл  7 07:47 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro    2 июл  6 15:02 ep-db-svc.yaml
-rw-rw-r-- 1 maestro maestro  236 июл  7 09:06 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
drwxrwxr-x 2 maestro maestro 4,0K июл 10 21:03 v-01
drwxrwxr-x 2 maestro maestro 4,0K июл 11 08:22 v-02
-rw-rw-r-- 1 maestro maestro  601 июл  7 07:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ mv v-02/ v-220711
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ ls -lha
итого 44K
drwxrwxr-x 4 maestro maestro 4,0K июл 11 08:23 .
drwxrwxr-x 5 maestro maestro 4,0K июл 10 08:02 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  206 июл  7 07:47 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro    2 июл  6 15:02 ep-db-svc.yaml
-rw-rw-r-- 1 maestro maestro  236 июл  7 09:06 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
drwxrwxr-x 2 maestro maestro 4,0K июл 10 21:03 v-01
drwxrwxr-x 2 maestro maestro 4,0K июл 11 08:22 v-220711
-rw-rw-r-- 1 maestro maestro  601 июл  7 07:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training$ cd v-220711/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ ls -lha
итого 12K
drwxrwxr-x 2 maestro maestro 4,0K июл 11 08:22 .
drwxrwxr-x 4 maestro maestro 4,0K июл 11 08:23 ..
-rw-rw-r-- 1 maestro maestro  821 июл  7 08:45 web-fb-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim web-fb-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim README.md
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim README.md
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim web-fb-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   79m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get ep
NAME         ENDPOINTS          AGE
kubernetes   10.128.0.28:6443   79m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe ep kubernetes 
Name:         kubernetes
Namespace:    default
Labels:       endpointslice.kubernetes.io/skip-mirror=true
Annotations:  <none>
Subsets:
  Addresses:          10.128.0.28
  NotReadyAddresses:  <none>
  Ports:
    Name   Port  Protocol
    ----   ----  --------
    https  6443  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl aply -f web-fb-app.yaml 
error: unknown command "aply" for "kubectl"

Did you mean this?
	apply
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f web-fb-app.yaml 
deployment.apps/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          88s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c 
Defaulted container "frontend" out of: frontend, backend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/11 04:44:10 [notice] 1#1: using the "epoll" event method
2022/07/11 04:44:10 [notice] 1#1: nginx/1.23.0
2022/07/11 04:44:10 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/11 04:44:10 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/11 04:44:10 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/11 04:44:10 [notice] 1#1: start worker processes
2022/07/11 04:44:10 [notice] 1#1: start worker process 29
2022/07/11 04:44:10 [notice] 1#1: start worker process 30
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend | grep db
    return self.dbapi.connect(*cargs, **cparams)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    return self.dbapi.connect(*cargs, **cparams)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend | grep "db"
    return self.dbapi.connect(*cargs, **cparams)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    return self.dbapi.connect(*cargs, **cparams)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend | grep known
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# cd 
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# echo $DATABASE_URL

root@fb-pod-6fdbd9c5f6-dsw2c:~# echo 'export DATABASE_URL="postgres://postgres:postgres@db:5432/news" >> ~/.bashrc
> ^C
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# echo 'export DATABASE_URL="postgres://postgres:postgres@db:5432/news"' >> ~/.bashrc
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# source .bashrc
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# echo $DATABASE_URL
postgres://postgres:postgres@db:5432/news
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c frontend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# cd
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# echo $BASE_URL

root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# echo 'export BASE_URL="http://localhost:9000"' >> ~/.bashrc
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# source .bashrc
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# echo $BASE_URL
http://localhost:9000
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   111m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ ls -lha
итого 20K
drwxrwxr-x 2 maestro maestro 4,0K июл 11 08:38 .
drwxrwxr-x 4 maestro maestro 4,0K июл 11 08:23 ..
-rw-rw-r-- 1 maestro maestro  220 июл 11 08:24 nodeport-svc-front.yaml
-rw-rw-r-- 1 maestro maestro  499 июл 11 08:35 README.md
-rw-rw-r-- 1 maestro maestro  650 июл 11 08:38 web-fb-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
fb-svc       NodePort    10.233.33.38   <none>        80:30080/TCP   7s
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP        113m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   115m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.7.184   <none>        8000:30080/TCP   33s
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          115m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe svc fb-svc 
Name:                     fb-svc
Namespace:                default
Labels:                   app=fb
Annotations:              <none>
Selector:                 app=fb-pod
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.7.184
IPs:                      10.233.7.184
Port:                     <unset>  8000/TCP
TargetPort:               8000/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:                <none>
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.7.184   <none>        8000:30080/TCP   3m58s
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          119m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.43.85   <none>        8000:30080/TCP   5s
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          119m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   146m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.26.132   <none>        8000:30080/TCP   3s
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          146m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.26.132   <none>        8000:30080/TCP   7m15s
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          153m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.24.238   <none>        8000:30080/TCP   4s
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          153m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe svc fb-svc 
Name:                     fb-svc
Namespace:                default
Labels:                   app=fb-app
Annotations:              <none>
Selector:                 app=fb-app
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.24.238
IPs:                      10.233.24.238
Port:                     <unset>  8000/TCP
TargetPort:               8000/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:                10.233.90.2:8000
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.7.183   <none>        8000:30080/TCP   51s
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          169m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs svc fb
Error from server (NotFound): pods "svc" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs pods/fb-pod-6fdbd9c5f6-dsw2c -c frontend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/11 04:44:10 [notice] 1#1: using the "epoll" event method
2022/07/11 04:44:10 [notice] 1#1: nginx/1.23.0
2022/07/11 04:44:10 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/11 04:44:10 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/11 04:44:10 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/11 04:44:10 [notice] 1#1: start worker processes
2022/07/11 04:44:10 [notice] 1#1: start worker process 29
2022/07/11 04:44:10 [notice] 1#1: start worker process 30
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c frontend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# cd
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# curl 127.1:80
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# curl 127.1:8000
curl: (7) Failed to connect to 127.1 port 8000: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# curl 127.1:9000
curl: (7) Failed to connect to 127.1 port 9000: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# curl 127.1:5432
curl: (7) Failed to connect to 127.1 port 5432: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# reboot
bash: reboot: command not found
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# reload
bash: reload: command not found
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# exit
exit
command terminated with exit code 127
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.7.183   <none>        8000:30080/TCP   4m48s
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          173m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim 10-cluster-ip.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mv 10-cluster-ip.yaml fb-clip-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f fb-clip-svc.yaml 
service/fb-clip-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
fb-clip-svc   ClusterIP   10.233.15.191   <none>        8000/TCP         7s
fb-svc        NodePort    10.233.7.183    <none>        8000:30080/TCP   10m
kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP          179m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim fb-clip-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-clip-svc 
service "fb-clip-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f fb-clip-svc.yaml 
service/fb-clip-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po fb-pod-6fdbd9c5f6-dsw2c 
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          100m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po fb-pod-6fdbd9c5f6-dsw2c -o wide
NAME                      READY   STATUS    RESTARTS   AGE    IP            NODE    NOMINATED NODE   READINESS GATES
fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          101m   10.233.90.2   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe po fb-pod-6fdbd9c5f6-dsw2c 
Name:         fb-pod-6fdbd9c5f6-dsw2c
Namespace:    default
Priority:     0
Node:         node1/10.128.0.16
Start Time:   Mon, 11 Jul 2022 08:44:00 +0400
Labels:       app=fb-app
              pod-template-hash=6fdbd9c5f6
Annotations:  cni.projectcalico.org/containerID: 0b3126687e12f48eb3d3054e2764827585048b2a18d0edd48f180865f6be39a0
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  ReplicaSet/fb-pod-6fdbd9c5f6
Containers:
  frontend:
    Container ID:   containerd://f0e1157f4bbbe701ace7d90cadc3276b1a4f2bb28648d40cbc4b84f7116ce739
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 11 Jul 2022 08:44:10 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4fdnm (ro)
  backend:
    Container ID:   containerd://787bb6bf98c6d4c6356d8f796ffb4821e0f43f7fb56d6d8c0e5b933ca920facd
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 11 Jul 2022 08:44:39 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4fdnm (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4fdnm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-clip-svc 
service "fb-clip-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
fb-svc       NodePort    10.233.7.183   <none>        8000:30080/TCP   18m
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          3h6m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-svc 
service "fb-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim fb-clip-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f fb-clip-svc.yaml 
service/fb-clip-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c frontend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# cd
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# curl 127.1:80
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f clasterip-db.yaml 
service/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
endpoints/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          114m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         7m30s
service/fb-pod        ClusterIP   10.233.37.46    <none>        5432/TCP       24s
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   8m18s
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        3h16m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     7m30s
endpoints/fb-pod        10.128.0.14:5432   16s
endpoints/fb-svc        10.233.90.2:80     8m18s
endpoints/kubernetes    10.128.0.28:6443   3h16m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# cd
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# curl 10.128.0.14:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# 
root@fb-pod-6fdbd9c5f6-dsw2c:~# exit
exit
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# ping db
ping: db: Name or service not known
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl 10.128.0.14:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:/app# exit
exit
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          124m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         17m
service/fb-pod        ClusterIP   10.233.37.46    <none>        5432/TCP       10m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   18m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        3h26m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     17m
endpoints/fb-pod        10.128.0.14:5432   10m
endpoints/fb-svc        10.233.90.2:80     18m
endpoints/kubernetes    10.128.0.28:6443   3h26m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-pod 
service "fb-pod" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete ep fb-pod 
Error from server (NotFound): endpoints "fb-pod" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          125m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         18m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   19m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        3h27m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     18m
endpoints/fb-svc        10.233.90.2:80     19m
endpoints/kubernetes    10.128.0.28:6443   3h27m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
error: error validating "endpoint-db.yml": error validating data: ValidationError(Endpoints): unknown field "namespace" in io.k8s.api.core.v1.Endpoints; if you choose to ignore these errors, turn validation off with --validate=false
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
error: error validating "endpoint-db.yml": error validating data: ValidationError(Endpoints): unknown field "namespace" in io.k8s.api.core.v1.Endpoints; if you choose to ignore these errors, turn validation off with --validate=false
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f clasterip-db.yaml 
service/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
error: error validating "endpoint-db.yml": error validating data: ValidationError(Endpoints): unknown field "namespace" in io.k8s.api.core.v1.Endpoints; if you choose to ignore these errors, turn validation off with --validate=false
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
endpoints/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# ping db
PING db.default.svc.cluster.local (10.233.32.46) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=1 ttl=64 time=0.044 ms
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=2 ttl=64 time=0.068 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2ms
rtt min/avg/max/mdev = 0.044/0.056/0.068/0.012 ms
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl 127.1:5432
curl: (7) Failed to connect to 127.1 port 5432: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl 10.128.0.14:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# ping db
PING db.default.svc.cluster.local (10.233.32.46) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=1 ttl=64 time=0.040 ms
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=2 ttl=64 time=0.064 ms
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=3 ttl=64 time=0.064 ms
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=4 ttl=64 time=0.073 ms
^C
--- db.default.svc.cluster.local ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 28ms
rtt min/avg/max/mdev = 0.040/0.060/0.073/0.013 ms
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl 10.128.0.14:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# ping db
PING db.default.svc.cluster.local (10.233.32.46) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=1 ttl=64 time=0.041 ms
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=2 ttl=64 time=0.071 ms

64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=3 ttl=64 time=0.064 ms
^C
--- db.default.svc.cluster.local ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 17ms
rtt min/avg/max/mdev = 0.041/0.058/0.071/0.015 ms
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          136m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.32.46    <none>        5432/TCP       9m17s
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         30m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   30m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        3h38m

NAME                    ENDPOINTS          AGE
endpoints/db            10.128.0.14:5432   7m52s
endpoints/fb-clip-svc   10.233.90.2:80     30m
endpoints/fb-svc        10.233.90.2:80     30m
endpoints/kubernetes    10.128.0.28:6443   3h38m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# ping db
PING db.default.svc.cluster.local (10.233.32.46) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=1 ttl=64 time=0.043 ms
64 bytes from db.default.svc.cluster.local (10.233.32.46): icmp_seq=2 ttl=64 time=0.068 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 24ms
rtt min/avg/max/mdev = 0.043/0.055/0.068/0.014 ms
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# exit
exit
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete ep fb-pod 
Error from server (NotFound): endpoints "fb-pod" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          158m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.32.46    <none>        5432/TCP       31m
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         52m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   52m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h

NAME                    ENDPOINTS          AGE
endpoints/db            10.128.0.14:5432   29m
endpoints/fb-clip-svc   10.233.90.2:80     52m
endpoints/fb-svc        10.233.90.2:80     52m
endpoints/kubernetes    10.128.0.28:6443   4h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete ep db
endpoints "db" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
endpoints/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          163m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.32.46    <none>        5432/TCP       35m
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         56m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   57m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h5m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     56m
endpoints/fb-pod        10.128.0.14:5432   3m35s
endpoints/fb-svc        10.233.90.2:80     57m
endpoints/kubernetes    10.128.0.28:6443   4h5m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc db 
service "db" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f clasterip-db.yaml 
service/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (6) Could not resolve host: db
command terminated with exit code 6
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          166m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         59m
service/fb-pod        ClusterIP   10.233.23.58    <none>        5432/TCP       48s
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   60m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h8m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     59m
endpoints/fb-pod        10.128.0.14:5432   7m7s
endpoints/fb-svc        10.233.90.2:80     60m
endpoints/kubernetes    10.128.0.28:6443   4h8m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl fb-pod:5432
curl: (7) Failed to connect to fb-pod port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- ping db-pod
ping: db-pod: Name or service not known
command terminated with exit code 2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- ping fb-pod
PING fb-pod.default.svc.cluster.local (10.233.23.58) 56(84) bytes of data.
64 bytes from fb-pod.default.svc.cluster.local (10.233.23.58): icmp_seq=1 ttl=64 time=0.043 ms
64 bytes from fb-pod.default.svc.cluster.local (10.233.23.58): icmp_seq=2 ttl=64 time=0.064 ms
^C
--- fb-pod.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2ms
rtt min/avg/max/mdev = 0.043/0.053/0.064/0.012 ms
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc fb-pod 
service "fb-pod" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete ep fb-pod 
Error from server (NotFound): endpoints "fb-pod" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          168m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         61m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   62m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h10m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     61m
endpoints/fb-svc        10.233.90.2:80     62m
endpoints/kubernetes    10.128.0.28:6443   4h10m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.16:5432
curl: (7) Failed to connect to 10.128.0.16 port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f clasterip-db.yaml 
service/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          170m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.36.154   <none>        5432/TCP       5s
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         63m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   64m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h12m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     63m
endpoints/fb-svc        10.233.90.2:80     64m
endpoints/kubernetes    10.128.0.28:6443   4h12m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc unchanged
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f endpoint-db.yml 
endpoints/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          172m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.36.154   <none>        5432/TCP       85s
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         65m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   66m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h14m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     65m
endpoints/fb-pod        10.128.0.14:5432   6s
endpoints/fb-svc        10.233.90.2:80     66m
endpoints/kubernetes    10.128.0.28:6443   4h14m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- ping db
PING db.default.svc.cluster.local (10.233.36.154) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.36.154): icmp_seq=1 ttl=64 time=0.042 ms
64 bytes from db.default.svc.cluster.local (10.233.36.154): icmp_seq=2 ttl=64 time=0.068 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3ms
rtt min/avg/max/mdev = 0.042/0.055/0.068/0.013 ms
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc db 
service "db" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          179m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         72m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   73m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h21m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     72m
endpoints/fb-pod        10.128.0.14:5432   7m25s
endpoints/fb-svc        10.233.90.2:80     73m
endpoints/kubernetes    10.128.0.28:6443   4h21m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete ep fb-pod 
endpoints "fb-pod" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          3h

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         73m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   74m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h22m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     73m
endpoints/fb-svc        10.233.90.2:80     74m
endpoints/kubernetes    10.128.0.28:6443   4h22m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl apply -f clasterip-db.yaml 
service/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get po,svc,ep
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          3h

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.46.103   <none>        5432/TCP       5s
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         73m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   74m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h22m

NAME                    ENDPOINTS          AGE
endpoints/db            10.233.90.2:5432   5s
endpoints/fb-clip-svc   10.233.90.2:80     73m
endpoints/fb-svc        10.233.90.2:80     74m
endpoints/kubernetes    10.128.0.28:6443   4h22m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- ping db
PING db.default.svc.cluster.local (10.233.46.103) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.46.103): icmp_seq=1 ttl=64 time=0.041 ms
64 bytes from db.default.svc.cluster.local (10.233.46.103): icmp_seq=2 ttl=64 time=0.070 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3ms
rtt min/avg/max/mdev = 0.041/0.055/0.070/0.016 ms
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- telnet db:5432
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "9614c7d2759e4c2303faa302a141c125b8a29de7ce31d94552dd211c4c83f8ce": OCI runtime exec failed: exec failed: unable to start container process: exec: "telnet": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl -v db:5432
* Expire in 0 ms for 6 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 2 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 0 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 4 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
* Expire in 1 ms for 1 (transfer 0x55ff7002d0f0)
*   Trying 10.233.46.103...
* TCP_NODELAY set
* Expire in 200 ms for 4 (transfer 0x55ff7002d0f0)
* connect to 10.233.46.103 port 5432 failed: Connection refused
* Failed to connect to db port 5432: Connection refused
* Closing connection 0
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get -A --selector=fb-app
You must specify the type of resource to get. Use "kubectl api-resources" for a complete list of supported resources.

error: Required resource not specified.
Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
See 'kubectl get -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get pod --selector=fb-app
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc --selector=fb-app
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc
NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
db            ClusterIP   10.233.46.103   <none>        5432/TCP       26m
fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         100m
fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   101m
kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h49m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc -o wide
NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE     SELECTOR
db            ClusterIP   10.233.46.103   <none>        5432/TCP       26m     app=fb-app
fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         100m    app=fb-app
fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   101m    app=fb-app
kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h49m   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc --selector=app=fb-app
NAME     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
db       ClusterIP   10.233.46.103   <none>        5432/TCP       27m
fb-svc   NodePort    10.233.16.252   <none>        80:30080/TCP   102m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get pod --selector=app=fb-app
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          3h28m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get pod --selector=app=db
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc --selector=app=db
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc,ep
NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.46.103   <none>        5432/TCP       29m
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         103m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   104m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        4h52m

NAME                    ENDPOINTS          AGE
endpoints/db            10.233.90.2:5432   29m
endpoints/fb-clip-svc   10.233.90.2:80     103m
endpoints/fb-svc        10.233.90.2:80     104m
endpoints/kubernetes    10.128.0.28:6443   4h52m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe pod fb-pod-6fdbd9c5f6-dsw2c 
Name:         fb-pod-6fdbd9c5f6-dsw2c
Namespace:    default
Priority:     0
Node:         node1/10.128.0.16
Start Time:   Mon, 11 Jul 2022 08:44:00 +0400
Labels:       app=fb-app
              pod-template-hash=6fdbd9c5f6
Annotations:  cni.projectcalico.org/containerID: 0b3126687e12f48eb3d3054e2764827585048b2a18d0edd48f180865f6be39a0
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  ReplicaSet/fb-pod-6fdbd9c5f6
Containers:
  frontend:
    Container ID:   containerd://f0e1157f4bbbe701ace7d90cadc3276b1a4f2bb28648d40cbc4b84f7116ce739
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 11 Jul 2022 08:44:10 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4fdnm (ro)
  backend:
    Container ID:   containerd://787bb6bf98c6d4c6356d8f796ffb4821e0f43f7fb56d6d8c0e5b933ca920facd
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 11 Jul 2022 08:44:39 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4fdnm (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4fdnm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe ep db
Name:         db
Namespace:    default
Labels:       app=fb-app
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-11T07:44:31Z
Subsets:
  Addresses:          10.233.90.2
  NotReadyAddresses:  <none>
  Ports:
    Name  Port  Protocol
    ----  ----  --------
    db    5432  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl describe svc db
Name:              db
Namespace:         default
Labels:            app=fb-app
Annotations:       <none>
Selector:          app=fb-app
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.46.103
IPs:               10.233.46.103
Port:              db  5432/TCP
TargetPort:        5432/TCP
Endpoints:         10.233.90.2:5432
Session Affinity:  None
Events:            <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get ep db -o wide
NAME   ENDPOINTS          AGE
db     10.233.90.2:5432   32m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get ep db -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-11T07:44:31Z"
  creationTimestamp: "2022-07-11T07:44:31Z"
  labels:
    app: fb-app
  name: db
  namespace: default
  resourceVersion: "24387"
  uid: c268aa3b-9d66-40c7-9819-047ab88be724
subsets:
- addresses:
  - ip: 10.233.90.2
    nodeName: node1
    targetRef:
      kind: Pod
      name: fb-pod-6fdbd9c5f6-dsw2c
      namespace: default
      uid: f1622557-b7f1-40a1-8601-1f524bc4e4a1
  ports:
  - name: db
    port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get ep db -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-11T07:44:31Z"
  creationTimestamp: "2022-07-11T07:44:31Z"
  labels:
    app: fb-app
  name: db
  namespace: default
  resourceVersion: "24387"
  uid: c268aa3b-9d66-40c7-9819-047ab88be724
subsets:
- addresses:
  - ip: 10.233.90.2
    nodeName: node1
    targetRef:
      kind: Pod
      name: fb-pod-6fdbd9c5f6-dsw2c
      namespace: default
      uid: f1622557-b7f1-40a1-8601-1f524bc4e4a1
  ports:
  - name: db
    port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc,ep
NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.46.103   <none>        5432/TCP       60m
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         134m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   135m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        5h23m

NAME                    ENDPOINTS          AGE
endpoints/db            10.233.90.2:5432   60m
endpoints/fb-clip-svc   10.233.90.2:80     134m
endpoints/fb-svc        10.233.90.2:80     135m
endpoints/kubernetes    10.128.0.28:6443   5h23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl -v db:5432
* Expire in 0 ms for 6 (transfer 0x564272f010f0)
* Expire in 1 ms for 1 (transfer 0x564272f010f0)
* Expire in 1 ms for 1 (transfer 0x564272f010f0)
* Expire in 2 ms for 1 (transfer 0x564272f010f0)
* Expire in 2 ms for 1 (transfer 0x564272f010f0)
* Expire in 2 ms for 1 (transfer 0x564272f010f0)
* Expire in 4 ms for 1 (transfer 0x564272f010f0)
* Expire in 3 ms for 1 (transfer 0x564272f010f0)
* Expire in 3 ms for 1 (transfer 0x564272f010f0)
* Expire in 4 ms for 1 (transfer 0x564272f010f0)
* Expire in 3 ms for 1 (transfer 0x564272f010f0)
* Expire in 4 ms for 1 (transfer 0x564272f010f0)
* Expire in 4 ms for 1 (transfer 0x564272f010f0)
*   Trying 10.233.46.103...
* TCP_NODELAY set
* Expire in 200 ms for 4 (transfer 0x564272f010f0)
* connect to 10.233.46.103 port 5432 failed: Connection refused
* Failed to connect to db port 5432: Connection refused
* Closing connection 0
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (7) Failed to connect to db port 5432: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl delete svc db
service "db" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl get svc,ep
NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         136m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   137m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        5h25m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     136m
endpoints/fb-svc        10.233.90.2:80     137m
endpoints/kubernetes    10.128.0.28:6443   5h25m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ cd 12-48/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ ls -lha
итого 16K
drwxrwxr-x 2 maestro maestro 4,0K июл 11 12:48 .
drwxrwxr-x 3 maestro maestro 4,0K июл 11 12:48 ..
-rw-rw-r-- 1 maestro maestro  261 июл 11 11:41 clasterip-db.yaml
-rw-r--r-- 1 maestro maestro  232 июл 11 11:42 endpoint-db.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ cat clasterip-db.yaml endpoint-db.yml 
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
#  name: fb-pod
  labels:
    app: fb-app
  name: db
  namespace: default
spec:
  ports:
    - name: db      
      port: 5432
      targetPort: 5432
  selector:
    app: fb-app
---
apiVersion: v1
kind: Endpoints
metadata:
  name: fb-pod 
#  name: db  
  namespace: default
  labels:
    app: fb-app
subsets:
  - addresses:
      - ip: 10.128.0.14
    ports:
      - port: 5432
    selector:
      app: fb-app
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ vim endpoint-db.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ vim clasterip-db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl apply -f clasterip-db.yaml 
service/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get svc,ep
NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.24.244   <none>        5432/TCP       7s
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         144m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   145m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        5h33m

NAME                    ENDPOINTS          AGE
endpoints/fb-clip-svc   10.233.90.2:80     144m
endpoints/fb-svc        10.233.90.2:80     145m
endpoints/kubernetes    10.128.0.28:6443   5h33m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl apply -f endpoint-db.yml 
endpoints/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get svc,ep
NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/db            ClusterIP   10.233.24.244   <none>        5432/TCP       24s
service/fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         144m
service/fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   145m
service/kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        5h33m

NAME                    ENDPOINTS          AGE
endpoints/db            10.128.0.14:5432   2s
endpoints/fb-clip-svc   10.233.90.2:80     144m
endpoints/fb-svc        10.233.90.2:80     145m
endpoints/kubernetes    10.128.0.28:6443   5h33m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl 10.128.0.14:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- curl db:5432
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend | grep known
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl logs fb-pod-6fdbd9c5f6-dsw2c -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# reload
bash: reload: command not found
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# reboot
bash: reboot: command not found
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5433
curl: (7) Failed to connect to db port 5433: Connection refused
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# exit
exit
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ cat clasterip-db.yaml
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
#  name: fb-pod
#  labels:
#    app: fb-app
  name: db
  namespace: default
spec:
  ports:
    - name: db      
      port: 5432
      targetPort: 5432
#  selector:
#    app: fb-app
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ cat endpoint-db.yml 
---
apiVersion: v1
kind: Endpoints
metadata:
#  name: fb-pod 
  name: db  
  namespace: default
#  labels:
#    app: fb-app
subsets:
  - addresses:
      - ip: 10.128.0.14
    ports:
      - port: 5432
        name: db
#    selector:
#      app: fb-app
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ pwd
/home/maestro/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-dsw2c -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# shutdown -r now
bash: shutdown: command not found
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# apt install reboot
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package reboot
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# apt install reload
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package reload
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# ls -lha
total 28K
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 11 04:44 ..
-rw-r--r-- 1 root root  280 Jul  4 09:09 Pipfile
-rw-r--r-- 1 root root  12K Jul  4 09:09 Pipfile.lock
-rw-r--r-- 1 root root 2.3K Jul  4 09:09 main.py
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# echo $DATABASE_URL
postgres://postgres:postgres@db:5432/news
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# psql
bash: psql: command not found
root@fb-pod-6fdbd9c5f6-dsw2c:/app# 
root@fb-pod-6fdbd9c5f6-dsw2c:/app# exit
exit
command terminated with exit code 127
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6fdbd9c5f6-dsw2c   2/2     Running   0          5h21m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           5h21m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl delete po fb-pod-6fdbd9c5f6-dsw2c 
pod "fb-pod-6fdbd9c5f6-dsw2c" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6fdbd9c5f6-7ls58   2/2     Running   0          51s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl logs fb-pod-6fdbd9c5f6-7ls58 -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
INFO:     Started server process [8]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -- curl db:5432
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -- curl db:5432
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
curl: (52) Empty reply from server
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -- bash
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-7ls58:/app# 
root@fb-pod-6fdbd9c5f6-7ls58:/app# cd
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# echo $DATABASE_UR

root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# echo $DATABASE_URL

root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# echo 'export DATABASE_URL="postgres://postgres:postgres@db:5432/news"' >> ~/.bashrc
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# source .bashrc
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# echo $DATABASE_URL
postgres://postgres:postgres@db:5432/news
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl logs fb-pod-6fdbd9c5f6-7ls58 -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
INFO:     Started server process [8]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c frontend -it -- bash
root@fb-pod-6fdbd9c5f6-7ls58:/app# 
root@fb-pod-6fdbd9c5f6-7ls58:/app# echo 'export BASE_URL="http://localhost:9000"' >> ~/.bashrc
root@fb-pod-6fdbd9c5f6-7ls58:/app# 
root@fb-pod-6fdbd9c5f6-7ls58:/app# source .bashrc
bash: .bashrc: No such file or directory
root@fb-pod-6fdbd9c5f6-7ls58:/app# 
root@fb-pod-6fdbd9c5f6-7ls58:/app# cd
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# source .bashrc
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# echo $BASE_URL
http://localhost:9000
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# curl
curl: try 'curl --help' or 'curl --manual' for more information
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# curl 127.1
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# ip a
bash: ip: command not found
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# exit
exit
command terminated with exit code 127
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -it -- ip a
Defaulted container "frontend" out of: frontend, backend
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "77fac8828535970e1a736a41590d3feb7029be728927d4db42c34e08c1bfeb39": OCI runtime exec failed: exec failed: unable to start container process: exec: "ip": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get pod _ o wide
Error from server (NotFound): pods "_" not found
Error from server (NotFound): pods "o" not found
Error from server (NotFound): pods "wide" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
fb-pod-6fdbd9c5f6-7ls58   2/2     Running   0          30m   10.233.90.3   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/12-48$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mkdir -p 14-45
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711$ cd 14-45/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ vim nodeport-svc-front.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl apply -f nodeport-svc-front.yaml 
service/fb-svc configured
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl get np
error: the server doesn't have a resource type "np"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl get nodes 
NAME    STATUS   ROLES           AGE     VERSION
cp1     Ready    control-plane   7h23m   v1.24.2
node1   Ready    <none>          7h22m   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl get svc
NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
db            ClusterIP   10.233.24.244   <none>        5432/TCP       110m
fb-clip-svc   ClusterIP   10.233.48.91    <none>        80/TCP         4h15m
fb-svc        NodePort    10.233.16.252   <none>        80:30080/TCP   4h15m
kubernetes    ClusterIP   10.233.0.1      <none>        443/TCP        7h23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -it -- env 
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=fb-pod-6fdbd9c5f6-7ls58
LANG=C.UTF-8
GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568
PYTHON_VERSION=3.9.13
PYTHON_PIP_VERSION=22.0.4
PYTHON_SETUPTOOLS_VERSION=58.1.0
PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/6ce3639da143c5d79b44f94b04080abf2531fd6e/public/get-pip.py
PYTHON_GET_PIP_SHA256=ba3ab8267d91fd41c58dbce08f76db99f747f716d85ce1865813842bb035524d
FB_CLIP_SVC_PORT_80_TCP_PROTO=tcp
FB_CLIP_SVC_PORT_80_TCP_PORT=80
DB_PORT_5432_TCP_PORT=5432
FB_SVC_PORT=tcp://10.233.16.252:80
FB_SVC_PORT_80_TCP_PORT=80
FB_CLIP_SVC_PORT=tcp://10.233.48.91:80
KUBERNETES_SERVICE_HOST=10.233.0.1
KUBERNETES_PORT_443_TCP_PORT=443
FB_CLIP_SVC_PORT_80_TCP_ADDR=10.233.48.91
DB_SERVICE_HOST=10.233.24.244
DB_PORT_5432_TCP_ADDR=10.233.24.244
KUBERNETES_SERVICE_PORT=443
FB_CLIP_SVC_PORT_80_TCP=tcp://10.233.48.91:80
DB_PORT_5432_TCP_PROTO=tcp
FB_SVC_SERVICE_PORT=80
KUBERNETES_PORT_443_TCP=tcp://10.233.0.1:443
FB_SVC_PORT_80_TCP=tcp://10.233.16.252:80
FB_SVC_PORT_80_TCP_PROTO=tcp
FB_CLIP_SVC_SERVICE_PORT_WEB=80
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP_ADDR=10.233.0.1
FB_SVC_PORT_80_TCP_ADDR=10.233.16.252
FB_CLIP_SVC_SERVICE_HOST=10.233.48.91
DB_SERVICE_PORT=5432
KUBERNETES_PORT_443_TCP_PROTO=tcp
FB_SVC_SERVICE_HOST=10.233.16.252
FB_CLIP_SVC_SERVICE_PORT=80
DB_PORT_5432_TCP=tcp://10.233.24.244:5432
KUBERNETES_PORT=tcp://10.233.0.1:443
DB_PORT=tcp://10.233.24.244:5432
DB_SERVICE_PORT_DB=5432
TERM=xterm
HOME=/root
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -it -- bash
root@fb-pod-6fdbd9c5f6-7ls58:/app# 
root@fb-pod-6fdbd9c5f6-7ls58:/app# cd
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# echo $DATABASE_URL
postgres://postgres:postgres@db:5432/news
root@fb-pod-6fdbd9c5f6-7ls58:~# 
root@fb-pod-6fdbd9c5f6-7ls58:~# env
KUBERNETES_SERVICE_PORT_HTTPS=443
FB_CLIP_SVC_PORT_80_TCP_PORT=80
KUBERNETES_SERVICE_PORT=443
DATABASE_URL=postgres://postgres:postgres@db:5432/news
HOSTNAME=fb-pod-6fdbd9c5f6-7ls58
PYTHON_VERSION=3.9.13
FB_CLIP_SVC_SERVICE_PORT=80
DB_PORT_5432_TCP_ADDR=10.233.24.244
PWD=/root
PYTHON_SETUPTOOLS_VERSION=58.1.0
DB_PORT=tcp://10.233.24.244:5432
HOME=/root
LANG=C.UTF-8
KUBERNETES_PORT_443_TCP=tcp://10.233.0.1:443
FB_SVC_PORT_80_TCP_ADDR=10.233.16.252
DB_SERVICE_PORT_DB=5432
GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568
DB_SERVICE_PORT=5432
FB_CLIP_SVC_PORT_80_TCP=tcp://10.233.48.91:80
FB_CLIP_SVC_SERVICE_PORT_WEB=80
FB_SVC_PORT_80_TCP_PORT=80
DB_SERVICE_HOST=10.233.24.244
DB_PORT_5432_TCP=tcp://10.233.24.244:5432
FB_SVC_PORT_80_TCP=tcp://10.233.16.252:80
TERM=xterm
FB_SVC_SERVICE_HOST=10.233.16.252
FB_CLIP_SVC_PORT_80_TCP_ADDR=10.233.48.91
FB_SVC_PORT_80_TCP_PROTO=tcp
FB_CLIP_SVC_PORT=tcp://10.233.48.91:80
SHLVL=1
KUBERNETES_PORT_443_TCP_PROTO=tcp
PYTHON_PIP_VERSION=22.0.4
KUBERNETES_PORT_443_TCP_ADDR=10.233.0.1
DB_PORT_5432_TCP_PROTO=tcp
PYTHON_GET_PIP_SHA256=ba3ab8267d91fd41c58dbce08f76db99f747f716d85ce1865813842bb035524d
KUBERNETES_SERVICE_HOST=10.233.0.1
DB_PORT_5432_TCP_PORT=5432
KUBERNETES_PORT=tcp://10.233.0.1:443
KUBERNETES_PORT_443_TCP_PORT=443
PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/6ce3639da143c5d79b44f94b04080abf2531fd6e/public/get-pip.py
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
FB_CLIP_SVC_PORT_80_TCP_PROTO=tcp
FB_SVC_SERVICE_PORT=80
FB_SVC_PORT=tcp://10.233.16.252:80
FB_CLIP_SVC_SERVICE_HOST=10.233.48.91
OLDPWD=/app
_=/usr/bin/env
root@fb-pod-6fdbd9c5f6-7ls58:~# exit
exit
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -it -- whoami
root
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ kubectl exec fb-pod-6fdbd9c5f6-7ls58 -c backend -it -- echo $DATABASE_URL

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-220711/14-45$ 
```
