FROM base/archlinux

COPY mirrorlist /etc/pacman.d/mirrorlist
RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -Syu
RUN pacman-db-upgrade
RUN pacman --noconfirm -S vim
RUN pacman --noconfirm -S gcc make cmake python2

RUN mkdir /root/dinamite/

COPY llvm-3.5.0.src.tar.xz /root/dinamite/
RUN cd /root/dinamite; \
        tar xf llvm-3.5.0.src.tar.xz; \
        rm llvm-3.5.0.src.tar.xz;

COPY cfe-3.5.0.src.tar.xz /root/dinamite/
RUN cd /root/dinamite; \
        tar xf cfe-3.5.0.src.tar.xz; \
        rm cfe-3.5.0.src.tar.xz;\
        mv cfe-3.5.0.src llvm-3.5.0.src/tools/clang

COPY clang-tools-extra-3.5.0.src.tar.xz /root/dinamite/
RUN cd /root/dinamite; \
        tar xf clang-tools-extra-3.5.0.src.tar.xz; \
        rm clang-tools-extra-3.5.0.src.tar.xz;\
        mv clang-tools-extra-3.5.0.src llvm-3.5.0.src/tools/clang/tools/extra

COPY compiler-rt-3.5.0.src.tar.xz /root/dinamite/
RUN cd /root/dinamite; \
        tar xf compiler-rt-3.5.0.src.tar.xz; \
        rm compiler-rt-3.5.0.src.tar.xz;\
        mv compiler-rt-3.5.0.src llvm-3.5.0.src/projects/compiler-rt

COPY dinamite_clang_gcc6.patch /root/dinamite/llvm-3.5.0.src/
RUN pacman --noconfirm -S patch
RUN cd /root/dinamite/llvm-3.5.0.src/ ;\
        patch -p0 < dinamite_clang_gcc6.patch

RUN mkdir /root/dinamite/build/; \
        cd /root/dinamite/build ;\
        cmake -G "Unix Makefiles" ../llvm-3.5.0.src ;\
        make -j4

RUN ln -s /usr/bin/python2 /usr/bin/python ;\
        cd /root/dinamite/llvm-3.5.0.src ;\
        ./configure

COPY bashrc /root/.bashrc

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN pacman --noconfirm -S git

RUN pacman --noconfirm -S ca-certificates ca-certificates-mozilla


RUN cd /root/dinamite/llvm-3.5.0.src/projects/ ;\
       git clone https://github.com/dinamite-toolkit/dinamite 

RUN cd /root/dinamite/llvm-3.5.0.src/projects/dinamite/library ;\
        PATH=$PATH:/root/dinamite/build/bin/ make binary;\
        cd /root/dinamite/llvm-3.5.0.src/projects/dinamite ;\
        make

RUN pacman --noconfirm -S openssh

