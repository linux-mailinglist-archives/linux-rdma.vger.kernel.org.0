Return-Path: <linux-rdma+bounces-2923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3038FD9F8
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 00:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4301F23B41
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E715FA8C;
	Wed,  5 Jun 2024 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MAGNPqbk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11023015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D1621;
	Wed,  5 Jun 2024 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627373; cv=fail; b=kvYy4RwBju+Pu021vlDRIY5kk9aIrOuSz04VEMBwBZOlul5H877YPaK0Nt3eje5LI8k0RUBNtLEZ/GYAeBqKXQIgp+HFpgMDUk/20wH3j3TbwWokG3Vk23XpY54uMFZUGMxd6/JwUYJo6Eka+AMJxG++w1PBXsD3FmIGkL3zRfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627373; c=relaxed/simple;
	bh=GZLoWwWonymHKg9s4n+JsdBjzD879mdnHrQzY6Gouos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xf3WK4TAyvumYWZ+CctMmxrDNPLdlGP6jKZqk5tiI9xSLye3I5mTL3v0tkDEF0eSD9ocBIFufyRh4PmBnpdSnkA2nx6pa1fciVccOFeERmuC8HFnyp/xB3b32ElCxMb3Qi319nAxX/HLOEIXpAEYhaBqSq/NmgkVRbb9ZdamDLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MAGNPqbk; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmcR27J5bmEzc17H92dSR6DOGtRxaHDCdOK16eVSwdShgF+0TcM2XgBdUZNM86Gb/I4w9H2P5/RFaFmFUZchfRRrqbgsaYe5C0JeckB5DhGSLZiEvPgJ6BCtknk8VSLdxJYRdD8o4JVEN4bPfjEcoB6JKMlRriUcl4C2N0tRaKkmWc6W7G9QOQ3pz9L/YKGihOxd8t4yWrbi2NEq0lQlm059QlN3XxkLVdnrkwDmOz4MUqawDOFsIH59B0gXtpxickDetKA/LtbWD1RsRsJiwv+sA2yy10b+2ega2GeB8QyxmX4qFz2easVNE88cGJZ4hOyIh4b5zORUQFNVZMzeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwnNmowIHoKiINsKo49qWk1lMOxzowM7/ApyWUeRRqI=;
 b=i8KE6Sr29DkgVYMKoSZsB4xl+Nm1ZHZZqwtkJijZbw+m4d4/2G1tQipCe/WAibTf0AztjVTALaB/1A6q9EMDwDdldv7/zWkjpNcNetdA5ZMKUQzTwcKaZM/vVh1knJcV5lBypHqeRd4HMT3Av4T6xuVtlNn+fQRodH3ZoPuHyPQ4gJkMxhkQ5Ors+i7RUqPWGKeUoM0HKjun9f+Jjsg2YWFaXdX5m1jtzTH1dLuXarueMI11FtS+XhksTK2yV6PxLYpYCNaAOYZN+/4hjiUd3NB14k+I8GbcTBycRHkgFEkhoq6kMihaQb3o0+SO3HFtxgtBQ3Jm83J/V8H+PfLu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwnNmowIHoKiINsKo49qWk1lMOxzowM7/ApyWUeRRqI=;
 b=MAGNPqbkup4LLjtROFy5MgsL28MNVc8k7LaKXkuMM6UjKk+NntWIMCr/xa4zo2LYVPt3hEe/f51x9BlQwjf93Gu+Au6SNBsjh2+oMytS6CYwFf71iz1I2mZKGQHTy1MDOUSrAkWhvSnW0/cgXgJhC2hZ6WMuCum5GMICJXYBNIQ=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by DS7PR21MB3366.namprd21.prod.outlook.com (2603:10b6:8:82::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.7; Wed, 5 Jun 2024 22:42:49 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%3]) with mapi id 15.20.7677.001; Wed, 5 Jun 2024
 22:42:49 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Index: AQHatnNn3cy/Ic0fek2xJdoL70MjcrG5wS7g
