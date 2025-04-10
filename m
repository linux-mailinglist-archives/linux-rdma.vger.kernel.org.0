Return-Path: <linux-rdma+bounces-9332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6BA84517
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739674E2428
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F162853FA;
	Thu, 10 Apr 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HWJ7UXHI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2103.outbound.protection.outlook.com [40.107.22.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1177102;
	Thu, 10 Apr 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292226; cv=fail; b=hz+TWTQvSLyW14Uu/k0BWZkTSY7sBSHQpB1YAN70QQP67srzODsgZhLtN9uEGd2EnqnISEVWYAKpWxTtPcgvn/w/c1gJxW0AO/wVYNEMvu4S3Wxf7r5hLbtQBMGbKQaxWkCmbqWjjJUfDEiEW1fos11MK+x4gU/hj8/770leN90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292226; c=relaxed/simple;
	bh=Qjse71Fn1ydwiEoZnzI3wPtHdUL999I1tzk1UkWmMIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5CsK6SvuxooAheawPvwl1YgH+ULUUcUcWJzAHR0SSq9aHItT29GNbPMZixR+3xDp+8OZTVuqOGXujfjhVXIDnkfeZrcLb4Ht9yvpTGNeZ1cjCecA7qnX2LAlDKnPTNChK05A2vY0lqXy7i27CDpjhmGd7ZTqtHgq/oaKna79ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HWJ7UXHI; arc=fail smtp.client-ip=40.107.22.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoJaKbJ3q0yjH03YPI69CeIPr9PAjCUJcmSf1mmNbNpwU8Gx8Q0QsHqdf53YBDbQkczISKxagm2o383nHZZ+vtqHNXMIoxVGFU7k/yqxpIuFCRCVBomGUwq7U4FfIXXSWjL6U37I0HzBdrG4H5YFIEWDqhNqRKmvhSboBPmPW4XiWFzmxIcWh4doNNT/2JDwLGLTXSip3VZuUKbeBIWR6ByLJxzc4kpojvt/oOYmzKhBiUo7buWjnLsddx+plVldwaW5FcyhaMAWgM61Q1TuNZgeTwH8PSzhT8yzGUCGTRW7Fj3yPnWmVix9qtG7yVYKwrjCio3RnVAxHH0fQTPB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjse71Fn1ydwiEoZnzI3wPtHdUL999I1tzk1UkWmMIU=;
 b=UyG+gJHLAxrLGeVPV84ld4kyU4wH21NhTvHfaB05ZYofiK2eamuJnfRBW7d993A9xPfKwt1DkicLDNyBHzJ4N4pu1wsUxlrYutF+bsjjK0Jo8xwKgtmsZbCq0DBfujVIhgc+39MfXYYG6juSAxj2uMdIjGLxfkZJIFKQwBqv9koooaoB+53ppsANRVwQEVL8u0mida0bZwuc68XMMTmcfbOvOtgr6i3D8tkTj45Z6uBouP2mDq3MTAeqQOorvcEs2wxtgcwB42+DIZwI8dp/156Ey7mQ4OBQ4Lhyo8WckHUZo5PtposvH2+NtlvYy2RUG2PkDkOi7lJVt/kBu2EC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjse71Fn1ydwiEoZnzI3wPtHdUL999I1tzk1UkWmMIU=;
 b=HWJ7UXHI77JzKL0zRqEQV76xKmaB5L3HB5VGb81niIWrqFt8HNUcRBItVsTFgYVd8qMesa5f9D2UnnOMqa3IcR98mu15cOV2kUYOYRXYaR5qRmfJTRuk9+2DaZnEtaDzqFrqLDKHmiyOMtgcRZFCz0FQ5RZJD36flphFqYLjjh8=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by GV1PR83MB0756.EURPRD83.prod.outlook.com (2603:10a6:150:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 13:37:00 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%6]) with mapi id 15.20.8655.011; Thu, 10 Apr 2025
 13:37:00 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote
 atomic for MRs
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote
 atomic for MRs
Thread-Index: AQHbpXBNINhh0Kyq2kyjM0FKnySZg7ObSwYAgAGktFA=
Date: Thu, 10 Apr 2025 13:37:00 +0000
Message-ID:
 <PA1PR83MB0662535F57D8F09C1C99DDDAB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-2-git-send-email-kotaranov@linux.microsoft.com>
 <20250409122852.GL199604@unreal>
