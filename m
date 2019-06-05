Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E888360AC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfFEP7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 11:59:34 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:15008
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728516AbfFEP7e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRrXvgyH6a/b1Ts2P6GfYBPcFhnZwxPhGDayWoEyErc=;
 b=Lu2ccFUrF7E+k3Pno//tO5tBJkAza4Mn0n3oE1cI64LTsmYFeixh8lt7lj+kMGfbGxaPCKPgScrSbML8uD0J/j38aNldEKyBWgd1Tdc4qiKWR39WTIh6kpo2uaJpLAfIPYj9FtMNZM2dvVQSjzTxqqvgUn1CBeILsZ0gOYd4VCY=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3282.eurprd05.prod.outlook.com (10.171.187.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 15:59:30 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a%5]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 15:59:30 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
Thread-Topic: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
Thread-Index: AQHVFuswzGhwAyDAKEKIb0r0OsrdFaaLIkIAgAAYgwCAAD2OgIABgEIAgABI4wA=
Date:   Wed, 5 Jun 2019 15:59:30 +0000
Message-ID: <20190605155928.GQ5261@mtr-leonro.mtl.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-4-git-send-email-maxg@mellanox.com>
 <20190604073514.GL15680@lst.de>
 <bcd4fe8a-38df-e302-b12f-4e7a99f9a77b@mellanox.com>
 <20190604124313.GC15534@mellanox.com>
 <ea2d665f-926b-5b80-ff32-9e91c04955ce@mellanox.com>
In-Reply-To: <ea2d665f-926b-5b80-ff32-9e91c04955ce@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To AM4PR05MB3137.eurprd05.prod.outlook.com (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1da7a72c-94ff-4c7d-ee32-08d6e9cecb58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3282;
x-ms-traffictypediagnostic: AM4PR05MB3282:
x-microsoft-antispam-prvs: <AM4PR05MB32821849BEBA18B34B3D28A1B0160@AM4PR05MB3282.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(1076003)(8676002)(71190400001)(53546011)(76176011)(66446008)(71200400001)(53936002)(386003)(102836004)(5660300002)(6436002)(2906002)(25786009)(11346002)(486006)(6636002)(26005)(66946007)(4326008)(54906003)(6506007)(446003)(476003)(99286004)(478600001)(256004)(64756008)(66476007)(52116002)(73956011)(305945005)(186003)(316002)(66066001)(81166006)(107886003)(14454004)(229853002)(86362001)(68736007)(8936002)(9686003)(6486002)(33656002)(66556008)(7736002)(6862004)(3846002)(6116002)(6512007)(81156014)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3282;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: neYzgiM7H2gMj+n/8tY9Ah4Sbss70k1//f+ZS3ZGEeYwQRGLCYAXmopbjV53psNH2drKfrcYLwI5ZMQ9hX6uZSWftC2demgLSVEFvNZzXBvUzeY1QQFjxSSaw4nBsMQ3tV8Oanfgf6MDlNhsq7DDnC0Z+MYG/n6shLxy9XqEebfaB5BzzAbY9E+NYOMSxjBAHMX8OOZoqm41T2XKT/qLCBbPE2g8KGxpXfniroV+53pSgAQ+l4X2HlEeELZhJfckyOOOs/yr2z/vHR2k7e9e8x8HhzFQA/4higlkPit/PSIAb3WX/AJWZaBwD14ufHSGGFRm/LI1TGsJB4g1Qt7xPbSLiBTkXnfwAaXQnzt7LCYrpQpd2P9XsRfBLKoUfFRSlhWXrAGE0OTNldTsPdGBHUymSWAVcRAvliTyz96ZqUI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A94DDCA30CA6384486B5AB7FEF2EB22D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da7a72c-94ff-4c7d-ee32-08d6e9cecb58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 15:59:30.5720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3282
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 02:38:36PM +0300, Max Gurtovoy wrote:
>
> On 6/4/2019 3:43 PM, Jason Gunthorpe wrote:
> > On Tue, Jun 04, 2019 at 12:02:58PM +0300, Max Gurtovoy wrote:
> > > On 6/4/2019 10:35 AM, Christoph Hellwig wrote:
> > > > On Thu, May 30, 2019 at 04:25:14PM +0300, Max Gurtovoy wrote:
> > > > > From: Israel Rukshin <israelr@mellanox.com>
> > > > >
> > > > > This is a preparation for signature verbs API re-design. In the n=
ew
> > > > > design a single MR with IB_MR_TYPE_INTEGRITY type will be used to=
 perform
> > > > > the needed mapping for data integrity operations.
> > > > >
> > > > > Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> > > > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > > > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > > > Looks good, but thinks like this that are very Linux specific reall=
y
> > > > should be EXPORT_SYMBOL_GPL.
> > > Well we used the convention of other exported functions in this .h fi=
le.
> > >
> > > If the maintainers are not against that, we can fix it.
> > >
> > > Jason/Leon/Doug ?
> > Since it is in a .c file that is dual licensed I have a hard time
> > justifying the _GPL prefix.
> >
> > Although I would agree with CH that it does seem to be very Linux
> > specific.
> >
> > Honestly, I've never seen a clear description of when to use one or
> > the other choice.
>
> I'm also not familiar with licensing stuff.
>
> I guess you prefer using the common EXPORT_SYMBOL for verbs.c functions,
> correct ?

Yes, it is much easier for us, instead of trying to pick specific
license for specific function.

Thanks
