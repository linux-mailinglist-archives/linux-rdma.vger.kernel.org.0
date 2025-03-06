Return-Path: <linux-rdma+bounces-8437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAFA55740
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 21:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A5173853
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A326FD99;
	Thu,  6 Mar 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ez1dqxS2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020079.outbound.protection.outlook.com [52.101.85.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CE42A8C;
	Thu,  6 Mar 2025 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291466; cv=fail; b=K2YKd1tNaPOaLVlpzl69i7kO83E5wiGCttK+3XiVOtC8y+ZNIukZkMVlrDE0J48DlAcRm5uy8igYmpjxQb9uDwNOZQFureyfILpAG6Ljn81RKeZclbSZHPEm0nc17k4yZyXPb0dZJVMJ8nndYW6ttyyTNDx4jrCoy4+JOyphjrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291466; c=relaxed/simple;
	bh=4WjAJMtWFaMjB7muZM8RBk1ae5fXy/AQ0qGoDs7nta8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sQGLsS0Sz1bq/pO1jYflARzIqMliIeEKwvpbXhbt0FjyiVKNvPHAuqJU09qbRZYkLAaWSUqzHzXuAiK/Dgiq3id5VA14AumOH/lXfAEODGl16mWvmrhQTzZZk1GbFlYVzsyBEaHWs8eb7GnGdajcKhy4KHR7zeAFEDYs+trSrRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ez1dqxS2; arc=fail smtp.client-ip=52.101.85.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p77NOaLMczDbYk3QiTUbJWntjlUI6aoog9aRy/mLytL16D/U0N0umi+ff+TLqU2h1IZTUT9XIGFD24CGl8AanpPv67Yvm9GIKNpGqPnXecpVAj2e/VIJwYyNtx+3gtITS7vDUdQMg+UWvXhrPWWvc/KJoDOCtptzzJIUhISMi6F3ilCXb/eRyv1wq8g2i4EOG8e7DEWnRdFKyyuThfHhKtOCUdzD1CN2zRG7WJfHs6W1CLX0kkDzWmlsibZ11o1vwqZDVUT6A0ccTdKf+z2nl698tr6dtmzR3NQ/iWWLiRYYZG/mtuFy2w1gui+43EBg4T7793QIZynvXC3XDOshtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR/+8Xfax1tScVYQlFeW328iBYgCAWIPk7uwjhH76tY=;
 b=LjLwRJmkGqMQEu9H/caYt2vaUTPMAzl5Q3UPy63Y6UDCuttFEak3GCyBE2JTMRcpUi6rTZwBu9RDqOZ9wmOlp+yCENtYoeDrUVrd2f6bOC37urwVS/qhx7iR9XajrbRw2ZnCEmy2ZLAaHfpgF8eoZbBfC7cEK3t2RyGQfG3QCkTvHgXiT8mbjWiIVIelbg5kcrrGCiMsrAjVUSG5WazLQijPua628c8DC8Jzb6mLU5FHgJikGpqTAjaWnsvsxtTkZN3vpLl88WcV/ZOE+AjW0IniCjzqT2Z5M+NPYUPvVvBZikNvi2HjTYBdgfhEJ7MeE55ME3vJ3nUtprL/9G1pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR/+8Xfax1tScVYQlFeW328iBYgCAWIPk7uwjhH76tY=;
 b=ez1dqxS2uG6k5ZLsS2BG6WaPu+V9GRzhKMOLZTlNUJI+nGl6mmqbo1m1xRQvDPPBnX7uwnpipwbkzNVgZ6yH2dXbCHyDLYl+ZfXI2CmHmD9PMF2J6GpXOO6mTR0wi94lKZ/zpOz6SP9X3eVq5z4HCI1tCJnIJS9kf0zriwMLI5U=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4208.namprd21.prod.outlook.com (2603:10b6:806:415::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:04:22 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Thu, 6 Mar 2025
 20:04:22 +0000
From: Long Li <longli@microsoft.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Konstantin Taranov
	<kotaranov@microsoft.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Shiraz
 Saleem <shirazsaleem@microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH next] RDMA/mana_ib: Use safer allocation
 function()
Thread-Topic: [EXTERNAL] [PATCH next] RDMA/mana_ib: Use safer allocation
 function()
Thread-Index: AQHbjtDXsCZovKPyy0SXwTjnDl5RtLNmiC1g
Date: Thu, 6 Mar 2025 20:04:22 +0000
Message-ID:
 <SA6PR21MB4231DCD3836F24ED596C0B62CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <58439ac0-1ee5-4f96-a595-7ab83b59139b@stanley.mountain>
In-Reply-To: <58439ac0-1ee5-4f96-a595-7ab83b59139b@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1f590687-fc53-4f7f-b94f-dd5d69bfcd84;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-06T20:04:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4208:EE_
x-ms-office365-filtering-correlation-id: 3245f7e0-ac27-4a4d-e3bc-08dd5cea1649
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u7aD08iiHKoy6UhHFgHtcA6AI6JOyWt3+6Xx8BhLQG6sD4IddQzM5/TCyFO4?=
 =?us-ascii?Q?fUFgTO7oCalb/nI9Hwpk5yN4euldYZA02yVWiIXsLfjo+cU2NJVq7OxO7Im1?=
 =?us-ascii?Q?sBEzTjmkhkM6ISp2XEAzMkf9lN/sxTifukZmxVkI2FAK+0KMq2uQcnu6t1FY?=
 =?us-ascii?Q?Nu6O75V+nwNgK+qJKIsgb5OE+tTryWpZL26USPu4uISWyZSea4AZ612ID2Uo?=
 =?us-ascii?Q?hEcajUcGKFCAxw7pKY9PAYHly32airaQeWyxHtqztUP/EC5hoKVxrZztVj6K?=
 =?us-ascii?Q?ml/Pumv9TwrUgjvuD/m8oF27E6vimcI4VSFHsCWvgBRxlKPdTLsx+Hz64qx3?=
 =?us-ascii?Q?6NLOf2J7LJlYveFY1wAtz+gHUG0+jF/zagH4z1oDUJ4whruQMcAD24fp9x1X?=
 =?us-ascii?Q?kUDzPTY0qAFKHqCIk2aYsE7DhjUTF2mf/eS9oKbiYSyn38kNEA33XPfTLq6P?=
 =?us-ascii?Q?ZIf8w5qz6of0QZ4V5+DNvdpx4O6GQf20b44VkxqJkPE3fyFfDn/V4csvHVRa?=
 =?us-ascii?Q?zL95LN8y2fBuItmFLZOA7UQeVRWwRONQc7tRVRYvymhaHnakWDD2w0C3M5Bn?=
 =?us-ascii?Q?tuxzxjm8JgciDGuFJojnn9RhLHoxcDcdseVvXweFNbf67C89xPiYgN8BwQqY?=
 =?us-ascii?Q?PxwO2y4chOjESAYNdUWjzHmwro4Fe2VWtbG3hVCsjuoFEP+zkq1niA3tiJVb?=
 =?us-ascii?Q?XbExzZCoYg1J8Ag3BjKlV0SgSH3jHGrii9gcvj1cmGWJw+g8i0wWmEYDv7wZ?=
 =?us-ascii?Q?LtDlthXl4HAhdG0870KwqlrtDbNp+vl5pWYoBKRojXY278yJWThBErJRvNNw?=
 =?us-ascii?Q?L7PPoEI5Ut/5FXLZ1ObDRUJLBDdDHs5o1ZjOmU4jE3N8G/KZrt0q9kOnJT+8?=
 =?us-ascii?Q?r/rKRUgMO4b9tRw1638ju159N8Yo2VbxM4gWrk7kwBaRTrbzXE4WxA7sX35r?=
 =?us-ascii?Q?rBTuOu4a2W/LpxvctjinEwDRV9cetL6CXOgKlMN2gfKWdaBf0ftKJGljuPA/?=
 =?us-ascii?Q?srUB17petSHyVzoIBbTlvnQp+xo7DufJK8NG6KdIAFjQ4kI7Z1yNycIGD83K?=
 =?us-ascii?Q?l4SoSZXJjDx3B/XbEUwO00ccxB/WIwu6oaooWI1A5XI+K7xo3x3jCCDLI5q1?=
 =?us-ascii?Q?+8vrMKAO6kQ1sTj5i4rHR7XSWqFoCL690B5NytV+XHR6eERn3EGj783beKiL?=
 =?us-ascii?Q?/gAVyJpFJYp/53SaPei+1xetdAgtGpo9Ad6POQAh7Z+tU/wR7cpPLS6GTYrf?=
 =?us-ascii?Q?Unan03xtTpmigHLinmkz/fdYtLqlamW+z7ndVeOmEvLGoGAxTUoyYf71NHk7?=
 =?us-ascii?Q?IDSobWb3cY88qOP3k/7KYLtxHt8jafSDk+6aDBzL1ttCIodv/CnWXQJUiXFa?=
 =?us-ascii?Q?xo8jFuaX8FiGcdizqCVpmk2y7E+vjWW87pJcucsMCvODcLOtur/ANZgXIijv?=
 =?us-ascii?Q?oBvnq2XIUgyFYq6g1D4GF3msS3GtDpcC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7V8hvBZvMl3apjJQKaIZiSz3sFuakQiDSH31tz0u7w8F1M0L2PLSL3jKji8u?=
 =?us-ascii?Q?FJ8MGYd1PSivKCENlGOHh/OFUKK+kyfpuQt0eUnF75T1bW0oXtA62i2thuNs?=
 =?us-ascii?Q?LHW2c7fC0vhbLfwq175s8hwQejqUk8cy4Moc5fdjPuCqTinX0MwCIjrMgEAq?=
 =?us-ascii?Q?x62JPyfwl+n/6NDEP8tw4JFjEnCxLLomA6WKPW8XVv3GwsGqyj5ffksyTEJl?=
 =?us-ascii?Q?fgAmmeBSZF0Hq3ZbtmCZT68IBYlYbBR3seKWNhpbuTdnt64B3pyMZetPKMwZ?=
 =?us-ascii?Q?Yj1xdl9XS/lnevzzPikOfiNVPYpCpSrGbUkSnB/j3LsN+Jzt0DasRAX3s2fN?=
 =?us-ascii?Q?AF+4nldQsB5GJkp9h62Gh36O9FeaupiCB34y0gxnbPzVPRPf55XVBAklC/EW?=
 =?us-ascii?Q?MR5rm9y+2X2Wv7RN1MrFOGdTry3CkBAgV7USEtF2stNfyB8tTeV4/2DD7Y1v?=
 =?us-ascii?Q?CoqNGwbeiHUUSOcUogSXtf/bk8RKN9TZnSH8TM+t99keVFWvtyfwLm/k1Gey?=
 =?us-ascii?Q?BBWctkQsh7/IOPFN0xHFRWwLxC7TRLJrGT0zamssbk6f+taxnGsKFljs2XUL?=
 =?us-ascii?Q?EZkUSx9f5mDtBr01PVobVPLBFDahuPJ73hJrRz5krsy2YHeUE8A7eFki6lnA?=
 =?us-ascii?Q?x7DbjNobFZm2YfypdkbJ9yt3Wsu7DtPhjGAZE8CUenNNeXdf9oIC4qGBF03u?=
 =?us-ascii?Q?eNYoNl1I4DPo5bwwK1JlKIP2tWBbJE2BYDvnXBe2ydOu7677cM286SdMyJFo?=
 =?us-ascii?Q?wpIip7Y7olyxsj++m1+0q0EVrO5fGPSPJjGY4jXB99kN1G4LYfRBCZ6Bb7hf?=
 =?us-ascii?Q?NRASAqfA5G6HohopZ8tPXgVRw6pMTfJV24bQWEibLKoFw4xMiIK3vILwtXcP?=
 =?us-ascii?Q?7b35FJDacvja8hDcBEASHj5pq1RGixD9ji6FP48wa1L+EW0sqU8xAJwu8A12?=
 =?us-ascii?Q?dSsGuoBxR+zWXzCQiI9iIIDOYqGLPtIB/9GhJPjxLpHj0KKjA6qRBaS2YYWy?=
 =?us-ascii?Q?yDz3io/WDdfFIQSS3GAFJUEWN8mb/uJjRGoQiHyZZqG32enV5ABWLY3LxP1R?=
 =?us-ascii?Q?DhD7xWvrWnNwZsI2+mq9tB4MpwAvmxMD3HZlFihuFD9Nk9GRmoAM1epT6/RG?=
 =?us-ascii?Q?Ba5A2mcSqG68ugtnhWuSAkdFVhKRVg0smRrA1OlylApUwzrrxMaH4kb01N45?=
 =?us-ascii?Q?M0GpjFdHK7O9h+kgfQo+rofv88Dfq70lBjwuQ4a3Mv+R4zYZYwTN54T8Am/a?=
 =?us-ascii?Q?JD/okTg/Q605FRKzUcXVBj8LwY9DfyxfIi7PkvXlzvOhbEZtQnet+PL3c9Ek?=
 =?us-ascii?Q?7DfmsCDOnLUQ0CdYfsIS70+sdR8XJ6qd+HKd2SiHOJDdnrad+ryuNfZJynA5?=
 =?us-ascii?Q?yzCiA0KIN6KnsICFoIF2vntP4W/jYoR0nZOalMaYWhXbQMTiObxaxgD8evXn?=
 =?us-ascii?Q?G/N7tW4+FuC6tvTddCUWyWoO3mwVGudRTozzeXcZmDPXhIDSgAuIBLZrtWQc?=
 =?us-ascii?Q?Xy6/sF/F0hnITkvuF8NEv4QHRHxKcg0spto50v7Slmnp3t5rLMiHSSqirsy+?=
 =?us-ascii?Q?HQq/n5IgtV5w3ync0gBx0sdEw5UfYTv9Rh6Urn4/?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3245f7e0-ac27-4a4d-e3bc-08dd5cea1649
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 20:04:22.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6+0wJw+SjdReoqJc/VCT0o8PH9+Y/jGDPEOP7Xqi3kFGrODnzGrB7t3Nz/Sh0NpEwTcxvzeUqHC080xa5IrVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4208

> Subject: [EXTERNAL] [PATCH next] RDMA/mana_ib: Use safer allocation
> function()
>=20
> My static checker says this multiplication can overflow.  I'm not an expe=
rt in this
> code but the call tree would be:
>=20
> ib_uverbs_handler_UVERBS_METHOD_QP_CREATE() <- reads cap from the user
> -> ib_create_qp_user()
>    -> create_qp()
>       -> mana_ib_create_qp()
>          -> mana_ib_create_ud_qp()
>             -> create_shadow_queue()
>=20
> It can't hurt to use safer interfaces.
>=20
> Cc: stable@vger.kernel.org
> Fixes: c8017f5b4856 ("RDMA/mana_ib: UD/GSI work requests")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> There seems to be another integer overflow bug in mana_ib_queue_size() as
> well?  It's basically the exact same issue.  Maybe we could put a cap on
> attr->cap.max_send/recv_wr at a lower level.  Maybe there already is
> attr->some
> bounds checking that I have missed...
>=20
>  drivers/infiniband/hw/mana/shadow_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/shadow_queue.h
> b/drivers/infiniband/hw/mana/shadow_queue.h
> index d8bfb4c712d5..a4b3818f9c39 100644
> --- a/drivers/infiniband/hw/mana/shadow_queue.h
> +++ b/drivers/infiniband/hw/mana/shadow_queue.h
> @@ -40,7 +40,7 @@ struct shadow_queue {
>=20
>  static inline int create_shadow_queue(struct shadow_queue *queue, uint32=
_t
> length, uint32_t stride)  {
> -	queue->buffer =3D kvmalloc(length * stride, GFP_KERNEL);
> +	queue->buffer =3D kvmalloc_array(length, stride, GFP_KERNEL);
>  	if (!queue->buffer)
>  		return -ENOMEM;
>=20
> --
> 2.47.2


