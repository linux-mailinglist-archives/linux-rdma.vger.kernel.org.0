Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCCEDCAD
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 11:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfKDKhe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 05:37:34 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:44166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfKDKhe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2P4tJt2mlQbwi2h1M4tOK7ZWYZe7qjF07QE2UXTVv3HFGsj/mehPfc9KHmEDNI1Vu6dkBTY3GFIFD2keZnH5EARqydHNy+BFe7CGoYCksmLwstcVYeGdT6RSt0YfMkD/2wrb2U0fIUNAtwm+5KmzozgokWSA5VQDvaklJ2rPwAvn34cPF3385JP1IxUtKGR8LA8632eMh6HLTD33MqMDfnzII+QVyyt906tnlTfOnp7bRlgRdPCngxtRTcKY7f18ZDAH4xSa0hN4XnHaRoQb19u43TBT9xSAP2GHoV2PWE+8qU3pqgxNOQXU1RvFfSIhDPgzQWON82XIOx874eSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzWPPKb/HHHdq/Gepknt/004Ag12cgLvwXJBuvgxKZc=;
 b=lQQ7sZRdCBtrgOhSq1/vlOmArgmrqCjmukcsOs7ztd1FrxY9frciZAiyYpw9n514RgilI1DFrQwtp4UcOv7upuzqn5Dnz6c559MLQZC0l/QvOQEr1vO0Y+31f74Rw8QXuOD48LOLoEHIYWHf7BAb1x+RfOY2cb2rkz48LtQCFXxKfOC2mj0ZHDRVHXqYSSL1DuF4gR3UcbZOxLBIlBlzNOLwsZcz4rqedDePh16F7Rt3lkS/5N7p7PVyMIYAMTFij5jBOlgg2A1X/kfUXMMree8q2FHikMGmAqy5llISDt5gx7rq2ui+lb4aprGznbIZcv1+nZSnxr9XC32jV6K4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzWPPKb/HHHdq/Gepknt/004Ag12cgLvwXJBuvgxKZc=;
 b=UFNdTzq33b21rIvdxHg1cwdSMypZJRdDqz8idorn6zUuien11XLgqWXnbIKcq/JeC8Tt6xFwXDDREBFE/a5NU2ewhvVWdxANq/Wegm1YHRHOTMrDkjzxUxf09kFSMSIuvdU7/WlB9QKho7OMPtyO5zyTm+Eq1ZU6UoHPnwGeC38=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5366.eurprd05.prod.outlook.com (20.177.191.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:37:29 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:37:29 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 5/5] Documentation: Document creation of CMID
Thread-Topic: [PATCH rdma-core 5/5] Documentation: Document creation of CMID
Thread-Index: AQHVkvvbqSTvVxkqCkiUGL+qRgohmg==
Date:   Mon, 4 Nov 2019 10:37:29 +0000
Message-ID: <20191104103710.11196-6-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 5711f897-91df-458c-51e9-08d76112fdc9
x-ms-traffictypediagnostic: AM6PR05MB5366:|AM6PR05MB5366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5366F6F02D544E8B5D651175D97F0@AM6PR05MB5366.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(14454004)(76176011)(66066001)(6636002)(305945005)(7736002)(186003)(86362001)(6486002)(446003)(11346002)(6436002)(102836004)(6512007)(2616005)(476003)(486006)(316002)(8676002)(478600001)(4326008)(8936002)(6116002)(81156014)(81166006)(110136005)(99286004)(54906003)(25786009)(6506007)(52116002)(26005)(50226002)(107886003)(14444005)(386003)(36756003)(256004)(66446008)(64756008)(66556008)(66946007)(66476007)(5660300002)(2501003)(2906002)(71200400001)(71190400001)(1076003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5366;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RN5xzfwbiUkbO59U22oHc8cMnWDhIHQXtlzuhyj/rm4sFdsAcTFuvOC9L1J8LncnUKC5X405rO1ycNrPjxuBHycHUyayWyoFniFFz6zmW1BDMJ+quoFyPzkQzI8d4OKTa5oP9FCdZ275eTFfdysBkJ24JpgMRR1/rZKUjNAgWGZqeCmKbB9rcT4TvLZ/Oas1wjXRiCKNMosEu47XKtXPQzI16xWLctaIvfgjRmtE7aRTgRZYkymRtBH2gMWmLmOG7CVPrlG6SZwFLTGywVaB/5jQ5q/nmuuGwso8Sq+KqLxhfByqbojMvMd6nwPp+DKhnmjOPERwcHOf6mnYwCl2RYT+njxyIFnOF34DZr2fWvKPpFOFPiB6cVrbwTll8x3IpaaT6ooyqWjBkxG01MBqvTniwCDv2j3Zui56QXydm2mpclWUWhkQA/EXJzSyPxJ0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5711f897-91df-458c-51e9-08d76112fdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:37:29.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1FjcFtfG0YEgcgqd8wI8lyOCEfGKilfLAhWBmW23D/si9/Z3DE5J0daMrQLTxF9OkIPWD9ukbFQ5xIE7sHt5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5366
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

Add code snippet to demonstrate creation of CMID and establish
connection (synchronous control path).

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 Documentation/pyverbs.md | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index 29ab9592c53c..6ff6fc5bbc37 100755
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -390,3 +390,33 @@ srq_attr.comp_mask =3D e.IBV_SRQ_INIT_ATTR_TYPE | e.IB=
V_SRQ_INIT_ATTR_PD | \
                      e.IBV_SRQ_INIT_ATTR_CQ | e.IBV_SRQ_INIT_ATTR_XRCD
 srq =3D SRQ(ctx, srq_attr)
 ```
+
+##### CMID
+The following code snippet will demonstrate creation of a CMID object, whi=
ch
+represents rdma_cm_id C struct, and establish connection between two peers=
.
+Currently only synchronous control path is supported (rdma_create_ep).
+For more complex examples, please see tests/test_rdmacm.
+```python
+from pyverbs.qp import QPInitAttr, QPCap
+from pyverbs.cmid import CMID, AddrInfo
+import pyverbs.cm_enums as ce
+
+cap =3D QPCap(max_recv_wr=3D1)
+qp_init_attr =3D QPInitAttr(cap=3Dcap)
+server =3D '11.137.14.124'
+port =3D '7471'
+
+# Active side
+
+cai =3D AddrInfo(server, port, ce.RDMA_PS_TCP)
+cid =3D CMID(creator=3Dcai, qp_init_attr=3Dqp_init_attr)
+cid.connect()  # send connection request to server
+
+# Passive side
+
+sai =3D AddrInfo(server, port, ce.RDMA_PS_TCP, ce.RAI_PASSIVE)
+sid =3D CMID(creator=3Dsai, qp_init_attr=3Dqp_init_attr)
+sid.listen()  # listen for incoming connection requests
+new_id =3D sid.get_request()  # check if there are any connection requests
+new_id.accept()  # new_id is connected to remote peer and ready to communi=
cate
+```
--=20
2.21.0

