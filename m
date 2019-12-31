Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C775C12D754
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLaJUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:20:16 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfLaJUQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:20:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM35J4h7kvL2S7dIUXLfdWcTa2sHJCGwOszUdzjbgCa3cNbiBZ26l5ZoQ5EhGuTvAiKfAuUvVWFE37MRgByoya+78IBzupm9e2tnLV+aHWINxpzJKnzafTX7MO8gck9L2Ofnw6JloPV3ecBA47KjAzVEYM/JVMu9nSO0rM00usvNh2W/clTB93bQXgBYF3na9cS/fFV4SsaHjML0CygwegBsg2TN8XtiRFx2Ix8fZZijuB+5EBYpUa4Vhqr1hVxqS1rAAjCT0SNtgoxXCXqr9fOvjhwhOa+tDaIoaR4WVc7shPeMOuvaQnJT3rtj8d5l7MbThFlXQt+sphfdxksvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26cSrUBJmsHjZ4IueUT4alNzDyV0ZMW8pVT16nvGhHo=;
 b=ix8CntQ3CKMPYBBpkv1y0ncZ1B44Vy6Z1JxcO83Ny+QzPiSQHbRpj3mYlFHe4BfM8oTyLYrl7Lc7NFT7wLdgnY3y6eRD329uJJtuv7cslePFz9N0AVs5gB1Oc+2TUx9na574/lrHQjM8kGCQjQC+DUGSfT6hzLPru1OCC+Dtd2PO62+SBMSbQ40L4S9faGATV5jo6aBPbAFw42ANXf+f+OByyY/8Sa82OomeoZmD/pWQXpMiGVMYhk39e8SB073/ifMdTbtPmsel6pu9P+fezC3YLkP9C2Sg8VG+dxrmsgeunxIThMIbWLM6kXykQzhKflBUbdjUrlZ3EIWNAuHErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26cSrUBJmsHjZ4IueUT4alNzDyV0ZMW8pVT16nvGhHo=;
 b=HBlzaYDFoGL38ssFDhqNz2iMCWrX7Gvh718QEz87FvhDKrD3bTId0yH7HEKIdZABLk6RCEBjqAEuBN2edUNFVa4ncbqanKGX54tLb3RD0HitgWPMb0imit4G+4kAGWF2wQzDnhS5uPLw7eXV8dvUOXQEQe+Ud0TkexEmmjYUGGY=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:34 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:34 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:33 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 7/8] Documentation: Add extended QP to pyverbs's doc
Thread-Topic: [PATCH rdma-core 7/8] Documentation: Add extended QP to
 pyverbs's doc
Thread-Index: AQHVv7tqxueZuHHudU6drdUYSRqyGA==
Date:   Tue, 31 Dec 2019 09:19:34 +0000
Message-ID: <20191231091915.23874-8-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 7e7f0d2f-2c5f-4366-8d6e-08d78dd28ccd
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB37429DD552741A6EDBDCDFE6D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IluQoooTnD+4VveP2v7E1+APCOFNlQGuiULSC+QSsNVekvZw7BkfjO0QQ4yCUZEB5Euk3BHQR7ZrEn8uDDESt080HX/f7931GpGOFgdV0WIH0jXvSiancgefPGKgqrWkutwZZGQ5e1zc+Uy4LD9nEygoHN1OqM/SQzDDkcyUkJp+K8qp4xfajpGIOGy5VtCV6XRgKxacNKNOHKYvr/jszzKeqV7XqFBygSvIV6CpMYrpvjPoBlLBB7dc9sPDj6W1cO74YrkYmyQ2ywXgqgpuqga0v6icDehiOG0k3XFevfft+5wFpS1TCe3yg+ZcSR73yXPaBpgeCgGtuaXcENXszEMepimMyFy2U9sCe/Hr+kf6AuH32APxYyddxZ5WOPvlWl9O7lQVDdbUJtFw6E1nD9t8pVXp8/VGfuGvXXO10F8eAQMhXTioaRqgZoJEisly
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7f0d2f-2c5f-4366-8d6e-08d78dd28ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:34.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA+uDoQ24Hl0sNsuc3c6VOB1cjh64dJvYNDatqFVFNPs4d6oBevXqwyyQZ4HLCMxXTmWYJB1ImswvpnkHHZF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a code snippet to demonstrate an extended QP creation using
pyverbs.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 Documentation/pyverbs.md | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index c7dddd598303..325e214fca0e 100755
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -339,6 +339,30 @@ wr =3D pwr.SendWR()
 wr.set_wr_ud(ah, 0x1101, 0) # in real life, use real values
 udqp.post_send(wr)
 ```
+###### Extended QP
+An extended QP exposes a new set of QP send operations to the user -
+extensibility for new send opcodes, vendor specific send opcodes and even =
vendor
+specific QP types.
+Pyverbs now exposes the needed interface to create such a QP.
+Note that the IBV_QP_INIT_ATTR_SEND_OPS_FLAGS in the `comp_mask` is mandat=
ory
+when using the extended QP's new post send mechanism.
+```python
+from pyverbs.qp import QPCap, QPInitAttrEx, QPAttr, QPEx
+import pyverbs.device as d
+import pyverbs.enums as e
+from pyverbs.pd import PD
+from pyverbs.cq import CQ
+
+
+ctx =3D d.Context(name=3D'mlx5_0')
+pd =3D PD(ctx)
+cq =3D CQ(ctx, 100)
+cap =3D QPCap(100, 10, 1, 1, 0)
+qia =3D QPInitAttrEx(qp_type=3De.IBV_QPT_UD, scq=3Dcq, rcq=3Dcq, cap=3Dcap=
, pd=3Dpd,
+                   comp_mask=3De.IBV_QP_INIT_ATTR_SEND_OPS_FLAGS| \
+                   e.IBV_QP_INIT_ATTR_PD)
+qp =3D QPEx(ctx, qia)
+```
=20
 ##### XRCD
 The following code demonstrates creation of an XRCD object.
--=20
2.21.0

