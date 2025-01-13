Return-Path: <linux-rdma+bounces-6972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037EA0ACFF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 01:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE69E3A66DF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 00:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D03C133;
	Mon, 13 Jan 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EPaue9o5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D9182
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736729699; cv=fail; b=hOb1+3UAIrD7eceIMMpaqB0mxZ6hchFWtxMBqaZGMix8GXdQ+9mmEcrRCpJxZFoL85mBiuh6yG9JhGOfaB6PzwwB3D3tBsYs0rKGTtgJhyA4PXtYo4IVsMYCTHoQ/T6V2AW8tXd4fFUSX/AB74armo0UvZQLzDnHHPUWhGGaNxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736729699; c=relaxed/simple;
	bh=KlT4LdJzn29kHpGAAs/3p4mz1aqtcI02e44RGMY+SKw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQLNzvzzNuFhLfRFNO5dDKJRa+G8qDpHTA32z5oDD4FtpOCpll54LR4dIu0FPqsbdbf4U7VtZ1VmE+07SS7vgf0MgzNj0XjwqGhW6iO24oD4PHXLzLzhvRJnh9VUzBM/MpQGAVijoZr/RkOH2FdcZiv2u07WRVbpKBUpujcvyes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EPaue9o5; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736729698; x=1768265698;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KlT4LdJzn29kHpGAAs/3p4mz1aqtcI02e44RGMY+SKw=;
  b=EPaue9o5XDRPajQ6xWu5Wr81PKbS1rUZ9W7dL19PzUiuBF2C6uKbYrp4
   hNHuOUQoFC5IXeSFGa2BHC/tEB3KP9GAGmbLKMql1uxnWYouJ2k80xnBS
   bWiR5eRFKGo8tjSKgLVP6hU7VIJnA9pGENHJXsKX4V/VJxTurdTkNtGxf
   gFmP5oSeMnq7Xhkb4k1jeLFNpitcgtP2y8g0C7VuEymJBlNtQRjatHsPC
   46d9p/1caa4j79Q2tHrcvST4LkMpg0U3D/IsNHbM4BXAtLaRr4BRxBe39
   Bqlylx1eGx3A376mR69TPE64nsfQQF4Un0fzLeSDvZBEUXqQ25odKWGd/
   A==;
X-CSE-ConnectionGUID: Yi4wDd/mR9KK6BElynxcvQ==
X-CSE-MsgGUID: bSMPJ9k0SKOqG9h+ucYaNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="53717695"
X-IronPort-AV: E=Sophos;i="6.12,310,1728918000"; 
   d="scan'208";a="53717695"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:53:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieYBZ2KbiM+juSryoyBgRyKX5onHTWBaxgUUHzm9IP6huVAN78gyLmcZPd8LPICsMAe5ETNoU4gYMr7h/69LD0cNHK9rcp1ebu0JVp05vH8wBx/AbxNj8niVcAVqO6al6iH9tt2jsMClAG0iRCZhU4rQY49EeYVsRUSgEcjzZy87m8m4BxKsHtk+oy099dH+AEWk1WmoJeDuDBdzyuCUQPg2NJy9Z1GV1+fp+6J1o0WrVws+mYu8yMoR9M+JoKdplPcV4u6ISgUy9rSwtOMBk/u4fcQfLzdOhV5g+C4XiWrHVnAos1fTdaXRU1U1Q1OhewULH5JAXqGBjLRD1G8vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlT4LdJzn29kHpGAAs/3p4mz1aqtcI02e44RGMY+SKw=;
 b=rHTztHhulwMIUzU8hE2Ucl5bC0fIeRX1LXAk25yRgrMUZw2chL+vvNwJhMNwUdg4dXxkCzD0osTAXW7Ed9kxSY6JZ6dbLsDrxf077GDBz1xd0Y5V/YtGfgmr+sx5NY8GOmwrnuK+6ytV7GJYXSoJphDYGdfiIPYqw4cntqmibyXIvHSLpFWEQr0HmwHATEanRgff//Uu0su1CGdkkvJWsA+qqvXw3PBm9ZK6/IksLsKORBcyZKAWskuVTEgAEeZTU3dlmW+vvFtd6W2UhRVl9EAhXA+rkr6dJIA/YGsuP7DEsruAlAYVc45TuZ7+P23ZlvsMTmz39TrHIeLUack6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB10599.jpnprd01.prod.outlook.com (2603:1096:400:319::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 00:53:42 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 00:53:42 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Change the return type from int to bool
