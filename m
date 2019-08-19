Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E5991D6E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53154 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNJ004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 07/14] tests: RCResources and UDResources classes
Date:   Mon, 19 Aug 2019 09:58:20 +0300
Message-Id: <20190819065827.26921-8-noaos@mellanox.com>
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

Add RC and UD specific aggregation objects. They provide
traffic-specific implementations for control path functions such as
modify QP.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py | 66 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/tests/base.py b/tests/base.py
index 54ebac27d522..a28e9b9dc466 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -4,9 +4,8 @@
 import unittest
 import random
 
-from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
 from pyverbs.qp import QPCap, QPInitAttr, QPAttr, QP
-from tests.utils import wc_status_to_str
+from pyverbs.addr import AHAttr, GlobalRoute
 from pyverbs.device import Context
 import pyverbs.device as d
 import pyverbs.enums as e
@@ -229,3 +228,66 @@ class TrafficResources(BaseResources):
         :return: None
         """
         raise NotImplementedError()
+
+
+class RCResources(TrafficResources):
+    PATH_MTU = e.IBV_MTU_1024
+    MAX_DEST_RD_ATOMIC = 1
+    MAX_RD_ATOMIC = 1
+    MIN_RNR_TIMER =12
+    RETRY_CNT = 7
+    RNR_RETRY = 7
+    TIMEOUT = 14
+
+    def to_rts(self, rpsn, rqpn):
+        """
+        Set the QP attributes' values to arbitrary values (same values used in
+        ibv_rc_pingpong).
+        :param rpsn: Remote PSN (packet serial number)
+        :param rqpn: Remote QP number
+        :return: None
+        """
+        attr = QPAttr(port_num=self.ib_port)
+        attr.dest_qp_num = rqpn
+        attr.path_mtu = self.PATH_MTU
+        attr.max_dest_rd_atomic = self.MAX_DEST_RD_ATOMIC
+        attr.min_rnr_timer = self.MIN_RNR_TIMER
+        attr.rq_psn = rpsn
+        attr.sq_psn = self.psn
+        attr.timeout = self.TIMEOUT
+        attr.retry_cnt = self.RETRY_CNT
+        attr.rnr_retry = self.RNR_RETRY
+        attr.max_rd_atomic = self.MAX_RD_ATOMIC
+        gr = GlobalRoute(dgid=self.ctx.query_gid(self.ib_port, self.gid_index),
+                         sgid_index=self.gid_index)
+        ah_attr = AHAttr(port_num=self.ib_port, is_global=1, gr=gr,
+                         dlid=self.port_attr.lid)
+        attr.ah_attr = ah_attr
+        self.qp.to_rts(attr)
+
+    def pre_run(self, rpsn, rqpn):
+        self.rqpn = rqpn
+        self.rpsn = rpsn
+        self.to_rts(rpsn, rqpn)
+
+
+class UDResources(TrafficResources):
+    UD_QKEY = 0x11111111
+    UD_PKEY_INDEX = 0
+
+    def create_mr(self):
+        self.mr = MR(self.pd, self.msg_size + self.GRH_SIZE,
+                     e.IBV_ACCESS_LOCAL_WRITE)
+
+    def create_qp(self):
+        qp_caps = QPCap(max_recv_wr=self.num_msgs)
+        qp_init_attr = QPInitAttr(qp_type=e.IBV_QPT_UD, cap=qp_caps,
+                                  scq=self.cq, rcq=self.cq)
+        qp_attr = QPAttr(port_num=self.ib_port)
+        qp_attr.qkey = self.UD_QKEY
+        qp_attr.pkey_index = self.UD_PKEY_INDEX
+        self.qp = QP(self.pd, qp_init_attr, qp_attr)
+
+    def pre_run(self, rpsn, rqpn):
+        self.rqpn = rqpn
+        self.rpsn = rpsn
\ No newline at end of file
-- 
2.21.0

