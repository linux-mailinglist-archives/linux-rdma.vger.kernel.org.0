Return-Path: <linux-rdma+bounces-3903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED4934FA2
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD601C210B7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7C142E9F;
	Thu, 18 Jul 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DnhISHQc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2114.outbound.protection.outlook.com [40.107.105.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7B84DF5;
	Thu, 18 Jul 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315164; cv=fail; b=MgphlPDoUNc8uWx2HYCafbqC0CMX8O38ZZsaX/uGptbHaKT+5Zx8GeYmtY2HfHZiCVgV+d4arPoMGx5WPrebEG+C3Q1+cU4+mH73ZmY0K10LwX3zVtMjn2tUFLy0qAUQhxr9MrcicWBaA6aw3KZqn6vboJLG4mhd57sgEiYk8To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315164; c=relaxed/simple;
	bh=7LYKvmENWOAhpPV+9b/BvCdbxeXFz2M1j3s7dSVofxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWL5bORiObYwasOeTozcIt3M3ukVS7PrSrzPonweTkS6BhgEPDLaTkXgwKoKTbFQTmcvFnScMQgA7NeQjijVWwVbiqVEha1ypy4UhVmAHSvw45flyXn1CqvbPPw1Bg80Z7JSoDrSyGZiMzPuBodqEt2v1nwJ66E0dcwgmVAZKuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DnhISHQc; arc=fail smtp.client-ip=40.107.105.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF2t6YasmQfhjlqVcvWfiqdC8we6C5zcOVuHVvNUpSibrhcZJxf9kRZ88Ilzc3tPCghF+tTE1FavQA0ZntVKmvu13eZSDKftT0P8YNU9mHY4xNdi45hYrniXGpWTaihOdcGGj8Rz/LMJg4oBzGxp+7peB/TOwE6F4UxbnFOTVNn+Q3BmW8rBdYoKuRr8Qmn2bR6JWS2zc1tPALbx3kVNPj8FjIrGiQafuSNn0mycTn4OugR4VciIRf9ke+h+nB6u0V844C7/5NMiiVQPtqTLozVmXQ8fRpA3IMLV02Mq16cWnUTMoafJL6Mb7kkFdo9RPlWWn+KdNGRbH5ngk+7fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LYKvmENWOAhpPV+9b/BvCdbxeXFz2M1j3s7dSVofxw=;
 b=eJ9dxOIhRQ0p1WXpQ1Ga2UTQd07Bp0IWI9T3GgOjRhKKiJR26cOzqW5Jh2SoleacRpicj9P4uYIqRbPMCSb5UCnHUOkHcIpMjdFYDBNArgtBFWXBFwyFSgjzsJV/FFhuJNqAPxy0Zhp9DztNJdPZtH4tOWJQEn6WHIDPjV2QbvEfWT8VrkIZcnjp2F8dSnCUi+2WIa1RkhplMd8YxqjKO4L9hrU/qjq+YXqJZwKVsngTDs56Ljf2AtA7BYiCdCjPbClhyR3tXgDy2C4Xrj2W49kD1lAk6jeWIHGTMDMP5OO/YyoEiP9qTL6KLWuJcxnmroeyJvkeHMkQDjyqlduZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LYKvmENWOAhpPV+9b/BvCdbxeXFz2M1j3s7dSVofxw=;
 b=DnhISHQchnaol2Yza4ECXT+mC+MNmCUd+YNViXWoE1YpkgiS6eaNAotJIOHbdEciCnhOqGplde9emKRBapeu7S/H3Gf4qU6VHBUe4DJTzdavh9l8jrdMWz8Dtyp2g61Z6mz7G7hxkj5bNiAWyDULHwkOWl2r34ywq68+AroWzXE=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by PA6PR83MB0578.EURPRD83.prod.outlook.com (2603:10a6:102:3d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Thu, 18 Jul
 2024 15:05:59 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Thu, 18 Jul 2024
 15:05:59 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Thread-Index: AQHa15Axxh1tqRxLuk+cZ2Vxnf/mzLH5lcYAgAADuPCAANrgAIAAqu6AgAF2yOA=
Date: Thu, 18 Jul 2024 15:05:59 +0000
Message-ID:
 <PAXPR83MB05599E93C7F584D34D715E8AB4AC2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240717062250.GE5630@unreal> <20240717163437.GG1482543@nvidia.com>
In-Reply-To: <20240717163437.GG1482543@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3c1a5719-5be2-49e3-91fd-ef235cb54562;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-18T14:56:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|PA6PR83MB0578:EE_
x-ms-office365-filtering-correlation-id: 06efbb33-5914-4f5e-3937-08dca73b21c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEJKdkF0cFhIQWgvTmovQlI3Q2dodE9SQ2o0Z3BhMDdPa3F2NXptbXVwRzlZ?=
 =?utf-8?B?WnFaSkRGcFFwdHcxekN6cEpObEpWY1cvTlJzbXNhZlJMRXc4cXFPcmxVU05E?=
 =?utf-8?B?Qy9UNFpQeFZKL08rdVB6V29OaTRiSFNNcmUvOHdYTEVLNjZjOGhoaE1jd1Fs?=
 =?utf-8?B?aU41cUl0SDZhT2pXc1Yvak5heFZCZGZOVFJ3WThIY21Nb3RUZGpiRHUvT3ls?=
 =?utf-8?B?T1lHTTZlcURnNVB0ZmxITHd1WVJPTUdaVDQ4bGdaY0tWVnFaU3N2R2R3WmV4?=
 =?utf-8?B?dzBVak1MYnk3OEk3bWFkdHhNU1dBd1lmRlU3dHpUN2sxbmthbXhkTVUwVGRB?=
 =?utf-8?B?YzlTbm5DTWdvbE10ZFVCRVdmUkVtK2kzaWFEMVJxbjRTV1R2OUdvZnpQODdp?=
 =?utf-8?B?TlhnZXlYZ2IvcUgrQWhvTzF2QnVndHdFdzE5dmpuOVp5NkN5b0lYYWpkeUZt?=
 =?utf-8?B?aUJhbEk3dC9HbzJRTVBVa3J4ZVExQXYxVWttTzE5eXgvcE9PYyswb1FCR1dP?=
 =?utf-8?B?RDNnR1oxc241RXRUWlJIcm5XT1ZFT3JrVTFYU0REUlFwL2c1U0ZqTmJ5d3dw?=
 =?utf-8?B?Uko0bjZJSE5SNyt3TGlSSXVkU0pIRXhha1poR1YwOTVmMnZYd0xBMVFwVk1Q?=
 =?utf-8?B?NEo5YTVnckVZUUlMWW90T0RQR1M1bmZ6NnpwL1duV1VZUStPckMyaGFtcnZN?=
 =?utf-8?B?ZE1aL1dyMEd1N2pCK3F1ci9HcVNxdERvMmlUVjk1UElHZW5jbzJMdHlmRWUx?=
 =?utf-8?B?UlR1ajluNmlDWlZHNmd6VzU4Skx3a1pjTSsxamd6Qi9LUWFGS3MrbksvRlZS?=
 =?utf-8?B?VUxNVVRJNXl6MFFLaFNmTFZTdHJyQU5TVEM4TmRibVRQeUhsSmtUVVJDc2gr?=
 =?utf-8?B?M3ZIb3ovR0FySHFmQi9PeXNzYmtMMk9aR0gzV29JN215Wjl6bGFvaTFIQ1JB?=
 =?utf-8?B?eGxpaVcyVmgwRDV6Mk56MTlISkZuSG14MXFlQjJuRTliQlBGMFBoalNtS210?=
 =?utf-8?B?L3FpQUtBR2ozWm1QSTRadHhGYUFNRnRhRlJzTnZDdW5kOGNKS2gvTUo2OXAr?=
 =?utf-8?B?cGR5UkdtUE4zZWZKa1poRkY1djdVUEgwVEkwVzRxL0JlYTFLaXlXMzNQdWNw?=
 =?utf-8?B?U3gzdXMwNnZKcEFLYTVJcEV1ZXZUaldRdzYwcXY3dm9KK294ZEhEZWNPdnkr?=
 =?utf-8?B?akJyaXFUaERPaDN5NUlnV0RTS3RUVmxsR3EwUlNvam9BVGR5WjI2K0luWXFF?=
 =?utf-8?B?emxGMjNPN1ZwNVhmQUM5R3NnRzVBaVRaNk1RaXNobHZPaDRuaDR5Y3pjNUZ3?=
 =?utf-8?B?ZmM3T0pxbUtXSkVkSTRqMTA0YmEvMjIwWWMwSzJIdGdiY2Raa0RHMlVjTi85?=
 =?utf-8?B?ekh4QlRxdmJNY0FCTkd5dEhlK0lFUUFyV3BsM0M2MUFUTkIxcSszV1VXRG1n?=
 =?utf-8?B?MG1vZWZBci9JWTU1d0ZKVlFTaUg0N3FCWVFJUzIwTUpJUHhFRHF3VGpoeU9D?=
 =?utf-8?B?NzZNS2NQd2UrVTBuZnBCbSsvNWxjR2FVWUVKaXJxRW9sRVNMTVdzajEyU3p1?=
 =?utf-8?B?Y3l2WFV5ZnI4ekhOU1RjdjN3Y3EzdU12bjZUdjdjM3dYam92MVZjU2tvd0k0?=
 =?utf-8?B?b29IWmwxdTJLWHh1dDkrdmUwZ0pWLzFXcnZ1cVNMQy9LMDUrRmp1c1ZzOU10?=
 =?utf-8?B?N201YzRJVjQwY2ZTdjVReFBKamRCako3WlFLdzRBWi9LenUwTjB0cGFwSEVh?=
 =?utf-8?B?VlBrZDZnNWtublBGTmpDbU5nTGJCdkU3eHRPWTNnejMzVXRDdzFBT3Eyd0NR?=
 =?utf-8?B?WmtnU2hEd1I5Rjh0Um5qTHRHYlZGK05UM0JDalBlY2FvWXBOdVZ5czgydGxR?=
 =?utf-8?B?WlpzZzNFMy9SVTdWUmZwNmg1Z1NUTENuV01xckUrNkhFVkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bm45Z0ZXc1kzUjNUeTNDQmp0QWpwcjBMWEFlS0VWSVU2VzIvRWtsSSs0ajFU?=
 =?utf-8?B?T1htdGlFRTV4Wmk4aER6ekwvZVgrOS9SaGt4dm4vS3VZOGRtVTU4TTFkVHZJ?=
 =?utf-8?B?Vzh6WXU5bnZjS1JCblpZY2w4ZFBveGxSMTBPdGRSUmpyclg3MnBKZ0U2dXR0?=
 =?utf-8?B?dDJGRmgzVE1iaFZOQnJ4Ky9OcW9QWWQ1UHBJRGpjUVVUL0kycDlLK0RiYzZ6?=
 =?utf-8?B?YnFabTB0VEFON1IxMG5iQjJONTZiWC9jUnMyTXduMmRySDVSbWJOVlZHKzBu?=
 =?utf-8?B?Um9MdnEzUTBEa2JtWGo3WER2M3RnNXUyenc1OGRGbUJkbHo2QUNZemJOVWdB?=
 =?utf-8?B?ZDU0QTRiTmdaczZXeUpIUG9EVCtrNUE5MnM4REt0dk1kd05ITHlGaTVhOGJr?=
 =?utf-8?B?QkVXZE9vcFV4ZHcrdTdDMnp0eEYydzdTYk44SW0zMXRzTktwSGQvdHRpV2dq?=
 =?utf-8?B?cjJpWW9ScWV3SmdZbEowSEYvTENad3NIalUvVFkzNGh4MmE1WTVsZ3pOcnRV?=
 =?utf-8?B?YjRzWk9aREt6Q0dZS3QxS04yL2FLMmdySmZFa203dC9CcjllZ0tWMmV6ZXNF?=
 =?utf-8?B?WDBvanBmTTVoeHpabkpnbHJvVi9ZRkY5ZVdQOEM4Y3FMN3phZ1ZRQ2JsaUpZ?=
 =?utf-8?B?bVFPOVJCaWVSeFgxWCs3MENSTnROUFd2NVRTTTh1NHlCam01NmNNM203Rkl0?=
 =?utf-8?B?YUpyckhLSWhOcW8rb2dzR3dTbXJiS1hBVzIyU3NVc0NLVzRnb25vYmdEVkxi?=
 =?utf-8?B?cGtORXp1K1N4ek9pYXJWcFJoZW1oK2JIbkRTZmhqZXlKRlBINER1alpnMFBT?=
 =?utf-8?B?akRWT3hPeXR4MFFwNENEb21STEJNc2MwSTV5WW90aUhKYU4wR1VZejZLOTg3?=
 =?utf-8?B?cm4yY1VXWnZCcUpRZFNQYUdzdWRNU2RBd05sUTFYZ1cyZ0hDTDZHaDQvaVVF?=
 =?utf-8?B?TitBQWRveDBUeXdTeDJia01pUS9rY2RyckJtQW1RMjZVdk5DYVA3WFlBaHZO?=
 =?utf-8?B?Tk1nbXVMM01sd0o3dUtHMlZCYUVxZzFMcGQ4T3ZIMnpaOGQ4QkhVdHZid3N0?=
 =?utf-8?B?MjMxajVXbU40MnMyZTRvTWFKMlNzbElQMWNTK0FPZy9wZldMSk55b0tYSlJT?=
 =?utf-8?B?MDNTQ2xFT2ZwVVVKc01lMURQMUg3NEkrdStWSWloUGxET242bjJiajRjeGt4?=
 =?utf-8?B?OUtOVWEwZnZEK01LZExvMVpEME83NUFLTXF0dWx4OEhSbjFuQXNQSElnYy9Q?=
 =?utf-8?B?WndrV2pTTzk5WFVVRTdUVDR0aWMvMjVmQ0V0S3FjWDVXN2hKd3ZrOGl3WXB0?=
 =?utf-8?B?UDMwc2hGNmxvbCtTZG9rVnQ0K3FSTmQ2M055SXpKQXlkNy9PSHh5Zk9XL3Jv?=
 =?utf-8?B?aFZJZC8zdkgvd2QxRm1HTGI2OWhqSGxzUVZOemJLUVlRMU53RTl0Q0dDZ2R6?=
 =?utf-8?B?WG82WUdpVllxdjBFcW1ZaHhUQkF4VXgwbmhJc1lXUkZZMEszcHN4cFRXdkVK?=
 =?utf-8?B?eGExMncwTHI0S0VJZWR2TFhGSW01dC9QSUZabDhYNHpJU2E0VFlXbk9BQWJ3?=
 =?utf-8?B?a3RHaXp0bUgvQzlqL05tTzRpN1FOZnRISkg0eXRmcEUzbmowaGdvaTJZdThT?=
 =?utf-8?B?VnFBdHhQQndjbllNZEZoa0hWR05ZV3lrVFUyaklLMVZBRlFiRzdKc0tvelFY?=
 =?utf-8?B?bnJLdklUY2RDK2JHRmpRand2Mzl5b0RGZ0hpY2pjcjN4UE82SVc4cENFR09W?=
 =?utf-8?B?dFlPQ3c0N01VQmxscjF4TDZqaDZVUnhMdlEwVG9QTGNoV2Z2QjU0bGg0WGJ0?=
 =?utf-8?B?dUJ1MWZIbDh5Z1VobFVvdTFBNXAralNjL2lpUC9mK3NDL3didC9vY3hnRy9C?=
 =?utf-8?B?VkRWaUhvMTM2WWZnZHJuOGVjUHA3RkNSdmh4c1pwcGxWL2dmWUltVkFhV1BE?=
 =?utf-8?B?TCtDSFEyQzhnYXRGeC9JOC9SZWg4cDhaWkc3MkJZeU00NU5CSlJZRGR4Mno3?=
 =?utf-8?B?bnFKT29DWnVmNnR5M2RpYWh1UkU4MGVXUXZyczFFUzREWU85MFpTci9NcTlz?=
 =?utf-8?Q?h5sn2m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06efbb33-5914-4f5e-3937-08dca73b21c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 15:05:59.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjvAqT27XM7S+vtX4pe7yOV4/O0FH689ozndYy7IyUx4yaY/nwKO1lrRpD1PV4jUdQuoNQuC82bsNVAKce9vGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR83MB0578

PiA+ID4gPiBZZXMsIHlvdSBhcmUuIElmIHVzZXIgYXNrZWQgZm9yIHNwZWNpZmljIGZ1bmN0aW9u
YWxpdHkNCj4gPiA+ID4gKG1heF9pbmxpbmVfZGF0YSAhPSAwKSBhbmQgeW91ciBkZXZpY2UgZG9l
c24ndCBzdXBwb3J0IGl0LCB5b3Ugc2hvdWxkDQo+IHJldHVybiBhbiBlcnJvci4NCj4gPiA+ID4N
Cj4gPiA+ID4gcHZyZG1hLCBtbHg0IGFuZCBydnQgYXJlIG5vdCBnb29kIGV4YW1wbGVzLCB0aGV5
IHNob3VsZCByZXR1cm4gYW4NCj4gPiA+ID4gZXJyb3IgYXMgd2VsbCwgYnV0IGJlY2F1c2Ugb2Yg
YmVpbmcgbGVnYWN5IGNvZGUsIHdlIHdvbid0IGNoYW5nZSB0aGVtLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGFua3MNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJIHNlZS4gU28gSSBndWVzcyB3ZSBjYW4g
cmV0dXJuIGEgbGFyZ2VyIHZhbHVlLCBidXQgbm90IHNtYWxsZXIuIFJpZ2h0Pw0KPiA+ID4gSSB3
aWxsIHNlbmQgdjIgdGhhdCBmYWlscyBRUCBjcmVhdGlvbiB0aGVuLg0KPiA+ID4NCj4gPiA+IElu
IHRoaXMgY2FzZSwgbWF5IEkgc3VibWl0IGEgcGF0Y2ggdG8gcmRtYS1jb3JlIHRoYXQgcXVlcmll
cyBkZXZpY2UNCj4gPiA+IGNhcHMgYmVmb3JlIHRyeWluZyB0byBjcmVhdGUgYSBxcCBpbiByZG1h
X2NsaWVudC5jIGFuZA0KPiA+ID4gcmRtYV9zZXJ2ZXIuYz8gQXMgdGhhdCBjb2RlIHZpb2xhdGVz
IHdoYXQgeW91IGRlc2NyaWJlZC4NCj4gPg0KPiA+IExldCdzIGFzayBKYXNvbiwgd2h5IGlzIHRo
YXQ/IERvIHdlIGFsbG93IHRvIGlnbm9yZSBtYXhfaW5saW5lX2RhdGE/DQo+ID4NCj4gPiBsaWJy
ZG1hY20vZXhhbXBsZXMvcmRtYV9jbGllbnQuYw0KPiA+ICAgNjMgICAgICAgICBtZW1zZXQoJmF0
dHIsIDAsIHNpemVvZiBhdHRyKTsNCj4gPiAgIDY0ICAgICAgICAgYXR0ci5jYXAubWF4X3NlbmRf
d3IgPSBhdHRyLmNhcC5tYXhfcmVjdl93ciA9IDE7DQo+ID4gICA2NSAgICAgICAgIGF0dHIuY2Fw
Lm1heF9zZW5kX3NnZSA9IGF0dHIuY2FwLm1heF9yZWN2X3NnZSA9IDE7DQo+ID4gICA2NiAgICAg
ICAgIGF0dHIuY2FwLm1heF9pbmxpbmVfZGF0YSA9IDE2Ow0KPiA+ICAgNjcgICAgICAgICBhdHRy
LnFwX2NvbnRleHQgPSBpZDsNCj4gPiAgIDY4ICAgICAgICAgYXR0ci5zcV9zaWdfYWxsID0gMTsN
Cj4gPiAgIDY5ICAgICAgICAgcmV0ID0gcmRtYV9jcmVhdGVfZXAoJmlkLCByZXMsIE5VTEwsICZh
dHRyKTsNCj4gPiAgIDcwICAgICAgICAgLy8gQ2hlY2sgdG8gc2VlIGlmIHdlIGdvdCBpbmxpbmUg
ZGF0YSBhbGxvd2VkIG9yIG5vdA0KPiA+ICAgNzEgICAgICAgICBpZiAoYXR0ci5jYXAubWF4X2lu
bGluZV9kYXRhID49IDE2KQ0KPiA+ICAgNzIgICAgICAgICAgICAgICAgIHNlbmRfZmxhZ3MgPSBJ
QlZfU0VORF9JTkxJTkU7DQo+ID4gICA3MyAgICAgICAgIGVsc2UNCj4gPiAgIDc0ICAgICAgICAg
ICAgICAgICBwcmludGYoInJkbWFfY2xpZW50OiBkZXZpY2UgZG9lc24ndCBzdXBwb3J0DQo+IElC
Vl9TRU5EX0lOTElORSwgIg0KPiA+ICAgNzUgICAgICAgICAgICAgICAgICAgICAgICAidXNpbmcg
c2dlIHNlbmRzXG4iKTsNCj4gDQo+IEkgdGhpbmsgdGhlIGlkZWEgZXhwcmVzc2VkIGluIHRoaXMg
Y29kZSBpcyB0aGF0IGlmIG1heF9pbmxpbmVfZGF0YSByZXF1ZXN0ZWQNCj4gdG9vIG11Y2ggaXQg
d291bGQgYmUgbGltaXRlZCB0byB0aGUgZGV2aWNlIGNhcGFiaWxpdHkuDQo+IA0KPiBpZSBxcCBj
cmVhdGlvbiBzaG91bGQgbGltaXQgdGhlIHJlcXVlc3RzIHZhbHVlcyB0byB3aGF0IHRoZSBIVyBj
YW4gZG8sIHNpbWlsYXINCj4gdG8gaG93IGVudHJpZXMgYW5kIG90aGVyIHdvcmsuDQo+IA0KPiBJ
ZiB0aGUgSFcgaGFzIG5vIHN1cHBvcnQgaXQgc2hvdWxkIHJldHVybiAtIGZvciBtYXhfaW5saW5l
X2RhdGEgbm90IGFuIGVycm9yLA0KPiBJIGd1ZXNzPw0KDQpZZXMsIHRoaXMgY29kZSBpbXBsaWVz
IHRoYXQgbWF4X2lubGluZV9kYXRhIGNhbiBiZSBpZ25vcmVkIGF0IGNyZWF0aW9uLCB3aGlsZSB0
aGUgbWFudWFsIG9mIGlidl9jcmVhdGVfcXAgc2F5czoNCiJUaGUgZnVuY3Rpb24gaWJ2X2NyZWF0
ZV9xcCgpIHdpbGwgdXBkYXRlIHRoZSBxcF9pbml0X2F0dHItPmNhcCBzdHJ1Y3Qgd2l0aCB0aGUg
YWN0dWFsIFFQIHZhbHVlcyBvZiB0aGUgUVAgdGhhdCB3YXMgY3JlYXRlZDsNCnRoZSB2YWx1ZXMg
d2lsbCBiZSAqKmdyZWF0ZXIgdGhhbiBvciBlcXVhbCB0byoqIHRoZSB2YWx1ZXMgcmVxdWVzdGVk
LiINCg0KSSBzZWUgdHdvIG9wdGlvbnM6DQoxKSBSZW1vdmUgY29kZSBmcm9tIHJkbWEgZXhhbXBs
ZXMgdGhhdCByZWx5IG9uIGlnbm9yaW5nIG1heF9pbmxpbmU7IGFkZCBhIHdhcm5pbmcgdG8gbGli
aWJ2ZXJicyB3aGVuIGRyaXZlcnMgaWdub3JlIHRoYXQgdmFsdWUuDQoyKSBBZGQgdG8gbWFudWFs
IHRoYXQgbWF4X2lubGluZV9kYXRhIG1pZ2h0IGJlIGlnbm9yZWQgYnkgZHJpdmVyczsgYW5kIGFs
bG93IG15IGN1cnJlbnQgcGF0Y2ggdGhhdCBpZ25vcmVzIG1heF9pbmxpbmVfZGF0YSBpbiBtYW5h
X2liLg0KDQpJIGFtIGZpbmUgdG8gaW1wbGVtZW50IGVpdGhlciBvZiB0d28uIFBsZWFzZSwgcmVw
bHkgd2hpY2ggb25lIHlvdSB0aGluayBtb3JlIGNvcnJlY3QuIEkgZ3Vlc3Mgb3B0aW9uIDIgaXMg
dGhlIHNhZmVzdCwgYnV0IG9wdGlvbiAxDQppcyBtb3JlIGNvcnJlY3QgaW4gbXkgb3Bpbmlvbi4N
Cg0KVGhhbmtzDQoNCj4gDQo+IEphc29uDQo=

