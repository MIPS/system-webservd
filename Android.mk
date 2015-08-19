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

ifeq ($(HOST_OS),linux)

webservd_root := $(my-dir)

# Definitions applying to all targets. $(eval) this last.
define webservd_common
  LOCAL_CPP_EXTENSION := .cc
  LOCAL_RTTI_FLAG := -frtti
  LOCAL_CFLAGS += \
    -Wno-missing-field-initializers \
    -Wno-unused-parameter \

  # libchromeos's secure_blob.h calls "using Blob::vector" to expose its base
  # class's constructors. This causes a "conflicts with version inherited from
  # 'std::__1::vector<unsigned char>'" error when building with GCC.
  LOCAL_CLANG := true

  LOCAL_C_INCLUDES += \
    $(webservd_root) \
    external/gtest/include \

  LOCAL_SHARED_LIBRARIES += \
      libchrome \
      libchrome-dbus \
      libchromeos \
      libchromeos-dbus \
      libchromeos-http \
      libdbus \
      libmicrohttpd \

endef

include $(call all-subdir-makefiles)

endif # HOST_OS == linux