Thread-Topic: [PATCH 1/1] RDMA/rxe: Change the return type from int to bool
Thread-Index: AQHbZBOR3G5VbKT240CFyKmz3DlgubMT4wWA
Date: Mon, 13 Jan 2025 00:53:42 +0000
Message-ID: <947653a5-5cca-42f6-a85c-f74773f2148a@fujitsu.com>
References: <20250111102758.308502-1-yanjun.zhu@linux.dev>
In-Reply-To: <20250111102758.308502-1-yanjun.zhu@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB10599:EE_
x-ms-office365-filtering-correlation-id: e6574af4-a1e0-4626-452d-08dd336cb9ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nkw4U0wvT1l4OU5TN1ptRjFhbkkxQmdOeFN1RjJLYlhuWXhhQWU0djZIdVRt?=
 =?utf-8?B?eHNxdnNGSWx4Nm13dlNoenN3VlY1SFZyNnIvT0x4YTM2UU5JSTRHOGJJS2x1?=
 =?utf-8?B?Z0E5bmRqVXU4ZTRTUFZ4TVQwNVoyNHFRWW1remIzb08rUWhzRkl5aDZzUHBN?=
 =?utf-8?B?WWtuaUJKUkRYOG5VRzNpcjg1OHE2dDZjTjYvKytOSkljdVExcG05aVVmeW5j?=
 =?utf-8?B?a3dEblFUeFV6Z0JId1E2QlJYRlJVV0g1UEt2aEZJMklFeEFjalZsMExQWERT?=
 =?utf-8?B?NnQ2Q1dPRzJVU0RBMDJINGpOSElrUVZBTXo5QlRYcXYySXRpNDVxZVQraXUx?=
 =?utf-8?B?U1oweUNBMG5vREVqc1c5UXFETlZ3ZldrN1VDYXhYK3RtODZWZEw2U3pERUUw?=
 =?utf-8?B?emt2ZlpqYXRWRndqd1NyWFNjYjRYdFFGWkZMTm1WcnVPRkZtWko4NUZCQ2pN?=
 =?utf-8?B?ZUlRQXljRE1LNzA2SVpPNjZieitPaFE2TEZvU3NjMjJUSm0xTk9CaEhnNzNh?=
 =?utf-8?B?QzFCSFV3RXhFTGhNRXlUbWtlb0F4R3B3M2dJMHNFSlU5WUdiZ0NSeks4Um4x?=
 =?utf-8?B?NDcwbUlocC9BL0tueEZLZmZzSXA5cVJJVzIwWkZKZXp5SmVtd20wVnRSNmVr?=
 =?utf-8?B?eE1WUmxEQVl2Q1lpanB3U09vTUp4K2VLbWF6bGtzNDVNd25NZDVoZnFlSUFN?=
 =?utf-8?B?NnVoYml4ZU1xbjZGN3J5S01XMExpTlFWbW1mRlNaUVVGWG5VaUpWTnJrNjd6?=
 =?utf-8?B?ZFU0WHVUd0FpNHFnbjYwMnMvQ0tHZHlQYjhMeE8yQzQrcDR1eGRxN0Uwc1ly?=
 =?utf-8?B?b0hRNVpxa2FNQ1FSM0tlaEFKVk5KaDJWeWZOUkpjVHlZbUxyTE9qc21OY0hD?=
 =?utf-8?B?ZkJnNXg4S2d4STRSNHI2NUVUSDdHdE0xMi9ISGdqOWg5UklsSVpFaS9LZ0lI?=
 =?utf-8?B?WklkT0JrbDQ5amErNUR3K3k2SERnNUpuQmVzTU5DUGl0bm4wQzIveENFZ0Ny?=
 =?utf-8?B?S20xNWI0TjJGVXovREJBSnhEbVpxdGF2bURmNkY2S09vdnFDamJBWjRZSnNp?=
 =?utf-8?B?Q3FmRitFMGZtVVM1ZC9HTDNGTjNmQ24rNGlQeTlEczBMK1BSZ1NPS3FCSUF1?=
 =?utf-8?B?cjZkdGp3TEVGUUtyd25MR3Q4L0VkdEZudHlwdmxZVWl5T3lscFcrcSsyZnE5?=
 =?utf-8?B?UkVUeDhEUkZCa0J2Z3ZxYzRQZ1BvY1dKUVA5eElpRm5ieVZ5bXdJZkZNSU85?=
 =?utf-8?B?MEVwQ2Z0YXpLUVo5WXhxN0RHd1FuNFV5OUVGbEVEbVdaK1Y1WlhKT05hajJ1?=
 =?utf-8?B?MFhNOXZ3Z0tIenRsbGV0aG5Xa0ZxSytUbW1RYi9VUURvN29IVEhVRHh2b3Iv?=
 =?utf-8?B?dzRMTkZqQXRpVTk4T0xXTDhNVWdxYm8vbkJoUDJsVVhkTjlnRkZRNU1FQmJw?=
 =?utf-8?B?RkIwZlN2Yjc2ci9KSldmd1FlNXNkcHo2SWpiSFhYV1g0Z2lLLzNPb2dxdVps?=
 =?utf-8?B?Vkpmc1N1VE5VdDJmVDRDNWRhYUN6ZFdQL1FndU0zcWhuZ1V1WFQxWXpTTW1S?=
 =?utf-8?B?N3hJNFR6cFpNMkJEWUlOWlhHbnVBNkRDK3hrZlloMEpzcFlzaDYvUGM0dFhB?=
 =?utf-8?B?ZXkxT3BvcUVQVmtzdytvQWt4dy9NbGprRlJqekRBMm1ZSUhzb0IzTW5xeVJw?=
 =?utf-8?B?eWJSNHVrYmhFbjRyajVob1RIUVEzS0hxVlAxalhjMmtaaVBHdlNaRUEvczc4?=
 =?utf-8?B?VlhLUTFYMGN0SGJyTXJqVUticG9HMHdIK21QQzJiNE9ReS9kVmlUbEswZ04y?=
 =?utf-8?B?N0RxWW9DWnlScTJTTGMySVFjVW1lMmZEeTgwSU9zMEpaQ3hNV1VkT1hCZitJ?=
 =?utf-8?B?R0ZkcDAzR2ttdTg0MWVGWTE2YWtGeDQwYXowTFBCTG9CcUllNUpIS2d4QW9Z?=
 =?utf-8?B?M2V3V0RrUVF6YWd4SFlPSzVBU1M3RnVkTXJobUJxZlZzbkNZZkJsZVZmOTFK?=
 =?utf-8?B?dkhoQXNSNC9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDZHQW9SUSthZVhSclhpWjFQMVlienBKZHM4UEZueFMyMGxCZHR0Uk5sT2U5?=
 =?utf-8?B?SmM3WHBKZWwrZitReEs5dG9qK09CWWpjUVlwUUg1NisxcVV0aXZJRGJmRlE5?=
 =?utf-8?B?aVBUeXQ2bElsd1Z4SEpDRXQyc2JCeVF2UmU3Y1YvbzZ2VUtWQ2RZWXBKZC9p?=
 =?utf-8?B?VkkzQTlUSnRzbHUvS1BLNThOU1YvZ2FrazFUdE43WXl6MXFnLzQ5RlpvdlA3?=
 =?utf-8?B?ZWR5VndydWJkdTNmZG1ENGo5TGZzZ0pHM0pPTVhQcnVJQ0h5Q01LZ1ltbG9o?=
 =?utf-8?B?OHdhYzBaa2YzK09FVmdwa2kxc3Z5L3VNUERiVWo2NWRiUUlxVTdaTzJ2bElX?=
 =?utf-8?B?VTQ3Z3dtT1JwMmI3UStaVUhTdW9yQnd4Mk41S29xbEJqa2VLcHdVelgyUDN0?=
 =?utf-8?B?MVJydi9sVExORWlvKzMzaHNnM0lQdGFCc1hldmIwSUdUK3NPSTFUSVNXK3ZN?=
 =?utf-8?B?UlB3VVEwb3BWWlR0eTdCa0JRUko3Y1VEMGVYR1hlN29tS0RPaHM2SVVPTkRy?=
 =?utf-8?B?MVNRVUU4NzdDcTdKY0svYUtxc3lxTEN5TGJ5YUtxOUhCV1VjSXdtV2pHcGZ5?=
 =?utf-8?B?YzlqYVgxQjNxV1A1bnZmMjY5d25kQjZrVmZZM0pkYWp4Y2ZMN0ttKzVjWnZG?=
 =?utf-8?B?Z3FLUEFrZ3NuelNENmxtQkRDSEZkeEJPK2xBeGVIN0tZSXFEY2JmQUVnVWg3?=
 =?utf-8?B?emhpQnZmTWMyU2ZCaWxFeTZObXNkamlCUEdORDB0a0d6Smg4K3h3SEFGVnVS?=
 =?utf-8?B?UFlwUXpDZ1I3MFhxNVpoOHZIUmtRNndsRjFLY0k4QmxFYUpsQXQ2aUN3L0hp?=
 =?utf-8?B?SDVBcld2Z2FzR0tNOXBnSHBsT3NHWU80OTR4Rm9YZFBmZ0g4OThaQ2FiWENY?=
 =?utf-8?B?QjJPNFRURVVhalI0aWFGY1NsRzU5aXdRNmI5V211c2VoT21sUitOOUZhT1Z3?=
 =?utf-8?B?VUFXWE9LWVBIeVYvOHc5U0tvNTFZakRuVlpHTGl2SmIvaXJIRitQZkFRU0Q4?=
 =?utf-8?B?Yzd0K0JoTE1mR0pYeWVhc2VEVnFRbUMrQ3NVQm43ODF1MFBRdWJjSVFOL1Z4?=
 =?utf-8?B?TWJ3R0xjSmo0YTY5L1psTzl4UTFFcThmSkcyV00vQ08wVFNibWdaZENNdGxU?=
 =?utf-8?B?N2V2UzNDd1d0eVo0eHFFWXorOUR3cmlwV0pTYm5sR0JPK2pQQ0x2KzlmVU93?=
 =?utf-8?B?WnFUQk1uZGx3NnRLMEl5dEovUVRWNFUxL1VwaWQzOFBleVFmTkgremlXb1hx?=
 =?utf-8?B?MXVGTEJyRm9VNVB2QzRaVnpoWjhHUkR1Y25qaWIwRk9ESWVPTFJ0S1pXUGhm?=
 =?utf-8?B?bkpkMFF5NXVyL0gvY2VNTmFjdVYzd2w2QVA2bXBpRGFCY0JPNGJ6NXJncGNS?=
 =?utf-8?B?bnNNUnlGbVRBajdmNmtQNkFmb3dES0poNU51TDMrUzFQQ3hlU081bG43aUpq?=
 =?utf-8?B?VjdPU25LdW5GbEx6QjhMak9JSWN4Nk41SFRYbmV6cXlpN1A5SWNlNHZaVHF4?=
 =?utf-8?B?bys0aEE2Ulg2cmF5RVM4dXRPS3lKTEg1UzQ5Q1NGSjg2ckF5R0NTb0tDa0VG?=
 =?utf-8?B?VU1Wd05pNTlvT3lyaGFZSFFIQm1IdzUyVU4wMTJSMWxNbWtxMEhGV2d3alRs?=
 =?utf-8?B?eXIvTlZPUFUrWnJ6MGxZZ2JMVGY3UHVjNkFHSGxCSXRFS3dOTWFwSmVoN0RX?=
 =?utf-8?B?VnZyWng4V2lOSVppZkdITnVjanB0dGMycis5TUptWlQwZHlFOXZZK1JRWGJS?=
 =?utf-8?B?WDlLMXlmSDgycldudk82ZWQ4aTE1RE5VeFhPYXpheVpTdFhyNVNrd0U1R3kr?=
 =?utf-8?B?VHJvL0dTNW1jc2tiTHg2Z1QveDhvZ0hKNVdDc3NNWW8rN0EzUVpNYzFKVldi?=
 =?utf-8?B?QVhCSmpuN3Nlc1VYbVJrMFNGclI0WTJDTmc2T3h0VnBISldOY1VYNXFVa3kz?=
 =?utf-8?B?L0pMNmphYzFqKzFhRnVMS1VxdkErVUhOQVc3S0VjaVRsY3JvZGg0SE0xUW4y?=
 =?utf-8?B?cEpMM2YxK1E4YlptS01NZ1RjdEdlL1JybHVxOVNkMUkwZUVxNERJYWVISi9s?=
 =?utf-8?B?cENpNjBPdE9kK2hXdUxpTjdSMWdoY25QMXgzWkxnNjdCdXBidER4eExUaXdR?=
 =?utf-8?B?czI0QkdVN1ZLaTdidThiSkJrbDRTREVTbC9yaE11dVlDbE9HUHVFVzBWVHgx?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9462049FF4942747B03F2DC42A5283EE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d2dgJtyIDlO1MssfBnGi7QAptyI+9F9rQmSxxRqOEMO6v0TaZi2mVkFdEqqB1WFKQkbMtP6XirHC5iyd3y8KR/EGXI8+SpJF76pafFZwe9UGSffC67T2z410jhfKF0+SOGcvyExzPJPO0HgJWzYBxU2nXqg7pgf299H2nzBayVwmyf/1kbaNlhq4gIVlJOIyP5qaaMNkmNXhf3JX/CWG06oxn1RM/teZDpaiNaSRUxaINIEBweNy1JPYWBzZAA868MSsNv3EOWtpVHdKY9AYwXKH5xlgGSg/aqi47ZzAoRe2tN875QbIX9LFeWyF5qwF53zH5PO85WHU1a7PDLa7r+ys2EIXqGy4TB45DQyYmimHfcMpI/s5jExinT+C1Qypq4np8YUMMb1+mFSyEY4jMW9eP3MeITQ7B4qsI5ILrN3nswH48H2Dtu9KA45mBHrJGNMH/OWvcgK0z2K/2/OKH+i4l1KVrp4SMkcK9uSLLwvDrkVWjM3pEW3EYYR+vd7Z8OGcq0O9vDDtZum3M5VnriFSKItEDnxg64CnrelPUKk/1qSPLAd0Lr1kHLIxwgb6+XVVdVBBq0eNQfJST3s5YNMfrI6qXWnhU/Z4RxqiGYSWfN0FtbPdzf9MeUPJNFE1
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6574af4-a1e0-4626-452d-08dd336cb9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 00:53:42.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UA68/Sm2lHHi7sPbRpEtoTvK+OuDpxQ6RKE0E5u0uHRLQGn/S9z3T+RoeXSDLsMvFHuZqlsWKlu+mugaoXNazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10599

