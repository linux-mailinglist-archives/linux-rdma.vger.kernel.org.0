Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F346D2E4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRRjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 13:39:51 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:28035
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbfGRRju (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jul 2019 13:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWKzScQ8HkyXrfw5Rik8HfVbpOGW7KRyZsDsyEdph7dsO+SKFdjVNtthjetHjEkgItDsUcFjut5RQ1ZD+75Fk7NyI0JD9SsMEMKNHmHP2WaxFVuqCfp1mZd8mkmXmYFUGM+rtiyKY+nyBaTpcaV/gJRYI1yMVdy7NX0vtyIBhv+BDmnI3g/2KW/y4J4ytfIeFn7xlte0fZGFKAHeQd0InhSFDLi6ngRQnCfGoGkY6XFtAw9hnypwzrx9sMVRD1zUmtE3Q/Rfqt7g2w3FNpUqakojubUgskuUYFutK24Igz1Nk2HdFWqObvx1+gROFZg17ruZnEc80OG91nml4e3NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieYl9Flm43mgx2lT7u4zfBZrL1Ef+HjBlXKI+AzFvZU=;
 b=EGVm7eCEDjN0ynFxLAWfrxjnoI0MI+FZTKyx+8KU8z8SVGu9oYaJqZkCZHM2vfEf8gyaNrRiO5LkWGP10ghmsdxwRW4Qn5XwZgGuo+1nuS3AhQBifscB5MH8RofJ+xe8ob7SIkxsVUPnUg66+3Dwg/LcCwqhLDYrYZo6ktb2t9TRAjJNBVUktxAaYjNuNAaA1rOfdKXo37lKdY4ixs1kKXXjvetFvkiAG/cDjoKqFiEejo1kyUWMKVgWdYs6OEr3SKdGh86gfwD6DboF6FYy51eQMMt2KmG5IIFGHpn8PjhnUFozdJ/sd3dJsjBvf1+hOTNHvtV96rKpGOu+v/gpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieYl9Flm43mgx2lT7u4zfBZrL1Ef+HjBlXKI+AzFvZU=;
 b=hGqTgG5JLSSRKwdbYCb/Tm9UgnP4Ol6IS9KK1w/0sV9G2kbh/4PjZF+lLzI35gZFTTJaKxVF4mX8z/QZVckfaCe0ClsUp9UqYXILP8ooH+mr/m7FbsNoXjkUeEIHUDgHkXAgxAfi/uxbxik7SynQneeks1xeaZnAn/iyslezA4w=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4768.eurprd05.prod.outlook.com (20.176.4.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 17:39:47 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 17:39:47 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Topic: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Index: AQHVN/21HuAr6Ssdm0+h3g3lp6E1KKbFjsQAgAABKgCAAAaPgIAAExcAgAADTACAANIagIAAnH2AgALZtoCABrpogA==
Date:   Thu, 18 Jul 2019 17:39:47 +0000
Message-ID: <20190718173943.GG1647@mellanox.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
 <20190711154734.GI23598@mtr-leonro.mtl.com>
 <20190711161103.GL25821@mellanox.com>
 <20190711171922.GJ23598@mtr-leonro.mtl.com>
 <20190711173110.GN25821@mellanox.com>
 <20190712060309.GM23598@mtr-leonro.mtl.com>
 <20190712152315.GD27526@mellanox.com>
 <20190714105459.GA6039@mtr-leonro.mtl.com>
In-Reply-To: <20190714105459.GA6039@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:208:fc::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3537c9bd-74ad-4014-3760-08d70ba6ed69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4768;
x-ms-traffictypediagnostic: VI1PR05MB4768:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB4768E6C27FC477C91893C2E4CFC80@VI1PR05MB4768.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(51444003)(305945005)(7736002)(229853002)(71200400001)(71190400001)(6506007)(386003)(99286004)(8936002)(486006)(102836004)(966005)(6486002)(52116002)(11346002)(1076003)(5660300002)(446003)(476003)(6512007)(4326008)(81166006)(26005)(6306002)(81156014)(36756003)(66446008)(64756008)(66556008)(66476007)(86362001)(66946007)(53936002)(25786009)(6246003)(68736007)(2616005)(316002)(76176011)(8676002)(256004)(2906002)(6916009)(66066001)(14454004)(6436002)(478600001)(33656002)(54906003)(107886003)(186003)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4768;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OVVZebR7hEkQ2vge2iGWZAibWo1Z4GXJ3F3ykp3YJy4ibTSxb83K3tg8XLM7gMXgi4IvkeZn2oxX7n8EhAtd2538qAWECBBK6QSxxGq8fSUL2aRhcIYG5E2Z+Nu5Ah9Ls21C3ZaqNLo/j1wi/VTYXcNl/ng+is73SMf00Pc66htHnhqgbCeTRrg0J5kcQdlf3VS7L5oHPssQG9GaZGAl+dJckM5eQ33O8ClwtwpPAmxpnFHe5CSu3mWPLyWOib/S/uEowFd/6I5t2BROOZPkgmts4F3+vD79GqT1myaA5s1dU6NFVUImJtPZom7iyTpnIjMcD5PHQyuXqb7KLWowpvfODIO41v2U86DGDy9f6QTxMWeEBphv6pxffoZkY5p3wQyJdbjvN1NuN+EWK3Fj3xjiS9LCN8I2+/P3pjmt7Jk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A6C74B08F800C48ABF22713F744BAA4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3537c9bd-74ad-4014-3760-08d70ba6ed69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:39:47.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4768
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 14, 2019 at 01:54:59PM +0300, Leon Romanovsky wrote:
> On Fri, Jul 12, 2019 at 03:23:20PM +0000, Jason Gunthorpe wrote:
> > On Fri, Jul 12, 2019 at 09:03:09AM +0300, Leon Romanovsky wrote:
> > > On Thu, Jul 11, 2019 at 05:31:14PM +0000, Jason Gunthorpe wrote:
> > > > On Thu, Jul 11, 2019 at 08:19:22PM +0300, Leon Romanovsky wrote:
> > > > > On Thu, Jul 11, 2019 at 04:11:07PM +0000, Jason Gunthorpe wrote:
> > > > > > On Thu, Jul 11, 2019 at 06:47:34PM +0300, Leon Romanovsky wrote=
:
> > > > > > > > > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > > > > > > > > index 439d641ec796..38045d6d0538 100644
> > > > > > > > > +++ b/lib/dim/dim.c
> > > > > > > > > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *=
start, struct dim_sample *end,
> > > > > > > > >  					delta_us);
> > > > > > > > >  	curr_stats->cpms =3D DIV_ROUND_UP(ncomps * USEC_PER_MSE=
C, delta_us);
> > > > > > > > >  	if (curr_stats->epms !=3D 0)
> > > > > > > > > -		curr_stats->cpe_ratio =3D
> > > > > > > > > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > > > > > > > > +		curr_stats->cpe_ratio =3D DIV_ROUND_DOWN_ULL(
> > > > > > > > > +			curr_stats->cpms * 100, curr_stats->epms);
> > > > > > > >
> > > > > > > > This will still potentially overfow the 'int' for cpe_ratio=
 if epms <
> > > > > > > > 100 ?
> > > > > > >
> > > > > > > I assumed that assignment to "unsigned long long" will do the=
 trick.
> > > > > > > https://elixir.bootlin.com/linux/latest/source/include/linux/=
kernel.h#L94
> > > > > >
> > > > > > That only protects the multiply, the result of DIV_ROUND_DOWN_U=
LL is
> > > > > > casted to int.
> > > > >
> > > > > It is ok, the result is "int" and it will be small, 100 in multip=
ly
> > > > > represents percentage.
> > > >
> > > > Percentage would be divide by 100..
> > > >
> > > > Like I said it will overflow if epms < 100 ...
> > >
> > > It is unlikely to happen because cpe_ratio is between 0 to 100 and cp=
ms
> > > * 100 is not large at all.
> > >
> > > UBSAN error is "theoretical" overflow.
> >
> > ? UBSAN is not theoretical, it only triggers if something actually
> > happens. So in this case cpms*100 was very large and overflowed.
> >
> > Maybe it shouldn't be and that is the actual bug, but if we overflowed
> > with cpms*100, then epms must be > 100 or we still overflow the
> > divide.
>=20
> I think that the real bug is cpms became too big.

So I'll drop the patch until someone figures out what is happening

Jason
