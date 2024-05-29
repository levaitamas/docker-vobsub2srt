# Copyright (C) 2023- Tamas Levai <levait@tmit.bme.hu>
# Copyright (C) 2018  Andrew Hayzen <ahayzen@gmail.com>
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

FROM alpine:3.20

RUN apk add --no-cache bash wget ca-certificates git cmake make pkgconf g++ tiff-dev tesseract-ocr-dev \
    && wget https://github.com/tesseract-ocr/tessdata_best/raw/main/eng.traineddata -O /usr/share/tessdata/eng.traineddata \
    && git clone https://github.com/ecdye/VobSub2SRT.git VobSub2SRT \
    && cd VobSub2SRT \
    && git checkout f3205f54448505e56daaf7449fdddc1a4d036d50 \
    && sed -Ei 's/#include <vector>/#include <vector>\n#include <climits>/' src/vobsub2srt.c++ \
    && ./configure \
    && make -j`nproc` \
    && make install \
    && make distclean \
    && cd .. \
    && rm -rf VobSub2SRT \
    && strip /usr/local/bin/vobsub2srt \
    && apk del git wget ca-certificates cmake make pkgconf g++

RUN echo "cd /subs" > /root/.bashrc \
    && echo "conv() { vobsub2srt --blacklist \"|\/_~<>\" --verbose \"\$1\" && chown 1000:1000 \"\$1.srt\"; }" >> /root/.bashrc

CMD /bin/bash
