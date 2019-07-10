Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FDE64866
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGJOb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 10:31:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47976 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727154AbfGJOb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 10:31:57 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Jul 2019 17:31:51 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x6AEVpIk004077;
        Wed, 10 Jul 2019 17:31:51 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 2/4] build: Remove warning-causing compilation flag from pyverbs
Date:   Wed, 10 Jul 2019 17:22:49 +0300
Message-Id: <20190710142251.9396-3-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710142251.9396-1-noaos@mellanox.com>
References: <20190710142251.9396-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The -fvar-tracking-assignment flag is causing the following
compilation warning:

note: variable tracking size limit exceeded with '-fvar-tracking-assignments', retrying without

Since it's a debug flag and not necessary for pyverbs functionality,
remove it from pyverbs' build.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewd-by: Leon Romanovsky <leonro@mellanox.com>
---
 CMakeLists.txt                   | 7 +++++++
 buildlib/pyverbs_functions.cmake | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8d2e357c78af..f2cb5c306c04 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -182,6 +182,13 @@ endif()
 
 #-------------------------
 # Setup the basic C compiler
+# Some compilation flags are not supported in clang, lets allow users to know
+# whether gcc or clang is used.
+if ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
+  set(IS_CLANG_BUILD TRUE)
+else()
+  set(IS_CLANG_BUILD FALSE)
+endif()
 RDMA_BuildType()
 include_directories(${BUILD_INCLUDE})
 
diff --git a/buildlib/pyverbs_functions.cmake b/buildlib/pyverbs_functions.cmake
index 1966cf3ba1a3..81cdd86fc020 100644
--- a/buildlib/pyverbs_functions.cmake
+++ b/buildlib/pyverbs_functions.cmake
@@ -16,8 +16,13 @@ function(rdma_cython_module PY_MODULE)
 
     string(REGEX REPLACE "\\.so$" "" SONAME "${FILENAME}${CMAKE_PYTHON_SO_SUFFIX}")
     add_library(${SONAME} SHARED ${CFILE})
+    # We need to disable -fvar-tracking-assignments. It's only supported in gcc
+    # so make sure we're not using clang before doing that.
+    if (NOT ${IS_CLANG_BUILD})
+      set(PYVERBS_DEBUG_FLAGS "-fno-var-tracking-assignments")
+    endif()
     set_target_properties(${SONAME} PROPERTIES
-	    COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-strict-aliasing -Wno-unused-function -Wno-redundant-decls -Wno-shadow -Wno-cast-function-type -Wno-implicit-fallthrough -Wno-unknown-warning -Wno-unknown-warning-option"
+        COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-strict-aliasing -Wno-unused-function -Wno-redundant-decls -Wno-shadow -Wno-cast-function-type -Wno-implicit-fallthrough -Wno-unknown-warning -Wno-unknown-warning-option ${PYVERBS_DEBUG_FLAGS}"
       LIBRARY_OUTPUT_DIRECTORY "${BUILD_PYTHON}/${PY_MODULE}"
       PREFIX "")
     target_link_libraries(${SONAME} LINK_PRIVATE ${PYTHON_LIBRARIES} ibverbs)
-- 
2.21.0

