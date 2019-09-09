Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECA6AD544
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbfIIJHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48378 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389616AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp8028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 10/12] tests: Fixes to to_rts() in RCResources
Date:   Mon,  9 Sep 2019 12:07:10 +0300
Message-Id: <20190909090712.11029-11-noaos@mellanox.com>
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

Move RCResources constants outside of the class in order to expose them
to other classes. Avoid passing parameters that are available to the
class.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)
 mode change 100644 => 100755 tests/base.py

diff --git a/tests/base.py b/tests/base.py
old mode 100644
new mode 100755
index b9bdaea93c96..ce9ea83b6b53
--- a/tests/base.py
+++ b/tests/base.py
@@ -13,6 +13,14 @@ from pyverbs.pd import PD
 from pyverbs.cq import CQ
 from pyverbs.mr import MR
 
+PATH_MTU = e.IBV_MTU_1024
+MAX_DEST_RD_ATOMIC = 1
+MAX_RD_ATOMIC = 1
+MIN_RNR_TIMER =12
+RETRY_CNT = 7
+RNR_RETRY = 7
+TIMEOUT = 14
+
 
 class PyverbsAPITestCase(unittest.TestCase):
     def setUp(self):
@@ -231,33 +239,24 @@ class TrafficResources(BaseResources):
 
 
 class RCResources(TrafficResources):
-    PATH_MTU = e.IBV_MTU_1024
-    MAX_DEST_RD_ATOMIC = 1
-    MAX_RD_ATOMIC = 1
-    MIN_RNR_TIMER =12
-    RETRY_CNT = 7
-    RNR_RETRY = 7
-    TIMEOUT = 14
-
-    def to_rts(self, rpsn, rqpn):
+
+    def to_rts(self):
         """
         Set the QP attributes' values to arbitrary values (same values used in
         ibv_rc_pingpong).
-        :param rpsn: Remote PSN (packet serial number)
-        :param rqpn: Remote QP number
         :return: None
         """
         attr = QPAttr(port_num=self.ib_port)
-        attr.dest_qp_num = rqpn
-        attr.path_mtu = self.PATH_MTU
-        attr.max_dest_rd_atomic = self.MAX_DEST_RD_ATOMIC
-        attr.min_rnr_timer = self.MIN_RNR_TIMER
-        attr.rq_psn = rpsn
-        attr.sq_psn = self.psn
-        attr.timeout = self.TIMEOUT
-        attr.retry_cnt = self.RETRY_CNT
-        attr.rnr_retry = self.RNR_RETRY
-        attr.max_rd_atomic = self.MAX_RD_ATOMIC
+        attr.dest_qp_num = self.rqpn
+        attr.path_mtu = PATH_MTU
+        attr.max_dest_rd_atomic = MAX_DEST_RD_ATOMIC
+        attr.min_rnr_timer = MIN_RNR_TIMER
+        attr.rq_psn = self.psn
+        attr.sq_psn = self.rpsn
+        attr.timeout = TIMEOUT
+        attr.retry_cnt = RETRY_CNT
+        attr.rnr_retry = RNR_RETRY
+        attr.max_rd_atomic = MAX_RD_ATOMIC
         gr = GlobalRoute(dgid=self.ctx.query_gid(self.ib_port, self.gid_index),
                          sgid_index=self.gid_index)
         ah_attr = AHAttr(port_num=self.ib_port, is_global=1, gr=gr,
@@ -266,9 +265,15 @@ class RCResources(TrafficResources):
         self.qp.to_rts(attr)
 
     def pre_run(self, rpsn, rqpn):
+        """
+        Configure Resources before running traffic
+        :param rpsn: Remote PSN (packet serial number)
+        :param rqpn: Remote QP number
+        :return: None
+        """
         self.rqpn = rqpn
         self.rpsn = rpsn
-        self.to_rts(rpsn, rqpn)
+        self.to_rts()
 
 
 class UDResources(TrafficResources):
-- 
2.21.0

