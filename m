Return-Path: <linux-rdma+bounces-2037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631968AFCC5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F5628320B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387823F8C7;
	Tue, 23 Apr 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dcW7a3GI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020002.outbound.protection.outlook.com [40.93.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF273367;
	Tue, 23 Apr 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915755; cv=fail; b=gZ0ntIbB92tX10ELGiAuskBABIZXQBYlCtaK31GKwPa1/3ZpoW/i8pk0iz8xayZ/OpiuwZgYG0xbZBfU3jGeHiRoDrXHOgspvpMym+EcTbzciv3JEyGkvNTWiZRYI6pXyyPJFyV64NpkgIUDecxcF0yzTd1n4V0WAG5dIYunBEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915755; c=relaxed/simple;
	bh=MCi+scovqnW4TU3ORCymyhY5tQpSfVUTWE89TDOytqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spyG7DU8HMEeha9i52+C7/GEA+2GytZaKWXaDgz2ROR9XWaaHbyFdxb0WEFBc65elgaQ14iC1sC+hnI7IPCoUWJO7kmcbgqKNTXI4Dc67ntsnSjjy3RQFiDEG7YtqsfK5FJXtYNnTEka2nWLl9MIkIKx1cvxq7C2zTLWpwtUeiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dcW7a3GI; arc=fail smtp.client-ip=40.93.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDu+2ldmSNQK8Etw2Bp2mK53Q6frW9opa7M9q2uLp5uhoScITJcfRpHopxMg4Ksdbkq77ed2uOml6mFFi0+IEu83CSjbJaEnnraWSQ1YBI+BrmiswrfIH6fRmnqygfv7Njn/JJueV/yi7jCdVhZ+7NjrPslRwuvcIjv8HdAVHm2DJuAopzSjfmCtyu7c8P9iS9T3KCy3ak4xOxhTrdfRTf8c6CFD7LWg/dyUk94vQorwssqiylRvj7/2XZvO2aU/qHIUI47ea6e/BrvjW7zYgl7Vf34Gr4xWqWTV4ONnlCq7+4XOcRj+4VXnQh0jFWY1W7g23kA1a8ujats30omjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIbttwhqkmA9nntEN+mEYlXGJmY8bSneVpOYJE5W9Pk=;
 b=YTniRMD9hZkeh/uAIhVS5WpD2+v9Hq7ueQbdiBSXp3CL1waVZlRhX12QQDky7bhMZoBVDcCnU2KZRRJUAXqcKMOC2C3Z00NMtNp5OyeZmaVcFUyPS5pPccVrNTAMsNKvKKy8rchvhTmxRhr54jL3LwSngWZWZDiRjVVnivqHIpaBoYxNWjcLQXwBpjqGwlMtqlbArMr8JKmanil+qL/7hoxMhhbsoJTQxOhggf3A9jK0loTlWEUh1I5/LEDuWR6eXDrch7fDnrx3w9Sn33oKzYcZ7f4fWZkqutw05n8JPnVW6WwNiVJ3TLOL2kYsj0s9PFD2xYWAya3H3gD2ZsEk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIbttwhqkmA9nntEN+mEYlXGJmY8bSneVpOYJE5W9Pk=;
 b=dcW7a3GIVcSNfpO2OJX8Cl1+ZlOK4fwrzJVo0jLpLPZT459lIVczLiHiG1qNC5k2Ygowoww3iowkNqmZaHwH4LBDJyH7Ho4pc7gcz5Z1eK3IkEAV7C+UUisd5jMq9H94ze0o+VNC0d7hiN9MEitKY84BxJ2YZVUJERUU82SnjfM=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.7; Tue, 23 Apr
 2024 23:42:30 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:42:30 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove
 cq callbacks
Thread-Topic: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove
 cq callbacks
Thread-Index: AQHakbDF9CkxsQavdkOVNDu9IJalsrF2i3jQ
Date: Tue, 23 Apr 2024 23:42:29 +0000
Message-ID:
 <SJ1PR21MB345799F95A00FE627B176598CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-5-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-5-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1642394-32de-4c1f-b152-92f2f14127fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:39:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BY3PR21MB3033:EE_
x-ms-office365-filtering-correlation-id: 985a586e-4e85-493c-f25f-08dc63ef0a45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sUSVNbsLlYfdoP0SqoHFLjgdLa5m+kZx0h7JCjdVujW6NeT3oy1EpeJ0kep+?=
 =?us-ascii?Q?qGPD50MRO4hl42tcDWi6bQtM3F+n4nNDQoHA85fACOoV2rx1VZ6tzeyXfZlK?=
 =?us-ascii?Q?0v+x4Iq1nOjOlj7D88mu+PsKvpoSNt17EXxEpV8SMhV3s4Yw4+ig0eiqKPec?=
 =?us-ascii?Q?GsGowM38PjyK5JqFtrnQYj9+5M/AyeoNlrV79EmhXWbDo529zNaaimZC8LRF?=
 =?us-ascii?Q?D8FvVFJtIKCpbrhhuha/LHF0Rzeik0Uc1jJ23SJu3Z22+/opY79gEG9f4Ra1?=
 =?us-ascii?Q?CPiMjBmRKGCwrahDgaHZwKA/HzmUyUNGjmz5bLOeaCu6H9e0O4vDnYw/MCPa?=
 =?us-ascii?Q?jbM2+xrUkpgd7LgjeaCuPITFnHNqVcM5lbnY44b9MuRGBuwj/os+bYOKJ2VH?=
 =?us-ascii?Q?ewwQyJFLGHS0FAGvscIiHmbe06Jh3TDPAOcq2OBOFsHlqNfxh3L1SpTVvZLc?=
 =?us-ascii?Q?ooO+CdfqVM1tN9gw/+nVgfiQVDCoN5/hjfBZWcA0poAIMsHkkREsGZmjsP7p?=
 =?us-ascii?Q?jeTFcoJlcmdbcIR1e0CAtXBLbOM+dFQtfO0JUz3BTu4DGkrrlv+ZK5m2s+3n?=
 =?us-ascii?Q?44P7XrLxw/0RAautL3yKy+f1YfzIuBP+yH4gUHE/ukT2NpJVkJAxq+GpgeCG?=
 =?us-ascii?Q?PnM+z+yIOlO7d9a865lErr/Vn9+b09TSRHCdf4kirwIZWUaE+mUBKNf99P2O?=
 =?us-ascii?Q?RuEPikB9XIhIoEShW+41fijczn8O2XubWfK/iSULmLZvjkNVcsYeQkMDK/lA?=
 =?us-ascii?Q?TNgSC9zWre8TIR+eVlp4IMG1ODGXacvle1uyRWtcYh7xgKJTc/1v4nahW9y+?=
 =?us-ascii?Q?M+NXiXE0NOJpf3k9THL6LvAenBWxuZMc2zL3eQ2MxMzlzq+ufiPesfA7Bt52?=
 =?us-ascii?Q?sXO+BYlY3ypNT5QXBV+zQO4kviaP5D7ijYNW4eGtTiBrKWs7ZWOixfo+HNN9?=
 =?us-ascii?Q?pGinwvTjZpuRkIeKVyz1QwghLXhakwbAebBV1A5UhROOWeGR5SHeqUB9SGyd?=
 =?us-ascii?Q?PVWoovWkB4ztmRAEhRmpSdlpCsSoQfCaCx1cKFj529Qk5SE+XKpFl4Mwj0ZP?=
 =?us-ascii?Q?7R5nebQynI6tZ4hBojDbnk6omqSsxluipQvCHOYJw/9V287basQ9Lo4ivkeA?=
 =?us-ascii?Q?DHEtO39vwHdcSWA4/fGrjXtvL5iq2h0iQoC6E/iACuBHDlS+2sW45mMeuPZu?=
 =?us-ascii?Q?b/fma8PsWFj+JDa8YowkiMearXZGlRFgymI9yarxS6PVVPJ9qjuQEGW6X587?=
 =?us-ascii?Q?ImbOjck3NoYcHMODlT6Q/ZPeHNn6WZpBSpEwtc72u2ndtgcNnKWnDqTGeotk?=
 =?us-ascii?Q?8uUJRBdBbcR7MTgA9F91OfnTWFvrwAq6DFSnKXJLpga56g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dg8LJxa9XYgHQwhWaaMTFWZ91So8MThqFDW9hy2GbKKG347ay6d1YkgrP1W/?=
 =?us-ascii?Q?BwmsIR/XU+4xegUdXBfbHNv7nED497w81I+FasOARPlVtLwKblvuWt6rSsN1?=
 =?us-ascii?Q?vZHfAqXzUGoZ1HONnpD2IFStXFexp6Ekx4wEMA6mfd572idSEuT/BQLHALPm?=
 =?us-ascii?Q?MyM3Cu0OVVPRQESXkYD6rMrRA4NND3pgOMTmCO6RCWKz44p2eTTsx0GzL4Tm?=
 =?us-ascii?Q?DIav0vb9uXldMqsc2kyqyccKcfRn1i4b24chBXjq0oAg0m7X3l4SJPQ5PzOU?=
 =?us-ascii?Q?bjHnFtU5k2odJMAhXm9cpjwU3TyhwzHNpSdDdIKpkn3Ofs1XH7JSJBxEnTPD?=
 =?us-ascii?Q?I2NcoXgbfGJgZV7c15F0bQZeYRDA7fQqWFFUgAkV1yBvHmA/kYRRBGkShdtS?=
 =?us-ascii?Q?xIQhpKp4kvaLM+7eYZMxDC7Qps6ARikXeNRfeqLOYD1DtUOrFgsHXc8MDUyv?=
 =?us-ascii?Q?+DupIc2ALAVdeA9Vq24YOqnvDNUIrFHfumA+tSG26sbKWs0EbB/8cWVjlYoZ?=
 =?us-ascii?Q?8ObMq36h5nLFnVlskfVmKAjPNqQxlI9oAY+6IPLUX+Sv58XkGagIf/guWamw?=
 =?us-ascii?Q?vUg0DGZd2Pfk/g6wZSTszWFxzbT5hRN/3l26jVQ6J3j0qZ3dKbFLXaYvSW5x?=
 =?us-ascii?Q?SKCYvP1OYedDBY+fuWcfc76k0FqupHhX1A1WZYzfQOpLYNRKqldk5aKKzf0G?=
 =?us-ascii?Q?DN4Ex6GxyMyPURKqIWGeaodz2t2WuyrGEN7ieJ3NLYbirf0u70QLxFc2Iftf?=
 =?us-ascii?Q?HqRpl/r3BnWv60ehaE87Gi8wX3Yb1GrmyYwSosgQ3bd14IgHJSUgzqKcNG9+?=
 =?us-ascii?Q?bACxIEjCrRikIQqsfeldLscNS6MPdvVLuQ9r7zNCc8KrvVVegejrPPM6AYSO?=
 =?us-ascii?Q?DXzIpu8VC+I4yPPpDKDcxWyncimWKozaGHWeDxHbGxBEco7MOjhbgS0Nb/0/?=
 =?us-ascii?Q?I5EgFoV6p3/g+H8fUSjZbz69HCZFU2YcqCSz2ElTgc5gIw8F/EM8mZgcbyxm?=
 =?us-ascii?Q?Gkeb0Cl14p1V+oj5KeUXoqd7/Dswza8quNqBSHFkuB6+uzJ+6qcnzO4okf9r?=
 =?us-ascii?Q?ocOcH2sHA4xPRH7CkBL2AKoeT8PeZTw7GtOyHHEmNpAaVTx5GHoZTsFYJ2IZ?=
 =?us-ascii?Q?Osx0g6AyW4b0mLUyvEU2Usl3Pv7lgxwbPs16DX6OlEI1p75MlR7j9/PfweWm?=
 =?us-ascii?Q?R38ir1M9E1gnkXAsmrWXuykzo/MflAH3da9irC+xSEmAqSGlTaT5VR46/b0T?=
 =?us-ascii?Q?EtQW6EBSUdb4pkEX8JG4CcdKfeCrPWGgZ5L2Ed2e6OHJcVdjMtdMKlIH3rrF?=
 =?us-ascii?Q?R8nR1JJAtdhCRADZEXZrcVwizcULi8DNucFC+n6p+JtX1y0fvMNdiA/W/o4u?=
 =?us-ascii?Q?QsLkTbc2mAcMZhCf/XN3K+WFYkpU3fJc6vArof2U+H4SQZN1s8umnlPjj7uW?=
 =?us-ascii?Q?YJRoRas8O7uDGya4ZQMv/rEEwDm8GwvhQq0K2pYMaA8NUo7+rJEJUJ69uWEM?=
 =?us-ascii?Q?GPA11Aqw1YXrvR9hqs1CQCdUce9pFzDGn/vSte1KAszmDQcXym2/LUlc19/X?=
 =?us-ascii?Q?3EhMOFoBbJPt6QkgLr+aMHgptjRukhQ20V6w0y4L+fNxi4MnsxIc2UP8o5Pn?=
 =?us-ascii?Q?8Im94Nt4vp6+IEcdn2l5Vg61m7lOKxSYdDdYDih5OmdV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a586e-4e85-493c-f25f-08dc63ef0a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:42:30.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/srvO5QHSfaKHCqNRU55KvflAcgMOhqh8COqbzyscoHoMs+a1SRG4CwY0x/rpDkUnDIEwIOhdjfusbuFDwuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR21MB3033

> Subject: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to
> remove cq callbacks
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Intoduce the mana_ib_remove_cq_cb helper to remove cq callbacks.
> The helper removes code duplicates.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c      | 19 ++++++++++++-------
>  drivers/infiniband/hw/mana/mana_ib.h |  1 +
>  drivers/infiniband/hw/mana/qp.c      | 26 ++++----------------------
>  3 files changed, 17 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 0467ee8..6c3bb8c 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -48,16 +48,10 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct
> ib_udata *udata)
>  	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_dev *mdev;
> -	struct gdma_context *gc;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev_to_gc(mdev);
> -
> -	if (cq->queue.id !=3D INVALID_QUEUE_ID) {
> -		kfree(gc->cq_table[cq->queue.id]);
> -		gc->cq_table[cq->queue.id] =3D NULL;
> -	}
>=20
> +	mana_ib_remove_cq_cb(mdev, cq);
>  	mana_ib_destroy_queue(mdev, &cq->queue);
>=20
>  	return 0;
> @@ -89,3 +83,14 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq)
>  	gc->cq_table[cq->queue.id] =3D gdma_cq;
>  	return 0;
>  }
> +
> +void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct
> mana_ib_cq
> +*cq) {
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +
> +	if (cq->queue.id >=3D gc->max_num_cqs)
> +		return;
> +
> +	kfree(gc->cq_table[cq->queue.id]);
> +	gc->cq_table[cq->queue.id] =3D NULL;

Why the check for (cq->queue.id !=3D INVALID_QUEUE_ID) is removed?

> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 9c07021..6c19f4f 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -255,6 +255,7 @@ static inline void copy_in_reverse(u8 *dst, const u8
> *src, u32 size)  }
>=20
>  int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq
> *cq);
> +void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct
> mana_ib_cq
> +*cq);
>=20
>  int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev,
> struct ib_umem *umem,
>  					  mana_handle_t *gdma_region);
> diff --git a/drivers/infiniband/hw/mana/qp.c
> b/drivers/infiniband/hw/mana/qp.c index c4fb8b4..169b286 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -95,11 +95,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp,
> ibqp);
>  	struct mana_ib_dev *mdev =3D
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
> -	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp =3D {};
>  	struct mana_ib_create_qp_rss ucmd =3D {};
> -	struct gdma_queue **gdma_cq_allocated;
>  	mana_handle_t *mana_ind_table;
>  	struct mana_port_context *mpc;
>  	unsigned int ind_tbl_size;
> @@ -173,13 +171,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>  		goto fail;
>  	}
>=20
> -	gdma_cq_allocated =3D kcalloc(ind_tbl_size,
> sizeof(*gdma_cq_allocated),
> -				    GFP_KERNEL);
> -	if (!gdma_cq_allocated) {
> -		ret =3D -ENOMEM;
> -		goto fail;
> -	}
> -

Why the allocation for CQs is removed? This is not related to this patch.


