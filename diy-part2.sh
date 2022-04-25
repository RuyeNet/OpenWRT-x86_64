#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.99.2/g' package/base-files/files/bin/config_generate
sed -i 's/UTC/UTC\-8/g' package/base-files/files/bin/config_generate

# Modify default DNS
sed -i '/network.$1.netmask'/a"\\ \t\ \t\ \t\ \tset network.\$1.dns='127.0.0.1 223.5.5.5 8.8.8.8'"  package/base-files/files/bin/config_generate

# WIFI ON
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default theme
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile

# luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git  package/diy/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/diy/luci-app-argon-config

# openclash
#wget -P package/diy/openclash -c https://github.com/vernesong/OpenClash/archive/refs/heads/master.zip
#unzip -o package/diy/openclash/master.zip  -d package/diy/openclash/

# luci-app-aliddns
#git clone https://github.com/chenhw2/luci-app-aliddns.git  package/diy/luci-app-aliddns

#openwrt-v2ray
git clone https://github.com/kuoruan/openwrt-v2ray.git package/diy/openwrt-v2ray
git clone https://github.com/kuoruan/openwrt-upx.git package/diy/openwrt-upx

#luci-app-v2ray
git clone -b luci2 https://github.com/kuoruan/luci-app-v2ray.git package/diy/luci-app-v2ray


git clone https://github.com/kenzok8/openwrt-packages package/diy/kenzok8/openwrt-packages
git clone https://github.com/kenzok8/small package/diy/kenzok8/small

# 编译 po2lmo
#pushd package/diy/openclash/OpenClash-master/luci-app-openclash/tools/po2lmo
#make && sudo make install
#popd
# cd $GITHUB_WORKSPACE/openwrt

# openwrt-r8168
git clone https://github.com/RuyeNet/openwrt-r8168 package/diy/openwrt-r8168

# fix golang
#rm -rf feeds/packages/lang/golang/
#git clone https://github.com/RuyeNet/openwrt-golang feeds/packages/lang/golang
mkdir temp
mv feeds/packages/lang/golang/ temp/
git clone https://github.com/openwrt/packages.git temp/packages
cd temp/packages/
git reset --hard 9704e900
cd $GITHUB_WORKSPACE/openwrt
cp -r temp/packages/lang/golang/ feeds/packages/lang/golang

# passwall
#git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/diy/passwall/luci
#git clone -b packages https://github.com/xiaorouji/openwrt-passwall.git package/diy/passwall/packages