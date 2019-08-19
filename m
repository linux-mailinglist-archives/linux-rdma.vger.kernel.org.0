Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D0291D75
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfHSG6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:37 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53190 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbfHSG6g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:36 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNQ004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 14/14] tests: Unify API tests' output
Date:   Mon, 19 Aug 2019 09:58:27 +0300
Message-Id: <20190819065827.26921-15-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When executed in verbose mode, unittest infrastructure prints a test's
docstring if it's in a single line format, which was used in some
tests. Change those to use multiline format instead.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 tests/test_device.py |  6 ++++--
 tests/test_mr.py     | 36 +++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/test_device.py b/tests/test_device.py
index e395e793c28f..32dedb34d559 100644
--- a/tests/test_device.py
+++ b/tests/test_device.py
@@ -120,7 +120,9 @@ class DeviceTest(unittest.TestCase):
 
     @staticmethod
     def test_query_port_bad_flow():
-        """ Verify that querying non-existing ports fails as expected """
+        """
+        Verify that querying non-existing ports fails as expected
+        """
         lst = d.get_device_list()
         for dev in lst:
             with d.Context(name=dev.name.decode()) as ctx:
@@ -199,7 +201,7 @@ class DMTest(PyverbsAPITestCase):
 
     def test_destroy_dm_bad_flow(self):
         """
-        test calling ibv_free_dm() twice
+        Test calling ibv_free_dm() twice
         """
         for ctx, attr, attr_ex in self.devices:
             if attr_ex.max_dm_size == 0:
diff --git a/tests/test_mr.py b/tests/test_mr.py
index e87fb33624ed..d11a4b8f8f26 100644
--- a/tests/test_mr.py
+++ b/tests/test_mr.py
@@ -32,7 +32,9 @@ class MRTest(PyverbsAPITestCase):
                         pass
 
     def test_dereg_mr(self):
-        """ Test ibv_dereg_mr() """
+        """
+        Test ibv_dereg_mr()
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 flags = u.get_access_flags(ctx)
@@ -42,7 +44,9 @@ class MRTest(PyverbsAPITestCase):
 
     @staticmethod
     def test_reg_mr_bad_flow():
-        """ Verify that trying to register a MR with None PD fails """
+        """
+        Verify that trying to register a MR with None PD fails
+        """
         try:
             # Use the simplest access flags necessary
             MR(None, random.randint(0, 10000), e.IBV_ACCESS_LOCAL_WRITE)
@@ -53,7 +57,9 @@ class MRTest(PyverbsAPITestCase):
             raise PyverbsRDMAErrno('Created a MR with None PD')
 
     def test_dereg_mr_twice(self):
-        """ Verify that explicit call to MR's close() doesn't fails """
+        """
+        Verify that explicit call to MR's close() doesn't fail
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 flags = u.get_access_flags(ctx)
@@ -65,7 +71,9 @@ class MRTest(PyverbsAPITestCase):
                         mr.close()
 
     def test_reg_mr_bad_flags(self):
-        """ Verify that illegal flags combination fails as expected """
+        """
+        Verify that illegal flags combination fails as expected
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 for i in range(5):
@@ -159,35 +167,45 @@ class MWTest(PyverbsAPITestCase):
     Test various functionalities of the MW class.
     """
     def test_reg_mw_type1(self):
-        """ Test ibv_alloc_mw() """
+        """
+        Test ibv_alloc_mw() for type 1 MW
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 with MW(pd, e.IBV_MW_TYPE_1):
                     pass
 
     def test_reg_mw_type2(self):
-        """ Test ibv_alloc_mw() """
+        """
+        Test ibv_alloc_mw() for type 2 MW
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 with MW(pd, e.IBV_MW_TYPE_2):
                     pass
 
     def test_dereg_mw_type1(self):
-        """ Test ibv_dealloc_mw() """
+        """
+        Test ibv_dealloc_mw() for type 1 MW
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 with MW(pd, e.IBV_MW_TYPE_1) as mw:
                     mw.close()
 
     def test_dereg_mw_type2(self):
-        """ Test ibv_dealloc_mw() """
+        """
+        Test ibv_dealloc_mw() for type 2 MW
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 with MW(pd, e.IBV_MW_TYPE_2) as mw:
                     mw.close()
 
     def test_reg_mw_wrong_type(self):
-        """ Test ibv_alloc_mw() """
+        """
+        Verify that trying to create a MW of a wrong type fails
+        """
         for ctx, attr, attr_ex in self.devices:
             with PD(ctx) as pd:
                 try:
-- 
2.21.0

