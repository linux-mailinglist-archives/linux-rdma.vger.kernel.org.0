Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957E51393B9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 15:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAMOdN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 09:33:13 -0500
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:59716
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgAMOdN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Jan 2020 09:33:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCSwoN67JsSHK9s3kg/h3y+uSQbK1OpEuKpfYkhYJGKRxMhbkcDz+unsBVvxwuZYBmcNHdpBaDqdHafq8YevC4vs3ouRh4lCe0jRO/YRgL0eB9m4Vqge5MxXja0OQWj7hB2hdTnD/+JiZOGyKs3ucmt1Yg3IcJHHcSDblsfXa2bsrkJLRuCEGQeB7pBhal1XkC0+GwNxPyzZEOMwp50Y6Q2KpgXqFpMlWKKXN+GKPmOYj9X2+4lDIetUTOOta95goFfSv1W5y0GhI0YdFAnrkbv/6LpiEhCEcxXQoQXJ+bfH4+pHqK/kOx52v3u7SDV7SJPbV0YhhKw6YmHOKGoz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHCBPAKywv/JfX837DCFjQHzUzJYUaUmgc+khZJHHIQ=;
 b=VpFsXRYo3XYhg8QsWk4A2LDAkT3lmV1s2TRBA6WWp8ZmULV90AsgN4IHc6dRYZz5MW+MVmVZT2ogeKzEaEEvrb2t6dgsRX04MdWFMfEdLd3ytbkUy7dzZYQreyYMWSrrIcS78dpIBchiNYJfWBEHSdbl+SdWZGTAeNLqtdsjxyCWYuTOugK4CMP4BDs58FUZ9TlQ6XpZ7qXVERAIKzWxD3ZCDAjYVk5z0eGCJkciMhiJZNbBXBB8ot6FCIkp9xOfxr834BXIeBMnQO2hxAy0Nw3m/GHnc39c5Xa1COUIlKTSzZcj+WGUl2UWg7Q/b5wa05Ocz3RRbHsho9Mlk2YiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHCBPAKywv/JfX837DCFjQHzUzJYUaUmgc+khZJHHIQ=;
 b=If7Y3aoLqorcGH7sWSItrBF3byZPGbpnKGcchQ4YkAOJFr3+PxnEteUzWjmQH8MeEx1HaOaCqOG03ZbyKOgeYoeQeTNqOYDgdyDXhZ+ONL++S0NtSZliUgIXJqmLMojIuV6QYWggEb4dW2MJ0uDChtFNGqSmMbALSETJnAQ5I1A=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6288.eurprd05.prod.outlook.com (20.179.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.12; Mon, 13 Jan 2020 14:33:10 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 14:33:10 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:d4::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 14:33:10 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1ir0mB-0007ZD-0d; Mon, 13 Jan 2020 10:33:07 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Michael Guralnik <michaelgur@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH] RDMA/uverbs: Remove needs_kfree_rcu from
 uverbs_obj_type_class
Thread-Topic: [PATCH] RDMA/uverbs: Remove needs_kfree_rcu from
 uverbs_obj_type_class
