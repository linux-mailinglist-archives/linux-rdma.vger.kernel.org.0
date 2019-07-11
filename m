Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026C765B3C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGKQLM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 12:11:12 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:18707
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbfGKQLL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 12:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atxF5SG7D7iNOTo+PPe7usVAldjDwatmWzO42kp4+jA=;
 b=OWv+rO7+jBHq8gZVZg5T4yi+J/94SbQ62nAHRXDAamI5NTRdgibBOn+0iPMdLJPxY8Mw4ba8zMwOoraapGdt9ANVW8ZLbNZROiNunGOMtI/fZBD2z3U5E1a8FQ4uycPRWSmrub8t/y5apR4WWODCJHytb/z/L+1TxdDiMAUzMrA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4575.eurprd05.prod.outlook.com (20.176.3.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 16:11:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 16:11:07 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Topic: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Index: AQHVN/21HuAr6Ssdm0+h3g3lp6E1KKbFjsQAgAABKgCAAAaPgA==
Date:   Thu, 11 Jul 2019 16:11:07 +0000
Message-ID: <20190711161103.GL25821@mellanox.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
 <20190711154734.GI23598@mtr-leonro.mtl.com>
In-Reply-To: <20190711154734.GI23598@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46701464-ab58-4d14-0b1a-08d7061a61dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4575;
x-ms-traffictypediagnostic: VI1PR05MB4575:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB4575B5DB25FE904E49E56983CFF30@VI1PR05MB4575.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(199004)(189003)(305945005)(36756003)(6916009)(14454004)(6486002)(186003)(4744005)(7736002)(81156014)(26005)(52116002)(81166006)(5660300002)(86362001)(102836004)(76176011)(8676002)(71190400001)(71200400001)(1076003)(66946007)(66556008)(64756008)(66476007)(6506007)(386003)(66446008)(256004)(6246003)(2906002)(54906003)(11346002)(107886003)(476003)(25786009)(99286004)(66066001)(3846002)(2616005)(486006)(53936002)(8936002)(446003)(6306002)(6512007)(4326008)(6436002)(966005)(478600001)(316002)(229853002)(68736007)(33656002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4575;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C6bDSTw9Ny/zSjYEVCFvwqnLkCRmXkW+FmDphC/aH/XudiNh5RmMnVb24BCDZFwLvFCx+vnraStkfaanA0VknFWxzR3yjYGuDj4lwNFHbYD5Dy7pyd8PU/yDmrsMHLc9vzmkA1UrteS6lSsKuTGYoQGzCGi9BkFCovBwMTwqJN6gICSuxhWOCOXcLZaXvU8QHyx4yyMu7X6a3/qJpA7fmIWBCMrVASEE59B9H4IW/8pFvLqD3Ddau11VwZoOQTAbkg7YWEAC3X51oKcsz1nkiY5F0t/kQn0qBrCWU6OWjXxB/jTsM1RIbXWt9vTLQIbkGKZisJ2JRD+be1GWwOBV9gj81da7mJ7tEQNtqPK0f6WETR+W6ndGL8Woy9/K/IDPopS8tuzQXcE4yzdzknp5f98uBIiczGdSnA9t0Oo+2wU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE309A2B082DDC43BBEDA9453940A078@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46701464-ab58-4d14-0b1a-08d7061a61dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 16:11:07.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4575
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 06:47:34PM +0300, Leon Romanovsky wrote:
> > > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > > index 439d641ec796..38045d6d0538 100644
> > > +++ b/lib/dim/dim.c
> > > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *start, struc=
t dim_sample *end,
> > >  					delta_us);
> > >  	curr_stats->cpms =3D DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us)=
;
> > >  	if (curr_stats->epms !=3D 0)
> > > -		curr_stats->cpe_ratio =3D
> > > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > > +		curr_stats->cpe_ratio =3D DIV_ROUND_DOWN_ULL(
> > > +			curr_stats->cpms * 100, curr_stats->epms);
> >
> > This will still potentially overfow the 'int' for cpe_ratio if epms <
> > 100 ?
>=20
> I assumed that assignment to "unsigned long long" will do the trick.
> https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L94

That only protects the multiply, the result of DIV_ROUND_DOWN_ULL is
casted to int.

Jason
