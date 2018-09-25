FROM debian:9

RUN apt-get update \
    && apt-get install -y git libtiff5-dev libtesseract-dev tesseract-ocr-eng build-essential cmake pkg-config \
    && apt-get clean \
    && git clone https://gitlab.com/ahayzen/mirror-VobSub2SRT.git VobSub2SRT \
    && cd VobSub2SRT \
    && git checkout 0ba6e25e078a040195d7295e860cc9064bef7c2c \
    && ./configure \
    && make -j`nproc` \
    && make install \
    && make clean \
    && apt-get purge -y git cmake pkg-config build-essential \
    && apt-get autoremove -y

RUN echo "cd /subs" > /root/.bashrc \
    && echo "conv() { vobsub2srt --blacklist \"|\/_~<>\" --verbose \"\$1\" && chown 1000:1000 \"\$1.srt\"; }" >> /root/.bashrc

CMD /bin/bash
