Return-Path: <linux-rdma+bounces-21284-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFzUJCFsFWoBVAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21284-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:47:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC05D3A73
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C1903017CC8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50473D9038;
	Tue, 26 May 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZlEUseG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2443D9686;
	Tue, 26 May 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788703; cv=fail; b=QR0UYHVQCP6nY+1lGSR+Y2/yR9Mu96+epwej/znTxH4mrY6eAALClqx/r0fWPgXVKTZSTSOmmme1ysvEPO90E3EuU19FMfhJak/w5GPD4Xgl+wAPnHnXZRndo7vh5dHtO8yqlgOHCrcJqDUZySTqXVCjOPNYYrygy5shxXDWv/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788703; c=relaxed/simple;
	bh=C/FIZmtl9CknSz/KKIRjbqc/qA54+5wYIUC/lg+BlAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwkt0OB+CRAA78fyQy54JUE+Vg02iJZSdfOGhd1L17gnjM0XD/DBEHRQAyZu8F3DJMjb7xea0pNf6HU00pVP4W9knBhIpuYIg6uNLqIPl8NCjL86dOVrGwN2x8MH3n9/Ob1HUiDTySVpgb55aytDmFUYyGXNvqknyFcTrCZV3eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dZlEUseG; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvHg/mCFBNgtQyEdIVsKp0zFEFY8+UmpN8fDo0SgUNafS/ievR+Q023fPnCwsdCBxhaPLkxTl8rV4MxZ1DY02xbM8oyxOdHidRMEAVp+SEOF9uoo8Yph7I1YsZM3ipTkijoRjzlDCrW+cSNTQbDDcPvkwzmhFgYkDAcmPQNvFgl6HMBPaesf57xpW0rznXAY5dKatnyWCDwuFQkoZ05/quJue5YN8I0PU6476h9P4/zY+U2+9odHYJLEnwBaVaqHjUqOxuxeZQwU+QznDjpOHffMv4FkFssw7iJdRdQhVsEsbcscTSkg7MhZYoqroBxPR0UlD3reoY4zh3Ni6AC8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc8cSg4nAHsAVrzhTgAqG/L52U3podFzdrHz6plNjnU=;
 b=OUsuqX/P7Lk0XnYfUQIuVil16bfZNDLkAQk4W1WlvBAk7rTyZFj9OTPAP1zkT2AXq27sIYBk4FRZ+TTEc4MIrL6hEqC6ZGeWFFbEra+cZ75QCO94ltBXLCRveSL6Prbmu1cc2gCtEdVgT3THVeBq9ce3SYrhizYZ2ZruvkkidUULKDfzrZcrhbPjIcjpNLelgGsbV5FgoFDk3aTOll5ipMXv+hD7JYykPt61RFA7T4+U7Ble0ZOoIwU4bwyBndu19o8gDhrjFwxgKYu9IS0YFnYhj6G7RLxd5CeJsLAtrWltQC3pBp9ltEbvc5edpxNDhmQurVFZGjfEvSeuVES4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc8cSg4nAHsAVrzhTgAqG/L52U3podFzdrHz6plNjnU=;
 b=dZlEUseGhw7AtGWMF6gfkxm4Enq2Ub0k/YNNeQ5DKa9HBg8eCg+vwg8vRDf4/Z7ZKbUK07Qxsk3huzIf1zbU5VQ9cF4gXfKu8gbMnuG/72R0yqEWueiWFVT6zuswc44NEJzq6OpZLrGXuNG2B4sM1vHJOjIaheMr8qzbBS73iNW7lsWvxrMKrnC7AyW141WhG9jSI4zholmN2SJ8hGDGFxDqDgxKvWeYEBfjD8ccYgS0LDqJhW1ckS694vTewe2AfLAruvIKGai+ADr2SOCBbfzUfFZuLuIYE86IhcJCwnXDc/OkM6GUz2B+yyBF/85fhVV7bk/Ctt0SYIsRODGMEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:44:55 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 09:44:55 +0000
