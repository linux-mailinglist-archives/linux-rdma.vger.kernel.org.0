Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE2214B26
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgGEIUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33123 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbgGEIUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:12 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:06 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K6W9001735;
        Sun, 5 Jul 2020 11:20:06 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5qK009336;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5D0009335;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH V1 rdma-core 13/13] tests: Add a shared PD Pyverbs test
Date:   Sun,  5 Jul 2020 11:19:49 +0300
Message-Id: <1593937189-8744-14-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

The test creates a client and server sides of RC resources.  Then the
server resources are imported and used for RDMA write traffic.

Reviewed-by: Ido Kalir <idok@mellanox.com>
Signed-off-by: Edward Srouji <edwards@mellanox.com>
---
 tests/CMakeLists.txt    |  1 +
 tests/base.py           | 11 ++++--
 tests/test_shared_pd.py | 95 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_shared_pd.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 1708fb9..33ffc78 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -25,6 +25,7 @@ rdma_python_test(tests
   test_qpex.py
   test_rdmacm.py
   test_relaxed_ordering.py
+  test_shared_pd.py
   utils.py
   )
 
diff --git a/tests/base.py b/tests/base.py
index 2824ca2..4311362 100755
--- a/tests/base.py
+++ b/tests/base.py
@@ -247,10 +247,17 @@ class BaseResources(object):
         :param ib_port: IB port of the device to use (default: 1)
         :param gid_index: Which GID index to use (default: 0)
         """
-        self.ctx = Context(name=dev_name)
+        self.dev_name = dev_name
         self.gid_index = gid_index
-        self.pd = PD(self.ctx)
         self.ib_port = ib_port
+        self.create_context()
+        self.create_pd()
+
+    def create_context(self):
+        self.ctx = Context(name=self.dev_name)
+
+    def create_pd(self):
+        self.pd = PD(self.ctx)
 
 
 class TrafficResources(BaseResources):
diff --git a/tests/test_shared_pd.py b/tests/test_shared_pd.py
new file mode 100644
index 0000000..e533074
--- /dev/null
+++ b/tests/test_shared_pd.py
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2020 Mellanox Technologies, Inc. All rights reserved. See COPYING file
+"""
+Test module for Shared PD.
+"""
+import unittest
+import errno
+import os
+
+from tests.test_qpex import QpExRCRDMAWrite
+from tests.base import RDMATestCase
+from pyverbs.device import Context
+from pyverbs.pd import PD
+from pyverbs.mr import MR
+import pyverbs.enums as e
+import tests.utils as u
+
+
+def get_import_res_class(base_class):
+    """
+    This function creates a class that inherits base_class of any BaseResources
+    type. Its purpose is to behave exactly as base_class does, except for the
+    objects creation, which instead of creating context, PD and MR, it imports
+    them. Hence the returned class must be initialized with (cmd_fd, pd_handle,
+    mr_handle, mr_addr, **kwargs), while kwargs are the arguments needed
+    (if any) for base_class. In addition it has unimport_resources() method
+    which unimprot all the resources and closes the imported PD object.
+    :param base_class: The base resources class to inherit from
+    :return: ImportResources(cmd_fd, pd_handle, mr_handle, mr_addr, **kwargs)
+             class
+    """
+    class ImportResources(base_class):
+        def __init__(self, cmd_fd, pd_handle, mr_handle, mr_addr=None, **kwargs):
+            self.cmd_fd = cmd_fd
+            self.pd_handle = pd_handle
+            self.mr_handle = mr_handle
+            self.mr_addr = mr_addr
+            super(ImportResources, self).__init__(**kwargs)
+
+        def create_context(self):
+            try:
+                self.ctx = Context(cmd_fd=self.cmd_fd)
+            except u.PyverbsRDMAError as ex:
+                if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                    raise unittest.SkipTest('Importing a device is not supported')
+                raise ex
+
+        def create_pd(self):
+            self.pd = PD(self.ctx, handle=self.pd_handle)
+
+        def create_mr(self):
+            self.mr = MR(self.pd, handle=self.mr_handle, address=self.mr_addr)
+
+        def unimport_resources(self):
+            self.mr.unimport()
+            self.pd.unimport()
+            self.pd.close()
+
+    return ImportResources
+
+
+class SharedPDTestCase(RDMATestCase):
+    def setUp(self):
+        super().setUp()
+        self.iters = 10
+        self.server_res = None
+        self.imported_res = []
+
+    def tearDown(self):
+        for res in self.imported_res:
+            res.unimport_resources()
+        super().tearDown()
+
+    def test_imported_rc_ex_rdma_write(self):
+        setup_params = {'dev_name': self.dev_name, 'ib_port': self.ib_port,
+                        'gid_index': self.gid_index}
+        self.server_res = QpExRCRDMAWrite(**setup_params)
+        cmd_fd_dup = os.dup(self.server_res.ctx.cmd_fd)
+        import_cls = get_import_res_class(QpExRCRDMAWrite)
+        server_import = import_cls(
+            cmd_fd_dup, self.server_res.pd.handle, self.server_res.mr.handle,
+            # The imported MR's address is NULL, so using the address of the
+            # "main" MR object to be able to validate the message
+            self.server_res.mr.buf,
+            **setup_params)
+        self.imported_res.append(server_import)
+        client = QpExRCRDMAWrite(**setup_params)
+        client.pre_run(server_import.psn, server_import.qpn)
+        server_import.pre_run(client.psn, client.qpn)
+        client.rkey = server_import.mr.rkey
+        server_import.rkey = client.mr.rkey
+        client.raddr = server_import.mr.buf
+        server_import.raddr = client.mr.buf
+        u.rdma_traffic(client, server_import, self.iters, self.gid_index,
+                       self.ib_port, send_op=e.IBV_QP_EX_WITH_RDMA_WRITE)
-- 
1.8.3.1

