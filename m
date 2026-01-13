Return-Path: <linux-rdma+bounces-15502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB75D18B35
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C94930248A2
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382B38BF62;
	Tue, 13 Jan 2026 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GcTuKI17"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020078.outbound.protection.outlook.com [52.101.84.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728F389DE6;
	Tue, 13 Jan 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307282; cv=fail; b=lc4ygxxj/lx3nL2wOx6Dypo6NPI4fyZmjuJW4w4gzb723F8O89kLJj/cdCbnfCDnYI0+WbIDSsO9t0qs39CPUV2iETXgfV502kZWPsTCYotNEPnLgF6Cm/bcd/OtJRuiGxpDf522HfjpICEop375B+gKiZXy2EYvcyO6t/k9a7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307282; c=relaxed/simple;
	bh=j7z/qG5ywfRvLHvTCTJ92CEwW//cRuiZ7ack0Nh3zQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ie7357PIHVICcLsj8Gw5+rRiiBXwTzkcwihj0241A3Dl31PmPn5VcMEmjfK3oiGJcjY3jclV4Sgf8PabGPu+tDk+yx5zjqtU7ycY2QQpL+EFQX4kwKzl2VPWKVVsYYwt3dTKItGSbbs5zN+kaWpgQP6rWK0hksTa/HhveXxCtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GcTuKI17; arc=fail smtp.client-ip=52.101.84.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkQ6gz9hQ7UNwTEeB/Vph0t/U39q0GpSyThGQyKCe4Xfp8jmbkA2EQXkRb5y7aSn47Dm9gHdZoWvR7Doj6C4uxwWWVvf0IV6xHZy0sCif+LrbHpllOqWlaq7slP2qJdanSxTabuTZu69/zQZHF5oEJgid8CQ3r3j8S9QJ2higrvOQloI2xX3BngB27+nPgN88wgN69BhopbOWZcn8p+D/Sf3j+vSDDzLhlZwKwBACY426EywbOvOyhPTq0khHQCt6BHvCwOwJYSN6D6j7Cf1XXPnkaeqpRfiILugPw0Bz3+FimuSqev/ziBS2oK++4nMCTWjfRWdKA5kPBghdT+iFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7z/qG5ywfRvLHvTCTJ92CEwW//cRuiZ7ack0Nh3zQY=;
 b=iAeIS1+TtaIvRgCRFA9l+VLqTotyvqu7FnIu7/7WXVu4UNUQv6T5zsS1Nb1uEw9gdWJx81bAFaSFffWAkrwJiwaKX3Ys3AbTEq7Vn0Iz+apqsVARXlgXnXYIm73aPev4jvEDOoqYVabYcGscNDz3ACATw4zEaveRoJkiHnwDGmBaa1vXBSoG0donQA/KifzGron7QF+resyrJqS0yRL8ZrmFueXHRx8nZBkY0dKXb8gONngdV+slacQkoGiv+sBotBlplR6n3sr7TRv/h5+b6XFiLNrpplMZi/hNOfTH0T2B0EumtH1d+6sZQ3aS84RREkVLRQ3IdSS7zWbBqqn25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7z/qG5ywfRvLHvTCTJ92CEwW//cRuiZ7ack0Nh3zQY=;
 b=GcTuKI17Dxou6M3e+fVQ+TrlX/ebo4yhYQAhfc6ilwM4qJ+0Y9G5mPL2JN/dtgZ1pnYs0qAxy9HM/aI3LP+7EKCg0KxXGeU4nX8NpgzPEEkfMVXrkUbT1KiKcKZ3F1BvbRU2ZN6P76CX23ctG9UzRAjIGLGPBi+kjvaiUUboSqE=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by GV1PR83MB0706.EURPRD83.prod.outlook.com (2603:10a6:150:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Tue, 13 Jan
 2026 12:27:57 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%5]) with mapi id 15.20.9542.000; Tue, 13 Jan 2026
 12:27:57 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type
 from the device type
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type
 from the device type
Thread-Index: AQHcgWS7Z+twYZwOwUu7i3llOPQeMrVOLgiAgAHZZ/A=
Date: Tue, 13 Jan 2026 12:27:57 +0000
Message-ID:
 <DU8PR83MB0975AC89F5149C284751B0A4B48EA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
 <20260112075233.GB14378@unreal>
