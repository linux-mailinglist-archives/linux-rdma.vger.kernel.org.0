Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B004BE8C19
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbfJ2Prq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 11:47:46 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:36932
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390172AbfJ2Prq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 11:47:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnMJWD427VzKgut8jRAA+bS75941Zh50eAET8OF2+xy7LGabW2PZ0TfJq6OlC7y3zs8+Nzy9EwXS6YM+KiR6jG1KDKPnh8wy4n2wdV8wneb486wtelEIDcFH1weCn4Aq8JNXJnHniOTllXYqGQhzsaMHUSIMaxX/3cbbyZEQ6PawTnPjyWYGpj74MRuLmdo+hkbvEcDzgf/fcv0DS0xyD27v64hLEZUeTQLyHSJHgLom4rUIJqJD2iMH6ScqZgIoX3FbqvYTMIOf4cMaGgLq4velCgjC0Pz+JFoftXoLGJLrPg81VD6C2qUsdvp5cqvYhlZKmi2Ysuma7TFfwEG0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37e3MUy+B9k6FdN12PaE206vbpazVv/os/HS3irq2gc=;
 b=EckgL5o8hFBdlVXxCRMaMdXB2hKvZuLZlOhSP7/eUCgvaF4j4XX8I7GtQXqj/FeBAN3HjLWVxFQSPbHRWpIGLIVoA9o4wyBcfDIyg8m545vsKZ7H3fC6bx+Hl+AyYeHRBq3cfgMOubaosL5UsnS65LQAqwvsbuQypymQuNxtP3qzVkeWFdz+uLsjEHGULWZ5ILWUjJ3otdIWrCZC5kMKF76QVXPv1GDn64haNh/bA7xujNG9Oaud+Ae1j/pVM2jGO174cAJ6TwaqI31iFECAAri1Vr/vMqpoj7UI9N+DFKq1M/OEH5yOYqQTZ80x5cckjbSxpTIXkR7vW79uX53l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37e3MUy+B9k6FdN12PaE206vbpazVv/os/HS3irq2gc=;
 b=LZ0SJR/+b6uxlIruofYowgWx4/rv6WTzKS4XP3l6rS/jPPik2aQKRDucC4ukndPqT8vRt2PO1pwETuCDwvsnbqliMdUYzjkqtAj1lrqsNMt1Umje0lylwQiNlT9sJi9jOeuvCtteurR/acVXovFJ2gzI9eqI9s1CrzkzJ2o0a4s=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6563.eurprd05.prod.outlook.com (20.179.32.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 15:47:42 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Tue, 29 Oct 2019
 15:47:42 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: RE: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVjk+CpuXxUn6Q9k2inmzUDW7ozKdxvUOAgAABLrCAAAF0gIAAAtsw
Date:   Tue, 29 Oct 2019 15:47:42 +0000
Message-ID: <AM0PR05MB48668ED6420D4DC6385ADE13D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
 <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029153345.GN22766@mellanox.com>
In-Reply-To: <20191029153345.GN22766@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da0f541e-189b-4c7c-3d96-08d75c875587
x-ms-traffictypediagnostic: AM0PR05MB6563:|AM0PR05MB6563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6563F8748205278D1A3C20C8D1610@AM0PR05MB6563.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(189003)(199004)(13464003)(55016002)(71190400001)(9686003)(71200400001)(3846002)(6116002)(5660300002)(6436002)(8936002)(81166006)(81156014)(8676002)(15650500001)(11346002)(25786009)(76116006)(99286004)(66446008)(66556008)(478600001)(316002)(446003)(2906002)(74316002)(305945005)(7736002)(66476007)(66946007)(229853002)(64756008)(256004)(14444005)(14454004)(186003)(7696005)(33656002)(53546011)(6506007)(86362001)(4326008)(6246003)(107886003)(486006)(52536014)(54906003)(476003)(76176011)(6636002)(26005)(66066001)(6862004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6563;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNHokr07zk7TjUAJ8laoLFN1IlGkRRHVEuNSyCLSaTyhX6u8aFyxyEX9DHvCDu5DnklD/jPYXC9UzKfFY7rGTrf3hzgygXdbcWQ0TvKO3huwdSEoFaE/rnlx/7VV0Hu7MsylU3GxDWVKdPYgEq5rwHYe2UHSvNkvaynj7N5QLSkI8oyNOhdjSkZ+bguw7B1Ppcg7r3SqFRw2pX9EdBYquAWGujfTyLQIIt3PHYioyk6Pd4uQHk5hS7gTVDwSKWeBj4sIg1Eyn6kJPbfvEhSbF/UDn262j8L8B67IAiwn7y1LcJ1JgWVnxyumkKZKwIkyXBpP1M+hdU0J/YcIA3z08UEHZy3V3laTXCm0LFKPSAXSrESjLEowl2ycgP1hH/w7M70Tc9ysL9a80Zg18sQ2tZoUBLXamXGkKShy9HUQXV1A2N6LXu9UZcDGVgMJe78O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0f541e-189b-4c7c-3d96-08d75c875587
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:47:42.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83QjOEgZBOxlGIlkQ4QcL3lPy5Q52uE9LVf1a2D1fIVt/GzQ20JKNon+PVK5VOirQpaRKvhHRmu/yWJVoYh5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6563
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Tuesday, October 29, 2019 10:34 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>; RDMA
> mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> <danielj@mellanox.com>
> Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cac=
he
> update events
>=20
> On Tue, Oct 29, 2019 at 03:32:46PM +0000, Parav Pandit wrote:
>=20
> > > > +/**
> > > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > > + * @event:Event to dispatch
> > > > + *
> > > > + * Low-level drivers must call ib_dispatch_event() to dispatch the
> > > > + * event to all registered event handlers when an asynchronous eve=
nt
> > > > + * occurs.
> > > > + */
> > > > +void ib_dispatch_event(struct ib_event *event) {
> > > > +	ib_enqueue_cache_update_event(event);
> > > > +}
> > > >  EXPORT_SYMBOL(ib_dispatch_event);
> > >
> > > Why not just move this into cache.c?
> > >
> > Same thought same to me when I had to add one liner call.
> > However the issue was device.c has the code for the event
> registration/unregistration and calling the handlers unrelated to cache.
> > So moving ib_dispatch_event() to cache.c looked incorrect to me.
>=20
> Well, maybe we can move the wq code from the cache.c into here?
>=20
I prefer to keep all cache specific code in cache.c because there is where =
we flush the ib_wq, queue work there.

> It looks just as incorrect to have the one line call
>=20
No, its not incorrect. Because device.c provides functionality to register/=
unregister handler and dispatch event.
While cache layer deals with cache updates etc, and uses wq service provide=
d device.c
If we rename ib_dispatch_event() to ib_dispatch_cache_event() it make sense=
 to move to cache.c
However we have non cache specific events there too, so current code split =
between cache.c and device.c looks appropriate.

> Jason
