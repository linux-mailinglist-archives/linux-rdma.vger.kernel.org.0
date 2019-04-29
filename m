Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4487E72F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfD2QB7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 12:01:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48564 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728506AbfD2QB7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 12:01:59 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 29 Apr 2019 18:55:15 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3TFtF7o025539;
        Mon, 29 Apr 2019 18:55:15 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 3/4] pyverbs/tests: Improvements
Date:   Mon, 29 Apr 2019 18:55:12 +0300
Message-Id: <20190429155513.30543-4-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429155513.30543-1-noaos@mellanox.com>
References: <20190429155513.30543-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- Use a common TestCase class to avoid code duplication (iterating
  over all existing devices, opening them and querying them).
- Capability checks: Check device capabilities before using flags
  in CQ or MR creation.
- replace random.randint() with random.random() due to significant
  performance differrences.
- Improve coverage:
  - Some test use random values e.g. for CQ properties. Run such
    tests in a loop to cover more values.
  - Modify get_access_flags to return all legal combination of create
    flags. The calling tests will iterate over all of them.
- Use constant data when writing to MR. Random data takes longer to
  generate. There's no benefit in using it, so change the tests to
  use constant data instead.

Change-Id: I57edc980edcfeb4331d234be428c7e27a85f4138
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt  |   1 +
 pyverbs/tests/base.py   |  23 ++++
 pyverbs/tests/cq.py     | 168 +++++++++++--------------
 pyverbs/tests/device.py | 235 ++++++++++++++++-------------------
 pyverbs/tests/mr.py     | 265 +++++++++++++++++++---------------------
 pyverbs/tests/pd.py     |  58 ++++-----
 pyverbs/tests/utils.py  |  69 ++++++++---
 7 files changed, 402 insertions(+), 417 deletions(-)
 create mode 100644 pyverbs/tests/base.py

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index d83f77317ecb..65cd578cdff4 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -19,6 +19,7 @@ rdma_python_module(pyverbs
 
 rdma_python_test(pyverbs/tests
   tests/__init__.py
+  tests/base.py
   tests/cq.py
   tests/device.py
   tests/mr.py
diff --git a/pyverbs/tests/base.py b/pyverbs/tests/base.py
new file mode 100644
index 000000000000..9541e61b0d55
--- /dev/null
+++ b/pyverbs/tests/base.py
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc . All rights reserved. See COPYING file
+
+import unittest
+
+import pyverbs.device as d
+
+class PyverbsTestCase(unittest.TestCase):
+    def setUp(self):
+        """
+        Opens the devices and queries them
+        """
+        lst = d.get_device_list()
+        self.devices = []
+        for dev in lst:
+            c = d.Context(name=dev.name.decode())
+            attr = c.query_device()
+            attr_ex = c.query_device_ex()
+            self.devices.append((c, attr, attr_ex))
+
+    def tearDown(self):
+        for tup in self.devices:
+            tup[0].close()
diff --git a/pyverbs/tests/cq.py b/pyverbs/tests/cq.py
index 4c1cea2b5296..38f145f865ba 100644
--- a/pyverbs/tests/cq.py
+++ b/pyverbs/tests/cq.py
@@ -1,32 +1,29 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
-# Copyright (c) 2019, Mellanox Technologies. All rights reserved.  See COPYING file
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
 """
 Test module for pyverbs' cq module.
 """
-import unittest
 import random
 
 from pyverbs.cq import CompChannel, CQ, CqInitAttrEx, CQEX
 from pyverbs.pyverbs_error import PyverbsError
-import pyverbs.device as d
+from pyverbs.tests.base import PyverbsTestCase
+import pyverbs.tests.utils as u
 import pyverbs.enums as e
 
 
-class CQTest(unittest.TestCase):
+class CQTest(PyverbsTestCase):
     """
     Test various functionalities of the CQ class.
     """
-
-    @staticmethod
-    def test_create_cq():
+    def test_create_cq(self):
         """
         Test ibv_create_cq()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                cqes = get_num_cqes(ctx)
-                comp_vector = random.randint(0, ctx.num_comp_vectors - 1)
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(10):
+                cqes = get_num_cqes(attr)
+                comp_vector = int(ctx.num_comp_vectors * random.random())
                 if random.choice([True, False]):
                     with CompChannel(ctx) as cc:
                         with CQ(ctx, cqes, None, cc, comp_vector):
@@ -35,24 +32,22 @@ class CQTest(unittest.TestCase):
                     with CQ(ctx, cqes, None, None, comp_vector):
                         pass
 
-    @staticmethod
-    def test_create_cq_bad_flow():
+    def test_create_cq_bad_flow(self):
         """
         Test ibv_create_cq() with a wrong comp_vector / cqe number
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                cqes = get_num_cqes(ctx)
-                comp_vector = random.randint(ctx.num_comp_vectors, 100)
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(10):
+                cc = CompChannel(ctx)
+                cqes = 100
+                comp_vector = ctx.num_comp_vectors + int(100 *
+                                                         random.random())
+                has_cc = random.choice([True, False])
+                if not has_cc:
+                    cc = None
                 try:
-                    if random.choice([True, False]):
-                        with CompChannel(ctx) as cc:
-                            with CQ(ctx, cqes, None, cc, comp_vector):
-                                pass
-                    else:
-                        with CQ(ctx, cqes, None, None, comp_vector):
-                            pass
+                    with CQ(ctx, cqes, None, cc, comp_vector):
+                        pass
                 except PyverbsError as e:
                     assert 'Failed to create a CQ' in e.args[0]
                     assert 'Invalid argument' in e.args[0]
@@ -63,13 +58,8 @@ class CQTest(unittest.TestCase):
                 max_cqe = ctx.query_device().max_cqe
                 cqes = random.randint(max_cqe + 1, max_cqe + 100)
                 try:
-                    if random.choice([True, False]):
-                        with CompChannel(ctx) as cc:
-                            with CQ(ctx, cqes, None, cc, 0):
-                                pass
-                    else:
-                        with CQ(ctx, cqes, None, None, 0):
-                            pass
+                    with CQ(ctx, cqes, None, cc, 0):
+                        pass
                 except PyverbsError as err:
                     assert 'Failed to create a CQ' in err.args[0]
                     assert 'Invalid argument' in err.args[0]
@@ -78,16 +68,14 @@ class CQTest(unittest.TestCase):
                         'Created a CQ with cqe={n} while device\'s max_cqe={nc}'.
                         format(n=cqes, nc=max_cqe))
 
-    @staticmethod
-    def test_destroy_cq():
+    def test_destroy_cq(self):
         """
         Test ibv_destroy_cq()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                cqes = get_num_cqes(ctx)
-                comp_vector = random.randint(0, ctx.num_comp_vectors - 1)
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(10):
+                cqes = get_num_cqes(attr)
+                comp_vector = int(ctx.num_comp_vectors * random.random())
                 if random.choice([True, False]):
                     with CompChannel(ctx) as cc:
                         cq = CQ(ctx, cqes, None, cc, comp_vector)
@@ -96,75 +84,63 @@ class CQTest(unittest.TestCase):
                 cq.close()
 
 
-class CCTest(unittest.TestCase):
+class CCTest(PyverbsTestCase):
     """
     Test various functionalities of the Completion Channel class.
     """
-
-    @staticmethod
-    def test_create_comp_channel():
+    def test_create_comp_channel(self):
         """
         Test ibv_create_comp_channel()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with CompChannel(ctx):
-                    pass
+        for ctx, attr, attr_ex in self.devices:
+            with CompChannel(ctx):
+                pass
 
-    @staticmethod
-    def test_destroy_comp_channel():
+    def test_destroy_comp_channel(self):
         """
         Test ibv_destroy_comp_channel()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                cc = CompChannel(ctx)
-                cc.close()
+        for ctx, attr, attr_ex in self.devices:
+            cc = CompChannel(ctx)
+            cc.close()
 
 
-class CQEXTest(unittest.TestCase):
+class CQEXTest(PyverbsTestCase):
     """
     Test various functionalities of the CQEX class.
     """
-
-    @staticmethod
-    def test_create_cq_ex():
+    def test_create_cq_ex(self):
         """
         Test ibv_create_cq_ex()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with CQEX(ctx, get_attrs_ex(ctx)):
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(10):
+                with CQEX(ctx, get_attrs_ex(attr, attr_ex)):
                     pass
 
-    @staticmethod
-    def test_create_cq_ex_bad_flow():
+    def test_create_cq_ex_bad_flow(self):
         """
         Test ibv_create_cq_ex() with wrong comp_vector / number of cqes
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attrs_ex = get_attrs_ex(ctx)
-                max_cqe = ctx.query_device().max_cqe
-                attrs_ex.cqe = max_cqe + random.randint(1, 100)
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(10):
+                cq_attrs_ex = get_attrs_ex(attr, attr_ex)
+                max_cqe = attr.max_cqe
+                cq_attrs_ex.cqe = max_cqe + 1 + int(100 * random.random())
                 try:
-                    CQEX(ctx, attrs_ex)
+                    CQEX(ctx, cq_attrs_ex)
                 except PyverbsError as e:
                     assert 'Failed to create extended CQ' in e.args[0]
                     assert ' Errno: 22' in e.args[0]
                 else:
                     raise PyverbsError(
                         'Created a CQEX with {c} CQEs while device\'s max CQE={dc}'.
-                        format(c=attrs_ex.cqe, dc=max_cqe))
+                        format(c=cq_attrs_ex.cqe, dc=max_cqe))
                 comp_channel = random.randint(ctx.num_comp_vectors, 100)
-                attrs_ex.comp_vector = comp_channel
-                attrs_ex.cqe = get_num_cqes(ctx)
+                cq_attrs_ex.comp_vector = comp_channel
+                cq_attrs_ex.cqe = get_num_cqes(attr)
                 try:
-                    CQEX(ctx, attrs_ex)
+                    CQEX(ctx, cq_attrs_ex)
                 except PyverbsError as e:
                     assert 'Failed to create extended CQ' in e.args[0]
                     assert ' Errno: 22' in e.args[0]
@@ -173,36 +149,38 @@ class CQEXTest(unittest.TestCase):
                         'Created a CQEX with comp_vector={c} while device\'s num_comp_vectors={dc}'.
                         format(c=comp_channel, dc=ctx.num_comp_vectors))
 
-    @staticmethod
-    def test_destroy_cq_ex():
+    def test_destroy_cq_ex(self):
         """
         Test ibv_destroy_cq() for extended CQs
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with CQEX(ctx, get_attrs_ex(ctx)) as cq:
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(10):
+                with CQEX(ctx, get_attrs_ex(attr, attr_ex)) as cq:
                     cq.close()
 
-
-def get_num_cqes(ctx):
-    attr = ctx.query_device()
+def get_num_cqes(attr):
     max_cqe = attr.max_cqe
-    return random.randint(0, max_cqe)
-
-
-def get_attrs_ex(ctx):
-    cqe = get_num_cqes(ctx)
-    sample = random.sample(list(e.ibv_create_cq_wc_flags),
-                           random.randint(0, 11))
+    return int((max_cqe + 1) * random.random())
+
+
+def get_attrs_ex(attr, attr_ex):
+    cqe = get_num_cqes(attr)
+    wc_flags = list(e.ibv_create_cq_wc_flags)
+    # Flow tag is not always supported, doesn't have a capability bit to check
+    wc_flags.remove(e.IBV_WC_EX_WITH_FLOW_TAG)
+    if attr_ex.tm_caps.max_ops == 0:
+        wc_flags.remove(e.IBV_WC_EX_WITH_TM_INFO)
+    if attr_ex.raw_packet_caps & e.IBV_RAW_PACKET_CAP_CVLAN_STRIPPING == 0:
+        wc_flags.remove(e.IBV_WC_EX_WITH_CVLAN)
+    sample = u.sample(wc_flags)
     wc_flags = 0
     for flag in sample:
         wc_flags |= flag
     comp_mask = random.choice([0, e.IBV_CQ_INIT_ATTR_MASK_FLAGS])
     flags = 0
     if comp_mask is not 0:
-        sample = random.sample(list(e.ibv_create_cq_attr_flags),
-                               random.randint(0, 2))
+        attr_flags = list(e.ibv_create_cq_attr_flags)
+        sample = u.sample(attr_flags)
         for flag in sample:
             flags |= flag
     return CqInitAttrEx(cqe=cqe, wc_flags=wc_flags, comp_mask=comp_mask,
diff --git a/pyverbs/tests/device.py b/pyverbs/tests/device.py
index 4f96a11a3ccb..54ff438d12fa 100644
--- a/pyverbs/tests/device.py
+++ b/pyverbs/tests/device.py
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
-# Copyright (c) 2018, Mellanox Technologies. All rights reserved.  See COPYING file
+# Copyright (c) 2018 Mellanox Technologies, Inc. All rights reserved. See COPYING file
 """
 Test module for pyverbs' device module.
 """
@@ -8,6 +8,7 @@ import resource
 import random
 
 from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
+from pyverbs.tests.base import PyverbsTestCase
 import pyverbs.tests.utils as u
 import pyverbs.device as d
 
@@ -136,164 +137,136 @@ class DeviceTest(unittest.TestCase):
                         format(p=port))
 
 
-class DMTest(unittest.TestCase):
+class DMTest(PyverbsTestCase):
     """
     Test various functionalities of the DM class.
     """
 
-    @staticmethod
-    def test_create_dm():
+    def test_create_dm(self):
         """
         test ibv_alloc_dm()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
-                                          u.DM_ALIGNMENT)
-                dm_attrs = u.get_dm_attrs(dm_len)
-                with d.DM(ctx, dm_attrs):
-                    pass
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
+                                      u.DM_ALIGNMENT)
+            dm_attrs = u.get_dm_attrs(dm_len)
+            with d.DM(ctx, dm_attrs):
+                pass
 
-    @staticmethod
-    def test_destroy_dm():
+    def test_destroy_dm(self):
         """
         test ibv_free_dm()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
-                                          u.DM_ALIGNMENT)
-                dm_attrs = u.get_dm_attrs(dm_len)
-                dm = d.DM(ctx, dm_attrs)
-                dm.close()
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
+                                      u.DM_ALIGNMENT)
+            dm_attrs = u.get_dm_attrs(dm_len)
+            dm = d.DM(ctx, dm_attrs)
+            dm.close()
 