Message-ID: <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
Date: Tue, 26 May 2026 12:44:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Feng Tang
 <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
 Eric Biggers <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com> <ahVPASuh4BZGOfx0@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ahVPASuh4BZGOfx0@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e694420-d688-460b-41ba-08debb0b713b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|11062099010|7136999003|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	IYcxF4lplPB+OtIugmJe0RJbR0gp0+SstACS1f6l92mEnvk+ufCL/8kFE+nozDIwV5xqAYYFJGEmmGguAWjxpfGtjEXdNc9hhK4BUfmSNgfdjRRtsn/nfmQWd0H4cj2eiLyvj17f6PWx8ei4Psd5F+znPYXvcYbI6aqh7ohLmWV/DCfXDfgNJXDtBltHgeTZOIsHEv8slFHAlsb/PkM7L3yn4riWeikUvaJnxsRa6P+gKLDMx/I1S9xHspOsxRQmEApyDDxObdtJKaan08fABV94OMrpPgKt9tCmo0D1iMX9ymYXcoX8Iw3tkzXM85tIchAsPAPYGxNCUdf7UmWQStLPUuFu2LvZI3LNz3FnGP/PD8wzl6kv/LTmogXlEMXbxJqQCrqm2OQWdo1NmrMGXiCz4wugY2PQT1mOkDPpcgcw6jqS5JohYOdxT7UDRkTb9jrjKY/er9TeGNZMRVZDLH3IT7cm6WaA8Ng+NY/DWhFMQcemEba5tR1NRUBI99QjuEQ2/a/WoQf9rOohEPMqi5Ke//zxU+wjgCIToXnUjUOaAC+ylPS6SzC6WeEiZVZ7Yt8WR9Pmb8i3lccd3fO+DMuFLvDGZC9J3Yh2QwWsYkH1dRIc6HcoZaeZUUEFeeAENOIG+I2U2+LMKoOg/MtXiocHGzXNSlfi6buIs1hap54f9zUb7UziwpZ8ACkQByd3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11062099010)(7136999003)(6133799003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEhEMkhXc3dOS2htYkM3Zko2eEt2czlrM3FxV0YvalNGck4zZUNKQytaUG9W?=
 =?utf-8?B?RE5YQ29QdTNHZTF2TDJpRnYvbjlaeGxaMlBJSXVBVmdQa0puUGxqdlRxZ0Zn?=
 =?utf-8?B?cXlLUGZFR0M3ZUc1WnpnSWorOFBzZWI5MU5BZjJOYktqK1I2cFVyNFh3aWF1?=
 =?utf-8?B?aTRZc205bzhRc3hIb3ZodmdGSWRiS2tpY2ViVmNpTmp0M05SWTZxOEpxdkdz?=
 =?utf-8?B?blk3N3FBUHhmbVNURC8wdnZhYjNncFZ4UlFBVHRoN3NLYjB2TlRkRk1qU0Q0?=
 =?utf-8?B?Zzk3dWQ2a2IzanZjNnh3UkxvZXlVZi9NeHdQMG5vYm9pdHQyUUFhV2p3dkgw?=
 =?utf-8?B?bUFmODFOaC9rQTFPdTkzZWUxcnlnOEg2NjVIbHkxbmNDNytic210WW4yaDli?=
 =?utf-8?B?czBrV2tibU1oNTh1eHJhRlU0YUI4UUsyM0FlakRsc0VOOG81NlJGVlExcjFa?=
 =?utf-8?B?VS9NMGhvL2tSb2dQMEhFRGlQbm9hRFBRVzNFY1FkUktUTWhjbkx4d2dMTmIz?=
 =?utf-8?B?NERqM3gxbUNFTnlWTytXcnVRQ2x6TjZ2eEdYdWNXNW5INzl6S0ZKWTlKUmhs?=
 =?utf-8?B?T3lIREpBTEpPRWJZaCtGemR6TEZ1SnRTMjZxODQzM2V0UTB0VEtvbDR1c1FU?=
 =?utf-8?B?azEyTkNGWW5Sd250R09EdVlrdkE1alBQU2VXbWJhNjBVR09LendVdXpEK05T?=
 =?utf-8?B?ZmRiZzB3VG1XYW9nT2daUnlWd2pjOGRwUkVNZzNDeTdBdklpMHQrSDZuemxU?=
 =?utf-8?B?cjJ0bXVHSDUrSi91d1Rqb3krdjRHWWg0T25hbjlmQUhFNm1RNExURENEcTlK?=
 =?utf-8?B?V0VUc29hZ28vdmFmcnFONVdzaUcwS05MRmhRT09nVHNiR2hBbENtbGZOcUtJ?=
 =?utf-8?B?M2NDWnVwbElTRWlpa3NoMUxJMlVTaXF1akgzR1FDWWNGdzAyWGdXM2VWUGlJ?=
 =?utf-8?B?bUFJbjdERmFoaTg5TVBDaXBpZGlkSmRWMVhlcWszcmNGM0JFVGsvMDlhalNS?=
 =?utf-8?B?YlEvYUZCbUc3b1dCUjhvRnJkZm56TUJUcUVLeHBsbUlLeEVBcjU2djFZMy83?=
 =?utf-8?B?WlpHRVM2UDRuWEpvTFhRT1FjQzVsZm9kSzlHTEo1R1oyYzdsTFkvQmIzdWU1?=
 =?utf-8?B?TkwzMWhxTjJmbGdQQTNVdFBCaHhPd0VTRHBVYjFqTlhlT015VlN3d1Fhc25r?=
 =?utf-8?B?eWdOQkZ0eEcyVVlCZUlWeU1Cd0lnc2ZBcVpQc2VzRU5tVVNaS3dVRGUrRTlW?=
 =?utf-8?B?NnNQMHhrNTkvUm5NYUI4cU9GQ1RPaHJzZ3hGSCtrdVg3cGNQUitZQ3c3THds?=
 =?utf-8?B?LzZrK1dENC9pY3d3cncyOGoxdGNuUE1uN0d6bHN3SEU3TFdueFltc1RhWG44?=
 =?utf-8?B?UUJ4b3RHNkhJa1IrOUFSTitCcWdlZWtpM1YzcHFadFkrYk11M014djRRYTdB?=
 =?utf-8?B?cmQwaCs0Yk1RTGVyVzFMTzI1MUVPM2Q5WnhMYTVrSkFHTU54TldtbVBNb0gw?=
 =?utf-8?B?V3BpZFpnL01qN3pDcSthSE5pWk9mS0JGUWVDQm80bHJnS29yZmU2N3ZEb1Jk?=
 =?utf-8?B?THNYNTBMV2p3NVU3N1NjcHZmNHIwdjNPa0FtS2hHSGlWQjZBSjNLbEl6V0tZ?=
 =?utf-8?B?WlhmV2ZUSjdlWTRnYndVb2owTEtCandhTUo5bkFsbmowYXVmZzd4N0pEZzQ3?=
 =?utf-8?B?V1B5K0NNc0JkOGNKV25aQ2dPbkd6M1dLdVdwMUZLMXNKNURwZ3Z6UWdmYlNj?=
 =?utf-8?B?NTRDTnZKOG1EanhHZTNKV1U0MHBXTjlESm1abnNySHV6WkhZN2JTbHY5NWRQ?=
 =?utf-8?B?YlRhU1RZbW9NUFdLcy9DdGpYVzhSQmpGbng3bzlJZXZUUDFBeDBzK2JQeEMw?=
 =?utf-8?B?VGxoVlVyK3kzazZYb0w0VzRvNlI1bkd5RjJFWnZFeTJLeXEvRjk0eHQwRSth?=
 =?utf-8?B?anZNT0Fmd0JFdktoVUgrWWNyMGVjVjFzM2hubkdrZjdGVm40RkpLSmlnYTFq?=
 =?utf-8?B?bFI5TUZlSjF2V3FzUzFpTktHaUNwbzdqd1lISW5lbGJHcnVFWUFydzR6Nmtv?=
 =?utf-8?B?S2JFcFVZamRwR1RXdWVNSjFOREZJU01WQ3B4MnFnSVE0UXhTdENoRDgyOXNE?=
 =?utf-8?B?Uzc1ZHFGWVZweTUrR1lya29tZzFtMmJ2SVVyYm1yMnRuR3pmT1NnaGxYZ1hp?=
 =?utf-8?B?YnU4SkV2MWNrYi90Nmg2ZzQ5SExYVm9YRUdFdmV2MURjRng3WGpZa0xZVHlX?=
 =?utf-8?B?bmtkdUVyN1NIUk9yNmF0T3RvWGNzaHQvdlVMZUh6TXRCSmY1SkFlUGNIcTl5?=
 =?utf-8?B?Nk5hQm1rUm04aDllV1pZb1R3L2c5UGdBUG0zakUvL1NuUnN1VXAvQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e694420-d688-460b-41ba-08debb0b713b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:44:55.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zps6QqT3tu70vDvhSEmxRLP/8cPjHX+sckxNGaAZNwZcM4TS6I+YswDFUpzt5cXOTu60ASxWATTFptN6df5HsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-21284-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 91AC05D3A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 10:44, Jiri Pirko wrote:
> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>> From: Mark Bloch <mbloch@nvidia.com>
>>
>> Apply devlink default eswitch mode for mlx5 devices after successful
>> device initialization while holding the devlink instance lock.
>>
>> At this point the devlink instance is registered and the mlx5 devlink
>> operations are available, so the default eswitch mode can be applied to
>> the matching PCI devlink handle.
>>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> index 0c6e4efe38c8..4528097f3d84 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>> }
>>
>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>> +{
>> +	struct devlink *devlink = priv_to_devlink(dev);
>> +	int err;
>> +
>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>> +		return;
>> +
>> +	devl_assert_locked(devlink);
>> +	err = devl_apply_default_esw_mode(devlink);
>> +	if (err)
>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>> +			       err);
>> +}
>> +
>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>> {
>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>
>> 	mutex_unlock(&dev->intf_state_mutex);
>> +	mlx5_devl_apply_default_esw_mode(dev);
> 
> I wonder how we can make this work for all. I mean, other driver would
> silently ignore this command like arg, right? Any idea how to make all
> drivers follow the arg from very beginning?
> 

I have a follow-up series that adds the call to all drivers which support
setting eswitch mode. When going over the other drivers, what I found is
that the right point to apply the default is driver specific, drivers
I have patch for:

46e16c6d9836 net: Apply devlink esw mode defaults
ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
b48cce1607bb liquidio: Apply devlink default eswitch mode during init
4ea54b0fe04a ice: Apply devlink default eswitch mode during init
b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
5000e4c3d768 nfp: Apply devlink default eswitch mode during init
97a218e95e41 netdevsim: Apply devlink default eswitch mode during init

I don't think doing this generically from devlink is realistic. devlink
doesn't really know when a given driver is ready to change eswitch mode.
Some drivers need SR-IOV state, representor setup, or other init pieces to
be ready first, and the locking is not identical across drivers either.

Also, since this knob is only about eswitch mode, I don't think we need to
touch every devlink driver. Drivers that don't implement eswitch_mode_set()
would just ignore it anyway. The follow-up only wires the default into
drivers that actually support changing eswitch mode.

Mark

> 
>> 	return 0;
>>
>> err_register:
>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>> 		goto err_attach;
>>
>> 	mutex_unlock(&dev->intf_state_mutex);
>> +	mlx5_devl_apply_default_esw_mode(dev);
>> 	return 0;
>>
>> err_attach:
>> -- 
>> 2.44.0
>>