In-Reply-To: <20260112075233.GB14378@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e0cb9d3-5fe6-46a8-a8c0-89b16e24cc63;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-13T12:06:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|GV1PR83MB0706:EE_
x-ms-office365-filtering-correlation-id: ee80855e-fcfd-49d9-35e8-08de529f2ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTZYTU5Ub015ZXVPU2ltdWsvR2NWSlFnTjk5L2J4SnJQNVBRT2t4TDlrMlpT?=
 =?utf-8?B?dGx2S2JUcWdzTnZjTzdUTFNncVlYLy9hdmZZUnkwOE9LOG9waW50dU95MCtj?=
 =?utf-8?B?SXNLVVBiVlVWNGJRb2RZOTRJclRUb0loTDBSZjdkaUlYekFJZ1gvT1pVZWxY?=
 =?utf-8?B?ZVRDRTRsK1AwdE5Xb3FHWGtURWdudTZwNzNKM2YraWYwdDlaMkdvOEp5dmQ4?=
 =?utf-8?B?Tlg5eGVNalRWNVo4VDhnVEs3N2t1ekw0dVltUTBIR1JLbVl1di9lZXZNSmxC?=
 =?utf-8?B?WTA2bGNxbjFKWjR1OWFrS2REQVV6M1A1NWFpdEZwT0M2UmZWZ1lENlRLMVRM?=
 =?utf-8?B?aC9jdzRCenlVNGVsYlhtSjZEeEVhVWlrTGJ5VUxLYkswNEJuandjbm0xR01t?=
 =?utf-8?B?bzB5enpmZk05VTU0WDRnVEZSVXgzU2dtTlFiR3A3ZUFzdFM3cVBGQ3RST1V2?=
 =?utf-8?B?REdUY0x3Y2lVUHd0TWZxRHBDWHNqenMraHNGSTZ6b01OR2JuSHNRbkIvbTMw?=
 =?utf-8?B?MGtwMDJJUkNla2NNUHBReE5XRTd3TTdVWHJDNG9mTlJpcUpIZUhOcEtJOUU1?=
 =?utf-8?B?S2U2SEhyc1JMVHlFcGJvcHh5TWZoYzFTWG5VZzYwcjVkMldaMStubG1jQkVs?=
 =?utf-8?B?UEhGeTBVQUw0cWIzcnhoWXVOV0oyYXRnN0JINGY3RW1LRWZNUWdFTVRGR2lu?=
 =?utf-8?B?OHN0WWdNeWtTN0FBaDAvY0JLVzVlQjBKMG9xazg5cmxFSVlIdjRuZmJzZ2lY?=
 =?utf-8?B?a214U2VWWmR1QTRBYlk2V0JML3RuRHdXMVcxNzVmS0lhNi9tQVYycHV0Qlcw?=
 =?utf-8?B?UC8rbU9KcjAxTEZIcUdNWjlBU1VMYXZmME5ZQzBWTlVWcEVxNXRyMDRuc3hj?=
 =?utf-8?B?L3B6eFl3cWl6QVlPYkQyQ3QvWTQ5S0cvOUpCZzZKUXFiQmwrZTUxdWpMQnY0?=
 =?utf-8?B?cnJxN3FnVEZrUVRxdWFVYlJkOHhnMU5uQkx2eHJveHptb2lnRXFjUW5NVzdZ?=
 =?utf-8?B?T1RnREJEOGdkMGhEdmdjWE03Z1FDMmhra0JYTDZFOEdIUUYyQXU1WFpWbml5?=
 =?utf-8?B?T1BoQjdiNjN5QVR4M045TXNxQ3ZjYW42TFM1MzVHcmVqbVJQV0VpZGVIRGFI?=
 =?utf-8?B?cHczL0NuQlkzNFdpc1FHRkUrNUZzVm5OaUZqdmQrLzlzOVJSai9kL0orbzNM?=
 =?utf-8?B?ZG92bTBaTmZISkVBWGdoZWJNRVVUbHhHZWhrNE1sMFQ2cjFra3gxOUxZeFhu?=
 =?utf-8?B?b0tyV000Slk3cUhoc1NaNFBma1dvSUM5YUFwY2dMeXUvKzZ1a1Y1NVN1Uks4?=
 =?utf-8?B?dmEvRDdlQkY4cVZkaktPRWlmTkwwdG5SajY5bG5wYnV1T1BJcTV2Q2lMNzV6?=
 =?utf-8?B?T0FSVFJmaE8vMysvcFZ0cUc2NVc2enlqSjJZU0RWdlc3QzJEazk4RVdZUzFs?=
 =?utf-8?B?QnpYOSs4TDVOSmsxYnlVeUx0cjAzVkdlN2NpTzRDOXZuQlJIeFVOdVhwSjk2?=
 =?utf-8?B?SGlCajJiSFVHeUtJL3BvVUZ2OFhrejJVeHNIckxoZ2RzSXlyWjBhUGpaczhS?=
 =?utf-8?B?WG45Y2w5ZkhOUURZaFlTV0NDekx2R1J0TWJINVgrUnVpSTNnejFpZCtxQjhl?=
 =?utf-8?B?MWU4amxjQitxYlQ3VFh6UW1DZzR3OTNhcndhZzlxTmVoNGFteDNSNW0xQVN5?=
 =?utf-8?B?M1lMWGg5UC9yR3FJUUsvUmU4ZGI2S25heFV6Tms4ZWVBV05FYm11SjdnWjNE?=
 =?utf-8?B?K0FFOUNOWFJQaVU1UmtmWTV1OEtOTFhLa3FxTWY3blpQd1FTZ3Btb3JTSklB?=
 =?utf-8?B?cUYyNDRKQmMyRTRTekJQMDJvMjdzdEZiSFAyZjhrR01WSCt0bDU5am1HYzNY?=
 =?utf-8?B?MnA0R1NjK21RdmJYS3U2QlY0ZHlERGZ3aGtSK2JFQ0NBNWN4RWlFWjY5c2lZ?=
 =?utf-8?B?anRCb1ZrcTNoSVlvRnEzYzE0UmlWaVVubXp3dnBrYXVWblhvdHNTUW1hWGpu?=
 =?utf-8?B?RWQvaVZibzlvSkZ5cDFWU3UzdjV2c1FBUnp4RUhrazZDVWJEWVF3Snc1OVVt?=
 =?utf-8?Q?fzfk0n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXcxMk82Z1F3eVk0a1cyTWtlVGNHeTFvc082SzJub2FmcU1kTy9JYW9kaTI3?=
 =?utf-8?B?aTl1cG5aTDYvdDBKek03VjJKWDF3d0p1eko4cm1IMTRJYTJOaHVYVzNOeFZO?=
 =?utf-8?B?bjBHdGhGcUJRLzNMekZDWTVVSlUyRElScHF1TTYvTHlQckdLWHgrNFBtcEc2?=
 =?utf-8?B?d1hwNWdNQXZGNzZPZGZJcWhUTEZ2WXA3c2RvM0dadmlLT1BaWXhzTDJKVWYy?=
 =?utf-8?B?cHdsZHF2V1QyU1RjM09RdnRpcUVMZVdReElNRkNZM1VZRzRZMXlYcjNZZXhE?=
 =?utf-8?B?REdwT2wrQzM0MkUvbXFXSWg1ZDAyRk54QzNKYjV2dmVPQkVleHpmcmQxNjlY?=
 =?utf-8?B?Q1grUkdUWUFrbmZhOWZnaWdCaGEybUpndkZrY2h4Q0hPeDRtejk2RXFRL1NR?=
 =?utf-8?B?SjFwd2xSNGFESUluNmdqOHNVU01kNGtCcU5GMVMxM1RPdmxrckczNFA0SHJD?=
 =?utf-8?B?aVJPQUFWUGF1ekZrSXVhcnppWFVyN2JiYlVaL1laaWVBMmV1T216UTdEV2tZ?=
 =?utf-8?B?dUpmMFpBY2Q5SThyUTBvcEIvckhLVWJCRWFvV3hsRVpqQVpVUFIyYmdpdXU2?=
 =?utf-8?B?NGRaQWNWOUpRaUYxMjFIVTkwa3hVVXBzZGQ2MW04Yzhyb09QZG0ralRRcS84?=
 =?utf-8?B?SE9yMUZPYWYva2xyZ2kzTjB0RmlyTmRHVGJqKzg1ek0relBFcG9TUlVyanNi?=
 =?utf-8?B?ckpFNFFocGRLQUtPM0Z0QTFhMjRFWnNiUUhrTHVWS2E3YU9jSVlRYXlqM1RB?=
 =?utf-8?B?OVN6V2hPWWQrZVVmRVQ1aWxub0JQSnJ2VTVuUXRwc0pwYU1YdFRXUm9HcFVO?=
 =?utf-8?B?dnZDTDhXWEhWcFRabkovb0Y5WDNoWW81NG15T2tRVFR2R1NGMUJHamtSVmxV?=
 =?utf-8?B?RmVtOVFqeGpVWnpVV2Z3VXA1S255YzRWN0VPT0ZCdFlJczcvVU8xMXVIVHUz?=
 =?utf-8?B?dkNnN3gzTEZGQ0xTNHZreVZuRE9XN0pxMkpaR2lpVGcrcWZHQ1lZYWJJbWsy?=
 =?utf-8?B?alNOejJ5K0Q1ZmhPc3k3RzU0bTEvZ3ppTExxZHhMUTV6T1BkaEFWYWtXVXBs?=
 =?utf-8?B?c1g2dGtkRTZ5Z3pvZStyaUdBSEZYdG9SR1FhZVcwU0JmMWNPaks2L0ErYzBh?=
 =?utf-8?B?UjhkK0JqVmVHUEtLd0Q0V2Z3NG93SEZPTnRleE5ZNlkzSVRiTEN3Zys0NWU1?=
 =?utf-8?B?dUYvRWdCVjF0aTlmZGdlb2R1cXlmK2g3cW1lWmFpK0ZOZTk4V251NHBSVmRJ?=
 =?utf-8?B?ZzZnNS9wY25iQ0VGcFg4b3c1aHMzUGJ0UFVzQ0RQRE9rYXRZQTNIUDd6SSta?=
 =?utf-8?B?TklFWDJoRzlXYlUwNnNyMlpGbENob3FEVzB4Wmg0MTdFcUljTjQyZHlQUkdQ?=
 =?utf-8?B?K1dCM0k1a0xUM0N3K0pqSm83Ti9MNDZkQUc4ZUhrdDVOb0s5Z1BSeFB6SVlm?=
 =?utf-8?B?RWJCQ2g3dlJvZEJqSnU2NEV4b2JYRXdCcVBWZjM0WVpnc3hCcnRmekxOQ2Zu?=
 =?utf-8?B?UzQ4cGxSQXhFSFFZOXBLRGF5MDJtWTNMYkd2K0JmOEtWTVE3Z2ZpNS9ZUmxZ?=
 =?utf-8?B?NDFJUGs2aTdEVHY3dEFPV1QxeWdqWUlWenB5My9nanA4S0JscFlkOU1wRFJE?=
 =?utf-8?B?azU1TytqUzVZVkI1Nk03cFBvdFNpamh5SlZjdm9VK0dzQ0VUWVRlekJObDgy?=
 =?utf-8?B?dGlLeGxVT2U2bjE5dithb2I2KzA3eHhPdDFxSzluUy91RkdIdTIvd1h3ZzI0?=
 =?utf-8?B?d0xxWUgwZGhFMzBxOWpYNndxYVlYcXU2VjM1UzVzcnBZZ3oxU2sxRmVoYThw?=
 =?utf-8?B?VStWd2ttTjJlOWV5V1hmYVVENzExM0g2KzVzbXhPbzg2WDVaU2JtSzFLTThD?=
 =?utf-8?B?bUlsT0RSNFB2OGNNT2NGSGpDWU1Hb3F1U0xHU3FGcExnSEtzaFgwQ1VPZ2hG?=
 =?utf-8?B?U3BQY2l2MCtPU2svSzlxd3FscDlDWTNXSUVrSFBFb2Jzc3ErdlRVdW1vT0Nk?=
 =?utf-8?B?eW1oYWUxL0N1eW1DTkFqME9pVS85ODhwL0ZWWjJvU3B6aitsemJYTlNYeThS?=
 =?utf-8?B?K05ncGN6elptVm02ZVlleFNpK0NuV05UcDdBQjhrLzZDNGpBbm1SdTVYQk54?=
 =?utf-8?B?bFNqZjYyQUYzNFV0VC8yeUw5d3kvV2F3Q28yZGcrRzZFMld0YmdoV2VGMHdJ?=
 =?utf-8?B?ZkVxYSswYU1EcVlUOGhZcjNjQXVvWHR2Tmh2RVNpUHBBY3F6VnFvKzc4bVRK?=
 =?utf-8?B?cWIxblBsRXN2azQzckpmVXVxQ2xnPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee80855e-fcfd-49d9-35e8-08de529f2ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 12:27:57.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rm3xwbsrvDsc5nTRBC4jMbI55etI840Qj3n54hzpFfMKuIpJBVh3D0JqhwrBTYwI5eWptsA1YK5ZFmL3yEXbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0706

