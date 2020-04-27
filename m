Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A441B9523
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 04:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgD0CeH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 22:34:07 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:28200
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgD0CeH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 22:34:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBVH6vQlKNmdaS9RqdDztX9iwpRfXKqeXwJY/MS9oJF2rOjpYsutqr9C4W5vl7UU+7s0ElE40UO28cNpTv1siDXO52tZ5cQg7fqgY1aKisfsSFZJRsVL5I2jN5rVsdWjHoJ+Zc6uIkLVsLur2Egzy7alltDypfia6V3YzavuJLjvJydE6e2SlbM3mrKqNUd5P7xR3x397GdQY10PE4b4Ev351Yb2A4hpnOQ45mNDcUcG4nVzTV5XATQsTWuqxcCV5THI7PnRCTXuqWEZHkFZ7FgA/rsRSw38JL8/Ss7eGmugzaTdvDRachx5Ak/90koG2sQaOIvHuYalg4UThOFFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydp4Rx6blscjQnmi/vxgK+oUo8DxYxFut9mGHE+c3WA=;
 b=TcAW7QeCFqPlh5H0RYdJJMgELdCjGUBsqUnxW6Q6rbSFVGrGjK1sy+n+2n2RlCfq0HZ34FbubPQ7up0G7nNGd49+Akofmni1mSGm4Mr9KfjPIJX0yslJfaKVvuZJ3LZjBlU2APGU7oDq/5qyNssvXC1t4IpFKgtF4PtJdLVtmmpYz1Rc9rOfNBUQp31fgVUSqieniVnGnyujKe99V3X32q7H6DAVItor8wzb0LFbgj3M8m0irDWRLsmb/T4s3wDXlK4+F7bz89sGg3TIipwaT6Pc9r4BPtgsb+nCVWWJulSOttBTjRNHs1eYx1KMiLbp4kz2QP1eLfm0nxCGbkoUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydp4Rx6blscjQnmi/vxgK+oUo8DxYxFut9mGHE+c3WA=;
 b=FrY1gruubDjdzEI+mB2o6e9yYkGTKCDzXygtzirpCYkIBkuAD26KNS6nCdZ8J/nmuTa0oh/hl6ispoUiys6OHwpWu52fTYl+D3+fivubzjgARzXFIuvAYCflxNQ9cL9N9PgGFcxJWyEvQMunp/5kGQMLbkn2oQDnSLl2fQNMDtk=
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com (2603:10a6:20b:4::13)
 by AM6PR05MB6470.eurprd05.prod.outlook.com (2603:10a6:20b:b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 02:34:03 +0000
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::fdcf:854a:cffb:1ac3]) by AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::fdcf:854a:cffb:1ac3%7]) with mapi id 15.20.2921.030; Mon, 27 Apr 2020
 02:34:03 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2] RDMA/rxe: check for error
