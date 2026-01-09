Return-Path: <linux-rdma+bounces-15421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74FD0C94B
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jan 2026 00:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09DDA30262BE
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 23:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584B3396F7;
	Fri,  9 Jan 2026 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jVI2qwk3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021075.outbound.protection.outlook.com [40.107.208.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D530DEAD;
	Fri,  9 Jan 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003006; cv=fail; b=MGhBDIjHVRuVv0WyyflqvUaFwboQDuScW+2pyynROBOKxXccWA0Se7bFTURYOjgPs6sFActChy3IPek68VgRykipeeG3+46gnJsuwT6QVOU798JSI1q/+2jKPLfwytrIyBCCoYLdnsOGA11zEoirMF+Fn/UoW3lT2zWSo+OWGKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003006; c=relaxed/simple;
	bh=v19Jag4q4PaOTAgREfV+J8d/yxR+b4hVlLe7I71h8uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qV6HCuwXnQ/K9Hi2LRb00hwWe3pZDgTuS9Q2ykSRTTxnYuRSADLom6QyK0LH4aKSSVhGqm2v+DphswfyEZbYbeT2PI6+DbhzjUwfS5/yymziO0DDKzoohEZfkPpwlqoxj9hA4+214+PxtOB4rcCseza7l0A69HfKc3jSsGhpgnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jVI2qwk3; arc=fail smtp.client-ip=40.107.208.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXIm1pqxQK7K/7pYNYZ9THZsP7TyfXDFnEveWOtcYk1zcXt43fMKYO7vrCQxACdUgYOvIEVJ1rKwK9MRkLZpnW30erMwUDUru0Vz/il6u7MDxtiZ8NFkJReShkFrcXlZNdHjBVxq2c8re+af/v0acdPZTl+PlETw3CtfzAr/lvaGoaYReM/sCJ58q6bkuHam4vtnBWpQQLnE1tokWOW4FGH6vjRlaBTbJ0UnK/TAPPSj1VPBIFvfs9MtMpdMFmu6ykO37JBM8Ky3/nhkYec+6uqOHrVjiOEhfWeG4f/pYqQPrcp1JhNrHym6vkPIOSWtmGIdvI3Ah9Q684bSw/LrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Xv9/J3RzBhos5TfhsbBYVIuzROCfe4IXO54jEmVU8=;
 b=LluhVxBVyf8QIp1qEPZgnv7sq6lNW5yFegRWCj8SwyZkwXehag3qZ7XRPM3mEmadAHg9HRZVbMho0aR1brlQxR671GpI2jwBYqAz99RCakbK+IJCngTWX3W/FfpWjPWPznZyN/9eGoP6McE83sn3VBlvVQQgIBlZ+a6MltSarfQwYudePO08vwfzWClYOwblX6bZWnW+yAhPtCEauHisLOTf2VQPv5KEID83/TNVAE9QhVkBX12UddaoPxoJ7nXRAR47k0Vze9ikvr8jvM0mP7RmR9czhGCCNo8suAyTagzMJqH1QbftGnr1uHx1SBHVD9XOmHjsdFF4qo9lZ/vGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Xv9/J3RzBhos5TfhsbBYVIuzROCfe4IXO54jEmVU8=;
 b=jVI2qwk3gSvWkhLqs2VDdHvDMg7X4+pHuc/ULb2UPdawokakPE83sG4d8rxsm/YqoLOh2ABAgv+IJhzenXmRt+pJnacKVILduI4uneJ8MJDQhKFE+8LFwbU6bJ5qmaKeP7OEl+Wd5PNWFfdyvSWgvECdxUmhVV8R3ZW2m2EhR9E=
Received: from EA3PR21MB5743.namprd21.prod.outlook.com (2603:10b6:303:2b1::20)
 by DS0PR21MB5953.namprd21.prod.outlook.com (2603:10b6:8:2f2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.2; Fri, 9 Jan
 2026 23:56:42 +0000
Received: from EA3PR21MB5743.namprd21.prod.outlook.com
 ([fe80::643:a9be:8194:f5a5]) by EA3PR21MB5743.namprd21.prod.outlook.com
 ([fe80::643:a9be:8194:f5a5%5]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 23:56:42 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type from the device
 type
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type from the device
 type
Thread-Index: AQHcgWS6skyvlB/HLUeDf0/Tf0ynQbVKhEWw
Date: Fri, 9 Jan 2026 23:56:42 +0000
Message-ID:
 <EA3PR21MB57431271C53518E78BA891B1CE82A@EA3PR21MB5743.namprd21.prod.outlook.com>
References: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c411062d-554e-4c9f-896f-32723458df9e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-09T23:56:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA3PR21MB5743:EE_|DS0PR21MB5953:EE_
x-ms-office365-filtering-correlation-id: 9a072c12-06b0-4cb4-13c5-08de4fdabd07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V2hhwqpuSU6SCnSKTWtzsS7BuW1CzYjuZwD2MP2ruYsgSYkT2/WJaJVSxWhH?=
 =?us-ascii?Q?m1s7Lv4Ez/71vubZtHztFb1gja1k28fw7j1bTXImxrYPOkJeC65rSOciIlSl?=
 =?us-ascii?Q?5132mf4M1Rbp/plC6Z1qO7HZtkdKtssZLn1O0h1bFMNdktwRVqZXF1c/DyOS?=
 =?us-ascii?Q?8Y68R7998cUCUV20ecAPbhZAy4CFKZfHXf7G7OOAuP+ksXCFerzYwyxawHH6?=
 =?us-ascii?Q?03HnT1YddQb4HXcm+qVS6b3kJ+vnBrQtX5+SGvOzNxYkyGO17DiR/EmSZH8g?=
 =?us-ascii?Q?/tKhXEPUL5SFom/zqu4tNXX/N8ANcywgA9tiP998t0cHxS+XVpnsuo9YNbnM?=
 =?us-ascii?Q?VO5jAk4u/IRYM7T8whonXACji4KXRi8if7WiWxi0e8uY6/gLxhXH1dXzm4ui?=
 =?us-ascii?Q?4/7rOrnNMjHxro6e2tUWCXtA2bm/3EO/ylLgfZCaz6YQCHKlW3Gddjb3YZc8?=
 =?us-ascii?Q?pplfGpI+qDV/mois0Li9CHBimrAMY4SPNnoXpVrKAgUYoGXBkusgXEpefiEN?=
 =?us-ascii?Q?3mnhuC/HZvTLj9f609JVXOzknUU3oL42c1xSjtlVnABron6alkdgQozu1eTO?=
 =?us-ascii?Q?7oTu9MV3zzxOyTaAH6tKNqk2jl9iS27RR17XYba0I1qn+vHdKDRAyQLC2vIs?=
 =?us-ascii?Q?nU6FkdfJdvN15ufmIEn0Ekn2wGasscsLY9FBsSDyU4z2X6kRLSDCCqt1Od2t?=
 =?us-ascii?Q?iVLqLBwohAcScEluxYf3Pky9uqgKuxKuKb+PuLhhKjJ1TIAoDkpa2L94Jx9s?=
 =?us-ascii?Q?eG21kQLK+JXxGlIxyDQvmFd48Nkh9Bn48Q4bEF7J2R/vk+LrIlnwloFXFNA2?=
 =?us-ascii?Q?HorUqvxJZ/M/50nz2R4tclPMLd6YcHybwtj/CJ/1UMmaE1G9e5ab7mFm4YmK?=
 =?us-ascii?Q?2hrJ3XFAHQwDz9b8V6FWlF3cJ2EdWeD6KtCO0mhE0klmNtjUcSQ4lxP7B/zy?=
 =?us-ascii?Q?faktx7YG7AL1bTI++2ybuTdukuOv3d8BSiyUZLm1BLAGKHPzSI94G+zwKKCi?=
 =?us-ascii?Q?jqBmbsu4zzoavIELlNCyfOn3CHhhjbHxXCMcjyqLCZMPrZhyjXvipr6mYIX7?=
 =?us-ascii?Q?y1P+hznmcTpIL4beTWSWqqv+LuKwpPCrbay5OWJGT21kiz7aHLq6e056HKka?=
 =?us-ascii?Q?69z04bofgm5WdBOV/aDahLP5fdr4BahVJfg70pEr9/HA5pBuWZX8LNG0mVDd?=
 =?us-ascii?Q?yn7AUc7b/aoLF7B5bvhiMNLVmsoOiApdmzoPk9ARhRmFJSIRv+KckPsLjOXB?=
 =?us-ascii?Q?gU96TzCamRT72Wpno5MMQrZrhY9/Do8yWvnrhUtbnvmXn0NpEqHiFLRpvGEm?=
 =?us-ascii?Q?+VfeMjS/RNfgnQZkB0lEd9YSSakU0KCGmC2BA6J8XkQDJLd+VpbZLVTxicEu?=
 =?us-ascii?Q?35rsmXhBtMqmfZAHKI8yijy3G3jy5RJC7sIw2wNC30s+BKvDNnsoYrqvkVm4?=
 =?us-ascii?Q?8XFTDduUmPen8NakAOFNW/UygsCilyTEoREEy3/1WBQHqe7xD4D3az9RzunQ?=
 =?us-ascii?Q?79ZOmU7Q+T2K+F3P4Nyot4Jj/l1mPiEeZfB5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EA3PR21MB5743.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DJPzTNSPRDzWKrfCgoOyO3K1o6rdqo3A760Hy8NPBBt0Y+z2UAg5bA4aog+v?=
 =?us-ascii?Q?IQs1Pj2s6oSCppv3oY2Dfstk88/n1QmfAf7jagCrGoBPudrg7+5Y8VS+KgBZ?=
 =?us-ascii?Q?h4IrRn+eMdX75rzDjcxi4cidvQXVOXnn7ZlijxSfIf0P0mmZMO5yjs6HLY+g?=
 =?us-ascii?Q?AGOs6l3GBxrEGd6302mNsNk0GAZt73Z16aryPjZAYCawmsr5dpZvbvpEjZru?=
 =?us-ascii?Q?Q0TKEFhYiZw2GTz843zFY0Y8gaHksjOdMU4N3KzVww0HFsAqJyb+5DBXGLli?=
 =?us-ascii?Q?ZaShpqPFqtvtfgTbu93Xk8PM6oaIDB2aqwaqpSHDeumXznnZixstFeSfgmth?=
 =?us-ascii?Q?8XbLvXYMmihh/xI73By8f+q4Un2y6DjrsihfwlLT7I4EuzqqOqRjP2vu8OMo?=
 =?us-ascii?Q?z507JzNAqFvWfaPzhy/ASDd4Wa3liJa/1GY3PqWgIE/u8Tx8EIMoKg00/57B?=
 =?us-ascii?Q?x8mL/Zz/rgX7v3rrykkmxZpKFjcNySEgGKB/svSNmUoJpOnGD48Uuu/xKH2x?=
 =?us-ascii?Q?ZRr7GZUZss4Emw+SksEwJOaVlWNxXY6wUC8L8PuGTOUlsjsnC4fVkPBk3TBN?=
 =?us-ascii?Q?0x+YN8AQhFgHKR9T85tGVU4iO2NIzKZh+eBMNL8LD2Pi/iWnVROLwhqDTZSN?=
 =?us-ascii?Q?CBqnh6UXxD6eUiC4ceS2NKUupctcYthZLIsq1wscRErPq0La1ucDlniVie0A?=
 =?us-ascii?Q?HrJSiuBlBE8o80gWrFGXN1uZnP/Ov45hlPTgce0rSIHiVK+8aZmxUM05ZJs4?=
 =?us-ascii?Q?efoXeVDgVbHxSOwzxQ0cjzGnXiP365Aw4Rt4gtw1R966//lzKMLmGzTDg81d?=
 =?us-ascii?Q?/GhsnYwzF5vajJbHlVCsWNBlE6yf/xfCWGklw7ByPSYV8/uRotJr6pk7eofe?=
 =?us-ascii?Q?f4RvYIV2Z5bmkqTCzSPwsQmul3/W/tO5aXsJH5WYVNkplYBU8+5v4qXtAAp7?=
 =?us-ascii?Q?9r6/tUFd+PVQOxnKg0vaFxcDhgEfEhalg6Ck/Uf6P5fCDJGgxD0+PTi6SNZf?=
 =?us-ascii?Q?br/0szTyIjLnKv7EAfMRS6jbTJRSYb2SAPfb8p5jo3mmqqbKLIfRIl02LF93?=
 =?us-ascii?Q?9j7P5uqKum0QKFUBG05BJVSHfmXPfyGU0S+1FJC4a2ILKInOC1ZCYc2DaW0t?=
 =?us-ascii?Q?GW5oT4rEBKj4x4q3RcbdDbH7DR5ywhdDczD5YYrQ9rCipBYH4kQ9yGvM7y04?=
 =?us-ascii?Q?irv2B0LrcJkvr8GFcWge75e+rzxteVoMl+zjjjm60qsf33O0y10S1mey60bp?=
 =?us-ascii?Q?N/GtIRjpdsCkhTlMwQAMpaFLo96P1RvbA2yo77oIDhf8NpgrmU0jo0g997Nk?=
 =?us-ascii?Q?zNa0dAcJVPcwb+XhfEHSjPLgVAZY0Wl3yJ8HzyahdbBcd0iLsoQEeP2mNIkD?=
 =?us-ascii?Q?OonbkUxLu5MaQ36CBt+q6M549YRW3QCuaixgXRw0eLaE6vkW5SmtPb2/XhBC?=
 =?us-ascii?Q?BPBDYIV2ud4L5lcApythg4pNJ+yTRfr1sMuQviYIxxv27y68Ms/P4kNkCeXs?=
 =?us-ascii?Q?L/e9udsu7OjXRFLCyiQEEliC9NPogh1L0bNDUxmaVcQATIAi0JuYoMgU/8st?=
 =?us-ascii?Q?GLiFZr/3Qqg7IbxR0F/ieIkvNT+7Qz71oBIVO+Z/Sy8gAvrlOcMU2RMuFHzQ?=
 =?us-ascii?Q?jyPpxTlLIN2zG8Yz1QtNflZ+MvU7YSh4bmTTqQHiuusUgFmeDRN1Un3nUw09?=
 =?us-ascii?Q?mGVIo33Atgzfv03QOkUzf9vmCoFYz4QxdcdmBRAn6HrFLbYq?=
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
X-MS-Exchange-CrossTenant-AuthSource: EA3PR21MB5743.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a072c12-06b0-4cb4-13c5-08de4fdabd07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 23:56:42.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9AebokAc4T89p3qIQ4ViK4WBd3fhsERwUem8ttuMfJ2PL/4qjzsu1mA5O+EO4GddX3G9wW84zhtmF6moOZsMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB5953

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type from the
> device type
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Get CQ type from the used gdma device. The MANA_IB_CREATE_RNIC_CQ flag
> is ignored. It was used in older kernel versions where the mana_ib was sh=
ared
> between ethernet and rnic.
>=20
> Fixes: d4293f96ce0b ("RDMA/mana_ib: unify mana_ib functions to support
> any gdma device")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 1becc8779..2dce1b677 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -24,6 +24,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>=20
>  	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
>  	cq->cq_handle =3D INVALID_MANA_HANDLE;
> +	is_rnic_cq =3D mana_ib_is_rnic(mdev);
>=20
>  	if (udata) {
>  		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> @@ -35,8 +36,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  			return err;
>  		}
>=20
> -		is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
> -
>  		if ((!is_rnic_cq && attr->cqe > mdev-
> >adapter_caps.max_qp_wr) ||
>  		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
>  			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr-
> >cqe); @@ -55,7 +54,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const
> struct ib_cq_init_attr *attr,
>  							  ibucontext);
>  		doorbell =3D mana_ucontext->doorbell;
>  	} else {
> -		is_rnic_cq =3D true;
>  		buf_size =3D MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> >cqe * COMP_ENTRY_SIZE));
>  		cq->cqe =3D buf_size / COMP_ENTRY_SIZE;
>  		err =3D mana_ib_create_kernel_queue(mdev, buf_size,
> GDMA_CQ, &cq->queue);
> --
> 2.43.0