In-Reply-To: <20250409122852.GL199604@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ec5f2cf-cd8c-4ea9-9283-ea2b9d014051;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-10T13:34:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|GV1PR83MB0756:EE_
x-ms-office365-filtering-correlation-id: a788128f-e3ef-42b9-7b58-08dd7834c572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tm5qQXNMczBBRlIreVI2RkU4RUdsUXVpQmpKQjZOb3BkcnpKeHNManpkMWZt?=
 =?utf-8?B?ZzgwSkxiWmVEN0RjaitDQWZ6a0hMVk9Va1VqcG1SSjE5SkdQejFGK1dCdFdJ?=
 =?utf-8?B?ZzRHYmVGQmk1R2lGMXF4TjFtaVFPUjh1bnZrOFFNeUs4cDM0UzdEOHdtQzJK?=
 =?utf-8?B?NmU3bWlDbHJUcFh2OVl2SE9xemdITFdIbitxcXhRQ25yWTdvNGY1YmdqaERn?=
 =?utf-8?B?d1ZUYmUyR0dzUFNtSnBNSmJZWStya0pVQ1ZkK3ZtbVRGMjQwNzdHZWNkcVhT?=
 =?utf-8?B?R0Flc2ZQcWxVMkRXRGNiMXpwREU5WkxLMVhjYUZZMkFYbjFCSGNNcVJGMEtY?=
 =?utf-8?B?RkJhT1dlaGZXdXgwZUwrMkNkcGkzcVV0M1hkKys2UURyT2Q0T3FldjI3cS9Y?=
 =?utf-8?B?TG9QN3k0YU1uNGM2NktIZ25UK2YxY09oOFh1dnlWUmVxVlFmakFUWXd5clRR?=
 =?utf-8?B?RHV6bmJJZG45U2p4QkU4RGMrbXExNkJ2Vy9ETkNhallicVczZkVnNEMxdmRz?=
 =?utf-8?B?R1ljMnlSNUpaYUh5UitTVXVqSjR4TklrSXg5WnlEckdHVUFzTCtoZWFHS3dM?=
 =?utf-8?B?MWN4MkFSdk1FWmkxRVcwQlhxUjVVcHEvcW5UejhwMnNFbklRQVBaK2lJa3ox?=
 =?utf-8?B?SkpRNmRHdURwdlNtajBoeVQ1QnZQTjJpL0ExOVZvT1VUbDQyNmVOdFRQZ0cv?=
 =?utf-8?B?MGVMS252eWt6VndhLytod3FZTTZUeUhOVEZ3MmY0a2V3c0tzbDR1bkM4MUZH?=
 =?utf-8?B?Q2UrSGdDQnFxcXgyeVNkSWJvR01yOVp4Z2ZhTEJxMlMrbkVLbFhDbFNFOVN2?=
 =?utf-8?B?QnQ5RlRRZ2FydXRsaU5NOWxiTmFKamZIS2hNVXA5QXFMK2hraFU3emlPbC9C?=
 =?utf-8?B?SWhHTk5zeDJUUDZ6YVJ0bUFBbTlwcmZYdHhXZk85YlpBY0lHNUYxRVlkYm82?=
 =?utf-8?B?Vkw2RzZWbXRkNGZCNVhQck5jVWhKR08xM2dUREpiQkgvbktsTmZHcTdpK2xG?=
 =?utf-8?B?d2ZiaEl6R2dHVG1uT3VESUJ0UjNqenBZam1kWkdaY0pvanlFNTBOZFljUno5?=
 =?utf-8?B?MmcxWGJSdldxaStCWDB3dUI2NnZVUU53UGZ5K2dETHVkS3pnYmJCVkNjakFh?=
 =?utf-8?B?djEzVG1Ob3loRUZZckZlcitWeitiT2hRWkJIWXplL2xaTENSaXBRMjJFa1pk?=
 =?utf-8?B?MmNuT3hselVteWRJWm8rWVk1UHdiSXlFUDdCckR5dDlnU0FrQXYwaEFOSGky?=
 =?utf-8?B?bXdnZXdvQS8xcXo2RE12L3VYQnZDMGJTREx1ckw0TUtlaFBVeGhmN25aZlZC?=
 =?utf-8?B?di9IY1JLbEw1NUQzbmdQQTdHR3NVQXAxSTJTYkxWYzBLajNxNEtDUThqbmxp?=
 =?utf-8?B?QkI1WTFoSWZ6RzVORzVvZzdodkoxb2JMYkcrTEFIN2puTWg4ZWNzZGlURUxL?=
 =?utf-8?B?MDdGek5iMVcyaUlhejZ4SzFaQ1dtQ25ydTVIMVErYjFtTXpaM0FobW0zRHZN?=
 =?utf-8?B?RXN5WTlmK0JqNFdtYlJlcFlOeE5NT1JwTG5TQWx0VnVyY21pZ1RGVFQ2K29K?=
 =?utf-8?B?VmxyVFlWYXpDS0hYeEI1dkNQbXZUU0RNNGZqODUzcXNCbERkd3hCbGdaNXNi?=
 =?utf-8?B?M3IwYXE0WDBxOWZrT1NKYVJqUkU2WDFySFNkQitWblhMc1FNZThqYlQxZmdS?=
 =?utf-8?B?L0RiQjBVK29iTU9OODFEc3lEVXVRamlFdmFDMXZ5dGN3RFNtWjFXSWlIQ0VO?=
 =?utf-8?B?QWFGdnd5Nk9OZWJRdm1jb0MzaVFBYklpQVJ2YWJEY3cvdGc1aGNWb2tUOXIr?=
 =?utf-8?B?SFpFK0twQW1LQlMxSTRmY2ExT21Wa2ZsZ3R0RHh3azA4ZGJRZ2N4b0s0aWZR?=
 =?utf-8?B?Vkt2REFaRTN5SHJLY0lKd1dXQU9pNUZtaUppa25zOHhzTEordkk2VjJrZEdw?=
 =?utf-8?B?V1RzaDhQL1FtbEpiMUhVZ0c1NzQ0dy81TGhDQk5wdGFPY1RjZWpGM3JISWp2?=
 =?utf-8?B?WUNRT2xTTXNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckJHd3JRSC9aV0RrQ084WjUwN2g0OEpMTzkwMDJEeTRxZmZveDlqeXpMbk93?=
 =?utf-8?B?dFF6azFGVFRKUUp4bzJYenpxcVljNHdCNHNnbldYUFE3ZVo4Y0FQaXpCZWhi?=
 =?utf-8?B?REJFNlhYTGw2em1DMWFFYnNOWm1nMFNqUE5NU1V0ZWMwMVVaL0h4dVlOVXZJ?=
 =?utf-8?B?VGpZQzZsaVlqcmZja1VaV2lxRDlncTFtMVVmdDVLVTlncDJKaW5WZncweURt?=
 =?utf-8?B?MnNVMHZzU3I0Z3d4U0RIREZjWTh1TUZRMklRbmo5UGt3VCs2ZENGeVJ2MUs2?=
 =?utf-8?B?aEQxVnhSc1VOQTFuV0F2MlNIcDA0SE9wbjBJVUp6NHgxVEpnVHRYYWM2dHU5?=
 =?utf-8?B?WjcxSy9JRWJPVFJLWXpkbUJ0ZUcvcnVOd3llM2gra1N1WWJZb21uS3kyRzhI?=
 =?utf-8?B?Z3FtMGlLejRyQmZGSVhRTFduenRNdFNVS1JnaFVOZUN5UnVDa1ZtVitGeXRj?=
 =?utf-8?B?U3V4Zzc3cm51WEI4UUQyV0V2aWVsSDJxOGxzMmtMTmJXNGJrRVVVWXI1K0M4?=
 =?utf-8?B?ZjlNSVJ3ZU5WZlhLQk8yTmxyNFVVUjJPbjlKeEtWazI1SFRsb3NZQmNVRUpD?=
 =?utf-8?B?eENmUEFQZEk5WUR0M0c4Wm90OTdHaVhvUzZlSGFobm8yN2VoTDFtaXhiMnlx?=
 =?utf-8?B?SG1PdWppNERxN3Fvc3Q1M2s4Zjh0WVExNVJOZ0JwS3ZReG0vak1JeG9OU3VB?=
 =?utf-8?B?WncwMmU4NTNBeEVLSE9uS0NBdFBWNXh2RFNuWkhjbW03bGc1YTJRZW8rNm9K?=
 =?utf-8?B?ZStGNVR6cnFnUkIzdm1PUWQzR004ZW80QUs3N3VjenpqUWpJM3NXRzNBM1NQ?=
 =?utf-8?B?L1JxYWlibUdkQzN3ZW04WG84K0praU1veEc0Kzk4cVFrczFVaHM1U3NUT0xo?=
 =?utf-8?B?d3BSNzBZaUJpVHEzcUN2K0dOcFZFaGJCcnNnbFlFa0lzRU1ySTcwSEsycW42?=
 =?utf-8?B?czJtSXZ6Q3ByTlk0UGxDZXVnMEpLeHlmZnM2S2hMM3MzeXVQU2RRaCtickp1?=
 =?utf-8?B?L0xRZ3FQTXJGUThYVW1yZXNIZHkzZ2dXY1ZFZW5EaGRDeVlsZmowSzRUazhE?=
 =?utf-8?B?S2dGdjRqc2lTK1hvajZCOXg4clhRT2N2OEo4MmtsTXdsRUh5L05NVGQ5NGov?=
 =?utf-8?B?dmJLMHJaenlsNCszcG9oT1FUMzRJVkxEUUdFT1haSlNmcFVhQy9jOFRvTWxv?=
 =?utf-8?B?b2EydEwyb1MwUFQ1cWs0anJ6UGZmdXRyQW5zSFFXK1VESWN6Y0JaS25Dd2Z2?=
 =?utf-8?B?dUl3Ty9Hckd2RnU2eUZBb3BuZG1DM01peU1pTWNFTnFjRm5nSDlIdTQyNHJO?=
 =?utf-8?B?WDVBT3pUV3FFa1dyY1J1UDUvb3FwZWJKcUdTbHdXNHhxam9MZ1h6ckJKQkF3?=
 =?utf-8?B?TjdNT0o4TVBBdlB5NnZEdnBMK3JQeUF0OW1oQkczUHFzQTRkWTd6Yk5IN1gy?=
 =?utf-8?B?OFJZcGhLNUd6NjFreU83Q2JGNTNzYnp3MHNCanVzVkt1bXdvakhuSXkza3dr?=
 =?utf-8?B?a0dvaGt5YUJJellBUWd2c1lMYzRWOXhXNG9aS1BFTG5qK3VoWDFYUGtBaFRn?=
 =?utf-8?B?bDhFRGJBcU5mNUlNbWNjRHJNblhleTF3czl4eDNWN2ROZTJ0WVp3NnNQaTZG?=
 =?utf-8?B?N2tEUkM5d2YzSXNOS3dHOUNUT2wrRVc5RzU4NEhtdENtUUZ0NVpaSE1PWTNO?=
 =?utf-8?B?aERVdFlOeWZhT25Cak91L0taRnJITU1naEk4bzAyN3RobXZ2bjBVaS9HR1E5?=
 =?utf-8?B?cjFVNTFTTkxKckZVcU1ZeWdFTDRSZmx6L3NkWnZLNk41MWxLM05PdFdML3pS?=
 =?utf-8?B?MVFZNGxWUlVzTkVHVXQxZ0ZOYi81R2Z3N2RrdEl6RDdGN3Y3K2FLNitsV2NZ?=
 =?utf-8?B?ZGJZd3k4MjM1Nnpwd0VGb2p3Y3I3czVyTHBpSkkyN2t6d3B2N0dxMU55QjhZ?=
 =?utf-8?B?Z3FuVkZQaEZEbnF5YlJvTUJBQWlWcUpub2d0TFA1MjNyVjh5S0VLanhPRFU0?=
 =?utf-8?B?Sjd4TkxpOXJ3amlIaHJuK2lydkM5SEVNQi9kT1JjdE9sYkZhVnM5dEd5ZzhC?=
 =?utf-8?Q?yWKYdu?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA1PR83MB0662.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a788128f-e3ef-42b9-7b58-08dd7834c572
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 13:37:00.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/2qWGbWgYsfoQnvg0JmGnDAqg0TAxXxg2lBDDjiC1KWyFxxa0K48X6Cqkc40FBzb7PEkEQ55R9k4rw2lELFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0756

