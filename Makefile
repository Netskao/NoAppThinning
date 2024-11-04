INSTALL_TARGET_PROCESSES = AppStore TestFlight
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoAppThinning
$(TWEAK_NAME)_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