-    @staticmethod
-    def test_create_dm_bad_flow():
+    def test_create_dm_bad_flow(self):
         """
         test ibv_alloc_dm() with an illegal size and comp mask
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = attr.max_dm_size + 1
-                dm_attrs = u.get_dm_attrs(dm_len)
-                try:
-                    d.DM(ctx, dm_attrs)
-                except PyverbsRDMAError as e:
-                    assert 'Failed to allocate device memory of size' in \
-                           e.args[0]
-                    assert 'Max available size' in e.args[0]
-                else:
-                    raise PyverbsError(
-                        'Created a DM with size larger than max reported')
-                dm_attrs.comp_mask = random.randint(1, 100)
-                try:
-                    d.DM(ctx, dm_attrs)
-                except PyverbsRDMAError as e:
-                    assert 'Failed to allocate device memory of size' in \
-                           e.args[0]
-                else:
-                    raise PyverbsError(
-                        'Created a DM with illegal comp mask {c}'. \
-                        format(c=dm_attrs.comp_mask))
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = attr_ex.max_dm_size + 1
+            dm_attrs = u.get_dm_attrs(dm_len)
+            try:
+                d.DM(ctx, dm_attrs)
+            except PyverbsRDMAError as e:
+                assert 'Failed to allocate device memory of size' in \
+                       e.args[0]
+                assert 'Max available size' in e.args[0]
+            else:
+                raise PyverbsError(
+                    'Created a DM with size larger than max reported')
+            dm_attrs.comp_mask = random.randint(1, 100)
+            try:
+                d.DM(ctx, dm_attrs)
+            except PyverbsRDMAError as e:
+                assert 'Failed to allocate device memory of size' in \
+                       e.args[0]
+            else:
+                raise PyverbsError(
+                    'Created a DM with illegal comp mask {c}'. \
+                    format(c=dm_attrs.comp_mask))
 
-    @staticmethod
-    def test_destroy_dm_bad_flow():
+    def test_destroy_dm_bad_flow(self):
         """
         test calling ibv_free_dm() twice
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
-                                          u.DM_ALIGNMENT)
-                dm_attrs = u.get_dm_attrs(dm_len)
-                dm = d.DM(ctx, dm_attrs)
-                dm.close()
-                dm.close()
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
+                                      u.DM_ALIGNMENT)
+            dm_attrs = u.get_dm_attrs(dm_len)
+            dm = d.DM(ctx, dm_attrs)
+            dm.close()
+            dm.close()
 
