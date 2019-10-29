Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8694CE8F09
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfJ2SLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 14:11:11 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:14230
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730435AbfJ2SLL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 14:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NajqjTeGk6AMMSLnHvEDWMIdGIZ5p637fDJzv9D15ew5iAlc9Lrvt1cW6hFTDwJb1AmIUWzA8LN634COXqjlZ+ZPbXXv1ubrnGq7rL4WEpIbXH4zPXsueu4+UcXu1Xqb8GU/DiRndymTxkn8EDBfHe8EkcrToALs2TomItvGvEoHXK+88+d2gzoTGuI1a4g/h/sjLbUv62LtkRuVeRl0bKbbfTK/lcfgFUmZj0W40MiZsK9wBKTsv/R+U5tYqCyTt1ByHB4XsPLPeI2ZZU0C/QsvLulNhnbZOLUTOmQ/BqQbGXqhq6JRbIgVb6lSiF9WeiUmFEz46SCZgpdXj33HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaflCKL2G+tL5FOXdW5yagk6ixycsDMECAImWnmj9ow=;
 b=EUn6nNR3ATDICq+vUBUtAtyIiqj2SAVnivtKzPddO6PNGpRS5LMvp2y0Ds0Nbv0/M5abhoNy9xG8Y+QUrq1RdoQYbKDFjSctplpP4cKwXsD/OC9YDyuU5fX9LQPfonW7j9j+5ZvIlz3oktZJsp5biDefHPHr8V9KxnciFzsXqSadt9M229n9dD4SPstoYZU9DHy2HUR5CKrlhJ31xiByITNUWn0kPU/DK1diZ+BqMaPgl5kaUfSq65GreAY6gs1FaMF9sZG7MCZ5QkC6XKSm0gBWwrXHYaJxS81HBF8qp/dbq4YEu5EaWO2/CbwxBFskqPTTF9gD63D8gYP/y7iICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaflCKL2G+tL5FOXdW5yagk6ixycsDMECAImWnmj9ow=;
 b=RA43Hns6P88Ecu1XEJQRL5mSivogWOfyCuR6QssjugGLhFjkjWHNDw/qpzfomy7TmtQUb3ej8Vhc+4vwDdS4cGoIB6zlr4q44WHuBA2oudWNlhMYYGGI36WilH+vMvXdUbVqw+vTItB/eTaF9kIhSvrsEnMoz/znKwOhYV+2DJ8=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6196.eurprd05.prod.outlook.com (20.178.115.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Tue, 29 Oct 2019 18:11:01 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Tue, 29 Oct 2019
 18:11:01 +0000
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
Thread-Index: AQHVjk+CpuXxUn6Q9k2inmzUDW7ozKdxvUOAgAABLrCAAAF0gIAAAtswgAADCQCAAAX74A==
Date:   Tue, 29 Oct 2019 18:11:01 +0000
Message-ID: <AM0PR05MB486695150B0FEE97AC3E6CECD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
 <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029153345.GN22766@mellanox.com>
 <AM0PR05MB48668ED6420D4DC6385ADE13D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029155454.GF6128@ziepe.ca>
In-Reply-To: <20191029155454.GF6128@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47c4ab36-2f77-404e-5057-08d75c9b5b21
x-ms-traffictypediagnostic: AM0PR05MB6196:|AM0PR05MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB61965EF814C4643A8163825CD1610@AM0PR05MB6196.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(54534003)(13464003)(51444003)(26005)(54906003)(6116002)(2906002)(71190400001)(229853002)(9686003)(4326008)(3846002)(6246003)(107886003)(55016002)(14444005)(6436002)(256004)(316002)(8936002)(8676002)(81156014)(81166006)(6916009)(71200400001)(446003)(66066001)(476003)(486006)(25786009)(86362001)(99286004)(11346002)(186003)(66556008)(66476007)(66946007)(5660300002)(102836004)(33656002)(53546011)(52536014)(6506007)(74316002)(7736002)(76116006)(305945005)(30864003)(478600001)(76176011)(14454004)(15650500001)(64756008)(66446008)(7696005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6196;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzZmxW5Qdcs+8FQBDdRo23kahvmMl2rHuZu+1CO+LCs6qV2f3OqrF1mQZQoORH6VUxh2DMSzfIuzKlpFUrtH6cOP5rDfP5CQsWW0FYDLivJnVC4aTYd1gYCkH4gy12tVsAUEx/YQg+Nswc2zrHYaYTDA8WMYgtkgLxvHVdRyj2+f8fx3n7rrVHeEAm9gZuBn0e/ytUHgIscR0OsXfJ7GBX44vHPCyihB2tN3END+lHruw4fQ6qLu8TEDjowP3qWppkxgxk7njQ3lIvqeu50ypLkOg8/ijgZTAarjntj2Ctw0v5rY4n0y5QzznkxVO2EfEneIqZve0keaDRNsuK+Gf4fUFzFcf1NoLxlyQJ0pGKoyKlb4hzDe57vf9mWCQl8arQZ2MEm65dSXiF4JY+pP+XINahoZH1YhCQqxQSSTly7BI8xXRI3pfjWugTAV3fSp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c4ab36-2f77-404e-5057-08d75c9b5b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 18:11:01.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BkOivsdZyz6lHRY1husqQtLDPYSlFpLLrXWjAKDNbOU8zuNGShGB56wONwpRG1mJcHQ712TsuozPaSn7q8ZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6196
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 29, 2019 10:55 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>; RDMA
> mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> <danielj@mellanox.com>
> Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cac=
he
> update events
>=20
> On Tue, Oct 29, 2019 at 03:47:42PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > Sent: Tuesday, October 29, 2019 10:34 AM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> > > <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>;
> RDMA
> > > mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> > > <danielj@mellanox.com>
> > > Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core
> > > distribute cache update events
> > >
> > > On Tue, Oct 29, 2019 at 03:32:46PM +0000, Parav Pandit wrote:
> > >
> > > > > > +/**
> > > > > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > > > > + * @event:Event to dispatch
> > > > > > + *
> > > > > > + * Low-level drivers must call ib_dispatch_event() to
> > > > > > +dispatch the
> > > > > > + * event to all registered event handlers when an
> > > > > > +asynchronous event
> > > > > > + * occurs.
> > > > > > + */
> > > > > > +void ib_dispatch_event(struct ib_event *event) {
> > > > > > +	ib_enqueue_cache_update_event(event);
> > > > > > +}
> > > > > >  EXPORT_SYMBOL(ib_dispatch_event);
> > > > >
> > > > > Why not just move this into cache.c?
> > > > >
> > > > Same thought same to me when I had to add one liner call.
> > > > However the issue was device.c has the code for the event
> > > registration/unregistration and calling the handlers unrelated to cac=
he.
> > > > So moving ib_dispatch_event() to cache.c looked incorrect to me.
> > >
> > > Well, maybe we can move the wq code from the cache.c into here?
> >
> > I prefer to keep all cache specific code in cache.c because there is
> > where we flush the ib_wq, queue work there.
>=20
> I think that is because the cache is not subscribing to a notifier, it re=
ally should,
> then things order properly and the flush is not needed.
>=20
Cache shouldn't subscribe to the notifier, that is the race condition issue=
.
With this fix, cache invokes the notifier chain in wq context after all cac=
he state is synced.
More below.

> > > It looks just as incorrect to have the one line call
> >
> > No, its not incorrect. Because device.c provides functionality to
> > register/unregister handler and dispatch event.  While cache layer
> > deals with cache updates etc, and uses wq service provided device.c If
> > we rename ib_dispatch_event() to ib_dispatch_cache_event() it make
> > sense to move to cache.c However we have non cache specific events
> > there too, so current code split between cache.c and device.c looks
> > appropriate.
>=20
> It always looks bad to have a single line function call like that, especi=
ally just for
> spurious reasons like file placement or functioning naming. It shows some=
thing
> is being done wrong
>=20
Actually this v1 version of the patch is incorrect.
Even though we don't have cache update event, patch calls the cache work.
My previous version was correct.

But improved version is below that addressed your comment.
I took care to get rid of one liner function too.
Inlined the patch below for review purpose. Will send through Leon's queue.
This fix exposed another dormant bug of mlx4 driver. So will send it togeth=
er as pre-patch to this patch.

From 97c8a3050471e1d27fdd7f529784d1fa0c871d43 Mon Sep 17 00:00:00 2001
From: Parav Pandit <parav@mellanox.com>
Date: Thu, 26 Sep 2019 15:55:26 -0500
Subject: [PATCH] IB/core: Let IB core distribute cache update events

Currently when low level driver notifies Pkey, GID, port change events,
they are notified to the registered handlers in the order they are
registered.
IB core and other ULPs such as IPoIB are interested in GID, LID, Pkey
change events.
Since all GID query done by ULPs is serviced by IB core, in below flow
when GID change event occurs, IB core is yet to update the GID cache
when IPoIB queries the GID, resulting into not updating IPoIB address.

mlx5_ib_handle_event()
  ib_dispatch_event()
    ib_cache_event()
       queue_work() -> slow cache update

    [..]
    ipoib_event()
     queue_work()
       [..]
       work handler
         ipoib_ib_dev_flush_light()
           __ipoib_ib_dev_flush()
              ipoib_dev_addr_changed_valid()
                rdma_query_gid() <- Returns old GID, cache not updated.

Hence, all events which require cache update are handled first by the IB
core. Once cache update work is completed, IB core distributes the event
to subscriber clients.

---
Changelog:
v1->v2:
 - Fixed not to call cache update when it is not a cache related event
 - Always invoke notifier handler in workqueue context
 - Removed incorrect comment about caller context of handler as it needs
   some more work
 - Replaced handler spin lock with rwsemaphore to make use of workqueue
   context
 - Moved ib_dispatch_event to cache.c as it distributes all events in wq
   managed mostly by cache.c

Fixes: f35faa4ba956 ("IB/core: Simplify ib_query_gid to always refer to cac=
he")
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/infiniband/core/cache.c     | 121 +++++++++++++++++-----------
 drivers/infiniband/core/core_priv.h |   1 +
 drivers/infiniband/core/device.c    |  11 +--
 include/rdma/ib_verbs.h             |   3 +-
 4 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cach=
e.c
index 00fb3eacda19..65b10efca2b8 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -51,9 +51,8 @@ struct ib_pkey_cache {
=20
 struct ib_update_work {
 	struct work_struct work;
-	struct ib_device  *device;
-	u8                 port_num;
-	bool		   enforce_security;
+	struct ib_event event;
+	bool enforce_security;
 };
=20
 union ib_gid zgid;
@@ -130,7 +129,7 @@ static void dispatch_gid_change_event(struct ib_device =
*ib_dev, u8 port)
 	event.element.port_num	=3D port;
 	event.event		=3D IB_EVENT_GID_CHANGE;
=20
-	ib_dispatch_event(&event);
+	ib_dispatch_event_clients(&event);
 }
=20
 static const char * const gid_type_str[] =3D {
@@ -1387,9 +1386,8 @@ static int config_non_roce_gid_cache(struct ib_device=
 *device,
 	return ret;
 }
=20
-static void ib_cache_update(struct ib_device *device,
-			    u8                port,
-			    bool	      enforce_security)
+static int
+ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
 {
 	struct ib_port_attr       *tprops =3D NULL;
 	struct ib_pkey_cache      *pkey_cache =3D NULL, *old_pkey_cache;
@@ -1397,11 +1395,11 @@ static void ib_cache_update(struct ib_device *devic=
e,
 	int                        ret;
=20
 	if (!rdma_is_port_valid(device, port))
-		return;
+		return -EINVAL;
=20
 	tprops =3D kmalloc(sizeof *tprops, GFP_KERNEL);
 	if (!tprops)
-		return;
+		return -ENOMEM;
=20
 	ret =3D ib_query_port(device, port, tprops);
 	if (ret) {
@@ -1419,8 +1417,10 @@ static void ib_cache_update(struct ib_device *device=
,
 	pkey_cache =3D kmalloc(struct_size(pkey_cache, table,
 					 tprops->pkey_tbl_len),
 			     GFP_KERNEL);
-	if (!pkey_cache)
+	if (!pkey_cache) {
+		ret =3D -ENOMEM;
 		goto err;
+	}
=20
 	pkey_cache->table_len =3D tprops->pkey_tbl_len;
=20
@@ -1452,50 +1452,84 @@ static void ib_cache_update(struct ib_device *devic=
e,
=20
 	kfree(old_pkey_cache);
 	kfree(tprops);
-	return;
+	return 0;
=20
 err:
 	kfree(pkey_cache);
 	kfree(tprops);
+	return ret;
+}
+
+static void ib_cache_event_task(struct work_struct *_work)
+{
+	struct ib_update_work *work =3D
+		container_of(_work, struct ib_update_work, work);
+	int ret;
+
+	/* Before distributing the cache update event, first sync
+	 * the cache.
+	 */
+	ret =3D ib_cache_update(work->event.device, work->event.element.port_num,
+			      work->enforce_security);
+
+	/* GID event is notified already for individual GID entries by
+	 * dispatch_gid_change_event(). Hence, notifiy for rest of the
+	 * events.
+	 */
+	if (!ret && work->event.event !=3D IB_EVENT_GID_CHANGE)
+		ib_dispatch_event_clients(&work->event);
+
+	kfree(work);
 }
=20
-static void ib_cache_task(struct work_struct *_work)
+static void ib_generic_event_task(struct work_struct *_work)
 {
 	struct ib_update_work *work =3D
 		container_of(_work, struct ib_update_work, work);
=20
-	ib_cache_update(work->device,
-			work->port_num,
-			work->enforce_security);
+	ib_dispatch_event_clients(&work->event);
 	kfree(work);
 }
=20
-static void ib_cache_event(struct ib_event_handler *handler,
-			   struct ib_event *event)
+static bool is_cache_update_event(const struct ib_event *event)
+{
+	return (event->event =3D=3D IB_EVENT_PORT_ERR    ||
+		event->event =3D=3D IB_EVENT_PORT_ACTIVE ||
+		event->event =3D=3D IB_EVENT_LID_CHANGE  ||
+		event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
+		event->event =3D=3D IB_EVENT_CLIENT_REREGISTER ||
+		event->event =3D=3D IB_EVENT_GID_CHANGE);
+}
+
+/**
+ * ib_dispatch_event - Dispatch an asynchronous event
+ * @event:Event to dispatch
+ *
+ * Low-level drivers must call ib_dispatch_event() to dispatch the
+ * event to all registered event handlers when an asynchronous event
+ * occurs.
+ */
+void ib_dispatch_event(const struct ib_event *event)
 {
 	struct ib_update_work *work;
=20
-	if (event->event =3D=3D IB_EVENT_PORT_ERR    ||
-	    event->event =3D=3D IB_EVENT_PORT_ACTIVE ||
-	    event->event =3D=3D IB_EVENT_LID_CHANGE  ||
-	    event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
-	    event->event =3D=3D IB_EVENT_CLIENT_REREGISTER ||
-	    event->event =3D=3D IB_EVENT_GID_CHANGE) {
-		work =3D kmalloc(sizeof *work, GFP_ATOMIC);
-		if (work) {
-			INIT_WORK(&work->work, ib_cache_task);
-			work->device   =3D event->device;
-			work->port_num =3D event->element.port_num;
-			if (event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
-			    event->event =3D=3D IB_EVENT_GID_CHANGE)
-				work->enforce_security =3D true;
-			else
-				work->enforce_security =3D false;
-
-			queue_work(ib_wq, &work->work);
-		}
-	}
+	work =3D kzalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return;
+
+	if (is_cache_update_event(event))
+		INIT_WORK(&work->work, ib_cache_event_task);
+	else
+		INIT_WORK(&work->work, ib_generic_event_task);
+
+	work->event =3D *event;
+	if (event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
+	    event->event =3D=3D IB_EVENT_GID_CHANGE)
+		work->enforce_security =3D true;
+
+	queue_work(ib_wq, &work->work);
 }
+EXPORT_SYMBOL(ib_dispatch_event);
=20
 int ib_cache_setup_one(struct ib_device *device)
 {
@@ -1511,9 +1545,6 @@ int ib_cache_setup_one(struct ib_device *device)
 	rdma_for_each_port (device, p)
 		ib_cache_update(device, p, true);
=20
-	INIT_IB_EVENT_HANDLER(&device->cache.event_handler,
-			      device, ib_cache_event);
-	ib_register_event_handler(&device->cache.event_handler);
 	return 0;
 }
=20
@@ -1535,14 +1566,12 @@ void ib_cache_release_one(struct ib_device *device)
=20
 void ib_cache_cleanup_one(struct ib_device *device)
 {
-	/* The cleanup function unregisters the event handler,
-	 * waits for all in-progress workqueue elements and cleans
-	 * up the GID cache. This function should be called after
-	 * the device was removed from the devices list and all
-	 * clients were removed, so the cache exists but is
+	/* The cleanup function waits for all in-progress workqueue
+	 * elements and cleans up the GID cache. This function should be
+	 * called after the device was removed from the devices list and
+	 * all clients were removed, so the cache exists but is
 	 * non-functional and shouldn't be updated anymore.
 	 */
-	ib_unregister_event_handler(&device->cache.event_handler);
 	flush_workqueue(ib_wq);
 	gid_table_cleanup_one(device);
=20
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/=
core_priv.h
index 3a8b0911c3bc..362b0231f7a1 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -149,6 +149,7 @@ unsigned long roce_gid_type_mask_support(struct ib_devi=
ce *ib_dev, u8 port);
 int ib_cache_setup_one(struct ib_device *device);
 void ib_cache_cleanup_one(struct ib_device *device);
 void ib_cache_release_one(struct ib_device *device);
+void ib_dispatch_event_clients(struct ib_event *event);
=20
 #ifdef CONFIG_CGROUP_RDMA
 void ib_device_register_rdmacg(struct ib_device *device);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index a667636f74bf..3524fa73a3ea 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1951,15 +1951,7 @@ void ib_unregister_event_handler(struct ib_event_han=
dler *event_handler)
 }
 EXPORT_SYMBOL(ib_unregister_event_handler);
=20
-/**
- * ib_dispatch_event - Dispatch an asynchronous event
- * @event:Event to dispatch
- *
- * Low-level drivers must call ib_dispatch_event() to dispatch the
- * event to all registered event handlers when an asynchronous event
- * occurs.
- */
-void ib_dispatch_event(struct ib_event *event)
+void ib_dispatch_event_clients(struct ib_event *event)
 {
 	unsigned long flags;
 	struct ib_event_handler *handler;
@@ -1971,7 +1963,6 @@ void ib_dispatch_event(struct ib_event *event)
=20
 	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
 }
-EXPORT_SYMBOL(ib_dispatch_event);
=20
 static int iw_query_port(struct ib_device *device,
 			   u8 port_num,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6a47ba85c54c..586da67ff0f5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2146,7 +2146,6 @@ struct ib_port_cache {
=20
 struct ib_cache {
 	rwlock_t                lock;
-	struct ib_event_handler event_handler;
 };
=20
 struct ib_port_immutable {
@@ -2897,7 +2896,7 @@ bool ib_modify_qp_is_ok(enum ib_qp_state cur_state, e=
num ib_qp_state next_state,
=20
 void ib_register_event_handler(struct ib_event_handler *event_handler);
 void ib_unregister_event_handler(struct ib_event_handler *event_handler);
-void ib_dispatch_event(struct ib_event *event);
+void ib_dispatch_event(const struct ib_event *event);
=20
 int ib_query_port(struct ib_device *device,
 		  u8 port_num, struct ib_port_attr *port_attr);
--=20
2.19.2