PiA+IEBAIC0yNCw2ICsyNCw5IEBAIG1hbmFfaWJfdmVyYnNfdG9fZ2RtYV9hY2Nlc3NfZmxhZ3Mo
aW50DQo+IGFjY2Vzc19mbGFncykNCj4gPiAgCWlmIChhY2Nlc3NfZmxhZ3MgJiBJQl9BQ0NFU1Nf
UkVNT1RFX1JFQUQpDQo+ID4gIAkJZmxhZ3MgfD0gR0RNQV9BQ0NFU1NfRkxBR19SRU1PVEVfUkVB
RDsNCj4gPg0KPiA+ICsJaWYgKGFjY2Vzc19mbGFncyAmIElCX0FDQ0VTU19SRU1PVEVfQVRPTUlD
KQ0KPiA+ICsJCWZsYWdzIHw9IEdETUFfQUNDRVNTX0ZMQUdfUkVNT1RFX0FUT01JQzsNCj4gDQo+
IENhbiB5b3UgZW5hYmxlIHRoaXMgZmxhZyB1bmNvbmRpdGlvbmFsbHkgd2l0aG91dCByZWxhdGlv
biB0byBydW5uaW5nIFJXPw0KDQpZZXMsIEFUT01JQyBhY2Nlc3MgZG9lcyBub3QgZGVwZW5kIG9u
IFJlbW90ZSBSZWFkIGFuZCBSZW1vdGUgV3JpdGUuDQpJIGFsc28gZG8gbm90IHNlZSBhbnkgY29u
ZGl0aW9ucyBpbiBvdGhlciBkcml2ZXJzLg0KDQotIEtvbnN0YW50aW4NCg0KPiANCj4gVGhhbmtz
DQo+IA0KPiA+ICsNCj4gPiAgCXJldHVybiBmbGFnczsNCj4gPiAgfQ0KPiA+DQo+ID4gLS0NCj4g
PiAyLjQzLjANCj4gPg0K

