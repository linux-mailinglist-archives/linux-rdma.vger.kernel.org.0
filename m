Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3BE3D6CCC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbhG0CvN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:51:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16005 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhG0CvM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:51:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GYj1457zwzZshQ;
        Tue, 27 Jul 2021 11:28:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:35 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:35 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 10/10] tests: Add traffic test of send on HNS DCA QPEx
Date:   Tue, 27 Jul 2021 11:28:00 +0800
Message-ID: <1627356480-41805-11-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add traffic test of old send on QPEx class.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 tests/hns_base.py     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/test_hns_dca.py | 37 ++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tests/hns_base.py
 create mode 100644 tests/test_hns_dca.py

diff --git a/tests/hns_base.py b/tests/hns_base.py
new file mode 100644
index 0000000..46d6a28
--- /dev/null
+++ b/tests/hns_base.py
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+import unittest
+import random
+import errno
+
+from pyverbs.providers.hns.hnsdv import HnsContext, HnsDVContextAttr, \
+    HnsDVQPInitAttr, HnsQP
+from tests.base import RCResources, RDMATestCase, PyverbsAPITestCase
+from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsUserError
+from pyverbs.qp import QPCap, QPInitAttrEx
+import pyverbs.providers.hns.hns_enums as dve
+import pyverbs.device as d
+import pyverbs.enums as e
+from pyverbs.mr import MR
+
+
+HUAWEI_VENDOR_ID = 0x19e5
+
+def is_hns_dev(ctx):
+    dev_attrs = ctx.query_device()
+    return dev_attrs.vendor_id == HUAWEI_VENDOR_ID
+
+
+def skip_if_not_hns_dev(ctx):
+    if not is_hns_dev(ctx):
+        raise unittest.SkipTest('Can not run the test over non HNS device')
+
+
+class HnsPyverbsAPITestCase(PyverbsAPITestCase):
+    def setUp(self):
+        super().setUp()
+        skip_if_not_hns_dev(self.ctx)
+
+
+class HnsRDMATestCase(RDMATestCase):
+    def setUp(self):
+        super().setUp()
+        skip_if_not_hns_dev(d.Context(name=self.dev_name))
+
+
+class HnsDcaResources(RCResources):
+    def create_context(self):
+        hnsdv_attr = HnsDVContextAttr(flags=dve.HNSDV_CONTEXT_FLAGS_DCA)
+        try:
+            self.ctx = HnsContext(hnsdv_attr, name=self.dev_name)
+        except PyverbsUserError as ex:
+            raise unittest.SkipTest(f'Could not open hns context ({ex})')
+        except PyverbsRDMAError:
+            raise unittest.SkipTest('Opening hns context is not supported')
+
+    def create_qp_cap(self):
+        return QPCap(100, 0, 10, 0)
+
+    def create_qp_init_attr(self):
+        return QPInitAttrEx(cap=self.create_qp_cap(), pd=self.pd, scq=self.cq,
+                            rcq=self.cq, srq=self.srq, qp_type=e.IBV_QPT_RC,
+                            comp_mask=e.IBV_QP_INIT_ATTR_PD,
+                            sq_sig_all=1)
+
+    def create_qps(self):
+        # Create the DCA QPs.
+        qp_init_attr = self.create_qp_init_attr()
+        try:
+            for _ in range(self.qp_count):
+                attr = HnsDVQPInitAttr(comp_mask=dve.HNSDV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS,
+                                       create_flags=dve.HNSDV_QP_CREATE_ENABLE_DCA_MODE)
+                qp = HnsQP(self.ctx, qp_init_attr, attr)
+                self.qps.append(qp)
+                self.qps_num.append(qp.qp_num)
+                self.psns.append(random.getrandbits(24))
+        except PyverbsRDMAError as ex:
+            if ex.error_code == errno.EOPNOTSUPP:
+                raise unittest.SkipTest(f'Create DCA QP is not supported')
+            raise ex
+
+    def create_mr(self):
+        access = e.IBV_ACCESS_REMOTE_WRITE | e.IBV_ACCESS_LOCAL_WRITE
+        self.mr = MR(self.pd, self.msg_size, access)
diff --git a/tests/test_hns_dca.py b/tests/test_hns_dca.py
new file mode 100644
index 0000000..8f47fb1
--- /dev/null
+++ b/tests/test_hns_dca.py
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+import unittest
+import errno
+
+from pyverbs.pyverbs_error import PyverbsRDMAError
+import pyverbs.enums as e
+
+from tests.hns_base import HnsRDMATestCase
+from tests.hns_base import HnsDcaResources
+import tests.utils as u
+
+
+
+class QPDCATestCase(HnsRDMATestCase):
+    def setUp(self):
+        super().setUp()
+        self.iters = 100
+        self.server = None
+        self.client = None
+
+    def create_players(self, qp_count=8):
+        try:
+            self.client = HnsDcaResources(self.dev_name, self.ib_port, self.gid_index, qp_count)
+            self.server = HnsDcaResources(self.dev_name, self.ib_port, self.gid_index, qp_count)
+        except PyverbsRDMAError as ex:
+            if ex.error_code == errno.EOPNOTSUPP:
+                raise unittest.SkipTest('Create DCA Resources is not supported')
+            raise ex
+        self.client.pre_run(self.server.psns, self.server.qps_num)
+        self.server.pre_run(self.client.psns, self.client.qps_num)
+
+    def test_qp_ex_dca_send(self):
+        self.create_players()
+        u.traffic(self.client, self.server, self.iters, self.gid_index, self.ib_port,
+                  new_send=False)
-- 
2.8.1

