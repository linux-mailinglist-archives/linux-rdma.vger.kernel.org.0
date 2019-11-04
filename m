Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD39EDCAC
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 11:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKDKhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 05:37:31 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:44166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727553AbfKDKhb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzCu3acXkfZYmPzuceNmIz5PxM/bbapAcQTBbWNeEk1WhG3Jkmh2EIs2OpgddbGBPH+n0Cb8OsmtqY4S9CwLqphbW9urbrSYP1IPT8dgOINI6lfnpUZ4Ug71q8qjV8ZlzmhQuYehy9dxyLnJf2Z5G49RitEdCqU3XbWm1z3PCZcU7MXQ8h0zcjTPd6cfiQNkEwxjTWf0S98fCaQgVzzvSKkRmOkOB2yhQ9A9b10GKIdeasNorlGwl32oFEwDMdrQDmyUMCoK2rcMheFh3f8tDPaD7smcM5Ag/Ho22CtYf/gFbZFhB7b1iqV2WuBUqJ7Z2NDsukmPJiQRpA1/FkLW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I2WMeDh2vremi3XcAX2JJFKXQ0RiAVCNu4rzGF6aho=;
 b=IQzUdmMQ4YJcEnu7Ou1GUatEEP4/1CIv0oApQvLOkhKFlgYUYTC09YEeBcWHALOp3G9dCUe0alKh8+Nqw4TfvFP711w8Fdapn1BBlHc8SYh2p08J/p3yhE9jimG/qHjM2KkdNA2u14vnSZF24InWLwHVsUz+cFg65CgaFFyeMYtiaoJ/B+G+yGdxp5Lt3u5KqxH/lRarocFYLXQQmlZn2Seojwa4ouQOaZ4PhXTciAFuqdrHfFaB/x/3mRqAI84IgOfoo3EPkj2PUfZH8uQ6SLNuet4tMLnscyKZPKcNVCnfQPxDp+ygLhI0ZezwY6gQYYhZrlGn3F3yXElmTXZa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I2WMeDh2vremi3XcAX2JJFKXQ0RiAVCNu4rzGF6aho=;
 b=e7WNegzNqmu0eK1tJsL6Uj8tw5NQUQcNZMjqEo4AfFT/n2whDovJXKXFkZwFte3yYIcSeC2NOkOshb4f2yrKUmI2l35Twkk+Y+k0a7BjubKDkdt+Hznvk474dugZzWwMSKLsnr+vhYgcWqsYC2w3BsYHrL/qaR/WqLYRGEwqORQ=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5366.eurprd05.prod.outlook.com (20.177.191.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:37:27 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:37:27 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 3/5] tests: New CMResources Class
