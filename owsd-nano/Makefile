include $(TOPDIR)/rules.mk

PKG_NAME:=owsd-nano
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Martin Tippmann <martin.tippmann@gmail.com>
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/owsd-nano
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libwebsockets +ubus +ubox +libjson-c
  TITLE:=owsd-nano websocket ubus bridge
endef

define Package/owsd-nano/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/owsd $(1)/usr/bin/owsd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/owsd.init $(1)/etc/init.d/owsd-nano
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/owsd.config $(1)/etc/config/owsd
endef

define Package/owsd-nano/conffiles
/etc/config/owsd
endef

define Package/owsd-nano/description
Minimal websocket ubus bridge for OpenWrt
endef

$(eval $(call BuildPackage,owsd-nano))