Date: Wed, 5 Jun 2024 22:42:48 +0000
Message-ID:
 <PH7PR21MB307195C7DD870A5716E1CA92CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b9f9122-27a4-4ad5-b04b-3479404d893d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-05T22:23:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|DS7PR21MB3366:EE_
x-ms-office365-filtering-correlation-id: 74993d9d-bd35-4340-936a-08dc85b0d391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZCwLxvwSMKq7+OyW4q4Otnoly7N3nw3s+qW9vN1CPrIBEjb8mxVeEKgSmNEh?=
 =?us-ascii?Q?+/9W5ndjMeY7zB28yU/haoQbrHw3i4hpxdsVi4O2oFwwxMm/nnp3JMplLDMY?=
 =?us-ascii?Q?VYuJB/FtbQANWAV0s5fFXBgZKUy16odz+Ix2Jadq/ApdT4CcWxNkF0bYTG7i?=
 =?us-ascii?Q?Fg1Mt0dpT80ppW9xjjoFMV8EpvqjaxobomkaBOyEH7bzj34/euQDTDLNz+Yr?=
 =?us-ascii?Q?hliYsrvlcF+WU2sm7SEv3C7tPAQTX7hUu4Gj4xtIapSQM5KXSgwkGwUJnSJ+?=
 =?us-ascii?Q?oJgA8cKq9cEpCxhhyEzo13jyzfukz/3OO3MZG+fHyt+S2EGgIt0l1AQpcUdf?=
 =?us-ascii?Q?CZA85jWN/6yhlG7owo7H46amra88azQOJZ0pGh9w5hWuxZdvhz5Idq63H5d+?=
 =?us-ascii?Q?K1zS1xtbEdzJMAsNGiHHiEpbHEkggTiHFDurIWy+XO5ZAmzhX2E6o93Oz+mL?=
 =?us-ascii?Q?lfpzoKDT3lDnUOx2IfFPLZxADPRemRtJGV8z3ddfq8vkk4tFubWlOSKTRkhL?=
 =?us-ascii?Q?CxP5HaVeykC/QZ+ahy2Bn2nTdiPnt0Kq7heC8pD6VRGV47NwCuoD4Gh5+yM9?=
 =?us-ascii?Q?ESIoKJ/SDBVO7yqBGgJevHgPOPu4MGIhCfF+MALv+biLmrjL6BcD7ANkR4Hq?=
 =?us-ascii?Q?vu2fMZB3vM7ltX40JnLipnsn0wAosyFl5GV0KmwmxkizOv9woONDEjHDza7A?=
 =?us-ascii?Q?RYH0TcJOWafeLaINI5V7fnow0x6qtSGpyevalZMCh8rb0ZinfoGlu4XPelY1?=
 =?us-ascii?Q?6Zb+rh5LRTgiyL8VJIE/nU6IuAWnDeX6LGKc/X3k51REuciK7z40AKxugNAN?=
 =?us-ascii?Q?xqRvEWh/YLl4QypIGBUwuyRvXcKbPc5k+767oR5cTVlgAR78z9btgSj0QSlV?=
 =?us-ascii?Q?WJBB5JMb0R0wkIlouXHwI66VwPAXWEegxxFo3dNZtsmH687e2W44A+EXKZQm?=
 =?us-ascii?Q?dINBbDKnQc2F2iX0kEgGVfykcWxzqISkMH2H344UC9oEhUXuY89Eyq0C0G9H?=
 =?us-ascii?Q?5U4XYMQLj/AJgfXoOjax2R6w5uiarpcZrrsXQbZoAZiWA+30yWVsG+VZ6M1X?=
 =?us-ascii?Q?ne+ato5vLjy0dQGfXX4rhyDpdl5TTibvr+y2nfs/Q5E6knX04Kq0iJ/S0WEi?=
 =?us-ascii?Q?FxG/kApueyGPLHFdpFhTJPOlOF/Vkq4NrGm3g7TX+b1m8I7WN1MXE9d+jvRD?=
 =?us-ascii?Q?coRyy/eeDeEZVW1ueAw5jRwpFzWhgKTe8PflMTMO06lebTyEnyveiMwu/5My?=
 =?us-ascii?Q?ockZ927hLDwQ1ZYxTJfUgKynlj50DV0xfymrXHZYOpTJTTlqj3+aD26ONfYW?=
 =?us-ascii?Q?PoAJ3Ke/97s0FIhNo+VQHB3AEezv6MVWw1NUURywwkXVsvV7mzQ7Q8cUC437?=
 =?us-ascii?Q?nfSaV/g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2lhviAVvFMqAl9lBTd/lJp+C8/x53j5BpuB5jVTjxQamCOt5Hm8716FvxXqN?=
 =?us-ascii?Q?i7W/8VGCgCLJvb5wqt3oUCSsBiqHHTVoV5pgeF0vfS8Q06lcxE8YZ1uydDbb?=
 =?us-ascii?Q?mTN4s0vPwYBipPzYDhT8fXKTS7UHAmZtwz8DQB6JSB1uhDXMtT3bSVL/fbJX?=
 =?us-ascii?Q?c1Bq8k4u/RepDKngZUWDbU6JwUaQP2adn+x1Ah042Rp+ut3yeHOrLvNz2BS8?=
 =?us-ascii?Q?pqMbKnrULpL51CsL4SdlJN2ncRc/YRz7m3MD2WhGG/Qbegt2ousBADpDjyXJ?=
 =?us-ascii?Q?lR8IIAKKFk7kQBZXnpGwQBcAZf/iXwIIaeVHn2puhTLpfU0hUmZydWXE6uPX?=
 =?us-ascii?Q?3eQXqI8sZ4c1KkpzxagkymVEVe4PNLBhg747Wma91GRmDeZPBkyqj4VfoZKM?=
 =?us-ascii?Q?LDFQ73aFY0AaWM73Li0Rj+/D+eeC4cqNYZIhrTv6EGkpyVDhi+QGwzrWNf7h?=
 =?us-ascii?Q?M4YuTd8JASrL73V2GdDSoY90n2mtsyKibRilQpzF4GZPdTBiC3l6tZUhZ5e/?=
 =?us-ascii?Q?m6DR1nEgEn+fOu29t2SNHCk8etYQ2XJeNCrVwuI//6go8yKrXFjnWK0pkJPh?=
 =?us-ascii?Q?BX7ylp0J8uCAW/3X5pKk2/7YCeMbn7s1g11LVkhTa9lxZxqBDqBQSA17INip?=
 =?us-ascii?Q?W9L8Pz03kceee38eNBX6mrqDqfzz7HQnzWJFdE1uHS4vjbyZRD7dsUsYGV3g?=
 =?us-ascii?Q?HxCXaK4lMs3tSFkS3W4Xyc9G8Vf6Us46debiEjSGWUo0hWUebDheWgjXrXbv?=
 =?us-ascii?Q?vGjDVxhV33W7axmkUZSwJKBqwRvJvx4ijHOrEhGiTOTr+W+Earmsy9vIC4KO?=
 =?us-ascii?Q?zht1oXlVNrDmSb8h6yoptWxZlDFsWXLGD4a/XTSM8PyyoHWj6ScAyD44C47C?=
 =?us-ascii?Q?tP375TuIGkKaXRxPTanRyYEwH1tXirZ58bc40FS8yTBU/WZIDXTmFwj/s1On?=
 =?us-ascii?Q?wgJhmpcNxW3pvJluShAMzbbm4HWl3KnXcDCu14oDvXr2f3napOmV0izhRhGd?=
 =?us-ascii?Q?8vTO5kZ31dCMz6s3uYp9oBQKN/2YHHS84xe4hzeKikPs/vU6fd+shAfix+PP?=
 =?us-ascii?Q?i1TWjRpJKZ/7yF/QPkf7Nj+X06+4vDyWwgb8QxDwSdRdnTBCd0TVvqZoY/0K?=
 =?us-ascii?Q?oGeOIXPVNhktzoa1q/BWx21YVWheU+FetuQL6SeGJqem05v4RYR75IivKrF+?=
 =?us-ascii?Q?+qeZyW5q/Y8Lj11otH8PkzkLMu6dZvXG9DwG+sVwQvvLCGQqGVVzmcJo2eyV?=
 =?us-ascii?Q?bSMjdXdtTPWdz/k/QCOOcDkKF3I5NhMici/tagMuVJT27hJMeaHYfUhlk2LZ?=
 =?us-ascii?Q?47b3sydWAnIbfFTJIjKSgV0Et1VJiL824WLOyvn7491oj5PB57B7whIrIwbV?=
 =?us-ascii?Q?iiCKgjT1+pM4dys+IeBz9D5m5PSxYaCtPBiL8IcxyrYlXsSpRP9o+IjjvMBo?=
 =?us-ascii?Q?guA4IsM7oSNaAtswBHmB9GbzH0RZ2PbvZWK3UkuguiYIj528+17oi71oM3/i?=
 =?us-ascii?Q?L40hEr1iRtWG/mWQ16ihV/yU8TYuKmaA0SjIE6x/aHGIvrZQ94t/ktNGENpU?=
 =?us-ascii?Q?TPZFTojKktA3febvXBdYIEvcGMeZVIoerBMq519X?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74993d9d-bd35-4340-936a-08dc85b0d391
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 22:42:48.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drA34vK+d93fd7t+2iDkrDqzEvCJjOyaxlBytOnIGsiOHY797awyLBWF8dVIvm9Fpmxb7oETo3GlvO6+Umby7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3366

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Process QP fatal events from the error event queue.
> For that, find the QP, using QPN from the event, and then call its event_=
handler.
> To find the QPs, store created RC QPs in an xarray.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c           |  3 ++
>  drivers/infiniband/hw/mana/main.c             | 37 ++++++++++++++++++-
>  drivers/infiniband/hw/mana/mana_ib.h          |  4 ++
>  drivers/infiniband/hw/mana/qp.c               | 11 ++++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
>  include/net/mana/gdma.h                       |  1 +
>  6 files changed, 55 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 9a7da2e..9eb714e 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -126,6 +126,7 @@ static int mana_ib_probe(struct auxiliary_device *ade=
v,
>  	if (ret)
>  		goto destroy_eqs;
>=20
> +	xa_init_flags(&dev->qp_table_rq, XA_FLAGS_LOCK_IRQ);
>  	ret =3D mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d",
> @@ -143,6 +144,7 @@ static int mana_ib_probe(struct auxiliary_device *ade=
v,
>  	return 0;
>=20
>  destroy_rnic:
> +	xa_destroy(&dev->qp_table_rq);
>  	mana_ib_gd_destroy_rnic_adapter(dev);
>  destroy_eqs:
>  	mana_ib_destroy_eqs(dev);
> @@ -158,6 +160,7 @@ static void mana_ib_remove(struct auxiliary_device
> *adev)
>  	struct mana_ib_dev *dev =3D dev_get_drvdata(&adev->dev);
>=20
>  	ib_unregister_device(&dev->ib_dev);
> +	xa_destroy(&dev->qp_table_rq);
>  	mana_ib_gd_destroy_rnic_adapter(dev);
>  	mana_ib_destroy_eqs(dev);
>  	mana_gd_deregister_device(dev->gdma_dev);
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 365b4f1..dfcfb88 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -667,6 +667,39 @@ int mana_ib_gd_query_adapter_caps(struct
> mana_ib_dev *dev)
>  	return 0;
>  }
>=20
> +static void
> +mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct
> +gdma_event *event) {
> +	struct mana_ib_dev *mdev =3D (struct mana_ib_dev *)ctx;
> +	struct mana_ib_qp *qp;
> +	struct ib_event ev;
> +	unsigned long flag;
> +	u32 qpn;
> +
> +	switch (event->type) {
> +	case GDMA_EQE_RNIC_QP_FATAL:
> +		qpn =3D event->details[0];
> +		xa_lock_irqsave(&mdev->qp_table_rq, flag);
> +		qp =3D xa_load(&mdev->qp_table_rq, qpn);
> +		if (qp)
> +			refcount_inc(&qp->refcount);


Move this to after checking for "if (!qp) break".

> +		xa_unlock_irqrestore(&mdev->qp_table_rq, flag);
> +		if (!qp)
> +			break;
> +		if (qp->ibqp.event_handler) {
> +			ev.device =3D qp->ibqp.device;
> +			ev.element.qp =3D &qp->ibqp;
> +			ev.event =3D IB_EVENT_QP_FATAL;
> +			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
> +		}
> +		if (refcount_dec_and_test(&qp->refcount))
> +			complete(&qp->free);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  int mana_ib_create_eqs(struct mana_ib_dev *mdev)  {
>  	struct gdma_context *gc =3D mdev_to_gc(mdev); @@ -676,7 +709,7 @@
> int mana_ib_create_eqs(struct mana_ib_dev *mdev)
>  	spec.type =3D GDMA_EQ;
>  	spec.monitor_avl_buf =3D false;
>  	spec.queue_size =3D EQ_SIZE;
> -	spec.eq.callback =3D NULL;
> +	spec.eq.callback =3D mana_ib_event_handler;
>  	spec.eq.context =3D mdev;
>  	spec.eq.log2_throttle_limit =3D LOG2_EQ_THROTTLE;
>  	spec.eq.msix_index =3D 0;
> @@ -691,7 +724,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
>  		err =3D -ENOMEM;
>  		goto destroy_fatal_eq;
>  	}
> -
> +	spec.eq.callback =3D NULL;
>  	for (i =3D 0; i < mdev->ib_dev.num_comp_vectors; i++) {
>  		spec.eq.msix_index =3D (i + 1) % gc->num_msix_usable;
>  		err =3D mana_gd_create_mana_eq(mdev->gdma_dev, &spec,
> &mdev->eqs[i]); diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 60bc548..b732555 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -62,6 +62,7 @@ struct mana_ib_dev {
>  	mana_handle_t adapter_handle;
>  	struct gdma_queue *fatal_err_eq;
>  	struct gdma_queue **eqs;
> +	struct xarray qp_table_rq;
>  	struct mana_ib_adapter_caps adapter_caps;  };
>=20
> @@ -124,6 +125,9 @@ struct mana_ib_qp {
>=20
>  	/* The port on the IB device, starting with 1 */
>  	u32 port;
> +
> +	refcount_t		refcount;
> +	struct completion	free;
>  };
>=20
>  struct mana_ib_ucontext {
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 34a9372..3f4fcc9 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -460,6 +460,12 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  		}
>  	}
>=20
> +	refcount_set(&qp->refcount, 1);
> +	init_completion(&qp->free);
> +	err =3D xa_insert_irq(&mdev->qp_table_rq, qp->ibqp.qp_num, qp,
> GFP_KERNEL);
> +	if (err)
> +		goto destroy_qp;
> +
>  	return 0;
>=20
>  destroy_qp:
> @@ -620,6 +626,11 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp
> *qp, struct ib_udata *udata)
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
>  	int i;
>=20
> +	xa_erase_irq(&mdev->qp_table_rq, qp->ibqp.qp_num);
> +	if (refcount_dec_and_test(&qp->refcount))
> +		complete(&qp->free);
> +	wait_for_completion(&qp->free);

Strange logic. Why not do:
if (!refcount_dec_and_test(&qp->refcount))
	wait_for_completion(&qp->free);



