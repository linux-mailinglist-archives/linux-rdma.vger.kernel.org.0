Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3660791D7C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHSG6j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:39 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53155 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726812AbfHSG6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNH004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 05/14] tests: RDMATestCase
Date:   Mon, 19 Aug 2019 09:58:18 +0300
Message-Id: <20190819065827.26921-6-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

Base class for future tests which allows user-set parameters:
device name, IB port, GID index and PKey index can be provided to the
tests. If not, they're selected at random.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 tests/base.py | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tests/base.py b/tests/base.py
index 88f00e07b326..e141b83dea0e 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -2,9 +2,11 @@
 # Copyright (c) 2019 Mellanox Technologies, Inc . All rights reserved. See COPYING file
 
 import unittest
+import random
 
 from pyverbs.device import Context
 import pyverbs.device as d
+import pyverbs.enums as e
 from pyverbs.pd import PD
 
 
@@ -26,6 +28,105 @@ class PyverbsAPITestCase(unittest.TestCase):
             tup[0].close()
 
 
+class RDMATestCase(unittest.TestCase):
+    """
+    A base class for test cases which provides the option for user parameters.
+    These can be provided by manually adding the test case to the runner:
+    suite = unittest.TestSuite()
+    ... # Regular auto-detection of test cases, no parameters used.
+    # Now follows your manual addition of test cases e.g:
+    suite.addTest(RDMATestCase.parametrize(<TestCaseName>, dev_name='..',
+                                           ib_port=1, gid_index=3,
+                                           pkey_index=42))
+    """
+    ZERO_GID = '0000:0000:0000:0000'
+
+    def __init__(self, methodName='runTest', dev_name=None, ib_port=None,
+                 gid_index=None, pkey_index=None):
+        super(RDMATestCase, self).__init__(methodName)
+        self.dev_name = dev_name
+        self.ib_port = ib_port
+        self.gid_index = gid_index
+        self.pkey_index = pkey_index
+
+    @staticmethod
+    def parametrize(testcase_klass, dev_name=None, ib_port=None, gid_index=None,
+                    pkey_index=None):
+        """
+        Create a test suite containing all the tests from the given subclass
+        with the given dev_name, port, gid index and pkey_index.
+        """
+        loader = unittest.TestLoader()
+        names = loader.getTestCaseNames(testcase_klass)
+        suite = unittest.TestSuite()
+        for n in names:
+            suite.addTest(testcase_klass(n, dev_name=dev_name, ib_port=ib_port,
+                                         gid_index=gid_index,
+                                         pkey_index=pkey_index))
+        return suite
+
+    def setUp(self):
+        """
+        Verify that the test case has dev_name, ib_port, gid_index and pkey index.
+        If not provided by the user, a random valid combination will be used.
+        """
+        if self.pkey_index is None:
+            # To avoid iterating the entire pkeys table, if a pkey index wasn't
+            # provided, use index 0 which is always valid
+            self.pkey_index = 0
+
+        self.args = []
+        if self.dev_name is not None:
+            ctx = d.Context(name=self.dev_name)
+            if self.ib_port is not None:
+                if self.gid_index is not None:
+                    # We have all we need, return
+                    return
+                else:
+                    # Add avaiable GIDs of the given dev_name + port
+                    self._add_gids_per_port(ctx, self.dev_name, self.ib_port)
+            else:
+                # Add available GIDs for each port of the given dev_name
+                self._add_gids_per_device(ctx, self.dev_name)
+        else:
+            # Iterate available devices, add available GIDs for each of
+            # their ports
+            lst = d.get_device_list()
+            for dev in lst:
+                dev_name = dev.name.decode()
+                ctx = d.Context(name=dev_name)
+                self._add_gids_per_device(ctx, dev_name)
+
+        if not self.args:
+            raise unittest.SkipTest('No dev/port/GID combinations, please check your setup and try again')
+        # Choose one combination and use it
+        args = random.choice(self.args)
+        self.dev_name = args[0]
+        self.ib_port = args[1]
+        self.gid_index = args[2]
+
+    def _add_gids_per_port(self, ctx, dev, port):
+        idx = 0
+        ll = ctx.query_port(port).link_layer
+        while True:
+            gid = ctx.query_gid(port, idx)
+            if gid.gid[-19:] == self.ZERO_GID:
+                # No point iterating on
+                break
+            if ll == e.IBV_LINK_LAYER_ETHERNET and gid.gid[0:4] == 'fe80':
+                # Use only IPv4/IPv6 GIDs
+                idx += 1
+                continue
+            else:
+                self.args.append([dev, port, idx])
+                idx += 1
+
+    def _add_gids_per_device(self, ctx, dev):
+        port_count = ctx.query_device().phys_port_cnt
+        for port in range(port_count):
+            self._add_gids_per_port(ctx, dev, port+1)
+
+
 class BaseResources(object):
     """
     BaseResources class is a base aggregator object which contains basic
-- 
2.21.0

