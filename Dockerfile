#
# BlissCollector Dockerfile
#

# Pull base image.
FROM centos:latest

# Install dependencies
RUN yum install -y git wget gcc-c++ make perl php java-1.8.0-openjdk java-1.8.0-openjdk-devel git-svn unzip epel-release && \
    yum clean all

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# Install JRuby
RUN curl https://s3.amazonaws.com/jruby.org/downloads/9.0.3.0/jruby-bin-9.0.3.0.tar.gz | tar xz -C /opt
ENV PATH /opt/jruby-9.0.3.0/bin:$PATH

# Update system gems and install bundler
RUN gem update --system 2.5.1 \
    && gem install bundler

# Install Go 1.5
RUN cd /tmp && \
    wget https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go1.5.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc && \
    mkdir /root/go
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /root/go
ENV PATH $PATH:/root/go/bin

# Set max heap space for java
ENV JAVA_OPTS '-Xms512m -Xmx2048m'

# Install Node.js, CSSlint, ESlint, nsp
RUN curl --silent --location https://rpm.nodesource.com/setup | bash - \
    && yum install -y nodejs --enablerepo=epel \
    && npm install -g jshint csslint eslint nsp

# Clone phpcs & wpcs & pmd & ocstyle
RUN cd /root \
    && git clone https://github.com/founderbliss/ocstyle.git /root/ocstyle \
    && git clone https://github.com/iconnor/pmd.git /root/pmd \
    && git clone https://github.com/squizlabs/PHP_CodeSniffer.git /root/phpcs \
    && git clone https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /root/wpcs \
    && /root/phpcs/scripts/phpcs --config-set installed_paths /root/wpcs

# Install Perl Critic
RUN yum install -y 'perl(Perl::Critic)'

# Install pip modules
RUN pip install importlib argparse lizard django prospector parcon ocstyle

# Install Tailor
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.71-2.b15.el7_2.x86_64
RUN curl -fsSL https://s3.amazonaws.com/bliss-cli-dependencies/tailor-install.sh | sh

# Install gometalinter
RUN go get github.com/alecthomas/gometalinter
RUN gometalinter --install --update

ENV BLISS_CLI_VERSION 43

# Get collector tasks and gems
RUN git clone https://github.com/founderbliss/enterprise-analyzer.git /root/collector \
    && cd /root/collector \
    && bundle install --without test && mv /root/collector/.rubocop.yml /root/.rubocop.yml \
    && mv /root/collector/jshintoptions.json /root/jshintoptions.json \
    && mv /root/collector/json.js /root/json.js \
    && mv /root/collector/eslintoptions.json /root/eslintoptions.json \
    && mv /root/collector/.eslintrc /root/.eslintrc \
    && mkdir /root/bliss && mv /root/collector/.prospector.yml /root/bliss/.prospector.yml

# Set default encoding
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /root

# Define default command.
CMD ["/bin/bash"]
