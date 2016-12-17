FROM mkoch/java:latest
MAINTAINER Michael Koch <michael.koch@enough.de>

ENV TERM dumb
ENV DEBIAN_FRONTEND noninteractive

RUN \
        dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y --no-install-recommends libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN curl -L "${ANDROID_SDK_URL}" | tar --no-same-owner -xz -C /usr/local
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

ENV ANDROID_COMPONENTS platform-tools,build-tools-24.0.2,android-24
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository

RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_COMPONENTS}" ; \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_COMPONENTS}"

