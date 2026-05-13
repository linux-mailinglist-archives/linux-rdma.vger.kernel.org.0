Return-Path: <linux-rdma+bounces-20617-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCiDItP4BGpuRAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20617-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 00:18:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8953B5E7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 00:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE973048DFE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D023CE080;
	Wed, 13 May 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cbx2AVZr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023097.outbound.protection.outlook.com [40.93.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861303CDBA8;
	Wed, 13 May 2026 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710512; cv=fail; b=szGTJm1fixlSWFFymAqZGxnT+N+aETF1jOWPPyEahN1JiqJmCmcxWu2qTCpqZAb94IuLYDr/0PShT1/WXEx8PWjSJmUSsxacFtsjPz0II076VJwZcIuqAjZ/RTwjT3qyzxGNCPZmJywKKChk3F1gZPd7qGUv5PG6cS3sa5sZby4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710512; c=relaxed/simple;
	bh=xvTk56pAG9noo8/pPHP977skkAFqeJjlP2ak0S7X/6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JHZw0AHZuaMkcBhzrh6hFMEEYoDw4R1H0M3I3RZeLy3wnu0lDBmSZPd14ZtV8AqkholwbKVjiBt+44giDd0XybMnYl59l6VhQCP29xkTA4CFsGgoySs1VYEDCLFhg7Vj9kKTSR2kE/cbQTkgTBnlG9jhod+nlq+Bu44wEwe4qGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cbx2AVZr; arc=fail smtp.client-ip=40.93.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxT6UxIhVbHOOTXxIrE1j9cMIqJo1XDW1b2IlZJZWUUG0wTXeo4idAi7iQZ9hC0+LtxsHVwaPMibAzZbcVceOTTsddUO26zdTXwaUIaL0r6V9R/j8SLBrlCcd5vOYZ1QmuWAeizv3t1sQ9xYfX2Tj2RXcUiKVkldk3bmke4FgT5WHNjgP3HvYyO+HoXC9dziy4p6BFsHI6iwXOMB58gujtHy4bsWRG0oufW2/ARPzlnVS4tgWrVyZ49qy0F5ytOeKSi5ny6wyjG2hmPAveyZ5N4oQO+y0F5kQtnNG1fpv499GPNzdP+Ndzw1MvWyUXAWZ29hHQVPhc4GrG2ce+qYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DysQYTtBBAqIzWp28+0AX9DNT975mxs8jjgh2YhdrUQ=;
 b=eTAEhq+Xj0qZWPw4Vo48xgQXXEekDOm28XG3DkueZJHXuspm5XRn65PQ0LV+KBka3dlwWNWuGhKpntlB+TGldu50Zu2M76n65zFZzrL3js+J2oNiNwra/3z9FTjYajW4Fpljbuhoa1lW2Ny/mhOR1KRPeOTWzQrPFgyRpr3IYmWQYVjQ+l5hg9DhXFhu9urKVx3cy8mJfiXmF8Um1WEdkyHL3MhV7RYgjnkagik9ZnH5oWE9ZJsH4tGywShRvQ2REMeI6FJELXFLCUT6EMYXNdKL/HtmQYyqZ7jaLI+BxabpRsKWdlGAap3k32uvdZtn5CenkFQ2/kVAWQw7YZMygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DysQYTtBBAqIzWp28+0AX9DNT975mxs8jjgh2YhdrUQ=;
 b=cbx2AVZrGJsD6ybVYl5OfaDyL0DxOE+rKvwWJx2pkhqzKEuhzolBYBUhJFrCWBZOewdJJk0FGMgINH4gYIDqsvLa/YszAfS2AsXYQYHzbEuDBRCFv5ugeMMZx3+MQnJW9YhDg9hp2RPh3nu6+UQUGS24txruKyoSQ1EAwCl9UNE=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS4PR21MB6366.namprd21.prod.outlook.com (2603:10b6:8:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Wed, 13 May
 2026 22:15:01 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Wed, 13 May 2026
 22:15:01 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for
 reporting port speed
Thread-Topic: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for
 reporting port speed
Thread-Index: AQHc4fNylzvvdJdzWkywPDUE41f2HrYMh7KQ
Date: Wed, 13 May 2026 22:15:01 +0000
Message-ID:
 <SA1PR21MB66831B2B066734B6228C866BCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=26913763-12ea-461c-a164-b31cd064606b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-13T22:13:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS4PR21MB6366:EE_
x-ms-office365-filtering-correlation-id: 4be3f7f8-a60f-4e34-c546-08deb13d13e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|3023799003|18002099003|56012099003|11063799003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 lbLmKUl8RkYQdEE+TblG8jyew5Yd922Ifl0XDmeh0k3g1xW8xe4RQ5zlNDDR5BCz5fGKLVLJh1ZkUzKQEKm5Hruic/Zd2wDKL0O74aWgCP40p95hdSEdxZvAM7iV1umdP3O6/aB/cHkIQRT2suUnQlVOsY+fckzno8DSWp5iQvsDI0XxOP1okMqIUpS4FzwIrXA2JW8crjHnRgIiZGGki/dK2SLmXQILZzpbE7A6CPpsOzGk0l9FQGN+8isO/W8H+EJDNW2G2n7M8F4+oZw8QdaNJumAPxFzdGbv8jGM3+CdQLaae1GYzMNx2CIwMYvLrbzQSxusC5qFPyxcuKrQMgHhvr77hN2VQ7b64QICGeY9KsiBk9Hzx5SpUJEs4IfXPz+/oBnWzAhRulJfC3a4ZbcMteKe8+NbsVlfgSVdKGRuSqZJRyHgQ97jBe3GWZmhHFedHxC91P1jk9bir/dazSYChWV7fNYZMiHBZ7JBsziaLv3zeoKWOKOiu9Hx6SD5L5Nwv7EbeA5YRe74KpBTxIixTY2W9UXgvP/9jezSqc8i71S5/6y/r1ItUV6hLRoOrELcko9+/m/FVRJ/h0aXz9SXQURkGcpENpj/8AURiSBgSVxHMEriyv+vz4Y9GqUEU+eOTt4UgVP5BFiQFsGupXJVUVM2evaJ2NMRCrjaHP2BZVEmc2OXGL9Ywzos0Sg8XTNMf7HUUbjuOSdJHDPNhCpA14rQ7iR9ncZQ2ZKuNccvUIVB1oefIdVRHyUz+9Yl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(18002099003)(56012099003)(11063799003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j7KnHrdzseYHP+1hLoXGFlv5n8xOj12JO+c/POdPn2FGkvmJqQTMCIXw/GxZ?=
 =?us-ascii?Q?CmCYGbVtP2xsB5M4DamlPE+YferQJMuICUSnh/v7CsCCkfrxfljO63mb8xZT?=
 =?us-ascii?Q?lg2UPgir2L58NpY5ZuZ5YRWcjkRAsL5vQhZ6SaFFRjpgAGD/AQQLWWH6kKpy?=
 =?us-ascii?Q?kh0q5RQ2nXHWpDZYv4cBWWcoR8tkZwCnCycMYMAZVKFdUoAYbHbTzDxQ8LRm?=
 =?us-ascii?Q?MkeZMCLYqWk6Z8equ7S4gndDOr9naVGaCXJCvfl9HJXErQdiomB9EL2IvX05?=
 =?us-ascii?Q?o8Su3DSgg3vDQ3v1EGS5FtEiugfGv87UM9GmF1BkBtBCpJ2ATuRefLxKr1EP?=
 =?us-ascii?Q?776q0IuQM/VjjD2k7y/RzBQ9JXnDvIJYrCmbFt0RntjP6PHWQvtse6BEmUKZ?=
 =?us-ascii?Q?ycD+qPeRjo0dZz+DjsejrzUzOxALHi50tmcUIWFA6TozHTorYevLY8pdxCfg?=
 =?us-ascii?Q?1a1WsIUw/z+YeeZIJGQzt+NJHiWVGrn4gFNWuMIXo3VTfDOAEt6Sht0MU2dP?=
 =?us-ascii?Q?thCLyDGVWzj1nE+Z1PC2mZZwJ0YP79PgcCZQx0w5+aS6RqXMITutaUp94QIU?=
 =?us-ascii?Q?HgU+80I8kZ3k+iLsIghGJk90fbP3gTcf3FDMZW3hTu1PLxcxS7pVJIhCdgP7?=
 =?us-ascii?Q?M9lfxiDql+qrtVQWDBbIKffDs3KaYCh/+2o1B0E6Dj/mhrODoi35QRx455ZE?=
 =?us-ascii?Q?tsgHa1ptgQgziAKg0zrLhEi5X4tojFV2sWW3mjfcVRvtWrnH+USZBJ9xFjMY?=
 =?us-ascii?Q?r5AnfVrZcaIByFadKI3/osZTCi53jyOGH5s9B6ofSke3IZXpoMNAbF37N73Z?=
 =?us-ascii?Q?LPUlh7dRlr+3TxoM5mtcmzxgxQog8stg2l5ueGMs2+7DYyE7iaWjCjAWtgbp?=
 =?us-ascii?Q?UAb0t8N2ZyOnDmRmWC94xAVwHfOCmcX0oIrO/Q8AFRZZ+setKEtOG54FzGyX?=
 =?us-ascii?Q?d9iZ7Q2Yt1j2amd0h6xzmEVUEay2MKidIg/5UYSL7l/7b4qLitskvkbrMRYs?=
 =?us-ascii?Q?yaVDw/xBu/e7uIxMrdb0i2uzH6VAkdsXG7PSo+MyH15Yc2Whwj25VEaWs3to?=
 =?us-ascii?Q?lvi1iyPPUDm7PxRtAA+fEYwsWPmVrxeYijghPNWxqMe9Z8q9kY2AiGArCvIl?=
 =?us-ascii?Q?FUfqxTwXJHxb4M4KDkn8B7fxrryTunjCjuH+2YIbK4xxzkY562D7APDjDh5J?=
 =?us-ascii?Q?FWoWWl1vlz9+/kyz4UzvsKfPXHlSl5xZYzvr4gyErzwYcdgpvpPsAtFrlbgJ?=
 =?us-ascii?Q?ViWaHyhNzJRapdJz20UAe9oJ6mbWoMeBWNtIid9HdOBHoitA+1Sk4jK1KiSc?=
 =?us-ascii?Q?Vm9GtYO2lwphZUC5A8tg4QHa5ctkzYoguBIprRqiE1zMSclW2JhlqHge3g92?=
 =?us-ascii?Q?b5OP+oiVvu4DvSR1K5wS07EuKUQm/4BQnyhRpHyPx6kRV/pH2V4LX2c9/l2f?=
 =?us-ascii?Q?t/c6cK3dhC96YmwSKMFkS9/Ukc1n4d5jaISUgtHi3ZEKEV6CH9fQfHt2KotE?=
 =?us-ascii?Q?kv9GiWr97hKy8kZYsy3kufDjbX6MnXJaAZ2BVt/AOZozoAyDY+Wts8/ndIJR?=
 =?us-ascii?Q?cZJCH46iF831liJBniY+FZqvSsDaiC5NBucaDy3wHbDY7MASyK9WxhY1eDo6?=
 =?us-ascii?Q?Jqy/dY6ZGWNBjylYEtBXlxEFBuCGd+1as0p+LwBRlENjS3QM6dGwA1gr94Ti?=
 =?us-ascii?Q?uI9UtCOf+6bt70Mt1Q5mxBNJF8VLeAWumdgelzvGhC16bZtH?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be3f7f8-a60f-4e34-c546-08deb13d13e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 22:15:01.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vS8+5YXSnQZ82SsieHDUksWUFOsD31KNuhAbhu3MWOYwtwEqJ1hIjVBT03FeyBZ81yHiSOTCkpajKR6YHkitA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6366
X-Rspamd-Queue-Id: E7E8953B5E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20617-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Action: no action

> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Replace hardcoded IB_WIDTH_4X/IB_SPEED_EDR with ib_get_eth_speed() to
> report the actual link speed in mana_ib_query_port().
>=20
> Fixes: 4bda1d5332ec ("RDMA/mana_ib: Implement port parameters")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index d4dfbec..9af92a4 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -633,8 +633,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32
> port,
>  		props->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
>  	}
>=20
> -	props->active_width =3D IB_WIDTH_4X;
> -	props->active_speed =3D IB_SPEED_EDR;
> +	ib_get_eth_speed(ibdev, port, &props->active_speed,
> +&props->active_width);

Should it check the return value, use default values as fallback?

Something like:

   ret =3D ib_get_eth_speed(ibdev, port, &props->active_speed, &props->acti=
ve_width);
   if (ret) {
        props->active_width =3D IB_WIDTH_4X;
        props->active_speed =3D IB_SPEED_EDR;
   }


