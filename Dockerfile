FROM ubuntu:latest
WORKDIR /

ENV DEBIAN_FRONTEND noninteractive
RUN set -x \
&& apt update \
&& apt install sudo openjdk-8-jdk gradle wget unzip curl git -y  \
&& curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - \
&& sudo apt-get install -y nodejs \
&& export ANDROID_HOME=/opt/android-sdk-linux \
&& sudo mkdir -p $ANDROID_HOME \
&& cd $ANDROID_HOME \
&& sudo wget https://dl.google.com/android/repository/tools_r25.2.3-linux.zip \
&& sudo unzip tools_r25.2.3-linux.zip \
&& cd tools \
&& (while sleep 3; do echo "y"; done)|sudo ./android update sdk --no-ui \
&& export PATH=${PATH}:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/build-tools/25.0.2/ \
&& . /etc/profile \
&& apt remove wget unzip  -y \
&& apt install gradle -y \
&& apt autoremove -y  \
&& npm install @ionic/cli cordova yarn -g
