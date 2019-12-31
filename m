Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CB12D755
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfLaJUW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:20:22 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfLaJUW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:20:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn4+d4qQ+x2pMdS9p1WhYf5A0B6tb0WW7Ecnkgk4hU3tB7M8PWCpQfAvoTAaLHXYJKSLRASUnFic9wzUkTohQioj7uO77VjZvPQz6d26VioAA7cpQKd8GUGI7e7+s9nUpgOFScvQvc0FKUuyn/vx+a0ZioIiPUVbIQD+RSmtX+FsesYuzNLabrh4UkmAd+wv6Czi3kbanPHZVtT4eCxDGf0oQ5vikYVldJYdcKoF+JFUItlQBRjNXOdlxc8lqGZbD5aavA6oBF20aAV3fiZhz35CT8g08kVNHoSDSOga7VX07wkKDqtBbUTJWiE1VTzl3uoGSxRrw++g0wizrU75/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCbbAQlv/pDec+mPE0jYeFQtiOl6X9Q+AkXMA6APJq4=;
 b=llQtMQsFzSCPQ9CsQaAHctyu/9nXstfV22elEIDjI6mJR2Pt24BvaVEAeQo0luHtSZVH7iwJ9jwsaUyYYOYPvhQkfyT2csCBGsdL8lWgVMwxsNOqbKg9SmVaKJLh4Y250g6NILPaUeYkrfrXG2I6cBKhPJs3dKkAXBwKytxCcXhVQ8LpCCgPmor8/hw9fYfSy5DMg+Qzwv3sNzHXnNDXMH7YRKZE3zHI+HKgZK57jFA6falRR1eRLdbSqzoQpU4h2MuPrZbjW7Bv2QOC5XfNJI2MbAFXnnvhQc+qVbwn1z7+xTk4y++/qW2IPIut93I2tYEXsgvYSr1/ouelfUA16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCbbAQlv/pDec+mPE0jYeFQtiOl6X9Q+AkXMA6APJq4=;
 b=XWpaSVebanV8+NIGHWMf2u1MyJRle8ZqggONp+aBi2jxHjqb5YK27/MkeyJOAl1+6so6Rq0Z+9aUHiVKjhifmWqX/1UW4dXpzZCT/90ZyH3temeYXwIT4ITKxlXZIb8YRqEGo+1UoFEZiWKGn+EREbFF+1yZ8qSXtpIyeSJgi9g=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:35 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:35 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:34 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 8/8] tests: Add test using the new post send API
Thread-Topic: [PATCH rdma-core 8/8] tests: Add test using the new post send
 API
Thread-Index: AQHVv7trXMBUg7S6tke3CiavnzokVg==
Date:   Tue, 31 Dec 2019 09:19:35 +0000
Message-ID: <20191231091915.23874-9-noaos@mellanox.com>
References: <20191231091915.23874-1-noaos@mellanox.com>
In-Reply-To: <20191231091915.23874-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94121827-beec-4f9e-f306-08d78dd28d85
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB374281EC074E349E6C382204D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(30864003)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o/2cWWMesBpJYn/wW+XKer4sJxkCWxdOD/cyb6An4Z1BefxOVjt5fOHxV69ZQoSgY8K4k4+/lxKg3bmTDPT2TS9UlyJeCARVd+pJmTLNag4fq2fhlQyf4xhfp39PixH4qewiQJNphB2PWGo0HZz5eIBfgF2NHfhhHlrFTKXBnNxfPEj8el+90ZQMtN/N69m5gi0V/LujMuwWm80IQoAO+Rs0o2lv1AXn0JgFq4NAhipRiVOyxCEBR2DsvOMqsq4XH3daf7Pkdhru0Z/U1ENkmKBSVjtjBbm0Fu4qQQYVQGTwWNU4Yx0oisjmqUowhMU6Z8dvF8ta4KJQ0mlQQG0gEz786va1KvGhX6HwPdMJfAHnw0HJESFQQk7jhUUKGxViUA8AuAerdqQxzSKKn05bA9d/ZpYmFgdB0djAl4XzU2EYsE+mmJKKV72mLXojndEA5vdmr7mWuz0/qPf7rlthX8lo8608jucLBDj8slA/DA0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94121827-beec-4f9e-f306-08d78dd28d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:35.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtGXPJItdawlTzMnChNCQ0a8TxTyci/94x5/GeVFV+AS0eA0NqttK5/uUzDi3hhgvEKLdfKiz3WpQr6Rkxmceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add simple traffic tests that use the new post_send API.
Currently tested include:
- UD: send, send with immediate
- RC: send, send with immediate, RDMA write, RDMA read, atomic fetch
  and add, atomic compare and swap, bind memory window
- XRC: send, send with immediate

The existing traffic methods - traffic() and xrc_traffic() were
modified to support usage of the new API and are now checking whether
a send_op was provided or not.