-    @staticmethod
-    def test_dm_write():
+    def test_dm_write(self):
         """
         Test writing to the device memory
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
-                                          u.DM_ALIGNMENT)
-                dm_attrs = u.get_dm_attrs(dm_len)
-                with d.DM(ctx, dm_attrs) as dm:
-                    data_length = random.randrange(4, dm_len, u.DM_ALIGNMENT)
-                    data_offset = random.randrange(0, dm_len - data_length,
-                                                   u.DM_ALIGNMENT)
-                    data = u.get_data(data_length)
-                    dm.copy_to_dm(data_offset, data.encode(), data_length)
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
+                                      u.DM_ALIGNMENT)
+            dm_attrs = u.get_dm_attrs(dm_len)
+            with d.DM(ctx, dm_attrs) as dm:
+                data_length = random.randrange(4, dm_len, u.DM_ALIGNMENT)
+                data_offset = random.randrange(0, dm_len - data_length,
+                                               u.DM_ALIGNMENT)
+                data = 'a' * data_length
+                dm.copy_to_dm(data_offset, data.encode(), data_length)
 
-    @staticmethod
-    def test_dm_write_bad_flow():
+    def test_dm_write_bad_flow(self):
         """
         Test writing to the device memory with bad offset and length
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
-                                          u.DM_ALIGNMENT)
-                dm_attrs = u.get_dm_attrs(dm_len)
-                with d.DM(ctx, dm_attrs) as dm:
-                    data_length = random.randrange(4, dm_len, u.DM_ALIGNMENT)
-                    data_offset = random.randrange(0, dm_len - data_length,
-                                                   u.DM_ALIGNMENT)
-                    data_offset += 1  # offset needs to be a multiple of 4
-                    data = u.get_data(data_length)
-                    try:
-                        dm.copy_to_dm(data_offset, data.encode(), data_length)
-                    except PyverbsRDMAError as e:
-                        assert 'Failed to copy to dm' in e.args[0]
-                    else:
-                        raise PyverbsError(
-                            'Wrote to device memory with a bad offset')
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
+                                      u.DM_ALIGNMENT)
+            dm_attrs = u.get_dm_attrs(dm_len)
+            with d.DM(ctx, dm_attrs) as dm:
+                data_length = random.randrange(4, dm_len, u.DM_ALIGNMENT)
+                data_offset = random.randrange(0, dm_len - data_length,
+                                               u.DM_ALIGNMENT)
+                data_offset += 1  # offset needs to be a multiple of 4
+                data = 'a' * data_length
+                try:
+                    dm.copy_to_dm(data_offset, data.encode(), data_length)
+                except PyverbsRDMAError as e:
+                    assert 'Failed to copy to dm' in e.args[0]
+                else:
+                    raise PyverbsError(
+                        'Wrote to device memory with a bad offset')
 
