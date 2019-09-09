Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13B0AD54B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbfIIJHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48388 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389611AbfIIJHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:20 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:17 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997FpA028426;
        Mon, 9 Sep 2019 12:07:17 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 12/12] tests: Add XRC ODP test case
Date:   Mon,  9 Sep 2019 12:07:12 +0300
Message-Id: <20190909090712.11029-13-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090712.11029-1-noaos@mellanox.com>
References: <20190909090712.11029-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

This case creates client and server, each one have two SEND and RECV
XRC QPs, and SRQ. By connecting SRQ and RECV XRC QPs to the same XRCD
and connecting SEND XRC QPs to RECV XRC QPs of the opposite side,
we run a traffic and validate the data received by the SRQ.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py     |  5 ++++-
 tests/test_odp.py | 32 +++++++++++++++++++++++--------
 tests/utils.py    | 48 ++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 73 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 tests/test_odp.py
 mode change 100644 => 100755 tests/utils.py

diff --git a/tests/base.py b/tests/base.py
index dd17ddb6fc50..57a75f797770 100755
--- a/tests/base.py
+++ b/tests/base.py
@@ -375,7 +375,10 @@ class XRCResources(TrafficResources):
         self.srq = SRQ(self.ctx, srq_attr)
 
     def to_rts(self):
-        ah_attr = AHAttr(dlid=self.port_attr.lid)
+        gid = self.ctx.query_gid(self.ib_port, self.gid_index)
+        gr = GlobalRoute(dgid=gid, sgid_index=self.gid_index)
+        ah_attr = AHAttr(port_num=self.ib_port, is_global=True,
+                         gr=gr, dlid=self.port_attr.lid)
         qp_attr = QPAttr()
         qp_attr.path_mtu = PATH_MTU
         qp_attr.timeout = TIMEOUT
diff --git a/tests/test_odp.py b/tests/test_odp.py
old mode 100644
new mode 100755
index 922cd0d9aad5..d412a7792951
--- a/tests/test_odp.py
+++ b/tests/test_odp.py
@@ -1,6 +1,6 @@
+from tests.base import RCResources, UDResources, XRCResources
+from tests.utils import requires_odp, traffic, xrc_traffic
 from tests.base import RDMATestCase
-from tests.utils import requires_odp, traffic
-from tests.base import RCResources, UDResources
 from pyverbs.mr import MR
 import pyverbs.enums as e
 
@@ -8,7 +8,7 @@ import pyverbs.enums as e
 class OdpUD(UDResources):
     @requires_odp('ud')
     def create_mr(self):