As RDMA read and write do not require receive WQEs to be posted, an
extra traffic method, rdma_traffic, was added to the tests' utils
section.

Creation of a customized memory region is now available in the tests'
utils section.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 tests/CMakeLists.txt |   1 +
 tests/test_odp.py    |  13 +-
 tests/test_qpex.py   | 295 +++++++++++++++++++++++++++++++++++++++++++
 tests/utils.py       | 207 +++++++++++++++++++++++++-----
 4 files changed, 478 insertions(+), 38 deletions(-)
 mode change 100755 =3D> 100644 tests/CMakeLists.txt
 create mode 100644 tests/test_qpex.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
old mode 100755
new mode 100644
index 6d702425886c..74930f69e19d
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -12,6 +12,7 @@ rdma_python_test(tests
   test_mr.py
   test_pd.py
   test_qp.py
+  test_qpex.py
   test_odp.py
   test_parent_domain.py
   test_rdmacm.py
diff --git a/tests/test_odp.py b/tests/test_odp.py
index d412a7792951..742ad81abb89 100755
--- a/tests/test_odp.py
+++ b/tests/test_odp.py
@@ -1,5 +1,5 @@
+from tests.utils import requires_odp, traffic, xrc_traffic, create_custom_=
mr
 from tests.base import RCResources, UDResources, XRCResources
-from tests.utils import requires_odp, traffic, xrc_traffic
 from tests.base import RDMATestCase
 from pyverbs.mr import MR
 import pyverbs.enums as e
@@ -8,21 +8,20 @@ import pyverbs.enums as e
 class OdpUD(UDResources):
     @requires_odp('ud')
     def create_mr(self):
-        self.mr =3D MR(self.pd, self.msg_size + self.GRH_SIZE,
-                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
+        self.mr =3D create_custom_mr(self, e.IBV_ACCESS_ON_DEMAND,
+                                   self.msg_size + self.GRH_SIZE)
=20
=20
 class OdpRC(RCResources):
     @requires_odp('rc')
     def create_mr(self):
-        self.mr =3D MR(self.pd, self.msg_size,
-                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
+        self.mr =3D create_custom_mr(self, e.IBV_ACCESS_ON_DEMAND)
+
=20
 class OdpXRC(XRCResources):
     @requires_odp('xrc')
     def create_mr(self):
-        self.mr =3D MR(self.pd, self.msg_size,
-                     e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_ON_DEMAND)
+        self.mr =3D create_custom_mr(self, e.IBV_ACCESS_ON_DEMAND)
=20
=20
 class OdpTestCase(RDMATestCase):
diff --git a/tests/test_qpex.py b/tests/test_qpex.py
new file mode 100644
index 000000000000..922010bce3e5
--- /dev/null
+++ b/tests/test_qpex.py
@@ -0,0 +1,295 @@
+import unittest
+import random
+
+from pyverbs.qp import QPCap, QPInitAttrEx, QPAttr, QPEx, QP
+from pyverbs.pyverbs_error import PyverbsRDMAError
+from pyverbs.mr import MW, MWBindInfo
+from pyverbs.base import inc_rkey
+import pyverbs.enums as e
+from pyverbs.mr import MR
+
+from tests.base import UDResources, RCResources, RDMATestCase, XRCResource=
s
+import tests.utils as u
+
+
+def create_qp_ex(agr_obj, qp_type, send_flags):
+    if qp_type =3D=3D e.IBV_QPT_XRC_SEND:
+        cap =3D QPCap(max_send_wr=3Dagr_obj.num_msgs, max_recv_wr=3D0, max=
_recv_sge=3D0,
+                    max_send_sge=3D1)
+    else:
+        cap =3D QPCap(max_send_wr=3Dagr_obj.num_msgs, max_recv_wr=3Dagr_ob=
j.num_msgs,
+                    max_recv_sge=3D1, max_send_sge=3D1)
+    qia =3D QPInitAttrEx(cap=3Dcap, qp_type=3Dqp_type, scq=3Dagr_obj.cq,
+                       rcq=3Dagr_obj.cq, pd=3Dagr_obj.pd, send_ops_flags=
=3Dsend_flags,
+                       comp_mask=3De.IBV_QP_INIT_ATTR_PD |
+                                 e.IBV_QP_INIT_ATTR_SEND_OPS_FLAGS)
+    qp_attr =3D QPAttr(port_num=3Dagr_obj.ib_port)
+    if qp_type =3D=3D e.IBV_QPT_UD:
+        qp_attr.qkey =3D agr_obj.UD_QKEY
+        qp_attr.pkey_index =3D agr_obj.UD_PKEY_INDEX
+    if qp_type =3D=3D e.IBV_QPT_RC:
+        qp_attr.qp_access_flags =3D e.IBV_ACCESS_REMOTE_WRITE | \
+                                  e.IBV_ACCESS_REMOTE_READ | \
+                                  e.IBV_ACCESS_REMOTE_ATOMIC
+    try:
+        # We don't have capability bits for this
+        qp =3D QPEx(agr_obj.ctx, qia, qp_attr)
+    except PyverbsRDMAError as exp:
+        if 'Operation not supported' in exp.args[0]:
+            raise unittest.SkipTest('Extended QP not supported on this dev=
ice')
+        raise exp
+    return qp
+
+
+class QpExUDSend(UDResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_UD, e.IBV_QP_EX_WITH_SEND=
)
+
+
+class QpExRCSend(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_SEND=
)
+
+
+class QpExXRCSend(XRCResources):
+    def create_qp(self):
+        qp_attr =3D QPAttr(port_num=3Dself.ib_port)
+        qp_attr.pkey_index =3D 0
+        for _ in range(self.qp_count):
+            attr_ex =3D QPInitAttrEx(qp_type=3De.IBV_QPT_XRC_RECV,
+                                   comp_mask=3De.IBV_QP_INIT_ATTR_XRCD,
+                                   xrcd=3Dself.xrcd)
+            qp_attr.qp_access_flags =3D e.IBV_ACCESS_REMOTE_WRITE | \
+                                      e.IBV_ACCESS_REMOTE_READ
+            recv_qp =3D QP(self.ctx, attr_ex, qp_attr)
+            self.rqp_lst.append(recv_qp)
+
+            send_qp =3D create_qp_ex(self, e.IBV_QPT_XRC_SEND, e.IBV_QP_EX=
_WITH_SEND)
+            self.sqp_lst.append(send_qp)
+            self.qps_num.append((recv_qp.qp_num, send_qp.qp_num))
+            self.psns.append(random.getrandbits(24))
+
+
+class QpExUDSendImm(UDResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_UD, e.IBV_QP_EX_WITH_SEND=
_WITH_IMM)
+
+
+class QpExRCSendImm(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_SEND=
_WITH_IMM)
+
+
+class QpExXRCSendImm(XRCResources):
+    def create_qp(self):
+        qp_attr =3D QPAttr(port_num=3Dself.ib_port)
+        qp_attr.pkey_index =3D 0
+        for _ in range(self.qp_count):
+            attr_ex =3D QPInitAttrEx(qp_type=3De.IBV_QPT_XRC_RECV,
+                                   comp_mask=3De.IBV_QP_INIT_ATTR_XRCD,
+                                   xrcd=3Dself.xrcd)
+            qp_attr.qp_access_flags =3D e.IBV_ACCESS_REMOTE_WRITE | \
+                                      e.IBV_ACCESS_REMOTE_READ
+            recv_qp =3D QP(self.ctx, attr_ex, qp_attr)
+            self.rqp_lst.append(recv_qp)
+
+            send_qp =3D create_qp_ex(self, e.IBV_QPT_XRC_SEND,
+                                   e.IBV_QP_EX_WITH_SEND_WITH_IMM)
+            self.sqp_lst.append(send_qp)
+            self.qps_num.append((recv_qp.qp_num, send_qp.qp_num))
+            self.psns.append(random.getrandbits(24))
+
+
+class QpExRCRDMAWrite(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_RDMA=
_WRITE)
+
+    def create_mr(self):
+        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
+
+
+class QpExRCRDMAWriteImm(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC,
+                               e.IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM)
+
+    def create_mr(self):
+        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
+
+
+class QpExRCRDMARead(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_RDMA=
_READ)
+
+    def create_mr(self):
+        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_READ)
+
+
+class QpExRCAtomicCmpSwp(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC,
+                               e.IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP)
+        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_ATOMIC)
+
+
+class QpExRCAtomicFetchAdd(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC,
+                               e.IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
+        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_ATOMIC)
+
+
+class QpExRCBindMw(RCResources):
+    def create_qp(self):
+        self.qp =3D create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND=
_MW)
+
+    def create_mr(self):
+        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
+
+
+class QpExTestCase(RDMATestCase):
+    """ Run traffic using the new post send API. """
+    def setUp(self):
+        super().setUp()
+        self.iters =3D 100
+        self.qp_dict =3D {'ud_send': QpExUDSend, 'rc_send': QpExRCSend,
+                        'xrc_send': QpExXRCSend, 'ud_send_imm': QpExUDSend=
Imm,
+                        'rc_send_imm': QpExRCSendImm,
+                        'xrc_send_imm': QpExXRCSendImm,
+                        'rc_write': QpExRCRDMAWrite,
+                        'rc_write_imm': QpExRCRDMAWriteImm,
+                        'rc_read': QpExRCRDMARead,
+                        'rc_cmp_swp': QpExRCAtomicCmpSwp,
+                        'rc_fetch_add': QpExRCAtomicFetchAdd,
+                        'rc_bind_mw': QpExRCBindMw}
+
+    def create_players(self, qp_type):
+        client =3D self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        server =3D self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        if 'xrc' in qp_type:
+            client.pre_run(server.psns, server.qps_num)
+            server.pre_run(client.psns, client.qps_num)
+        else:
+            client.pre_run(server.psn, server.qpn)
+            server.pre_run(client.psn, client.qpn)
+        return client, server
+
+    def test_qp_ex_ud_send(self):
+        client, server =3D self.create_players('ud_send')
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_SEND)
+
+    def test_qp_ex_rc_send(self):
+        client, server =3D self.create_players('rc_send')
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_SEND)
+
+    def test_qp_ex_xrc_send(self):
+        client, server =3D self.create_players('xrc_send')
+        u.xrc_traffic(client, server, send_op=3De.IBV_QP_EX_WITH_SEND)
+
+    def test_qp_ex_ud_send_imm(self):
+        client, server =3D self.create_players('ud_send_imm')
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_SEND_WITH_I=
MM)
+
+    def test_qp_ex_rc_send_imm(self):
+        client, server =3D self.create_players('rc_send_imm')
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_SEND_WITH_I=
MM)
+
+    def test_qp_ex_xrc_send_imm(self):
+        client, server =3D self.create_players('xrc_send_imm')
+        u.xrc_traffic(client, server, send_op=3De.IBV_QP_EX_WITH_SEND_WITH=
_IMM)
+
+    def test_qp_ex_rc_rdma_write(self):
+        client, server =3D self.create_players('rc_write')
+        client.rkey =3D server.mr.rkey
+        server.rkey =3D client.mr.rkey
+        client.raddr =3D server.mr.buf
+        server.raddr =3D client.mr.buf
+        u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib=
_port,
+                       is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_RDMA_W=
RITE)
+
+    def test_qp_ex_rc_rdma_write_imm(self):
+        client, server =3D self.create_players('rc_write_imm')
+        client.rkey =3D server.mr.rkey
+        server.rkey =3D client.mr.rkey
+        client.raddr =3D server.mr.buf
+        server.raddr =3D client.mr.buf
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_RDMA_WRITE_=
WITH_IMM)
+
+    def test_qp_ex_rc_rdma_read(self):
+        client, server =3D self.create_players('rc_read')
+        client.rkey =3D server.mr.rkey
+        server.rkey =3D client.mr.rkey
+        client.raddr =3D server.mr.buf
+        server.raddr =3D client.mr.buf
+        server.mr.write('s' * server.msg_size, server.msg_size)
+        u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib=
_port,
+                       is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_RDMA_R=
EAD)
+
+    def test_qp_ex_rc_atomic_cmp_swp(self):
+        client, server =3D self.create_players('rc_cmp_swp')
+        client.msg_size =3D 8  # Atomic work on 64b operators
+        server.msg_size =3D 8
+        client.rkey =3D server.mr.rkey
+        server.rkey =3D client.mr.rkey
+        client.raddr =3D server.mr.buf
+        server.raddr =3D client.mr.buf
+        server.mr.write('s' * 8, 8)
+        u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib=
_port,
+                       is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_ATOMIC=
_CMP_AND_SWP)
+
+    def test_qp_ex_rc_atomic_fetch_add(self):
+        client, server =3D self.create_players('rc_fetch_add')
+        client.msg_size =3D 8  # Atomic work on 64b operators
+        server.msg_size =3D 8
+        client.rkey =3D server.mr.rkey
+        server.rkey =3D client.mr.rkey
+        client.raddr =3D server.mr.buf
+        server.raddr =3D client.mr.buf
+        server.mr.write('s' * 8, 8)
+        u.rdma_traffic(client, server, self.iters, self.gid_index, self.ib=
_port,
+                       is_cq_ex=3DFalse, send_op=3De.IBV_QP_EX_WITH_ATOMIC=
_FETCH_AND_ADD)
+
+    def test_qp_ex_rc_bind_mw(self):
+        """
+        Verify bind memory window operation using the new post_send API.
+        Instead of checking through regular pingpong style traffic, we'll
+        do as follows:
+        - Register an MR with remote write access
+        - Bind a MW without remote write permission to the MR
+        - Verify that remote write fails
+        Since it's a unique flow, it's an integral part of that test rathe=
r
+        than a utility method.
+        """
+        client, server =3D self.create_players('rc_bind_mw')
+        client_sge =3D u.get_send_element(client, False)[1]
+        # Create a MW and bind it
+        server.qp.wr_start()
+        server.qp.wr_id =3D 0x123
+        server.qp.wr_flags =3D e.IBV_SEND_SIGNALED
+        bind_info =3D MWBindInfo(server.mr, server.mr.buf, server.mr.lengt=
h,
+                               e.IBV_ACCESS_LOCAL_WRITE)
+        mw =3D MW(server.pd, mw_type=3De.IBV_MW_TYPE_2)
+        new_key =3D inc_rkey(server.mr.rkey)
+        server.qp.wr_bind_mw(mw, new_key, bind_info)
+        server.qp.wr_complete()
+        u.poll_cq(server.cq)
+        # Verify remote write fails
+        client.qp.wr_start()
+        client.qp.wr_id =3D 0x124
+        client.qp.wr_flags =3D e.IBV_SEND_SIGNALED
+        client.qp.wr_rdma_write(new_key, server.mr.buf)
+        client.qp.wr_set_sge(client_sge)
+        client.qp.wr_complete()
+        try:
+            u.poll_cq(client.cq)
+        except PyverbsRDMAError as exp:
+            if 'Completion status is Remote access error' not in exp.args[=
0]:
+                raise exp
+
diff --git a/tests/utils.py b/tests/utils.py
index 47eacfee35e5..20132a7cf40b 100755
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -7,6 +7,7 @@ from itertools import combinations as com
 from string import ascii_lowercase as al
 import unittest
 import random