PiA+DQo+ID4gLQkJaXNfcm5pY19jcSA9ICEhKHVjbWQuZmxhZ3MgJiBNQU5BX0lCX0NSRUFURV9S
TklDX0NRKTsNCj4gDQo+IFlvdSBuZWVkIHRvIGFkZCBjb2RlIHdoaWNoIHByb2hpYml0cyBmdXR1
cmUgdXNlIG9mIHRoaXMgQklUKDApIGluIHVjbWQuZmxhZ3MNCj4gZm9yIGJhY2t3YXJkIGNvbXBh
dGliaWxpdHkgYW5kIG1heWJlIGRlbGV0ZSBNQU5BX0lCX0NSRUFURV9STklDX0NRDQo+IGZyb20g
VUFQSSB0b28uDQo+IA0KPiBUaGFua3MNCj4gDQoNCkhpIExlb24uIEkgdGhvdWdodCB0aGF0IG15
IHByb3Bvc2VkIGNoYW5nZSBpcyBiYWNrd2FyZCBhbmQgZm9yd2FyZCBjb21wYXRpYmxlLg0KSWYg
SSBhZGQgY29kZSB0aGF0IHByb2hpYml0cyB0aGlzIGZsYWcsIHRoZW4gdGhlIG9sZGVyIHJkbWEt
Y29yZSB3aWxsIGZhaWwgdG8gY3JlYXRlIENRLA0KYXMgaXQgc2V0cyB0aGlzIGZsYWcuIEFkZCBy
ZG1hLWNvcmUgc2hvdWxkIHNldCB0aGUgZmxhZyB0byBzdXBwb3J0IG9sZGVyIGtlcm5lbHMuDQoN
ClNvLCB0aGUgY3VycmVudCBzb2x1dGlvbiBpcyBhcyBmb2xsb3dzOg0KcmRtYS1jb3JlIGFsd2F5
cyBzZW5kcyB0aGUgZmxhZy4gVGhlIGtlcm5lbHMgd2l0aG91dCB0aGlzIHBhdGNoIHN0aWxsIHVz
ZSB0aGlzIGZsYWcuDQpOZXdlciBrZXJuZWxzIGp1c3QgaWdub3JlIHRoZSBmbGFnIGFuZCBjcmVh
dGUgdGhlIENRIGFjY29yZGluZyB0byB0aGUgY2xpZW50Lg0KSXQgaXMgbm90IGZ1bGx5IHBvc3Np
YmxlIHRvIHJldGlyZSB0aGlzIGZsYWcgbm93LCBhcyB3ZSB3YW50IHRvIGJlIGJhY2t3YXJkcyBj
b21wYXRpYmxlIGFuZA0Kc3VwcG9ydCBvbGRlciBrZXJuZWxzIGFuZCBvbGRlciByZG1hLWNvcmUu
DQpPciBkaWQgeW91IG1lYW4gc29tZXRoaW5nIGVsc2U/IE9yIGRvIEkgbWlzcyBzb21ldGhpbmc/
DQoNClRoYW5rcw0K

