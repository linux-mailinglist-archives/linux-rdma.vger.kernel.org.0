Return-Path: <linux-rdma+bounces-12073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED41BB02C94
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 21:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA29188EA3B
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99437283FDE;
	Sat, 12 Jul 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AxYAGX+2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022091.outbound.protection.outlook.com [40.93.195.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D71632DF;
	Sat, 12 Jul 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752347767; cv=fail; b=phyXxeV2sqGma/bXeHDsX+9BkZ71tL1oyfF+nHvwCK3yGRELvF27Nt43zGL2uDNCw+3bfF3ceyxQOJ5EIA3H4LIm9d2HycBVylK9FEAJYj+Nyf/Ei2tFQMAjRtfe5L4qBDWEC4jPx8ctazSrJXPLFwFcMICejtWffAgJXZQOp4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752347767; c=relaxed/simple;
	bh=MOlYRJykpOYHo3/pPjSDb26rr1u++0BtwvRTaAZDbyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8p/wFI2JKDbm7tiV7mvdjA8Rd6aaWGLp9QQSworz4X+KrmuTPfwkw1PR8R+vjYnzDZlkCTaQ4EiXnmjMoMOTvRyDMk2RDNpsNpk5YdAQbVncV7ZEF2Io76dkQCWG5cCoUaqBCIn1sIeZKfSNvIgOOkJdc9ICokxmpNRtmNFF+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AxYAGX+2; arc=fail smtp.client-ip=40.93.195.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LergpuK7vy+EjebR0X3aMInj3J6GMrYyZZWWHHmrAd7tX2V3uVguOyIegiMJ/7Uk8mEIbWLfR8FI2DrsVXd3hwOjaIngddaExNR4yLKX+4v5D472dw6Emuj0qRJhlfKIcSkLjvTJBAe+TDGzT35rzSPHR7Lr4zDq4187phdcsFczJx0H8Qj9p54veo7psxWeGYiwzYOmsVQZOwLnatL4adXh0pO6Frtfgczjilv/Pgp3y3mkKdw/YYcU3XBQiIeJfLcLOQoK/CAcucuj/VzRRgagc3oVpEkXTCtZHPEcq6eId87MjztyfBydYoeU6uULWPAB1PeRlFsM30eR0ZIjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DXCtxiTm+PhgMwM0pUA5mCo5wjtk57p/3SIM7qMW/o=;
 b=nI1bUiAOHhwE56T5gBeuYpA9b5Do6tv17qjQQ0gyzEFh9j1hG6DhHEyz8nheuTAEzaUNKNuwlwyEoHmo1bqG8EFo8ycTmpmnz1Hark74BYu8tYpitCWzGX4iGjDuIjCtipeUlbSTXVjeJYXXcEqwKnpccfyO21b/Nu15zzVtyihu4M1E8kR5Qp4HKTbj8rUYzsnishy5NaH8+iqk7SUlvwqvvTkha6t4EKDrNBdNxaEycyvA62Jr/GdAng4TcPKpqW2yxdBJBeU13P3T/SqNa+kJ2h8qQBPAdE6d0n2EPlR5jdi3Ntaf6bW14GhXVOf6snkwEmDrrK1Ex1YksbcxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DXCtxiTm+PhgMwM0pUA5mCo5wjtk57p/3SIM7qMW/o=;
 b=AxYAGX+2rgDYo8vDBSPTBrbxN3IvCguE9x0OgIj+vgbK5ZXpuDq+ycSaOEsYRRKpVSbLKi5Ghu9WXQ+5kuOd/9Kgkg1acddwlzF51DlHg2hcSUcmAQN+gy+tddYDXrOktrts7YG4QqpdPzNFNXxAk6+BERAkdEoSrJUTRkBE1XU=
Received: from DS2PR21MB5181.namprd21.prod.outlook.com (2603:10b6:8:2b8::22)
 by DS4PR21MB5177.namprd21.prod.outlook.com (2603:10b6:8:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.3; Sat, 12 Jul
 2025 19:16:03 +0000
Received: from DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d]) by DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d%4]) with mapi id 15.20.8943.001; Sat, 12 Jul 2025
 19:16:03 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Zhiyue Qiu <zhiyueqiu@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: add additional port counters
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: add additional port counters
Thread-Index: AQHb8YWY9999YyLJnUOusNmqy4DufLQu38KA
Date: Sat, 12 Jul 2025 19:16:02 +0000
Message-ID:
 <DS2PR21MB518120FF2942700DDE8E675ACE4AA@DS2PR21MB5181.namprd21.prod.outlook.com>
