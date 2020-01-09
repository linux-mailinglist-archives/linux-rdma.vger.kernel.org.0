Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6152C135AF3
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgAIOFZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:25 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33793 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728770AbgAIOFY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:24 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5Guo016625;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5Gnb001350;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5Ge4001349;
        Thu, 9 Jan 2020 16:05:16 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 7/7] tests: Add relaxed ordering access test
Date:   Thu,  9 Jan 2020 16:04:36 +0200
Message-Id: <1578578676-752-8-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Test traffic with MRs with relaxed ordering access set.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Edward Srouji <edwards@mellanox.com>
---
 tests/CMakeLists.txt           |  5 ++--
 tests/test_relaxed_ordering.py | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_relaxed_ordering.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 6d70242..cacfc52 100755
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -10,11 +10,12 @@ rdma_python_test(tests
   test_cqex.py
   test_device.py
   test_mr.py
-  test_pd.py
-  test_qp.py
   test_odp.py
+  test_pd.py
   test_parent_domain.py
+  test_qp.py
   test_rdmacm.py
+  test_relaxed_ordering.py
   utils.py
   )
 
diff --git a/tests/test_relaxed_ordering.py b/tests/test_relaxed_ordering.py
new file mode 100644
index 0000000..27af992
--- /dev/null
+++ b/tests/test_relaxed_ordering.py
@@ -0,0 +1,55 @@
+from tests.base import RCResources, UDResources, XRCResources
+from tests.utils import traffic, xrc_traffic
+from tests.base import RDMATestCase
+from pyverbs.mr import MR
+import pyverbs.enums as e
+
+
+class RoUD(UDResources):
+    def create_mr(self):
+        self.mr = MR(self.pd, self.msg_size + self.GRH_SIZE,
+                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_RELAXED_ORDERING)
+
+
+class RoRC(RCResources):
+    def create_mr(self):
+        self.mr = MR(self.pd, self.msg_size,
+                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_RELAXED_ORDERING)
+
+
+class RoXRC(XRCResources):
+    def create_mr(self):
+        self.mr = MR(self.pd, self.msg_size,
+                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_RELAXED_ORDERING)
+
+
+class RoTestCase(RDMATestCase):
+    def setUp(self):
+        super(RoTestCase, self).setUp()
+        self.iters = 100
+        self.qp_dict = {'rc': RoRC, 'ud': RoUD, 'xrc': RoXRC}
+
+    def create_players(self, qp_type):
+        client = self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        server = self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        if qp_type == 'xrc':
+            client.pre_run(server.psns, server.qps_num)
+            server.pre_run(client.psns, client.qps_num)
+        else:
+            client.pre_run(server.psn, server.qpn)
+            server.pre_run(client.psn, client.qpn)
+        return client, server
+
+    def test_ro_rc_traffic(self):
+        client, server = self.create_players('rc')
+        traffic(client, server, self.iters, self.gid_index, self.ib_port)
+
+    def test_ro_ud_traffic(self):
+        client, server = self.create_players('ud')
+        traffic(client, server, self.iters, self.gid_index, self.ib_port)
+
+    def test_ro_xrc_traffic(self):
+        client, server = self.create_players('xrc')
+        xrc_traffic(client, server)
-- 
1.8.3.1