DQoNCk9uIDExLzAxLzIwMjUgMTg6MjcsIFpodSBZYW5qdW4gd3JvdGU6DQo+IFRoZSByZXR1cm4g
dHlwZSBvZiB0aGUgZnVuY3Rpb25zIHF1ZXVlX2Z1bGwgYW5kIHF1ZXVlX2VtcHR5IHNob3VsZCBi
ZQ0KPiBib29sLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KPiANCj4gRml4ZXM6IDg3
MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgWWFu
anVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCg0KTG9va3MgZ29vZCB0byBtZQ0KDQpSZXZpZXdl
ZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY3EuYyAgICB8IDIgKy0NCj4gICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5oIHwgNCArKy0tDQo+ICAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYyB8IDYgKysrLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY3EuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX2NxLmMNCj4gaW5kZXggZmVjODdjOTAzMGFiLi5hMmRmNTVlMTNlYTQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NxLmMNCj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY3EuYw0KPiBAQCAtODgsNyArODgsNyBAQCBpbnQgcnhl
X2NxX3Jlc2l6ZV9xdWV1ZShzdHJ1Y3QgcnhlX2NxICpjcSwgaW50IGNxZSwNCj4gICBpbnQgcnhl
X2NxX3Bvc3Qoc3RydWN0IHJ4ZV9jcSAqY3EsIHN0cnVjdCByeGVfY3FlICpjcWUsIGludCBzb2xp
Y2l0ZWQpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgaWJfZXZlbnQgZXY7DQo+IC0JaW50IGZ1bGw7DQo+
ICsJYm9vbCBmdWxsOw0KPiAgIAl2b2lkICphZGRyOw0KPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVl
dWUuaCBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3F1ZXVlLmgNCj4gaW5kZXggYzcx
MWNiOThiOTQ5Li41OTdlM2RhNDY5YTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3F1ZXVlLmgNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcXVldWUuaA0KPiBAQCAtMTUxLDcgKzE1MSw3IEBAIHN0YXRpYyBpbmxpbmUgdTMyIHF1ZXVl
X2dldF9jb25zdW1lcihjb25zdCBzdHJ1Y3QgcnhlX3F1ZXVlICpxLA0KPiAgIAlyZXR1cm4gY29u
czsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIGludCBxdWV1ZV9lbXB0eShzdHJ1Y3Qg
cnhlX3F1ZXVlICpxLCBlbnVtIHF1ZXVlX3R5cGUgdHlwZSkNCj4gK3N0YXRpYyBpbmxpbmUgYm9v
bCBxdWV1ZV9lbXB0eShzdHJ1Y3QgcnhlX3F1ZXVlICpxLCBlbnVtIHF1ZXVlX3R5cGUgdHlwZSkN
Cj4gICB7DQo+ICAgCXUzMiBwcm9kID0gcXVldWVfZ2V0X3Byb2R1Y2VyKHEsIHR5cGUpOw0KPiAg
IAl1MzIgY29ucyA9IHF1ZXVlX2dldF9jb25zdW1lcihxLCB0eXBlKTsNCj4gQEAgLTE1OSw3ICsx
NTksNyBAQCBzdGF0aWMgaW5saW5lIGludCBxdWV1ZV9lbXB0eShzdHJ1Y3QgcnhlX3F1ZXVlICpx
LCBlbnVtIHF1ZXVlX3R5cGUgdHlwZSkNCj4gICAJcmV0dXJuICgocHJvZCAtIGNvbnMpICYgcS0+
aW5kZXhfbWFzaykgPT0gMDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIGludCBxdWV1
ZV9mdWxsKHN0cnVjdCByeGVfcXVldWUgKnEsIGVudW0gcXVldWVfdHlwZSB0eXBlKQ0KPiArc3Rh
dGljIGlubGluZSBib29sIHF1ZXVlX2Z1bGwoc3RydWN0IHJ4ZV9xdWV1ZSAqcSwgZW51bSBxdWV1
ZV90eXBlIHR5cGUpDQo+ICAgew0KPiAgIAl1MzIgcHJvZCA9IHF1ZXVlX2dldF9wcm9kdWNlcihx
LCB0eXBlKTsNCj4gICAJdTMyIGNvbnMgPSBxdWV1ZV9nZXRfY29uc3VtZXIocSwgdHlwZSk7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYw0KPiBpbmRleCA4YTVmYzIwZmQxODYu
LmM4ODE0MGQ4OTZjNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfdmVyYnMuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5j
DQo+IEBAIC04NzAsNyArODcwLDcgQEAgc3RhdGljIGludCBwb3N0X29uZV9zZW5kKHN0cnVjdCBy
eGVfcXAgKnFwLCBjb25zdCBzdHJ1Y3QgaWJfc2VuZF93ciAqaWJ3cikNCj4gICAJc3RydWN0IHJ4
ZV9zZW5kX3dxZSAqc2VuZF93cWU7DQo+ICAgCXVuc2lnbmVkIGludCBtYXNrOw0KPiAgIAl1bnNp
Z25lZCBpbnQgbGVuZ3RoOw0KPiAtCWludCBmdWxsOw0KPiArCWJvb2wgZnVsbDsNCj4gICANCj4g
ICAJZXJyID0gdmFsaWRhdGVfc2VuZF93cihxcCwgaWJ3ciwgJm1hc2ssICZsZW5ndGgpOw0KPiAg
IAlpZiAoZXJyKQ0KPiBAQCAtOTYwLDcgKzk2MCw3IEBAIHN0YXRpYyBpbnQgcG9zdF9vbmVfcmVj
dihzdHJ1Y3QgcnhlX3JxICpycSwgY29uc3Qgc3RydWN0IGliX3JlY3Zfd3IgKmlid3IpDQo+ICAg
CXVuc2lnbmVkIGxvbmcgbGVuZ3RoOw0KPiAgIAlzdHJ1Y3QgcnhlX3JlY3Zfd3FlICpyZWN2X3dx
ZTsNCj4gICAJaW50IG51bV9zZ2UgPSBpYndyLT5udW1fc2dlOw0KPiAtCWludCBmdWxsOw0KPiAr
CWJvb2wgZnVsbDsNCj4gICAJaW50IGVycjsNCj4gICANCj4gICAJZnVsbCA9IHF1ZXVlX2Z1bGwo
cnEtPnF1ZXVlLCBRVUVVRV9UWVBFX0ZST01fVUxQKTsNCj4gQEAgLTExODUsNyArMTE4NSw3IEBA
IHN0YXRpYyBpbnQgcnhlX3JlcV9ub3RpZnlfY3Eoc3RydWN0IGliX2NxICppYmNxLCBlbnVtIGli
X2NxX25vdGlmeV9mbGFncyBmbGFncykNCj4gICB7DQo+ICAgCXN0cnVjdCByeGVfY3EgKmNxID0g
dG9fcmNxKGliY3EpOw0KPiAgIAlpbnQgcmV0ID0gMDsNCj4gLQlpbnQgZW1wdHk7DQo+ICsJYm9v
bCBlbXB0eTsNCj4gICAJdW5zaWduZWQgbG9uZyBpcnFfZmxhZ3M7DQo+ICAgDQo+ICAgCXNwaW5f
bG9ja19pcnFzYXZlKCZjcS0+Y3FfbG9jaywgaXJxX2ZsYWdzKTs=

