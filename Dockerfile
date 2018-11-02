# Copyright (C) 2018 Andrew Hayzen <ahayzen@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
