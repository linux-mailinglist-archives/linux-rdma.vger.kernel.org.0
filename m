Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11267E898D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 14:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbfJ2Nb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 09:31:27 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:37862
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbfJ2Nb0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 09:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmUSwmqaUnzl3A7AbEgnzFlIWOkPFM2wlSk9nFdod6ZIYaQNNTNdRTvMxrbisVsy0sHfj63t9utpgMwQ43py0dK9LrkT2/+cbu2eM95htyu2ASKatAi1kHk/a+AuUg+edF3buOqE8GCpFbAK7nfJMEVQqvyhXDLD8BQn4LjWjm1UczDQRXF2gEO1DVwdcFt5i/M9O9bwRZulB3rS5MX6hIZ1So/JZBZY6Z2cxF6GCYN/MwKerFLdSwDdH2HKwM2CP6R8muGbAmi760Bp62vvTaPZkJzcnDjP0Fv+vKXgRsYSRTEZ+77TkHi/TYSf8Mg8q5TiEnkDLhHbnPvfgnq4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkK50PPgp85AeroYL90FT4botfNI9lVDHGn88FXzJgE=;
 b=NPBgX6ZFN62wQj0dwKIH9+eSQnRrGYVhcRjmZrBrnaXnXEWUDKD/0suhuCRnpFEb3+bfcsfn+kPXVtftOqcxPK7/WS9YLeKje8csy0JejGwBXPFthkPmnNVkB5LkkCF0TvS/lNek86l3le9C/b9/RikIpPICugh00jMbuupPU7EWKSf9isThkHolz88Ekb3PeNKDj5J3R/t8Mo+thXk0I5HercCYfLBFRseTMyHZUN+RRp4zyWJpkEvCVDRcXUnG23WXMmCj7BssAffg/0UgLLwtkwQ7OsQaCl4o9lhfxVmMyiRzbUlV/i6FiftZj+LN+hki1W7A4tuYp6emiqJBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkK50PPgp85AeroYL90FT4botfNI9lVDHGn88FXzJgE=;
 b=bVA2YVZVD5f8njzkuBdQWakvFKtm/kBOYoyLqQsvDkzE4ADV9UKm2j7xa9dCmLvBAqbdSpaxGZS4Aeimbdu1Z5P7+0X8mobdcDAl/jLiFv7tsQTdowjrfULCYEM7XMUuB1EQo3ZVStMXaCS/jtJx6mmo99bCf1fHDlye+TigNck=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4580.eurprd05.prod.outlook.com (52.133.56.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 13:31:20 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Tue, 29 Oct 2019
 13:31:20 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: RE: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVjk+CpuXxUn6Q9k2inmzUDW7ozKdxnU3Q
Date:   Tue, 29 Oct 2019 13:31:19 +0000
Message-ID: <AM0PR05MB4866DC079BB158F04ED57552D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
In-Reply-To: <20191029115327.16589-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:e4b1:55b3:a0c6:e6a1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c162e3b9-fa81-41c4-d808-08d75c74489b
x-ms-traffictypediagnostic: AM0PR05MB4580:|AM0PR05MB4580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB45804C484A715A33E252A55FD1610@AM0PR05MB4580.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(13464003)(14444005)(186003)(256004)(4326008)(6116002)(76176011)(55016002)(86362001)(9686003)(8676002)(476003)(14454004)(46003)(229853002)(74316002)(6436002)(7736002)(8936002)(6246003)(305945005)(81166006)(102836004)(81156014)(486006)(107886003)(66556008)(25786009)(316002)(52536014)(11346002)(446003)(7696005)(110136005)(54906003)(6636002)(15650500001)(64756008)(66446008)(66476007)(66946007)(71190400001)(76116006)(71200400001)(6506007)(5660300002)(53546011)(478600001)(2906002)(33656002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4580;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loPqoc8H4dnZjxoHz0darn8PqsH+bm3n+KT59FuogOiEUQRtB0icDCjQxlSO/JSzTmNwg9MxE1gf1Z82O6tiMCJ6bSEu6HC6eCAd3bpj9sv5pCOP/i9A2Q+0bf73woBkZkduoDeNU3ILM/7o20mEPA2EJzyOPGa3AuscAGl8ClGfn5pLsraPkDGlJSrNNGQl1MoiiwrEOxvhcXJSHzVqfuWvaS6Qr24qwGO2xeRd6hPWxobLqsRG8FaeFdKBo8Moklmfyz7s3+79FjEA6ClhEy4nm0o7Si9uCI6BqE13LdUg7PPTl/K1lrWsdpt02xEKtpg6+jTqVxAwbeJieZXeYDRJwANveRElHfJR0qoya9JzQPJsw2Yh/asfKj1OR1mCR8Q3VVIGcmB4hT6TTyzo8X/tuyhTEKIT8ucIsqVOTPOCKoZyaHqgbS3rhaapp+lu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c162e3b9-fa81-41c4-d808-08d75c74489b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:31:19.9279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpAyCVCDaCRtzzQdc4uGN1YtzeJUc68nR7MLhqLhCd68MAiJQU0XHMZOuRIpcvT1iU+0eE0wnidBSaht++Hh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4580
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, October 29, 2019 6:53 AM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> rdma@vger.kernel.org>; Daniel Jurgens <danielj@mellanox.com>; Parav
> Pandit <parav@mellanox.com>
> Subject: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
> update events
>=20
> From: Parav Pandit <parav@mellanox.com>
>=20
> Currently when low level driver notifies Pkey, GID, port change events, t=
hey
> are notified to the registered handlers in the order they are registered.
> IB core and other ULPs such as IPoIB are interested in GID, LID, Pkey cha=
nge
> events.
> Since all GID query done by ULPs is serviced by IB core, in below flow wh=
en
> GID change event occurs, IB core is yet to update the GID cache when IPoI=
B
> queries the GID, resulting into not updating IPoIB address.
>=20
> mlx5_ib_handle_event()
>   ib_dispatch_event()
>     ib_cache_event()
>        queue_work() -> slow cache update
>=20
>     [..]
>     ipoib_event()
>      queue_work()
>        [..]
>        work handler
>          ipoib_ib_dev_flush_light()
>            __ipoib_ib_dev_flush()
>               ipoib_dev_addr_changed_valid()
>                 rdma_query_gid() <- Returns old GID, cache not updated.
>=20
> Hence, all events which require cache update are handled first by the IB
> core. Once cache update work is completed, IB core distributes the event =
to
> subscriber clients.
>=20
> Fixes: f35faa4ba956 ("IB/core: Simplify ib_query_gid to always refer to
> cache")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cache.c     | 84 ++++++++++++++---------------
>  drivers/infiniband/core/core_priv.h |  2 +
>  drivers/infiniband/core/device.c    | 27 ++++++----
>  include/rdma/ib_verbs.h             |  1 -
>  4 files changed, 57 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/ca=
che.c
> index d535995711c3..1d5c0df7dfab 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -51,9 +51,8 @@ struct ib_pkey_cache {
>=20
>  struct ib_update_work {
>  	struct work_struct work;
> -	struct ib_device  *device;
> -	u8                 port_num;
> -	bool		   enforce_security;
> +	struct ib_event event;
> +	bool enforce_security;
>  };
>=20
>  union ib_gid zgid;
> @@ -130,7 +129,7 @@ static void dispatch_gid_change_event(struct
> ib_device *ib_dev, u8 port)
>  	event.element.port_num	=3D port;
>  	event.event		=3D IB_EVENT_GID_CHANGE;
>=20
> -	ib_dispatch_event(&event);
> +	ib_dispatch_cache_event_clients(&event);
>  }
>=20
>  static const char * const gid_type_str[] =3D { @@ -1381,9 +1380,8 @@ sta=
tic
> int config_non_roce_gid_cache(struct ib_device *device,
>  	return ret;
>  }
>=20
> -static void ib_cache_update(struct ib_device *device,
> -			    u8                port,
> -			    bool	      enforce_security)
> +static int
> +ib_cache_update(struct ib_device *device, u8 port, bool
> 	enforce_security)
>  {
>  	struct ib_port_attr       *tprops =3D NULL;
>  	struct ib_pkey_cache      *pkey_cache =3D NULL, *old_pkey_cache;
> @@ -1391,11 +1389,11 @@ static void ib_cache_update(struct ib_device
> *device,
>  	int                        ret;
>=20
>  	if (!rdma_is_port_valid(device, port))
> -		return;
> +		return -EINVAL;
>=20
>  	tprops =3D kmalloc(sizeof *tprops, GFP_KERNEL);
>  	if (!tprops)
> -		return;
> +		return -ENOMEM;
>=20
>  	ret =3D ib_query_port(device, port, tprops);
>  	if (ret) {
> @@ -1413,8 +1411,10 @@ static void ib_cache_update(struct ib_device
> *device,
>  	pkey_cache =3D kmalloc(struct_size(pkey_cache, table,
>  					 tprops->pkey_tbl_len),
>  			     GFP_KERNEL);
> -	if (!pkey_cache)
> +	if (!pkey_cache) {
> +		ret =3D -ENOMEM;
>  		goto err;
> +	}
>=20
>  	pkey_cache->table_len =3D tprops->pkey_tbl_len;
>=20
> @@ -1446,49 +1446,48 @@ static void ib_cache_update(struct ib_device
> *device,
>=20
>  	kfree(old_pkey_cache);
>  	kfree(tprops);
> -	return;
> +	return 0;
>=20
>  err:
>  	kfree(pkey_cache);
>  	kfree(tprops);
> +	return ret;
>  }
>=20
>  static void ib_cache_task(struct work_struct *_work)  {
>  	struct ib_update_work *work =3D
>  		container_of(_work, struct ib_update_work, work);
> +	int ret;
> +
> +	ret =3D ib_cache_update(work->event.device, work-
> >event.element.port_num,
> +			      work->enforce_security);
> +
> +	/* GID event is notified already for individual GID entries by
> +	 * dispatch_gid_change_event(). Hence, notifiy for rest of the
> +	 * events.
> +	 */
> +	if (!ret && work->event.event !=3D IB_EVENT_GID_CHANGE)
> +		ib_dispatch_cache_event_clients(&work->event);
>=20
> -	ib_cache_update(work->device,
> -			work->port_num,
> -			work->enforce_security);
>  	kfree(work);
>  }
>=20
> -static void ib_cache_event(struct ib_event_handler *handler,
> -			   struct ib_event *event)
> +void ib_enqueue_cache_update_event(const struct ib_event *event)
>  {
>  	struct ib_update_work *work;
>=20
> -	if (event->event =3D=3D IB_EVENT_PORT_ERR    ||
> -	    event->event =3D=3D IB_EVENT_PORT_ACTIVE ||
> -	    event->event =3D=3D IB_EVENT_LID_CHANGE  ||
> -	    event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
> -	    event->event =3D=3D IB_EVENT_CLIENT_REREGISTER ||
> -	    event->event =3D=3D IB_EVENT_GID_CHANGE) {
> -		work =3D kmalloc(sizeof *work, GFP_ATOMIC);
> -		if (work) {
> -			INIT_WORK(&work->work, ib_cache_task);
> -			work->device   =3D event->device;
> -			work->port_num =3D event->element.port_num;
> -			if (event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
> -			    event->event =3D=3D IB_EVENT_GID_CHANGE)
> -				work->enforce_security =3D true;
> -			else
> -				work->enforce_security =3D false;
> -
> -			queue_work(ib_wq, &work->work);
> -		}
> -	}
> +	work =3D kzalloc(sizeof(*work), GFP_ATOMIC);
> +	if (!work)
> +		return;
> +
> +	INIT_WORK(&work->work, ib_cache_task);
> +	work->event =3D *event;
> +	if (event->event =3D=3D IB_EVENT_PKEY_CHANGE ||
> +	    event->event =3D=3D IB_EVENT_GID_CHANGE)
> +		work->enforce_security =3D true;
> +
> +	queue_work(ib_wq, &work->work);
>  }
>=20
>  int ib_cache_setup_one(struct ib_device *device) @@ -1505,9 +1504,6 @@
> int ib_cache_setup_one(struct ib_device *device)
>  	rdma_for_each_port (device, p)
>  		ib_cache_update(device, p, true);
>=20
> -	INIT_IB_EVENT_HANDLER(&device->cache.event_handler,
> -			      device, ib_cache_event);
> -	ib_register_event_handler(&device->cache.event_handler);
>  	return 0;
>  }
>=20
> @@ -1529,14 +1525,12 @@ void ib_cache_release_one(struct ib_device
> *device)
>=20
>  void ib_cache_cleanup_one(struct ib_device *device)  {
> -	/* The cleanup function unregisters the event handler,
> -	 * waits for all in-progress workqueue elements and cleans
> -	 * up the GID cache. This function should be called after
> -	 * the device was removed from the devices list and all
> -	 * clients were removed, so the cache exists but is
> +	/* The cleanup function waits for all in-progress workqueue
> +	 * elements and cleans up the GID cache. This function should be
> +	 * called after the device was removed from the devices list and
> +	 * all clients were removed, so the cache exists but is
>  	 * non-functional and shouldn't be updated anymore.
>  	 */
> -	ib_unregister_event_handler(&device->cache.event_handler);
>  	flush_workqueue(ib_wq);
>  	gid_table_cleanup_one(device);
>=20
> diff --git a/drivers/infiniband/core/core_priv.h
> b/drivers/infiniband/core/core_priv.h
> index 3a8b0911c3bc..137c98098489 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -149,6 +149,8 @@ unsigned long roce_gid_type_mask_support(struct
> ib_device *ib_dev, u8 port);  int ib_cache_setup_one(struct ib_device
> *device);  void ib_cache_cleanup_one(struct ib_device *device);  void
> ib_cache_release_one(struct ib_device *device);
> +void ib_enqueue_cache_update_event(const struct ib_event *event); void
> +ib_dispatch_cache_event_clients(struct ib_event *event);
>=20
>  #ifdef CONFIG_CGROUP_RDMA
>  void ib_device_register_rdmacg(struct ib_device *device); diff --git
> a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index f8d383ceae05..9db229c628e9 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1931,8 +1931,8 @@ EXPORT_SYMBOL(ib_set_client_data);
>   *
>   * ib_register_event_handler() registers an event handler that will be
>   * called back when asynchronous IB events occur (as defined in
> - * chapter 11 of the InfiniBand Architecture Specification).  This
> - * callback may occur in interrupt context.
> + * chapter 11 of the InfiniBand Architecture Specification). This
> + * callback always occurring in workqueue context.
>   */
>  void ib_register_event_handler(struct ib_event_handler *event_handler)  =
{
> @@ -1962,15 +1962,7 @@ void ib_unregister_event_handler(struct
> ib_event_handler *event_handler)  }
> EXPORT_SYMBOL(ib_unregister_event_handler);
>=20
> -/**
> - * ib_dispatch_event - Dispatch an asynchronous event
> - * @event:Event to dispatch
> - *
> - * Low-level drivers must call ib_dispatch_event() to dispatch the
> - * event to all registered event handlers when an asynchronous event
> - * occurs.
> - */
> -void ib_dispatch_event(struct ib_event *event)
> +void ib_dispatch_cache_event_clients(struct ib_event *event)
>  {
>  	unsigned long flags;
>  	struct ib_event_handler *handler;
> @@ -1982,6 +1974,19 @@ void ib_dispatch_event(struct ib_event *event)
>=20
>  	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
> }
> +
> +/**
> + * ib_dispatch_event - Dispatch an asynchronous event
> + * @event:Event to dispatch
> + *
> + * Low-level drivers must call ib_dispatch_event() to dispatch the
> + * event to all registered event handlers when an asynchronous event
> + * occurs.
> + */
> +void ib_dispatch_event(struct ib_event *event) {
> +	ib_enqueue_cache_update_event(event);
> +}
>  EXPORT_SYMBOL(ib_dispatch_event);
>=20
>  static int iw_query_port(struct ib_device *device,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 0626b62ed107..6604115f7c85 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2148,7 +2148,6 @@ struct ib_port_cache {
>=20
>  struct ib_cache {
>  	rwlock_t                lock;
> -	struct ib_event_handler event_handler;
>  };
>=20
>  struct ib_port_immutable {
> --
> 2.20.1

We noticed one Kazan report with this patch in additional QA tests. I am lo=
oking into it.
Please wait until we have more updates.
