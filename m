Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D145AE0CD7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfJVTz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:55:27 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:64837
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731806AbfJVTz1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 15:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNtvBEe0TqSFpRM4vKzrerWORMUBqpX2M0flzXXf/JjlsJuc0xOnxcnYiRBH1pUHkisEsTYqD2rkxfun+WLklXvk6ulB/Uu8RpC1+Y+f8+6IdPOgqg9rBRql/Kx/ZeAMAJQ0BBoBia2LXRWvSBtvV6KIFgsFz3qwIEQ+htoqHpZOQ7a51hkuAQS1yiZeVuFq35+vWqyDX6atCibUPDqFuQvJbXXwxkdFFMSFE89O6qrtIfY74QxTCO/t3nCLy1V6v2Vl7o2UXY/985aRPtXbPODJkqdi7qG940moQeps4ENRQ5G3mxb1UMgo7erq9X2kUmy+xB9ezMGtzLG6SbCARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftnz+zeol4bHSlW+ojayleRTyXRE6X0jgau78jRe7c0=;
 b=TxqE01Yc6mjRMhqLZRhHXiFBT4WcZw1mkn+cXfc8NsfbNGypRCzQetsDA4tfUNnTzh5U8awrNtboQTHeH9j7ycp1pDeGxsYUrbxsdJAKVHPFOKUBe8ZjzTh1KWikw8fbBNw/fV0VmLpDs1wH2sn+oKbY9CIdPJBdhK6drnX7TrWwL+wdLcjk/HSZ2vRbC3heU8B13FogjFJdknD/O/MdYjObCes/Yi9ldKP8zpx/OnOTpyviF5EUtA1DCzp/eB11FyjHgPBevjDkhSZ/QM+S8l3/I0CTI0gkHO8VR3sbg/CdPH/YQntZdahjGCRiSQZl410mWx8OiRlcAbc1jFqQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftnz+zeol4bHSlW+ojayleRTyXRE6X0jgau78jRe7c0=;
 b=NRJFEMKFXD1EBN6G9VTCWnngFCINL/tRMmvqlS3GYP4ll7rI2Gpj64mPHQi/UZLWt3nY/YdaPsyuyVNKKuVlfXvlgHizTo3LLs/QNnFw49eInyON2jYCuHBuizQpg+UDYtrqj3DVV2v1e0lHFKDIgcs4/eqL3ERaRMzcTUKQx8Y=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5072.eurprd05.prod.outlook.com (20.177.52.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 19:55:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 19:55:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next 1/3] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVhxM94+KDX9EQUkqFPNNVbTrJ86dnFxsA
Date:   Tue, 22 Oct 2019 19:55:22 +0000
Message-ID: <20191022195518.GO22766@mellanox.com>
References: <20191020065427.8772-1-leon@kernel.org>
 <20191020065427.8772-2-leon@kernel.org>
In-Reply-To: <20191020065427.8772-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0040.prod.exchangelabs.com
 (2603:10b6:208:25::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 605ab514-7443-4994-ee13-08d75729c5cc
x-ms-traffictypediagnostic: VI1PR05MB5072:|VI1PR05MB5072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB507277513637F6C49CB59CF1CF680@VI1PR05MB5072.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(6486002)(6916009)(6506007)(76176011)(25786009)(54906003)(66946007)(446003)(11346002)(102836004)(26005)(186003)(229853002)(33656002)(486006)(2616005)(476003)(4326008)(316002)(386003)(7736002)(66556008)(66476007)(66446008)(3846002)(6116002)(64756008)(86362001)(305945005)(52116002)(6246003)(36756003)(107886003)(99286004)(8936002)(2906002)(81156014)(81166006)(6512007)(8676002)(5660300002)(66066001)(71190400001)(71200400001)(478600001)(14444005)(256004)(1076003)(6436002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5072;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4u3PVPNZUKFES13rUoLjT4lRbXCULQ67zPMlaXlrEqO3KqOf7zr7gXW56OEUtPpe43Lt6q3h2nGtDg7SlmNx9Ihd2kpPDfs3i3LrgRbwvoG+wRuRk70/q3atH85IviMI9tILv1CfU6avIbwdzz1Gv7vA5ahPiljPQ4iXAuqk/fktSET3RyEGWyS0aOXB0qwpNt9HSRQMSwrM17KtUvZ/eWF+TOpWZWBs89Azl1KcIyC7GpfW+kjpSyCSmEMrFBtgGMZa4q/0tQdczTVrLlYFiECc10vz9m9hDQ2XIhxC2V7cjIECVwwAMHhLTRJEhBafhocR2jGs/oXQMlAy1VilmR/aF8d/LIpHPHpcp2oayZbcP75jQhDvfZF+jxtZ3HOSmOf9eIxXEe1H8zGErDQskxIpQAVH6IDogoezLX+hraJwBEmBBBxqtBSOmplRv/pv
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E501227CDC9FE489624EDEB583D8DB4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605ab514-7443-4994-ee13-08d75729c5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 19:55:22.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9b8AR0S/SOBdkseBm8M5bW2/uE55KUubjGfo/qcuYSQ0Vs8TvW7yyeMv+4adl/F7wYB1dNM6kCErny1B7CLxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5072
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 09:54:25AM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 2f89c4d64b73..e9ab1289c224 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -1951,15 +1951,7 @@ void ib_unregister_event_handler(struct ib_event_h=
andler *event_handler)
>  }
>  EXPORT_SYMBOL(ib_unregister_event_handler);
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

no kdoc for this?

>  	unsigned long flags;
>  	struct ib_event_handler *handler;
> @@ -1971,6 +1963,22 @@ void ib_dispatch_event(struct ib_event *event)
>=20
>  	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
>  }
> +
> +/**
> + * ib_dispatch_event - Dispatch an asynchronous event
> + * @event:Event to dispatch
> + *
> + * Low-level drivers must call ib_dispatch_event() to dispatch the
> + * event to all registered event handlers when an asynchronous event
> + * occurs.
> + */
> +void ib_dispatch_event(struct ib_event *event)
> +{
> +	if (ib_is_cache_update_event(event))
> +		ib_enqueue_cache_update_event(event);
> +	else
> +		ib_dispatch_cache_event_clients(event);
> +}
>  EXPORT_SYMBOL(ib_dispatch_event);

It seems like there is now some big mess here, many of the users of
events, including cache, acctually do need a blocking context to do
their work, while this function is supposed to be atomic context for
the driver.

So, after this change, many event types are now guarenteed to be
called from a blocking context in a WQ - but we still go ahead and do
silly things like launch more work to get into blocking contexts
from the other users

Thus I'm wondering if this wouldn't be better off just always pushing
events into a wq and running the notifier subscriptions sequentially?

Jason
