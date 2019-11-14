Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57730FC2BC
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 10:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKNJhz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 04:37:55 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:60673
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfKNJhz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 04:37:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9qpi3Av9H+8R57LZxdt1OgYcs2vaq4bBWEJ4YSlCH/ZsaUwpTYdvqQL6aJpD3grAd289Fb9HZruUrqi5z7u6aEH12Uch6ezi2RnvCT/7HpbjoH/NaERfpqhpWPxNSAGVCObbaTwXrzBOp79xEVB++ti2zqOlIG/s+RzrdPrk2Nxue1WozL5yZlzzTihz8kkOUAGCONJHyir8m/WzULpMj+HlxdsVgOwhJUggyJs9Q2r62+5j3MLIVallAhG2Jfr8rVZdC/MQlQ9H+iERuZiBaZdEUC7Afv+4owqsOzmUoUFGxyBY7YMUeFFVtsJ896IXBRxDjjgAKecHt14TsHWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FynntZjT6aPM/WYQ1esZjLei2Xa+aKaFu6Qth1Ho5tk=;
 b=Jy2N3/QYwBdVCqsUIPAI4UEjx173CwclF19DvXv3jbajwCq3pcSTzxrLsODUrx8gn6TqREsm6Ya3c4XcnfDU80kkyzi8aWsVOLpIx10OH9Gocz/8wz1qqqTOsFA4t3AARV4EClo6xA0L44drXsQhiHUBihYiHNBtHCnCYEV2pQ9FsPlW+Tz4pLKqgqmqun3JxBFqihwcvE1unP8pJkWjEbv5hhJu7rwSTCdKSAnUnq2XDWSpzlAcso6pNRtoK7lzMpxdRIOx5YiXYxHyZdrcNcZUFjwANzKVeXCRibDaLhcwVqIMAcKHe4ulKS/26OncegVT61yO+8OERTjQmYO/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FynntZjT6aPM/WYQ1esZjLei2Xa+aKaFu6Qth1Ho5tk=;
 b=KznzUaKJPITdB8kVa9PMAhk6QwESTWde/C7ZuyhFuCqVCRJgFeLrfLDitIGOxXzMP2Gsh0Eszk5aoP8wHl5TF4gc8UZGLSnxfjeywLYqwkkRYD3fzVxvlzACG8h1EteoXRXNPYny2BqCSak2g+xlaVreHK5jx9I7N0yIhJ++szk=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6230.eurprd05.prod.outlook.com (20.178.95.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 09:37:48 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 09:37:48 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 4/4] tests: Add a test for parent domain
Thread-Topic: [PATCH rdma-core 4/4] tests: Add a test for parent domain
Thread-Index: AQHVms8tNrNtgWDAi0O3CkLKEjwuIQ==
Date:   Thu, 14 Nov 2019 09:37:48 +0000
Message-ID: <20191114093732.12637-5-noaos@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
In-Reply-To: <20191114093732.12637-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0402CA0012.eurprd04.prod.outlook.com
 (2603:10a6:208:15::25) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da29954c-56e3-4ac9-ee92-08d768e64f97
x-ms-traffictypediagnostic: AM6PR05MB6230:|AM6PR05MB6230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6230E905B3659091E2D695F5D9710@AM6PR05MB6230.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(3846002)(256004)(14444005)(71190400001)(6116002)(71200400001)(14454004)(2906002)(478600001)(81166006)(81156014)(50226002)(8676002)(8936002)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(6512007)(4326008)(5660300002)(1076003)(6436002)(2501003)(107886003)(186003)(66066001)(476003)(446003)(2616005)(26005)(11346002)(6636002)(486006)(6486002)(36756003)(25786009)(110136005)(54906003)(316002)(305945005)(102836004)(386003)(52116002)(6506007)(7736002)(76176011)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6230;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+3GMSRvW053rcWS7UFJubVbBOQj3ZFgv4TeS/sGvoB6s/ccc3ZmYNe+/3aYgeTcofqQkrhScUGkuzdm5EHWLcewQ4s2HDf2Q8ivDKp+EAvRap9GgtGQ1OiWiOOQ06pB/V/9LsqTBfdMkem/wR4fmXailTJZrxES0FtIlv/udPFzF64IEpASj+gU/A2hnPoZiqvmoAGVVACEteod1WXbV4xIipEE9z2iIctuVSwhCz5qNt1wZ0m3HoAO0bkXc9z/R0DlRFrWLiFoW8zhfcsW7VoUXJvErSC8FO990tqwpZU3ZVoDhmdMgk38Ke/QifuwX8kCXf+XQvJK7kfISvyyEHtQIoWrncxoLirq7RydbAbBb7In6OUfNB4ZDwHDQc43lm5JAuJF/a+fHyWW67WQ9Wimmii2v/fn8zQapzH1u7+hHKRTpBHZfG+Y1EcJhugo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da29954c-56e3-4ac9-ee92-08d768e64f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:37:48.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4UF8o7sbP9KVPGBjviBhAEH1xzn0MMgAV3vRQ5cHTLhzR3ati+swT99CnB19v6nOido5yYL93f1E/QOn/zTvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6230
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

