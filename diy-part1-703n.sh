  
#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
cat>target/linux/ath79/image/generic-tp-link.mk<<EOF
define Device/tplink_tl-wr703n
  $(Device/tplink-16mlzma)
  SOC := ar9331
  DEVICE_MODEL := TL-WR703N
  DEVICE_PACKAGES := kmod-usb-chipidea2
  TPLINK_HWID := 0x07030101
  SUPPORTED_DEVICES += tl-wr703n
endef
TARGET_DEVICES += tplink_tl-wr703n
EOF
sed -i 's/0x3d0000/0xfd0000/' target/linux/ath79/dts/ar9331_tplink_tl-wr703n_tl-mr10u.dtsi
sed -i 's/0x3f0000/0xff0000/' target/linux/ath79/dts/ar9331_tplink_tl-wr703n_tl-mr10u.dtsi