Thread-Index: AQHVyh5h4DGrlAJrz02SdJavNbXIxg==
Date:   Mon, 13 Jan 2020 14:33:10 +0000
Message-ID: <20200113143306.GA28717@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b05b8bab-7459-4f55-ddbd-08d798358383
x-ms-traffictypediagnostic: VI1PR05MB6288:|VI1PR05MB6288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB62889F87ED4BFD343E005E55CF350@VI1PR05MB6288.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(66946007)(64756008)(33656002)(6666004)(52116002)(81166006)(81156014)(8676002)(26005)(186003)(9686003)(66556008)(66476007)(86362001)(66446008)(36756003)(9746002)(9786002)(107886003)(2906002)(8936002)(1076003)(71200400001)(316002)(5660300002)(6916009)(54906003)(478600001)(4326008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6288;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5sw/DNIvMec6FlidAUVJ09gmaZw3s2KgWofi5oMaKHa594gIps11IKvLv9ViwpeOAVxJzUpIuqlli5qJkPIV0ECIpaNTRkQ9R7iKqrhA6f+VyP8Svi18UYiBV9vjpr3wcpc2O2Y+Z26rDH5m5lnQ7Xkurqqw4CMsRiGdUbpHCQkB8kx7oOy2sGIWvnrD0Puc7UH5gk4KsleKE3RX5IbAVVEVY2D/Ys23nKtwh2wwumwPLunttOz06krswyFu02t4nSsHdY+ga7xzGQxmDaQcSyD69ciWFkEJoUEtHH7NAfPv2l16uzj1w5iyy5Ivw7jG0qiKQ8i5vNy9V/qzLBDEHuTDcDAirbK4P8VVgWGttee1gneDtkN9izuJCj+6JtT6Vt+WmFSLa9gwSpc+ga5R60raJUpFOWb+otAW1wPkR7BByaBypf0KFvBXdO4UbHVPaAWjfSBCFfiTaLsZ5fsJ0riRwKFcqUNhRG1kXv/MVD/vtQnmUPqHoENf+csYm5x
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3543D026F7C8684AAFF60E5F7D704151@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05b8bab-7459-4f55-ddbd-08d798358383
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 14:33:10.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bv0c94wHo2T/3MX47UYi39VV94DNGbBz++xiXQDSOj62/fsXaS7zbHtW5lc8zN0hseG9NBmDgJByqmyzog5gIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6288
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After device disassociation the uapi_objects are destroyed and freed,
however it is still possible that core code can be holding a kref on the
uobject. When it finally goes to uverbs_uobject_free() via the kref_put()
it can trigger a use-after-free on the uapi_object.

Since needs_kfree_rcu is a micro optimization that only benefits file
uobjects, just get rid of it. There is no harm in using kfree_rcu even if
it isn't required, and the number of involved objects is small.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c | 23 +----------------------
 include/rdma/uverbs_types.h         |  1 -
 2 files changed, 1 insertion(+), 23 deletions(-)

This should go before the 'refactoring fd usage' series as more
testing has shown the reworked code can trivially trigger this
existing bug.

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/=
rdma_core.c
index 6c72773faf2911..17bdbe38fdfa59 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -49,13 +49,7 @@ void uverbs_uobject_get(struct ib_uobject *uobject)
=20
 static void uverbs_uobject_free(struct kref *ref)
 {
-	struct ib_uobject *uobj =3D
-		container_of(ref, struct ib_uobject, ref);
-
-	if (uobj->uapi_object->type_class->needs_kfree_rcu)
-		kfree_rcu(uobj, rcu);
-	else
-		kfree(uobj);
+	kfree_rcu(container_of(ref, struct ib_uobject, ref), rcu);
 }
=20
 void uverbs_uobject_put(struct ib_uobject *uobject)
@@ -744,20 +738,6 @@ const struct uverbs_obj_type_class uverbs_idr_class =
=3D {
 	.lookup_put =3D lookup_put_idr_uobject,
 	.destroy_hw =3D destroy_hw_idr_uobject,
 	.remove_handle =3D remove_handle_idr_uobject,
-	/*
-	 * When we destroy an object, we first just lock it for WRITE and
-	 * actually DESTROY it in the finalize stage. So, the problematic
-	 * scenario is when we just started the finalize stage of the
-	 * destruction (nothing was executed yet). Now, the other thread
-	 * fetched the object for READ access, but it didn't lock it yet.
-	 * The DESTROY thread continues and starts destroying the object.
-	 * When the other thread continue - without the RCU, it would
-	 * access freed memory. However, the rcu_read_lock delays the free
-	 * until the rcu_read_lock of the READ operation quits. Since the
-	 * exclusive lock of the object is still taken by the DESTROY flow, the
-	 * READ operation will get -EBUSY and it'll just bail out.
-	 */
-	.needs_kfree_rcu =3D true,
 };
 EXPORT_SYMBOL(uverbs_idr_class);
=20
@@ -920,7 +900,6 @@ const struct uverbs_obj_type_class uverbs_fd_class =3D =
{
 	.lookup_put =3D lookup_put_fd_uobject,
 	.destroy_hw =3D destroy_hw_fd_uobject,
 	.remove_handle =3D remove_handle_fd_uobject,
-	.needs_kfree_rcu =3D false,
 };
 EXPORT_SYMBOL(uverbs_fd_class);
=20
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index d57a5ba00c743e..0b0f5a5f392de7 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -98,7 +98,6 @@ struct uverbs_obj_type_class {
 				       enum rdma_remove_reason why,
 				       struct uverbs_attr_bundle *attrs);
 	void (*remove_handle)(struct ib_uobject *uobj);
-	u8    needs_kfree_rcu;
 };
=20
 struct uverbs_obj_type {
--=20
2.24.1

