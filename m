Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E9FF9E4
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfKQNa4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:30:56 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:21606
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfKQNa4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi2HPzx3mTQqm0ZaFh05ATArTz+/zycf8hl3XkUrBqAA+n1bHoI/5BzpQWMF8nSK9pHWWiblH3OfZrHzPUF4uaLplyd8V8Pt2UvEjymJUJA2dfriuyntNzOlv2bziZ3uSg5pfvL5muu19n0AQwr6W/nl2oVqoHh9o0/0hb2pAK7goW9pRe9dXsokdzB8VltRutaBX5iCRQcz25p7cgkX9wuf6lV+tJOml0kRNNrV5tQOIozPY2y6jcH+z6ieBncmJIkcz4454Zba3HD3oXKN71jisUqoMHwLQSco+jPEuxvsgNA085XhXsyxE/WzyAYi3A58wA7+EeKW8a6bPWbgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skj3jX3LRZaWmX5exEsEoXxMxhb+cRBU2uU6bl3S5KA=;
 b=Za9Ay06rUAohV63tWsrqRc8f1YpjM8bMhUCBd9lsMn9Hpet+7E0Koo0jPPY2YLOSv14K4Mi4QvDfDSk7gC3IjEi/hrXIF2DtzqyYF6gQ018xN84TI8C5/ds1lGeT2ETHHA4HnVnoPEK2FNcuAuunSM8wNBA5AnsVtFjk/gZl0r5SxdQbYSYWdBjs/Z6srofXRbRXZEkoLBjQrnEj+rNtWEhpcfmG0i0+dykslQwhTFfIFTIPaJjNn6hZezuWn2rJksBQ8iVA1CktY3thxXzsmCZKRlcl7N5TBZKvAxUtEce4W98ChZ5lkaSrzCc3jBGNp1theYUJilQO4cR486LsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skj3jX3LRZaWmX5exEsEoXxMxhb+cRBU2uU6bl3S5KA=;
 b=lKROYRAGRw6OhKlk3bu+FIfvfoe99J4aCdBoCIeSTy/yJTc+fLwkJduKh8UVtRBFmJBrPSPLh1EO5B4G8qvH//4jvNMoXZtWPy9OGA2JmA/JWfq5/TB8ifQsa5lM44PMR8PIbP6MWZrvQlVXO+KaK+n05SqjkODTOGvcAQoutOM=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6598.eurprd05.prod.outlook.com (20.179.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 13:30:46 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 13:30:46 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 6/7] Documentation: Add mlx5 provider to
 documentation
Thread-Topic: [PATCH rdma-core 6/7] Documentation: Add mlx5 provider to
 documentation
Thread-Index: AQHVnUs4lquWkLu+ikG2y0vMD6U/AA==
Date:   Sun, 17 Nov 2019 13:30:46 +0000
Message-ID: <20191117133030.10784-7-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 5c283600-d8f4-4f0c-49c0-08d76b625a73
x-ms-traffictypediagnostic: AM6PR05MB6598:|AM6PR05MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6598BD7EB84BB61CFB675DEED9720@AM6PR05MB6598.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(102836004)(6116002)(386003)(6506007)(256004)(11346002)(3846002)(2616005)(26005)(36756003)(446003)(5660300002)(86362001)(8936002)(186003)(64756008)(66556008)(66476007)(66946007)(7736002)(50226002)(66446008)(305945005)(66066001)(2501003)(81166006)(81156014)(8676002)(99286004)(6636002)(25786009)(76176011)(478600001)(14454004)(1076003)(2906002)(6436002)(6486002)(14444005)(54906003)(6512007)(476003)(107886003)(110136005)(52116002)(486006)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6598;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9g0E2EaNGmB5cLfMJLLyFoPCH/SrMzXuHJjRiLZ4RXu7jw5SGhVg6XCqlEvqs7sN3VOYDJGrUAE99QgK4MUE0zT6a9swMXh625M+DdkSxJyHWCXR1iCYQvCCIzEVB96rEdRatFjhpK1i8WwJIwwoC7B1rcmJbdQujpoxJWlQVCSzo0YEsH1DJv8gZaIj9/YM8SnVh/EsOzEDas4dr/RvY2gtewn1B9kjczomsJKnRESLwGu+4wGbgj1v/F8e4IIhNaBDGY+ROOmCPG+FgLbSMQBTt0V8kxcCOSQeHnpXCpKHrl4T32RrDgCiBWB6UcNN5ZqOzvVhnDy9orvatysi5zAX/KR7jF7whUa56KZi9uRC3oslyFZd1SJbUzOOpeAJcxqYv0tRCXXAk0mHeQMwuXXbKtt8xzz/W22X5aLdEqYPmqLxn20iB9GoOr3YRUse
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c283600-d8f4-4f0c-49c0-08d76b625a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 13:30:46.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iWPg+XxU2+oIaNi+yjTpVpG97nmohz28wePubH9lLrfzQ0i2cw7ex9g8gqfvnRrg9XDxtYK0Wz/mEFTKVkFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code snippets to show:
- Opening an mlx5 device
- Querying an mlx5 device
- Creating an mlx5 QP (DCI and Raw Packet QP with mlx5-specific
  capabilties)
