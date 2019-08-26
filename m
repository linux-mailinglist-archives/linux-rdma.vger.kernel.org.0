Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1F9D48B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfHZQ4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 12:56:38 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:55349
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731288AbfHZQ4i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 12:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/lpey5tBiPDNUFfpPe3KPYNKLgVeGyuF/DmIiFVoCKJDNwj2sKsonG5viF/CffMi3lgTLBQvz4yv0bP7Cmv68/egv/yo8ZdYmukhmFxBXx+cYH8j+l8RIpRLGSJVv/rZmveXkkPYeIITuynALwwv5kByRFZfaNW6AFjNX+5zPgq7WiNer6LS2/aT6rPeL+2y8iMqv/PFsz4jChaeCvjygOS05xcm6l95VErg/SsDAOzpdl2lvOKL7zO3S0FPZjOdn8B7cczc9qHKrco74xqCXTLJktX+A/0vzEUCcGcyh8IIMOZuD2Jri516x3RMy6pv6t1/IykIEHWtsuJkENdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU/HFtp5k9JjbNivC6ihG6aA+XPBOoVv0lwGrVvfJ5o=;
 b=HOMivJgTR/j9PHECOq7mP03Z4YT+AY4HGuocn8IJ9T2NWVv+6VD1kORxdBn9yCou4sfTQjw/tdu/DIevVIRxGnHLfyuE8IlF0Xi5RSI6pT+k1W+VtG9i39ZFha/tEGrlptjwWrFqoq9kKo/FdZGCX2VSPEAOn9pMHAESDIE1VrVSywGmO5ur5lVOmuAN0qHDhJoWGW10AghNSpa/VhgEnwsO9WIfhBereBcfc2IG7KA91KlkyckkX74r/PwrO5SHIf4AuLP2aROSTsucy/ot1OTy2vAjdcSlicL51inpp/X1jvpAAxVuPf7TMYY4pxp8bNEw7gneVwEcnHEwskClhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU/HFtp5k9JjbNivC6ihG6aA+XPBOoVv0lwGrVvfJ5o=;
 b=Bm8jqA872UqM5bMj7PvMUeh2xMnBGwtADt+v3Z10ullWhowih9OzOVwvhjWmjawNHX09U6X6LsT0GRFoqOkkB9yFEKiPVM+tJkHitHDYeIguwH8F01yOka7BuMjjyLTg10vckHwhUPib5/1HEK5gfSyzOK84OqiZPLn0ncSc6oE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5773.eurprd05.prod.outlook.com (20.178.122.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 16:55:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 16:55:45 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "Guy Levi(SW)" <guyle@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 08/12] RDMA/odp: Check for overflow when
 computing the umem_odp end
Thread-Topic: [PATCH rdma-next 08/12] RDMA/odp: Check for overflow when
 computing the umem_odp end
Thread-Index: AQHVVn+5ZX4D+uV/0E+o9x2qjh54W6cNrXiAgAADtYA=
Date:   Mon, 26 Aug 2019 16:55:45 +0000
Message-ID: <20190826165539.GF27031@mellanox.com>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-9-leon@kernel.org>
 <20190826164223.GA122752@archlinux-threadripper>
