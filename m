Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA814F14
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfEFPHo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:44 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50073 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727092AbfEFPHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:42 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:40 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edY019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 02/11] pyverbs: Add unittests for address handle creation
Date:   Mon,  6 May 2019 18:07:29 +0300
Message-Id: <20190506150738.19477-3-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Check AH creation and destruction API.
Also verify that AH can't be created without a GRH on RoCE (the test
simply returns if link layer is Infiniband).

This patch also removes the redundant rdma_python_test function from
buildlib. rdma_python_module can be used instead.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 buildlib/pyverbs_functions.cmake |  9 ----
 pyverbs/CMakeLists.txt           |  3 +-
 pyverbs/tests/addr.py            | 72 ++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 10 deletions(-)
 create mode 100644 pyverbs/tests/addr.py

diff --git a/buildlib/pyverbs_functions.cmake b/buildlib/pyverbs_functions.cmake
index bd8e2028f9d5..1966cf3ba1a3 100644
--- a/buildlib/pyverbs_functions.cmake
+++ b/buildlib/pyverbs_functions.cmake
@@ -35,15 +35,6 @@ function(rdma_python_module PY_MODULE)
   endforeach()
 endfunction()
 
-function(rdma_python_test PY_MODULE)
-  foreach(PY_FILE ${ARGN})
-    get_filename_component(LINK "${CMAKE_CURRENT_SOURCE_DIR}/${PY_FILE}" ABSOLUTE)
-    rdma_create_symlink("${LINK}" "${BUILD_PYTHON}/${PY_MODULE}/${PY_FILE}")
-    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/${PY_FILE}
-      DESTINATION ${CMAKE_INSTALL_PYTHON_ARCH_LIB}/${PY_MODULE})
-  endforeach()
-endfunction()
-
 # Make a python script runnable from the build/bin directory with all the
 # correct paths filled in
 function(rdma_internal_binary)
diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index b30793dcbb8f..b7ec880ecd29 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -18,8 +18,9 @@ rdma_python_module(pyverbs
   utils.py
   )
 
-rdma_python_test(pyverbs/tests
+rdma_python_module(pyverbs/tests
   tests/__init__.py
+  tests/addr.py
   tests/base.py
   tests/cq.py
   tests/device.py
diff --git a/pyverbs/tests/addr.py b/pyverbs/tests/addr.py
new file mode 100644
index 000000000000..1326eec0d0f6
--- /dev/null
+++ b/pyverbs/tests/addr.py
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.  See COPYING file
+
+from pyverbs.addr import GlobalRoute, AHAttr, AH
+from pyverbs.pyverbs_error import PyverbsError
+from pyverbs.tests.base import PyverbsTestCase
+import pyverbs.device as d
+import pyverbs.enums as e
+from pyverbs.pd import PD
+from pyverbs.cq import WC
+
+class AHTest(PyverbsTestCase):
+    """
+    Test various functionalities of the AH class.
+    """
+    def test_create_ah(self):
+        """
+        Test ibv_create_ah.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            pd = PD(ctx)
+            for port_num in range(1, 1 + attr.phys_port_cnt):
+                gr = get_global_route(ctx, port_num=port_num)
+                ah_attr = AHAttr(gr=gr, is_global=1, port_num=port_num)
+                with AH(pd, attr=ah_attr):
+                    pass
+    # TODO: Test ibv_create_ah_from_wc once we have traffic
+
+    def test_create_ah_roce(self):
+        """
+        Verify that AH can't be created without GRH in RoCE
+        """
+        for ctx, attr, attr_ex in self.devices:
+            pd = PD(ctx)
+            for port_num in range(1, 1 + attr.phys_port_cnt):
+                port_attr = ctx.query_port(port_num)
+                if port_attr.link_layer == e.IBV_LINK_LAYER_INFINIBAND:
+                    return
+                ah_attr = AHAttr(is_global=0, port_num=port_num)
+                try:
+                    ah = AH(pd, attr=ah_attr)
+                except PyverbsError as err:
+                    assert 'Failed to create AH' in err.args[0]
+                else:
+                    raise PyverbsError('Created a non-global AH on RoCE')
+
+    def test_destroy_ah(self):
+        """
+        Test ibv_destroy_ah.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            pd = PD(ctx)
+            for port_num in range(1, 1 + attr.phys_port_cnt):
+                gr = get_global_route(ctx)
+                ah_attr = AHAttr(gr=gr, is_global=1, port_num=port_num)
+                with AH(pd, attr=ah_attr) as ah:
+                    ah.close()
+
+
+def get_global_route(ctx, gid_index=0, port_num=1):
+    """
+    Queries the provided Context's gid <gid_index> and creates a GlobalRoute
+    object with sgid_index <gid_index> and the queried GID as dgid.
+    :param ctx: Context object to query
+    :param gid_index: GID index to query and use. Default: 0, as it's always
+                      valid
+    :param port_num: Number of the port to query. Default: 1
+    :return: GlobalRoute object
+    """
+    gid = ctx.query_gid(port_num, gid_index)
+    gr = GlobalRoute(dgid=gid, sgid_index=gid_index)
+    return gr
-- 
2.17.2

