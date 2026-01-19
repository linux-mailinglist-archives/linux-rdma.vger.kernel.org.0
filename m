Return-Path: <linux-rdma+bounces-15682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD1AD39DB6
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 06:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233693007C64
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74851330641;
	Mon, 19 Jan 2026 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Dhi8G5XY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AB2836E;
	Mon, 19 Jan 2026 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800294; cv=fail; b=LPZNL6FcHY9vxXv68aNXkp690epHXLAGN+S/2/8PLaT7rf2yBqvj9aEMZ4FSabzQXomlE5czU6gi1FZEzL2ZCfCLjd/VlFiCecbbHxQ+RJZkr2HH9+vCFOI/ryMIlYB2uxSPkhDErbkt2DajkcTpsgyD3g5yxUmOgmMi5XXGtpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800294; c=relaxed/simple;
	bh=ckRQ386ZKXR1Yw0sZvWMtutY+so3npN4YrmE/UWlEBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tg3dmBX9UWqw47BSYYfKNBJCtLzMouFtB8ALYsfjdgpPDdN5a+L5uCK5odbEkOMrrv6uVgPT4Obj8W9IVaSvLYUO6CrMji/wlrk4D71JBGpmc671eNDkQ6az4yFiHPVxJtQgt/wpJCis1ID0py0hc1lfQ+6+x3RdDqkrNx221Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Dhi8G5XY; arc=fail smtp.client-ip=52.101.125.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shdy2TtCf3/lwFsMLCRO7fN2z2QrWoAk45zd4sB8PNNLxM5ZyQkmUL/RPOg4a8/g0/r56Q+qHmyAU48chies1bofAgPBEtL8A+mBRJtFYw4bCPkxmxop9YsvMCapGP4N1qSgn1gPZt2LBAW14aNXl7ZMn/Q/X/VrQzsh6jT0HedwttUnB/x+nNHTb6XfysDrcx3+jRURCts3JG5Xk39avF9jskNq0n662uA4L0224Br2PUj857CKhf64gMNZwX79vx5GI+Koea6ur2Zy5gGDuHaTQXc70NNbMWk4i0YzwArC8ayBCskPIsRN5rE+OX/sXfgOy27LeVCt2DTXztK59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckRQ386ZKXR1Yw0sZvWMtutY+so3npN4YrmE/UWlEBg=;
 b=XoAmMV4nle9MAEytvNhCX8Wsy6GF/b83TLVGej8R40WomVGn9yNozv+4ZBDHfsnnU5PvZNm4Z+FE6+CpwaAaG3QezHtgo6abhnXTxfdKm4Catali/7wM0WxUugBxCOtvRbuBK//rK7cBHKUZiMjT5NY/tldtxnS97McmqHB9KoqueB4WdrSFSurw1oGuFWwbExGJrKtHvpPvmgPsEH19FGQWmdN+Oei5AthNtRZUU0vPmz9JjWTGwHTZio5kG0awQk2c/BPmMoI92eqw5zwo0KN9OVi+CbS/1fUODzp2tv8/5FoOZLSfHxyGxP/oQbTl6uuW9r2zXoPTOkkyexl0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckRQ386ZKXR1Yw0sZvWMtutY+so3npN4YrmE/UWlEBg=;
 b=Dhi8G5XYiLAbbMXEOHuCPZ7yfdtFlIMPiiBiDmW/nvue7ps+Aemn6OsZyoGbtzkYV7VMtrEbPNCLqP/tmu2EPWi29DKVZOf2X0C2vtHpAfmVPaqCHzKzc4LFGV3mghLfVHIAEqUVNA1P97Dr5TqBG7D2ElSuxL13XupJnSslzDQVRKoIxDpvzVt6DPvv+MunnOn06zb03/j2cmrSoedlDIusVOUQc8CqBN3ZwQ/M+yEh+hPJl6qtb7mLZo7ONGFRcNce7JlwKOy4CtC6cVdE4XP7UVbYQUjLQsDXjTJwOIjVVXOued4uB3d2NtfHe56FCjQsPCQ8WnPDHorbeelKbQ==
