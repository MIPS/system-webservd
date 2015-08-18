#
# Copyright 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(my-dir)

# TODO: Refactor to build and run unit tests.

# webservd executable
# ========================================================

include $(CLEAR_VARS)
LOCAL_MODULE := webservd
LOCAL_REQUIRED_MODULES := init.webservd.rc
# TODO: Add firewalld-client once code generation is working.
LOCAL_SHARED_LIBRARIES := \
    libcrypto \
    libwebserv \

# TODO: Add the following once code generation is working:
# dbus_bindings/dbus-service-config.json
# dbus_bindings/org.chromium.WebServer.ProtocolHandler.dbus.xml
# dbus_bindings/org.chromium.WebServer.Server.dbus.xml
LOCAL_SRC_FILES := \
    config.cc \
    dbus_protocol_handler.cc \
    dbus_request_handler.cc \
    error_codes.cc \
    firewalld_firewall.cc \
    log_manager.cc \
    main.cc \
    protocol_handler.cc \
    request.cc \
    server.cc \
    utils.cc \

$(eval $(webservd_common))
include $(BUILD_EXECUTABLE)

# init.webservd.rc script
# ========================================================

ifdef INITRC_TEMPLATE
include $(CLEAR_VARS)

LOCAL_MODULE := init.webservd.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_INITRCD)

include $(BUILD_SYSTEM)/base_rules.mk
my_args := --noipv6
my_groups := inet
.PHONY: $(LOCAL_BUILT_MODULE)
$(LOCAL_BUILT_MODULE): $(INITRC_TEMPLATE)
	$(call generate-initrc-file,webservd,$(my_args),$(my_groups))
endif
