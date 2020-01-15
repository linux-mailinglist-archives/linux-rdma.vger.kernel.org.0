Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7013CE04
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 21:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAOUUt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 15:20:49 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:54820
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgAOUUt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 15:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbSJ1OJ5bbu38PYKrMhc9x6s58W/1dRfk/z7z9d9mHjYCCYzNet0u9mpCU5MCwZ2/vXxJH9p13E9ZqfEPcHBmIw7o6RO9yaB14hekBzIjVYCaBqcto0ILDT7fcHNfTk9b2ItLod1IJg0g7HKCkK9Dx2XzALEy9+Agz+yo5mrE8jV+fmVfOS6J0RB3/kcBMd0tlokIPaO+2is/5ICumw2ldnjIVvCcAPPJY8mYzrRKfzVcKGT3KYlCR+xQgoHC5d8nfrBnThhaTybv1JYP1AGiTG2MKzqHjhntl978/oowQuo/STxV10jVlu2XtbwCyAtDH/Yty+GpUbzuZBLnpphnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKofr3tTQLDfn0chgpel8HFKhhFa8T6ZcaCJ2cCVgfg=;
 b=TbndU1mWlIswpooMf062R1pqzexdGnikZiv9i8nPJP/DHAqcApCzQMGZHUcdyMx9kKej+sWzAR1FvSb4VCgTvmV1kX9uGa76wj0L+M6k8zxh/xXppBEGK2I4q0GAdPhRmkvGex62T7Ngq6II+ExmX/pfq34HFzW6IJJA2RV8rIRJYgDTEaZLQ8FEBdZg++7sY/g/XjejpWQAASSgv8pL+bXKyGAXuq8GyVgDYWB8HdV22uoLH0M38gIAVaKIxSOwSaC3qz4WrZr2L08m9tNhNHjpQi6Rj1NX1s3Zp1VyNc+rqnLPcPkTurh8m4DTZ/A7wkWjFVFwmNmH7qIlGCHx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKofr3tTQLDfn0chgpel8HFKhhFa8T6ZcaCJ2cCVgfg=;
 b=bemJFdpAgL0S+1c/MHF6insqufnS5IerLoz0RB/IfDNlxrxsUAcfLKJv1j3IpaGj1Dadn9gfMZNpyy6CJPjU5ug1DMOTMl+F0LiNyJUHlfYrBx4EENgLdG9/BSLRXO3TZza0NjSHYDE+zO07jdaNLL1xnuiQr64jaY/vs9Aeh3o=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4573.eurprd05.prod.outlook.com (20.176.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 15 Jan 2020 20:20:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 20:20:45 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend Transport; Wed, 15 Jan 2020 20:20:44 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1irp9d-0004VS-Eo; Wed, 15 Jan 2020 16:20:41 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is a
 fence
Thread-Topic: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is
 a fence
Thread-Index: AQHVy+FEjDSjACX4D0WvK+XBwBxvVw==
Date:   Wed, 15 Jan 2020 20:20:44 +0000
Message-ID: <20200115202041.GA17199@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 881f08a6-3cf6-4869-3736-08d799f86678
x-ms-traffictypediagnostic: VI1PR05MB4573:
x-microsoft-antispam-prvs: <VI1PR05MB4573737B2F3409CC95F87DA4CF370@VI1PR05MB4573.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(52116002)(66556008)(66476007)(66946007)(1076003)(64756008)(9746002)(66446008)(9786002)(33656002)(316002)(86362001)(186003)(71200400001)(110136005)(2906002)(81166006)(8676002)(8936002)(81156014)(5660300002)(9686003)(26005)(478600001)(36756003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4573;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klGR/nxbwpVfua+60A9XnHf35WEYOKX2JZfhYrC7799xDUOZe29CzTIkU0UOWimYQytCjL9PmaqUBwsbcDrWB1HRhHJqKYNWtHTX8rEyrLvBOldJ5pjyxnppx5cHMt8DRHhUoq1JXKnUFvSxaHuAt+YF5jqG629qXQIkqSSjBYd2JGPknznkoPG538tBJyWUd8heYcFF8+gTK4RB9yUqex9v0xgHUzeE/6m6Nj4rDfcRXnpzDc+PV7cRT2SFCbBxtubzYol2zgnFyXWVAQo4aOG60hpgRQilYZvcyu3QAmuVeLOxn5xz9pCmhd1WglIwJpPy0EcNiTTvg1442qSPaEnDE6s+H5Kcb3kGzjx2p2Exj+Fv67G6pfkXdJaslmJ4mMbGyrkDJHLo2voQIMoJ5cN2fEkj80MEUvh5ug8Bny1ip7xi0MEgVDB9qMxrRjsWt6Fi1KImO4RxFVc2q7LJFFoOV9tICAadIlLlLmu5nByugi4bN49ERdeEQL2Qe8VF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B33E2ACF966B44EACA1CBC0BB38C5EE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881f08a6-3cf6-4869-3736-08d799f86678
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 20:20:44.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaTeKljai2BSdLGpGjjaXiJ5iq3sY/yDMaM7StpdV2T1JCle6lNmYFNma0Vf9nKwFXbHslJC3pUZkj7Uz9/vAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4573
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The set of entry->driver_removed is missing locking, protect it with
xa_lock() which is held by the only reader.

Otherwise readers may continue to see driver_removed =3D false after
rdma_user_mmap_entry_remove() returns and may continue to try and
establish new mmaps.

Fixes: 3411f9f01b76 ("RDMA/core: Create mmap database and cookie helper fun=
ctions")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/ib_core_uverbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/=
core/ib_core_uverbs.c
index b7cb59844ece45..b51bd7087a881f 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -232,7 +232,9 @@ void rdma_user_mmap_entry_remove(struct rdma_user_mmap_=
entry *entry)
 	if (!entry)
 		return;
=20
+	xa_lock(&entry->ucontext->mmap_xa);
 	entry->driver_removed =3D true;
+	xa_unlock(&entry->ucontext->mmap_xa);
 	kref_put(&entry->ref, rdma_user_mmap_entry_free);
 }
 EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
--=20
2.24.1