+import socket
=20
 from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
 from pyverbs.addr import AHAttr, AH, GlobalRoute
@@ -16,6 +17,7 @@ from tests.base import XRCResources
 from pyverbs.cq import PollCqAttr
 import pyverbs.device as d
 import pyverbs.enums as e
+from pyverbs.mr import MR
=20
 MAX_MR_SIZE =3D 4194304
 # Some HWs limit DM address and length alignment to 4 for read and write
@@ -29,6 +31,7 @@ MAX_DM_LOG_ALIGN =3D 6
 # Raw Packet QP supports TSO header, which creates a larger send WQE.
 MAX_RAW_PACKET_SEND_WR =3D 2500
 GRH_SIZE =3D 40
+IMM_DATA =3D 1234
=20
=20
 def get_mr_length():
@@ -197,7 +200,7 @@ def random_qp_create_flags(qpt, attr_ex):
=20
 def random_qp_init_attr_ex(attr_ex, attr, qpt=3DNone):
     """
-    Create a random-valued QPInitAttrEX object with the given QP type.
+    Create a random-valued QPInitAttrEx object with the given QP type.
     QP type affects QP capabilities, so allow users to set it and still ge=
t
     valid attributes.
     :param attr_ex: Extended device attributes for capability checks
@@ -251,24 +254,38 @@ def wc_status_to_str(status):
     except KeyError:
         return 'Unknown WC status ({s})'.format(s=3Dstatus)
=20
+
+def create_custom_mr(agr_obj, additional_access_flags=3D0, size=3DNone):
+    """
+    Creates a memory region using the aggregation object's PD.
+    If size is None, the agr_obj's message size is used to set the MR's si=
ze.
+    The access flags are local write and the additional_access_flags.
+    :param agr_obj: The aggregation object that creates the MR
+    :param additional_access_flags: Addition access flags to set in the MR
+    :param size: MR's length. If None, agr_obj.msg_size is used.
+    """
+    mr_length =3D size if size else agr_obj.msg_size
+    return MR(agr_obj.pd, mr_length,
+              e.IBV_ACCESS_LOCAL_WRITE | additional_access_flags)
+
 # Traffic helpers
=20
-def get_send_wr(agr_obj, is_server):
+def get_send_element(agr_obj, is_server):
     """
