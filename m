Return-Path: <linux-rdma+bounces-12072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88508B02C8A
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 21:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622071C248BF
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D42797AA;
	Sat, 12 Jul 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R6cyIV7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022107.outbound.protection.outlook.com [52.101.43.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9E35946;
	Sat, 12 Jul 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752347561; cv=fail; b=C5FVqlmkKy9XHo2rjd30Et+Pa24TpLeVHoRP/jnIEA2AoZhyM8HcMh9jC/2e9hsV2rqrMiG7jP7DccthupudH7/K/RbNV4+NhKrb031ETyAE1LrAEy4P9JEmvPZTvAkyaImKUMtsWscBCzn8qDCq0m9L2BfHGWU51Ws12Bb9Gx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752347561; c=relaxed/simple;
	bh=p9Oe/KIIVeSnOAeUOtod/+39QpuwTC0x1SJAqlm4eA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFFg1h3Nt9ynpGNHayIK6Wemqa5Ha5+PR3SFQIK7ISNamTQeFCxduCgx1/Zsa07N2MOxk3sGquXWlgdy7duZ+RVUw4uBq5RdAqhgPj6gi4Q/9ta1OAkxrORq3ezTeS5XQj9ZrbJWPLyP3WdEdtvQDNSSOFshfWwL8GFxz1/Xc7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=R6cyIV7a; arc=fail smtp.client-ip=52.101.43.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGtyJuU//1WDKTs7EuPv8vqERtPUE5X8k2iDKVupdrMs/smdv3A+YMWzwQ+h6CeJglRpfyvzOWu2CsivUlx6vB6zl8cu7U/zHiZolRDwn3YbICCc/Xol02JlrUsTXL3dfgGZK+vgFIUFGRI5ZgRTYI65t1eJ8BRQtG5AZc61qiNmk0RQurLCB4+umhKIlvQYHgfetKj6gLGQSAb2chvPzHWb4zUhgntqHYU8h+fInCDFDakAum1AKBs61W9yoME2gmcBkAxTmqFKAP0TtrQJA4jMkg92m8wkDYv5QUVz/kyhBmVi0fTzTuO9xvhuHWjkmah2rs4YtJuST4co54W+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT5hlLUUMYzRBA70QcJxr02ouekvSqInhDBKb82LA6w=;
 b=A2wXN+mP7qoxedB4topTt7ELdZKFpRu22Sp5oGYzp7r3rgBZLInnL892NVhERoyRTJEt4FCOShTHLU0qmOrbj1uccP6S0g0qKr0e227MPdAa1rKH4coTQFgAqrJrUagwqiO7FpWrigTvJaCIgK+GFaOZSQCGHi3Dk0K7Lp/ksy2aFljYDxkkmDi0zO/gc3Bkpzv+m9jTuLYfzdccPA5dC34uz0hRklSjzLLbxgw90X21VD2aDW1inZsEv/6su55tBkaEe2PH2gwh9sChjlnaHsQ0E4C5SpSLDW8toaZCq1eDpBVL93/mzJDOMjXAzoqX0A5Aam/L8LsiP1wqlZHKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT5hlLUUMYzRBA70QcJxr02ouekvSqInhDBKb82LA6w=;
 b=R6cyIV7ap7d3KRSz7c36zPPzMfmt6pRsPhVRFBryQQGG2y1HHAyTE5y+xhJ7ayhqp1BGclHYxU2jlcDhGWINuU3bFk2HKTqSuOBoBnMQ3GOJNgAXOk6lZie0eN6Nu8xZ+ZfnKm/CcEK1xmvWJaNvW/9gNczAuR4f8EkvVtBe+9I=
Received: from DS2PR21MB5181.namprd21.prod.outlook.com (2603:10b6:8:2b8::22)
 by DS4PR21MB5177.namprd21.prod.outlook.com (2603:10b6:8:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.3; Sat, 12 Jul
 2025 19:12:33 +0000
Received: from DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d]) by DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d%4]) with mapi id 15.20.8943.001; Sat, 12 Jul 2025
 19:12:32 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix DSCP value in modify QP
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix DSCP value in modify QP
Thread-Index: AQHb8YTff647P8MnUkCz1O//ZyAlGLQu3r9Q
Date: Sat, 12 Jul 2025 19:12:32 +0000
Message-ID:
 <DS2PR21MB51814DF56F08DC385B5860DECE4AA@DS2PR21MB5181.namprd21.prod.outlook.com>
