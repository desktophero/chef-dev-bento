FROM ubuntu:14.04.3
MAINTAINER Jason Walker <desktophero@gmail.com>

RUN apt-get update
RUN apt-get install -y wget curl git apt-transport-https software-properties-common make
RUN apt-get install -y build-essential make curl
RUN apt-get install -y vagrant
RUN apt-get install -y vim
RUN apt-get install -y gcc
# RUN apt-get install -y gcc-c++
RUN apt-get install -y strace
# RUN apt-get install -y vim-enhanced
RUN apt-get install -y dos2unix
RUN apt-get install -y libxml2-devel
RUN apt-get install -y libvslt-devel
RUN apt-get install -y lsof
RUN apt-get install -y git

# For those CI environments
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN wget --no-check-certificate https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.10.0-1_amd64.deb -O ~/chefdk.deb
RUN dpkg -i ~/chefdk.deb && rm -rf ~/chefdk.deb

ENV PATH="/opt/chefdk/bin:/root/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
ENV GEM_HOME="/root/.chefdk/gem/ruby/2.1.0"
ENV GEM_PATH="/root/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"

# pre-install some specific Ruby Gems into Chef DK
RUN chef gem install \
  rest-client:1.8.0 \
  kitchen-openstack:1.8.1 \
  kitchen-vagrant:0.19.0 \
  faraday:0.9.1 \
  hipchat:1.5.2 \
  rake:10.4.2 \
  chef-sugar:3.1.1 \
  statsd:0.5.4 \
  consul-kv \
  --no-ri --no-rdoc
