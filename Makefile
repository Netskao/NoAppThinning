INSTALL_TARGET_PROCESSES = AppStore TestFlight
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:11.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoAppThinning

NoAppThinning_LDFLAGS = -Wl,-segalign,4000
NoAppThinning_FILES = Tweak.xm
NoAppThinning_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/tweak.mk