-    @staticmethod
-    def test_dm_read():
+    def test_dm_read(self):
         """
         Test reading from the device memory
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
-                                          u.DM_ALIGNMENT)
-                dm_attrs = u.get_dm_attrs(dm_len)
-                with d.DM(ctx, dm_attrs) as dm:
-                    data_length = random.randrange(4, dm_len, u.DM_ALIGNMENT)
-                    data_offset = random.randrange(0, dm_len - data_length,
-                                                   u.DM_ALIGNMENT)
-                    data = u.get_data(data_length)
-                    dm.copy_to_dm(data_offset, data.encode(), data_length)
-                    read_str = dm.copy_from_dm(data_offset, data_length)
-                    assert read_str.decode() == data
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
+                                      u.DM_ALIGNMENT)
+            dm_attrs = u.get_dm_attrs(dm_len)
+            with d.DM(ctx, dm_attrs) as dm:
+                data_length = random.randrange(4, dm_len, u.DM_ALIGNMENT)
+                data_offset = random.randrange(0, dm_len - data_length,
+                                               u.DM_ALIGNMENT)
+                data = 'a' * data_length
+                dm.copy_to_dm(data_offset, data.encode(), data_length)
+                read_str = dm.copy_from_dm(data_offset, data_length)
+                assert read_str.decode() == data
diff --git a/pyverbs/tests/mr.py b/pyverbs/tests/mr.py
index f27c40887f94..e303fd575de4 100644
--- a/pyverbs/tests/mr.py
+++ b/pyverbs/tests/mr.py
@@ -1,12 +1,13 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
-# Copyright (c) 2019, Mellanox Technologies. All rights reserved.  See COPYING file
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
 """
 Test module for pyverbs' mr module.
 """
-import unittest
+from itertools import combinations as com
 import random
 
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
+from pyverbs.tests.base import PyverbsTestCase
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.mr import MR, MW, DMMR
 import pyverbs.tests.utils as u
@@ -17,61 +18,57 @@ import pyverbs.enums as e
 MAX_IO_LEN = 1048576
 
 
-class MRTest(unittest.TestCase):
+class MRTest(PyverbsTestCase):
     """
     Test various functionalities of the MR class.
     """
-    @staticmethod
-    def test_reg_mr():
+    def test_reg_mr(self):
         """ Test ibv_reg_mr() """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    with MR(pd, u.get_mr_length(), u.get_access_flags()) as mr:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                flags = u.get_access_flags(ctx)
+                for f in flags:
+                    with MR(pd, u.get_mr_length(), f) as mr:
                         pass
 
-    @staticmethod
-    def test_dereg_mr():
+    def test_dereg_mr(self):
         """ Test ibv_dereg_mr() """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    with MR(pd, u.get_mr_length(), u.get_access_flags()) as mr:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                flags = u.get_access_flags(ctx)
+                for f in flags:
+                    with MR(pd, u.get_mr_length(), f) as mr:
                         mr.close()
 
     @staticmethod
     def test_reg_mr_bad_flow():
         """ Verify that trying to register a MR with None PD fails """
         try:
-            MR(None, random.randint(0, 10000), u.get_access_flags())
+            # Use the simplest access flags necessary
+            MR(None, random.randint(0, 10000), e.IBV_ACCESS_LOCAL_WRITE)
         except TypeError as te:
             assert 'expected pyverbs.pd.PD' in te.args[0]
             assert 'got NoneType' in te.args[0]
         else:
             raise PyverbsRDMAErrno('Created a MR with None PD')
 
-    @staticmethod
-    def test_dereg_mr_twice():
+    def test_dereg_mr_twice(self):
         """ Verify that explicit call to MR's close() doesn't fails """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    with MR(pd, u.get_mr_length(), u.get_access_flags()) as mr:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                flags = u.get_access_flags(ctx)
+                for f in flags:
+                    with MR(pd, u.get_mr_length(), f) as mr:
                         # Pyverbs supports multiple destruction of objects,
                         # we are not expecting an exception here.
                         mr.close()
                         mr.close()
 
-    @staticmethod
-    def test_reg_mr_bad_flags():
+    def test_reg_mr_bad_flags(self):
         """ Verify that illegal flags combination fails as expected """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                for i in range(5):
                     flags = random.sample([e.IBV_ACCESS_REMOTE_WRITE,
                                            e.IBV_ACCESS_REMOTE_ATOMIC],
                                           random.randint(1, 2))
@@ -85,139 +82,138 @@ class MRTest(unittest.TestCase):
                     else:
                         raise PyverbsRDMAError('Registered a MR with illegal falgs')
 
-    @staticmethod
-    def test_write():
+    def test_write(self):
         """
         Test writing to MR's buffer
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                for i in range(10):
                     mr_len = u.get_mr_length()
