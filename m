Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69AF6723F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfGLPXZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:23:25 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:60930
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbfGLPXY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 11:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLltCWYYGQtfWKl6h9QcBtlD6d9x3nBDsLttWe7xTzkmNs0NLLZf3opL9Y/ct+96UrWzctMzSgYZiv9BPdm/GUXpvmJcCcMS++hPLAJY8HH/hcaVokCIdmaGyohtPMcFEMZEVW0KxyezzPygJOuULWLzqAgSOLern0LbUzFqj7zNVDj4+vd3oPbulTAqCBnv4vPpsnNw/gU4uapF11XmSWBRXCbEJOBo+jQAlpssFWPf6hSJKt4JfjG2+aAq3wW1AQEIFgVgIQyRgNqWehHrJEM1KoIu+aFxM5Z/EyYISlSUcb5gttqGdIXF2w/7OsB05Py9f+pm6P/BVYBQwYiR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRQ112rAsKtZ8ShGAtfZBiZbWd2bSfBoK3JUdJzZaxE=;
 b=Mjocx6MiZ6byV2lnnxJ2O6lbuylMQNsSjMsKJ2IOgaljHLrEyHnfgrx6zlx6lkvy/2XeWTXgNBgXS5e4c/M+/0LAGmLOUffGZW9nnhT/f3476prBbNCZScLza+f4OyH/JejJrEDmNd9No3/ogM79PQsU9MB3p2M9taKcXT7bez+ZAgs2P4p/1V7mMWv+ns/sEWqtB2KQbjV4L6uDXlHpFDc4EnTy9mZrKGVjeVA/Z3BsUOQ19j1hcWFLeuFFv6NNaypsb1epsv/XfW7wjjYU515uEWE6y/eQTWhxgjj7whlHfDCmkakkFBAufn2iok72PB6Uqv3hlb7a+iAfQoN1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRQ112rAsKtZ8ShGAtfZBiZbWd2bSfBoK3JUdJzZaxE=;
 b=KPwechcjtfPndItljjzeg9UYGNYQBBjVNw68zkGbUqGz2MtKge/8/zki6DcRl/Cj27rgk33BGNz2Xvd2XlzlXYOxW8CeoMJaj9dYXF2JzJXt3xJIDXctSqRPUbgiGmRyE8/ZB7FxWHQh7C9PSy4ZbhD8+8qGqsR2pLKTJNfwOv0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6478.eurprd05.prod.outlook.com (20.179.26.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.13; Fri, 12 Jul 2019 15:23:20 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 15:23:20 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Topic: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Index: AQHVN/21HuAr6Ssdm0+h3g3lp6E1KKbFjsQAgAABKgCAAAaPgIAAExcAgAADTACAANIagIAAnH2A
Date:   Fri, 12 Jul 2019 15:23:20 +0000
Message-ID: <20190712152315.GD27526@mellanox.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
 <20190711154734.GI23598@mtr-leonro.mtl.com>
 <20190711161103.GL25821@mellanox.com>
 <20190711171922.GJ23598@mtr-leonro.mtl.com>
 <20190711173110.GN25821@mellanox.com>
 <20190712060309.GM23598@mtr-leonro.mtl.com>
In-Reply-To: <20190712060309.GM23598@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4601c375-73ce-44e2-3eed-08d706dcdf3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6478;
x-ms-traffictypediagnostic: VI1PR05MB6478:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB6478102D9A6093D9028A1097CFF20@VI1PR05MB6478.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(6486002)(99286004)(86362001)(386003)(33656002)(36756003)(1076003)(8676002)(25786009)(6506007)(26005)(6116002)(52116002)(3846002)(7736002)(186003)(107886003)(305945005)(476003)(6512007)(6306002)(966005)(446003)(11346002)(102836004)(478600001)(6246003)(6916009)(2906002)(53936002)(2616005)(229853002)(71200400001)(71190400001)(6436002)(76176011)(4326008)(54906003)(256004)(486006)(316002)(66476007)(66946007)(66556008)(64756008)(66446008)(5660300002)(14454004)(81156014)(81166006)(8936002)(68736007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6478;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rLB2k56IPm07s4/d/KOtcE9YDT0Rxc6+OP671c3uLB/3EwNQzr2AWiQyS3ZCSHI+Jryj2q2RVRAmHAi39TJtE3WveH+Qtv4NoDQXbdVS4cvpFCQqPtPeF/7dfc409+Wsgk1AHvYfiEqNAeroajccBV+FO7jWGEQO5ZNn6Eug9x8TuCxbeHhqxZkMfSG8Kx8dNtxjGJWHgDjK1IFaQ8177KTjsPqb6T3squq+jXaQVOpd6Sfey0modF+YHnstPiXnD2J0FqRA5H+ZRXKe0TJDfWWehqReqvy7IfKTH8bPoma9vMfHxR3bNFM/dGM77k0Czzi2RIYCHGB3sXx50NSt6cGG594VCvyD/2y/EXH7b4QRYZ8ENnvm6IXK5lPOE//jgO3o5uMzVwyvutAjy1gk5Min7bm+u+PcLsw6Vu3YahE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADE7FDA5FE8D4946884AF6FE3B256107@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601c375-73ce-44e2-3eed-08d706dcdf3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 15:23:20.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6478
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 09:03:09AM +0300, Leon Romanovsky wrote:
> On Thu, Jul 11, 2019 at 05:31:14PM +0000, Jason Gunthorpe wrote:
> > On Thu, Jul 11, 2019 at 08:19:22PM +0300, Leon Romanovsky wrote:
> > > On Thu, Jul 11, 2019 at 04:11:07PM +0000, Jason Gunthorpe wrote:
> > > > On Thu, Jul 11, 2019 at 06:47:34PM +0300, Leon Romanovsky wrote:
> > > > > > > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > > > > > > index 439d641ec796..38045d6d0538 100644
> > > > > > > +++ b/lib/dim/dim.c
> > > > > > > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *star=
t, struct dim_sample *end,
> > > > > > >  					delta_us);
> > > > > > >  	curr_stats->cpms =3D DIV_ROUND_UP(ncomps * USEC_PER_MSEC, d=
elta_us);
> > > > > > >  	if (curr_stats->epms !=3D 0)
> > > > > > > -		curr_stats->cpe_ratio =3D
> > > > > > > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > > > > > > +		curr_stats->cpe_ratio =3D DIV_ROUND_DOWN_ULL(
> > > > > > > +			curr_stats->cpms * 100, curr_stats->epms);
> > > > > >
> > > > > > This will still potentially overfow the 'int' for cpe_ratio if =
epms <
> > > > > > 100 ?
> > > > >
> > > > > I assumed that assignment to "unsigned long long" will do the tri=
ck.
> > > > > https://elixir.bootlin.com/linux/latest/source/include/linux/kern=
el.h#L94
> > > >
> > > > That only protects the multiply, the result of DIV_ROUND_DOWN_ULL i=
s
> > > > casted to int.
> > >
> > > It is ok, the result is "int" and it will be small, 100 in multiply
> > > represents percentage.
> >
> > Percentage would be divide by 100..
> >
> > Like I said it will overflow if epms < 100 ...
>=20
> It is unlikely to happen because cpe_ratio is between 0 to 100 and cpms
> * 100 is not large at all.
>=20
> UBSAN error is "theoretical" overflow.

? UBSAN is not theoretical, it only triggers if something actually
happens. So in this case cpms*100 was very large and overflowed.=20

Maybe it shouldn't be and that is the actual bug, but if we overflowed
with cpms*100, then epms must be > 100 or we still overflow the
divide.

Jason