-    Creates a single SGE Send WR for agr_obj's QP type. The content of the
-    message is either 's' for server side or 'c' for client side.
+    Creates a single SGE and a single Send WR for agr_obj's QP type. The c=
ontent
+    of the message is either 's' for server side or 'c' for client side.
     :param agr_obj: Aggregation object which contains all resources necess=
ary
     :param is_server: Indicates whether this is server or client side
-    :return: send wr
+    :return: send wr and its SGE
     """
+    mr =3D agr_obj.mr
     qp_type =3D agr_obj.sqp_lst[0].qp_type if isinstance(agr_obj, XRCResou=
rces) \
                 else agr_obj.qp.qp_type
-    mr =3D agr_obj.mr
     offset =3D GRH_SIZE if qp_type =3D=3D e.IBV_QPT_UD else 0
-    send_sge =3D SGE(mr.buf + offset, agr_obj.msg_size, mr.lkey)
     msg =3D (agr_obj.msg_size + offset) * ('s' if is_server else 'c')
     mr.write(msg, agr_obj.msg_size + offset)
-    return SendWR(num_sge=3D1, sg=3D[send_sge])
+    sge =3D SGE(mr.buf + offset, agr_obj.msg_size, mr.lkey)
+    return SendWR(num_sge=3D1, sg=3D[sge]), sge
=20
=20
 def get_recv_wr(agr_obj):
@@ -286,6 +303,64 @@ def get_recv_wr(agr_obj):
     return RecvWR(sg=3D[recv_sge], num_sge=3D1)
=20
=20
+def get_global_ah(agr_obj, gid_index, port):
+    gr =3D GlobalRoute(dgid=3Dagr_obj.ctx.query_gid(port, gid_index),
+                     sgid_index=3Dgid_index)
+    ah_attr =3D AHAttr(port_num=3Dport, is_global=3D1, gr=3Dgr,
+                     dlid=3Dagr_obj.port_attr.lid)
+    return AH(agr_obj.pd, attr=3Dah_attr)
+
+
+def xrc_post_send(agr_obj, qp_num, send_object, gid_index, port, send_op=
=3DNone):
+    agr_obj.qp =3D agr_obj.sqp_lst[qp_num]
+    if send_op:
+        post_send_ex(agr_obj, send_object, gid_index, port, send_op)
+    else:
+        post_send(agr_obj, send_object, gid_index, port)
+
+
+def post_send_ex(agr_obj, send_object, gid_index, port, send_op=3DNone):
+    qp_type =3D agr_obj.qp.qp_type
+    agr_obj.qp.wr_start()
+    agr_obj.qp.wr_id =3D 0x123
+    agr_obj.qp.wr_flags =3D e.IBV_SEND_SIGNALED
+    if send_op =3D=3D e.IBV_QP_EX_WITH_SEND:
+        agr_obj.qp.wr_send()
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_RDMA_WRITE:
+        agr_obj.qp.wr_rdma_write(agr_obj.rkey, agr_obj.raddr)
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_SEND_WITH_IMM:
+        agr_obj.qp.wr_send_imm(IMM_DATA)
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM:
+        agr_obj.qp.wr_rdma_write_imm(agr_obj.rkey, agr_obj.raddr, IMM_DATA=
)
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_RDMA_READ:
+        agr_obj.qp.wr_rdma_read(agr_obj.rkey, agr_obj.raddr)
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP:
+        # We're checking the returned value (remote's content), so cmp/swp
+        # values are of no importance.
+        agr_obj.qp.wr_atomic_cmp_swp(agr_obj.rkey, agr_obj.raddr, 42, 43)
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD:
+        agr_obj.qp.wr_atomic_fetch_add(agr_obj.rkey, agr_obj.raddr, 1)
+    elif send_op =3D=3D e.IBV_QP_EX_WITH_BIND_MW:
+        bind_info =3D MWBindInfo(agr_obj.mr, agr_obj.mr.buf, agr_obj.mr.rk=
ey,
+                               e.IBV_ACCESS_REMOTE_WRITE)
+        mw =3D MW(agr_obj.pd, mw_type=3De.IBV_MW_TYPE_2)
+        # A new rkey is needed to be set into bind_info, modify rkey
+        agr_obj.qp.wr_bind_mw(mw, agr_obj.mr.rkey + 12, bind_info)
+        agr_obj.qp.wr_complete()
+        return
+        #agr_obj.qp.wr_start()
+        #agr_obj.qp.wr_id =3D 0x123
+        #agr_obj.qp.wr_flags =3D e.IBV_SEND_SIGNALED
+        #agr_obj.qp.wr_send()
+    if qp_type =3D=3D e.IBV_QPT_UD:
+        ah =3D get_global_ah(agr_obj, gid_index, port)
+        agr_obj.qp.wr_set_ud_addr(ah, agr_obj.rqpn, agr_obj.UD_QKEY)
+    if qp_type =3D=3D e.IBV_QPT_XRC_SEND:
+        agr_obj.qp.wr_set_xrc_srqn(agr_obj.remote_srqn)
+    agr_obj.qp.wr_set_sge(send_object)
+    agr_obj.qp.wr_complete()
+
+
 def post_send(agr_obj, send_wr, gid_index, port):
     """
     Post a single send WR to the QP. Post_send's second parameter (send ba=
