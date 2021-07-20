Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641DB3CF60C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhGTHil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:41 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:45793
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234655AbhGTHiJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:38:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEpQ6oO5i6+Wz/4jhV3Ikgf5UUrM+oNnHzn7WTg8hmvsfboth22rOLD37iWdZ+GEdEzhi1RkfuAGiNmJTNnYsP1+n7qXr+J56RqrrvoLOOQWb2DFSaa6jqmSnBXayydmZAQJNsjml44gQvCmqfFwzR2WHODSbU2v/v6ABg8cR/iUhPsmsAZJbeUig26V9JK5dXrafSImaJCOdA3ai8sSQV/jRmZlVTNWMOsmM8Y49YVIwctS48zd3UKdW72RHrs1hlgcS6UY+fwJTlVHNKQ9XRSDXwb1vD+Mei8TcAhe6B+D79Pn9DTY9+Hcncs8I88dtvHc1qP5XrQf4PjhO9EtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0bgFKOnxC0b886xY9onpE5CuZrJcKQA2WQXuW9HfzM=;
 b=GzLfpTpznk4VSG47agJWhAD//ToamWsyx9avNcJCja1kG0ujmb3wbtgqDV03jBbg6j9d4GFHn/jsjmjIS+R/2H2pyjopURJugeRwKj+Q4jiBt/uowWpz1lrQz15iqdwxsiywtN96DPBzx4B5Yv4YuWlkVTBZyrTwcP018MpGj9v4fZnr1dcXvmFVxsbHbvMOADl4n06vhFlxYPiZiMxXgAo5qK6W4jzariQaanAt+RSezhriE0ZE0qK5w5bN4l9+Z/tOcDGWzHHyhDQ0Il9weTSzl2DKnFb/Bgdnc42CwA0I9Ph6CbRXQbTI2hJXBgfKMZU+afJX5qsYaIEF9GfucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0bgFKOnxC0b886xY9onpE5CuZrJcKQA2WQXuW9HfzM=;
 b=MQrVIKr0aC3fWB82ougHTQEcuwlm29NlYpmMFEVWKJCRyrGCSAEjTyuMzlUmyomWuqFE1ZWfjvtNP2E0KXwSDSmOAZikc0cJ5yV38WHAwXnIrO4qjnasAlgv19dgPDZkB3Zz7yUxNPtqnKfhVFaCEqEp+GtLrXLONjtMWtujSY7Y2KrpJduR2nhOveeaZcIIZ3ocxuGJfdrYE8PApUjaqNpYNgbcKecaGRCFORrHWBTZHtRdrbTzTxW/zmbEox76g4wrAwRoZXzQXCFXwIuG+XoqifgLuG0l8D8bn9x4mFn9q4VnkumrNRkGyr7HGkvJ0D8A8u/NWHtyCUzXnZup4A==
Received: from BN6PR19CA0056.namprd19.prod.outlook.com (2603:10b6:404:e3::18)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:18:44 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::2b) by BN6PR19CA0056.outlook.office365.com
 (2603:10b6:404:e3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:44 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:31 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:29 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 25/27] tests: Add mlx5 DevX data path test