In-Reply-To: <20190826164223.GA122752@archlinux-threadripper>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93fb1b25-dec4-4488-0a65-08d72a463cf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5773;
x-ms-traffictypediagnostic: VI1PR05MB5773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5773A03429BAB439A2FA0CBFCFA10@VI1PR05MB5773.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(316002)(6916009)(11346002)(6246003)(76176011)(2616005)(107886003)(6436002)(25786009)(6506007)(4326008)(5660300002)(446003)(1411001)(36756003)(52116002)(486006)(33656002)(99286004)(6486002)(71190400001)(86362001)(53936002)(1076003)(2906002)(6512007)(476003)(256004)(14444005)(66066001)(66946007)(229853002)(8676002)(81156014)(81166006)(54906003)(26005)(66446008)(64756008)(66556008)(66476007)(71200400001)(3846002)(7736002)(305945005)(6116002)(14454004)(8936002)(102836004)(478600001)(186003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5773;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KfgwgYfaBpxgE2ndnV529B+JMAZq6Q37ilZH0/cezUEeUsYiWB3/8b00IZ4QoZDm5gSBeTKPODqhN9sjuHALLlIWvMGxIppmIMU2mxn49SC0h2olkV9v3W1eqJJVfBB3eGO3A62SFAQYV6Qe/tfrFN9QGk7M7sERHFdTtsiI38S3Qcsn+ydpq6VJqL0YTMblfdd1pNlLB1eA+g4zCpa9NJY30/EzPaTf8N/J2gPW1mlXVax8PvXXju68Aqo9ss9y6zz0bIwcrfjr+3LKIoXMbP6e2RBckdDYw04UVnnrFr6ZiOTFo/8sP/7bIfhGXnvYaoRtzkL9MZ8iShH601kcidR4jXmxK/8Hy18sopCf/sXi3odWpWqxZhI4tN0zw9c8ar1CK5EedsHWgkj+5uz9VII/HBAu+5S1k+xCzWutkXk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <895A6B0C314C594EB153FBCE57826560@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fb1b25-dec4-4488-0a65-08d72a463cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 16:55:45.6970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSrw0MfuE333Y620L0RMKfMGCywJt7j+fBRnS4pAkmgXJsa0FXx79Lz0qOuLC0TQsjaXvABMQ66kvlq5KF/qUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5773
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 09:42:23AM -0700, Nathan Chancellor wrote:
> On Mon, Aug 19, 2019 at 02:17:06PM +0300, Leon Romanovsky wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > Since the page size can be extended in the ODP case by IB_ACCESS_HUGETL=
B
> > the existing overflow checks done by ib_umem_get() are not
> > sufficient. Check for overflow again.
> >=20
> > Further, remove the unchecked math from the inlines and just use the
> > precomputed value stored in the interval_tree_node.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/umem_odp.c | 25 +++++++++++++++++++------
> >  include/rdma/ib_umem_odp.h         |  5 ++---
> >  2 files changed, 21 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/co=
re/umem_odp.c
> > index 2575dd783196..46ae9962fae3 100644
> > +++ b/drivers/infiniband/core/umem_odp.c
> > @@ -294,19 +294,32 @@ static inline int ib_init_umem_odp(struct ib_umem=
_odp *umem_odp,
> > =20
> >  	umem_odp->umem.is_odp =3D 1;
> >  	if (!umem_odp->is_implicit_odp) {
> > -		size_t pages =3D ib_umem_odp_num_pages(umem_odp);
> > -
> > +		size_t page_size =3D 1UL << umem_odp->page_shift;
> > +		size_t pages;
> > +
> > +		umem_odp->interval_tree.start =3D
> > +			ALIGN_DOWN(umem_odp->umem.address, page_size);
> > +		if (check_add_overflow(umem_odp->umem.address,
> > +				       umem_odp->umem.length,
> > +				       &umem_odp->interval_tree.last))
> > +			return -EOVERFLOW;
>=20
> This if statement causes a warning on 32-bit ARM:
>=20
> drivers/infiniband/core/umem_odp.c:295:7: warning: comparison of distinct
> pointer types ('typeof (umem_odp->umem.address) *' (aka 'unsigned long *'=
)
> and 'typeof (umem_odp->umem.length) *' (aka 'unsigned int *'))
> [-Wcompare-distinct-pointer-types]
>                 if (check_add_overflow(umem_odp->umem.address,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/overflow.h:59:15: note: expanded from macro 'check_add_over=
flow'
>         (void) (&__a =3D=3D &__b);                  \
>                 ~~~~ ^  ~~~~
> 1 warning generated.

Hum, I'm pretty sure 0-day has stopped running 32 bit builds or
something :\

Jason