d wr)
@@ -299,11 +374,7 @@ def post_send(agr_obj, send_wr, gid_index, port):
     """
     qp_type =3D agr_obj.qp.qp_type
     if qp_type =3D=3D e.IBV_QPT_UD:
-        gr =3D GlobalRoute(dgid=3Dagr_obj.ctx.query_gid(port, gid_index),
-                         sgid_index=3Dgid_index)
-        ah_attr =3D AHAttr(port_num=3Dport, is_global=3D1, gr=3Dgr,
-                         dlid=3Dagr_obj.port_attr.lid)
-        ah =3D AH(agr_obj.pd, attr=3Dah_attr)
+        ah =3D get_global_ah(agr_obj, gid_index, port)
         send_wr.set_wr_ud(ah, agr_obj.rqpn, agr_obj.UD_QKEY)
     agr_obj.qp.post_send(send_wr, None)
=20
@@ -321,7 +392,7 @@ def post_recv(qp, recv_wr, num_wqes=3D1):
         qp.post_recv(recv_wr, None)
=20
=20
-def poll_cq(cq, count=3D1):
+def poll_cq(cq, count=3D1, data=3DNone):
     """
     Poll <count> completions from the CQ.
     Note: This function calls the blocking poll() method of the CQ
@@ -329,6 +400,8 @@ def poll_cq(cq, count=3D1):
     single CQ event when events are used.
     :param cq: CQ to poll from
     :param count: How many completions to poll
