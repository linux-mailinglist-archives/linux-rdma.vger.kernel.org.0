Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5B91D73
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53153 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNI004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 06/14] tests: TrafficResources class
Date:   Mon, 19 Aug 2019 09:58:19 +0300
Message-Id: <20190819065827.26921-7-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Basic traffic aggregation object which contains MR, CQ and QP. It
also provides common control path functions to create these objects.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 tests/base.py  | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/utils.py | 20 ++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/tests/base.py b/tests/base.py
index e141b83dea0e..54ebac27d522 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -4,10 +4,15 @@
 import unittest
 import random
 
+from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
+from pyverbs.qp import QPCap, QPInitAttr, QPAttr, QP
+from tests.utils import wc_status_to_str
 from pyverbs.device import Context
 import pyverbs.device as d
 import pyverbs.enums as e
 from pyverbs.pd import PD
+from pyverbs.cq import CQ
+from pyverbs.mr import MR
 
 
 class PyverbsAPITestCase(unittest.TestCase):
@@ -144,3 +149,83 @@ class BaseResources(object):
         self.gid_index = gid_index
         self.pd = PD(self.ctx)
         self.ib_port = ib_port
+
+
+class TrafficResources(BaseResources):
+    """
+    Basic traffic class. It provides the basic RDMA resources and operations
+    needed for traffic.
+    """
+    def __init__(self, dev_name, ib_port, gid_index):
+        """
+        Initializes a TrafficResources object with the given values and creates
+        basic RDMA resources.
+        :param dev_name: Device name to be used
+        :param ib_port: IB port of the device to use
+        :param gid_index: Which GID index to use
+        """
+        super(TrafficResources, self).__init__(dev_name=dev_name,
+                                               ib_port=ib_port,
+                                               gid_index=gid_index)
+        self.psn = random.getrandbits(24)
+        self.msg_size = 1024
+        self.num_msgs = 1000
+        self.port_attr = None
+        self.mr = None
+        self.cq = None
+        self.qp = None
+        self.rqpn = 0
+        self.rpsn = 0
+        self.init_resources()
+
+    @property
+    def qpn(self):
+        return self.qp.qp_num
+
+    def init_resources(self):
+        """
+        Initializes a CQ, MR and an RC QP.
+        :return: None
+        """
+        self.port_attr = self.ctx.query_port(self.ib_port)
+        self.create_cq()
+        self.create_mr()
+        self.create_qp()
+
+    def create_cq(self):
+        """
+        Initializes self.cq with a CQ of depth <num_msgs> - defined by each
+        test.
+        :return: None
+        """
+        self.cq = CQ(self.ctx, self.num_msgs, None, None, 0)
+
+    def create_mr(self):
+        """
+        Initializes self.mr with an MR of length <msg_size> - defined by each
+        test.
+        :return: None
+        """
+        self.mr = MR(self.pd, self.msg_size, e.IBV_ACCESS_LOCAL_WRITE)
+
+    def create_qp(self):
+        """
+        Initializes self.qp with an RC QP.
+        :return: None
+        """
+        qp_caps = QPCap(max_recv_wr=self.num_msgs)
+        qp_init_attr = QPInitAttr(qp_type=e.IBV_QPT_RC, scq=self.cq,
+                                  rcq=self.cq, cap=qp_caps)
+        qp_attr = QPAttr(port_num=self.ib_port)
+        self.qp = QP(self.pd, qp_init_attr, qp_attr)
+
+    def pre_run(self, rpsn, rqpn):
+        """
+        Modify the QP's state to RTS and fill receive queue with <num_msgs> work
+        requests.
+        This method is not implemented in this class.
+        :param rpsn: Remote PSN
+        :param rqpn: Remote QPN
+        :return: None
+        """
+        raise NotImplementedError()
diff --git a/tests/utils.py b/tests/utils.py
index c84865a10a40..30166f41d555 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -221,3 +221,23 @@ def random_qp_init_attr_ex(attr_ex, attr, qpt=None):
     qia = QPInitAttrEx(qp_type=qpt, cap=qp_cap, sq_sig_all=sig, comp_mask=mask,
                        create_flags=cflags, max_tso_header=max_tso)
     return qia
+
+
+def wc_status_to_str(status):
+    try:
+        return \
+            {0: 'Success', 1: 'Local length error',
+             2: 'local QP operation error', 3: 'Local EEC operation error',
+             4: 'Local protection error', 5: 'WR flush error',
+             6: 'Memory window bind error', 7: 'Bad response error',
+             8: 'Local access error', 9: 'Remote invalidate request error',
+             10: 'Remote access error', 11: 'Remote operation error',
+             12: 'Retry exceeded', 13: 'RNR retry exceeded',
+             14: 'Local RDD violation error',
+             15: 'Remote invalidate RD request error',
+             16: 'Remote aort error', 17: 'Invalidate EECN error',
+             18: 'Invalidate EEC state error', 19: 'Fatal error',
+             20: 'Response timeout error', 21: 'General error'}[status]
+    except KeyError:
+        return 'Unknown WC status ({s})'.format(s=status)
+
-- 
2.21.0

