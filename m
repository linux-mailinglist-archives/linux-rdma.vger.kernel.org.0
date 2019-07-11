Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5776B65EA7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 19:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfGKRbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 13:31:19 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:13782
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbfGKRbT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 13:31:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SllCRS8ZK/zfEYIaSxVYQKhmIL2sDtckiAGYeaXRnndBueFclIoBbE9bzlk1te8spcwyzPBaEq+y4NdhV1QL+D0cUWBTcmOSj5Y1ZKSNVtvcIunCqZeMXS9EFhXtcc6DZBpDT6bwBN2eUZfxnG3PhWFWir4rUYUbwdWn4DZQ9cnUPxBWM4h7K1BCty8pSncS5hYhicWLoLOWoDbMVCWsskjV8i0tYokg+NkXrasHBRqxWQW81krqqsNkEtD21bSv0bqkha5b6Z3yWtYHz0l/wdGuwVBPBO/eBFXU70wHC/Oe+WMUtzbnG/lnzoHz4PJrKnIyVSEGG3UKMRSNfl9Zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bMoTn7nLiMTGmnPksZ19pAHJFJ/PEGE4oe7/UO8XFU=;
 b=IyoCDWkbITTHo4sT7s3BN9Lg9kJ6Q7rURkfp53SrznFvcnLa/GBPNUvVrR2ncHWMQ8dDp+EqG/sqarX+aImMCa6DA9sn3FdMuvxCz9TDbzhjdHN0svSh+Vzlm2iZcPAiMLbcpm3TYxoYFLpIxlQy8PRg1uialga0ImejUMtjOiRbP1aJA0rq+sRpltKw4ajCIu1tH8CxAwdKY7u/Zou0M26B3Z0zma4Pll7zoCHo4TjZdKRaSoR4BljPeF9J489/uw6gHjzR+2iMqTaiG+AgKQ1zaD59QkbZX4qnzte0ICHurs/PhIW1s4JDNMWcSx7tc70Xz+gvO9rFR7ozvWKYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bMoTn7nLiMTGmnPksZ19pAHJFJ/PEGE4oe7/UO8XFU=;
 b=G7V/JPvTbuTMAW160IXc0cDIJxMwMwgxIF01/RKGGZ1ncEmnyqa1ahlKfYTANTF67OGGcrARnQHV0BbrK5L/eSAJXmeOIdAvPjfcj1l+SAAGCEFuTYE8yiYVEreHTPu+brGcfcYFInYEyVFhIcddLBYTUUwEFauziE7F3ggkpEc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4477.eurprd05.prod.outlook.com (52.133.13.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 11 Jul 2019 17:31:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 17:31:14 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Topic: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Index: AQHVN/21HuAr6Ssdm0+h3g3lp6E1KKbFjsQAgAABKgCAAAaPgIAAExcAgAADTAA=
Date:   Thu, 11 Jul 2019 17:31:14 +0000
Message-ID: <20190711173110.GN25821@mellanox.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
 <20190711154734.GI23598@mtr-leonro.mtl.com>
 <20190711161103.GL25821@mellanox.com>
 <20190711171922.GJ23598@mtr-leonro.mtl.com>
In-Reply-To: <20190711171922.GJ23598@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:208:120::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f606c5b9-5526-43cb-0ab7-08d7062592ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4477;
x-ms-traffictypediagnostic: VI1PR05MB4477:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB44779098E6AB29FCABDEA371CFF30@VI1PR05MB4477.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(6116002)(25786009)(6436002)(3846002)(8936002)(6486002)(966005)(86362001)(478600001)(68736007)(8676002)(102836004)(26005)(386003)(6506007)(14454004)(186003)(33656002)(52116002)(76176011)(11346002)(2616005)(476003)(305945005)(446003)(54906003)(2906002)(7736002)(316002)(53936002)(66446008)(1076003)(256004)(4326008)(229853002)(6246003)(5660300002)(107886003)(64756008)(486006)(6306002)(36756003)(6916009)(99286004)(66946007)(71190400001)(66476007)(66556008)(71200400001)(66066001)(6512007)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4477;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wOZNUgod54rL3zx/9RfVkvgfVsDCbAKCjXegO+bb8ZkMZHXy6gNaQ9BFuCLUhYJ62UZPEi6Ru6RGRKzH7EI0H3pXCvOayhSaSW/pIan3UUN4/RB9yOHzrGqivh8/m0WwANAl27lXpVlDz+ZBXvbG6o+8NwoEnOsVzYSqJrRsNE7UAOrDcCu6bMgIgtXDSJWg7dqvySPIhIRdQyDpcSKpo371mZC3vuOlQex10JeAYAo3txoXjtqmYLIrdCni94NYmR/D8Ui6c5/SFHqdZOSu/86hA9akKxFeImBUDvo9xHsPXIO9yM58NvXEJBa52EibUNKPZVplxPRPB6zMzaTrTc3vp+LzyrRDabXmjKlYIky8eVw2vtXolelxRCIHA5D2C8UBSwVFoUECMT+w+M20BAL8KXNqyfD/89IhxOKlrz4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7546AD13C0BA747B73EFCD5E2697462@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f606c5b9-5526-43cb-0ab7-08d7062592ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 17:31:14.7489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4477
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 08:19:22PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 11, 2019 at 04:11:07PM +0000, Jason Gunthorpe wrote:
> > On Thu, Jul 11, 2019 at 06:47:34PM +0300, Leon Romanovsky wrote:
> > > > > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > > > > index 439d641ec796..38045d6d0538 100644
> > > > > +++ b/lib/dim/dim.c
> > > > > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *start, s=
truct dim_sample *end,
> > > > >  					delta_us);
> > > > >  	curr_stats->cpms =3D DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta=
_us);
> > > > >  	if (curr_stats->epms !=3D 0)
> > > > > -		curr_stats->cpe_ratio =3D
> > > > > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > > > > +		curr_stats->cpe_ratio =3D DIV_ROUND_DOWN_ULL(
> > > > > +			curr_stats->cpms * 100, curr_stats->epms);
> > > >
> > > > This will still potentially overfow the 'int' for cpe_ratio if epms=
 <
> > > > 100 ?
> > >
> > > I assumed that assignment to "unsigned long long" will do the trick.
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h=
#L94
> >
> > That only protects the multiply, the result of DIV_ROUND_DOWN_ULL is
> > casted to int.
>=20
> It is ok, the result is "int" and it will be small, 100 in multiply
> represents percentage.

Percentage would be divide by 100..

Like I said it will overflow if epms < 100 ...

Jason