+    :param data: In case of a work request with immediate, the immediate d=
ata
+                 to be compared after poll
     :return: An array of work completions of length <count>, None
              when events are used
     """
@@ -339,15 +412,21 @@ def poll_cq(cq, count=3D1):
             if wc.status !=3D e.IBV_WC_SUCCESS:
                 raise PyverbsRDMAError('Completion status is {s}'.
                                        format(s=3Dwc_status_to_str(wc.stat=
us)))
+            if data:
+                if wc.wc_flags & e.IBV_WC_WITH_IMM =3D=3D 0:
+                    raise PyverbsRDMAError('Completion without immediate')
+                assert socket.ntohl(wc.imm_data) =3D=3D data
         count -=3D nc
     return wcs
=20
=20
-def poll_cq_ex(cqex, count=3D1):
+def poll_cq_ex(cqex, count=3D1, data=3DNone):
     """
     Poll <count> completions from the extended CQ.
     :param cq: CQEX to poll from
     :param count: How many completions to poll
+    :param data: In case of a work request with immediate, the immediate d=
ata
+                 to be compared after poll
     :return: None
     """
     poll_attr =3D PollCqAttr()
@@ -360,6 +439,8 @@ def poll_cq_ex(cqex, count=3D1):
     if cqex.status !=3D e.IBV_WC_SUCCESS:
         raise PyverbsRDMAErrno('Completion status is {s}'.
                                format(s=3Dcqex.status))
+    if data:
+        assert data =3D=3D socket.ntohl(cqex.read_imm_data())
     # Now poll the rest of the packets
     while count > 0:
         ret =3D cqex.poll_next()
@@ -370,6 +451,8 @@ def poll_cq_ex(cqex, count=3D1):
         if cqex.status !=3D e.IBV_WC_SUCCESS:
             raise PyverbsRDMAErrno('Completion status is {s}'.
                                    format(s=3Dcqex.status))
+        if data:
+            assert data =3D=3D socket.ntohl(cqex.read_imm_data())
         count -=3D 1
     cqex.end_poll()
=20
@@ -398,7 +481,13 @@ def validate(received_str, is_server, msg_size):
                 format(exp=3Dexpected_str, rcv=3Dreceived_str))
=20
=20
-def traffic(client, server, iters, gid_idx, port, is_cq_ex=3DFalse):
+def send(agr_obj, send_wr, gid_index, port, send_op=3DNone):
+    if send_op:
+        return post_send_ex(agr_obj, send_wr, gid_index, port, send_op)
+    return post_send(agr_obj, send_wr, gid_index, port)
+
+
+def traffic(client, server, iters, gid_idx, port, is_cq_ex=3DFalse, send_o=
p=3DNone):
     """
     Runs basic traffic between two sides
     :param client: client side, clients base class is BaseTraffic