Received: from TYYPR01MB13036.jpnprd01.prod.outlook.com (2603:1096:405:1c5::6)
 by TY7PR01MB14552.jpnprd01.prod.outlook.com (2603:1096:405:243::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 05:24:50 +0000
Received: from TYYPR01MB13036.jpnprd01.prod.outlook.com
 ([fe80::b9bb:b7ad:edf4:b297]) by TYYPR01MB13036.jpnprd01.prod.outlook.com
 ([fe80::b9bb:b7ad:edf4:b297%3]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 05:24:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: yanjun.zhu <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC v2] RDMA/rxe: Fix iova-to-va conversion for MR page
 sizes != PAGE_SIZE
Thread-Topic: [PATCH RFC v2] RDMA/rxe: Fix iova-to-va conversion for MR page
 sizes != PAGE_SIZE
Thread-Index: AQHchpgm783zhNLyfkmrBSNVnCt637VVD/gAgAPqswA=
Date: Mon, 19 Jan 2026 05:24:50 +0000
Message-ID: <7134f410-b8bd-4eee-8332-4d4dbccae014@fujitsu.com>
References: <20260116032753.2574363-1-lizhijian@fujitsu.com>
 <1bc84ed5-6e06-47fd-a85a-c85ac8cc4118@linux.dev>
In-Reply-To: <1bc84ed5-6e06-47fd-a85a-c85ac8cc4118@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13036:EE_|TY7PR01MB14552:EE_
x-ms-office365-filtering-correlation-id: 1b19eb86-ac19-4543-d08e-08de571b1188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXhIdDRKY1N4U29ydEt4VGJvZktYbnV0eHpJbW5wTkdzZjRrMWFrcGlFMVds?=
 =?utf-8?B?VlRCTUsycnlhcXVmZWJSZ0UxTHIwNVM5L1F6TjF3NStNNXR1Y1FoUTk3K0Mw?=
 =?utf-8?B?cFZkUHkwZUhSRVV6WmtKcHJCV3BrdVZic0tIQUQvL2NRNVZuV25OcFI2Z2tR?=
 =?utf-8?B?d3lHZ3RPZURUTEVTMmFqNFlhUVdFb1VOVzl3VU1xSmtEUVVQUHY4Y1I1ZlA0?=
 =?utf-8?B?dFhOMFFOVmFpL2dVU05rYVRkQUdtZHZOTWorbkd1ZVBwZXFqWUowM2d3SEhG?=
 =?utf-8?B?cG9oSXc3UHZiQlVkajk4V0hjd2tQcnJaYmhiS3pvY3g0K1BiS2FpTGRVQUhl?=
 =?utf-8?B?MVF3M0Vyc0loTnFmbENXSHY2Y0ZIRjJKMjV6VEpGbGY2V210KzZpLzhaRkdz?=
 =?utf-8?B?alBnajdubFdvVDllNE5JUm41a0xXSUF0YTl1YjgyTzIvWndvTWdDeThUTE04?=
 =?utf-8?B?dGV1UlNpemtWMnBOYXB1VWIrclA2bzFrbGFkRHo2ZlRaRU51eFJGUWJnTWRn?=
 =?utf-8?B?aUVsZmgvL21LcVFPVHRRbGkxS1NqUzZJTkpwOC9ncUE0WkRpQ1hUQ0djeS8z?=
 =?utf-8?B?MjBiWkdSa3ZpWFQyMjlQMHJWSHN3U2pGajc5THBlVng3MmJtQms5NklJa2cv?=
 =?utf-8?B?Ritadmk5cmQ3eGYzQlZxTXVIdEpBMUpuYmhJVjNxMWYwRnVuU1QxenpSSUtY?=
 =?utf-8?B?S1ZKK1dLUEUrL3RmZldzN2FJMW5XL0J5Y28wQVQzOW94NzlhdkkwRVc1M1U0?=
 =?utf-8?B?TVZCdjhqdHgzZll6L0ZnQ1lLTUFSanZZUTlvV2xsV0h2eGMraG81dFFUZUoy?=
 =?utf-8?B?L1hpVW1Ec0htdXVGcUJsb3JYR2RuRFdXbjZQaGNNZXNQMEtPRnB4aUZ1RDRU?=
 =?utf-8?B?c2xFbTFRMmFadU12dmZjc21QQ1Uzdmp0QkhUV1Y2VFc0cURaeG1vSDhjMFpj?=
 =?utf-8?B?cnZFNGVSQ3NMbHFOTDI2L0FvTlQ5OENwV0E0U3BkOGFHSDBsd2c4NXBEa2Ru?=
 =?utf-8?B?TUdQa3VuSGlGbmlNazJ2WVgvazZGVmVxWjNmV09XK0ZQdDJ5OG8wL1luMlhK?=
 =?utf-8?B?S1NIWVVWV0Y0SEZ6ZldoSkNqSGlDSHNGVlBVMEJYOUZ6dEY3akU2VWE0M0Q1?=
 =?utf-8?B?NmR4ZHlBMGhNRVdoeFp0cWNJMlBVTkltMUtVV3d4ckNpMXJiK1ptVE5rTmN0?=
 =?utf-8?B?dUEyMGtwaDE2c1RidTkvSWRFWlNVaG5RVUhIbXZnZWZYSXJBMTNuYXpSaEl5?=
 =?utf-8?B?R1lTQUY3VFpVaUFGOThULzYzWUtHc3VGTlB6b0l6QWZjdmxqMjRzNE5rd3hj?=
 =?utf-8?B?T0t1MlBPNWlwdFY0eEl0QjZZeVNVODFmSUlwOWVXWDJrNFdxV0I0K0hGbjBs?=
 =?utf-8?B?MC9xeE9XR3NtcXVqZ0l2eTBFd2ltbWFUWko0WUh3U3dERlZjTFk5bmhQUVNh?=
 =?utf-8?B?dUo0V0dvRms2QmZYTXd6NGNhL29nQWJKV09DUFZ2VENUYnZwRHFVbHlvMXlq?=
 =?utf-8?B?OGZNdzlXc0QvR2REZTVueWtwU0M3eXZHMk9Ub3l1N1FzOHB5RE4zMGZSRVFw?=
 =?utf-8?B?cEVKRkdwSzUyTFJsWnQ2bkMwSHVUNjBERFBuRFhiSXhRUThUSWNnRURZc2l6?=
 =?utf-8?B?SHlGUEpNbHd4MlRiVlErZTNRcHFVdjlCNEFqNE5YT2Yxb3A5NzZZank0SVBy?=
 =?utf-8?B?elFZdzhvWktKNE9zUTh4MmRlNnVHMmxraW9NZjBPUjNjd0d6ZDl1UkRFWVJM?=
 =?utf-8?B?WVBmbExaeVBlM3lmY29LbEpzSWtXV1lZemI0RVNDMVEzM2hiZzRnc3hibWxl?=
 =?utf-8?B?bnNib0FQa084MGo5cktEZnJTSW5MaVd5MzZWdkVOQWUyTWlCK2JGd2JVeTNn?=
 =?utf-8?B?U2dmRy9laitZVllDaDBRSVh2TnpYVzJMZkRnWnd5eFJwcDFyKzB0Z080NjQ4?=
 =?utf-8?B?TVpKZFNPRDBra00ydG9tM1RRdmhDM0YwV1Y2ZVVJREhLZEIwTlBTblBxOGxY?=
 =?utf-8?B?Z3ZON21ZdkRaV0cwUXIxVXg1Z2JoZm1idTUxbEJvNkdVc2poZlJGalhKVDNV?=
 =?utf-8?B?L0hxcU9tbEI4NUxNWk15MFZzaW5zRzluNlBaQUsvb3pmZmlXRWpqSGIxK2hU?=
 =?utf-8?B?d2FUNG5pYTJTTmlINy9nWitLUERZTUdVRC8rWDMwN0dkZ21Gc09BdFloMzlt?=
 =?utf-8?Q?S5Z0ymfGHnpaEcVL/3ykSOPP5no4qMc2Fim9nAaBULSR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13036.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkpmdVdHbmM5SmdQMVRpd0NoTWtQZDQzZzFvME5FMUF2bHNoSEhJSHlwZG4v?=
 =?utf-8?B?M0ZxSTVtcXpHUUxtL090b0crM2hIUk5RZ0dQNnhiNmJSbGVZMjh4S0M5cGlE?=
 =?utf-8?B?M09EaEh4MXRTQ0FESVBZK1FmNXJaMDJTSGM5YW45blFuQ0R2YjgwM1ZvNk8r?=
 =?utf-8?B?RzFYUGNMWTBOOWwrL3RHZ3RvKzFlYmQrV0pLak9qK0MrYytqQko1QVF1UFE4?=
 =?utf-8?B?ZmRpUlFRcUdMUU1McVBFQndTb3FhVzFKUFVGTitEdHlXQisrSEFNclFDNUxz?=
 =?utf-8?B?QzFnTEhoRkZaVERudjRmbWg0ekdtU293MENXeTcwdXZ4dXd1QWZycTQvdys3?=
 =?utf-8?B?NUVrdlZseWIxQWZEa3NqLzYrNGhDeVp3Z1UxMWF0MEtaM0hjNVVPQnBGWW1m?=
 =?utf-8?B?SmhnVURjQXRtUS9FK2g5MXg2YStGODFKaWdUa2xyekFCckE3WnFvbWF6SVFj?=
 =?utf-8?B?amljWGxXbGhYelRSbk4xNEpEVGdZdkZUcmdmaVgvR1BjQ25sVnZjTXBXZjF6?=
 =?utf-8?B?bFFEbnQrQXZweGxSaWVreU4ybG5TUDU5OVRCVUdpekhLRi9peUdaUTUvWnNw?=
 =?utf-8?B?cFRlem5UOHBKSXlzL1hTVXFWNHQ2VTJjdWdhUHpEQzVBSGVWb0JLaWtYdkFS?=
 =?utf-8?B?SmpMK3N1bE1YWVVpMVo4VGh5OVJEK2srem5HbVd6bEZpa1Zqb3R3SGJBREE4?=
 =?utf-8?B?TFFLSXZyWVBnU2YwZ3N0WjlMalU0cXlTRnE0a2FaWHk0UjhYQlRrOWE5RkVS?=
 =?utf-8?B?STlTaVo0MTU3cUJRcVpIR3kwMDgrSitrTHR4SHo1VXNieURiOVVyam1heC9h?=
 =?utf-8?B?cUY3T0wwOHU0RnNIeVBkL2xZWXdUcGdRZ1pKV2pXMytDSlRMT29vTFJPcEh0?=
 =?utf-8?B?eDFiYnJHZjVpajAxSEs5Q0lnaEo3WWpTWk5UcWVjNWVxdGdtZVk2Vk9hbVdB?=
 =?utf-8?B?M2xzMEEvcWI5OXFuRFZNeEhubmpxSDJFQVVtS2NiNmNub2dQcVREK2pBa3lD?=
 =?utf-8?B?ZmRGLzR5OTQ3MUFRSk1HT1dJSmRhempwZGk3Y1NvV09BSVJ3ZDE5MG93Tmwy?=
 =?utf-8?B?cVRSNjVvYmxzWCtlbkFvOG5vY2lGY2FyUVU2a0dpalJ3RTVuTlhnaTA0akxm?=
 =?utf-8?B?ZmMwRDJxNFI5aXhFTHFFcktqV0xTOFlSSmd3dnViUDJ3QjBzUis5NTk4Ni96?=
 =?utf-8?B?SHVaQnFKNmttMnRzWUZNTlEyakpkcDdKKzJOcXI3bE5yaXVNYjJ1cFlZdG9l?=
 =?utf-8?B?R0luS0doVUFVVkdjTDdlNzVYdGlzdEhwcFJUYkhuemorVmduVWpXS0xpSUxF?=
 =?utf-8?B?QThLN1pBcjJwV09SVTIxY1EyMDB2ODh2bjhROWdTdzJGWEo2Z1FOOEtRU0Vr?=
 =?utf-8?B?Z3BnOWRhUitwaHlxNlpvRjltb3N1aTZKMGp0dkl2Tzk0U2F6UnlwMmhoTkM5?=
 =?utf-8?B?Y1NBMXhlM01lbEZiekFrOHM4azNCUGROMzl0K1VhdTNtRnYwUnp6ckFuUVZX?=
 =?utf-8?B?RHpiRDVYK2FiRVNBTHcrVTBEd0dPZ3FjQmVMb0JaS2dvMzlNM2FnRXVHamV2?=
 =?utf-8?B?QXVZWFJKOHk0WWdOdElSQW5IYURGalFRQmdLdXo5czZ1b3lTM0U1K0dTWFJC?=
 =?utf-8?B?NzdLZmFzSjdJNnhjbFV4VnFHNnVLeTdHRzd5Y1lHbmQ4bjlTZWxWS3FrYmd5?=
 =?utf-8?B?RnJ4dnpNUUJjTTA2T2VmNjJHaGlvMFdzSUk5ejFRR0FTT3RGTHZ3b0Q3d2pt?=
 =?utf-8?B?bU83dG83bFhZMGl6TmpWQWp3RytFcGh6ckVoMVJHQk1iNjhxbWZxQUQ2SDll?=
 =?utf-8?B?bU14eUk0SzJjQXFZTU1zaDNLUi94OGxmeHJhbU9LZWZ0UlBWUlJLbloxZDhi?=
 =?utf-8?B?dUg1TnNsYW9RTy9zbDNwbGxwV1NCZzJ3ZW1sUWNnd3ZMQ2hXRXVmQjd6T2ky?=
 =?utf-8?B?dVIwUVlVLzMxOGo2Q09xclRZUTV1VDcxWm8wYjI1NDVZdVBmYU9nUHliOUps?=
 =?utf-8?B?NElnR3MwajNzM1BwT2RhRjNRb2RFOWdLUkFUeE5GMm9oYld3OWxQeGdQeFRz?=
 =?utf-8?B?aUlENjJ4YWpMU3ozdjBjR0NkSHpESHNSdk5VQ1J6ZlhtZnNRa01LVFlZKzE2?=
 =?utf-8?B?ZDVXNEJFVXZJby8zUGM5STJkRk1DdmpYY2gzZERrWUR3OXB3LzI2MWxPbEZz?=
 =?utf-8?B?TTB5Wm5MS3ROdjhHakFEUzBXSHlZb0w1SytESWtxMTBIQUMzYmdsbmpCRHFz?=
 =?utf-8?B?MVhXZDBRR0V1bXRhWjd0Mm5HOUt5eU1RZllYTmowZmduNHpCRjEwc2NLTlRK?=
 =?utf-8?B?RTh2Y1ZLTHhpVGl4a3E3Z0NwM1V3T0VPaW5jMHlFRVIwUDk5aW9BYUlrOGtp?=
 =?utf-8?Q?2+1kPxpJ2wN2u6jY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F21619BEE19294DBA5D64370F6F3AC2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13036.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b19eb86-ac19-4543-d08e-08de571b1188
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 05:24:50.2749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRIpamtiu1MAmYbc8rToHIpvzKMyDowskC6g3f3iKSGW0/bhb/xbq3FWSyfI8h0siVs2akv9ch6mKR1rGSdMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14552

DQoNCk9uIDE3LzAxLzIwMjYgMDE6MzYsIHlhbmp1bi56aHUgd3JvdGU6DQo+IE9uwqAxLzE1LzI2
wqA3OjI3wqBQTSzCoExpwqBaaGlqaWFuwqB3cm90ZToNCj4+IFRoZcKgY3VycmVudMKgaW1wbGVt
ZW50YXRpb27CoGluY29ycmVjdGx5wqBoYW5kbGVzwqBtZW1vcnnCoHJlZ2lvbnPCoChNUnMpwqB3
aXRoDQo+PiBwYWdlwqBzaXplc8KgZGlmZmVyZW50wqBmcm9twqB0aGXCoHN5c3RlbcKgUEFHRV9T
SVpFLsKgVGhlwqBjb3JlwqBpc3N1ZcKgaXPCoHRoYXQNCj4+IHJ4ZV9zZXRfcGFnZSgpwqBpc8Kg
Y2FsbGVkwqB3aXRowqBtci0+cGFnZV9zaXplwqBzdGVwwqBpbmNyZW1lbnRzLMKgYnV0wqB0aGUN
Cj4+IHBhZ2VfbGlzdMKgc3RvcmVzwqBpbmRpdmlkdWFswqBzdHJ1Y3TCoHBhZ2XCoHBvaW50ZXJz
LMKgZWFjaMKgcmVwcmVzZW50aW5nDQo+PiBQQUdFX1NJWkXCoG9mwqBtZW1vcnkuDQo+Pg0KPj4g
aWJfc2dfdG9fcGFnZSgpwqBoYXPCoGVuc3VyZWTCoHRoYXTCoHdoZW7CoGk+PTHCoGVpdGhlcg0K
Pj4gYSnCoFNHW2ktMV0uZG1hX2VuZMKgYW5kwqBTR1tpXS5kbWFfYWRkcsKgYXJlwqBjb250aWd1
b3VzDQo+PiBvcg0KPj4gYinCoFNHW2ktMV0uZG1hX2VuZMKgYW5kwqBTR1tpXS5kbWFfYWRkcsKg
YXJlwqBtci0+cGFnZV9zaXplwqBhbGlnbmVkLg0KPj4NCj4+IFRoaXPCoGxlYWRzwqB0b8KgaW5j
b3JyZWN0wqBpb3ZhLXRvLXZhwqBjb252ZXJzaW9uwqBpbsKgc2NlbmFyaW9zOg0KPj4NCj4+IDEp
wqBwYWdlX3NpemXCoDzCoFBBR0VfU0laRcKgKGUuZy4swqBNUjrCoDRLLMKgc3lzdGVtOsKgNjRL
KToNCj4+IMKgwqDCoMKgaWJtci0+aW92YcKgPcKgMHgxODE4MDANCj4+IMKgwqDCoMKgc2dbMF06
wqBkbWFfYWRkcj0weDE4MTgwMCzCoGxlbj0weDgwMA0KPj4gwqDCoMKgwqBzZ1sxXTrCoGRtYV9h
ZGRyPTB4MTczMDAwLMKgbGVuPTB4MTAwMA0KPj4NCj4+IMKgwqDCoMKgQWNjZXNzwqBpb3ZhwqA9
wqAweDE4MTgwMMKgK8KgMHg4MTDCoD3CoDB4MTgyMDEwDQo+PiDCoMKgwqDCoEV4cGVjdGVkwqBW
QTrCoDB4MTczMDEwwqAoc2Vjb25kwqBTRyzCoG9mZnNldMKgMHgxMCkNCj4+IMKgwqDCoMKgQmVm
b3JlwqBmaXg6DQo+PiDCoMKgwqDCoMKgwqAtwqBpbmRleMKgPcKgKDB4MTgyMDEwwqA+PsKgMTIp
wqAtwqAoMHgxODE4MDDCoD4+wqAxMinCoD3CoDENCj4+IMKgwqDCoMKgwqDCoC3CoHBhZ2Vfb2Zm
c2V0wqA9wqAweDE4MjAxMMKgJsKgMHhGRkbCoD3CoDB4MTANCj4+IMKgwqDCoMKgwqDCoC3CoHhh
cnJheVsxXcKgc3RvcmVzwqBzeXN0ZW3CoHBhZ2XCoGJhc2XCoDB4MTcwMDAwDQo+PiDCoMKgwqDC
oMKgwqAtwqBSZXN1bHRpbmfCoFZBOsKgMHgxNzAwMDDCoCvCoDB4MTDCoD3CoDB4MTcwMDEwwqAo
d3JvbmcpDQo+Pg0KPj4gMinCoHBhZ2Vfc2l6ZcKgPsKgUEFHRV9TSVpFwqAoZS5nLizCoE1SOsKg
NjRLLMKgc3lzdGVtOsKgNEspOg0KPj4gwqDCoMKgwqBpYm1yLT5pb3ZhwqA9wqAweDE4ZjgwMA0K
Pj4gwqDCoMKgwqBzZ1swXTrCoGRtYV9hZGRyPTB4MThmODAwLMKgbGVuPTB4ODAwDQo+PiDCoMKg
wqDCoHNnWzFdOsKgZG1hX2FkZHI9MHgxNzAwMDAswqBsZW49MHgxMDAwDQo+Pg0KPj4gwqDCoMKg
wqBBY2Nlc3PCoGlvdmHCoD3CoDB4MThmODAwwqArwqAweDgxMMKgPcKgMHgxOTAwMTANCj4+IMKg
wqDCoMKgRXhwZWN0ZWTCoFZBOsKgMHgxNzAwMTDCoChzZWNvbmTCoFNHLMKgb2Zmc2V0wqAweDEw
KQ0KPj4gwqDCoMKgwqBCZWZvcmXCoGZpeDoNCj4+IMKgwqDCoMKgwqDCoC3CoGluZGV4wqA9wqAo
MHgxOTAwMTDCoD4+wqAxNinCoC3CoCgweDE4ZjgwMMKgPj7CoDE2KcKgPcKgMQ0KPj4gwqDCoMKg
wqDCoMKgLcKgcGFnZV9vZmZzZXTCoD3CoDB4MTkwMDEwwqAmwqAweEZGRkbCoD3CoDB4MTANCj4+
IMKgwqDCoMKgwqDCoC3CoHhhcnJheVsxXcKgc3RvcmVzwqBzeXN0ZW3CoHBhZ2XCoGZvcsKgZG1h
X2FkZHLCoDB4MTcwMDAwDQo+PiDCoMKgwqDCoMKgwqAtwqBSZXN1bHRpbmfCoFZBOsKgc3lzdGVt
wqBwYWdlwqBvZsKgMHgxNzAwMDDCoCvCoDB4MTDCoD3CoDB4MTcwMDEwwqAod3JvbmcpDQo+Pg0K
Pj4gWWnCoFpoYW5nwqByZXBvcnRlZMKgYcKga2VybmVswqBwYW5pY1sxXcKgeWVhcnPCoGFnb8Kg
cmVsYXRlZMKgdG/CoHRoaXPCoGRlZmVjdC4NCj4gDQo+IFRoYW5rc8KgYcKgbG90Lg0KPiBJwqBh
bcKgbm90wqBzdXJlwqBpZsKgdGhpc8KgcHJvYmxlbcKgYWxzb8Kgb2NjdXJzwqBvbsKgU0lXwqBv
csKgbm90Lg0KDQoNClRoZXJlIGlzIG5vIHN1Y2ggaXNzdWUgaW4gU0lXLg0KDQoNCj4gSWbCoHll
cyzCoGNhbsKgeW91wqBhbHNvwqBhZGTCoHRoaXPCoGZpeMKgdG/CoFNJVz8NCj4gSWbCoG5vdCzC
oGNhbsKgeW91wqBleHBsYWluwqB3aHnCoHRoaXPCoHByb2JsZW3CoGRvZXPCoG5vdMKgb2NjdXLC
oG9uwqBTSVc/DQoNCiAgDQpUaGUgcmVhc29uIGlzIHRoYXQgU0lXIGhhbmRsZXMgSUJfTVJfVFlQ
RV9VU0VSIGFuZCBJQl9NUl9UWVBFX01FTV9SRUcgZGlmZmVyZW50bHkuDQoNCkZvciBJQl9NUl9U
WVBFX1VTRVIsIGl0IHN0b3JlcyBpdHMgcGFnZXMgaW50byB0aGUgcGFnZVtdIGFycmF5LCBhbmQg
dGhlIHBhZ2Vfc2l6ZSBmb3IgSUJfTVJfVFlQRV9VU0VSIGFsd2F5cyBtYXRjaGVzIHRoZSBzeXN0
ZW0ncyBQQUdFX1NJWkUuDQpGb3IgSUJfTVJfVFlQRV9NRU1fUkVHLCBpdCBzdG9yZXMgdGhlIERN
QSBhZGRyZXNzIGRpcmVjdGx5Lg0KICANClRoZXJlZm9yZSwgdGhlb3JldGljYWxseSwgU0lXIGNh
biBjb3JyZWN0bHkgaGFuZGxlIGFueSBtci0+cGFnZV9zaXplIGZvciBJQl9NUl9UWVBFX01FTV9S
RUcgTVJzLg0KICANCg0KVGhhbmtzDQpaaGlqaWFuDQo+IA0KPiBJwqBhbcKganVzdMKgY3VyaW91
c8KgYWJvdXTCoHRoaXMuDQo=

