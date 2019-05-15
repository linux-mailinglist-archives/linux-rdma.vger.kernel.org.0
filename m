Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB91F759
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfEOPTy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 11:19:54 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:29308
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfEOPTy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 11:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEx+i4eFGcb428hpHreLaBXdoe61rk+Q/PGJLzyoMdU=;
 b=St2eeQI8sWKpxBeCHy6B7biNkp8ZNi9MjxJvugXIEPhrqhpTv0UF79XRjFyEoTRaCPKcc8uG11SZZqvbZ6qqOYIwo58xyPkxs64A5Csy1bspa2NVC7iIE0j6jYBoAoG+Kro3sHPUil96slvRHmqocTJ+hdrKlFQP6JFYf71KLlI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3151.eurprd05.prod.outlook.com (10.170.237.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 15:19:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 15:19:50 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 4/5] cbuild: Do not use the http proxy for
 tumbleweed
Thread-Topic: [PATCH rdma-core 4/5] cbuild: Do not use the http proxy for
 tumbleweed
Thread-Index: AQHVCq0HUGM85A2DmUOSy8uLcNKHCaZrqh8AgACjx4A=
Date:   Wed, 15 May 2019 15:19:50 +0000
Message-ID: <20190515151945.GK30771@mellanox.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-5-jgg@ziepe.ca>
 <20190515053334.GH5225@mtr-leonro.mtl.com>
In-Reply-To: <20190515053334.GH5225@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bced8ede-db68-49e3-42ca-08d6d948c5f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3151;
x-ms-traffictypediagnostic: VI1PR05MB3151:
x-microsoft-antispam-prvs: <VI1PR05MB315183FB738532C6C41B1EC5CF090@VI1PR05MB3151.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(76176011)(2906002)(66066001)(476003)(7736002)(26005)(256004)(33656002)(73956011)(52116002)(305945005)(66946007)(64756008)(66446008)(66556008)(186003)(6506007)(386003)(25786009)(36756003)(4326008)(14454004)(102836004)(66476007)(4744005)(486006)(508600001)(53936002)(11346002)(446003)(316002)(8676002)(6246003)(99286004)(81166006)(3846002)(71200400001)(71190400001)(81156014)(8936002)(2616005)(6116002)(6512007)(229853002)(68736007)(5660300002)(6486002)(6436002)(6916009)(86362001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3151;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OZnSpuA0iEWWkB8pOSUHaQPtx24vS474pnpd+Ws8z4ifE85wg89rRMvl5LqfjCYtfbZ/OHer4qOghLZJPhyblPOK40R4iiB0OtSWrc6yh9fA7hqNn18umFzvug2VsW8cAUbdVzC/1ZcJw1ptX1lkzYWVii67vmnM8gAZ+FWWZZ3L40zbOtEx2LUS6m9VU0ECP2Iug2qv7j0E3wzrRUrbK1RKIk/kdKgzSlBnJhvT7awtWuqhBVzLnbDaQHwtojarQNMuAUiX7l32OKqYHA4TdMPF/EUxxso3EMz7c9wdt2+YbqEV9F0eDjudSWci/uxFpZILFnSSyToRjm+qcIPRTSWqlKuJHroHcX6jEkK/lxXzTFaW4lHY6RIsUjIvBnONC9ss2Dt+cojv0QUZIH7diebYzcWbaDfdk4lCmaKmCvA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58350A806B68474F8531704E73BD4532@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bced8ede-db68-49e3-42ca-08d6d948c5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 15:19:50.5809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3151
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 08:33:34AM +0300, Leon Romanovsky wrote:
> On Tue, May 14, 2019 at 08:30:27PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > It also does not work with apt-cacher-ng because the server generates
> > redirects for some reason.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  buildlib/cbuild | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/buildlib/cbuild b/buildlib/cbuild
> > index a659a77fc5bb74..e012b08b5fbb76 100755
> > +++ b/buildlib/cbuild
> > @@ -360,6 +360,7 @@ class leap(ZypperEnvironment):
> >      aliases =3D {"leap"};
> >
> >  class tumbleweed(ZypperEnvironment):
> > +    proxy =3D False;
>=20
> It should be set in ZypperEnvironment, because both leap and tumbleweed
> have this line now.

done

Jason
