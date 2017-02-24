#!/bin/bash

export ARCH=arm64

export PATH=/home/devries/tools/aarch64-linux-android-4.9-kernel/bin:$PATH

export CROSS_COMPILE=aarch64-linux-android-

make onyxia_defconfig

make -j8

mkbootfs ramdisk | gzip > ramdisk.cpio.gz

mkbootimg \
      --kernel arch/arm64/boot/Image.gz-dtb \
      --ramdisk ramdisk.cpio.gz \
      --cmdline "androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 cma=16M@0-0xffffffff coherent_pool=2M enforcing=0" \
      --base 0x80000000 \
      --pagesize 4096 \
      --ramdisk_offset 0x02200000 \
      --tags_offset 0x02000000 \
      --output boot.img