-                    with MR(pd, mr_len, u.get_access_flags()) as mr:
-                        write_len = min(random.randint(1, MAX_IO_LEN), mr_len)
-                        mr.write(u.get_data(write_len), write_len)
-
-    @staticmethod
-    def test_read():
+                    flags = u.get_access_flags(ctx)
+                    for f in flags:
+                        with MR(pd, mr_len, f) as mr:
+                            write_len = min(random.randint(1, MAX_IO_LEN),
+                                            mr_len)
+                            mr.write('a' * write_len, write_len)
+
+    def test_read(self):
         """
         Test reading from MR's buffer
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                for i in range(10):
                     mr_len = u.get_mr_length()
-                    with MR(pd, mr_len, u.get_access_flags()) as mr:
-                        write_len = min(random.randint(1, MAX_IO_LEN), mr_len)
-                        write_str = u.get_data(write_len)
-                        mr.write(write_str, write_len)
-                        read_len = random.randint(1, write_len)
-                        offset = random.randint(0, write_len-read_len)
-                        read_str = mr.read(read_len, offset).decode()
-                        assert read_str in write_str
-
-    @staticmethod
-    def test_lkey():
+                    flags = u.get_access_flags(ctx)
+                    for f in flags:
+                        with MR(pd, mr_len, f) as mr:
+                            write_len = min(random.randint(1, MAX_IO_LEN),
+                                            mr_len)
+                            write_str = 'a' * write_len
+                            mr.write(write_str, write_len)
+                            read_len = random.randint(1, write_len)
+                            offset = random.randint(0, write_len-read_len)
+                            read_str = mr.read(read_len, offset).decode()
+                            assert read_str in write_str
+
+    def test_lkey(self):
         """
         Test reading lkey property
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    length = u.get_mr_length()
-                    with MR(pd, length, u.get_access_flags()) as mr:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                length = u.get_mr_length()
+                flags = u.get_access_flags(ctx)
+                for f in flags:
+                    with MR(pd, length, f) as mr:
                         mr.lkey
 
