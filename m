Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF2AD547
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbfIIJHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48387 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389613AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:17 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp9028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 11/12] tests: Add XRCResources class
Date:   Mon,  9 Sep 2019 12:07:11 +0300
Message-Id: <20190909090712.11029-12-noaos@mellanox.com>
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

Add base aggregation object for XRC communication. XRCResources
contains Context, PD, MR, CQ, two XRC RECV QPs, two XRC SEND QPs, SRQ
and XRCD. XRCResources constructor has optional parameter qp_count
which decides how many QPs to create (for both types),
default value is 2.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py | 107 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/tests/base.py b/tests/base.py
index ce9ea83b6b53..dd17ddb6fc50 100755
--- a/tests/base.py
+++ b/tests/base.py
@@ -3,9 +3,13 @@
 
 import unittest
 import random
+import stat
+import os
 
-from pyverbs.qp import QPCap, QPInitAttr, QPAttr, QP
+from pyverbs.qp import QPCap, QPInitAttrEx, QPInitAttr, QPAttr, QP
 from pyverbs.addr import AHAttr, GlobalRoute
+from pyverbs.xrcd import XRCD, XRCDInitAttr
+from pyverbs.srq import SRQ, SrqInitAttrEx
 from pyverbs.device import Context
 import pyverbs.device as d
 import pyverbs.enums as e
@@ -296,4 +300,103 @@ class UDResources(TrafficResources):
 
     def pre_run(self, rpsn, rqpn):
         self.rqpn = rqpn
-        self.rpsn = rpsn
\ No newline at end of file
+        self.rpsn = rpsn
+
+
+class XRCResources(TrafficResources):
+    def __init__(self, dev_name, ib_port, gid_index, qp_count=2):
+        self.xrcd_fd = -1
+        self.xrcd = None
+        self.srq = None
+        self.qp_count = qp_count
+        self.sqp_lst = []
+        self.rqp_lst = []
+        self.qps_num = []
+        self.psns = []
+        self.rqps_num = None
+        self.rpsns = None
+        super(XRCResources, self).__init__(dev_name, ib_port, gid_index)
+
+    def close(self):
+        os.close(self.xrcd_fd)
+
+    def create_qp(self):
+        """
+        Initializes self.qp with an XRC SEND/RECV QP.
+        :return: None
+        """
+        qp_attr = QPAttr(port_num=self.ib_port)
+        qp_attr.pkey_index = 0
+
+        for _ in range(self.qp_count):
+            attr_ex = QPInitAttrEx(qp_type=e.IBV_QPT_XRC_RECV,
+                                   comp_mask=e.IBV_QP_INIT_ATTR_XRCD,
+                                   xrcd=self.xrcd)
+            qp_attr.qp_access_flags = e.IBV_ACCESS_REMOTE_WRITE | \
+                                      e.IBV_ACCESS_REMOTE_READ
+            recv_qp = QP(self.ctx, attr_ex, qp_attr)
+            self.rqp_lst.append(recv_qp)
+
+            qp_caps = QPCap(max_send_wr=self.num_msgs, max_recv_sge=0,
+                            max_recv_wr=0)
+            attr_ex = QPInitAttrEx(qp_type=e.IBV_QPT_XRC_SEND, sq_sig_all=1,
+                                   comp_mask=e.IBV_QP_INIT_ATTR_PD,
+                                   pd=self.pd, scq=self.cq, cap=qp_caps)
+            qp_attr.qp_access_flags = 0
+            send_qp =QP(self.ctx, attr_ex, qp_attr)
+            self.sqp_lst.append(send_qp)
+            self.qps_num.append((recv_qp.qp_num, send_qp.qp_num))
+            self.psns.append(random.getrandbits(24))
+
+    def create_xrcd(self):
+        """
+        Initializes self.xrcd with an XRC Domain object.
+        :return: None
+        """
+        self.xrcd_fd = os.open('/tmp/xrcd', os.O_RDONLY | os.O_CREAT,
+                                stat.S_IRUSR | stat.S_IRGRP)
+        init = XRCDInitAttr(
+            e.IBV_XRCD_INIT_ATTR_FD | e.IBV_XRCD_INIT_ATTR_OFLAGS,
+            os.O_CREAT, self.xrcd_fd)
+        self.xrcd = XRCD(self.ctx, init)
+
+    def create_srq(self):
+        """
+        Initializes self.srq with a Shared Receive QP object.
+        :return: None
+        """
+        srq_attr = SrqInitAttrEx(max_wr=self.qp_count*self.num_msgs)
+        srq_attr.srq_type = e.IBV_SRQT_XRC
+        srq_attr.pd = self.pd
+        srq_attr.xrcd = self.xrcd
+        srq_attr.cq = self.cq
+        srq_attr.comp_mask = e.IBV_SRQ_INIT_ATTR_TYPE | e.IBV_SRQ_INIT_ATTR_PD | \
+                             e.IBV_SRQ_INIT_ATTR_CQ | e.IBV_SRQ_INIT_ATTR_XRCD
+        self.srq = SRQ(self.ctx, srq_attr)
+
+    def to_rts(self):
+        ah_attr = AHAttr(dlid=self.port_attr.lid)
+        qp_attr = QPAttr()
+        qp_attr.path_mtu = PATH_MTU
+        qp_attr.timeout = TIMEOUT
+        qp_attr.retry_cnt = RETRY_CNT
+        qp_attr.rnr_retry = RNR_RETRY
+        qp_attr.min_rnr_timer = MIN_RNR_TIMER
+        qp_attr.ah_attr = ah_attr
+        for i in range(self.qp_count):
+            qp_attr.dest_qp_num = self.rqps_num[i][1]
+            qp_attr.rq_psn = self.psns[i]
+            qp_attr.sq_psn = self.rpsns[i]
+            self.rqp_lst[i].to_rts(qp_attr)
+            qp_attr.dest_qp_num = self.rqps_num[i][0]
+            self.sqp_lst[i].to_rts(qp_attr)
+
+    def init_resources(self):
+        self.create_xrcd()
+        super(XRCResources, self).init_resources()
+        self.create_srq()
+
+    def pre_run(self, rpsns, rqps_num):
+        self.rqps_num = rqps_num
+        self.rpsns = rpsns
+        self.to_rts()
-- 
2.21.0

