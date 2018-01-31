FROM ubuntu:14.04
RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y git build-essential python

RUN git clone https://github.com/Z3Prover/z3.git
WORKDIR z3
RUN python scripts/mk_make.py && cd build && make && sudo make install

RUN apt-get install -y curl
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN apt-get install -y libncurses5-dev libncursesw5-dev
RUN apt-get install -y openjdk-7-jdk
WORKDIR ../
RUN git clone https://github.com/GaloisInc/saw-script.git
WORKDIR saw-script
RUN ln -s stack.ghc-8.2-unix.yaml stack.yaml
RUN apt-get install -y zip
RUN ./build.sh
RUN ln -s $(stack path --local-install-root)/bin/* /usr/local/bin
