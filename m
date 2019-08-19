Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27391D71
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53173 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725958AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNM004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 10/14] tests: Add ODP RC test
Date:   Mon, 19 Aug 2019 09:58:23 +0300
Message-Id: <20190819065827.26921-11-noaos@mellanox.com>
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

Add a TestCase for ODP/RC traffic.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 tests/CMakeLists.txt |  1 +
 tests/test_odp.py    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tests/test_odp.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index f1ba542fab90..6f3c23cd1ec0 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -10,5 +10,6 @@ rdma_python_test(tests
   test_mr.py
   test_pd.py
   test_qp.py
+  test_odp.py
   utils.py
   )
diff --git a/tests/test_odp.py b/tests/test_odp.py
new file mode 100644
index 000000000000..a9f3bf4573a5
--- /dev/null
+++ b/tests/test_odp.py
@@ -0,0 +1,30 @@
+from tests.base import RDMATestCase
+from tests.utils import requires_odp, traffic
+from tests.base import RCResources
+from pyverbs.mr import MR
+import pyverbs.enums as e
+
+
+class OdpRC(RCResources):
+    @requires_odp('rc')
+    def create_mr(self):
+        self.mr = MR(self.pd, self.msg_size,
+                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
+
+
+class OdpTestCase(RDMATestCase):
+    def setUp(self):
+        super(OdpTestCase, self).setUp()
+        self.iters = 100
+        self.qp_dict = {'rc': OdpRC}
+
+    def create_players(self, qp_type):
+        client = self.qp_dict[qp_type](self.dev_name, self.ib_port, self.gid_index)
+        server = self.qp_dict[qp_type](self.dev_name, self.ib_port, self.gid_index)
+        client.pre_run(server.psn, server.qpn)
+        server.pre_run(client.psn, client.qpn)
+        return client, server
+
+    def test_odp_rc_traffic(self):
+        client, server = self.create_players('rc')
+        traffic(client, server, self.iters, self.gid_index, self.ib_port)
-- 
2.21.0

