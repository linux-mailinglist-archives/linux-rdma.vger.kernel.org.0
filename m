Return-Path: <linux-rdma+bounces-2212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D368B9F2F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 19:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096621F21E6C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16616D9D4;
	Thu,  2 May 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DrWKx0Pw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2110.outbound.protection.outlook.com [40.107.237.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EF1E89C;
	Thu,  2 May 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669483; cv=fail; b=jo34TTkFeKucFfs9J0gvP6ekZwrCSSGOXQuvOlhfxwYKiKKyfcWygvs0OVV7vIcbN0zAn7qy268UYC51NgAKpj9u9yWGjT661Z0ge4LGbb0dBxHK1/Zsg3YZJ34YP2mGnXqH2BjT4EMylYIkMtqKWjn3Tv8mRMdVVPBZmIZlcpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669483; c=relaxed/simple;
	bh=8l1wM2GyGCFetkBpEj87wKkvV5sxTeZgehFTOYhcMUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpVnjaos/u1zU8EzKtQ8OT/zb82xHqhEgt3/IOxk4nq/HgxNXzAVwKDfEuA+J8EBGHXeL3kIuvZh8g4Kk1IbSsI+t74ch3r3gGxffbLGyOGhI082jOANXN5Zuzz9nK08NlLneIthL8vq1QdvIXpLcG6GRysQWpcbXODz22XwWLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DrWKx0Pw; arc=fail smtp.client-ip=40.107.237.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbKpzKdmzAvuEu0Hmj/8i3qYvF/89sL4kI+KdXzFOEvaIlZKM7d0PueeLWQMcxgmHTBfNu0sdQkag9/tlE9SiYW4nRmNVrnZLwBEbBRj01Kim0xOavmFjG7KaZsnKm8pcVmjptvZ6LvaNNI1PX2QWqYz8LUVsIX23a9bc6rbFm9943LYSDFUcEm5RipwCG3ra+x4+L4UPwziRJg0K35DX48phB8SsmdjPZMrskDURSb7jXqW8DQ/IjNHEOmApbsUSuvfuyhfA+6b6fuW/sGUB+o6Dc1SwLZwXUaVwjKAxrO+gY0fQeWpwmMgU298oY5WZwH0yfUKABH9O0i+bM2Qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUv9C/1+ApzaEGz3EoK6qGzaLSiH2HWa6VNBEI01Tpk=;
 b=RiWJayQh+S/WRBfRFFhSf0km7/iCMJxx0TQIUkNEd65zThBWc80Nu4kUC9LHupxFkAF8k3ynT5QXdTlM6gtk8bTwCJC2pDH4aUIvcu4tjnzwDW+uYb39x2YLbsQa4cQT7SFD/rGc4Jb4eJLHXqh7hlg7PF3Ya3ENvPk+ONFFTUWY4FBejEzUvHtzqHHgWS13IvQpwYz0mnpB8A+TS+4GRSR54fCpjq9Ld54iL7scve/Urj9++Vpz+Lb1FB8hxVevW8mj6z+ZcUCRVsHDJIspDlcTXcSbxKLWMmeTUZfDrA1fjJ7J6gHPkH0iO/kilm498LvkmQqUoht8OtPugZ94CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUv9C/1+ApzaEGz3EoK6qGzaLSiH2HWa6VNBEI01Tpk=;
 b=DrWKx0PwBZloPugzPrl5WN0GkBU18YTUYNPQCgDY4xiqJEHULngw93+5u0vfb5oeddssGqB64f1kgk9DXweBzlPSVCrIeRN8TFd9jURfAEaMPlj22brpJZow/OoAd/5xKT25ludz6gquwXkL5bMj8rvaSWP4pr4SM6MeQVLf55M=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BY1PR21MB4346.namprd21.prod.outlook.com (2603:10b6:a03:5bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 17:04:38 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.019; Thu, 2 May 2024
 17:04:37 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Topic: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Index: AQHal9t008XqsRzWOUiSmiSGonpoubGENcUA
Date: Thu, 2 May 2024 17:04:37 +0000
Message-ID:
 <SJ1PR21MB3457ED69FCD16572EFD22089CE182@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
 <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4abe3963-1ec2-443a-83f3-ab851f32673e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-02T17:04:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BY1PR21MB4346:EE_
x-ms-office365-filtering-correlation-id: 2c91e91d-f763-4993-0352-08dc6ac9f2e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sy7NQ+YiUA/CqZNRCdssZKKl2XaeAYvLWyguLYOUrkUSUfW7/EIz4/FrahVR?=
 =?us-ascii?Q?yazGn1P2qxpYE9ztDVFJKVv3TxN2jVs3rO2gRO2t0+PWHXCj1tvSWsGNemGb?=
 =?us-ascii?Q?AsVYMSunl6RcXtTrbG5DYXONdgNVu2EfLbdKYvv+JIjcsW/FxAhq4r71o9k1?=
 =?us-ascii?Q?1JnDY5kgAiHEfmEb5jJNBT+fnUDKLg4a5EFFgzjcTR7J+qP3rSrFAIPB/Zob?=
 =?us-ascii?Q?1HyOcreMRco1bSUzHrFsrZzt9zQD/tZ0ly2Jp+QVHfvmqeRwJ0iuMmljZ90F?=
 =?us-ascii?Q?rKAut4rJ9bxu0DBCR0iOt05K4nhWu/TWt3gz5SNpg0fPMgJ8OZsdYFw14iG+?=
 =?us-ascii?Q?GSwPOJYmWanY4mapy6WVpN6m6n6bq+cH4knPhHxBfE12nyj9tl8lklPqAWro?=
 =?us-ascii?Q?IAZM8j+/30dzY0DnuY8MtbZpLVhAJtZ3IzuZqCnyPqlRomzOlQH3jGL9dfqq?=
 =?us-ascii?Q?2+wIu3EgnN3/htk1mLw8j8yEOcfD3g8u5X1fxvNxK44F5PkwAzyWGrstmndS?=
 =?us-ascii?Q?jkifTKYzz74BZnttNjT9AHA53CgHQFKJd+y70jbRaEJutjROeVxWkVBUFA/i?=
 =?us-ascii?Q?cc0Z7V9tFeBYMBrSvFM0s1ql9xFvDA0DTazPXgrMYmy3lGA13DxRQ4S5iDUg?=
 =?us-ascii?Q?SQlpDxEQxcMmI2vgQxXYA4Ji1xrj6qZPCW8ehBiqXpquNmucZ+1H4a4+Py1R?=
 =?us-ascii?Q?qI8yo0gFXwnasbYI537jPb1QLE9i3y6u/03UcrqeMRnjxRCZq5p+51Kx904K?=
 =?us-ascii?Q?XlwmijBE5p0yEoOT57QYc1XA8XEQUcbSpl+qAenINlQgRvSXAN0/A6Jdeq86?=
 =?us-ascii?Q?OjxDQlyQjE1pvqtMQhepj0jzjNS1mpusdPklg4Y2LZo3gy86wPn6pWkO2aH5?=
 =?us-ascii?Q?2vfldH7CPz5YFyiCd6gHEXlfGjOvkws3BNxtyUCRSDkpc44UcIzaAehEHL6O?=
 =?us-ascii?Q?o+QT+6U8Duw0QQcUQsYPgb34G1StzUr6FM/HRoauJmmJMl1uYwaFdZkQdqok?=
 =?us-ascii?Q?Hw5Q8vbP8PanVuDTjuRP+EZ8Uaukq+NmY81d0IJ8ojU53cwNBi32gG3NH9Pw?=
 =?us-ascii?Q?QEUtQoPky74By/9PLRlmGe1iti4CgoKje0AXY92FeqrNsqDVLN7YgrA4cQle?=
 =?us-ascii?Q?dAJU4/d0nLqG0qr649VniHgShGZQKFvDa4XIGg9XvXPQ7SHQMTHZzVvagPni?=
 =?us-ascii?Q?ADulwV8G7X/W/8KedyDQOp1zx1rUKI9RH/ogXBUhG279Z+PRJqJNZRBYAGE+?=
 =?us-ascii?Q?nniLGMyC/KyRiAwJihK/Y6dbQ+YpKBMn2Ae/Lxn36ziKne385/d4j5xa1pss?=
 =?us-ascii?Q?WyWuSNURK8gUVlFK46UNwpaY/UK0Fu3TgWxK9Oh8irZLZw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ef8ne3UmOg2LPNRC+TO1bvd52Qi8X1+amukOnySbL7bc7PoZ6gKGkI59nVHH?=
 =?us-ascii?Q?NMmuTxbUeSINv8Oo+WMXfIJOCdxes59ROTT5RNRg94xfyQzeuDyI3CX4uM/s?=
 =?us-ascii?Q?0OQXnip+p6KvyVFocEAbkd7drm8fb+GhUcaowNpvqgxxQl5TerRyzN5Xj27j?=
 =?us-ascii?Q?k6mLPnw70whbZQLqPHGEPlEgefvL9SbVWwhZ/9IbbQc4Mi7b42lkC1Tb0xOC?=
 =?us-ascii?Q?L5kXe+8Pqp5jHObLCM1/umIZ1hGgXbhSjCgyp8/u811W+dsIThbf4IAlWGCb?=
 =?us-ascii?Q?1Q0fTUr1vEBuXgNeNa2L+b8z0vYBIMPHA/gjMQHooAOJFy9CEMV19f9Om7a4?=
 =?us-ascii?Q?hpfpCGdSKoBpgDhlQok8MQtQNn3bjmsEy564gXlwozfyncs5tGyneAdodlQe?=
 =?us-ascii?Q?sjtNnpvEkIIryEW6f3QEoR+YXr1xYyRkKGPxy6CcDITmasUeBMa8dMlQw5Wk?=
 =?us-ascii?Q?BtZVp9fCzcPc2710MwQeV7Qwn5NSQEIEjN6bIur++VJ4Eh06Meu1J8X0lyST?=
 =?us-ascii?Q?6JuqHTanPtZQBhubcTXu+/jApGuXbeM03vqvT4Sd5R4Mb80/+ouTq75T5t/d?=
 =?us-ascii?Q?6D5FY+gUeqyK0P/sGYelcYwNBqKPe7ZAopSbtDXwNDKDT8QWCSseQd6YS23z?=
 =?us-ascii?Q?gKyg5nLI6lP7jVWXdMRSfs6UGpJy/NgYZJAY5B7Sggs4WLaxFMo/LpVM6i3F?=
 =?us-ascii?Q?7743T2esb4WWGg2TSc2TlmKqkfM6G/u3hPcWZASpSdhWeuIgqUhkd3lr7d6I?=
 =?us-ascii?Q?76xA9D7UGWQUA7inmboLupxhk3TEGZyrvijWYidlTInUgpjTnkif8qVoyBmH?=
 =?us-ascii?Q?XhCGd5ZjK+ZKGv2m1D1FRTpwf23IHF02HX3rN9nRadHCrVNnYwhomX76XRfB?=
 =?us-ascii?Q?Bz0iJwT+WqpodtK8Ssk9RuUCsgAFoMsECA8BgCdH/fjGp3Lxbp/v+hoVelcU?=
 =?us-ascii?Q?8WOu+8UFGiFmxqsau4n5m74nWrljD3/YzfDAULpbBhPfK3GM2M2tzNdYEi2w?=
 =?us-ascii?Q?79irKrQyfZ0rpjoheSQmkxPyWXXbYCJghQKbZJrkAMB60GubSlHyXHp6gi6s?=
 =?us-ascii?Q?OSzS+9eWx3wMTm5XigwlYZN1XHX3C5xp4Jak/cmB3VquF61Hc4JbHRXcJE4V?=
 =?us-ascii?Q?rTmP6PEffbuP+Bdz9Gi8+PT+MdptlJGgepz+gLY18IuOgtb34/BHZwIursj/?=
 =?us-ascii?Q?lzVXllhxf3fcA0QaIfMEJG+c1a8QLrPdJO/JWqtGl4kpUqJJ5fuyhIMh/QM/?=
 =?us-ascii?Q?vr/otFASaP/0QHGqD2fZWFot13DNbw5F1za65hKS+ZjCFpF3bz5K4REmaJFN?=
 =?us-ascii?Q?JIzVVpErqDQAcdoEiNe2bHBui+7uZC/hI50EjXi1iJoT2hE/RD6Rs7DC9bdZ?=
 =?us-ascii?Q?Uc53OBHlvVxMT5Czr2S/URukl2KBGgo0uY4jyXrOnyTkrX9SW7P6tvSpkbSm?=
 =?us-ascii?Q?06aRspNxOrwT+aSpE/W6IET2k2rVVlkpGz8SvFNmo6GBsXo2UeP4MMbVOtKU?=
 =?us-ascii?Q?tKHdT/vjx2rZNA4oykFZKjI45PKT5ApnYY0Ckzu4MGhNZjFLQqqskkPrV1YC?=
 =?us-ascii?Q?DH+hGTKDxv1ZrLVdaa63Czuy/flJTfuGCZ/8a16j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c91e91d-f763-4993-0352-08dc6ac9f2e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 17:04:37.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxzCGREP4s1a/6MaCcbQtJ2hYT6RZK142rEXWB+HcFUOeoGHJoTLDXpqI5AQI5tn4fbzRgzsY6pbrR/z5GIcuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB4346

> Subject: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for creati=
on
> of rnic cq
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Enable users to create RNIC CQs using a corresponding flag.
> With the previous request size, an ethernet CQ is created.
> As a response, return ID of the created CQ.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c | 55 ++++++++++++++++++++++++++++++---
>  include/uapi/rdma/mana-abi.h    | 12 +++++++
>  2 files changed, 63 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 688ffe6..c6a3fd5 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -9,17 +9,22 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		      struct ib_udata *udata)
>  {
>  	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
> +	struct mana_ib_create_cq_resp resp =3D {};
> +	struct mana_ib_ucontext *mana_ucontext;
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
>  	struct mana_ib_dev *mdev;
> +	bool is_rnic_cq;
> +	u32 doorbell;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
> -	if (udata->inlen < sizeof(ucmd))
> -		return -EINVAL;
> -
>  	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
> +	cq->cq_handle =3D INVALID_MANA_HANDLE;
> +
> +	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> +		return -EINVAL;
>=20
>  	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
>  	if (err) {
> @@ -28,7 +33,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		return err;
>  	}
>=20
> -	if (attr->cqe > mdev->adapter_caps.max_qp_wr) {
> +	is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
> +
> +	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
>  		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
>  		return -EINVAL;
>  	}
> @@ -40,7 +47,41 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		return err;
>  	}
>=20
> +	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
> +						  ibucontext);
> +	doorbell =3D mana_ucontext->doorbell;
> +
> +	if (is_rnic_cq) {
> +		err =3D mana_ib_gd_create_cq(mdev, cq, doorbell);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
> +			goto err_destroy_queue;
> +		}
> +
> +		err =3D mana_ib_install_cq_cb(mdev, cq);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n",
> err);
> +			goto err_destroy_rnic_cq;
> +		}
> +	}
> +
> +	resp.cqid =3D cq->queue.id;
> +	err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen)=
);
> +	if (err) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
> +		goto err_remove_cq_cb;
> +	}
> +
>  	return 0;
> +
> +err_remove_cq_cb:
> +	mana_ib_remove_cq_cb(mdev, cq);
> +err_destroy_rnic_cq:
> +	mana_ib_gd_destroy_cq(mdev, cq);
> +err_destroy_queue:
> +	mana_ib_destroy_queue(mdev, &cq->queue);
> +
> +	return err;
>  }
>=20
>  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata) @@ -5=
2,6
> +93,12 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *uda=
ta)
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
>  	mana_ib_remove_cq_cb(mdev, cq);
> +
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_cq(mdev, cq);
> +
>  	mana_ib_destroy_queue(mdev, &cq->queue);
>=20
>  	return 0;
> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
> index 5fcb31b..2c41cc3 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -16,8 +16,20 @@
>=20
>  #define MANA_IB_UVERBS_ABI_VERSION 1
>=20
> +enum mana_ib_create_cq_flags {
> +	MANA_IB_CREATE_RNIC_CQ	=3D 1 << 0,
> +};
> +
>  struct mana_ib_create_cq {
>  	__aligned_u64 buf_addr;
> +	__u16	flags;
> +	__u16	reserved0;
> +	__u32	reserved1;
> +};
> +
> +struct mana_ib_create_cq_resp {
> +	__u32 cqid;
> +	__u32 reserved;
>  };
>=20
>  struct mana_ib_create_qp {
> --
> 2.43.0


