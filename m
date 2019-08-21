Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6439297DE4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfHUPAC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 11:00:02 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:17666
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729565AbfHUPAA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 11:00:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6O8FzKCHLhpf4i1ybM/KQGfKnXYpa6fxdRlNGEkSiOm5saeueP+4Z+raFZPy0e0hyMgEbqHN+/1ymOQfwFW70w2ltDSMpHMQkeVRsbVNgdmqu0WXuDjfrMU6SmBLI4QrXtIZmM2Vu0kCgZi2Dml0NZlHtc6Fn/30gVIGWZJhqY4G+nn5P3PXspNUZneLVMRnsI6BS6m1APH6VVcoJne2cxEO8kEo4mPFxQCG8/zApixmETpzNgPGKp0lHBULtOxTlnf74NAS4SWWUlsw7k0YUNi7qHRxTWNrRUpose8YKcootUodzBat4f/tY4D6sTeQ3H5tW3ZI1cdDMLJ6f2GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHGJk77k6O/NBbpSpm1VhenfWRy01nUy8ujUoxjMqlQ=;
 b=WIzuaTuSFo7y9/SiaTwXL+DiPTr0Dnn04ciZdT6q4gdclf0rq76/qY1MFEYIf9lzBVsk/5sbFOv5/evgzXfD0GzaHTknvwn+pA16eq1a0wkSCZxnPZBqrgfDiydIl4GxoHLN+El3scmj+qfcBkqCoyXoaxz7h3unTS2OOu9xBgEtgzJ0GgtiO5k+XxfA0WZCkbIC3dGwDzrdE19N+5tgjBk7zgxrD+KN+HsSHxEeLsIw39J314YmX747gPUINLcEY5GqhmxwyM3vuJbGeuKEHukTPwWs/UVQXnyGM4p7hrn2IDe3GR24bn3VXpn6Sw6Srg3WKtCxy9lbmF8rwbrA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHGJk77k6O/NBbpSpm1VhenfWRy01nUy8ujUoxjMqlQ=;
 b=UVfbc+M325oruIT1P3HQcOSDNF3ApqjB4vrFlivcDnwXjvBBmrLV6Mmb8JuVHRKcTZKza12PHy9jhEau28BODTtIGfBtDxx5C5Y/tsdrfawKD19fBIF892b3gGmYFMSScOCIpdp289sZwERkm2Q4Kr1qfvmvaxVMiNtDf7Fl8z0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6254.eurprd05.prod.outlook.com (20.178.205.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 14:59:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 14:59:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 10/24] IB/mlx4: Add implementation of clone_pd callback
Thread-Topic: [PATCH v1 10/24] IB/mlx4: Add implementation of clone_pd
 callback
Thread-Index: AQHVWC449WSIDZNrJ0CtOZ7OyK69RqcFscwA
Date:   Wed, 21 Aug 2019 14:59:54 +0000
Message-ID: <20190821145950.GE8667@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-11-yuval.shaia@oracle.com>
In-Reply-To: <20190821142125.5706-11-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 436e12f5-de65-4ad4-3b39-08d726483973
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6254;
x-ms-traffictypediagnostic: VI1PR05MB6254:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB62544EC5BBBD77DA9275FCE8CFAA0@VI1PR05MB6254.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(33656002)(2906002)(316002)(7416002)(52116002)(5660300002)(8936002)(66446008)(64756008)(6436002)(66556008)(66476007)(6916009)(486006)(66946007)(6512007)(6246003)(8676002)(4326008)(81156014)(81166006)(66066001)(25786009)(36756003)(53936002)(305945005)(4744005)(7736002)(99286004)(54906003)(1076003)(102836004)(256004)(14444005)(446003)(386003)(6506007)(2616005)(478600001)(86362001)(76176011)(6486002)(26005)(186003)(3846002)(6116002)(14454004)(11346002)(229853002)(71200400001)(71190400001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6254;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gudKOobOl03kg3y05aYXQUzd9Ujy5Qtiq7zzyrehfuoa5OwkPvO8of116IT51BBwVyqssvNRAIIhZ+6FIp5ug1SXxeXuo6COOpjlczrnbvz9bo79gBZtsqBrX3yJ16ehccYnOo0zM4u6UDP2DhRbC/0ACpRbBAErPqiqbEhQLVc+fHye8GK+iBX+zPQzpHHQE7ZFYsw9jUts39jCq1Ew+uhis3mMNFgxLpD35GO2kg9g24owSdI3gZyYeF7Vu9mmbBEZVQ00S8Q4aB6Cvu2UR/HvYT1HAfPDJUkiu9/Z3BqNAv4snV1wsfpF0UZP8yox4eI3JqX+KLRbKUGdAVp8idfm0EnfGk2xMYawuIyYJpx1OkrnN1jRio+QcmC9iKZDSwFtgDpvDPFk6b200pKKJ1mrq//+eA2kDra17pqgKIg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85075A4197FC2A4AB261B3F90052CBAB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436e12f5-de65-4ad4-3b39-08d726483973
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:59:54.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0ADmW/XjBRdi21hK8Ba5xHkrrwo/5ZbvfccgfrzJwvONwE3yq9HlhocxpoutL7jLrtn7UrmH7DwU0zElv1Lxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6254
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:11PM +0300, Yuval Shaia wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>=20
> Copy mlx4 ib_pd to user-space.
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
>  drivers/infiniband/hw/mlx4/main.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/ml=
x4/main.c
> index 8d2f1e38b891..6baf52d988ed 100644
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -1179,6 +1179,13 @@ static int mlx4_ib_mmap(struct ib_ucontext *contex=
t, struct vm_area_struct *vma)
>  	}
>  }
> =20
> +static int mlx4_ib_clone_pd(struct ib_udata *udata, struct ib_pd *ibpd)
> +{
> +	struct mlx4_ib_pd *pd =3D to_mpd(ibpd);
> +
> +	return udata ? ib_copy_to_udata(udata, &pd->pdn, sizeof(__u32)) : 0;
> +}

And here it is, clone is just query.

Jason
