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
    fake_encryptor.cc \
    firewalld_firewall.cc \
    log_manager.cc \
    main.cc \
    protocol_handler.cc \
    request.cc \
    server.cc \
    temp_file_manager.cc \
    utils.cc \

LOCAL_INIT_RC := init.webservd.rc

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
