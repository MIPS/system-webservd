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
LOCAL_SHARED_LIBRARIES := \
    libcrypto \
    libfirewalld-client \
    libwebserv \
    libwebserv-proxies-internal \

LOCAL_SRC_FILES := \
    config.cc \
    dbus_bindings/dbus-service-config.json \
    dbus_bindings/org.chromium.WebServer.ProtocolHandler.dbus-xml \
    dbus_bindings/org.chromium.WebServer.Server.dbus-xml \
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

# libwebservd-client-internal shared library
# ========================================================
# You do not want to depend on this.  Depend on libwebserv instead.
# libwebserv abstracts and helps you consume this interface.

include $(CLEAR_VARS)
LOCAL_MODULE := libwebservd-client-internal
LOCAL_SRC_FILES := \
    dbus_bindings/dbus-service-config.json \
    dbus_bindings/org.chromium.WebServer.ProtocolHandler.dbus-xml \
    dbus_bindings/org.chromium.WebServer.Server.dbus-xml \

LOCAL_DBUS_PROXY_PREFIX := webservd
include $(BUILD_SHARED_LIBRARY)


# init.webservd.rc script
# ========================================================

# TODO: Switch back to the template once webservd doesn't need to run as root in
# order to bind to port 80.
ifdef INITRC_TEMPLATE
include $(CLEAR_VARS)

LOCAL_MODULE := init.webservd.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_INITRCD)
LOCAL_SRC_FILES := init.webservd.rc
include $(BUILD_PREBUILT)
endif
