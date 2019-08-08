Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BF865DD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403833AbfHHPeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 11:34:21 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:31310
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733153AbfHHPeV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 11:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK7wxnOihdj3mQ5hFube8o1qraQyVj7I5n9n8z/6eYAlYgCGllD1beZTu1A4Qb4EHSF+ORKNi+HnniJFic/KQeCr4uBHcGllVwy2n72G3sGdJKN16Wlu1Q7/A1JVGXjr/EXrZttixNNTmOJZzkiYajtK3K8s+N0Xu1N3T0/tRxWW3LMDhvmE+SgclOn+8UnMfBx3sx/AzYixb31psckAxhzVRZAHmUP2iY6W8lt+H4f0xtQkWtnxmbo6+vF4Q2PWxCwDXOH5wUjZ3RkkNA/YzDcMai/N3hVDMELed779gmg1sv0SE4l97+eNNdIHvaFGKKDIy71d9WjoTmq0HvBO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d6JN5Lj0U3xC9q8aWcQHsX98nOlb4636zrbQdPluUI=;
 b=L0xYaUqNC1CecXZyddAaufcP9AX9W2/i9/7m4Yk8jLP8+YvPxwRWqmIlgZWvQaz6E5hXK3zlb392/6Tb0dBw7i5KnYsofRQyegi7YDGvzh9YbVwH4ip3bkRuJINx/AnrSpWieU0ZzIXUiSlb4ZTH07bjYcErnpPDfBBHY36JeJ7GP8Jvr5rRzHwYeUi/nDlQZqXQRylYWFkbUTF2Hvg5v6YD9aV3B+YKND1aVAr8BOYb3F7iYpbitmJb2bzVMeHSLbjIgsfu4P1++dpWwhSo9BAlvkJbUSmHtcMiPZHA9K5Pr+eVpAFaPA22PmsBHEx7NNbct/7MIqRsDo7NV8I2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d6JN5Lj0U3xC9q8aWcQHsX98nOlb4636zrbQdPluUI=;
 b=Nl2E8U2WQHkegc/X3wElTj7ODNeY3AGfaPO3deImRsCaxW9EvMB3BCX3UYX0Wx+zBM3ecO6zbwd6+LVHjD/YwwFmKi/OOdGB7wNnx41COAeTSTFn7A4vz4FWHOzXQIgbMGRCDKpEe3FBzN9UOmpcdZDZ33qeksT6qacPakcFMII=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5582.eurprd05.prod.outlook.com (20.177.203.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 8 Aug 2019 15:34:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.022; Thu, 8 Aug 2019
 15:34:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while accessing
 ev_file pointer
Thread-Topic: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while
 accessing ev_file pointer
Thread-Index: AQHVTcF9MrNNBZGTSEeMMAk1fHMANqbxLW6AgAAz5gCAAACcgA==
Date:   Thu, 8 Aug 2019 15:34:16 +0000
Message-ID: <20190808153411.GE1975@mellanox.com>
References: <20190808081538.28772-1-leon@kernel.org>
 <20190808122615.GC1975@mellanox.com>
 <869b1416-a87b-f361-7722-bf9d231bc262@dev.mellanox.co.il>
In-Reply-To: <869b1416-a87b-f361-7722-bf9d231bc262@dev.mellanox.co.il>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6642bc1a-65eb-41db-a535-08d71c15df84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5582;
x-ms-traffictypediagnostic: VI1PR05MB5582:
x-microsoft-antispam-prvs: <VI1PR05MB558241F7E496FBA6FD2E194BCFD70@VI1PR05MB5582.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(5660300002)(386003)(86362001)(305945005)(7736002)(11346002)(3846002)(6436002)(6116002)(66946007)(76176011)(6506007)(229853002)(478600001)(99286004)(52116002)(66446008)(2616005)(186003)(476003)(8676002)(81166006)(26005)(446003)(486006)(64756008)(66556008)(66476007)(66066001)(8936002)(6486002)(2906002)(81156014)(6512007)(1076003)(256004)(14444005)(14454004)(25786009)(6246003)(102836004)(53936002)(316002)(107886003)(33656002)(71200400001)(4326008)(54906003)(6862004)(71190400001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5582;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NMcoyFDSGSAIAeNV5/rHm2BHJVBeiQ+Q4TW+JZoSJzWVuff8jIQeVE8iY4lbDcStjqw7KACPf2yN1Fa7m+glZNwNMxRoVVGbaqA1Nmr0iPxBV8X9qQs8lUdbKeeLLJL4y5QjbrVa6ao6/ESOjVC0DDDr78hC5LrDMh+SOYBgcjEwvXGRQ12J8eCfWM7UXIYKEdbe51QNFTej9KA5zqg+WH0adkGeGX1aF4t50rFrP6K6ZDAtH2KjJtgb5Fjh82AITpRyS4BazPrR1j0XDh2gKKfJqhLYzptGKsth/fRTJ5WSLTJPX0h0JBrZs2chv/xunjXyA7amBNPGT7LK2gt2GhHGr2sFMjS1Wjo9JYbKuqUt7Pnod3OON1siy4FnbU1b9Q5YRQ2YV/Q2hDVGd5SCCUCCi9HmKSNqToJhXC9EGTs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <478077A494E1C547B240C03B20C56725@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6642bc1a-65eb-41db-a535-08d71c15df84
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 15:34:16.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5582
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 08, 2019 at 06:32:00PM +0300, Yishai Hadas wrote:
> > > diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/h=
w/mlx5/devx.c
> > > index 2d1b3d9609d9..af5bbb35c058 100644
> > > +++ b/drivers/infiniband/hw/mlx5/devx.c
> > > @@ -2644,12 +2644,13 @@ static int devx_async_event_close(struct inod=
e *inode, struct file *filp)
> > >   	struct devx_async_event_file *ev_file =3D filp->private_data;
> >=20
> > This line is wrong, it should be
> >=20
> >    	struct devx_async_event_file *ev_file =3D container_of(struct
> >   	                   devx_async_event_file, filp->private_data, uobj);
>=20
> You suggested the below 2 lines instead of the above one line, correct ? =
as
> struct devx_async_event_file wraps uobj as its first field this is logica=
lly
> equal, agree ?

Yes, it is wrong only in the use of the type system, the private_data
void * should only ever be cast to a ib_uobject.

> struct ib_uobject *uobj =3D filp->private_data;

This could be done with a cast

> > It is also a bit redundant to store the mlx5_ib_dev in the
> > devx_async_event_file as uobj->ucontext->dev is the same pointer.
> > =20
> Post hot unplug uobj->ucontext might not be accessible, isn't it ?
> Current code should be fine for that.

That is the other kind of weird thing, all this destruction could be
done on unplug..

> Are we fine to take this patch ?

Yes

Jason