@@ -407,32 +496,83 @@ def traffic(client, server, iters, gid_idx, port, is_=
cq_ex=3DFalse):
     :param gid_idx: local gid index
     :param port: IB port
     :param is_cq_ex: If True, use poll_cq_ex() rather than poll_cq()
+    :param send_op: If not None, new post send API is assumed.
     :return:
     """
     poll =3D poll_cq_ex if is_cq_ex else poll_cq
+    if send_op =3D=3D e.IBV_QP_EX_WITH_SEND_WITH_IMM or \
+       send_op =3D=3D e.IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM:
+        imm_data =3D IMM_DATA
+    else:
+        imm_data =3D None
+    # Using the new post send API, we need the SGE, not the SendWR
+    send_element_idx =3D 1 if send_op else 0
     s_recv_wr =3D get_recv_wr(server)
     c_recv_wr =3D get_recv_wr(client)
     post_recv(client.qp, c_recv_wr, client.num_msgs)
     post_recv(server.qp, s_recv_wr, server.num_msgs)
     read_offset =3D GRH_SIZE if client.qp.qp_type =3D=3D e.IBV_QPT_UD else=
 0
     for _ in range(iters):
-        c_send_wr =3D get_send_wr(client, False)
-        post_send(client, c_send_wr, gid_idx, port)
+        c_send_wr =3D get_send_element(client, False)[send_element_idx]
+        send(client, c_send_wr, gid_idx, port, send_op)
         poll(client.cq)
-        poll(server.cq)
+        poll(server.cq, data=3Dimm_data)
         post_recv(server.qp, s_recv_wr)
         msg_received =3D server.mr.read(server.msg_size, read_offset)
         validate(msg_received, True, server.msg_size)
-        s_send_wr =3D get_send_wr(server, True)
-        post_send(server, s_send_wr, gid_idx, port)
+        s_send_wr =3D get_send_element(server, True)[send_element_idx]
+        send(server, s_send_wr, gid_idx, port, send_op)
         poll(server.cq)
-        poll(client.cq)
+        poll(client.cq, data=3Dimm_data)
         post_recv(client.qp, c_recv_wr)
         msg_received =3D client.mr.read(client.msg_size, read_offset)
         validate(msg_received, False, client.msg_size)
=20
=20
-def xrc_traffic(client, server, is_cq_ex=3DFalse):
+def rdma_traffic(client, server, iters, gid_idx, port, is_cq_ex=3DFalse, s=
end_op=3DNone):
+    """
+    Runs basic RDMA traffic between two sides. No receive WQEs are posted.=
 For