-        self.mr = MR(self.pd, self.msg_size + self.GRH_SIZE ,
+        self.mr = MR(self.pd, self.msg_size + self.GRH_SIZE,
                      e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
 
 
@@ -18,18 +18,30 @@ class OdpRC(RCResources):
         self.mr = MR(self.pd, self.msg_size,
                      e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
 
+class OdpXRC(XRCResources):
+    @requires_odp('xrc')
+    def create_mr(self):
+        self.mr = MR(self.pd, self.msg_size,
+                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
+
 
 class OdpTestCase(RDMATestCase):
     def setUp(self):
         super(OdpTestCase, self).setUp()
         self.iters = 100
-        self.qp_dict = {'rc': OdpRC, 'ud': OdpUD}
+        self.qp_dict = {'rc': OdpRC, 'ud': OdpUD, 'xrc': OdpXRC}
 
     def create_players(self, qp_type):
-        client = self.qp_dict[qp_type](self.dev_name, self.ib_port, self.gid_index)
-        server = self.qp_dict[qp_type](self.dev_name, self.ib_port, self.gid_index)
-        client.pre_run(server.psn, server.qpn)
-        server.pre_run(client.psn, client.qpn)
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
         return client, server
 
     def test_odp_rc_traffic(self):
@@ -39,3 +51,7 @@ class OdpTestCase(RDMATestCase):
     def test_odp_ud_traffic(self):
         client, server = self.create_players('ud')
         traffic(client, server, self.iters, self.gid_index, self.ib_port)
+
+    def test_odp_xrc_traffic(self):
+        client, server = self.create_players('xrc')
+        xrc_traffic(client, server)
diff --git a/tests/utils.py b/tests/utils.py
old mode 100644
new mode 100755
index 881ce4d03634..785309552e25
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -12,6 +12,7 @@ from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
 from pyverbs.addr import AHAttr, AH, GlobalRoute
 from pyverbs.wr import SGE, SendWR, RecvWR
 from pyverbs.qp import QPCap, QPInitAttrEx
+from tests.base import XRCResources
 import pyverbs.device as d
 import pyverbs.enums as e
 
@@ -256,7 +257,8 @@ def get_send_wr(agr_obj, is_server):
     :param is_server: Indicates whether this is server or client side
     :return: send wr
     """
-    qp_type = agr_obj.qp.qp_type
+    qp_type = agr_obj.sqp_lst[0].qp_type if isinstance(agr_obj, XRCResources) \
+                else agr_obj.qp.qp_type
     mr = agr_obj.mr
     if qp_type == e.IBV_QPT_UD:
         send_sge = SGE(mr.buf + GRH_SIZE, agr_obj.msg_size, mr.lkey)
@@ -273,7 +275,8 @@ def get_recv_wr(agr_obj):
     :param agr_obj: Aggregation object which contains all resources necessary
     :return: recv wr
     """
-    qp_type = agr_obj.qp.qp_type
+    qp_type = agr_obj.rqp_lst[0].qp_type if isinstance(agr_obj, XRCResources) \
+                else agr_obj.qp.qp_type
     mr = agr_obj.mr
     if qp_type == e.IBV_QPT_UD:
         recv_sge = SGE(mr.buf, agr_obj.msg_size + GRH_SIZE, mr.lkey)
@@ -393,6 +396,44 @@ def traffic(client, server, iters, gid_idx, port):
         msg_received = client.mr.read(client.msg_size, 0)
         validate(msg_received, False, client.msg_size)
 
+
+def xrc_traffic(client, server):
+    """
+    Runs basic xrc traffic, this function assumes that number of QPs, which
+    server and client have are equal, server.send_qp[i] is connected to
+    client.recv_qp[i], each time server.send_qp[i] sends a message, it is
+    redirected to client.srq because client.recv_qp[i] and client.srq are
+    under the same xrcd. The traffic flow in the opposite direction is the same.
+    :param client: Aggregation object of the active side, should be an instance
+    of XRCResources class
+    :param server: Aggregation object of the passive side, should be an instance
+    of XRCResources class
+    :return: None
+    """
+    client_srqn = client.srq.get_srq_num()
+    server_srqn = server.srq.get_srq_num()
+    s_recv_wr = get_recv_wr(server)
+    c_recv_wr = get_recv_wr(client)
+    post_recv(client.srq, c_recv_wr, client.qp_count*client.num_msgs)
+    post_recv(server.srq, s_recv_wr, server.qp_count*server.num_msgs)
+    for _ in range(client.num_msgs):
+        for i in range(server.qp_count):
+            c_send_wr = get_send_wr(client, False)
+            c_send_wr.set_qp_type_xrc(server_srqn)
+            client.sqp_lst[i].post_send(c_send_wr)
+            poll_cq(client.cq)
+            poll_cq(server.cq)
+            msg_received = server.mr.read(server.msg_size, 0)
+            validate(msg_received, True, server.msg_size)
+            s_send_wr = get_send_wr(server, True)
+            s_send_wr.set_qp_type_xrc(client_srqn)
+            server.sqp_lst[i].post_send(s_send_wr)
+            poll_cq(server.cq)
+            poll_cq(client.cq)
+            msg_received = client.mr.read(client.msg_size, 0)
+            validate(msg_received, False, client.msg_size)
+
+
 # Decorators
 def requires_odp(qp_type):
     def outer(func):
@@ -415,7 +456,8 @@ def odp_supported(ctx, qp_type):
         raise unittest.SkipTest('ODP is not supported - No ODP caps')
     qp_odp_caps = getattr(odp_caps, '{}_odp_caps'.format(qp_type))
     has_odp_send = qp_odp_caps & e.IBV_ODP_SUPPORT_SEND
-    has_odp_recv = qp_odp_caps & e.IBV_ODP_SUPPORT_RECV
+    has_odp_recv = qp_odp_caps & e.IBV_ODP_SUPPORT_SRQ_RECV if qp_type == 'xrc'\
+                else qp_odp_caps & e.IBV_ODP_SUPPORT_RECV
     if has_odp_send == 0:
         raise unittest.SkipTest('ODP is not supported - ODP send not supported')
     if has_odp_recv == 0:
-- 
2.21.0