Date:   Tue, 20 Jul 2021 11:16:45 +0300
Message-ID: <20210720081647.1980-26-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280ca6d4-2e66-465e-b4bb-08d94b56fdad
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41516C373DF3171E7E9B7C75C3E29@CH2PR12MB4151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ax0WneYEDqSs1YyS3+1zw4zlNCFx1BqV/NfXn1pR24VUY7M7v3ELceKDZRxBb1HKXCuz4cxG8ILSRU+xreBfvr8m5FyPN0qTADW/hthxV+6xmQwIEGEwDcUG+3g9P8s5dEgRZb3IwiwHoaURyghgmxH6Ocrg9gEgL5RMdbLixVK8N2iRm+YXsQp4y4x6dLmCEZCMHYzFPZE+qnn9wXg4h7ED0yJhgDZTkCQ8p6IiRRKs/ipSHnSSmHSDOUikxAcLtE+DVNF2/IGGlMA795/GN6INGFLlPFNjwjWtTIxZ9y7MXNU2VMDa4a/CKoWbpH0lZTII6Lv6qJS7iNXOr6bRA61K9XvRfKDJan929qc28HJehh6GBNYQF52Ccmk99ErfChajOz/J0nIdSrHPrOQyNGVPoLZW1giUlhOP6LRlmrkTk7fynp+m5SRU8G+CZ/v9iTb4N7RRfxYhA0wV0lUb12BREaiDzxWendnYq7c2WO7W3toPkDGh7wVABq9z8fOXEIl9IRD+wVYI6PJLNxe7aDhTRm3G84Ax1dfQMnwO6Eyrz9rBWbolwDPV8AEqY7NCF1IsZgdiUIxW5IHotf7ESd+zRI2cauJOyRYrHoBVneOkwf4aUZWWKHxi6Z2JwhrDwDA5t247akUiCoOIG0hb8E66+bt34mW/HuxmK6kSvchNHRAkHcL7Mp+h/WICjWiVXgZX2b1oQl2As4W8zd0nkg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(107886003)(36756003)(186003)(356005)(7636003)(2616005)(8936002)(19627235002)(426003)(336012)(4326008)(8676002)(7696005)(6916009)(83380400001)(47076005)(26005)(54906003)(30864003)(82740400003)(1076003)(2906002)(82310400003)(70586007)(6666004)(316002)(5660300002)(70206006)(86362001)(36906005)(36860700001)(478600001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:44.3316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280ca6d4-2e66-465e-b4bb-08d94b56fdad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Extend the mlx5 tests' infrastructure to support mlx5 DevX objects
creation.
Add a data path test that creates all the needed resources to be able
to create an RC QP, modify it to RTS state and does SEMD_IMM traffic
over DevX objects.
The tests does validate the data including the received "immediate"
value, and checks the validity of the received CQEs.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 tests/CMakeLists.txt      |    2 +
 tests/base.py             |    1 +
 tests/mlx5_base.py        |  460 +++++++++++++++++++-
 tests/mlx5_prm_structs.py | 1046 +++++++++++++++++++++++++++++++++++++++++++++
 tests/test_mlx5_devx.py   |   23 +
 5 files changed, 1529 insertions(+), 3 deletions(-)
 create mode 100644 tests/mlx5_prm_structs.py
 create mode 100644 tests/test_mlx5_devx.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 7333f25..7b079d8 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -8,6 +8,7 @@ rdma_python_test(tests
   base_rdmacm.py
   efa_base.py
   mlx5_base.py
+  mlx5_prm_structs.py
   rdmacm_utils.py
   test_addr.py
   test_cq.py
@@ -20,6 +21,7 @@ rdma_python_test(tests
   test_fork.py
   test_mlx5_cq.py
   test_mlx5_dc.py
+  test_mlx5_devx.py
   test_mlx5_dm_ops.py
   test_mlx5_dr.py
   test_mlx5_flow.py
diff --git a/tests/base.py b/tests/base.py
index f5518d1..e9f36ab 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -30,6 +30,7 @@ PATH_MTU = e.IBV_MTU_1024
 MAX_DEST_RD_ATOMIC = 1
 NUM_OF_PROCESSES = 2
 MC_IP_PREFIX = '230'
+MAX_RDMA_ATOMIC = 20
 MAX_RD_ATOMIC = 1
 MIN_RNR_TIMER =12
 RETRY_CNT = 7
diff --git a/tests/mlx5_base.py b/tests/mlx5_base.py
index ded4bc1..47e6ebc 100644
--- a/tests/mlx5_base.py
+++ b/tests/mlx5_base.py
@@ -2,20 +2,35 @@
 # Copyright (c) 2020 NVIDIA Corporation . All rights reserved. See COPYING file
 
 import unittest
+import resource
 import random
+import struct
 import errno
+import math
+import time
 
 from pyverbs.providers.mlx5.mlx5dv import Mlx5Context, Mlx5DVContextAttr, \
-    Mlx5DVQPInitAttr, Mlx5QP, Mlx5DVDCInitAttr
+    Mlx5DVQPInitAttr, Mlx5QP, Mlx5DVDCInitAttr, Mlx5DevxObj, Mlx5UMEM, Mlx5UAR, \
+    WqeDataSeg, WqeCtrlSeg, Wqe, Mlx5Cqe64
 from tests.base import TrafficResources, set_rnr_attributes, DCT_KEY, \
-    RDMATestCase, PyverbsAPITestCase, RDMACMBaseTest
-from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsUserError
+    RDMATestCase, PyverbsAPITestCase, RDMACMBaseTest, BaseResources, PATH_MTU, \
+    RNR_RETRY, RETRY_CNT, MIN_RNR_TIMER, TIMEOUT, MAX_RDMA_ATOMIC
+from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsUserError, \
+    PyverbsError
+from pyverbs.providers.mlx5.mlx5dv_objects import Mlx5DvObj
 from pyverbs.qp import QPCap, QPInitAttrEx, QPAttr
 import pyverbs.providers.mlx5.mlx5_enums as dve
 from pyverbs.addr import AHAttr, GlobalRoute
+import pyverbs.mem_alloc as mem
+import pyverbs.dma_util as dma
 import pyverbs.device as d
+from pyverbs.pd import PD
 import pyverbs.enums as e
 from pyverbs.mr import MR
+import tests.utils
+
+MLX5_CQ_SET_CI = 0
+POLL_CQ_TIMEOUT = 5  # In seconds
 
 
 MELLANOX_VENDOR_ID = 0x02c9
@@ -155,3 +170,442 @@ class Mlx5DcResources(TrafficResources):
             if ex.error_code == errno.EOPNOTSUPP:
                 raise unittest.SkipTest(f'Create DC QP is not supported')
             raise ex
+
+
+class WqAttrs:
+    def __init__(self):
+        super().__init__()
+        self.wqe_num = 0
+        self.wqe_size = 0
+        self.wq_size = 0
+        self.head = 0
+        self.post_idx = 0
+        self.wqe_shift = 0
+        self.offset = 0
+
+    def __str__(self):
+        return str(vars(self))
+
+    def __format__(self, format_spec):
+        return str(self).__format__(format_spec)
+
+
+class CqAttrs:
+    def __init__(self):
+        super().__init__()
+        self.cons_idx = 0
+        self.cqe_size = 64
+        self.ncqes = 256
+
+    def __str__(self):
+        return str(vars(self))
+
+    def __format__(self, format_spec):
+        return str(self).__format__(format_spec)
+
+
+class QueueAttrs:
+    def __init__(self):
+        self.rq = WqAttrs()
+        self.sq = WqAttrs()
+        self.cq = CqAttrs()
+
+    def __str__(self):
+        print_format = '{}:\n\t{}\n'
+        return print_format.format('RQ Attributes', self.rq) + \
+               print_format.format('SQ Attributes', self.sq) + \
+               print_format.format('CQ Attributes', self.cq)
+
+
+class Mlx5DevxRcResources(BaseResources):
+    """
+    Creates all the DevX resources needed for a traffic-ready RC DevX QP,
+    including methods to transit the WQs into RTS state.
+    It also includes traffic methods for post send/receive and poll.
+    The class currently supports post send with immediate, but can be
+    easily extended to support other opcodes in the future.
+    """
+    def __init__(self, dev_name, ib_port, gid_index, msg_size=1024):
+        super().__init__(dev_name, ib_port, gid_index)
+        self.umems = {}
+        self.msg_size = msg_size
+        self.num_msgs = 1000
+        self.imm = 0x03020100
+        self.uar = {}
+        self.max_recv_sge = 1
+        self.eqn = None
+        self.pd = None
+        self.dv_pd = None
+        self.mr = None
+        self.cq = None
+        self.qp = None
+        self.qpn = None
+        self.psn = None
+        self.lid = None
+        self.gid = [0, 0, 0, 0]
+        # Remote attrs
+        self.rqpn = None
+        self.rpsn = None
+        self.rlid = None
+        self.rgid = [0, 0, 0, 0]
+        self.rmac = None
+        self.devx_objs = []
+        self.qattr = QueueAttrs()
+        self.init_resources()
+
+    def init_resources(self):
+        if not self.is_eth():
+            self.query_lid()
+        else:
+            self.query_gid()
+        self.create_pd()
+        self.create_mr()
+        self.query_eqn()
+        self.create_uar()
+        self.create_queue_attrs()
+        self.create_cq()
+        self.create_qp()
+        # Objects closure order is important, and must be done manually in DevX
+        self.devx_objs = [self.qp, self.cq] + list(self.uar.values()) + list(self.umems.values())
+
+    def query_lid(self):
+        from tests.mlx5_prm_structs import QueryHcaVportContextIn, \
+            QueryHcaVportContextOut, QueryHcaCapIn, QueryCmdHcaCapOut
+
+        query_cap_in = QueryHcaCapIn(op_mod=0x1)
+        query_cap_out = QueryCmdHcaCapOut(self.ctx.devx_general_cmd(
+            query_cap_in, len(QueryCmdHcaCapOut())))
+        if query_cap_out.status:
+            raise PyverbsRDMAError('Failed to query general HCA CAPs with syndrome '
+                                   f'({query_port_out.syndrome}')
+        port_num = self.ib_port if query_cap_out.capability.num_ports >= 2 else 0
+        query_port_in = QueryHcaVportContextIn(port_num=port_num)
+        query_port_out = QueryHcaVportContextOut(self.ctx.devx_general_cmd(
+            query_port_in, len(QueryHcaVportContextOut())))
+        if query_port_out.status:
+            raise PyverbsRDMAError('Failed to query vport with syndrome '
+                                   f'({query_port_out.syndrome})')
+        self.lid = query_port_out.hca_vport_context.lid
+
+    def query_gid(self):
+        gid = self.ctx.query_gid(self.ib_port, self.gid_index).gid.split(':')
+        for i in range(0, len(gid), 2):
+            self.gid[int(i/2)] = int(gid[i] + gid[i+1], 16)
+
+    def is_eth(self):
+        from tests.mlx5_prm_structs import QueryHcaCapIn, \
+            QueryCmdHcaCapOut
+
+        query_cap_in = QueryHcaCapIn(op_mod=0x1)
+        query_cap_out = QueryCmdHcaCapOut(self.ctx.devx_general_cmd(
+            query_cap_in, len(QueryCmdHcaCapOut())))
+        if query_cap_out.status:
+            raise PyverbsRDMAError('Failed to query general HCA CAPs with syndrome '
+                                   f'({query_port_out.syndrome})')
+        return query_cap_out.capability.port_type  # 0:IB, 1:ETH
+
+    @staticmethod
+    def roundup_pow_of_two(val):
+        return pow(2, math.ceil(math.log2(val)))
+
+    def create_queue_attrs(self):
+        # RQ calculations
+        wqe_size = WqeDataSeg.sizeof() * self.max_recv_sge
+        self.qattr.rq.wqe_size = self.roundup_pow_of_two(wqe_size)
+        max_recv_wr = self.roundup_pow_of_two(self.num_msgs)
+        self.qattr.rq.wq_size = max(self.qattr.rq.wqe_size * max_recv_wr,
+                                    dve.MLX5_SEND_WQE_BB)
+        self.qattr.rq.wqe_num = math.ceil(self.qattr.rq.wq_size / self.qattr.rq.wqe_size)
+        self.qattr.rq.wqe_shift = int(math.log2(self.qattr.rq.wqe_size - 1)) + 1
+
+        # SQ calculations
+        self.qattr.sq.offset = self.qattr.rq.wq_size
+        # 192 = max overhead size of all structs needed for all operations in RC
+        wqe_size = 192 + WqeDataSeg.sizeof()
+        # Align wqe size to MLX5_SEND_WQE_BB
+        self.qattr.sq.wqe_size = (wqe_size + dve.MLX5_SEND_WQE_BB - 1) & ~(dve.MLX5_SEND_WQE_BB - 1)
+        self.qattr.sq.wq_size = self.roundup_pow_of_two(self.qattr.sq.wqe_size * self.num_msgs)
+        self.qattr.sq.wqe_num = math.ceil(self.qattr.sq.wq_size / dve.MLX5_SEND_WQE_BB)
+        self.qattr.sq.wqe_shift = int(math.log2(dve.MLX5_SEND_WQE_BB))
+
+    def create_context(self):
+        try:
+            attr = Mlx5DVContextAttr(dve.MLX5DV_CONTEXT_FLAGS_DEVX)
+            self.ctx = Mlx5Context(attr, self.dev_name)
+        except PyverbsUserError as ex:
+            raise unittest.SkipTest(f'Could not open mlx5 context ({ex})')
+        except PyverbsRDMAError:
+            raise unittest.SkipTest('Opening mlx5 DevX context is not supported')
+
+    def create_pd(self):
+        self.pd = PD(self.ctx)
+        self.dv_pd = Mlx5DvObj(dve.MLX5DV_OBJ_PD, pd=self.pd).dvpd
+
+    def create_mr(self):
+        access = e.IBV_ACCESS_REMOTE_WRITE | e.IBV_ACCESS_LOCAL_WRITE | \
+                 e.IBV_ACCESS_REMOTE_READ
+        self.mr = MR(self.pd, self.msg_size, access)
+
+    def create_umem(self, size,
+                    access=e.IBV_ACCESS_LOCAL_WRITE,
+                    alignment=resource.getpagesize()):
+        return Mlx5UMEM(self.ctx, size=size, alignment=alignment, access=access)
+
+    def create_uar(self):
+        self.uar['qp'] = Mlx5UAR(self.ctx, dve._MLX5DV_UAR_ALLOC_TYPE_NC)
+        self.uar['cq'] = Mlx5UAR(self.ctx, dve._MLX5DV_UAR_ALLOC_TYPE_NC)
+        if not self.uar['cq'].page_id or not self.uar['qp'].page_id:
+            raise PyverbsRDMAError('Failed to allocate UAR')
+
+    def query_eqn(self):
+        self.eqn = self.ctx.devx_query_eqn(0)
+
+    def create_cq(self):
+        from tests.mlx5_prm_structs import CreateCqIn, SwCqc, CreateCqOut
+
+        cq_size = self.roundup_pow_of_two(self.qattr.cq.cqe_size * self.qattr.cq.ncqes)
+        # Align to page size
+        pg_size = resource.getpagesize()
+        cq_size = (cq_size + pg_size - 1) & ~(pg_size - 1)
+        self.umems['cq'] = self.create_umem(size=cq_size)
+        self.umems['cq_dbr'] = self.create_umem(size=8, alignment=8)
+        log_cq_size = math.ceil(math.log2(self.qattr.cq.ncqes))
+        cmd_in = CreateCqIn(cq_umem_valid=1, cq_umem_id=self.umems['cq'].umem_id,
+                            sw_cqc=SwCqc(c_eqn=self.eqn, uar_page=self.uar['cq'].page_id,
+                                         log_cq_size=log_cq_size, dbr_umem_valid=1,
+                                         dbr_umem_id=self.umems['cq_dbr'].umem_id))
+        self.cq = Mlx5DevxObj(self.ctx, cmd_in, len(CreateCqOut()))
+
+    def create_qp(self):
+        self.psn = random.getrandbits(24)
+        from tests.mlx5_prm_structs import SwQpc, CreateQpIn, DevxOps,\
+            CreateQpOut, CreateCqOut
+
+        self.psn = random.getrandbits(24)
+        qp_size = self.roundup_pow_of_two(self.qattr.rq.wq_size + self.qattr.sq.wq_size)
+        # Align to page size
+        pg_size = resource.getpagesize()
+        qp_size = (qp_size + pg_size - 1) & ~(pg_size - 1)
+        self.umems['qp'] = self.create_umem(size=qp_size)
+        self.umems['qp_dbr'] = self.create_umem(size=8, alignment=8)
+        log_rq_size = int(math.log2(self.qattr.rq.wqe_num - 1)) + 1
+        # Size of a receive WQE is 16*pow(2, log_rq_stride)
+        log_rq_stride = self.qattr.rq.wqe_shift - 4
+        log_sq_size = int(math.log2(self.qattr.sq.wqe_num - 1)) + 1
+        cqn = CreateCqOut(self.cq.out_view).cqn
+        qpc = SwQpc(st=DevxOps.MLX5_QPC_ST_RC, pd=self.dv_pd.pdn,
+                    pm_state=DevxOps.MLX5_QPC_PM_STATE_MIGRATED,
+                    log_rq_size=log_rq_size, log_sq_size=log_sq_size, ts_format=0x1,
+                    log_rq_stride=log_rq_stride, uar_page=self.uar['qp'].page_id,
+                    cqn_snd=cqn, cqn_rcv=cqn, dbr_umem_id=self.umems['qp_dbr'].umem_id,
+                    dbr_umem_valid=1)
+        cmd_in = CreateQpIn(sw_qpc=qpc, wq_umem_id=self.umems['qp'].umem_id,
+                            wq_umem_valid=1)
+        self.qp = Mlx5DevxObj(self.ctx, cmd_in, len(CreateQpOut()))
+        self.qpn = CreateQpOut(self.qp.out_view).qpn
+
+    def to_rts(self):
+        """
+        Moves the created QP to RTS state by modifying it using DevX through all
+        the needed states with all the required attributes.
+        rlid, rpsn, rqpn and rgid (when valid) must be already updated before
+        calling this method.
+        """
+        from tests.mlx5_prm_structs import DevxOps, ModifyQpIn, ModifyQpOut,\
+            CreateQpOut, SwQpc
+        cmd_out_len = len(ModifyQpOut())
+
+        # RST2INIT
+        qpn = CreateQpOut(self.qp.out_view).qpn
+        swqpc = SwQpc(rre=1, rwe=1)
+        swqpc.primary_address_path.vhca_port_num = self.ib_port
+        cmd_in = ModifyQpIn(opcode=DevxOps.MLX5_CMD_OP_RST2INIT_QP, qpn=qpn,
+                            sw_qpc=swqpc)
+        self.qp.modify(cmd_in, cmd_out_len)
+
+        # INIT2RTR
+        swqpc = SwQpc(mtu=PATH_MTU, log_msg_max=20, remote_qpn=self.rqpn,
+                      min_rnr_nak=MIN_RNR_TIMER, next_rcv_psn=self.rpsn)
+        swqpc.primary_address_path.vhca_port_num = self.ib_port
+        swqpc.primary_address_path.rlid = self.rlid
+        if self.is_eth():
+            # GID field is a must for Eth (or if GRH is set in IB)
+            swqpc.primary_address_path.rgid_rip = self.rgid
+            swqpc.primary_address_path.rmac = self.rmac
+            swqpc.primary_address_path.src_addr_index = self.gid_index
+            swqpc.primary_address_path.hop_limit = tests.utils.PacketConsts.TTL_HOP_LIMIT
+            # UDP sport must be reserved for roce v1 and v1.5
+            if self.ctx.query_gid_type(self.ib_port, self.gid_index) == e.IBV_GID_TYPE_SYSFS_ROCE_V2:
+                swqpc.primary_address_path.udp_sport = 0xdcba
+        else:
+            swqpc.primary_address_path.rlid = self.rlid
+        cmd_in = ModifyQpIn(opcode=DevxOps.MLX5_CMD_OP_INIT2RTR_QP, qpn=qpn,
+                            sw_qpc=swqpc)
+        self.qp.modify(cmd_in, cmd_out_len)
+
+        # RTR2RTS
+        swqpc = SwQpc(retry_count=RETRY_CNT, rnr_retry=RNR_RETRY,
+                      next_send_psn=self.psn, log_sra_max=MAX_RDMA_ATOMIC)
+        swqpc.primary_address_path.vhca_port_num = self.ib_port
+        swqpc.primary_address_path.ack_timeout = TIMEOUT
+        cmd_in = ModifyQpIn(opcode=DevxOps.MLX5_CMD_OP_RTR2RTS_QP, qpn=qpn,
+                            sw_qpc=swqpc)
+        self.qp.modify(cmd_in, cmd_out_len)
+
+    def pre_run(self, rpsn, rqpn, rgid=0, rlid=0, rmac=0):
+        """
+        Configure Resources before running traffic
+        :param rpsns: Remote PSN (packet serial number)
+        :param rqpn: Remote QP number
+        :param rgid: Remote GID
+        :param rlid: Remote LID
+        :param rmac: Remote MAC (valid for RoCE)
+        :return: None
+        """
+        self.rpsn = rpsn
+        self.rqpn = rqpn
+        self.rgid = rgid
+        self.rlid = rlid
+        self.rmac = rmac
+        self.to_rts()
+
+    def post_send(self):
+        """
+        Posts one send WQE to the SQ by doing all the required work such as
+        building the control/data segments, updating and ringing the dbr,
+        updating the producer indexes, etc.
+        """
+        idx = self.qattr.sq.post_idx if self.qattr.sq.post_idx < self.qattr.sq.wqe_num else 0
+        buf_offset = self.qattr.sq.offset + (idx << dve.MLX5_SEND_WQE_SHIFT)
+        # Prepare WQE
+        imm_be32 = struct.unpack("<I", struct.pack(">I", self.imm + self.qattr.sq.post_idx))[0]
+        ctrl_seg = WqeCtrlSeg(imm=imm_be32, fm_ce_se=dve.MLX5_WQE_CTRL_CQ_UPDATE)
+        data_seg = WqeDataSeg(self.mr.length, self.mr.lkey, self.mr.buf)
+        ctrl_seg.opmod_idx_opcode = (self.qattr.sq.post_idx & 0xffff) << 8 | dve.MLX5_OPCODE_SEND_IMM
+        size_in_octowords = int((ctrl_seg.sizeof() +  data_seg.sizeof()) / 16)
+        ctrl_seg.qpn_ds = self.qpn << 8 | size_in_octowords
+        Wqe([ctrl_seg, data_seg], self.umems['qp'].umem_addr + buf_offset)
+        self.qattr.sq.post_idx += int((size_in_octowords * 16 +
+                                       dve.MLX5_SEND_WQE_BB - 1) / dve.MLX5_SEND_WQE_BB)
+        # Make sure descriptors are written
+        dma.udma_to_dev_barrier()
+        # Update the doorbell record
+        mem.writebe32(self.umems['qp_dbr'].umem_addr,
+                      self.qattr.sq.post_idx & 0xffff, dve.MLX5_SND_DBR)
+        dma.udma_to_dev_barrier()
+        # Ring the doorbell and post the WQE
+        dma.mmio_write64_as_be(self.uar['qp'].reg_addr, mem.read64(ctrl_seg.addr))
+
+    def post_recv(self):
+        """
+        Posts one receive WQE to the RQ by doing all the required work such as
+        building the control/data segments, updating the dbr and the producer
+        indexes.
+        """
+        buf_offset = self.qattr.rq.offset + self.qattr.rq.wqe_size * self.qattr.rq.head
+        # Prepare WQE
+        data_seg = WqeDataSeg(self.mr.length, self.mr.lkey, self.mr.buf)
+        Wqe([data_seg], self.umems['qp'].umem_addr + buf_offset)
+        # Update indexes
+        self.qattr.rq.post_idx += 1
+        self.qattr.rq.head = self.qattr.rq.head + 1 if self.qattr.rq.head + 1 < self.qattr.rq.wqe_num else 0
+        # Update the doorbell record
+        dma.udma_to_dev_barrier()
+        mem.writebe32(self.umems['qp_dbr'].umem_addr,
+                      self.qattr.rq.post_idx & 0xffff, dve.MLX5_RCV_DBR)
+
+    def poll_cq(self):
+        """
+        Polls the CQ once and updates the consumer index upon success.
+        The CQE opcode and owner bit are checked and verified.
+        This method does busy-waiting as long as it gets an empty CQE, until a
+        timeout of POLL_CQ_TIMEOUT seconds.
+        """
+        idx = self.qattr.cq.cons_idx % self.qattr.cq.ncqes
+        cq_owner_flip = not(not(self.qattr.cq.cons_idx & self.qattr.cq.ncqes))
+        cqe_start_addr = self.umems['cq'].umem_addr + (idx * self.qattr.cq.cqe_size)
+        cqe = None
+        start_poll_t = time.perf_counter()
+        while cqe is None:
+            cqe = Mlx5Cqe64(cqe_start_addr)
+            if (cqe.opcode == dve.MLX5_CQE_INVALID) or \
+                    (cqe.owner ^ cq_owner_flip) or cqe.is_empty():
+                if time.perf_counter() - start_poll_t >= POLL_CQ_TIMEOUT:
+                    raise PyverbsRDMAError(f'CQE #{self.qattr.cq.cons_idx} '
+                                           f'is empty or invalid:\n{cqe.dump()}')
+                cqe = None
+
+        # After CQE ownership check, must do memory barrier and re-read the CQE.
+        dma.udma_from_dev_barrier()
+        cqe = Mlx5Cqe64(cqe_start_addr)
+
+        if cqe.opcode == dve.MLX5_CQE_RESP_ERR:
+            raise PyverbsRDMAError(f'Got a CQE #{self.qattr.cq.cons_idx} '
+                                   f'with responder error:\n{cqe.dump()}')
+        elif cqe.opcode == dve.MLX5_CQE_REQ_ERR:
+            raise PyverbsRDMAError(f'Got a CQE #{self.qattr.cq.cons_idx} '
+                                   f'with requester error:\n{cqe.dump()}')
+
+        self.qattr.cq.cons_idx += 1
+        mem.writebe32(self.umems['cq_dbr'].umem_addr,
+                      self.qattr.cq.cons_idx & 0xffffff, MLX5_CQ_SET_CI)
+        return cqe
+
+    def close_resources(self):
+        for obj in self.devx_objs:
+            if obj:
+                obj.close()
+
+
+class Mlx5DevxTrafficBase(Mlx5RDMATestCase):
+    """
+    A base class for mlx5 DevX traffic tests.
+    This class does not include any tests, but provides quick players (client,
+    server) creation and provides a traffic method.
+    """
+    def tearDown(self):
+        if self.server:
+            self.server.close_resources()
+        if self.client:
+            self.client.close_resources()
+        super().tearDown()
+
+    def create_players(self, resources, **resource_arg):
+        """
+        Initialize tests resources.
+        :param resources: The RDMA resources to use.
+        :param resource_arg: Dictionary of args that specify the resources
+                             specific attributes.
+        :return: None
+        """
+        self.server = resources(**self.dev_info, **resource_arg)
+        self.client = resources(**self.dev_info, **resource_arg)
+        self.pre_run()
+
+    def pre_run(self):
+        self.server.pre_run(self.client.psn, self.client.qpn, self.client.gid,
+                            self.client.lid, self.mac_addr)
+        self.client.pre_run(self.server.psn, self.server.qpn, self.server.gid,
+                            self.server.lid, self.mac_addr)
+
+    def send_imm_traffic(self):
+        self.client.mr.write('c' * self.client.msg_size, self.client.msg_size)
+        for _ in range(self.client.num_msgs):
+            cons_idx = self.client.qattr.cq.cons_idx
+            self.server.post_recv()
+            self.client.post_send()
+            # Poll client and verify received cqe opcode
+            send_cqe = self.client.poll_cq()
+            self.assertEqual(send_cqe.opcode, dve.MLX5_CQE_REQ,
+                             'Unexpected CQE opcode')
+            # Poll server and verify received cqe opcode
+            recv_cqe = self.server.poll_cq()
+            self.assertEqual(recv_cqe.opcode, dve.MLX5_CQE_RESP_SEND_IMM,
+                             'Unexpected CQE opcode')
+            msg_received = self.server.mr.read(self.server.msg_size, 0)
+            # Validate data (of received message and immediate value)
+            tests.utils.validate(msg_received, True, self.server.msg_size)
+            self.assertEqual(recv_cqe.imm_inval_pkey,
+                             self.client.imm + cons_idx)
+            self.server.mr.write('s' * self.server.msg_size,
+                                 self.server.msg_size)
diff --git a/tests/mlx5_prm_structs.py b/tests/mlx5_prm_structs.py
new file mode 100644
index 0000000..1999a3b
--- /dev/null
+++ b/tests/mlx5_prm_structs.py
@@ -0,0 +1,1046 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia Inc. All rights reserved. See COPYING file
+
+"""
+This module provides scapy based classes that represent the mlx5 PRM structs.
+"""
+import unittest
+
+try:
+    import logging
+    logging.getLogger("scapy.runtime").setLevel(logging.ERROR)
+    from scapy.packet import Packet
+    from scapy.fields import BitField, ByteField, IntField, \
+        ShortField, LongField, StrFixedLenField, PacketField, \
+        PacketListField, ConditionalField, PadField, FieldListField, MACField
+except ImportError:
+    raise unittest.SkipTest('scapy package is needed in order to run DevX tests')
+
+
+class DevxOps:
+    MLX5_CMD_OP_ALLOC_PD = 0x800
+    MLX5_CMD_OP_CREATE_CQ = 0x400
+    MLX5_CMD_OP_QUERY_CQ = 0x402
+    MLX5_CMD_OP_MODIFY_CQ = 0x403
+    MLX5_CMD_OP_CREATE_QP = 0x500
+    MLX5_CMD_OP_QUERY_QP = 0x50b
+    MLX5_CMD_OP_RST2INIT_QP = 0x502
+    MLX5_CMD_OP_INIT2RTR_QP = 0x503
+    MLX5_CMD_OP_RTR2RTS_QP = 0x504
+    MLX5_CMD_OP_RTS2RTS_QP = 0x505
+    MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT = 0x762
+    MLX5_CMD_OP_QUERY_HCA_VPORT_GID = 0x764
+    MLX5_QPC_ST_RC = 0X0
+    MLX5_QPC_PM_STATE_MIGRATED = 0x3
+    MLX5_CMD_OP_QUERY_HCA_CAP = 0x100
+
+
+# Common
+class SwPas(Packet):
+    fields_desc = [
+        IntField('pa_h', 0),
+        BitField('pa_l', 0, 20),
+        BitField('reserved1', 0, 12),
+    ]
+
+
+# PD
+class AllocPdIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_ALLOC_PD),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        StrFixedLenField('reserved2', None, length=8),
+    ]
+
+
+class AllocPdOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        ByteField('reserved2', 0),
+        BitField('pd', 0, 24),
+        StrFixedLenField('reserved3', None, length=4),
+    ]
+
+
+# CQ
+class CmdInputFieldSelectResizeCq(Packet):
+    fields_desc = [
+        BitField('reserved1', 0, 28),
+        BitField('umem', 0, 1),
+        BitField('log_page_size', 0, 1),
+        BitField('page_offset', 0, 1),
+        BitField('log_cq_size', 0, 1),
+    ]
+
+
+class CmdInputFieldSelectModifyCqFields(Packet):
+    fields_desc = [
+        BitField('reserved_0', 0, 26),
+        BitField('status', 0, 1),
+        BitField('cq_period_mode', 0, 1),
+        BitField('c_eqn', 0, 1),
+        BitField('oi', 0, 1),
+        BitField('cq_max_count', 0, 1),
+        BitField('cq_period', 0, 1),
+    ]
+
+
+class SwCqc(Packet):
+    fields_desc = [
+        BitField('status', 0, 4),
+        BitField('as_notify', 0, 1),
+        BitField('initiator_src_dct', 0, 1),
+        BitField('dbr_umem_valid', 0, 1),
+        BitField('reserved1', 0, 1),
+        BitField('cqe_sz', 0, 3),
+        BitField('cc', 0, 1),
+        BitField('reserved2', 0, 1),
+        BitField('scqe_break_moderation_en', 0, 1),
+        BitField('oi', 0, 1),
+        BitField('cq_period_mode', 0, 2),
+        BitField('cqe_compression_en', 0, 1),
+        BitField('mini_cqe_res_format', 0, 2),
+        BitField('st', 0, 4),
+        ByteField('reserved3', 0),
+        IntField('dbr_umem_id', 0),
+        BitField('reserved4', 0, 20),
+        BitField('page_offset', 0, 6),
+        BitField('reserved5', 0, 6),
+        BitField('reserved6', 0, 3),
+        BitField('log_cq_size', 0, 5),
+        BitField('uar_page', 0, 24),
+        BitField('reserved7', 0, 4),
+        BitField('cq_period', 0, 12),
+        ShortField('cq_max_count', 0),
+        BitField('reserved8', 0, 24),
+        ByteField('c_eqn', 0),
+        BitField('reserved9', 0, 3),
+        BitField('log_page_size', 0, 5),
+        BitField('reserved10', 0, 24),
+        StrFixedLenField('reserved11', None, length=4),
+        ByteField('reserved12', 0),
+        BitField('last_notified_index', 0, 24),
+        ByteField('reserved13', 0),
+        BitField('last_solicit_index', 0, 24),
+        ByteField('reserved14', 0),
+        BitField('consumer_counter', 0, 24),
+        ByteField('reserved15', 0),
+        BitField('producer_counter', 0, 24),
+        BitField('local_partition_id', 0, 12),
+        BitField('process_id', 0, 20),
+        ShortField('reserved16', 0),
+        ShortField('thread_id', 0),
+        IntField('db_record_addr_63_32', 0),
+        BitField('db_record_addr_31_3', 0, 29),
+        BitField('reserved17', 0, 3),
+    ]
+
+
+class CreateCqIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_CREATE_CQ),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        ByteField('reserved2', 0),
+        BitField('cqn', 0, 24),
+        StrFixedLenField('reserved3', None, length=4),
+        PacketField('sw_cqc', SwCqc(), SwCqc),
+        LongField('e_mtt_pointer_or_cq_umem_offset', 0),
+        IntField('cq_umem_id', 0),
+        BitField('cq_umem_valid', 0, 1),
+        BitField('reserved4', 0, 31),
+        StrFixedLenField('reserved5', None, length=176),
+        PacketListField('pas', [SwPas() for x in range(0)], SwPas, count_from=lambda pkt: 0),
+    ]
+
+
+class CreateCqOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        ByteField('reserved2', 0),
+        BitField('cqn', 0, 24),
+        StrFixedLenField('reserved3', None, length=4),
+    ]
+
+
+# QP
+class SwAds(Packet):
+    fields_desc = [
+        BitField('fl', 0, 1),
+        BitField('free_ar', 0, 1),
+        BitField('reserved1', 0, 14),
+        ShortField('pkey_index', 0),
+        ByteField('reserved2', 0),
+        BitField('grh', 0, 1),
+        BitField('mlid', 0, 7),
+        ShortField('rlid', 0),
+        BitField('ack_timeout', 0, 5),
+        BitField('reserved3', 0, 3),
+        ByteField('src_addr_index', 0),
+        BitField('log_rtm', 0, 4),
+        BitField('stat_rate', 0, 4),
+        ByteField('hop_limit', 0),
+        BitField('reserved4', 0, 4),
+        BitField('tclass', 0, 8),
+        BitField('flow_label', 0, 20),
+        FieldListField('rgid_rip', [0 for x in range(4)], IntField('', 0),
+                       count_from=lambda pkt: 4),
+        BitField('reserved5', 0, 4),
+        BitField('f_dscp', 0, 1),
+        BitField('f_ecn', 0, 1),
+        BitField('reserved6', 0, 1),
+        BitField('f_eth_prio', 0, 1),
+        BitField('ecn', 0, 2),
+        BitField('dscp', 0, 6),
+        ShortField('udp_sport', 0),
+        BitField('dei_cfi_reserved_from_prm_041', 0, 1),
+        BitField('eth_prio', 0, 3),
+        BitField('sl', 0, 4),
+        ByteField('vhca_port_num', 0),
+        MACField('rmac', '00:00:00:00:00:00'),
+
+    ]
+
+
+class SwQpc(Packet):
+    fields_desc = [
+        BitField('state', 0, 4),
+        BitField('lag_tx_port_affinity', 0, 4),
+        ByteField('st', 0),
+        BitField('reserved1', 0, 3),
+        BitField('pm_state', 0, 2),
+        BitField('reserved2', 0, 1),
+        BitField('req_e2e_credit_mode', 0, 2),
+        BitField('offload_type', 0, 4),
+        BitField('end_padding_mode', 0, 2),
+        BitField('reserved3', 0, 2),
+        BitField('wq_signature', 0, 1),
+        BitField('block_lb_mc', 0, 1),
+        BitField('atomic_like_write_en', 0, 1),
+        BitField('latency_sensitive', 0, 1),
+        BitField('dual_write', 0, 1),
+        BitField('drain_sigerr', 0, 1),
+        BitField('multi_path', 0, 1),
+        BitField('reserved4', 0, 1),
+        BitField('pd', 0, 24),
+        BitField('mtu', 0, 3),
+        BitField('log_msg_max', 0, 5),
+        BitField('reserved5', 0, 1),
+        BitField('log_rq_size', 0, 4),
+        BitField('log_rq_stride', 0, 3),
+        BitField('no_sq', 0, 1),
+        BitField('log_sq_size', 0, 4),
+        BitField('reserved6', 0, 1),
+        BitField('retry_mode', 0, 2),
+        BitField('ts_format', 0, 2),
+        BitField('data_in_order', 0, 1),
+        BitField('rlkey', 0, 1),
+        BitField('ulp_stateless_offload_mode', 0, 4),
+        ByteField('counter_set_id', 0),
+        BitField('uar_page', 0, 24),
+        BitField('reserved7', 0, 3),
+        BitField('full_handshake', 0, 1),
+        BitField('cnak_reverse_sl', 0, 4),
+        BitField('user_index', 0, 24),
+        BitField('reserved8', 0, 3),
+        BitField('log_page_size', 0, 5),
+        BitField('remote_qpn', 0, 24),
+        PacketField('primary_address_path', SwAds(), SwAds),
+        PacketField('secondary_address_path', SwAds(), SwAds),
+        BitField('log_ack_req_freq', 0, 4),
+        BitField('reserved9', 0, 4),
+        BitField('log_sra_max', 0, 3),
+        BitField('extended_rnr_retry_valid', 0, 1),
+        BitField('reserved10', 0, 1),
+        BitField('retry_count', 0, 3),
+        BitField('rnr_retry', 0, 3),
+        BitField('extended_retry_count_valid', 0, 1),
+        BitField('fre', 0, 1),
+        BitField('cur_rnr_retry', 0, 3),
+        BitField('cur_retry_count', 0, 3),
+        BitField('extended_log_rnr_retry', 0, 5),
+        ShortField('extended_cur_rnr_retry', 0),
+        ShortField('packet_pacing_rate_limit_index', 0),
+        ByteField('reserved11', 0),
+        BitField('next_send_psn', 0, 24),
+        ByteField('reserved12', 0),
+        BitField('cqn_snd', 0, 24),
+        ByteField('reserved13', 0),
+        BitField('deth_sqpn', 0, 24),
+        ByteField('reserved14', 0),
+        ByteField('extended_retry_count', 0),
+        ByteField('reserved15', 0),
+        ByteField('extended_cur_retry_count', 0),
+        ByteField('reserved16', 0),
+        BitField('last_acked_psn', 0, 24),
+        ByteField('reserved17', 0),
+        BitField('ssn', 0, 24),
+        ByteField('reserved18', 0),
+        BitField('log_rra_max', 0, 3),
+        BitField('reserved19', 0, 1),
+        BitField('atomic_mode', 0, 4),
+        BitField('rre', 0, 1),
+        BitField('rwe', 0, 1),
+        BitField('rae', 0, 1),
+        BitField('reserved20', 0, 1),
+        BitField('page_offset', 0, 6),
+        BitField('reserved21', 0, 3),
+        BitField('cd_slave_receive', 0, 1),
+        BitField('cd_slave_send', 0, 1),
+        BitField('cd_master', 0, 1),
+        BitField('reserved22', 0, 3),
+        BitField('min_rnr_nak', 0, 5),
+        BitField('next_rcv_psn', 0, 24),
+        ByteField('reserved23', 0),
+        BitField('xrcd', 0, 24),
+        ByteField('reserved24', 0),
+        BitField('cqn_rcv', 0, 24),
+        LongField('dbr_addr', 0),
+        IntField('q_key', 0),
+        BitField('reserved25', 0, 5),
+        BitField('rq_type', 0, 3),
+        BitField('srqn_rmpn_xrqn', 0, 24),
+        ByteField('reserved26', 0),
+        BitField('rmsn', 0, 24),
+        ShortField('hw_sq_wqebb_counter', 0),
+        ShortField('sw_sq_wqebb_counter', 0),
+        IntField('hw_rq_counter', 0),
+        IntField('sw_rq_counter', 0),
+        ByteField('reserved27', 0),
+        BitField('roce_adp_retrans_rtt', 0, 24),
+        BitField('reserved28', 0, 15),
+        BitField('cgs', 0, 1),
+        ByteField('cs_req', 0),
+        ByteField('cs_res', 0),
+        LongField('dc_access_key', 0),
+        BitField('rdma_active', 0, 1),
+        BitField('comm_est', 0, 1),
+        BitField('suspended', 0, 1),
+        BitField('dbr_umem_valid', 0, 1),
+        BitField('reserved29', 0, 4),
+        BitField('send_msg_psn', 0, 24),
+        ByteField('reserved30', 0),
+        BitField('rcv_msg_psn', 0, 24),
+        LongField('rdma_va', 0),
+        IntField('rdma_key', 0),
+        IntField('dbr_umem_id', 0),
+    ]
+
+
+class CreateQpIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_CREATE_QP),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        ByteField('reserved2', 0),
+        BitField('input_qpn', 0, 24),
+        BitField('reserved3', 0, 1),
+        BitField('cmd_on_behalf', 0, 1),
+        BitField('reserved4', 0, 14),
+        ShortField('vhca_id', 0),
+        IntField('opt_param_mask', 0),
+        StrFixedLenField('reserved5', None, length=4),
+        PacketField('sw_qpc', SwQpc(), SwQpc),
+        LongField('e_mtt_pointer_or_wq_umem_offset', 0),
+        IntField('wq_umem_id', 0),
+        BitField('wq_umem_valid', 0, 1),
+        BitField('reserved6', 0, 31),
+        PacketListField('pas', [SwPas() for x in range(0)], SwPas,
+                        count_from=lambda pkt: 0),
+    ]
+
+
+class CreateQpOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        ByteField('reserved2', 0),
+        BitField('qpn', 0, 24),
+        StrFixedLenField('reserved3', None, length=4),
+    ]
+
+
+class ModifyQpIn(Packet):
+    fields_desc = [
+        ShortField('opcode', 0),
+        ShortField('uid', 0),
+        ShortField('vhca_tunnel_id', 0),
+        ShortField('op_mod', 0),
+        ByteField('reserved2', 0),
+        BitField('qpn', 0, 24),
+        IntField('reserved3', 0),
+        IntField('opt_param_mask', 0),
+        IntField('ece', 0),
+        PacketField('sw_qpc', SwQpc(), SwQpc),
+        StrFixedLenField('reserved4', None, length=16),
+    ]
+
+
+class ModifyQpOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        StrFixedLenField('reserved2', None, length=8),
+    ]
+
+
+class QueryQpIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_QUERY_QP),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        ByteField('reserved2', 0),
+        BitField('qpn', 0, 24),
+        StrFixedLenField('reserved3', None, length=4),
+    ]
+
+
+class QueryQpOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        StrFixedLenField('reserved2', None, length=8),
+        IntField('opt_param_mask', 0),
+        StrFixedLenField('reserved3', None, length=4),
+        PacketField('sw_qpc', SwQpc(), SwQpc),
+        LongField('e_mtt_pointer', 0),
+        StrFixedLenField('reserved4', None, length=8),
+        PacketListField('pas', [SwPas() for x in range(0)], SwPas,
+                        count_from=lambda pkt: 0),
+    ]
+
+
+# Query HCA VPORT Context
+class QueryHcaVportContextIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        BitField('other_vport', 0, 1),
+        BitField('reserved2', 0, 11),
+        BitField('port_num', 0, 4),
+        ShortField('vport_number', 0),
+        StrFixedLenField('reserved3', None, length=4),
+    ]
+
+
+class HcaVportContext(Packet):
+    fields_desc = [
+        IntField('field_select', 0),
+        StrFixedLenField('reserved1', None, length=28),
+        BitField('sm_virt_aware', 0, 1),
+        BitField('has_smi', 0, 1),
+        BitField('has_raw', 0, 1),
+        BitField('grh_required', 0, 1),
+        BitField('reserved2', 0, 1),
+        BitField('min_wqe_inline_mode', 0, 3),
+        ByteField('reserved3', 0),
+        BitField('port_physical_state', 0, 4),
+        BitField('vport_state_policy', 0, 4),
+        BitField('port_state', 0, 4),
+        BitField('vport_state', 0, 4),
+        StrFixedLenField('reserved4', None, length=4),
+        LongField('system_image_guid', 0),
+        LongField('port_guid', 0),
+        LongField('node_guid', 0),
+        IntField('cap_mask1', 0),
+        IntField('cap_mask1_field_select', 0),
+        IntField('cap_mask2', 0),
+        IntField('cap_mask2_field_select', 0),
+        ShortField('reserved5', 0),
+        ShortField('ooo_sl_mask', 0),
+        StrFixedLenField('reserved6', None, length=12),
+        ShortField('lid', 0),
+        BitField('reserved7', 0, 4),
+        BitField('init_type_reply', 0, 4),
+        BitField('lmc', 0, 3),
+        BitField('subnet_timeout', 0, 5),
+        ShortField('sm_lid', 0),
+        BitField('sm_sl', 0, 4),
+        BitField('reserved8', 0, 12),
+        ShortField('qkey_violation_counter', 0),
+        ShortField('pkey_violation_counter', 0),
+        StrFixedLenField('reserved9', None, length=404),
+    ]
+
+
+class QueryHcaVportContextOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        StrFixedLenField('reserved2', None, length=8),
+        PacketField('hca_vport_context', HcaVportContext(), HcaVportContext),
+    ]
+
+
+# Query HCA VPORT GID
+class QueryHcaVportGidIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_QUERY_HCA_VPORT_GID),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        BitField('other_vport', 0, 1),
+        BitField('reserved2', 0, 11),
+        BitField('port_num', 0, 4),
+        ShortField('vport_number', 0),
+        ShortField('reserved3', 0),
+        ShortField('gid_index', 0),
+    ]
+
+
+class IbGidCmd(Packet):
+    fields_desc = [
+        LongField('prefix', 0),
+        LongField('guid', 0),
+    ]
+
+
+class QueryHcaVportGidOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        StrFixedLenField('reserved2', None, length=4),
+        ShortField('gids_num', 0),
+        ShortField('reserved3', 0),
+        PacketField('gid0', IbGidCmd(), IbGidCmd),
+    ]
+
+
+# Query HCA CAP
+class QueryHcaCapIn(Packet):
+    fields_desc = [
+        ShortField('opcode', DevxOps.MLX5_CMD_OP_QUERY_HCA_CAP),
+        ShortField('uid', 0),
+        ShortField('reserved1', 0),
+        ShortField('op_mod', 0),
+        BitField('other_function', 0, 1),
+        BitField('reserved2', 0, 15),
+        ShortField('function_id', 0),
+        StrFixedLenField('reserved3', None, length=4),
+    ]
+
+
+class CmdHcaCap(Packet):
+    fields_desc = [
+        BitField('access_other_hca_roce', 0, 1),
+        BitField('reserved1', 0, 30),
+        BitField('vhca_resource_manager', 0, 1),
+        BitField('hca_cap_2', 0, 1),
+        BitField('reserved2', 0, 2),
+        BitField('event_on_vhca_state_teardown_request', 0, 1),
+        BitField('event_on_vhca_state_in_use', 0, 1),
+        BitField('event_on_vhca_state_active', 0, 1),
+        BitField('event_on_vhca_state_allocated', 0, 1),
+        BitField('event_on_vhca_state_invalid', 0, 1),
+        ByteField('transpose_max_element_size', 0),
+        ShortField('vhca_id', 0),
+        ByteField('transpose_max_cols', 0),
+        ByteField('transpose_max_rows', 0),
+        ShortField('transpose_max_size', 0),
+        BitField('reserved3', 0, 1),
+        BitField('sw_steering_icm_large_scale_steering', 0, 1),
+        BitField('qp_data_in_order', 0, 1),
+        BitField('log_regexp_scatter_gather_size', 0, 5),
+        BitField('reserved4', 0, 3),
+        BitField('log_dma_mmo_max_size', 0, 5),
+        BitField('relaxed_ordering_write_pci_enabled', 0, 1),
+        BitField('reserved5', 0, 2),
+        BitField('log_compress_max_size', 0, 5),
+        BitField('reserved6', 0, 3),
+        BitField('log_decompress_max_size', 0, 5),
+        ByteField('log_max_srq_sz', 0),
+        ByteField('log_max_qp_sz', 0),
+        BitField('event_cap', 0, 1),
+        BitField('reserved7', 0, 2),
+        BitField('isolate_vl_tc_new', 0, 1),
+        BitField('reserved8', 0, 2),
+        BitField('nvmeotcp', 0, 1),
+        BitField('pcie_hanged', 0, 1),
+        BitField('prio_tag_required', 0, 1),
+        BitField('wqe_index_ignore_cap', 0, 1),
+        BitField('reserved9', 0, 1),
+        BitField('log_max_qp', 0, 5),
+        BitField('regexp', 0, 1),
+        BitField('regexp_params', 0, 1),
+        BitField('regexp_alloc_onbehalf_umem', 0, 1),
+        BitField('ece', 0, 1),
+        BitField('regexp_num_of_engines', 0, 4),
+        BitField('allow_pause_tx', 0, 1),
+        BitField('reg_c_preserve', 0, 1),
+        BitField('isolate_vl_tc', 0, 1),
+        BitField('log_max_srqs', 0, 5),
+        BitField('psp', 0, 1),
+        BitField('reserved10', 0, 1),
+        BitField('ts_cqe_to_dest_cqn', 0, 1),
+        BitField('regexp_log_crspace_size', 0, 5),
+        BitField('selective_repeat', 0, 1),
+        BitField('go_back_n', 0, 1),
+        BitField('reserved11', 0, 1),
+        BitField('scatter_fcs_w_decap_disable', 0, 1),
+        BitField('reserved12', 0, 4),
+        ByteField('max_sgl_for_optimized_performance', 0),
+        ByteField('log_max_cq_sz', 0),
+        BitField('relaxed_ordering_write_umr', 0, 1),
+        BitField('relaxed_ordering_read_umr', 0, 1),
+        BitField('access_register_user', 0, 1),
+        BitField('reserved13', 0, 5),
+        BitField('upt_device_emulation_manager', 0, 1),
+        BitField('virtio_net_device_emulation_manager', 0, 1),
+        BitField('virtio_blk_device_emulation_manager', 0, 1),
+        BitField('log_max_cq', 0, 5),
+        ByteField('log_max_eq_sz', 0),
+        BitField('relaxed_ordering_write', 0, 1),
+        BitField('relaxed_ordering_read', 0, 1),
+        BitField('log_max_mkey', 0, 6),
+        BitField('tunneled_atomic', 0, 1),
+        BitField('as_notify', 0, 1),
+        BitField('m_pci_port', 0, 1),
+        BitField('m_vhca_mk', 0, 1),
+        BitField('hotplug_manager', 0, 1),
+        BitField('nvme_device_emulation_manager', 0, 1),
+        BitField('terminate_scatter_list_mkey', 0, 1),
+        BitField('repeated_mkey', 0, 1),
+        BitField('dump_fill_mkey', 0, 1),
+        BitField('dpp', 0, 1),
+        BitField('resources_on_nvme_emulation_manager', 0, 1),
+        BitField('fast_teardown', 0, 1),
+        BitField('log_max_eq', 0, 4),
+        ByteField('max_indirection', 0),
+        BitField('fixed_buffer_size', 0, 1),
+        BitField('log_max_mrw_sz', 0, 7),
+        BitField('force_teardown', 0, 1),
+        BitField('prepare_fast_teardown_allways_1', 0, 1),
+        BitField('log_max_bsf_list_size', 0, 6),
+        BitField('umr_extended_translation_offset', 0, 1),
+        BitField('null_mkey', 0, 1),
+        BitField('log_max_klm_list_size', 0, 6),
+        BitField('non_wire_sq', 0, 1),
+        BitField('ats_ro_dependence', 0, 1),
+        BitField('qp_context_extension', 0, 1),
+        BitField('log_max_static_sq_wq_size', 0, 5),
+        BitField('resources_on_virtio_net_emulation_manager', 0, 1),
+        BitField('resources_on_virtio_blk_emulation_manager', 0, 1),
+        BitField('log_max_ra_req_dc', 0, 6),
+        BitField('vhca_trust_level_reg', 0, 1),
+        BitField('eth_wqe_too_small_mode', 0, 1),
+        BitField('vnic_env_eth_wqe_too_small', 0, 1),
+        BitField('log_max_static_sq_wq', 0, 5),
+        BitField('ooo_sl_mask', 0, 1),
+        BitField('vnic_env_cq_overrun', 0, 1),
+        BitField('log_max_ra_res_dc', 0, 6),
+        BitField('cc_roce_ecn_rp_classify_mode', 0, 1),
+        BitField('cc_roce_ecn_rp_dynamic_rtt', 0, 1),
+        BitField('cc_roce_ecn_rp_dynamic_ai', 0, 1),
+        BitField('cc_roce_ecn_rp_dynamic_g', 0, 1),
+        BitField('cc_roce_ecn_rp_burst_decouple', 0, 1),
+        BitField('release_all_pages', 0, 1),
+        BitField('depracated_do_not_use', 0, 1),
+        BitField('sig_crc64_xp10', 0, 1),
+        BitField('sig_crc32c', 0, 1),
+        BitField('roce_accl', 0, 1),
+        BitField('log_max_ra_req_qp', 0, 6),
+        BitField('reserved14', 0, 1),
+        BitField('rts2rts_udp_sport', 0, 1),
+        BitField('rts2rts_lag_tx_port_affinity', 0, 1),
+        BitField('dma_mmo', 0, 1),
+        BitField('compress_min_block_size', 0, 4),
+        BitField('compress', 0, 1),
+        BitField('decompress', 0, 1),
+        BitField('log_max_ra_res_qp', 0, 6),
+        BitField('end_pad', 0, 1),
+        BitField('cc_query_allowed', 0, 1),
+        BitField('cc_modify_allowed', 0, 1),
+        BitField('start_pad', 0, 1),
+        BitField('cache_line_128byte', 0, 1),
+        BitField('gid_table_size_ro', 0, 1),
+        BitField('pkey_table_size_ro', 0, 1),
+        BitField('rts2rts_qp_rmp', 0, 1),
+        BitField('rnr_nak_q_counters', 0, 1),
+        BitField('rts2rts_qp_counters_set_id', 0, 1),
+        BitField('rts2rts_qp_dscp', 0, 1),
+        BitField('gen3_cc_negotiation', 0, 1),
+        BitField('vnic_env_int_rq_oob', 0, 1),
+        BitField('sbcam_reg', 0, 1),
+        BitField('cwcam_reg', 0, 1),
+        BitField('qcam_reg', 0, 1),
+        ShortField('gid_table_size', 0),
+        BitField('out_of_seq_cnt', 0, 1),
+        BitField('vport_counters', 0, 1),
+        BitField('retransmission_q_counters', 0, 1),
+        BitField('debug', 0, 1),
+        BitField('modify_rq_counters_set_id', 0, 1),
+        BitField('rq_delay_drop', 0, 1),
+        BitField('max_qp_cnt', 0, 10),
+        ShortField('pkey_table_size', 0),
+        BitField('vport_group_manager', 0, 1),
+        BitField('vhca_group_manager', 0, 1),
+        BitField('ib_virt', 0, 1),
+        BitField('eth_virt', 0, 1),
+        BitField('vnic_env_queue_counters', 0, 1),
+        BitField('ets', 0, 1),
+        BitField('nic_flow_table', 0, 1),
+        BitField('eswitch_manager', 0, 1),
+        BitField('device_memory', 0, 1),
+        BitField('mcam_reg', 0, 1),
+        BitField('pcam_reg', 0, 1),
+        BitField('local_ca_ack_delay', 0, 5),
+        BitField('port_module_event', 0, 1),
+        BitField('enhanced_retransmission_q_counters', 0, 1),
+        BitField('port_checks', 0, 1),
+        BitField('pulse_gen_control', 0, 1),
+        BitField('disable_link_up_by_init_hca', 0, 1),
+        BitField('beacon_led', 0, 1),
+        BitField('port_type', 0, 2),
+        ByteField('num_ports', 0),
+        BitField('snapshot', 0, 1),
+        BitField('pps', 0, 1),
+        BitField('pps_modify', 0, 1),
+        BitField('log_max_msg', 0, 5),
+        BitField('multi_path_xrc_rdma', 0, 1),
+        BitField('multi_path_dc_rdma', 0, 1),
+        BitField('multi_path_rc_rdma', 0, 1),
+        BitField('traffic_fast_control', 0, 1),
+        BitField('max_tc', 0, 4),
+        BitField('temp_warn_event', 0, 1),
+        BitField('dcbx', 0, 1),
+        BitField('general_notification_event', 0, 1),
+        BitField('multi_prio_sq', 0, 1),
+        BitField('afu_owner', 0, 1),
+        BitField('fpga', 0, 1),
+        BitField('rol_s', 0, 1),
+        BitField('rol_g', 0, 1),
+        BitField('ib_port_sniffer', 0, 1),
+        BitField('wol_s', 0, 1),
+        BitField('wol_g', 0, 1),
+        BitField('wol_a', 0, 1),
+        BitField('wol_b', 0, 1),
+        BitField('wol_m', 0, 1),
+        BitField('wol_u', 0, 1),
+        BitField('wol_p', 0, 1),
+        ShortField('stat_rate_support', 0),
+        BitField('sig_block_4048', 0, 1),
+        BitField('pci_sync_for_fw_update_event', 0, 1),
+        BitField('init2rtr_drain_sigerr', 0, 1),
+        BitField('log_max_extended_rnr_retry', 0, 5),
+        BitField('init2_lag_tx_port_affinity', 0, 1),
+        BitField('flow_group_type_hash_split', 0, 1),
+        BitField('reserved15', 0, 1),
+        BitField('wqe_based_flow_table_update', 0, 1),
+        BitField('cqe_version', 0, 4),
+        BitField('compact_address_vector', 0, 1),
+        BitField('eth_striding_wq', 0, 1),
+        BitField('reserved16', 0, 1),
+        BitField('ipoib_enhanced_offloads', 0, 1),
+        BitField('ipoib_basic_offloads', 0, 1),
+        BitField('ib_link_list_striding_wq', 0, 1),
+        BitField('repeated_block_disabled', 0, 1),
+        BitField('umr_modify_entity_size_disabled', 0, 1),
+        BitField('umr_modify_atomic_disabled', 0, 1),
+        BitField('umr_indirect_mkey_disabled', 0, 1),
+        BitField('umr_fence', 0, 2),
+        BitField('dc_req_sctr_data_cqe', 0, 1),
+        BitField('dc_connect_qp', 0, 1),
+        BitField('dc_cnak_trace', 0, 1),
+        BitField('drain_sigerr', 0, 1),
+        BitField('cmdif_checksum', 0, 2),
+        BitField('sigerr_cqe', 0, 1),
+        BitField('e_psv', 0, 1),
+        BitField('wq_signature', 0, 1),
+        BitField('sctr_data_cqe', 0, 1),
+        BitField('bsf_in_create_mkey', 0, 1),
+        BitField('sho', 0, 1),
+        BitField('tph', 0, 1),
+        BitField('rf', 0, 1),
+        BitField('dct', 0, 1),
+        BitField('qos', 0, 1),
+        BitField('eth_net_offloads', 0, 1),
+        BitField('roce', 0, 1),
+        BitField('atomic', 0, 1),
+        BitField('extended_retry_count', 0, 1),
+        BitField('cq_oi', 0, 1),
+        BitField('cq_resize', 0, 1),
+        BitField('cq_moderation', 0, 1),
+        BitField('cq_period_mode_modify', 0, 1),
+        BitField('cq_invalidate', 0, 1),
+        BitField('reserved17', 0, 1),
+        BitField('cq_eq_remap', 0, 1),
+        BitField('pg', 0, 1),
+        BitField('block_lb_mc', 0, 1),
+        BitField('exponential_backoff', 0, 1),
+        BitField('scqe_break_moderation', 0, 1),
+        BitField('cq_period_start_from_cqe', 0, 1),
+        BitField('cd', 0, 1),
+        BitField('atm', 0, 1),
+        BitField('apm', 0, 1),
+        BitField('vector_calc', 0, 1),
+        BitField('umr_ptr_rlkey', 0, 1),
+        BitField('imaicl', 0, 1),
+        BitField('qp_packet_based', 0, 1),
+        BitField('ib_cyclic_striding_wq', 0, 1),
+        BitField('ipoib_enhanced_pkey_change', 0, 1),
+        BitField('initiator_src_dct_in_cqe', 0, 1),
+        BitField('qkv', 0, 1),
+        BitField('pkv', 0, 1),
+        BitField('set_deth_sqpn', 0, 1),
+        BitField('rts2rts_primary_sl', 0, 1),
+        BitField('initiator_src_dct', 0, 1),
+        BitField('dc_v2', 0, 1),
+        BitField('xrc', 0, 1),
+        BitField('ud', 0, 1),
+        BitField('uc', 0, 1),
+        BitField('rc', 0, 1),
+        BitField('uar_4k', 0, 1),
+        BitField('reserved18', 0, 7),
+        BitField('fl_rc_qp_when_roce_disabled', 0, 1),
+        BitField('reserved19', 0, 1),
+        BitField('uar_sz', 0, 6),
+        BitField('reserved20', 0, 3),
+        BitField('log_max_dc_cnak_qps', 0, 5),
+        ByteField('log_pg_sz', 0),
+        BitField('bf', 0, 1),
+        BitField('driver_version', 0, 1),
+        BitField('pad_tx_eth_packet', 0, 1),
+        BitField('query_driver_version', 0, 1),
+        BitField('max_qp_retry_freq', 0, 1),
+        BitField('qp_by_name', 0, 1),
+        BitField('mkey_by_name', 0, 1),
+        BitField('reserved21', 0, 4),
+        BitField('log_bf_reg_size', 0, 5),
+        BitField('reserved22', 0, 6),
+        BitField('lag_dct', 0, 2),
+        BitField('lag_tx_port_affinity', 0, 1),
+        BitField('lag_native_fdb_selection', 0, 1),
+        BitField('must_be_0', 0, 1),
+        BitField('lag_master', 0, 1),
+        BitField('num_lag_ports', 0, 4),
+        ShortField('num_of_diagnostic_counters', 0),
+        ShortField('max_wqe_sz_sq', 0),
+        ShortField('reserved23', 0),
+        ShortField('max_wqe_sz_rq', 0),
+        ShortField('max_flow_counter_31_16', 0),
+        ShortField('max_wqe_sz_sq_dc', 0),
+        BitField('reserved24', 0, 7),
+        BitField('max_qp_mcg', 0, 25),
+        ShortField('mlnx_tag_ethertype', 0),
+        ByteField('flow_counter_bulk_alloc', 0),
+        ByteField('log_max_mcg', 0),
+        BitField('reserved25', 0, 3),
+        BitField('log_max_transport_domain', 0, 5),
+        BitField('reserved26', 0, 3),
+        BitField('log_max_pd', 0, 5),
+        BitField('reserved27', 0, 11),
+        BitField('log_max_xrcd', 0, 5),
+        BitField('nic_receive_steering_discard', 0, 1),
+        BitField('receive_discard_vport_down', 0, 1),
+        BitField('transmit_discard_vport_down', 0, 1),
+        BitField('eq_overrun_count', 0, 1),
+        BitField('nic_receive_steering_depth', 0, 1),
+        BitField('invalid_command_count', 0, 1),
+        BitField('quota_exceeded_count', 0, 1),
+        BitField('flow_counter_by_name', 0, 1),
+        ByteField('log_max_flow_counter_bulk', 0),
+        ShortField('max_flow_counter_15_0', 0),
+        BitField('modify_tis', 0, 1),
+        BitField('flow_counters_dump', 0, 1),
+        BitField('reserved28', 0, 1),
+        BitField('log_max_rq', 0, 5),
+        BitField('reserved29', 0, 3),
+        BitField('log_max_sq', 0, 5),
+        BitField('reserved30', 0, 3),
+        BitField('log_max_tir', 0, 5),
+        BitField('reserved31', 0, 3),
+        BitField('log_max_tis', 0, 5),
+        BitField('basic_cyclic_rcv_wqe', 0, 1),
+        BitField('reserved32', 0, 2),
+        BitField('log_max_rmp', 0, 5),
+        BitField('reserved33', 0, 3),
+        BitField('log_max_rqt', 0, 5),
+        BitField('reserved34', 0, 3),
+        BitField('log_max_rqt_size', 0, 5),
+        BitField('reserved35', 0, 3),
+        BitField('log_max_tis_per_sq', 0, 5),
+        BitField('ext_stride_num_range', 0, 1),
+        BitField('reserved36', 0, 2),
+        BitField('log_max_stride_sz_rq', 0, 5),
+        BitField('reserved37', 0, 3),
+        BitField('log_min_stride_sz_rq', 0, 5),
+        BitField('reserved38', 0, 3),
+        BitField('log_max_stride_sz_sq', 0, 5),
+        BitField('reserved39', 0, 3),
+        BitField('log_min_stride_sz_sq', 0, 5),
+        BitField('hairpin_eth_raw', 0, 1),
+        BitField('reserved40', 0, 2),
+        BitField('log_max_hairpin_queues', 0, 5),
+        BitField('hairpin_ib_raw', 0, 1),
+        BitField('hairpin_eth2ipoib', 0, 1),
+        BitField('hairpin_ipoib2eth', 0, 1),
+        BitField('log_max_hairpin_wq_data_sz', 0, 5),
+        BitField('reserved41', 0, 3),
+        BitField('log_max_hairpin_num_packets', 0, 5),
+        BitField('reserved42', 0, 3),
+        BitField('log_max_wq_sz', 0, 5),
+        BitField('nic_vport_change_event', 0, 1),
+        BitField('disable_local_lb_uc', 0, 1),
+        BitField('disable_local_lb_mc', 0, 1),
+        BitField('log_min_hairpin_wq_data_sz', 0, 5),
+        BitField('system_image_guid_modifiable', 0, 1),
+        BitField('reserved43', 0, 1),
+        BitField('vhca_state', 0, 1),
+        BitField('log_max_vlan_list', 0, 5),
+        BitField('reserved44', 0, 3),
+        BitField('log_max_current_mc_list', 0, 5),
+        BitField('reserved45', 0, 3),
+        BitField('log_max_current_uc_list', 0, 5),
+        LongField('general_obj_types', 0),
+        BitField('sq_ts_format', 0, 2),
+        BitField('rq_ts_format', 0, 2),
+        BitField('steering_format_version', 0, 4),
+        BitField('create_qp_start_hint', 0, 24),
+        BitField('tls', 0, 1),
+        BitField('ats', 0, 1),
+        BitField('reserved46', 0, 1),
+        BitField('log_max_uctx', 0, 5),
+        BitField('aes_xts', 0, 1),
+        BitField('crypto', 0, 1),
+        BitField('ipsec_offload', 0, 1),
+        BitField('log_max_umem', 0, 5),
+        ShortField('max_num_eqs', 0),
+        BitField('reserved47', 0, 1),
+        BitField('tls_tx', 0, 1),
+        BitField('tls_rx', 0, 1),
+        BitField('log_max_l2_table', 0, 5),
+        ByteField('reserved48', 0),
+        ShortField('log_uar_page_sz', 0),
+        BitField('e', 0, 1),
+        BitField('reserved49', 0, 31),
+        IntField('device_frequency_mhz', 0),
+        IntField('device_frequency_khz', 0),
+        BitField('capi', 0, 1),
+        BitField('create_pec', 0, 1),
+        BitField('nvmf_target_offload', 0, 1),
+        BitField('capi_invalidate', 0, 1),
+        BitField('reserved50', 0, 23),
+        BitField('log_max_pasid', 0, 5),
+        IntField('num_of_uars_per_page', 0),
+        IntField('flex_parser_protocols', 0),
+        ByteField('max_geneve_tlv_options', 0),
+        BitField('reserved51', 0, 3),
+        BitField('max_geneve_tlv_option_data_len', 0, 5),
+        BitField('flex_parser_header_modify', 0, 1),
+        BitField('reserved52', 0, 2),
+        BitField('log_max_guaranteed_connections', 0, 5),
+        BitField('reserved53', 0, 3),
+        BitField('log_max_dct_connections', 0, 5),
+        ByteField('log_max_atomic_size_qp', 0),
+        BitField('reserved54', 0, 3),
+        BitField('log_max_dci_stream_channels', 0, 5),
+        BitField('reserved55', 0, 3),
+        BitField('log_max_dci_errored_streams', 0, 5),
+        ByteField('log_max_atomic_size_dc', 0),
+        ShortField('max_multi_user_group_size', 0),
+        BitField('reserved56', 0, 2),
+        BitField('crossing_vhca_mkey', 0, 1),
+        BitField('log_max_dek', 0, 5),
+        BitField('reserved57', 0, 1),
+        BitField('mini_cqe_resp_l3l4header', 0, 1),
+        BitField('mini_cqe_resp_flow_tag', 0, 1),
+        BitField('enhanced_cqe_compression', 0, 1),
+        BitField('mini_cqe_resp_stride_index', 0, 1),
+        BitField('cqe_128_always', 0, 1),
+        BitField('cqe_compression_128b', 0, 1),
+        BitField('cqe_compression', 0, 1),
+        ShortField('cqe_compression_timeout', 0),
+        ShortField('cqe_compression_max_num', 0),
+        BitField('reserved58', 0, 3),
+        BitField('wqe_based_flow_table_update_dest_type_offset', 0, 5),
+        BitField('flex_parser_id_gtpu_dw_0', 0, 4),
+        BitField('log_max_tm_offloaded_op_size', 0, 4),
+        BitField('tag_matching', 0, 1),
+        BitField('rndv_offload_rc', 0, 1),
+        BitField('rndv_offload_dc', 0, 1),
+        BitField('log_tag_matching_list_sz', 0, 5),
+        BitField('reserved59', 0, 3),
+        BitField('log_max_xrq', 0, 5),
+        ByteField('affiliate_nic_vport_criteria', 0),
+        ByteField('native_port_num', 0),
+        ByteField('num_vhca_ports', 0),
+        BitField('flex_parser_id_gtpu_teid', 0, 4),
+        BitField('reserved60', 0, 1),
+        BitField('trusted_vnic_vhca', 0, 1),
+        BitField('sw_owner_id', 0, 1),
+        BitField('reserve_not_to_use', 0, 1),
+        ShortField('max_num_of_monitor_counters', 0),
+        ShortField('num_ppcnt_monitor_counters', 0),
+        ShortField('max_num_sf', 0),
+        ShortField('num_q_monitor_counters', 0),
+        StrFixedLenField('reserved61', None, length=4),
+        BitField('sf', 0, 1),
+        BitField('sf_set_partition', 0, 1),
+        BitField('reserved62', 0, 1),
+        BitField('log_max_sf', 0, 5),
+        ByteField('reserved63', 0),
+        ByteField('log_min_sf_size', 0),
+        ByteField('max_num_sf_partitions', 0),
+        IntField('uctx_permission', 0),
+        BitField('flex_parser_id_mpls_over_x_cw', 0, 4),
+        BitField('flex_parser_id_geneve_tlv_option_0', 0, 4),
+        BitField('flex_parser_id_icmp_dw1', 0, 4),
+        BitField('flex_parser_id_icmp_dw0', 0, 4),
+        BitField('flex_parser_id_icmpv6_dw1', 0, 4),
+        BitField('flex_parser_id_icmpv6_dw0', 0, 4),
+        BitField('flex_parser_id_outer_first_mpls_over_gre', 0, 4),
+        BitField('flex_parser_id_outer_first_mpls_over_udp_label', 0, 4),
+        ShortField('max_num_match_definer', 0),
+        ShortField('sf_base_id', 0),
+        BitField('flex_parser_id_gtpu_dw_2', 0, 4),
+        BitField('flex_parser_id_gtpu_first_ext_dw_0', 0, 4),
+        BitField('num_total_dynamic_vf_msix', 0, 24),
+        BitField('reserved64', 0, 3),
+        BitField('log_flow_hit_aso_granularity', 0, 5),
+        BitField('reserved65', 0, 3),
+        BitField('log_flow_hit_aso_max_alloc', 0, 5),
+        BitField('reserved66', 0, 4),
+        BitField('dynamic_msix_table_size', 0, 12),
+        BitField('reserved67', 0, 3),
+        BitField('log_max_num_flow_hit_aso', 0, 5),
+        BitField('reserved68', 0, 4),
+        BitField('min_dynamic_vf_msix_table_size', 0, 4),
+        BitField('reserved69', 0, 4),
+        BitField('max_dynamic_vf_msix_table_size', 0, 12),
+        BitField('reserved70', 0, 3),
+        BitField('log_max_num_header_modify_argument', 0, 5),
+        BitField('reserved71', 0, 4),
+        BitField('log_header_modify_argument_granularity', 0, 4),
+        BitField('reserved72', 0, 3),
+        BitField('log_header_modify_argument_max_alloc', 0, 5),
+        BitField('reserved73', 0, 3),
+        BitField('max_flow_execute_aso', 0, 5),
+        LongField('vhca_tunnel_commands', 0),
+        LongField('match_definer_format_supported', 0),
+    ]
+
+
+class QueryCmdHcaCapOut(Packet):
+    fields_desc = [
+        ByteField('status', 0),
+        BitField('reserved1', 0, 24),
+        IntField('syndrome', 0),
+        StrFixedLenField('reserved2', None, length=8),
+        PadField(PacketField('capability', CmdHcaCap(), CmdHcaCap), 2048, padwith=b"\x00"),
+    ]
diff --git a/tests/test_mlx5_devx.py b/tests/test_mlx5_devx.py
new file mode 100644
index 0000000..c43dcd5
--- /dev/null
+++ b/tests/test_mlx5_devx.py
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia Inc. All rights reserved. See COPYING file
+
+"""
+Test module for mlx5 DevX.
+"""
+
+from tests.mlx5_base import Mlx5DevxRcResources, Mlx5DevxTrafficBase
+
+
+class Mlx5DevxRcTrafficTest(Mlx5DevxTrafficBase):
+    """
+    Test various functionality of mlx5 DevX objects
+    """
+
+    def test_devx_rc_qp_send_imm_traffic(self):
+        """
+        Creates two DevX RC QPs and modifies them to RTS state.
+        Then does SEND_IMM traffic.
+        """
+        self.create_players(Mlx5DevxRcResources)
+        # Send traffic
+        self.send_imm_traffic()
-- 
1.8.3.1