-    @staticmethod
-    def test_rkey():
+    def test_rkey(self):
         """
         Test reading rkey property
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    length = u.get_mr_length()
-                    with MR(pd, length, u.get_access_flags()) as mr:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                length = u.get_mr_length()
+                flags = u.get_access_flags(ctx)
+                for f in flags:
+                    with MR(pd, length, f) as mr:
                         mr.rkey
 
-    @staticmethod
-    def test_buffer():
+    def test_buffer(self):
         """
         Test reading buf property
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    length = u.get_mr_length()
-                    with MR(pd, length, u.get_access_flags()) as mr:
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                length = u.get_mr_length()
+                flags = u.get_access_flags(ctx)
+                for f in flags:
+                    with MR(pd, length, f) as mr:
                         mr.buf
 
 
-class MWTest(unittest.TestCase):
+class MWTest(PyverbsTestCase):
     """
     Test various functionalities of the MW class.
     """
-    @staticmethod
-    def test_reg_mw():
+    def test_reg_mw_type1(self):
         """ Test ibv_alloc_mw() """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    with MW(pd, random.choice([e.IBV_MW_TYPE_1,
-                                               e.IBV_MW_TYPE_2])):
-                        pass
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with MW(pd, e.IBV_MW_TYPE_1):
+                    pass
 
