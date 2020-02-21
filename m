Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD52168159
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBUPUb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 10:20:31 -0500
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:45696
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbgBUPUa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 10:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC9xGwuQBojHK3zTWtjTzNCMWyRExGI4826AwDn3j0/Ykr/MWMC+PSL2dOpPHdWArarzmoBWKs7zQmxzkLHHowX5ub6hpFdVWTqVFQKCzz1XHXU9V4vrsTET1C3SysBexa+ynytaAsK1i2rNwIwO+D+k1rpNIuOl1GoVMNpze7uBLNldaeOZR5jGshn6PfglX3k4g8tHER6kIyR+0SZ7Zx3nGcqpaK5xwiINjfme39OM1hoBmEUC2z0aLgD4y12uLHV9q3WbcU8Cx3/DfqBLmdZwavmQtJuitSzxcG8qXnKzCNXs1zlIjnh7Iimj4e6iiVagqt2wsRkYuNgbYsGHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUhpd+hAICIkfTceb8co7bQ9iG8zto6rEqikDk3rxdw=;
 b=fQR+PP0aFyJgAio63khBb5mHCWiQVd3GxLBPrS07JncGqnFI7UMn21D9V25NK8uDi3pESDjhfA2AonB3jqaO1jDxwaWUwLrEY1NdnbU/PDRQTaYYlriR+6e01HWZbUeEQNmwavuka0StfEogSorWlhJO2zg3f1y/QQ+Sr3GqJQZiym8HxenI3Lupvi+aYvpfm9w+8ooAX/gkjPYUbbQOGVUR2MfRKi1Vk0AgUICdShiOEoIIkzLCkZ1H0DMq4rzDJNCEVqtiF6Y+2ehfZgj1ujHThsxznKgvlnvgYFn/Y+41DkzkMqZpKaY/uYiq4ykZgtBpIsQFv+PFdjLzR0ukFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUhpd+hAICIkfTceb8co7bQ9iG8zto6rEqikDk3rxdw=;
 b=WCjZFeRCciCZwPr/QBtFfap/mlqH115ROsVz6MrTi5AtYmtE/0nASNn8+l1/X5pB+UBQdYzfBeEKwuR3IDcehC+675NF7809INha2Kdxvfi50w0z6SDwECuVGQl/7njzLIliwLlHphaxrxfY/Rt6L7MbN5QxCurWLzlCpfz/ytc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5022.eurprd05.prod.outlook.com (20.177.52.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Fri, 21 Feb 2020 15:20:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 15:20:26 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:208:23b::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 15:20:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j5A6J-0002I8-HJ     for linux-rdma@vger.kernel.org; Fri, 21 Feb 2020 11:20:23 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [PATCH] RMDA/cm: Fix missing ib_cm_destroy_id() in
 ib_cm_insert_listen()
Thread-Topic: [PATCH] RMDA/cm: Fix missing ib_cm_destroy_id() in
 ib_cm_insert_listen()
Thread-Index: AQHV6MpxlnKqvwyLG0ShCAwT3qCZ9Q==
Date:   Fri, 21 Feb 2020 15:20:26 +0000
Message-ID: <20200221152023.GA8680@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:208:23b::12) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8d4ae6b-418b-43bf-6c88-08d7b6e193e1
x-ms-traffictypediagnostic: VI1PR05MB5022:
x-microsoft-antispam-prvs: <VI1PR05MB5022EF2234AC84E558920594CF120@VI1PR05MB5022.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(189003)(199004)(6916009)(86362001)(5660300002)(9786002)(9746002)(1076003)(316002)(2906002)(4744005)(478600001)(81166006)(71200400001)(52116002)(81156014)(8676002)(66446008)(66556008)(64756008)(66946007)(33656002)(66476007)(26005)(9686003)(36756003)(186003)(8936002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5022;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZZzgyrGtanInxlKPITxOc41/QfdP6tUhvdLCtEdosk5rLX9viEzMJFVJ1HGQQVfD34EhtreKCybYwRxhHOD/rKvMs93T4pw4VAwHKNQTVNKKfVNAsQhEySxgoJ5KXw02AKgnqxOIg1mpaI8r8zjRNDb5H63Uvy3GdD7+dS5LmKlM2pWu8V5LKCKuttO2LzN11KDEZ+I0hoANOs6c+V3Kj7FmsFRLMzWfPK4ZQi32kWiTKLAoSphp198qozcJik+bcpSv9z3wfavYR95XNw1cihgs3/I9kVtPaOSU/8EZ3FV96zBrsNhAtrbFF7m4hcbCclThvpd4OHZIHYEmHp7MWU2fLsolegKOxIIlQ/O932VN8Q74vrTqaNrjlR93U9rbE5EJ3VR2YwDMlc6YYwwjphUhT7yyj2Sn7w8kufPglaqVdenOg7+a2W0rQSQMZf1cLc2pZoTjRssBMOvyYckYitEXUV6q5/i+lAk0KrhMKPAmMSVZ+8ubaCmlAPdLfXm
x-ms-exchange-antispam-messagedata: SI+OykCQNEdrr+3jewOYtWv89Y5YqmWUJw5tD1VYgF1Qrr1Yy+iTtJAmsBgkTuw/c8UB9H1PJuTxklDKbEAVXyf1xAzCYvaESOTc3OY1XNP4zCsH1t84oMQQTyZ9z65zoYCGbLFQGhxmsP0ZlIPLcg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71BEAB1B0520E74BAED4AC670BA6593D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d4ae6b-418b-43bf-6c88-08d7b6e193e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 15:20:26.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2ZIGrXFithT6Dr6tF1jplECXx2PZ1aStNtkySEbrTArzE+Afx4/zniIhLruzf2FuOVQcRGeT5KOZV/w6R3ouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5022
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The algorithm pre-allocates a cm_id since allocation cannot be done while
holding the cm.lock spinlock, however it doesn't free it on one error
path, leading to a memory leak.

Fixes: 067b171b8679 ("IB/cm: Share listening CM IDs")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/cm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index bfe97bae91ce0d..c8fe74f6394faa 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1191,6 +1191,7 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device=
 *device,
 			/* Sharing an ib_cm_id with different handlers is not
 			 * supported */
 			spin_unlock_irqrestore(&cm.lock, flags);
+			ib_destroy_cm_id(cm_id);
 			return ERR_PTR(-EINVAL);
 		}
 		refcount_inc(&cm_id_priv->refcount);
--=20
2.25.0

