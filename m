Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060F9EDCAA
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 11:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKDKh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 05:37:29 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:44166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfKDKh3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmKAHkmzMxFtIW+s7hU4T4DpjwVqarzQ8QgSPaa44uWL0HsB8QYTRZGSy1z+p2ICoyZRLzDQlxDbuDEW22Iu2OHnPoQ6sKZ6kzMy0+UPwRktsAzlXZi1SGdsXtPm9zGhU8I2kdOHqXW6pErIoX0vkV3/6q8zi9ZR0cTi0/+anFRC2dtMzcdiqZJ27bW6Rk8ORBpG6OomIIZo94XsXTA8IbH/sAdwJpx0H0zX8gjoKiMHbrFDx0VNnsrzr4ykvnVcm1Ja7PfgSwi0sbFGqyKkc+WuriduzLEfFb5jhYk6dVS/aHprhDb5bEX8SxE+pSRq4o3V4B8X+Liim8rdIw98/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1FUTBOHaypDNLokkCZPgekc9bZo3lA15tMsPk1Kems=;
 b=C8VjnG8gLLFXFq+zMY3cfIEp2DxYP+xUKGpKTdtdIjXHn6L+jQ6zqv4brj50VY6Fqcsb26xu0r977ImbysR0tC9uMXdFFe67U00NIkB9+C+cE+opxP/C+iomybAbbzlYcqL63iwZU6t++AmohmdSt8IddsezGt6A8jP1pkjjtbJ8Njo3qS7aimcVVUvGJPVMCGpF/tC7w4xj5eeTJP7sUlPCmA5B6ujkY4vHLySGkZBGv48oFDzG1bF8ol3C+Qt0y5RVhFgzA63+lUoK3Plx0zN7v0p+1nU+mIslcGWoXERUiqLDoHyuz6PpAq2VaoKuuO15Fyu+HWWlyvrSJ9F27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1FUTBOHaypDNLokkCZPgekc9bZo3lA15tMsPk1Kems=;
 b=lv8NX5qp0bSAo4a+sDUVNIEl8SNfyTqA+8pkNDLyMx+Yr6885uTCe1fYdcxC38UDsPUdoikyPlOCtVElUOvsO3e5usP35Qog7GI3W5UgFzudKDwXPPYSB/WqS6ygq67ZJ+KAwALoqejBYUKvIiROaX3P/vHrSgTOmHlULE+B0Gc=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5366.eurprd05.prod.outlook.com (20.177.191.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:37:26 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:37:26 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 2/5] tests: Fix PD API test
Thread-Topic: [PATCH rdma-core 2/5] tests: Fix PD API test
Thread-Index: AQHVkvvZTm52QF1ahkqonM2eoGSorg==
Date:   Mon, 4 Nov 2019 10:37:26 +0000
Message-ID: <20191104103710.11196-3-noaos@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 7c8de083-6224-46b5-ca08-08d76112fc35
x-ms-traffictypediagnostic: AM6PR05MB5366:|AM6PR05MB5366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB53666BF8156619BAC44F4329D97F0@AM6PR05MB5366.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(14454004)(76176011)(66066001)(6636002)(305945005)(7736002)(186003)(86362001)(6486002)(446003)(11346002)(6436002)(102836004)(6512007)(2616005)(476003)(486006)(316002)(8676002)(478600001)(4326008)(8936002)(4744005)(6116002)(81156014)(81166006)(110136005)(99286004)(54906003)(25786009)(6506007)(52116002)(26005)(50226002)(107886003)(14444005)(386003)(36756003)(256004)(66446008)(64756008)(66556008)(66946007)(66476007)(5660300002)(2501003)(2906002)(71200400001)(71190400001)(1076003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5366;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mImW9dZz6WyFKTH2xRNjJrFben6c1rjyp/2CNUSo7Y7QYq9SO9ASyumiTjYqfqgRcW2PYr3r/vvo7ITPmjs934eVetYjBn1gmPl0jXr99p2YgqUUvZU7w13nOXcqZYwCZardnpYO+Kf+84/y9nNWEPKLNgjZ4zXjkfQ/imAOcsKNCd56ByenouxOmtGOC+3e20pevcUQAnIyjzw8e7tpYogZt0b+HYN+Ih1CsQPFEqVKpyEO0UHgK+5gr+cEBpMzPFHTDWPF+vRMeKpL6cHoIa+tyETb7Ph82i+KfKXWRl/NywfPGrCv8xOZPZMk9YVDSfuvTmTTy8ZtC4P9p+o6p+gNqndJpPhlSCX78VbE7lcbeCJy+2VpPN/8pWhqXCutdRCfMwuLmR4kx5xqS1MnNTvF7mhjdmrS0ZYOFN5sbzAFmWPyxlfRYwGWWVIORFd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8de083-6224-46b5-ca08-08d76112fc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:37:26.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydAmfeHJhl2/ILhNX+7+VwNxxNLGJAgFJG9o3jpMTxd/3x1hJcaiYCnYiV8y+phYCCoPJ+5nHKzVZekS4SzTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5366
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

In order to support PD class in CMID, modifications was made in PD
constructor, as a result one of test_pd's cases broke.
Fix it to create PD properly.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/test_pd.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
 mode change 100644 =3D> 100755 tests/test_pd.py

diff --git a/tests/test_pd.py b/tests/test_pd.py
old mode 100644
new mode 100755
index 978cf4900146..a8d6eb2fb69f
--- a/tests/test_pd.py
+++ b/tests/test_pd.py
@@ -48,8 +48,7 @@ class PDTest(PyverbsAPITestCase):
         try:
             PD(None)
         except TypeError as te:
-            assert 'expected pyverbs.device.Context' in te.args[0]
-            assert 'got NoneType' in te.args[0]
+            assert 'must not be None' in te.args[0]
         else:
             raise PyverbsRDMAErrno('Created a PD with None context')
=20
--=20
2.21.0