References: <1752143395-5324-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1752143395-5324-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50326a26-c230-428c-9513-2ca57978af40;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-12T19:15:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR21MB5181:EE_|DS4PR21MB5177:EE_
x-ms-office365-filtering-correlation-id: 1e9f17fd-f45d-418d-60ed-08ddc1788b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n/4Gl6MdPf5OrGaECA0hHf0p0QDVpzzwuO+vUhzTOozsLJ6PzpvN1cRTxJhs?=
 =?us-ascii?Q?N9LiNyn3WSclsMeicRwvLybu0PY89DSWq4Ydd/DODwnJRuszKYLUaZtk02mb?=
 =?us-ascii?Q?qmLKTlxuBovYxxCDppWV8JMc53Sl7uwUWfuTmQU/+y5Vk1DleEb5jryhD2qx?=
 =?us-ascii?Q?D830N+JCVrboYMCYfrn2r1l3wyz647viG0IjWks0lj105TYpn+UGm4zQHBPL?=
 =?us-ascii?Q?xGyYjFPSIQFE5ftKEgoXuq48NVxtNrttiAFNmiKsk0qzuOjJQGm0ilVx4fYS?=
 =?us-ascii?Q?NvmRJIm8E/a519+W/qRleMRFDLVsqVg8nCbnFr4numwtq1IqciRc2UBSl505?=
 =?us-ascii?Q?2vsbIwAZZocl+8pisuUxzOlSn63LQjAlYEv2IkHfKBct6amx1yKkBLwXAHfg?=
 =?us-ascii?Q?2Jm75TqCk2iWd6WJF14zEnQi6fXNSF+Masz1wI+fseLbHWpCr4pN0twJZeTb?=
 =?us-ascii?Q?Wj2dl4y3UoAuDF6vMuiezfn4lZxg9IEdYrl7mhGlDkRYmb+9A92d+AQGApAE?=
 =?us-ascii?Q?xkhPaH345+RdU5cnbH1+wE4BG7uldubVaQCUGNgyi9YQTTXcgcs+jT5Q941M?=
 =?us-ascii?Q?mBInj+B25slj7/T0saTI+gSSchu4SOT/TAEfSr8agWCvKh07xFodUYNgXZCm?=
 =?us-ascii?Q?EG+fIKF0ct1f6jhcIZTUazkRzxlsc2PntN8WYRLxaysrNi7tKxj7JxPmiv9Y?=
 =?us-ascii?Q?lIU+rmuyypkbCKtPelUNh8CqTAwUOZcVMi5KElsNT5lmvfQJqTqFR/fRGJUB?=
 =?us-ascii?Q?N8ewm38gzmc8TC1aZUGk7aahm5rTqMGd3ovcyO7jnkqrrOIWtG7032iThiEh?=
 =?us-ascii?Q?B3UfVhjIDbzqXlnF+WGGdP0siTz7NlyGqyp5bRMY9ypY8nK1DjjFZM1ro6h9?=
 =?us-ascii?Q?Lp4LqdKfbO7Avc8uP5CAvKa9GHfNX78T2/S/twFGafaClbNtFrRdZrH0vx2g?=
 =?us-ascii?Q?Fnc7jCZsNri4Cia6EVrw7U6CsYH+gD7MkvAFEdh9vYak5AHM0UaWwOOHbNtS?=
 =?us-ascii?Q?VUXXkp6KSHGaRorp26PsqPOl69BGFt0I05dNCtN8qujU7ZMHCsKSi/u4Zga0?=
 =?us-ascii?Q?fAQ4jur/iNqYH27kx6A8++2+IdqlwIysY5HVki88fhgFzEL4t1qOiwUH7QQV?=
 =?us-ascii?Q?0vLzOnV90vHEw8bfAfJRinlT0hhWqLMHb+dZGUyS/mWaRDofr62So/94llCY?=
 =?us-ascii?Q?XOt0jbfHz/RxkutIg/2laXswvh81bg9OqS2Wx/Vwz6KQjNJbbLXY0g/1sC9M?=
 =?us-ascii?Q?av3cnehQVQnjoMw4dO/FSZcu1CJLKjI55BZYsWxgUirrxCz1TAAnGvNUgi0Y?=
 =?us-ascii?Q?BUOTOZ5YIpf0knkab8sUJEl0AuQCfMlX9NMcbZVG/8u2r7l5i0zQElGosCgg?=
 =?us-ascii?Q?ckLSB+SlQjTbVMuhmQpy0mJbkBhfhjj6zcKg/G3OehF16flozwsfM0hHBICN?=
 =?us-ascii?Q?qtybzuJ5MDbaxRA5hwRHXoTCAg5Ka3ooKoAj3wfUBWhEsaZaUlGhGgGPdJNp?=
 =?us-ascii?Q?+jJEr26hWDRcWUM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR21MB5181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nWPqEP5j6n3Y1TWXVpkD2Kb1sJURDcPjuUOd6/rozQmw6HtwAQNvkbvf1Iml?=
 =?us-ascii?Q?nAP9BNdfx5yY5jU4QIM04nszTcICJTFsYNREdmw4+T3ad6LNlrVHnO70rBcS?=
 =?us-ascii?Q?jkd334MSp3S0/0O+NoSF/r1DEjoPPzKa9rTdUw977Q/hiYFUjs8tDQtqAxbt?=
 =?us-ascii?Q?0aSpuaUpcizYa0Dh4eja/ic9usAaEc9W6FZXEqyS0eLdo+375A+FS2Hd2CJZ?=
 =?us-ascii?Q?gLMQPAswBjx/TasnIY2HxiPVnn0b5zFbGdM+2Ul2RPCoHHiPCwsQ6rWRLd3M?=
 =?us-ascii?Q?OQ9kDqqw1IQkL/Bc75SyddachZPQCaYzr2M9QjZrEAssg2QblRfObYLaZMr3?=
 =?us-ascii?Q?Dr0jxMFMtaTJSxqd3T05erh5RUrYiYyQtnn2iY2NcKSYiM3V13/NGfSbxaEd?=
 =?us-ascii?Q?GcU85bSEgIr9PIRKIXxMCI5ldTxgQsuFWXrkmnCzAFjOXvkSyeFHtYcE4VRb?=
 =?us-ascii?Q?eOh8t4qgdibEHc8biaRqKt9COmdicPI4Gi28l17n4vmslR9jey3o0Ryn+H4v?=
 =?us-ascii?Q?ZfeH1Lr/O2fDyOPfRo94d2JkKC6huqczQMuBMd/OUxU4ceGkU3ECkkfBKnjN?=
 =?us-ascii?Q?oZ81nHryXUFK7XASPfodlsrdfTdjsi+Tw9YssQnIJBIGSOS5XT7uQp9nPXsG?=
 =?us-ascii?Q?+Tlr15RjaKfLCEG/DYzUKlVmYkG3o7LBQmaWqQ800WJK1SnWWguXmzoe+UnF?=
 =?us-ascii?Q?yLBCAPnckpBxDM43xEvZs90w6TFQhJa+KIorfHU+G8eJVNp5M5sbeJ90XRc7?=
 =?us-ascii?Q?j3Bo0Ttvs3UjCCaFGZSWhhAMxpiOPZlKyswkJBUD1vR9TcndX8oKv0Z3HIV9?=
 =?us-ascii?Q?vb48RlT8rOEUjRFoBe5pKCQsvazv6FUHAJGhVSWSLp24KHSxxPbbOju6EWLQ?=
 =?us-ascii?Q?Re2qyRbt4lPy/dKIbItnYmLqXhmQuCTwVw+bTRj3VI+8rPVUSuvZ0Xh491h1?=
 =?us-ascii?Q?CKtu4lOjvDtI5YDJYQ7oxyO6cSZeQNE3pbKecnhTIVSLpjssqZ9u+iprZJzu?=
 =?us-ascii?Q?gNHmuLKBcDAUPsWSIdaIOVrjtka4MCWM/7wh0YkfJXsKkFlRBFKq/jDNDSx5?=
 =?us-ascii?Q?qZFkgWk++b4HWEVSdu0J8UJ+6Y3zsCRt+3sil6EY0wroAMmwG4U88nOARrx8?=
 =?us-ascii?Q?tuKxaiI9zgGgnF0xqvLcaySp5qa3UE/EOn+GnUYybZCoK2uICmoss132Pfk/?=
 =?us-ascii?Q?xhgNALWGEQmV7+hi4jgaw6k4sgx5wqPpHhXmwoRqAh7dnWwy9C+geHCO+g0H?=
 =?us-ascii?Q?TAxeTxErldn5D/oLIjFU3s1z6deOpyhXQ63yXyw+mdYL8wbfOtvqneB+N3M5?=
 =?us-ascii?Q?P0zBGK9hssmgjiZEeSgQUbd5DZb2tK77oIdlc4F4z68NYkW1U5ju0qBr9Lwu?=
 =?us-ascii?Q?m7B1HyakbfGd38NfrLx6Q8NIq+IkpxOxHeFAfxOTJpMOW4Qlvf47yilrMeNx?=
 =?us-ascii?Q?bhbaFUcF76sdX3AXJwNcMYXH9c9mhBckP0pT66Ag5R76fGPmgCMHXfqkL+0W?=
 =?us-ascii?Q?Nzga3Qjp8yel8gNOMsArWZ3Dql9uARL2SVvR4SuNTLoo0LzhQJqu/8IUiR7U?=
 =?us-ascii?Q?IyEXnDsTTu0kyXJXzmA6HqyYN0Iw/6HpU1Z/zYaf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f17fd-f45d-418d-60ed-08ddc1788b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2025 19:16:03.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/WTj7LGs26zkg9HoxvWyCsbfaLtkydp/mGiWuvLHwPtpBwBR7V6nHg+7y6EUOXFRPjeTX4WtXd/JyPq5W7SiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5177

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: add additional port counters
>=20
> From: Zhiyue Qiu <zhiyueqiu@microsoft.com>
>=20
> Add packet and request port counters to mana_ib.
>=20
> Signed-off-by: Zhiyue Qiu <zhiyueqiu@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/counters.c | 18 ++++++++++++++++++
> drivers/infiniband/hw/mana/counters.h |  8 ++++++++
> drivers/infiniband/hw/mana/mana_ib.h  |  8 ++++++++
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/counters.c
> b/drivers/infiniband/hw/mana/counters.c
> index 6a81365..e964e74 100644
> --- a/drivers/infiniband/hw/mana/counters.c
> +++ b/drivers/infiniband/hw/mana/counters.c
> @@ -32,6 +32,14 @@
>  	[MANA_IB_RATE_INC_EVENTS].name =3D "rate_inc_events",
>  	[MANA_IB_NUM_QPS_RECOVERED].name =3D "num_qps_recovered",
>  	[MANA_IB_CURRENT_RATE].name =3D "current_rate",
> +	[MANA_IB_DUP_RX_REQ].name =3D "dup_rx_requests",
> +	[MANA_IB_TX_BYTES].name =3D "tx_bytes",
> +	[MANA_IB_RX_BYTES].name =3D "rx_bytes",
> +	[MANA_IB_RX_SEND_REQ].name =3D "rx_send_requests",
> +	[MANA_IB_RX_WRITE_REQ].name =3D "rx_write_requests",
> +	[MANA_IB_RX_READ_REQ].name =3D "rx_read_requests",
> +	[MANA_IB_TX_PKT].name =3D "tx_packets",
> +	[MANA_IB_RX_PKT].name =3D "rx_packets",
>  };
>=20
>  static const struct rdma_stat_desc mana_ib_device_stats_desc[] =3D { @@ =
-100,6
> +108,7 @@ static int mana_ib_get_hw_port_stats(struct ib_device *ibdev, s=
truct
> rdma_hw_sta
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_QUERY_VF_COUNTERS,
>  			     sizeof(req), sizeof(resp));
> +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
>  	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>=20
> @@ -148,6 +157,15 @@ static int mana_ib_get_hw_port_stats(struct ib_devic=
e
> *ibdev, struct rdma_hw_sta
>  	stats->value[MANA_IB_NUM_QPS_RECOVERED] =3D
> resp.num_qps_recovered;
>  	stats->value[MANA_IB_CURRENT_RATE] =3D resp.current_rate;
>=20
> +	stats->value[MANA_IB_DUP_RX_REQ] =3D resp.dup_rx_req;
> +	stats->value[MANA_IB_TX_BYTES] =3D resp.tx_bytes;
> +	stats->value[MANA_IB_RX_BYTES] =3D resp.rx_bytes;
> +	stats->value[MANA_IB_RX_SEND_REQ] =3D resp.rx_send_req;
> +	stats->value[MANA_IB_RX_WRITE_REQ] =3D resp.rx_write_req;
> +	stats->value[MANA_IB_RX_READ_REQ] =3D resp.rx_read_req;
> +	stats->value[MANA_IB_TX_PKT] =3D resp.tx_pkt;
> +	stats->value[MANA_IB_RX_PKT] =3D resp.rx_pkt;
> +
>  	return ARRAY_SIZE(mana_ib_port_stats_desc);
>  }
>=20
> diff --git a/drivers/infiniband/hw/mana/counters.h
> b/drivers/infiniband/hw/mana/counters.h
> index 987a6fe..f68e776 100644
> --- a/drivers/infiniband/hw/mana/counters.h
> +++ b/drivers/infiniband/hw/mana/counters.h
> @@ -35,6 +35,14 @@ enum mana_ib_port_counters {
>  	MANA_IB_RATE_INC_EVENTS,
>  	MANA_IB_NUM_QPS_RECOVERED,
>  	MANA_IB_CURRENT_RATE,
> +	MANA_IB_DUP_RX_REQ,
> +	MANA_IB_TX_BYTES,
> +	MANA_IB_RX_BYTES,
> +	MANA_IB_RX_SEND_REQ,
> +	MANA_IB_RX_WRITE_REQ,
> +	MANA_IB_RX_READ_REQ,
> +	MANA_IB_TX_PKT,
> +	MANA_IB_RX_PKT,
>  };
>=20
>  enum mana_ib_device_counters {
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index eddd0a8..369825f 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -516,6 +516,14 @@ struct mana_rnic_query_vf_cntrs_resp {
>  	u64 rate_inc_events;
>  	u64 num_qps_recovered;
>  	u64 current_rate;
> +	u64 dup_rx_req;
> +	u64 tx_bytes;
> +	u64 rx_bytes;
> +	u64 rx_send_req;
> +	u64 rx_write_req;
> +	u64 rx_read_req;
> +	u64 tx_pkt;
> +	u64 rx_pkt;
>  }; /* HW Data */
>=20
>  struct mana_rnic_query_device_cntrs_req {
> --
> 1.8.3.1