Thread-Topic: [PATCH rdma-core 3/5] tests: New CMResources Class
Thread-Index: AQHVkvvaRSNnBzqSGEakdKCfJDTpmQ==
Date:   Mon, 4 Nov 2019 10:37:27 +0000
Message-ID: <20191104103710.11196-4-noaos@mellanox.com>
References: <20191104103710.11196-1-noaos@mellanox.com>
In-Reply-To: <20191104103710.11196-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:200:42::49) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec3bdf91-e677-4f6b-9195-08d76112fcbd
x-ms-traffictypediagnostic: AM6PR05MB5366:|AM6PR05MB5366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB536689275BAFD45BEA3BBBA0D97F0@AM6PR05MB5366.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(14454004)(76176011)(66066001)(6636002)(305945005)(7736002)(186003)(86362001)(6486002)(446003)(11346002)(6436002)(102836004)(6512007)(2616005)(476003)(486006)(316002)(8676002)(478600001)(4326008)(8936002)(6116002)(81156014)(81166006)(110136005)(99286004)(54906003)(25786009)(6506007)(52116002)(26005)(50226002)(107886003)(14444005)(386003)(36756003)(256004)(66446008)(64756008)(66556008)(66946007)(66476007)(5660300002)(2501003)(2906002)(71200400001)(71190400001)(1076003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5366;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/YPNfNE2APPNE7hXeBtQlp/DPRj3m1jYB3IojsqFdjx0MLHsaxptHIxcIgQHTq8CDaRw5iUD/eVS71/rOjURxE3KxXIYfXMqNgFgEISZaPHkZ1gDoyDltFZI0KcHfG5KKIrM/Z4gz5Q0QrEeFe+wTifs5UjhB05IPgiq0rwaMq0Ii75IKmQxzY6LHJpNzAxZ8BhvoMhECS18dNnDX3m27T6//8IqhQvA865paSgL/BvjEqbNWuHglROer36fuHEu6j5eK6x4nlfHtIOaV8n/SJwQkgMSmOKEvt9oyg0FJf3zea3YKnzruslPcTzp5iiTZu+yE0w05DNZINJ7pDHAqSyijN2969VQ9cepH6sXFv0WxoHFhGyGsE8ages2dBBWmluy4IKGaTdGtjpauB6ODqhP4MHe3uCA0d0stNBiD83r2lWHfdNm3YOMueBIt6b
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3bdf91-e677-4f6b-9195-08d76112fcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:37:27.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCtudqhBwiV3eoN1h6Vh1/6I5ibKDkyzCztax2GMkmmVfYF0qvOXtlJGuJZVO7dureDBn5fDiEnJiHbpEJLPNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5366
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

A base aggregation object for RDMACM. Currently only synchronous data
path flow is supported.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/base.py b/tests/base.py
index e4e92fa2a35f..54bfc42ffe4c 100755
--- a/tests/base.py
+++ b/tests/base.py
@@ -11,13 +11,16 @@ from pyverbs.qp import QPCap, QPInitAttrEx, QPInitAttr,=
 QPAttr, QP
 from pyverbs.addr import AHAttr, GlobalRoute
 from pyverbs.xrcd import XRCD, XRCDInitAttr
 from pyverbs.srq import SRQ, SrqInitAttrEx
+from pyverbs.cmid import CMID, AddrInfo
 from pyverbs.device import Context
+import pyverbs.cm_enums as ce
 import pyverbs.device as d
 import pyverbs.enums as e
 from pyverbs.pd import PD
 from pyverbs.cq import CQ
 from pyverbs.mr import MR
=20
+
 PATH_MTU =3D e.IBV_MTU_1024
 MAX_DEST_RD_ATOMIC =3D 1
 MAX_RD_ATOMIC =3D 1
@@ -26,6 +29,10 @@ RETRY_CNT =3D 7
 RNR_RETRY =3D 7
 TIMEOUT =3D 14
=20
+# for rdmacm
+PORT =3D '7471'
+ZERO_ADDR =3D '0.0.0.0'
+
=20
 class PyverbsAPITestCase(unittest.TestCase):
     def setUp(self):
@@ -144,6 +151,51 @@ class RDMATestCase(unittest.TestCase):
             self._add_gids_per_port(ctx, dev, port+1)
=20
=20
+class CMResources:
+    """
+    CMResources class is a base aggregator object which contains basic
+    resources for RDMA CM communication.
+    """
+    def __init__(self, src=3DZERO_ADDR, dst=3DZERO_ADDR, port=3DPORT):
+        """
+        :param src: Local address to bind to (for passive side)
+        :param dst: Destination address to connect (for active side)
+        :param port: Port number of the address
+        """
+        self.is_server =3D True if dst =3D=3D ZERO_ADDR else False
+        self.qp_init_attr =3D None
+        self.msg_size =3D 1024
+        self.num_msgs =3D 100
+        self.new_id =3D None
+        self.port =3D port
+        self.mr =3D None
+        if self.is_server:
+            self.ai =3D AddrInfo(src, self.port, ce.RDMA_PS_TCP,
+                               ce.RAI_PASSIVE)
+        else:
+            self.ai =3D AddrInfo(dst, self.port, ce.RDMA_PS_TCP)
+        self.create_qp_init_attr()
+        self.cmid =3D CMID(creator=3Dself.ai, qp_init_attr=3Dself.qp_init_=
attr)
+
+    def create_mr(self, cmid):
+        self.mr =3D cmid.reg_msgs(self.msg_size)
+
+    def create_qp_init_attr(self):
+        self.qp_init_attr =3D QPInitAttr(cap=3DQPCap(max_recv_wr=3D1))
+
+    def listen(self):
+        self.cmid.listen()
+        self.new_id =3D self.cmid.get_request()
+        self.new_id.accept()
+
+    def pre_run(self):
+        if self.is_server:
+            self.listen()
+        else:
+            self.cmid.connect()
+        self.create_mr(self.new_id if self.is_server else self.cmid)
+
+
 class BaseResources(object):
     """
     BaseResources class is a base aggregator object which contains basic
--=20
2.21.0

