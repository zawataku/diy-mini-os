#! /bin/bash
set -xue

QEMU=qemu-system-riscv32

$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot

# qemu-system-riscv32 -machine virt -bios default -nographic -serial mon:stdio --no-rebootだとエラーが出る
# QEMUが-bios defaultで呼び出すファームウェアが本の執筆当時とは変わっているっぽい
# riscv-gnu-toolchainとQEMUをソースコードからビルドして対処
# 参考：https://zenn.dev/mikiken/scraps/483401c1bef8a1

# sudo apt install -y \
#   autoconf automake autotools-dev curl python3 python-is-python3 \
#   libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex \
#   texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
#   pkg-config git