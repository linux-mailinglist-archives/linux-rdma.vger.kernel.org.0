Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B2FF9E5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQNa4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:56 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:28158
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfKQNa4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgX59edmJaUT3ITOCGM/94JH+CBxeOraXYCdObCv/6MweB7AqfTVmbfFteZkIYDES9SMi1H2nuZgykIWrEpfVRApRvc9tWmw9RTcswLeExlGFWiqvPZt5xfaxyGzZMH5pufmAan+JpeSKmQj90cGGR9f/F/SSwMGzbvXvkNKFmT01Q/JOihhu+ghEepRBieairaahNHKsrimYBiM0hjLPumUUFliGGBtRg0Ga+uz9MoN0pHkuVBFquiUpioVTjL6r5Yszgq33faSAxIhIEGZk1gZEW+Wl1gW8vZk66enigXgvD1/yaC32TJ6Fyp8LF2oST56xbDDnUr7HA7nzgtYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTU2iS7FimODVNjIUMdlN9MslOwrf/ny+FLNs6Oa8no=;
 b=ku5mUaVc/Zig2YaqZ6LCPMdzlTeuYi1V3vhAXqhGQ8/StWSA3RzYrAHzmZcefTAJLpWGcKVJw7m6mK6FW6mmGAb1k2SmU33eInH9n2NS/AFVN1ZR2BUFMmvpVTKV61WrF7WiEYEy5t142GDH4ncrG2Y6oS5XQupLzya2Mr8tX1NWkN1/xhHND17WOQ6wJtUtN3UpamWFCDpJiaj0Go4MwQY05dJoPQeE6x9Zjgp+WDd5aUCI1FI2jeRE70n2MI432XIjIeRV2gQdWAwVhQRjA+PEAUtj6p4MQa+sipmx05ci00DQ5PZ1DVayRn+bsT0NjbiHa5BJWE3idyODQY0Jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTU2iS7FimODVNjIUMdlN9MslOwrf/ny+FLNs6Oa8no=;
 b=EuI1i11VOottmT74DukgSo9odoQcRWKKdkhx9CTSf2rvs28e18Z1YuOxKfOmtZUPX7yuglwqviAmCjsSePkX9DcThJirvc599maRHAyeWYUz9xKZj1u/pIMOjk3MOcFJo/GG0i9sutQipYixVmnXBm/aIezjREzwX7NwAV+g4U0=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:47 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:47 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 7/7] tests: Add traffic tests using extended CQ
Thread-Topic: [PATCH rdma-core 7/7] tests: Add traffic tests using extended CQ
Thread-Index: AQHVnUs42Nt8N1GNE0yWI7VU8Tbn0A==
Date:   Sun, 17 Nov 2019 13:30:47 +0000
Message-ID: <20191117133030.10784-8-noaos@mellanox.com>
References: <20191117133030.10784-1-noaos@mellanox.com>
In-Reply-To: <20191117133030.10784-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::29) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32f9babe-1ac5-418f-400c-08d76b625af8
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6598BE311F6247F2F800CDC9D9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:144;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(14444005)(54906003)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtMhjGTfLYewdqOYN+1qAqyRKFnsaukLpzoaX5ajnENFA/YxI9BJMU++dpDtMbvvGXJZtypnZqg7qYIxdchu+2j+o/3zvI+ftalFoDa9mz4wCyk8SiAJEj/FWqnEBVSDEv3i1B8lTTwGF1ZHZgb8ynh94gx1HUapoIvhvX+KKaQX8xSb6Kg+iX6tcyBeuI8+3KWnaR9o3cN10dwArzkKjpHxVgES2auV5HZzVMim7WPrmOGeJ6fsJya9dCyWDv2OusoclzH6EHTCskbsd0KklOuKTUHjfoXJkZnMQrArNcR29q76JYV3t7LSGJIAkwJ+ldPQa5TF8ko4vtO89bVI8T2ByXbxhHArSPyIae2dsDiCFO2ol/9W+RldJvhVzhANK2+vaSK8mHAXPpLRHi1OEDosoAyvVfm9hhb9U2w8sf/c7VngJo3BF/4HYvpl987L
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f9babe-1ac5-418f-400c-08d76b625af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:47.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDs8sRYFiOEfWr53J9uEyD30Dgb0HivHOBwXMtescGnL9kYmI3XfoT3YqYgaHVek352k4VNxea2tQEDZ8gtpfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add UD/RC/XRC traffic tests which use an extended CQ instead of the
legacy one.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/libibverbs_enums.pxd |  3 ++
 tests/CMakeLists.txt         |  1 +
 tests/test_cqex.py           | 75 ++++++++++++++++++++++++++++++++++++
 tests/utils.py               | 56 ++++++++++++++++++++++-----
 4 files changed, 125 insertions(+), 10 deletions(-)
 create mode 100644 tests/test_cqex.py

diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 114915d0a751..4bf77d3f14f7 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -398,6 +398,9 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_XRCD_INIT_ATTR_OFLAGS
         IBV_XRCD_INIT_ATTR_RESERVED
=20
+    cpdef enum:
+        IBV_WC_STANDARD_FLAGS
+
     cdef unsigned long long IBV_DEVICE_RAW_SCATTER_FCS
     cdef unsigned long long IBV_DEVICE_PCI_WRITE_END_PADDING
=20
diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 0d81d1a98fb7..7c6be35dc58a 100755
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -7,6 +7,7 @@ rdma_python_test(tests
   test_addr.py
   base.py
   test_cq.py
+  test_cqex.py
   test_device.py
   test_mr.py
   test_pd.py
diff --git a/tests/test_cqex.py b/tests/test_cqex.py
new file mode 100644
index 000000000000..df135a991c15
--- /dev/null
+++ b/tests/test_cqex.py
@@ -0,0 +1,75 @@
+from pyverbs.cq import CqInitAttrEx, CQEX
+import pyverbs.enums as e
+from pyverbs.mr import MR
+
+from tests.base import RCResources, UDResources, XRCResources, RDMATestCas=
e
+import tests.utils as u
+
+
+def create_ex_cq(res):
+    """
+    Create an Extended CQ using res's context and assign it to res's cq me=
mber.
+    IBV_WC_STANDARD_FLAGS is used for WC flags to avoid support difference=
s
+    between devices.
+    :param res: An instance of TrafficResources
+    """
+    wc_flags =3D e.IBV_WC_STANDARD_FLAGS
+    cia =3D CqInitAttrEx(cqe=3D2000, wc_flags=3Dwc_flags)
+    res.cq =3D CQEX(res.ctx, cia)
+
+
+class CqExUD(UDResources):
+    def create_cq(self):
+        create_ex_cq(self)
+
+    def create_mr(self):
+        self.mr =3D MR(self.pd, self.msg_size + self.GRH_SIZE,
+                     e.IBV_ACCESS_LOCAL_WRITE)
+
+
+class CqExRC(RCResources):
+    def create_cq(self):
+        create_ex_cq(self)
+
+
+class CqExXRC(XRCResources):
+    def create_cq(self):
+        create_ex_cq(self)
+
+
+class CqExTestCase(RDMATestCase):
+    """
+    Run traffic over the existing UD, RC and XRC infrastructure, but use
+    ibv_cq_ex instead of legacy ibv_cq
+    """
+    def setUp(self):
+        super().setUp()
+        self.iters =3D 100
+        self.qp_dict =3D {'ud': CqExUD, 'rc': CqExRC, 'xrc': CqExXRC}
+
+    def create_players(self, qp_type):
+        client =3D self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        server =3D self.qp_dict[qp_type](self.dev_name, self.ib_port,
+                                       self.gid_index)
+        if qp_type =3D=3D 'xrc':
+            client.pre_run(server.psns, server.qps_num)
+            server.pre_run(client.psns, client.qps_num)
+        else:
+            client.pre_run(server.psn, server.qpn)
+            server.pre_run(client.psn, client.qpn)
+        return client, server
+
+    def test_ud_traffic_cq_ex(self):
+        client, server =3D self.create_players('ud')
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DTrue)
+
+    def test_rc_traffic_cq_ex(self):
+        client, server =3D self.create_players('rc')
+        u.traffic(client, server, self.iters, self.gid_index, self.ib_port=
,
+                  is_cq_ex=3DTrue)
+
+    def test_xrc_traffic_cq_ex(self):
+        client, server =3D self.create_players('xrc')
+        u.xrc_traffic(client, server, is_cq_ex=3DTrue)
diff --git a/tests/utils.py b/tests/utils.py
index 785309552e25..04a988a531e4 100755
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -13,6 +13,7 @@ from pyverbs.addr import AHAttr, AH, GlobalRoute
 from pyverbs.wr import SGE, SendWR, RecvWR
 from pyverbs.qp import QPCap, QPInitAttrEx
 from tests.base import XRCResources
+from pyverbs.cq import PollCqAttr
 import pyverbs.device as d
 import pyverbs.enums as e
=20
@@ -342,6 +343,37 @@ def poll_cq(cq, count=3D1):
     return wcs