-    @staticmethod
-    def test_dereg_mw():
-        """ Test ibv_dealloc_mw() """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    with MW(pd, random.choice([e.IBV_MW_TYPE_1,
-                                               e.IBV_MW_TYPE_2])) as mw:
-                        mw.close()
-
-    @staticmethod
-    def test_reg_mw_wrong_type():
+    def test_reg_mw_type2(self):
         """ Test ibv_alloc_mw() """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    try:
-                        mw_type = random.randint(3, 100)
-                        MW(pd, mw_type)
-                    except PyverbsRDMAError:
-                        pass
-                    else:
-                        raise PyverbsError('Created a MW with type {t}'.\
-                                           format(t=mw_type))
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with MW(pd, e.IBV_MW_TYPE_2):
+                    pass
 
+    def test_dereg_mw_type1(self):
+        """ Test ibv_dealloc_mw() """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with MW(pd, e.IBV_MW_TYPE_1) as mw:
+                    mw.close()
+
+    def test_dereg_mw_type2(self):
+        """ Test ibv_dealloc_mw() """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with MW(pd, e.IBV_MW_TYPE_2) as mw:
+                    mw.close()
 
-class DMMRTest(unittest.TestCase):
+    def test_reg_mw_wrong_type(self):
+        """ Test ibv_alloc_mw() """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                try:
+                    mw_type = random.randint(3, 100)
+                    MW(pd, mw_type)
+                except PyverbsRDMAError:
+                    pass
+                else:
+                    raise PyverbsError('Created a MW with type {t}'.\
+                                       format(t=mw_type))
+
+
+class DMMRTest(PyverbsTestCase):
     """
     Test various functionalities of the DMMR class.
     """
