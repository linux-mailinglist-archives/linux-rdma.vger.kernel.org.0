Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2792BE8BD7
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbfJ2Pcv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 11:32:51 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:27555
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389319AbfJ2Pcu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 11:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arb6bTuuMft8KcoEFJr5JIcscmiKONUvFwoR0C1DJJmpqT6VylUTCjzqixf1kwRavTWJO1xVitlK7M4kss9+4xlL9tnx3nnK20IaYqUAou1M0LjsL9FefkSDsRycgA0BRH5zCCCWZdsgAGjzeDCJomidArOgJoAaQsxmzYVHMSWXQvaoTU/ThBTLP0NCmxS/hNfk7pOywCFJmWlML6D6gq+ud5pJjojbXM4g7lIO9aKqdqwnofsxD/fp7RSJt9KGI7fqeicIU51qywYh/5dRiQdTz7Jczv2WCZxFmOmlGW3jVxZV5MqWFsMrx8gu+ppj6see5/OgOdrTdMl363xAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kljvRtwqYDxtw0boOZzOJz5lLvOFtw/DNTyt3LWrSUw=;
 b=od4WHd+wn/S5MwRh2+N+8z3p2i5eznRg7p6e3np35QvBBtd05GhCbKnYfhn7yMsfzlnEOjEdawzu8up5ivcvFKkE0tuaQ5tJIV7CnMltk5ELf8flc5uIehDgLcdAaAio2XKxhwTIRQ1anxO+iAPfvs1BtKTcrN+btpQoZKUcrpg34384aFkttk8wFz8Zku3QzFn4KysqxgcjdH4Ur1Mj08Ny4EPDNOXJtEb/HATh1Y4QFm6fpj7IUNJ1W13/ymSzEuOKztSPgpikCy0frFNF34kb9AG2Hc7f4rM3KU6ZbxatwBGUQFuyShvlLdWXskRsZ38Gu6KfWX9mN2uNK1lpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kljvRtwqYDxtw0boOZzOJz5lLvOFtw/DNTyt3LWrSUw=;
 b=CGTdTMOyedHS+vxrnHaX/GHcuyXyyzaACMMh3chciNK5vhkmzGpkx2Z4HVWDdgbhZojC8870xTbu2jZghhIxcTA6auaHqmLEJ0GPDoO6dnZs4T+ceg+KLSVXrl3vaxPdumFzAvXrIWGl6slegFihrIVSrXAiLQ25AJQzj3rTB6I=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6772.eurprd05.prod.outlook.com (10.186.174.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 15:32:46 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Tue, 29 Oct 2019
 15:32:46 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: RE: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVjk+CpuXxUn6Q9k2inmzUDW7ozKdxvUOAgAABLrA=
Date:   Tue, 29 Oct 2019 15:32:46 +0000
Message-ID: <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
In-Reply-To: <20191029152419.GL22766@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f0752e3-bf13-4acf-8a33-08d75c853fda
x-ms-traffictypediagnostic: AM0PR05MB6772:|AM0PR05MB6772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6772873DAD22B8487D895220D1610@AM0PR05MB6772.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(13464003)(199004)(189003)(3846002)(6116002)(9686003)(476003)(11346002)(6436002)(107886003)(86362001)(446003)(229853002)(55016002)(5660300002)(4326008)(15650500001)(256004)(33656002)(186003)(14444005)(25786009)(52536014)(76116006)(54906003)(66066001)(71190400001)(71200400001)(8676002)(74316002)(76176011)(7696005)(7736002)(66476007)(66446008)(66946007)(66556008)(110136005)(102836004)(316002)(8936002)(64756008)(81166006)(81156014)(26005)(486006)(2906002)(53546011)(305945005)(6506007)(99286004)(478600001)(14454004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6772;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvqCsZHgL3ftvLyjk9bIu194XQx2UPe5EY+htiCrepPiGZf2NpeGkGzLYC0bflmcGZnzQ7IHbfNGcUPFKcKrTegUygOKNVCoABMNvAhplajYMnDkQNg8i/M9d09yjdDpamOr2Bw1D3gcTvDZU839dOiX3CzDD/a+bPWNVXL1HaLBgz2dnSpl6cP/AMC5XR5O7VCQdJiVIVymJUvhrAY0dxXZNHovIyJGRiyFMf2pInGK4Uz9jmclXnxMEbdxJyCv/HULQrKoxNei3msVppRMXvM6LtqJtLinadsi2xbNlCgU7jleG9QDD9FjLLFQLXE9rC9Sojhdpep1H7lNR5UgFMh9hO57Tvg1zcZHdSqtpK+JUbFSCUcYiMQxixPBFXgLl1rm0FdmNSsCItGVdIP/PuBjw54Lw7zOEh1Crpvoq2aTvFJaEvcXxHcBTmfNpV5s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0752e3-bf13-4acf-8a33-08d75c853fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:32:46.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFjepeTtZS8hZDOO+l/l+fNv2eNbGP78RcxKMhIes7jPGN2kYfWfGgIfm61slJqZ+2J6LPqC55L/SVpxRRRGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6772
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Tuesday, October 29, 2019 10:24 AM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> <leonro@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Daniel Jurgens <danielj@mellanox.com>; Parav Pandit <parav@mellanox.com>
> Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cac=
he
> update events
>=20
> On Tue, Oct 29, 2019 at 01:53:26PM +0200, Leon Romanovsky wrote:
> > -static void ib_cache_update(struct ib_device *device,
> > -			    u8                port,
> > -			    bool	      enforce_security)
> > +static int
> > +ib_cache_update(struct ib_device *device, u8 port, bool
> 	enforce_security)
> >  {
>=20
> Formatting
>=20
Will fix it.

> > +/**
> > + * ib_dispatch_event - Dispatch an asynchronous event
> > + * @event:Event to dispatch
> > + *
> > + * Low-level drivers must call ib_dispatch_event() to dispatch the
> > + * event to all registered event handlers when an asynchronous event
> > + * occurs.
> > + */
> > +void ib_dispatch_event(struct ib_event *event) {
> > +	ib_enqueue_cache_update_event(event);
> > +}
> >  EXPORT_SYMBOL(ib_dispatch_event);
>=20
> Why not just move this into cache.c?
>=20
Same thought same to me when I had to add one liner call.
However the issue was device.c has the code for the event registration/unre=
gistration and calling the handlers unrelated to cache.
So moving ib_dispatch_event() to cache.c looked incorrect to me.

> Jason