References: <1752143085-4169-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1752143085-4169-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f32a02a7-de71-4e68-998b-740b8b5249bc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-12T19:12:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR21MB5181:EE_|DS4PR21MB5177:EE_
x-ms-office365-filtering-correlation-id: c1feb335-f57b-42d7-73ca-08ddc1780da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GSI7pByCYjKr2UYaVPoaKztqy0HI+kzf9YgC58Q5Ry4MnStoyhkwCbhmJUwC?=
 =?us-ascii?Q?EsZ1fQv4FjsZob605bbHChWiZSRhGNwLXAuFJMNYEiSGZfAoyPm4EZjPoEkY?=
 =?us-ascii?Q?Zb0Za1GGhOIcylt2cN8ManipbZzk/3mCFUE8ztkIiUK/Ua9MiCR45NR+KJsD?=
 =?us-ascii?Q?/Yc3VNM/dwGqvIedfyZL4BsnZwr1QyzHqo8uIXjuQRyAmEAFl2lbRWjG4J7q?=
 =?us-ascii?Q?S74XgqbAAJ2iG2rZvHktpL2CytoUx5KZ49I03OM+68YaTBRmKVZ+Wc5pC6fn?=
 =?us-ascii?Q?Sutei2Zb8KSfRM81DxC0SxNFxM4mqHV4Twr2UYx07/mIiOZlHaHHb2DzWhIu?=
 =?us-ascii?Q?jSSbe0aA2YAuKpSD/5VpY2yewsuS13EuBh9HfcjK8awrq654k5C128KBsQcz?=
 =?us-ascii?Q?C4YBNMSCW/fBPAZnffT+yEErQnx9oSwkSpfSzc6qAAWUDtJApSYf0YgW+5LG?=
 =?us-ascii?Q?9HMNwv7QXfE683KtNf3FEqZkxYDmV5LFu8C1HCOnhMiLHDqU1CTROMR7IAfz?=
 =?us-ascii?Q?widtgZBL3/cyVHxCzNthSuo9so7cDsoIo2+h93OVVP1mwjhIaOw6iEVbdmqy?=
 =?us-ascii?Q?vZ72GBi78P3n43a5NRf5/UZKu0MCkYLCPtDctZgxoTldeZIhBsBiFHX2aysD?=
 =?us-ascii?Q?cKUKraJOJukVSHdrE3gI9c2DdDrzzxOzBuYUuPReJXWeBY5gYifV5QMOJF0P?=
 =?us-ascii?Q?Fdi9LHfwV5pOArYUuMQE9NiUZNxQjbZryO93gt3ycDgtnsKlzwvmJeyY3wKK?=
 =?us-ascii?Q?53YSMZSrAsEayFoUzIJ2xmszTw1UvEQwof46M59F6oOwC0ilNYWUMRChArS1?=
 =?us-ascii?Q?UHNhYF1JgEhFOpJa34pM/EASEKenDzlCu8/ffZjrK/pNQZxRMChppf2kf0DH?=
 =?us-ascii?Q?4zgiMPBFQKu4kpgH22kVMzVcIT/h2DGLkIq+56NLOy/RGlYT/C2htBTwqXSS?=
 =?us-ascii?Q?bFoJYMQIX8TKExKZusliIhGzv0KAKeh9ZigY/sMJuhznv3yZgW71fXe8id/q?=
 =?us-ascii?Q?8bFn55E5AF9+dfyIbOUubVkZeb8pN+4sJLEjqphRIEvq6+dMLnWLbModlGpS?=
 =?us-ascii?Q?x/AN48Gll8lI/2AzK0OnkTc4yFZklIDVCjIHIE8+h9J7udR++WeV2FT71TFy?=
 =?us-ascii?Q?lal6Djf9VN6P/aOvwD0oYXiVqdA4F6GTJ6z+tnN3yDJ8pzkrIPAhuFJ9ztbz?=
 =?us-ascii?Q?tJpOTn78yXtCBmz5288aZ5rLeSGNrUCguPX+ejzwzPEHHSCp+l4S105WQmFT?=
 =?us-ascii?Q?/MnjE+tvhHY9dJPIhMVz7k4c5jQEeXQ3kHhhfSKNy/lvilwdy8F9IzCK4mer?=
 =?us-ascii?Q?lDa6G+9Dx8ufVD7/mmCWfhXzMkuc4UE7hDbrO91PuAweg+16Tsg7GJqwtNUZ?=
 =?us-ascii?Q?8DPf0Fyp+DXtiETCoNhDPErASRNktWLologRu9TjxNLfNgv7xEKxS589kDyb?=
 =?us-ascii?Q?ip+KmWMhPH/+iApEdXEAbS2VHaKAOLqoh4vIySvHWfhijoU+utZE3w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR21MB5181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YFswKYFTqBI2WsCWL4El9iGagoMXNf13cBYXh0slGsaCUqCzYj/4NuPXrETV?=
 =?us-ascii?Q?aDx5Hcu6LJt0wEWsqkaPw0lqXx3ZexifK41zh2828swKlFLdEiEQGUaw1+UR?=
 =?us-ascii?Q?EhKFjhGmUbX+z74Bpdne1nBKwuJlXPqjFRvqS4jmJgpDCbZevI+S5nNXcS5c?=
 =?us-ascii?Q?5ETnH65BfgAM7cpkpWd4+JlqYzSxZHg092kEBIfSehnXCSBZYwQBo9e/ksIQ?=
 =?us-ascii?Q?CAVTyyP/WkiXjfLUpgMQHd2nZt0V8YEX/iUdOY/YwR3G4hj4tSgHD5fH6Sfv?=
 =?us-ascii?Q?nbvkD6lYRS1L0iY33d6+zmdFt7Cbg4yzziY/R2K4DbfbJG5OcmOyHA1wHQc1?=
 =?us-ascii?Q?mAONS47+3//ZEWIK4mWb+slNpQGrlepVsy2wylUfwyDEggh9jnEwSgqFygoV?=
 =?us-ascii?Q?jXa2Bc+hCydL+zf1LOuwp2zl6LA4rVEquWYLGNq9/xMZACNkxT3R86p0nHxZ?=
 =?us-ascii?Q?wuCvVh99t4OoPranvSu2Cuya1MIMBlILge8NgwaxdJYXiPMqESn3UnZWoDpB?=
 =?us-ascii?Q?V21TfjDU+85nC63KUGDQhJKBpprzHNJZMsn9su00snZN7YRlYkpYrp8A9AIM?=
 =?us-ascii?Q?HfVfyanKQSpsKsXTa/XwG8dY2U7Jj4CLTAgys8jeZsUtcmHzEQURFEnxz0zy?=
 =?us-ascii?Q?fB11JHz312TH80KymG4VDvmV3mLdpWSWfWhCGhQr2EANnxi/XWQxAPM30Pe2?=
 =?us-ascii?Q?NX1YfckHOkbJfWJTLDRcYBqLmgE4OgNcgbaI2BqP+j4xXmygFMVqCk68FP4E?=
 =?us-ascii?Q?GhR7XPQMAwvHV8XYN3XVIVksRbVDz9yNxaZ7Ux/8k3bGS68o+qGy/pjsGon/?=
 =?us-ascii?Q?m5iFU74W6pQGHZ//+hA1kg1Oa0P0VDDto5kXD9hC02YATWC/2UCBvXBg/qTY?=
 =?us-ascii?Q?xfY1UOq+Csa18sgITmZkfmoe871fUdsMLZ4SstElfWi3oe462F1TrVjq5u9A?=
 =?us-ascii?Q?sNR2SjReuuD6UsdseHEWJZ0r6FdD8u1E25sgCs9XnRrdzZSAPrlOvc3sGzim?=
 =?us-ascii?Q?l2ydRz64vde25VPV7Q0SntjOlJ8HQqm04m4SubOwCgbAv+OpKtp/vET61znO?=
 =?us-ascii?Q?J7RlZ0yknK94WC9gBW98DOpHEoLRBpbiGOSi7VzGasvKdRAtZ5DaIVZnSpLk?=
 =?us-ascii?Q?+2+qacz+7ceB78c4PvZDPJlnBROaoGPxwoyXuO8s8pmXMLERmgx6fFU+Jm/7?=
 =?us-ascii?Q?AKxKBDRoLR2CNgIukDiM9V8rchJdOF0HiWWCatovrG9okB+q1mqZhONWijTM?=
 =?us-ascii?Q?2WjQfHDIvEUb1KfRltH8+moGrUBK4LYznLms9keyy0YXyIJiVJ/4j+kmrXX0?=
 =?us-ascii?Q?CPhHYUYTj+4yHo2PXv2g1b6z6DrCLy3e3D1fsGfOjx9DBRzt5vneJaPCHSWj?=
 =?us-ascii?Q?Mpodkd9rYH6gjKDpzptQ5oyvk0DOz+UXjNRCVMAaxVOHvSMI6MPlKJ0BAMs0?=
 =?us-ascii?Q?GQhNZQa1j6XxVmHWkmW1h9St/LhnFV+IWyVr6mFX2ZXHTrhdX+lDOpyUNX0w?=
 =?us-ascii?Q?edAQuR5zsxCjz0UxA4X0qjjrOgppqT/8LXFAqurg7T7gfA01RNpOzurQSclI?=
 =?us-ascii?Q?SjQ6rZUK54jkV9L7LblsbttWzDnkCLy/i1RbIK7g?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS2PR21MB5181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1feb335-f57b-42d7-73ca-08ddc1780da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2025 19:12:32.5442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUAJu0Dou2RBn1fpcJrE+B7iC0fV1mPtrX1F4DBJrQYLRyj47KL100npcGgU1HtlD0IKG4Iyc2FEHB8mppg+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5177

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix DSCP value in modify QP
>=20
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Convert the traffic_class in GRH to a DSCP value as required by the HW.
>=20
> Fixes: e095405b45bb ("RDMA/mana_ib: Modify QP state")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>


Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index c928af5..456d78c 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -773,7 +773,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp,
> struct ib_qp_attr *attr,
>  		req.ah_attr.dest_port =3D ROCE_V2_UDP_DPORT;
>  		req.ah_attr.src_port =3D rdma_get_udp_sport(attr-
> >ah_attr.grh.flow_label,
>  							  ibqp->qp_num, attr-
> >dest_qp_num);
> -		req.ah_attr.traffic_class =3D attr->ah_attr.grh.traffic_class;
> +		req.ah_attr.traffic_class =3D attr->ah_attr.grh.traffic_class >> 2;
>  		req.ah_attr.hop_limit =3D attr->ah_attr.grh.hop_limit;
>  	}
>=20
> --
> 2.43.0


