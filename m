Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7590E8FF6
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfJ2T2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:28:45 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:40349
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfJ2T2p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 15:28:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrIH8py176EZuZXWlPMcR0Sx95kPDb+LMMnf3wqtfwLQzjO5HDYW2GNcmArAtzHf0O38+2O2FEjfqlaFqhW2GTmBPshzu1zr1hNfKd1ycxrpOCqWhubpUkJakEzQevXJWAXh7RoAe4DArOohQ2kG4LCqB1ihkTohoLtX9XSJJ4oO/zukc9Ttt4fN6JEfmqHhTFjPDyASe0AB0zkd53Q/2sDGxTSn3jwP3z60ADxsGuPrO9cLhaHZD766CaKl4t+Im6LAZ0D9vc/YfjQ47RUzDH0akw/BQ68UWEm0oSnqc0kcHPDge99ecqPdldkc3EXnaOJREdiFNsTu4DuPyttulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMW9N1LFqBqdQQcm9zvQDrSMlnINrgdnSUl9dpmWSz8=;
 b=IpQ7TBwAR0TBYOn+Xu9VlXvgEovDwcCaQqrnZSUIC6ldkXkM7FeM6vyK8lJE5Bwm80sSIbH2AkQmhAyb0Uhv1YbgCxqFZu7sj45yIrwN16L2ae1CrB+CTdlIWJwcHzuCcBxFE7xiHZkzg1atZIdBMkNexQ3wPnzbXbOsW7FB9R3wruarYqEDYOPO0q9Qyr3qE6kOPriPh2OG2hBEMH8C4UG01nyzKT+ficB2bVD5qS1RScLMQIovzapNVzoapKhIvuL+L7FTIqqHAF65WMTI5mgITJ2rSE0wWKjdPr0f0lMhpUk8dm6idjYs1czjtUB6PI0YVs/iNNUdw7153H6QVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMW9N1LFqBqdQQcm9zvQDrSMlnINrgdnSUl9dpmWSz8=;
 b=YccXWz/Wcm7n5iiyfHqoNQJ4OeN2YpL1Snj0s5DqvNZdk2AfNpwXRQqb9nIsXZSSQNNBosd0GaE9RktKekv0xz/BHuCtza6RCc2UKJQPC6ewV4dvcnE0kX2BS3IUQM89boG+6+5Q+fr0a5A/SK41V4FnaXBHf5e3AiovRx2/OdE=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4353.eurprd05.prod.outlook.com (52.134.126.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Tue, 29 Oct 2019 19:28:40 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Tue, 29 Oct 2019
 19:28:40 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: RE: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVjk+CpuXxUn6Q9k2inmzUDW7ozKdxvUOAgAABLrCAAAF0gIAAAtswgAADCQCAAAX74IAAJEQAgAANobA=
Date:   Tue, 29 Oct 2019 19:28:40 +0000
Message-ID: <AM0PR05MB4866464BDB51FD682AFFDB78D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
 <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029153345.GN22766@mellanox.com>
 <AM0PR05MB48668ED6420D4DC6385ADE13D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029155454.GF6128@ziepe.ca>
 <AM0PR05MB486695150B0FEE97AC3E6CECD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029182606.GG6128@ziepe.ca>
In-Reply-To: <20191029182606.GG6128@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f001ed15-4075-4c47-1c43-08d75ca6341c
x-ms-traffictypediagnostic: AM0PR05MB4353:|AM0PR05MB4353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB43539AADFF999D64AC4F6953D1610@AM0PR05MB4353.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(51444003)(13464003)(25786009)(6116002)(81166006)(11346002)(446003)(8676002)(99286004)(305945005)(74316002)(81156014)(2906002)(33656002)(476003)(52536014)(9686003)(55016002)(6916009)(7736002)(5660300002)(15650500001)(486006)(102836004)(26005)(7696005)(76176011)(53546011)(229853002)(6506007)(6436002)(14444005)(256004)(4326008)(3846002)(71200400001)(186003)(66946007)(316002)(76116006)(66476007)(54906003)(64756008)(66446008)(66556008)(14454004)(107886003)(8936002)(478600001)(6246003)(66066001)(71190400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4353;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9F2YcVHIvAvPsdrmkhBR+YdXoj5xy3pty+dytLMxxyqsMZab/s3tFu14q9qpIJi4iH2LE8TinWqS1z/eTZSjLxJDDjgJyDb4r70po6FqCteGye5PeGJ1jBkLOBY0rU1NcFMSQgX243Lc2rokBwc3KDlHDFF/ttXtpc7+2nuXq41+epPVFQOtC6NwqGJuGZFML84VYi7ngM03yOQObQlUTWSc+FsdueZ8ClT/sILv2KUPMTQO2WMb99b+hYrK7llhlmVuhpg6Y1cGOQtaZ1XzpmuYnT4hGiyfb5FDw4xmUWC+7Ni8vSjfL0A63PyX154hqzxs6ZrJrQEy+fMP/BdmYNB5WEt2kf/wv0PEh/ZHU/d7w5WbHrdyCQ/0tTzw9TUmo2oHAIyDZ+i4p4DEO3T/NPCbRKMbnOIoHuenHTnc2Pi1+McZxDewohHzIbXtb0r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f001ed15-4075-4c47-1c43-08d75ca6341c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 19:28:40.3029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95Je/hCO8TBzJSpzJ2b2e/zi05Pe9QIq57yYE6GoruEUwzUCaUBKxxt5MdX5QzTjSab8P+myazyUD36O9Ovunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4353
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 29, 2019 1:26 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>; RDMA
> mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> <danielj@mellanox.com>
> Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cac=
he
> update events
>=20
> On Tue, Oct 29, 2019 at 06:11:01PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Tuesday, October 29, 2019 10:55 AM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> > > <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>;
> RDMA
> > > mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> > > <danielj@mellanox.com>
> > > Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core
> > > distribute cache update events
> > >
> > > On Tue, Oct 29, 2019 at 03:47:42PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > > Sent: Tuesday, October 29, 2019 10:34 AM
> > > > > To: Parav Pandit <parav@mellanox.com>
> > > > > Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> > > > > <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>;
> > > RDMA
> > > > > mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> > > > > <danielj@mellanox.com>
> > > > > Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core
> > > > > distribute cache update events
> > > > >
> > > > > On Tue, Oct 29, 2019 at 03:32:46PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > > > +/**
> > > > > > > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > > > > > > + * @event:Event to dispatch
> > > > > > > > + *
> > > > > > > > + * Low-level drivers must call ib_dispatch_event() to
> > > > > > > > +dispatch the
> > > > > > > > + * event to all registered event handlers when an
> > > > > > > > +asynchronous event
> > > > > > > > + * occurs.
> > > > > > > > + */
> > > > > > > > +void ib_dispatch_event(struct ib_event *event) {
> > > > > > > > +	ib_enqueue_cache_update_event(event);
> > > > > > > > +}
> > > > > > > >  EXPORT_SYMBOL(ib_dispatch_event);
> > > > > > >
> > > > > > > Why not just move this into cache.c?
> > > > > > >
> > > > > > Same thought same to me when I had to add one liner call.
> > > > > > However the issue was device.c has the code for the event
> > > > > registration/unregistration and calling the handlers unrelated to=
 cache.
> > > > > > So moving ib_dispatch_event() to cache.c looked incorrect to me=
.
> > > > >
> > > > > Well, maybe we can move the wq code from the cache.c into here?
> > > >
> > > > I prefer to keep all cache specific code in cache.c because there
> > > > is where we flush the ib_wq, queue work there.
> > >
> > > I think that is because the cache is not subscribing to a notifier,
> > > it really should, then things order properly and the flush is not nee=
ded.
> > >
> > Cache shouldn't subscribe to the notifier, that is the race condition
> > issue.
>=20
> Notifiers are ordered, as long as the cache subscribes first to the notif=
ier list it
> is not a 'race condition'.
>=20
> This is still somewhat problematic because 'ib_dispatch_event' still call=
s the
> handlers under a spinlock (ie the handlers are still non-blocking context=
s)
>=20
It is not problematic  unless we ask ULPs to execute most of their work in =
the notifier context.
It is sub optimal at the moment.

> I'm suggesting to swap it for a normal blocking notifier chain and guaran=
tee
Before writing this version, I considered that option.
However the blocker was qp's event_handler callback.
In below two call traces rw_semaphore will be triggered in interrupt contex=
t.
So wanted to split the QP's event_handler with device->event_handler.
After I split both, than running device's event_handler will be possible wi=
th cache as first entry in chain.
Shall I revise the series to split two handlers?

qedr_iw_event_handler
  qedr_iw_qp_event

hns_roce_v2_aeq_int
  hns_roce_qp_event
    qp->event_handler
       __ib_shared_qp_event_handler()

> the cache is the first entry in the chain.
>=20
> Jason