=20
=20
+def poll_cq_ex(cqex, count=3D1):
+    """
+    Poll <count> completions from the extended CQ.
+    :param cq: CQEX to poll from
+    :param count: How many completions to poll
+    :return: None
+    """
+    poll_attr =3D PollCqAttr()
+    ret =3D cqex.start_poll(poll_attr)
+    while ret =3D=3D 2: # ENOENT
+        ret =3D cqex.start_poll(poll_attr)
+    if ret !=3D 0:
+        raise PyverbsRDMAErrno('Failed to poll CQ')
+    count -=3D 1
+    if cqex.status !=3D e.IBV_WC_SUCCESS:
+        raise PyverbsRDMAErrno('Completion status is {s}'.
+                               format(s=3Dcqex.status))
+    # Now poll the rest of the packets
+    while count > 0:
+        ret =3D cqex.poll_next()
+        while ret =3D=3D 2:
+            ret =3D cqex.poll_next()
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to poll CQ')
+        if cqex.status !=3D e.IBV_WC_SUCCESS:
+            raise PyverbsRDMAErrno('Completion status is {s}'.
+                                   format(s=3Dcqex.status))
+        count -=3D 1
+    cqex.end_poll()
+
+
 def validate(received_str, is_server, msg_size):
     """
     Validates the received buffer against the expected result.
@@ -366,7 +398,7 @@ def validate(received_str, is_server, msg_size):
                 format(exp=3Dexpected_str, rcv=3Dreceived_str))
=20
=20
-def traffic(client, server, iters, gid_idx, port):
+def traffic(client, server, iters, gid_idx, port, is_cq_ex=3DFalse):
     """
     Runs basic traffic between two sides
     :param client: client side, clients base class is BaseTraffic
@@ -374,8 +406,10 @@ def traffic(client, server, iters, gid_idx, port):
     :param iters: number of traffic iterations
     :param gid_idx: local gid index
     :param port: IB port
+    :param is_cq_ex: If True, use poll_cq_ex() rather than poll_cq()
     :return:
     """
+    poll =3D poll_cq_ex if is_cq_ex else poll_cq
     s_recv_wr =3D get_recv_wr(server)
     c_recv_wr =3D get_recv_wr(client)
     post_recv(client.qp, c_recv_wr, client.num_msgs)
@@ -383,21 +417,21 @@ def traffic(client, server, iters, gid_idx, port):
     for _ in range(iters):
         c_send_wr =3D get_send_wr(client, False)
         post_send(client, c_send_wr, gid_idx, port)
-        poll_cq(client.cq)
-        poll_cq(server.cq)
+        poll(client.cq)
+        poll(server.cq)
         post_recv(client.qp, c_recv_wr)
         msg_received =3D server.mr.read(server.msg_size, 0)
         validate(msg_received, True, server.msg_size)
         s_send_wr =3D get_send_wr(server, True)
         post_send(server, s_send_wr, gid_idx, port)
-        poll_cq(server.cq)
-        poll_cq(client.cq)
+        poll(server.cq)
+        poll(client.cq)
         post_recv(server.qp, s_recv_wr)
         msg_received =3D client.mr.read(client.msg_size, 0)
         validate(msg_received, False, client.msg_size)
=20
=20
-def xrc_traffic(client, server):
+def xrc_traffic(client, server, is_cq_ex=3DFalse):
     """
     Runs basic xrc traffic, this function assumes that number of QPs, whic=
h
     server and client have are equal, server.send_qp[i] is connected to
@@ -408,8 +442,10 @@ def xrc_traffic(client, server):
     of XRCResources class
     :param server: Aggregation object of the passive side, should be an in=
stance
     of XRCResources class
+    :param is_cq_ex: If True, use poll_cq_ex() rather than poll_cq()
     :return: None
     """
+    poll =3D poll_cq_ex if is_cq_ex else poll_cq
     client_srqn =3D client.srq.get_srq_num()
     server_srqn =3D server.srq.get_srq_num()
     s_recv_wr =3D get_recv_wr(server)
@@ -421,15 +457,15 @@ def xrc_traffic(client, server):
             c_send_wr =3D get_send_wr(client, False)
             c_send_wr.set_qp_type_xrc(server_srqn)
             client.sqp_lst[i].post_send(c_send_wr)
-            poll_cq(client.cq)
-            poll_cq(server.cq)
+            poll(client.cq)
+            poll(server.cq)
             msg_received =3D server.mr.read(server.msg_size, 0)
             validate(msg_received, True, server.msg_size)
             s_send_wr =3D get_send_wr(server, True)
             s_send_wr.set_qp_type_xrc(client_srqn)
             server.sqp_lst[i].post_send(s_send_wr)
-            poll_cq(server.cq)
-            poll_cq(client.cq)
+            poll(server.cq)
+            poll(client.cq)
             msg_received =3D client.mr.read(client.msg_size, 0)
             validate(msg_received, False, client.msg_size)
=20
--=20
2.21.0

