Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4753A25717
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 19:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEUR4G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 13:56:06 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:27884
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEUR4G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 May 2019 13:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3/aFD3tS7lSXD5QUYxohddDVyWVtxHQJasAl6swn+c=;
 b=FW0Uxfi7m40G2jzvT0CmsnhxPVoIop1sVvPReMyprh8mCW/GK6TLXdfIUC75jUUQai0UADP9d4FyzwWHykbfYm8FvL6RY8K4TxP2DIN7HpXLGNbQ6NFx64Ni6F9b16RWJRI6TEv3GSYTak1vdT52LdZ8MmXNkKOcG3U3nhTzosQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6543.eurprd05.prod.outlook.com (20.179.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 17:55:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 17:55:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc] RDMA/core: Clear out the udata before error unwind
Thread-Topic: [PATCH for-rc] RDMA/core: Clear out the udata before error
 unwind
Thread-Index: AQHVD/5bAV3bZyKmEUeuU/KAE0hGUg==
Date:   Tue, 21 May 2019 17:55:22 +0000
Message-ID: <20190521175515.GA12761@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 691ae9df-8434-44ba-6ea6-08d6de157d22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6543;
x-ms-traffictypediagnostic: VI1PR05MB6543:
x-microsoft-antispam-prvs: <VI1PR05MB654344C464BEA7F161C06EA2CF070@VI1PR05MB6543.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(386003)(305945005)(6506007)(68736007)(81156014)(8936002)(102836004)(7736002)(8676002)(81166006)(3846002)(2351001)(2906002)(6116002)(6916009)(478600001)(1076003)(4326008)(33656002)(36756003)(2501003)(53936002)(5660300002)(14454004)(99286004)(476003)(486006)(26005)(54906003)(52116002)(25786009)(66066001)(186003)(256004)(73956011)(66946007)(66556008)(64756008)(66446008)(66476007)(6436002)(71190400001)(71200400001)(316002)(6486002)(14444005)(86362001)(5640700003)(6512007)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6543;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p/x0dZIXVL9+Ex7sQ5THELISPdZqOja+LctoDTAmqXoqhrd5nBVG+M5g8wdPqNNg404wJ6wMEY7Pe9/5pG4aJ92EeJf9WNYmJZNu7h5lcvwzy8efMl6oprG++afsDCfH1LkRY1TOC5IdyqvbXjma7ye2i+ufpWZsRsawxQwTyVshvji7L0lMI9hjG3fkaBj4AMNZmJlGp10oGb0Wwx9by7RTXziIHWv2RjKatfZtxq9DgGrc2ZKGs7AaOycMmoHp/ZbJ3tkbSmCuvtAEaqj1MICeh2eoehjVE0mkEEAPyitUrrm6MKiMj5SuO1fPxQnguPunxtPyaQ/sV3I3wVUUcFlrk34gMjGrNcC3B2wkPndUbbHjyi72YC79a1waQG3nlw4YujYzhm8jT3UPSkWKK/RC2WJ+VbPOL2ELTj6yMbA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4ED2E7051CB7F84198F17A9A090CD196@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691ae9df-8434-44ba-6ea6-08d6de157d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 17:55:22.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6543
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The core code should not pass a udata to the driver destroy function that
contains the input from the create command. Otherwise the driver will
attempt to interpret the create udata as destroy udata, and at least
in the case of EFA, will leak resources.

Zero this stuff out before invoking destroy.

Reported-by: Leon Romanovsky <leonro@mellanox.com>
Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.h           |  2 ++
 drivers/infiniband/core/uverbs_cmd.c          | 21 ++++++++++++++-----
 drivers/infiniband/core/uverbs_std_types_mr.c |  2 +-
 3 files changed, 19 insertions(+), 6 deletions(-)

Fix for that thing Leon and Gal were talking about.

diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/=
rdma_core.h
index 5445323629b5b5..e63fbda25e1dca 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -110,6 +110,8 @@ int uverbs_output_written(const struct uverbs_attr_bund=
le *bundle, size_t idx);
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile);
 void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
=20
+struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs=
);
+
 /*
  * This is the runtime description of the uverbs API, used by the syscall
  * machinery to validate and dispatch calls.
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index 5a3a1780ceea4d..a9b32ebb9beb77 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -174,6 +174,17 @@ static int uverbs_request_finish(struct uverbs_req_ite=
r *iter)
 	return 0;
 }
=20
+/*
+ * When calling a destroy function during an error unwind we need to pass =
in
+ * the udata that is sanitized of all user arguments. Ie from the driver
+ * perspective it looks like no udata was passed.
+ */
+struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs=
)
+{
+	attrs->driver_udata =3D (struct ib_udata){};
+	return &attrs->driver_udata;
+}
+
 static struct ib_uverbs_completion_event_file *
 _ib_uverbs_lookup_comp_file(s32 fd, struct uverbs_attr_bundle *attrs)
 {
@@ -441,7 +452,7 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle=
 *attrs)
 	return uobj_alloc_commit(uobj, attrs);
=20
 err_copy:
-	ib_dealloc_pd_user(pd, &attrs->driver_udata);
+	ib_dealloc_pd_user(pd, uverbs_get_cleared_udata(attrs));
 	pd =3D NULL;
 err_alloc:
 	kfree(pd);
@@ -644,7 +655,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundl=
e *attrs)
 	}
=20
 err_dealloc_xrcd:
-	ib_dealloc_xrcd(xrcd, &attrs->driver_udata);
+	ib_dealloc_xrcd(xrcd, uverbs_get_cleared_udata(attrs));
=20
 err:
 	uobj_alloc_abort(&obj->uobject, attrs);
@@ -767,7 +778,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *=
attrs)
 	return uobj_alloc_commit(uobj, attrs);
=20
 err_copy:
-	ib_dereg_mr_user(mr, &attrs->driver_udata);
+	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
=20
 err_put:
 	uobj_put_obj_read(pd);
@@ -2964,7 +2975,7 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_=
bundle *attrs)
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
=20
 err_copy:
-	ib_destroy_wq(wq, &attrs->driver_udata);
+	ib_destroy_wq(wq, uverbs_get_cleared_udata(attrs));
 err_put_cq:
 	uobj_put_obj_read(cq);
 err_put_pd:
@@ -3464,7 +3475,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bu=
ndle *attrs,
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
=20
 err_copy:
-	ib_destroy_srq_user(srq, &attrs->driver_udata);
+	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
=20
 err_free:
 	kfree(srq);
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infini=
band/core/uverbs_std_types_mr.c
index 610d3b9f7654d8..997f7a3a558af9 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -148,7 +148,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	return 0;
=20
 err_dereg:
-	ib_dereg_mr_user(mr, &attrs->driver_udata);
+	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
=20
 	return ret;
 }
--=20
2.21.0