The test checks parent domain creation without custom allocators, with
custom allocators that return USE_DEFAULT (indicates the driver to use
the default allocator) and custom allocators with local memory allocation.
In addition, in each case a QP is created in order to verify the usage
of the allocators.

Signed-off-by: Edward Srouji <edwards@mellanox.com>
Reviewd-by: Noa Osherovich <noaos@mellanox.com>
---
 tests/CMakeLists.txt        |  1 +
 tests/test_parent_domain.py | 86 +++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tests/test_parent_domain.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 960276230860..4a8e4f6607c8 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -8,6 +8,7 @@ rdma_python_test(tests
   test_cq.py
   test_device.py
   test_mr.py
+  test_parent_domain.py
   test_pd.py
   test_qp.py
   test_odp.py
diff --git a/tests/test_parent_domain.py b/tests/test_parent_domain.py
new file mode 100644
index 000000000000..5731f6256d04
--- /dev/null
+++ b/tests/test_parent_domain.py
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See =
COPYING file
+"""
+Test module for Pyverbs' ParentDomain.
+"""
+from pyverbs.pd import ParentDomainInitAttr, ParentDomain, ParentDomainCon=
text
+from pyverbs.pyverbs_error import PyverbsRDMAError
+from pyverbs.srq import SrqAttr, SrqInitAttr, SRQ
+from pyverbs.qp import QPInitAttr, QP
+from tests.base import BaseResources
+from tests.base import RDMATestCase
+from pyverbs.base import MemAlloc
+import pyverbs.device as d
+import pyverbs.enums as e
+from pyverbs.cq import CQ
+import tests.utils as u
+import unittest
+
+
+class ParentDomainRes(BaseResources):
+    def __init__(self, dev_name, ib_port=3DNone, gid_index=3DNone):
+        super().__init__(dev_name=3Ddev_name, ib_port=3Dib_port,
+                         gid_index=3Dgid_index)
+        # Parent Domain will be created according to the test
+        self.pd_ctx =3D None
+        self.parent_domain =3D None
+
+
+class ParentDomainTestCase(RDMATestCase):
+    def setUp(self):
+        if self.dev_name is None:
+            dev =3D d.get_device_list()[-1]
+            self.dev_name =3D dev.name.decode()
+        self.pd_res =3D ParentDomainRes(self.dev_name)
+
+    def _create_parent_domain_with_allocators(self, alloc_func, free_func)=
:
+        if alloc_func and free_func:
+            self.pd_res.pd_ctx =3D ParentDomainContext(self.pd_res.pd, all=
oc_func,
+                                                     free_func)
+        pd_attr =3D ParentDomainInitAttr(pd=3Dself.pd_res.pd,
+                                       pd_context=3Dself.pd_res.pd_ctx)
+        try:
+            self.pd_res.parent_domain =3D ParentDomain(self.pd_res.ctx,
+                                                     attr=3Dpd_attr)
+        except PyverbsRDMAError as ex:
+            if 'not supported' in str(ex) or 'not implemented' in str(ex):
+                raise unittest.SkipTest('Parent Domain is not supported on=
 this device')
+            raise ex
+
+    def _create_rdma_objects(self):
+        cq =3D CQ(self.pd_res.ctx, 100, None, None, 0)
+        dev_attr =3D self.pd_res.ctx.query_device()
+        qp_cap =3D u.random_qp_cap(dev_attr)
+        qia =3D QPInitAttr(scq=3Dcq, rcq=3Dcq, cap=3Dqp_cap)
+        qia.qp_type =3D e.IBV_QPT_RC
+        QP(self.pd_res.parent_domain, qia)
+        srq_init_attr =3D SrqInitAttr(SrqAttr())
+        SRQ(self.pd_res.parent_domain, srq_init_attr)
+
+    def test_without_allocators(self):
+        self._create_parent_domain_with_allocators(None, None)
+        self._create_rdma_objects()
+        self.pd_res.parent_domain.close()
+
+    def test_default_allocators(self):
+        def alloc_p_func(pd, context, size, alignment, resource_type):
+            return e._IBV_ALLOCATOR_USE_DEFAULT
+
+        def free_p_func(pd, context, ptr, resource_type):
+            return e._IBV_ALLOCATOR_USE_DEFAULT
+
+        self._create_parent_domain_with_allocators(alloc_p_func, free_p_fu=
nc)
+        self._create_rdma_objects()
+        self.pd_res.parent_domain.close()
+
+    def test_mem_align_allocators(self):
+        def alloc_p_func(pd, context, size, alignment, resource_type):
+            p =3D MemAlloc.aligned_alloc(size, alignment)
+            return p
+
+        def free_p_func(pd, context, ptr, resource_type):
+            MemAlloc.free(ptr)
+
+        self._create_parent_domain_with_allocators(alloc_p_func, free_p_fu=
nc)
+        self._create_rdma_objects()
+        self.pd_res.parent_domain.close()
--=20
2.21.0

