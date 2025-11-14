#! /bin/bash
set -xue
QEMU=qemu-system-riscv32
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot


# qemu-system-riscv32 -machine virt -bios default -nographic -serial mon:stdio --no-rebootだとエラーが出る
# QEMUが-bios defaultで呼び出すファームウェアが本の執筆当時とは変わっているっぽい
# riscv-gnu-toolchainとQEMUをソースコードからビルドして対処
# 参考：https://zenn.dev/mikiken/scraps/483401c1bef8a1


# riscv-gnu-toolchainのビルド
# sudo apt install -y \
#   autoconf automake autotools-dev curl python3 python-is-python3 \
#   libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex \
#   texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
#   pkg-config git
# git clone --depth=1 https://github.com/riscv-collab/riscv-gnu-toolchain.git
# cd riscv-gnu-toolchain/
# ./configure --prefix=/opt/riscv32 --with-arch=rv32i --with-abi=ilp32
# sudo make


# QEMUのビルド
# sudo apt install -y \
#   build-essential pkg-config \
#   git ninja-build python3-pip \
#   libglib2.0-dev libpixman-1-dev libslirp-dev libfdt-dev
# wget https://download.qemu.org/qemu-8.0.3.tar.xz
# tar -xf qemu-8.0.3.tar.xz
# mkdir build
# cd build
# sudo ./configure --target-list=riscv32-softmmu --prefix=/opt/qemu-system-riscv32/
# sudo make -j $(nproc)
# sudo make install
# export PATH="$PATH:/opt/qemu-system-riscv32/bin"
# source ~/.bashrc