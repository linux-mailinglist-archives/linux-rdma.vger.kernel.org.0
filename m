Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9BE117C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 07:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJWFJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 01:09:01 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:22814
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727980AbfJWFJB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 01:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0EiKpKuLD8/Rz5g64pOhZ+IT1RT/GC64Vyjr7NYKa7zbAP/FFoSJF+WthiiWpOo+FUAo/ugasloqwqFRgTICrtNIGQ291kRzXDnc3XFss08o0bzWWtmnvaTtaNYGk7t2NKOb5RYVPFURFj6eQZymcJj0JInxHJVCQ6eyKknqATxHR0IqpwCojs/eKLX+X6d+uhFxMme5WZSQN3bHigAQvshH7eZlCe3VSOxcDpVelMKkwpDbidf+94xs4ZNRqtLguo6XXweTG+eLfogC4yKXAopgGl/qP2PvYa3T3Wgnyg1C7vSjDXrxAkPSllntNMpZ+47Eg2T0Jcdb/Y/r34E9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5WDGWZZpjxBQbH3tPRXcycjFuRwRV4QliHAlK05gm8=;
 b=QASeJq0EhZYZKWWNRtm+ezJtDYwud2ktRzt1EAKezktXcaQ5WVAKHC1pahNhU/Y6IP1cHQcq1zOnYHnzd3WubIyUrAVD9yL3Q3hJVKVx4clsuumX3aHo1bwCkCfbrH6+mj7d+LLrnZi68zhNcw2zXGSpwNEQVnpuKBhVBl57t1JoNvwDX0qZPnlLmC2Hv09i8TYqhOcmH8g3K3dRJlq7Z+LwVhjbtkjOIscvHpmYtkEFbX1vyILVaZ+veRk5qZu7WFQmFt4z4GGlDNIA1UY5ZBDZRmwSDbOmEnRbi47EMxQajGwbwjFF8y+tgys8v4E7Rgm4ZMyUmy0DSemIlORw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5WDGWZZpjxBQbH3tPRXcycjFuRwRV4QliHAlK05gm8=;
 b=JCFs+6slxKkKO1rlp5ktl4f8hVs0t4+POYqHU4ZZ3Bj7+MRkxyF4V3aUkKPHCC6Yzm9BLYXvuy4kfJ7tTnzAQdIkdFKTL/d630mtx5FgqsGdqqb5RJXiKIlNwcUKqQZ+fBcz1Lq2TC2RRYiGQjxP7ed1+bSlbMsEqX8SeVgHmOU=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6433.eurprd05.prod.outlook.com (20.179.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Wed, 23 Oct 2019 05:08:56 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 05:08:56 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: RE: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVhxM9S9h4NqlGK0Gqm3lNIdP0f6dnFyAAgACYR0A=
Date:   Wed, 23 Oct 2019 05:08:56 +0000
Message-ID: <AM0PR05MB4866B5ABA8F86D60A3FEE299D16B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191020065427.8772-1-leon@kernel.org>
 <20191020065427.8772-2-leon@kernel.org> <20191022195518.GO22766@mellanox.com>
In-Reply-To: <20191022195518.GO22766@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:9998:a67e:2d73:c34e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d843094-9179-45ef-1107-08d757771af5
x-ms-traffictypediagnostic: AM0PR05MB6433:|AM0PR05MB6433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB64339342F8BC5CEDF824ECFDD16B0@AM0PR05MB6433.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(189003)(199004)(13464003)(14444005)(229853002)(2906002)(15650500001)(66556008)(6246003)(66476007)(33656002)(86362001)(76116006)(107886003)(55016002)(66446008)(6436002)(64756008)(478600001)(14454004)(256004)(9686003)(66946007)(71190400001)(4326008)(11346002)(46003)(8936002)(186003)(71200400001)(25786009)(6116002)(81166006)(81156014)(8676002)(446003)(316002)(54906003)(7696005)(76176011)(53546011)(6506007)(476003)(102836004)(486006)(52536014)(305945005)(7736002)(74316002)(5660300002)(99286004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6433;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L71Prtdwr3uRgLgZNvQIZW809DKsCXbgXJNU5z79GZaa45N9ciQjPRf1UgjFesmZp+JcN0NhhddZKRdJ1k6gxwudQLTFzvFJlzGiEqkcq/srKeFNkTmW18QIagC0aWNnQSxkPTgDwbWvh1g2H0cxv12AHp9dbKLvbEcC+kX5cPL4guTOVJ+Him3BkpyRGC25A8sdtSfs8XgdYTj6RZi/eODQuNNhRR/wFXLICQQZFY4Ie45lJ5CDeQ6GoS6h1gDOPlj+vCtEd8TuvNK27hP/KOWp1a3qlS8leakxxI0HtOqRzJdVw3bfFqPIO8CIJz4aK8bw8NDm9QTmyZyg1Nx93IGJdq6hrz1wfQ1tNV8hAeHAltvL+7g/LHKvBMH6UvK2vTJqHISo/Wq6i9M+5UdlzUYHKwlrp11YtY1FvDV/HZdqFc5sEf1uPhYj3buvyHwB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d843094-9179-45ef-1107-08d757771af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 05:08:56.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yg52KjkcSh4PS0JQUmgOm6beps9d4oVdeK1ho9BWjyKUqhAnMZ0Uv+ZOQYtT7W2NTpoVGENaulgrbG8CS/E51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6433
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Tuesday, October 22, 2019 2:55 PM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> <leonro@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Daniel Jurgens <danielj@mellanox.com>; Parav Pandit
> <parav@mellanox.com>
> Subject: Re: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
> update events
>=20
> On Sun, Oct 20, 2019 at 09:54:25AM +0300, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index 2f89c4d64b73..e9ab1289c224 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1951,15 +1951,7 @@ void ib_unregister_event_handler(struct
> > ib_event_handler *event_handler)  }
> > EXPORT_SYMBOL(ib_unregister_event_handler);
> >
> > -/**
> > - * ib_dispatch_event - Dispatch an asynchronous event
> > - * @event:Event to dispatch
> > - *
> > - * Low-level drivers must call ib_dispatch_event() to dispatch the
> > - * event to all registered event handlers when an asynchronous event
> > - * occurs.
> > - */
> > -void ib_dispatch_event(struct ib_event *event)
> > +void ib_dispatch_cache_event_clients(struct ib_event *event)
> >  {
>=20
> no kdoc for this?
>
I dropped the kdoc because it was an internal API, not exposed to other ker=
nel modules.=20
 And added for the external one below.

> >  	unsigned long flags;
> >  	struct ib_event_handler *handler;
> > @@ -1971,6 +1963,22 @@ void ib_dispatch_event(struct ib_event *event)
> >
> >  	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
> > }
> > +
> > +/**
> > + * ib_dispatch_event - Dispatch an asynchronous event
> > + * @event:Event to dispatch
> > + *
> > + * Low-level drivers must call ib_dispatch_event() to dispatch the
> > + * event to all registered event handlers when an asynchronous event
> > + * occurs.
> > + */
> > +void ib_dispatch_event(struct ib_event *event) {
> > +	if (ib_is_cache_update_event(event))
> > +		ib_enqueue_cache_update_event(event);
> > +	else
> > +		ib_dispatch_cache_event_clients(event);
> > +}
> >  EXPORT_SYMBOL(ib_dispatch_event);
>=20
> It seems like there is now some big mess here, many of the users of event=
s,
> including cache, acctually do need a blocking context to do their work, w=
hile
> this function is supposed to be atomic context for the driver.
>=20
> So, after this change, many event types are now guarenteed to be called
> from a blocking context in a WQ - but we still go ahead and do silly thin=
gs
> like launch more work to get into blocking contexts from the other users
>=20
> Thus I'm wondering if this wouldn't be better off just always pushing eve=
nts
> into a wq and running the notifier subscriptions sequentially?
>
Are you saying we should drop the else part above and always do ib_enqueue_=
cache_update_event()?
If so, yes, I think it should be fine.
Only event that I wanted to deliver faster was IB_EVENT_SRQ_LIMIT_REACHED.
However given no kernel consumer interested in it, doing fast event deliver=
y for such event is not so useful.
We can slim down ib_is_cache_update_event().

