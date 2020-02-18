Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04618162F9D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgBRTRE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 14:17:04 -0500
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:35639
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbgBRTRE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 14:17:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2g9xCV1YZWA/5tRbj40JRJkMW2m58EWtpRvFxOwMMHAWTdwAz+AXIRyFG+HFjr0gQj9YaNlphJD6TRHEPpATBvq41P00hCyWbLcY/AhKGvnBYYtpXxhtNSWlR6WqNENsu8bIRa0DjKKlXLmYg4cONp+Nmci/UiAmi97zInF2fO2EO0ifsWTFpqSu4s96RliECUwKwEAIUSk+ovKhiH0KYFcOQQlwR6HpJjG/AJ5Cq0HqgWmfA+ZlTpivJJPZpBbOKqnqXJHczcfSU1VyjaQ8x647duKs5Xb9oclxdGYYGfN8Qi8XzcBI1rPB5AS5sAdflDByq5P5If3LiS1Ksk2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ7A+6ZLypsg/gDImTAJou6KVEz4kZV8M323P6/Al6g=;
 b=SPtAoH5gdC1MkRhQGP7gWOv7rtOdso1X0n+EDu4cIgTZ7x3NKcfgOLEQCjiYFa1UowdJD3eYWh/yV3dQgdjpoRlqoQ/mM6d4whmkBwzB68n9oQQITsowKvCiqQr/3lGBy5U+6dIYHGFs/mprgj/m9t2z+i8VXslON0I7ESIi8P31R1f6DxZcj4zPxGM78B2EhBXiJWbkeSNyrSn2RXwfKBDxJoxC8X6GS0FFnQ3QVax0xtxfMsY3DSlfeCIQPeAjUntCeTjKz8oWI+OJENb2/sm0h36a381DLL0+MOsSydvIy+iHw9QXwp7I6+zR4oxPPebJY8U1CyrIcg4OcvAoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ7A+6ZLypsg/gDImTAJou6KVEz4kZV8M323P6/Al6g=;
 b=j9SsXhS2t/l2Ec2+KxsCKG/4DCg7/xkfZg+MZ66qIJ/QnVE5owuAkqxShMdtphMyRvaG2I9+CWZIJ4FUgCHvca+dnB75zmBp7TopvPNYDPFuveKDerEog81dM0jZFzBPYIbiJ3UHdF8mgf2bSdySXJ4lOKynOtY6fs1WhiRQrL4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4223.eurprd05.prod.outlook.com (52.133.14.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Tue, 18 Feb 2020 19:17:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 19:17:00 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0038.prod.exchangelabs.com (2603:10b6:208:25::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Tue, 18 Feb 2020 19:17:00 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j48Mb-0007k0-50     for linux-rdma@vger.kernel.org; Tue, 18 Feb 2020 15:16:57 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/ucma: Use refcount_t for the ctx->ref
Thread-Topic: [PATCH] RDMA/ucma: Use refcount_t for the ctx->ref
Thread-Index: AQHV5o/+nXvxHXBnbU61iZRpZOE2Uw==
Date:   Tue, 18 Feb 2020 19:17:00 +0000
Message-ID: <20200218191657.GA29724@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0038.prod.exchangelabs.com
 (2603:10b6:208:25::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc508ea7-2ce6-4b5e-764a-08d7b4a72131
x-ms-traffictypediagnostic: VI1PR05MB4223:
x-microsoft-antispam-prvs: <VI1PR05MB4223DD2BE6E7FF36DEB0A7E2CF110@VI1PR05MB4223.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66476007)(478600001)(66556008)(64756008)(66446008)(86362001)(66946007)(316002)(5660300002)(6666004)(33656002)(71200400001)(8936002)(81156014)(81166006)(8676002)(1076003)(26005)(186003)(52116002)(9786002)(9746002)(36756003)(6916009)(2906002)(9686003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4223;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mjdqck1pYf+M7QXn8CxeqagC6hMj4nZwCHKwvjs8hLdYbfS/voOsRE6IQK20Cm5tDT9jJn7Jlq4tbiG2LVKwi5gn9ximCZ5TLPN1rfUuLlU8rUuBBEjXTz667vgIVmVE05a6rqLTwQilkfNxSRDDUZ7tx+GgQUf3ZHhH1J9FpBjU9ebBRObQS+cOr5DDsnk5nXE404ym3Cq0kaioZics8sHXl8039xizYwnO09YD7ZnEj2YM5ADCD/knOtITWo7CO5nx/bRwsLlNfB7arTpmuVfi0ENVHRXH1o/EnELJmIV+LrRnq7uuRRYakO0gSGNN1MB1jUAgsDUlauGYZyRTWIuNrgTFDgx5/ZCkPCF25VtD4Ves85+8vX6hJppx7D10/KKXnbEi/xGGi69H/rUEqJP/Q1DF0IX8MuVceX8jDMfi8XtKw5FU3zUgs2T2yVkVYp0ybD8X6io1YHIVQ8BZiGZX4UlnTAruEsYAIy2wIC4pfJCvSGXODMFC904+kexl
x-ms-exchange-antispam-messagedata: oeqddWbIbnDPY8R2+uFGmRuI6qomv4UC6s6LHKgIQNu6xsR5oYWQmqR5za2eZwlj+5m5VIEJObPDc93pm6ecXW8LBUneXJAR8pgWNwUuHQzrMuM0Jqh7DzUvr91bPiGqpkEgx7GGh+e60c2ujl7UyA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0989584E2902C048B2BAE91D97F924BE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc508ea7-2ce6-4b5e-764a-08d7b4a72131
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 19:17:00.7391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIoSZoUcwP7qUMyWtSmQn9aJyxWuJIdmbNfwErquwA3KlOc83QAk1hPRMNJC4jaauM6PDqxeGSlMmoZARpeoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Don't use an atomic as a refcount.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index 57e68491a2fd6a..66ad29c672fce2 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -85,7 +85,7 @@ struct ucma_file {
 struct ucma_context {
 	u32			id;
 	struct completion	comp;
-	atomic_t		ref;
+	refcount_t		ref;
 	int			events_reported;
 	int			backlog;
=20
@@ -152,7 +152,7 @@ static struct ucma_context *ucma_get_ctx(struct ucma_fi=
le *file, int id)
 		if (ctx->closing)
 			ctx =3D ERR_PTR(-EIO);
 		else
-			atomic_inc(&ctx->ref);
+			refcount_inc(&ctx->ref);
 	}
 	xa_unlock(&ctx_table);
 	return ctx;
@@ -160,7 +160,7 @@ static struct ucma_context *ucma_get_ctx(struct ucma_fi=
le *file, int id)
=20
 static void ucma_put_ctx(struct ucma_context *ctx)
 {
-	if (atomic_dec_and_test(&ctx->ref))
+	if (refcount_dec_and_test(&ctx->ref))
 		complete(&ctx->comp);
 }
=20
@@ -212,7 +212,7 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_=
file *file)
 		return NULL;
=20
 	INIT_WORK(&ctx->close_work, ucma_close_id);
-	atomic_set(&ctx->ref, 1);
+	refcount_set(&ctx->ref, 1);
 	init_completion(&ctx->comp);
 	INIT_LIST_HEAD(&ctx->mc_list);
 	ctx->file =3D file;
@@ -1502,7 +1502,7 @@ static ssize_t ucma_leave_multicast(struct ucma_file =
*file,
 		mc =3D ERR_PTR(-ENOENT);
 	else if (mc->ctx->file !=3D file)
 		mc =3D ERR_PTR(-EINVAL);
-	else if (!atomic_inc_not_zero(&mc->ctx->ref))
+	else if (!refcount_inc_not_zero(&mc->ctx->ref))
 		mc =3D ERR_PTR(-ENXIO);
 	else
 		__xa_erase(&multicast_table, mc->id);
--=20
2.25.0

