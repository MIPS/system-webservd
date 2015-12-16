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

# libwebserv shared library
# ========================================================

include $(CLEAR_VARS)
LOCAL_MODULE := libwebserv
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/..
LOCAL_SHARED_LIBRARIES := libwebservd-client-internal
LOCAL_SRC_FILES := \
    dbus_bindings/org.chromium.WebServer.RequestHandler.dbus-xml \
    dbus_protocol_handler.cc \
    dbus_server.cc \
    protocol_handler.cc \
    request.cc \
    request_handler_callback.cc \
    request_utils.cc \
    response.cc \
    server.cc \

$(eval $(webservd_common))
include $(BUILD_SHARED_LIBRARY)

# libwebserv-proxies-internal shared library
# ========================================================
# You do not want to depend on this.  Depend on libwebserv instead.
# libwebserv abstracts and helps you consume this interface.

include $(CLEAR_VARS)
LOCAL_MODULE := libwebserv-proxies-internal
LOCAL_SRC_FILES := \
    dbus_bindings/org.chromium.WebServer.RequestHandler.dbus-xml \

LOCAL_DBUS_PROXY_PREFIX := libwebserv
include $(BUILD_SHARED_LIBRARY)
