Return-Path: <linux-rdma+bounces-3114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AF906726
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC045B25821
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E613FD82;
	Thu, 13 Jun 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="O46BeSKm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4C522F
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267901; cv=none; b=TLosiJb2p6ey4rHTJorJyhJ4Z3ZEvYVN+fwMIgYhlQhY0HYHh/kMXUrwr7oQyLPE3BTX/Aj7Dgag9UnxBUH4hnZSMfxnwGCLAEtVpAM4lmGtXTGXZBfHLD0Aaeicx8YrDCA8IikZjV1gPvLNIx/EyJqqHVyU13gY4RQSujLOnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267901; c=relaxed/simple;
	bh=Xx5QjQVoMKqAAqKq2XueN4NFlL8Oa8E/tyDn2I7nhn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7mTBrw6G6ev5Y/feGo3nWLpS9yBMIbvKaEzkLN2lyiRuSopflYBWZI3k00UyUn0+4HSn2W9EGlYdVOytZC75fCKZ7G642GobW8z1hmXGee6rLa46TtrJC5TabwDRqy350b8/GwMaZOOF1gRVzuneqKCgMgWtDBQssruq1MrW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=O46BeSKm; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718267902; bh=Xx5QjQVoMKqAAqKq2XueN4NFlL8Oa8E/tyDn2I7nhn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O46BeSKmI7ciW6QSc8m+QiwAQx5IXgOAq122PYKfsGbE8+U2SV58Oz5VuvM32k6CS
	 VtFTxiObzdM6CidK0GaCRO7LpWA4AcPK0xQGrlD2InpDUC/+vl+s8t/RyQWh77p+ml
	 2eNJ9uGF88BxOHc48ps/baYmyXycEjdvjQXYyorSG2EZZYdB8VcRiyx1psc0agOIYi
	 dtYcwB/UPSyYRKgLXRzIU/pWsDnGP/cZ+yFnRMpmmR2QCwiBP1hR7FZLlZ1jgCWTMa
	 NmO6M0QHDqwM1BB0Np7eM9ysKr/swGlanVTq1Wzw7tRWcAErwVMGpKpTvMmOGAgjBk
	 0BVErXGK/+2Vw==
Received: from oshpigelman-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by oshpigelman-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45D8c2vb1440923;
	Thu, 13 Jun 2024 11:38:03 +0300
