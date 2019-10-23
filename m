Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F05E21F1
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 19:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfJWRlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 13:41:25 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:16802
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730976AbfJWRlZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 13:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imlTRHwuuIdxelI1vnrfhjgrhbN7K0aH3nB8e8+65zFrS6tHn0i5h+D+brmZa+9uQn7tWruB5fXXk0tbnFEAhoXczMAROVU7RBmG6cs/lhx6Ba+cbbqcwD2DQGE4sqn7sB2T0DxoeMVV5Gp1g6uasVHWUu4Y8R1p8UbEs7dMU6ZLor9DwbsWFUBRRGtBc609U0JOf7XY1L9UjwfoWfKtzOPwBHDQos7lAkGtmova5Wu+Ke7+2sYqYobrLDE6n1s2nLPZAeRN6+Pn9wcagLSB27g6LpEWSBJw4k8M/PtWlcJkXa+t8R4UqTgxhR6CkqLcS8iTBDyHH+oh4Jra+YUHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYr8eHaS/++X0xeIT8eYyRCLOAXUsQfVCdX4KlJfgBA=;
 b=Gt6FOzjUbUWvFkVeHGR2bnZgpsBiG3WxuZpl5ICfBzvMtQBNF5cAZ0U84guCgd7yY2t0PlJgwD6wf/MXhmvUXP5j0JsZICeZHLoeGRe88Vae6KGtLDTnUuFNi6TMtrYQejvxWirHNBALXXTzOeFz6UHFwv2HbyZZa+brwzAggqTQa9lydbAjuMnWjvoHo85HV+tFvsuOa03InF3nn+kR/kPZksjKW2iWk1lNgGXqN+Bw47/0kDv+rbpQlOYOieqEOShfYVL71ndQ/mKAsdGTTEp1ML38puxMkpr90XhcgwMJxp0NarTOncwhsiHfYb2KIeW6PDByWywTlydD8gOUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYr8eHaS/++X0xeIT8eYyRCLOAXUsQfVCdX4KlJfgBA=;
 b=bXLckyClcd+H+WMi2kB5tWDoh53267N6FnHYe5TQrVXDPACDIVOVE+GfjS4GS12yJ3TfMQ0fQNeqPnNx9Qj2dCa/sccEhnNZzVviLPzXe1M1zL4SqSmNLa63a/d2TptHEXMVf05qLVM0qBKtFi0lZ3OxkxKVOKWkpxWJR5XOq7I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3357.eurprd05.prod.outlook.com (10.170.237.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 17:40:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 17:40:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVhxM94+KDX9EQUkqFPNNVbTrJ86dnFxsAgACarwCAANIEgA==
Date:   Wed, 23 Oct 2019 17:40:41 +0000
Message-ID: <20191023174037.GY22766@mellanox.com>
References: <20191020065427.8772-1-leon@kernel.org>
 <20191020065427.8772-2-leon@kernel.org> <20191022195518.GO22766@mellanox.com>
 <AM0PR05MB4866B5ABA8F86D60A3FEE299D16B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866B5ABA8F86D60A3FEE299D16B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:408:d4::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a34ea325-d4f8-4448-5801-08d757e01fe3
x-ms-traffictypediagnostic: VI1PR05MB3357:|VI1PR05MB3357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3357119F1378484A1EDA91AFCF6B0@VI1PR05MB3357.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(66556008)(5660300002)(37006003)(316002)(66476007)(66446008)(1076003)(64756008)(66946007)(66066001)(71200400001)(71190400001)(54906003)(14444005)(36756003)(8936002)(86362001)(256004)(81166006)(99286004)(81156014)(186003)(33656002)(6436002)(6506007)(6862004)(107886003)(6636002)(4326008)(386003)(6486002)(26005)(14454004)(52116002)(76176011)(102836004)(2906002)(478600001)(446003)(486006)(476003)(229853002)(6246003)(11346002)(2616005)(6512007)(3846002)(6116002)(7736002)(305945005)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3357;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4K7azIcnBsuyrSrJDBB2778bz28XoysnSkqyi4mL4Wmt9au4s9xa1l47PzkxT8xL7DkLywH/AJKpV2ky0HQhhn/MTbmy3MdYQt3ZIy+tC/oFgeJrnqe30Mh4XIjOiULbB/sQ5H36xqxBBsVbdDnfiQs4ph7x8VdyUZhAr8UEbLDza0P0f/4l+oueRG1unvk0p9z4XxHWFnkW98Hzo6JvGuPcmuW+sTjsPsrLvEtEP+WOiIixiVpO00JryZ81d8ZLmY67GHqP4Ke7ZGAhQ/zDN4RMuFMg0QJZEZqrVMdnOlHO0G3rV3XvqCIRCrxLyTy+96ZnQ84Pa0K1wAReG96sAUttNh8QbIva+vyXfe+zY5wiIw6ZFXGalRXr11kGRpJ1xETk1vEJ7Wx2JWdeIVPoJxwhuQh8s6y5bz+lraUqWlXU2inEUFJKh1JcGVvgm5+i
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45D15685D095F34C922AFC44DE60A9FE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34ea325-d4f8-4448-5801-08d757e01fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 17:40:41.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XqsXjN2oJuwb8N7lqZWqonrdSIMIje71jQovSMkGbp+K9sNKioV6OGN0hPWsup8WvAcBWAtvJcsyjtRjth6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3357
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 05:08:56AM +0000, Parav Pandit wrote:
> > >  	unsigned long flags;
> > >  	struct ib_event_handler *handler;
> > > @@ -1971,6 +1963,22 @@ void ib_dispatch_event(struct ib_event *event)
> > >
> > >  	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
> > > }
> > > +
> > > +/**
> > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > + * @event:Event to dispatch
> > > + *
> > > + * Low-level drivers must call ib_dispatch_event() to dispatch the
> > > + * event to all registered event handlers when an asynchronous event
> > > + * occurs.
> > > + */
> > > +void ib_dispatch_event(struct ib_event *event) {
> > > +	if (ib_is_cache_update_event(event))
> > > +		ib_enqueue_cache_update_event(event);
> > > +	else
> > > +		ib_dispatch_cache_event_clients(event);
> > > +}
> > >  EXPORT_SYMBOL(ib_dispatch_event);
> >=20
> > It seems like there is now some big mess here, many of the users of eve=
nts,
> > including cache, acctually do need a blocking context to do their work,=
 while
> > this function is supposed to be atomic context for the driver.
> >=20
> > So, after this change, many event types are now guarenteed to be called
> > from a blocking context in a WQ - but we still go ahead and do silly th=
ings
> > like launch more work to get into blocking contexts from the other user=
s
> >=20
> > Thus I'm wondering if this wouldn't be better off just always pushing e=
vents
> > into a wq and running the notifier subscriptions sequentially?
> >
> Are you saying we should drop the else part above and always do
> ib_enqueue_cache_update_event()?

Yes, but also now saying that all notifier callbacks are called from
work queues and can block for short periods.

This seems it would simplify many of the users??

And not using the ib_enqueue_cache_update_event() but a simple
blocking_notifier_call_chain() with the cache always at the front

> Only event that I wanted to deliver faster was
> IB_EVENT_SRQ_LIMIT_REACHED. =20

It might make sense to have an atomic event list for such things in
future..

Jason
