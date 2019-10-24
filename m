Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1451E3CA3
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfJXT6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 15:58:20 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:55022
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfJXT6U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 15:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fULW3HYG9VWe6PjgtqqLPEGIXqYMJABrYWrmhYnIBrVNO1s+0ctQvgtR9cx4j9EU8AGHMsVPkcIq8XwrXpjAw28L1Hx913GutrCx2vlVS0f7sg+3lCTrQlzu4HSukPYlY1F43pbYevfdHxdxysb2HmEn2hTEn5RQFOjqRZPVeRV3ZgjQX42DxGsBYkyAV4FxaxTgIREkLQCtiZi3cwWbLh/N2T8QpyYvQcU8dY6YMF4YR1AjJmdEyC2rhVGdStD6Gbsio8+Kr1O7BE6qgyZj6cVWiMuEePmIRGSL7SCt2nbq4hgfqr01aSdqp3CQh9bm5KkRriu5x/DAmnSX+FP8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T07j0/AtsjaAEyRjcknvgztN8H8lrb28UUFyS/8Q/SM=;
 b=myR/toQQdStt5cWa+wwx7nXtCUlJiCaT2ek/mU6g3ardtvBqoJSU9cMD1H9wchO5FpCd854Ev7lpQcB/eKaPlBqgdlvLggwdE8ASHPRzrOAZYtPtOYIGMkQp83J6JiPFCDAfc2Ve2oMVp+7//I9thOdMa4FRkVvsn6baUND8uIn6GjrjXGqs9QCA1SCk4uORE7rNkhpqfeRdK+gXAhRu+w/zBUAByZQLqlr7/xOgiXKdSXffMPwjYgFqlhgBf5ZwqSAqX5Z0IQdy6NSXm7QkhyRyvGAy7p1K5amYb4jsRNwQCMp5BYf+pCUc3/gRxFHXHMauQwHptKZBa1V5NjkbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T07j0/AtsjaAEyRjcknvgztN8H8lrb28UUFyS/8Q/SM=;
 b=hQa9cNWninOQYdRrp5cZ4+sP7d7pZdT4Ay9l6vyO4y4Iug/AxJOOjwGHkdm6UuhuvrsPZ6wYMP16HW7W8qZQqDkGXRx201U6PdyQdPN89oLdAA/Z1GHIUCrYmWSFySORMvF/xCKT7QKraWueXWQ8+fX+88hOYDErp6frgHjF+UM=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6770.eurprd05.prod.outlook.com (10.186.175.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 24 Oct 2019 19:58:15 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Thu, 24 Oct 2019
 19:58:15 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: RE: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVhxM9S9h4NqlGK0Gqm3lNIdP0f6dnFyAAgACYR0CAANRsgIABt9cg
Date:   Thu, 24 Oct 2019 19:58:15 +0000
Message-ID: <AM0PR05MB4866E018CCCAE50CFBC79E6DD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191020065427.8772-1-leon@kernel.org>
 <20191020065427.8772-2-leon@kernel.org> <20191022195518.GO22766@mellanox.com>
 <AM0PR05MB4866B5ABA8F86D60A3FEE299D16B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191023174037.GY22766@mellanox.com>
In-Reply-To: <20191023174037.GY22766@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56747c89-df35-4aaf-0eb0-08d758bc824e
x-ms-traffictypediagnostic: AM0PR05MB6770:|AM0PR05MB6770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB67700E186CA30F70E7942805D16A0@AM0PR05MB6770.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(13464003)(33656002)(76116006)(66446008)(186003)(66946007)(66556008)(66476007)(64756008)(26005)(53546011)(86362001)(3846002)(6116002)(15650500001)(2906002)(102836004)(52536014)(6506007)(76176011)(99286004)(54906003)(476003)(11346002)(446003)(486006)(5660300002)(9686003)(256004)(14444005)(305945005)(74316002)(7736002)(6636002)(7696005)(66066001)(6246003)(25786009)(107886003)(6862004)(4326008)(478600001)(81166006)(6436002)(81156014)(8936002)(8676002)(14454004)(55016002)(229853002)(71200400001)(316002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6770;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2YlI/Af3NrhizuVoSfG/T5LvQYbnxHn5BvVsgD4y8Ay0FGzFCN2aFdNWruYtGg3eUdxvBOYf7ZZlAFKHfXecVLR6RCY7zM2o3GumqAT619/IgAIKL69R7sWOv866/uLojAlNpOh3N6/bah6bb34ALTQ99JkuHZG4Tb5wiwSsTl63AIl9T9Tm3f8FS7abxAmTeQEPCkBPqUN4jmqkhISc90lLNdnJAF2uzQVVixKM7gfulUkVMSjwiR0vPDNCLB6wrLuNqOlACmm06L4XT5o8WV1OYJrMjoGnsFZv7dkA3ygcrbkJBcC7dGU0y50i6DDc8Ymtm+pxedAffNvA075cEOOiJK67JhgDWK8MqQmCPY9a8TFkap68Ndh3LcRPCT/u/r1YitOauriUCFii/j0Y2pkvgWk/xA3ykQSLS/CjibDgcbGUvatArtm2hd743NF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56747c89-df35-4aaf-0eb0-08d758bc824e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 19:58:15.8004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qBuw8jkeEvKMkYExvgRU7wr+UUufh5A/g5vTlgy7UXrtU1HqNNwLbYcHGgVLD+QMlXLXQVjXw53I6gcbsZrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6770
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Wednesday, October 23, 2019 12:41 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>; RDMA
> mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> <danielj@mellanox.com>
> Subject: Re: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache =
update
> events
>=20
> On Wed, Oct 23, 2019 at 05:08:56AM +0000, Parav Pandit wrote:
> > > >  	unsigned long flags;
> > > >  	struct ib_event_handler *handler; @@ -1971,6 +1963,22 @@ void
> > > > ib_dispatch_event(struct ib_event *event)
> > > >
> > > >  	spin_unlock_irqrestore(&event->device->event_handler_lock,
> > > > flags); }
> > > > +
> > > > +/**
> > > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > > + * @event:Event to dispatch
> > > > + *
> > > > + * Low-level drivers must call ib_dispatch_event() to dispatch
> > > > +the
> > > > + * event to all registered event handlers when an asynchronous
> > > > +event
> > > > + * occurs.
> > > > + */
> > > > +void ib_dispatch_event(struct ib_event *event) {
> > > > +	if (ib_is_cache_update_event(event))
> > > > +		ib_enqueue_cache_update_event(event);
> > > > +	else
> > > > +		ib_dispatch_cache_event_clients(event);
> > > > +}
> > > >  EXPORT_SYMBOL(ib_dispatch_event);
> > >
> > > It seems like there is now some big mess here, many of the users of
> > > events, including cache, acctually do need a blocking context to do
> > > their work, while this function is supposed to be atomic context for =
the
> driver.
> > >
> > > So, after this change, many event types are now guarenteed to be
> > > called from a blocking context in a WQ - but we still go ahead and
> > > do silly things like launch more work to get into blocking contexts
> > > from the other users
> > >
> > > Thus I'm wondering if this wouldn't be better off just always
> > > pushing events into a wq and running the notifier subscriptions
> sequentially?
> > >
> > Are you saying we should drop the else part above and always do
> > ib_enqueue_cache_update_event()?
>=20
> Yes, but also now saying that all notifier callbacks are called from work=
 queues
> and can block for short periods.
>=20
> This seems it would simplify many of the users??
>=20
Yes, however that optimization should be a different series per ULP/consume=
r/event based.
Will send v1 through Leon's queue.

> And not using the ib_enqueue_cache_update_event() but a simple
> blocking_notifier_call_chain() with the cache always at the front
>=20
> > Only event that I wanted to deliver faster was
> > IB_EVENT_SRQ_LIMIT_REACHED.
>=20
> It might make sense to have an atomic event list for such things in futur=
e..
>=20
Ok.

> Jason