-    @staticmethod
-    def test_create_dm_mr():
+    def test_create_dm_mr(self):
         """
         Test ibv_reg_dm_mr
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                with PD(ctx) as pd:
-                    dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            with PD(ctx) as pd:
+                for i in range(10):
+                    dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
                                               u.DM_ALIGNMENT)
                     dm_attrs = u.get_dm_attrs(dm_len)
                     with d.DM(ctx, dm_attrs) as dm:
@@ -226,19 +222,16 @@ class DMMRTest(unittest.TestCase):
                         DMMR(pd, dm_mr_len, e.IBV_ACCESS_ZERO_BASED, dm=dm,
                              offset=dm_mr_offset)
 
-    @staticmethod
-    def test_destroy_dm_mr():
+    def test_destroy_dm_mr(self):
         """
         Test freeing of dm_mr
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                attr = ctx.query_device_ex()
-                if attr.max_dm_size == 0:
-                    return
-                with PD(ctx) as pd:
-                    dm_len = random.randrange(u.MIN_DM_SIZE, attr.max_dm_size,
+        for ctx, attr, attr_ex in self.devices:
+            if attr_ex.max_dm_size == 0:
+                return
+            with PD(ctx) as pd:
+                for i in range(10):
+                    dm_len = random.randrange(u.MIN_DM_SIZE, attr_ex.max_dm_size,
                                               u.DM_ALIGNMENT)
                     dm_attrs = u.get_dm_attrs(dm_len)
                     with d.DM(ctx, dm_attrs) as dm:
diff --git a/pyverbs/tests/pd.py b/pyverbs/tests/pd.py
index c9c6384e1bd0..5072a4a35de1 100644
--- a/pyverbs/tests/pd.py
+++ b/pyverbs/tests/pd.py
@@ -1,53 +1,44 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
-# Copyright (c) 2019, Mellanox Technologies. All rights reserved.  See COPYING file
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
 """
 Test module for pyverbs' pd module.
 """
-import unittest
 import random
 
+from pyverbs.tests.base import PyverbsTestCase
 from pyverbs.base import PyverbsRDMAErrno
 import pyverbs.device as d
 from pyverbs.pd import PD
 
 
-class PDTest(unittest.TestCase):
+class PDTest(PyverbsTestCase):
     """
     Test various functionalities of the PD class.
     """
-    @staticmethod
-    def test_alloc_pd():
+    def test_alloc_pd(self):
         """
         Test ibv_alloc_pd()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx):
-                    pass
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx):
+                pass
 
-    @staticmethod
-    def test_dealloc_pd():
+    def test_dealloc_pd(self):
         """
         Test ibv_dealloc_pd()
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    pd.close()
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                pd.close()
 
-    @staticmethod
-    def test_multiple_pd_creation():
+    def test_multiple_pd_creation(self):
         """
         Test multiple creations and destructions of a PD object
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                for i in range(random.randint(1, 200)):
-                    with PD(ctx) as pd:
-                        pd.close()
+        for ctx, attr, attr_ex in self.devices:
+            for i in range(random.randint(1, 200)):
+                with PD(ctx) as pd:
+                    pd.close()
 
     @staticmethod
     def test_create_pd_none_ctx():
@@ -62,16 +53,13 @@ class PDTest(unittest.TestCase):
         else:
             raise PyverbsRDMAErrno('Created a PD with None context')
 
-    @staticmethod
-    def test_destroy_pd_twice():
+    def test_destroy_pd_twice(self):
         """
         Test bad flow cases in destruction of a PD object
         """
-        lst = d.get_device_list()
-        for dev in lst:
-            with d.Context(name=dev.name.decode()) as ctx:
-                with PD(ctx) as pd:
-                    # Pyverbs supports multiple destruction of objects, we are
-                    # not expecting an exception here.
-                    pd.close()
-                    pd.close()
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                # Pyverbs supports multiple destruction of objects, we are
+                # not expecting an exception here.
+                pd.close()
+                pd.close()
diff --git a/pyverbs/tests/utils.py b/pyverbs/tests/utils.py
index 84deb49093d2..c4a28b70a2da 100644
--- a/pyverbs/tests/utils.py
+++ b/pyverbs/tests/utils.py
@@ -3,6 +3,7 @@
 """
 Provide some useful helper function for pyverbs' tests.
 """
+from itertools import combinations as com
 from string import ascii_lowercase as al
 import random
 
@@ -25,37 +26,56 @@ def get_mr_length():
     """
     Provide a random value for MR length. We avoid large buffers as these
     allocations typically fails.
+    We use random.random() instead of randrange() or randint() due to
+    performance issues when generating very large pseudo random numbers.
     :return: A random MR length
     """
-    return random.randint(0, MAX_MR_SIZE)
+    return int(MAX_MR_SIZE * random.random())
 
 
-def get_access_flags():
+def filter_illegal_access_flags(element):
     """
-    Provide random legal access flags for an MR.
+    Helper function to filter illegal access flags combinations
+    :param element: A list of access flags to check
+    :return: True if this list is legal, else False
+    """
+    if e.IBV_ACCESS_REMOTE_ATOMIC in element or e.IBV_ACCESS_REMOTE_WRITE:
+        if e.IBV_ACCESS_LOCAL_WRITE:
+            return False
+    return True
+
+
+def get_access_flags(ctx):
+    """
+    Provide an array of random legal access flags for an MR.
     Since remote write and remote atomic require local write permission, if
     one of them is randomly selected without local write, local write will be
     added as well.
+    After verifying that the flags selection is legal, it is appended to an
+    array, assuming it wasn't previously appended.
+    :param ctx: Device Context to check capabilities
+    :param num: Size of initial collection
     :return: A random legal value for MR flags
     """
+    attr = ctx.query_device()
+    attr_ex = ctx.query_device_ex()
     vals = list(e.ibv_access_flags)
-    selected = random.sample(vals, random.randint(1, 7))
-    if e.IBV_ACCESS_REMOTE_WRITE in selected or e.IBV_ACCESS_REMOTE_ATOMIC in selected:
-        if not e.IBV_ACCESS_LOCAL_WRITE in selected:
-            selected.append(e.IBV_ACCESS_LOCAL_WRITE)
-    flags = 0
-    for i in selected:
-        flags += i.value
-    return flags
-
-
-def get_data(length):
-    """
-    Randomizes data of a given length.
-    :param length: Length of the data
-    :return: A random data of the given length
-    """
-    return ''.join(random.choice(al) for i in range(length))
+    if not attr_ex.odp_caps.general_caps & e.IBV_ODP_SUPPORT:
+        vals.remove(e.IBV_ACCESS_ON_DEMAND)
+    if not attr.device_cap_flags & e.IBV_DEVICE_MEM_WINDOW:
+        vals.remove(e.IBV_ACCESS_MW_BIND)
+    if not attr.atomic_caps & e.IBV_ATOMIC_HCA:
+        vals.remove(e.IBV_ACCESS_REMOTE_ATOMIC)
+    arr = []
+    for i in range(1, len(vals)):
+        tmp = list(com(vals, i))
+        tmp = filter(filter_illegal_access_flags, tmp)
+        for t in tmp:  # Iterate legal combinations and bitwise OR them
+            val = 0
+            for flag in t:
+                val += flag.value
+            arr.append(val)
+    return arr
 
 
 def get_dm_attrs(dm_len):
@@ -68,3 +88,12 @@ def get_dm_attrs(dm_len):
     """
     align = random.randint(MIN_DM_LOG_ALIGN, MAX_DM_LOG_ALIGN)
     return d.AllocDmAttr(dm_len, align, 0)
+
+
+def sample(coll):
+    """
+    Returns a random-length subset of the given collection.
+    :param coll: The collection to sample
+    :return: A subset of <collection>
+    """
+    return random.sample(coll, int((len(coll) + 1) * random.random()))
-- 
2.17.2