- Creating an mlx5 CQ

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 Documentation/pyverbs.md | 105 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index 7e81690a064a..e405ab53b423 100755
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -389,6 +389,111 @@ srq_attr.cq =3D cq
 srq_attr.comp_mask =3D e.IBV_SRQ_INIT_ATTR_TYPE | e.IBV_SRQ_INIT_ATTR_PD |=
 \
                      e.IBV_SRQ_INIT_ATTR_CQ | e.IBV_SRQ_INIT_ATTR_XRCD
 srq =3D SRQ(ctx, srq_attr)
+
+
+##### Open an mlx5 provider
+A provider is essentially a Context with driver-specific extra features. A=
s
+such, it inherits from Context. In legcay flow Context iterates over the I=
B
+devices and opens the one matches the name given by the user (name=3D argu=
ment).
+When provider attributes are also given (attr=3D), the Context will assign=
 the
+relevant ib_device to its device member, so that the provider will be able=
 to
+open the device in its specific way as demonstated below:
+
+```python
+import pyverbs.providers.mlx5.mlx5dv as m
+from pyverbs.pd import PD
+attr =3D m.Mlx5DVContextAttr()  # Default values are fine
+ctx =3D m.Mlx5Context(attr=3Dattr, name=3D'rocep0s8f0')
+# The provider context can be used as a regular Context, e.g.:
+pd =3D PD(ctx)  # Success
+```
+
+##### Query an mlx5 provider
+After opening an mlx5 provider, users can use the device-specific query fo=
r
+non-legacy attributes. The following snippet demonstrates how to do that.
+```python
+import pyverbs.providers.mlx5.mlx5dv as m
+ctx =3D m.Mlx5Context(attr=3Dm.Mlx5DVContextAttr(), name=3D'ibp0s8f0')
+mlx5_attrs =3D ctx.query_mlx5_device()
+print(mlx5_attrs)
+Version             : 0
+Flags               : CQE v1, Support CQE 128B compression, Support CQE 12=
8B padding, Support packet based credit mode (in RC QP)
+comp mask           : CQE compression, SW parsing, Striding RQ, Tunnel off=
loads, Dynamic BF regs, Clock info update, Flow action flags
+CQE compression caps:
+  max num             : 64
+  supported formats   : with hash, with RX checksum CSUM, with stride inde=
x
+SW parsing caps:
+  SW parsing offloads :
+  supported QP types  :
+Striding RQ caps:
+  min single stride log num of bytes: 6
+  max single stride log num of bytes: 13
+  min single wqe log num of strides: 9
+  max single wqe log num of strides: 16
+  supported QP types  : Raw Packet
+Tunnel offloads caps:
+Max dynamic BF registers: 1024
+Max clock info update [nsec]: 1099511
+Flow action flags   : 0
+```
+
+##### Create an mlx5 QP
+Using an Mlx5Context object, one can create either a legacy QP (creation
+process is the same) or an mlx5 QP. An mlx5 QP is a QP by inheritance but =
its
+constructor receives a keyword argument named `dv_init_attr`. If the user
+provides it, the QP will be created using `mlx5dv_create_qp` rather than
+`ibv_create_qp_ex`. The following snippet demonstrates how to create both =
a DC
+(dynamically connected) QP and a Raw Packet QP which uses mlx5-specific
+capabilities, unavailable using the legacy interface. Currently, pyverbs
+supports only creation of a DCI. DCT support will be added in one of the
+following PRs.
+```python
+from pyverbs.providers.mlx5.mlx5dv import Mlx5Context, Mlx5DVContextAttr
+from pyverbs.providers.mlx5.mlx5dv import Mlx5DVQPInitAttr, Mlx5QP
+import pyverbs.providers.mlx5.mlx5_enums as me
+from pyverbs.qp import QPInitAttrEx, QPCap
+import pyverbs.enums as e
+from pyverbs.cq import CQ
+from pyverbs.pd import PD
+
+with Mlx5Context(name=3D'rocep0s8f0', attr=3DMlx5DVContextAttr()) as ctx:
+    with PD(ctx) as pd:
+        with CQ(ctx, 100) as cq:
+            cap =3D QPCap(100, 0, 1, 0)
+            # Create a DC QP of type DCI
+            qia =3D QPInitAttrEx(cap=3Dcap, pd=3Dpd, scq=3Dcq, qp_type=3De=
.IBV_QPT_DRIVER,
+                               comp_mask=3De.IBV_QP_INIT_ATTR_PD, rcq=3Dcq=
)
+            attr =3D Mlx5DVQPInitAttr(comp_mask=3Dme.MLX5DV_QP_INIT_ATTR_M=
ASK_DC)
+            attr.dc_type =3D me.MLX5DV_DCTYPE_DCI
+
+            dci =3D Mlx5QP(ctx, qia, dv_init_attr=3Dattr)
+
+            # Create a Raw Packet QP using mlx5-specific capabilities
+            qia.qp_type =3D e.IBV_QPT_RAW_PACKET
+            attr.comp_mask =3D me.MLX5DV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS
+            attr.create_flags =3D me.MLX5DV_QP_CREATE_ALLOW_SCATTER_TO_CQE=
 |\
+                                me.MLX5DV_QP_CREATE_TIR_ALLOW_SELF_LOOPBAC=
K_UC |\
+                                me.MLX5DV_QP_CREATE_TUNNEL_OFFLOADS
+            qp =3D Mlx5QP(ctx, qia, dv_init_attr=3Dattr)
+```
+
+##### Create an mlx5 CQ
+Mlx5Context also allows users to create an mlx5 specific CQ. The Mlx5CQ in=
herits
+from CQEX, but its constructor receives 3 parameters instead of 2. The 3rd
+parameter is a keyword argument named `dv_init_attr`. If provided by the u=
ser,
+the CQ will be created using `mlx5dv_create_cq`.
+The following snippet shows this simple creation process.
+```python
+from pyverbs.providers.mlx5.mlx5dv import Mlx5Context, Mlx5DVContextAttr
+from pyverbs.providers.mlx5.mlx5dv import Mlx5DVCQInitAttr, Mlx5CQ
+import pyverbs.providers.mlx5.mlx5_enums as me
+from pyverbs.cq import CqInitAttrEx
+
+with Mlx5Context(name=3D'rocep0s8f0', attr=3DMlx5DVContextAttr()) as ctx:
+    cqia =3D CqInitAttrEx()
+    mlx5_cqia =3D Mlx5DVCQInitAttr(comp_mask=3Dme.MLX5DV_CQ_INIT_ATTR_MASK=
_COMPRESSED_CQE,
+                                 cqe_comp_res_format=3Dme.MLX5DV_CQE_RES_F=
ORMAT_CSUM)
+    cq =3D Mlx5CQ(ctx, cqia, dv_init_attr=3Dmlx5_cqia)
 ```
=20
 ##### CMID
--=20
2.21.0