Thread-Topic: [PATCH v2] RDMA/rxe: check for error
Thread-Index: AQHWG1pBq55CaERy4U2zSkMOnPc6jaiMQWXQ
Date:   Mon, 27 Apr 2020 02:34:02 +0000
Message-ID: <AM6PR05MB5014ABAB86FBF15EDCD11AA0D8AF0@AM6PR05MB5014.eurprd05.prod.outlook.com>
References: <20200425233545.17210-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20200425233545.17210-1-sudipm.mukherjee@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yanjunz@mellanox.com; 
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ae0f3d0-5f99-4659-8002-08d7ea537316
x-ms-traffictypediagnostic: AM6PR05MB6470:
x-microsoft-antispam-prvs: <AM6PR05MB6470474AE48B59B36C0772F4D8AF0@AM6PR05MB6470.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB5014.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(33656002)(9686003)(4326008)(26005)(5660300002)(55016002)(6506007)(110136005)(53546011)(186003)(54906003)(86362001)(66946007)(66476007)(7696005)(64756008)(66556008)(76116006)(316002)(478600001)(71200400001)(66446008)(52536014)(8676002)(8936002)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1P+wTFFAL/a+Uq8AaOqrdOYuTLKa3RxWSc/DxrZWi3grAlPLcgHCF00QPYob2mH+mrI90/WxkaZ2s9r8aIyZ1dr5py50e3VpYQkA4jrZElWxBiicZW1CrJRYjUjWN5Kai/ov5eC+NkPtx99wfFPwQgDlPzjWzjI44CJvb06r7kMC0P7hh9OUX08wfHQNDQzgsi96Rj2MfKnHp7Z0y4ah9j08gDItXEdKKGFdYJ293UC5dTGNHgoixJMS5CfjItdZaUDDiQchN6IIDQzOjX7ZTfN7ZSN9gLuquo3KudshxONVk5ttvZ+ml1tJkgLrpYJzfvBiEZ9As3xYRD+YybOiXMeD4FABAN7Gja+RqHp0tSIZ9V646zI51WgZ73I2/NQDsg7+ExkhOu2l9ENoNX0lxWUwWOzomguKgaZqXSUPp0tMAOyLg0/n7DDTle8/fTFG
x-ms-exchange-antispam-messagedata: PFbAGyLamgTXwWab3ltXwMhE0PGB9MhbCMg5XbFjPkwwcgzTKo9EapcJ7vyz+WI4QGsCnH/TQdfmjNMOVryshrKmy01jGqFUpN8hPwV52uUBGtpmHhmi4xtPBIhPtv2waYkW/RKXwRQNyPRD34aV0yI+zjou6kruuuqeY7MBs6ZWRzRC1gx6anAtXiOzImQOGjBrz8f4v3WFlTK4TEXhHCeX6vJQXpk0nPyqWBOOMbCZOEpFm45GGfal1UawHfJg91u9DUdgId8bW5l0RoqeeNu5Jka+5y/JXpf9UXG2fNV3L+tZHZPwnYZHYI3XiBbBEJLkjDbHEJk7G/9eEs1AtLQonINXwo/mmVS+4aahXpdBBoNfD+NKYkh6L2b5TTA1A5CGKcViACOFcZf05gW5ltD52qE0zTiO57+zckW4POwLP/LBZ26hNZvNYW9hFed8ljpvj3XolS+8yZaKsi69PJOCG1SCbynxtAzlFGdqjlGFm0kmvN62cThmGl4YCqlE/3PMhUyUSX04H9bYR6rF5vZ4EzLKFA2/iFY4yNHXTIuKeiqN4h+L88EM0Ql1le15k47g+wYa50p3LpBJZz9Yw3IyTHAhHGNBNcnWCRk6soHIswDIT+1uM05HxPKw7YLkFoCqDWWpr8UwsXlV0BECN/2ic4M2M7MXuEzqjtmcBtRnDUdXuzHl1F2jWiwPxJcjLM3dxcR0qAbjHKK2krBdTy7ETaqp5kXzJLzhjjx3XzP5p0szMl8JQNHVdB7s5EvThxW3S78nmA/esBmSPcaAEUwDkAQxfu2KKz1MIOS7qjj68B9nteC2R6ISU1F6VeuS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae0f3d0-5f99-4659-8002-08d7ea537316
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 02:34:02.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJ+6AhNvgn4hbYEIyu2qj9XJupdzizUTuP19Iy+y6TiyQuPVmpEOMxMlUeyIokdeBs7W8QvtK7m+fjy3RhyS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6470
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the commit log,=20

ff23dfa13457 ("IB: Pass only ib_udata in function prototypes") is better th=
an commit 'ff23dfa13457'?


-----Original Message-----
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>=20
Sent: Sunday, April 26, 2020 7:36 AM
To: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; =
Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Sudip Mukherj=
ee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] RDMA/rxe: check for error

The commit 'ff23dfa13457' modified rxe_create_mmap_info() to return error c=
ode and also NULL but missed fixing codes which called rxe_create_mmap_info=
(). Modify rxe_create_mmap_info() to only return errorcode and fix error ch=
ecking after rxe_create_mmap_info() was called.

Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
Cc: stable@vger.kernel.org [5.4+]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mmap.c  | 2 +-  drivers/infiniband/sw/rxe/rx=
e_queue.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/r=
xe/rxe_mmap.c
index 48f48122ddcb..6a413d73b95d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -151,7 +151,7 @@ struct rxe_mmap_info *rxe_create_mmap_info(struct rxe_d=
ev *rxe, u32 size,
=20
 	ip =3D kmalloc(sizeof(*ip), GFP_KERNEL);
 	if (!ip)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
=20
 	size =3D PAGE_ALIGN(size);
=20
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/=
rxe/rxe_queue.c
index ff92704de32f..fef2ab5112de 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -45,8 +45,10 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __us=
er *outbuf,
=20
 	if (outbuf) {
 		ip =3D rxe_create_mmap_info(rxe, buf_size, udata, buf);
-		if (!ip)
+		if (IS_ERR(ip)) {
+			err =3D PTR_ERR(ip);
 			goto err1;
+		}
=20
 		err =3D copy_to_user(outbuf, &ip->info, sizeof(ip->info));
 		if (err)
@@ -64,7 +66,7 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __use=
r *outbuf,
 err2:
 	kfree(ip);
 err1:
-	return -EINVAL;
+	return err;
 }
=20
 inline void rxe_queue_reset(struct rxe_queue *q)
--
2.11.0