From: Omer Shpigelman <oshpigelman@habana.ai>
To: linux-rdma@vger.kernel.org
Cc: ogabbay@kernel.org, oshpigelman@habana.ai, zyehudai@habana.ai
Subject: [PATCH 4/4] tests/hbl: direct verbs tests
Date: Thu, 13 Jun 2024 11:38:02 +0300
Message-Id: <20240613083802.1440904-5-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613083802.1440904-1-oshpigelman@habana.ai>
References: <20240613083802.1440904-1-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test every DV operation. This includes opening the device via the DV API.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Co-developed-by: David Meriin <dmeriin@habana.ai>
Signed-off-by: David Meriin <dmeriin@habana.ai>
Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
---
 tests/CMakeLists.txt |   2 +
 tests/hbl_base.py    |  89 +++++++++++++++++
 tests/test_hbldv.py  | 226 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+)
 create mode 100644 tests/hbl_base.py
 create mode 100644 tests/test_hbldv.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index b77ba98cf..4e653a942 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -8,6 +8,7 @@ rdma_python_test(tests
   base_rdmacm.py
   cuda_utils.py
   efa_base.py
+  hbl_base.py
   irdma_base.py
   mlx5_base.py
   mlx5_prm_structs.py
@@ -23,6 +24,7 @@ rdma_python_test(tests
   test_efadv.py
   test_flow.py
   test_fork.py
+  test_hbldv.py
   test_mlx5_cq.py
   test_mlx5_crypto.py
   test_mlx5_cuda_umem.py
diff --git a/tests/hbl_base.py b/tests/hbl_base.py
new file mode 100644
index 000000000..9311d0823
--- /dev/null
+++ b/tests/hbl_base.py
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+import unittest
+import os
+import re
+
+from pyverbs.providers.hbl.hbldv import HblContext, HblDVContextAttr, \
+    HblDVSetPortEx, HblDVPortExAttr
+from pyverbs.pyverbs_error import PyverbsRDMAError
+from pyverbs.base import PyverbsRDMAError
+from pyverbs.pyverbs_error import PyverbsUserError
+import pyverbs.providers.hbl.hbl_enums as hbl_e
+import pyverbs.providers.hbl.hbldv as hbl
+
+from tests.base import PyverbsAPITestCase
+
+
+HABANALABS_VENDOR_ID = 0x1da3
+
+
+def is_hbl_dev(ctx):
+    dev_attrs = ctx.query_device()
+    return dev_attrs.vendor_id == HABANALABS_VENDOR_ID
+
+
+def skip_if_not_hbl_dev(ctx):
+    if not is_hbl_dev(ctx):
+        raise unittest.SkipTest('Can not run the test over non hbl device')
+
+def bits(n):
+    b=0
+    while n:
+        if (n & 0x1):
+            yield b
+        b += 1
+        n >>= 1
+
+
+class HblAPITestCase(PyverbsAPITestCase):
+    def __init__(self, methodName='runTest'):
+        super().__init__(methodName)
+        self.fd = None
+
+    def setUp(self):
+        super().setUp()
+        skip_if_not_hbl_dev(self.ctx)
+
+    def create_context(self):
+        try:
+            path = None
+            for file in os.listdir('/dev/accel/'):
+                if re.match('^accel[0-9]+$', file):
+                    path = os.path.join('/dev/accel/', file)
+                    break
+
+            self.assertNotEqual(path, None, 'No core device found')
+
+            self.fd = os.open(path, os.O_RDWR | os.O_CLOEXEC)
+            attr = HblDVContextAttr()
+            attr.ports_mask = 0
+            attr.core_fd = self.fd
+            self.ctx = HblContext(attr, name=self.dev_name)
+        except PyverbsUserError as ex:
+            raise unittest.SkipTest(f'Could not open hbl context ({ex})')
+        except PyverbsRDMAError:
+            raise unittest.SkipTest('Opening hbl context is not supported')
+
+        try:
+            # Set ports Ex should be called for all enabled ports
+            ib_ports_mask = self.ctx.query_hbl_device().ports_mask
+            for ib_port in bits(ib_ports_mask):
+                attr = HblDVPortExAttr()
+                attr.port_num = ib_port
+                attr.mem_id = hbl_e.HBLDV_MEM_HOST
+                attr.max_num_of_wqs = 8
+                attr.max_num_of_wqes_in_wq = 16
+                attr.swq_granularity = hbl_e.HBLDV_SWQE_GRAN_32B
+                attr.caps = 1
+                port = HblDVSetPortEx()
+                port.set_port_ex(self.ctx, attr)
+        except PyverbsUserError as ex:
+            raise unittest.SkipTest(f'Could not set port extended params ({ex})')
+
+    def tearDown(self):
+        super().tearDown()
+        os.close(self.fd)
diff --git a/tests/test_hbldv.py b/tests/test_hbldv.py
new file mode 100644
index 000000000..44e84c746
--- /dev/null
+++ b/tests/test_hbldv.py
@@ -0,0 +1,226 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright 2022-2024 HabanaLabs, Ltd.
+# Copyright (C) 2023-2024, Intel Corporation.
+# All Rights Reserved.
+
+"""
+Test module for hbl direct-verbs.
+"""
+
+import errno
+import unittest
+import struct
+import ctypes
+
+from pyverbs.providers.hbl.hbldv import (
+    HblDVUserFIFOAttr, HblDVCQattr, HblDVQueryCQ, HblDVCQ, HblDVPortAttr, HblDVQP,
+    HblDVQueryQP, HblDVEncap, HblDVEncapAttr, HblDVEncapOut, HblDVModifyQP
+)
+
+from pyverbs.base import PyverbsRDMAError
+from pyverbs.pyverbs_error import PyverbsUserError
+import pyverbs.providers.hbl.hbldv as hbl
+import pyverbs.providers.hbl.hbl_enums as hbl_e
+from pyverbs.cq import CQ
+from pyverbs.pd import PD
+import pyverbs.enums as e
+from pyverbs.qp import QPInitAttr, QPAttr
+
+from tests.hbl_base import HblAPITestCase
+
+
+class HblUserFIFOTest(HblAPITestCase):
+    """
+    Test functionality of the Hbl user FIFO class
+    """
+    def test_hbldv_usr_fifo(self):
+        """
+        Test hbldv_usr_fifo()
+        """
+        try:
+            attr = HblDVUserFIFOAttr()
+            attr.port_num = self.ib_port
+            usr_fifo = hbl.HblDVUserFIFO()
+            usr_fifo.create_usr_fifo(self.ctx, attr)
+            usr_fifo.destroy_usr_fifo()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+class HblCQTest(HblAPITestCase):
+    """
+    Test functionality of the Hbl CQ class
+    """
+    def test_hbldv_create_cq(self):
+        """
+        Test hbldv_create_cq()
+        """
+        try:
+            num_cqes = 512
+            cq_attr = HblDVCQattr()
+            cq_attr.port_num = self.ib_port
+            cq_attr.cq_type = 0
+            cq_obj = HblDVCQ()
+            cq_obj.create_cq(self.ctx, num_cqes, cq_attr)
+            cq_obj.destroy_cq()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+    def test_hbldv_query_cq(self):
+        """
+        Test hbldv_query_cq()
+        """
+        try:
+            num_cqes = 512
+            cq_attr = HblDVCQattr()
+            cq_attr.port_num = self.ib_port
+            cq_attr.cq_type = 0
+            cq_obj = HblDVCQ()
+            cq_obj.create_cq(self.ctx, num_cqes, cq_attr)
+            query_cq_obj = HblDVQueryCQ()
+            cq_obj.query_cq(query_cq_obj)
+            cq_obj.destroy_cq()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+class HblQueryPortTest(HblAPITestCase):
+    """
+    Test functionality of the Hbl Query port class
+    """
+    def test_hbldv_query_port(self):
+        """
+        Test hbldv_query_port()
+        """
+        try:
+            attr = HblDVPortAttr()
+            port = hbl.HblQueryPort()
+            port.query_port(self.ctx, self.ib_port, attr)
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+class HblQPTest(HblAPITestCase):
+    """
+    Test functionality of the Hbl Query QP class
+    """
+    def test_hbldv_modify_qp(self):
+        """
+        Test hbldv_modify_qp()
+        """
+        try:
+            pd_obj = PD(self.ctx)
+            cq_obj = CQ(self.ctx, 512)
+            qp_init_obj = QPInitAttr(e.IBV_QPT_RC, None, cq_obj, cq_obj)
+            qp_obj = HblDVQP()
+            qp_obj.create_qp(pd_obj, qp_init_obj)
+            qp_attr_obj = QPAttr()
+            qp_attr_obj.qp_state = e.IBV_QPS_INIT
+            qp_attr_obj.port_num = self.ib_port
+            qp_attr_obj.pkey_index = 0
+            qp_modify_attr = HblDVModifyQP()
+            qp_modify_attr.wq_type = 1
+            qp_obj.modify_qp(qp_attr_obj,
+                             e.IBV_QP_STATE | e.IBV_QP_PKEY_INDEX |
+                             e.IBV_QP_PORT | e.IBV_QP_ACCESS_FLAGS, qp_modify_attr)
+            qp_obj.destroy_qp()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+    def test_hbldv_query_qp(self):
+        """
+        Test hbldv_query_qp()
+        """
+        try:
+            cq_obj = CQ(self.ctx, 512)
+            pd_obj = PD(self.ctx)
+            qp_init_obj = QPInitAttr(e.IBV_QPT_RC, None, cq_obj, cq_obj)
+            qp_obj = HblDVQP()
+            qp_obj.create_qp(pd_obj, qp_init_obj)
+            qp_attr_obj = QPAttr()
+            qp_attr_obj.qp_state = e.IBV_QPS_INIT
+            qp_attr_obj.port_num = self.ib_port
+            qp_attr_obj.pkey_index = 0
+            qp_modify_attr = HblDVModifyQP()
+            qp_modify_attr.wq_type = 1
+            qp_obj.modify_qp(qp_attr_obj, e.IBV_QP_STATE | e.IBV_QP_PKEY_INDEX | e.IBV_QP_PORT | e.IBV_QP_ACCESS_FLAGS, qp_modify_attr)
+            query_qp_obj = HblDVQueryQP()
+            qp_obj.query_qp(query_qp_obj)
+            qp_obj.destroy_qp()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+class HblCCCQTest(HblAPITestCase):
+    """
+    Test functionality of the Hbl CC CQ class
+    """
+    def test_hbldv_create_cq(self):
+        """
+        Test hbldv_create_cq() for CC
+        """
+        if not self.ctx.query_hbl_device().caps & hbl_e.HBLDV_DEVICE_ATTR_CAP_CC:
+            raise unittest.SkipTest('Test not supported on this device')
+        try:
+            num_cqes = 512
+            cq_attr = HblDVCQattr()
+            cq_attr.port_num = self.ib_port
+            cq_attr.cq_type = 1
+            cq_obj = HblDVCQ()
+            cq_obj.create_cq(self.ctx, num_cqes, cq_attr)
+            cq_obj.destroy_cq()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+    def test_hbldv_query_cq(self):
+        """
+        Test hbldv_query_cq() for CC
+        """
+        if not self.ctx.query_hbl_device().caps & hbl_e.HBLDV_DEVICE_ATTR_CAP_CC:
+            raise unittest.SkipTest('Test not supported on this device')
+        try:
+            num_cqes = 512
+            cq_attr = HblDVCQattr()
+            cq_attr.port_num = self.ib_port
+            cq_attr.cq_type = 1
+            cq_obj = HblDVCQ()
+            cq_obj.create_cq(self.ctx, num_cqes, cq_attr)
+            query_cq_obj = HblDVQueryCQ()
+            cq_obj.query_cq(query_cq_obj)
+            cq_obj.destroy_cq()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
+
+class HblEncapTest(HblAPITestCase):
+    """
+    Test functionality of the Hbl Encap class
+    """
+    def test_hbldv_create_encap(self):
+        """
+        Test hbldv_create_encap()
+        """
+        try:
+            encap_attr = HblDVEncapAttr()
+            encap_attr.port_num = self.ib_port
+            encap_attr.encap_type = 2
+            encap_out = HblDVEncapOut()
+            encap_obj = HblDVEncap()
+            encap_attr.tnl_hdr_size = 32
+            encap_obj.create_encap(self.ctx, encap_attr, encap_out)
+            encap_obj.destroy_encap()
+        except PyverbsRDMAError as ex:
+            if ex.error_code in [errno.EOPNOTSUPP, errno.EPROTONOSUPPORT]:
+                raise unittest.SkipTest('Not supported on non hbl devices')
+            raise ex
-- 
2.34.1


