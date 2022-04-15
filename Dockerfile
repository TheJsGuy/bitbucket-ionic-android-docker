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
&& sudo wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip \
&& sudo unzip -q commandlinetools-linux-8092744_latest.zip \
&& export ANDROID_HOME="$PWD/cmdline-tools" \
&& export PATH="$PWD/cmdline-tools/bin/:$PATH" \
&& yes | sdkmanager --licenses --sdk_root=$ANDROID_HOME \
&& sdkmanager "platforms;android-30" "build-tools;30.0.3" "extras;google;m2repository" "extras;android;m2repository" --sdk_root=$ANDROID_HOME \
&& yes | sdkmanager --licenses --sdk_root=$ANDROID_HOME \
&& sdkmanager --list --sdk_root=$ANDROID_HOME \
&& . /etc/profile \
&& apt remove wget unzip  -y \
&& apt install gradle -y \
&& apt autoremove -y  \
&& npm install @ionic/cli cordova

ENV ANDROID_HOME /opt/android-sdk-linux/cmdline-tools