+    RDMA send with immediate, use traffic().
+    :param client: client side, clients base class is BaseTraffic
+    :param server: server side, servers base class is BaseTraffic
+    :param iters: number of traffic iterations
+    :param gid_idx: local gid index
+    :param port: IB port
+    :param is_cq_ex: If True, use poll_cq_ex() rather than poll_cq()
+    :param send_op: If not None, new post send API is assumed.
+    :return:
+    """
+    # Using the new post send API, we need the SGE, not the SendWR
+    send_element_idx =3D 1 if send_op else 0
+    same_side_check =3D (send_op =3D=3D e.IBV_QP_EX_WITH_RDMA_READ or
+                       send_op =3D=3D e.IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP =
or
+                       send_op =3D=3D e.IBV_QP_EX_WITH_ATOMIC_FETCH_AND_AD=
D)
+    for _ in range(iters):
+        c_send_wr =3D get_send_element(client, False)[send_element_idx]
+        send(client, c_send_wr, gid_idx, port, send_op)
+        poll_cq(client.cq)
+        if same_side_check:
+            msg_received =3D client.mr.read(client.msg_size, 0)
+        else:
+            msg_received =3D server.mr.read(server.msg_size, 0)
+        validate(msg_received, False if same_side_check else True,
+                 server.msg_size)
+        s_send_wr =3D get_send_element(server, True)[send_element_idx]
+        if same_side_check:
+            client.mr.write('c' * client.msg_size, client.msg_size)
+        send(server, s_send_wr, gid_idx, port, send_op)
+        poll_cq(server.cq)
+        if same_side_check:
+            msg_received =3D server.mr.read(client.msg_size, 0)
+        else:
+            msg_received =3D client.mr.read(server.msg_size, 0)
+        validate(msg_received, True if same_side_check else False,
+                 client.msg_size)
+        if same_side_check:
+            server.mr.write('s' * server.msg_size, server.msg_size)
+
+
+def xrc_traffic(client, server, is_cq_ex=3DFalse, send_op=3DNone):
     """
     Runs basic xrc traffic, this function assumes that number of QPs, whic=
h
     server and client have are equal, server.send_qp[i] is connected to
@@ -444,27 +584,32 @@ def xrc_traffic(client, server, is_cq_ex=3DFalse):
     :param server: Aggregation object of the passive side, should be an in=
stance
     of XRCResources class
     :param is_cq_ex: If True, use poll_cq_ex() rather than poll_cq()
+    :param send_op: If not None, new post send API is assumed.
     :return: None
     """
     poll =3D poll_cq_ex if is_cq_ex else poll_cq
-    client_srqn =3D client.srq.get_srq_num()
-    server_srqn =3D server.srq.get_srq_num()
+    server.remote_srqn =3D client.srq.get_srq_num()
+    client.remote_srqn =3D server.srq.get_srq_num()
     s_recv_wr =3D get_recv_wr(server)
     c_recv_wr =3D get_recv_wr(client)
     post_recv(client.srq, c_recv_wr, client.qp_count*client.num_msgs)
     post_recv(server.srq, s_recv_wr, server.qp_count*server.num_msgs)
+    # Using the new post send API, we need the SGE, not the SendWR
+    send_element_idx =3D 1 if send_op else 0
     for _ in range(client.num_msgs):
         for i in range(server.qp_count):
-            c_send_wr =3D get_send_wr(client, False)
-            c_send_wr.set_qp_type_xrc(server_srqn)
-            client.sqp_lst[i].post_send(c_send_wr)
+            c_send_wr =3D get_send_element(client, False)[send_element_idx=
]
+            if send_op is None:
+                c_send_wr.set_qp_type_xrc(client.remote_srqn)
+            xrc_post_send(client, i, c_send_wr, 0, 0, send_op)
             poll(client.cq)
             poll(server.cq)
             msg_received =3D server.mr.read(server.msg_size, 0)
             validate(msg_received, True, server.msg_size)
-            s_send_wr =3D get_send_wr(server, True)
-            s_send_wr.set_qp_type_xrc(client_srqn)
-            server.sqp_lst[i].post_send(s_send_wr)
+            s_send_wr =3D get_send_element(server, True)[send_element_idx]
+            if send_op is None:
+                s_send_wr.set_qp_type_xrc(server.remote_srqn)
+            xrc_post_send(server, i, s_send_wr, 0, 0, send_op)
             poll(server.cq)
             poll(client.cq)
             msg_received =3D client.mr.read(client.msg_size, 0)
--=20
2.21.0

