# SPDX-License-Identifier: GPL-2.0-or-later
#
# owsd-nano - Minimal websocket ubus bridge for OpenWrt
#
# Forked from owsd
# Upstream: https://dev.iopsys.eu/iopsys/owsd
# Minimal version and OpenWrt packaging: Farokh Panahirad <raad.farokh@gmail.com>

include $(TOPDIR)/rules.mk

PKG_NAME:=owsd-nano
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Farokh Panahirad <raad.farokh@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/owsd-nano
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Minimal websocket ubus bridge (nano fork)
  DEPENDS:=+libwebsockets +ubus +ubox +libjson-c
  URL:=https://dev.iopsys.eu/iopsys/owsd
endef

define Package/owsd-nano/description
A minimal websocket ubus bridge for OpenWrt.
Forked from owsd [https://dev.iopsys.eu/iopsys/owsd], with features stripped for size.
endef

define Package/owsd-nano/conffiles
/etc/config/owsd
endef

define Package/owsd-nano/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/owsd-nano $(1)/usr/bin/owsd-nano

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/owsd.init $(1)/etc/init.d/owsd-nano

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/owsd.config $(1)/etc/config/owsd
endef

$(eval $(call BuildPackage,owsd-nano))
