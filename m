Return-Path: <linux-rdma+bounces-22133-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HLoXJtfzKmrXzwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22133-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:43:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE096741B6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ovd5CQFj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22133-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22133-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 994B9301AB58
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119553BD63C;
	Thu, 11 Jun 2026 17:43:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90A19DF62;
	Thu, 11 Jun 2026 17:43:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199815; cv=fail; b=FMhEuBLbTxEn+zaKHykW7OamPbLdJeA+kk3h4u3f5S9sN1YnzzH32NfoAEhJCFNrdNKIxI/vF/14Ati7T4YJRUhGYOAOphYsg+9RlvZ8ik33t92Nu5giIuqVQkjqDPGB57XkENUgrjH+tsGCjEbsV89yLVvGvqLTtZ/E14LNGqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199815; c=relaxed/simple;
	bh=znLTNB1sYGxY5ykVINSRxZZqoFWsJPKPgEyOQukSXzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=joVDLJkTrLgvC4N8tGhgGKoto72KTCxvwI0HcuCG7aO5+LjDFK3THd0lE5fG6ENtbVAf/q0ymgxgCY26IFWciIrCGQLdyeucIxyIbJivV0fOXm7vsnGszpP1k43rHYlBeSkyR9qtSm0iSOya9YdR4+19y77wA/wzeDC9bg7fd6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ovd5CQFj; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukF44RdD8RBywGgXMCzDsUJbT+E8m2iwpbbzsYox6Q+YVKa6o2IO6je/knLGORdbFuwrP4au76fCmg60z4WzHpvlCJOBGq9y4Eg4GiOslU1cnnwrxdYBhzgsH82lojhnhm4wPmvmfe7R05xFfu1vcZUG9A6JqTT8iV1PxD7wyd1h15Tje7VuzxNnE4WseBsq8KyHKY8c4Q+conke3dnBK1mDSGd1w9LAsChDYj+2R6/gAtJ1sm8RR2dWtrnYI4SY4E5JuduxlGaERgTpEEoWldKVmHj4txPAgJwBVS7r5zSUSRhPvicgMPcBPT8TlkHMgzFglrYFT5yLNTigdRAp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usocpods56Um8V+3ts6MpOVtMfCyBVCI9gmtw7TUC88=;
 b=h5Wfdy8F5NYxJrrKNz6pQBKRU3mC9sqHRzOmMh4zSjAn8u84uMmwgUQLxnR/RD9WTHYqyw6RmLLlWBwb79cDEp5Ah8uPZpLesv6PouP2kV6LvG+x+b5xBy6xkId01cgyLmb7huoQWZ6vSpkDoRs0zjtZ+8NpnJy3yPobX3Tw6jxC28W5p9ATdMqdd0ILUW7vuOjC/GsE/0yAOY0U04Tsz4QzTM2oWTCnTvVbhpHMO8NmL1QgbPHqh7iJ6fJsbZLU10kHH2s0CannHMAan6Hd3B78BepxmCONMviKza7CYu77PqBMEQQLGwGNO5zmhtlBK79nAT9h3gjWK706TuHngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usocpods56Um8V+3ts6MpOVtMfCyBVCI9gmtw7TUC88=;
 b=ovd5CQFj+cheMybgNhb/6XFC6h8Ukx3e+5oHCEVontU/mLfGYBfCEBlhEaOQ+Es7mT7Yi/J/b+vEnMsSak3ThNGv9s/cb/Jn6ar27oKOfb7I+CGRxpIRjIhgdGHsnWPoawXDjsYDfb/JZ0Xc5/GxJ00LeVmKSdECjD1Tokx3HHgxmicbbDUyR3wNEmXWZuyNo5sGErdQGWWaAPqSHfp1S+vVJzgv6ikf6pAk7YN0qu8cmo6jGKBAQZ5DjT2VteA6nNelMkgj+sdBaouCn6z7sJ2CuEO+XELu3IuVrUZRfFsF5uk8KbZSGrl0LGylG7N2VcfF3JsA+q3djN25HK9Mrg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DSWPR12MB999152.namprd12.prod.outlook.com (2603:10b6:8:36e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 17:43:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.014; Thu, 11 Jun 2026
 17:43:28 +0000
Message-ID: <f266dfa5-0c6c-4be0-b73e-b2185dadd6a7@nvidia.com>
Date: Thu, 11 Jun 2026 20:43:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 2/7] netdevsim: Register devlink after device
 init
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260605181030.3486619-1-mbloch@nvidia.com>
 <20260605181030.3486619-3-mbloch@nvidia.com>
 <20260610165053.7c91f331@kernel.org>
 <eb525345-da07-414c-9d05-7e00e3eb472f@nvidia.com>
 <20260611085440.4fe36bf2@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260611085440.4fe36bf2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DSWPR12MB999152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c72c9b9-0651-488d-280f-08dec7e0f24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+HLPAT6kXnuBlmc8hiTg8TZycATcQgynjFAEBkP/Hq1UZPk84XBIQqY6ll0HXbPAEu8meePiMeAJqhta5VnaiIBktj/1tl5mORKiLk2SVAyAz9udrKn9Es3H5L80ZdLp0ZCbloUPUz2cJc4umuOv8g/QtasFmvOCfzxaNAlGOka98i3ubQjIZXxwRncJLd1OifPrqe3Ww0jntQksOHBOVZFCxODU5pOf8MFC4fCAyPbgKfnZDaO9vGldR6JKNlOBwkW7MAKyOLP6yaC799lypbsoNzDujB9YT8hpaaglS1m9gsFoOuppDBM/1KKA1N0t+65EGTpmV/cQ9Tsb3irPXQH3372juCXc+6dCgGSBlm5VHI8wn99UD50h2sZqRKegTv8LcQB96XWB+LMRZ7+xHUvGFqUNkbJYPQZbG59wbJ6P/izvdXguJtENuIh+RIEOW3RLBDQb1sd/rLu/qxMIclGt9xKx42VH9qLLdQ09RL8ebNttYPcY33dcAO5K8UJClUBsn4xXMb/e785+blkcaloNninUtESMzUQ52zA5RBbEBCVNvWHuNZ3dDCeYyYrLdDyuXbGzAuhl/TyHG3wtm85Y9y15w8a1lad3uyQBymgLWF7+tHM5+pK/H8cCjc4P2gRDn338OISO7fERTUle9pmtvbXvSny1vD/iG4+gpKh9vM7atqv28o8a2KeAhT0/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3R6NjhDeDh3UDlhMVlJbjFxOVBCWU8yMEl2WjBuOUE1RXRvcDFBSjlYSk54?=
 =?utf-8?B?anR5U2dYeDc4TEEzZXlIRzZCc0RNcjJEYXBZdEdtZVkxa3FpZ3NOdDllaDcz?=
 =?utf-8?B?VEFsOFVhUWUyMDRBeXpqQlQrMkUrekRqV3J0RE5NUW4vaU5yZ0lxeGRjWWNj?=
 =?utf-8?B?R1dxb3FrMUY4bHhZbzROQjYyeUltRXBYWnl4NFhXMVFWeS92S1ZQYmk1SjU4?=
 =?utf-8?B?M05NcFdUUmwvOENVTldGUjhwQVEwNFRNRGpYQVZlTmF2TG9vWUM4aGZDVkVx?=
 =?utf-8?B?aEpOMTh6NDdmN09qVkZYeUFqTXNJSUVQVVE1T2FaU0VPZkxsbzVDYzljajlv?=
 =?utf-8?B?ZEtpcWtiWmFNSEo4eFlRNVl6MU1LYkRQVHVqOUJId1lUVGhGejZYeDB6ZHNh?=
 =?utf-8?B?UnZrKzd1cEQ3YnVSM3ZoNTdrR1Y2RWJPN1RqL1R2K1dYOXhiNFoxN2M5aWVB?=
 =?utf-8?B?ZzdNTjRqN3Y1U2ltNVBIMWlWa2UxZVpxY2xzR1dvdGw4UHZWZnFGSTBpc284?=
 =?utf-8?B?bTI2dTg5UWhCOHNYbUtLbHZma2krZHBQQmdYWngybzRzcTU0VUIraXNVbWY5?=
 =?utf-8?B?NE1WcDhVK1NTNDhwYkYxL3BXS054TWE3azZBVXRLdnpYbGlEY0l5eU1kODVJ?=
 =?utf-8?B?YUlVcjNqREJvTE9nbU1MZUcydDNUTUJpYllyZk1MM1JlU3FKUUdvRURyUXZy?=
 =?utf-8?B?cjdBOUVtckJRZ2p4SWZ2VnFQQUxLalpiOUhJNXoxVGc2eWhiWHVuaTBaQzZj?=
 =?utf-8?B?Y3Z1d3FUNjBSVldaanQvZXdabXhFclZnNDNZdUxVRWphMkFDRnp4SUcvd0xh?=
 =?utf-8?B?QzcvZVg0RkZqbkd0WXJRTXhzUGo3T0JvWjlEQ1FkTXE3U2Q3em11V2NYRXVy?=
 =?utf-8?B?Y3RFWmE4VDFqWXRHNzlvOHMzcDFtZjlXZURqYmVrL2lqOGQzRWxoMlBWOERp?=
 =?utf-8?B?U2dCei9YdC9JRVFHZW9NRi9tdDJGN1BzUm5BajhjR3JmOVVDWnpPaUJsUFJ3?=
 =?utf-8?B?Umg1WHR0UVJFR1VPNDhSWnNyWFQ5eENIdTlickVZU1BiMkxuc1FWVEtIYXg4?=
 =?utf-8?B?VFhpWkJlemZsRzBQdzB3STBYaWV1eURScUp5NUU2NGx4anJpK21VeVdqaTA3?=
 =?utf-8?B?T3RXSkg5Vm1qczlFWC9Idmh6UWkxRVpkQy92ODlHbU5SeHVkbm5MbnJmKzBE?=
 =?utf-8?B?OHNLUzBCd3FvN0VweWRaRThiS21GU3BOdUorc0g5Q0kvV0ZEaXEvTlNvQU8x?=
 =?utf-8?B?MldYZllHZWlTWHFYQTJ1ZXgweTk0Rk5uN0RGMUtQYkozQmd6aW1CeGs3c3VE?=
 =?utf-8?B?OEI2ZUNTRmtDMTVYbVNqVFVxYW5PSmxGckdLWE0yRFpibGh3TCtIaEg0dDNa?=
 =?utf-8?B?RzNaZDNjdXRWcHNzVVdzTXB0UVVWd3orcFdYZFNaOXFKaW1EdXMwZy9wZVpl?=
 =?utf-8?B?MFI0R3NSdmt0enBOOUVhTWt1djFMaElzMElEcVlrVWVKQjJBRmUrQ2hsNVFY?=
 =?utf-8?B?U0FtaHE3V2oycmVtUzkzRGh1eDFxbUI2eW1EUSt2TjQzY0RNKzNHcERuKzcx?=
 =?utf-8?B?VkQ0d2dxemh6UjcvSjJjUmQrZnNEL3Uxbi8vaHFaNFZNMTR4UkpvS2lpVmxz?=
 =?utf-8?B?NjRMaVlyMWVCK0dFVmM3RXlDUTdxamIyT1FYaWwrZU11WWR6Z2EyVlBML2RH?=
 =?utf-8?B?aW1IRWgzaERRUlAwZVdJZmh4Qll0Vzh2NCtVMDRNZHcxd210aERESFdUZXZZ?=
 =?utf-8?B?cEQ1M2V0OFFaSnRQbFRRNW9hWms1VHY5K2pVaVcrSjViMVJLZVRSbWZGbSts?=
 =?utf-8?B?T3NPWnFCUG1SeVhJOG02eDRncmJIeDJvb0dRRUpOYTZxMWJUUkNjMEJWYy9z?=
 =?utf-8?B?UGFCQysybEc2NGhFaWRLVFE1NzFrRkNZWEtZZWd6SWNUOUJNUWpEQWVsR2Zt?=
 =?utf-8?B?bU5QNnorSVkvUkFCcCs1WldiZFpBYXNxM05oQit3WXVqNWcySFh3Sjgwb0ZE?=
 =?utf-8?B?MmZ2U3JuUWd0d0V3OEczWmZMNkMyalMxalZRTFlTVWY5a2lWSXhiRG9BQWxo?=
 =?utf-8?B?YjFtc0xWeGhKcUh1K3VsNU1pblcxVCtMemZ5Nk5Uclo1VU8xSVFiVnExcEhY?=
 =?utf-8?B?cVNNRzVRalA0eUZxRmhTdWl0ZXBUWFA4VFEwVmZ6aytGd0g3WlR2aWdZK0xj?=
 =?utf-8?B?WjNlajNvYmtnTHVacEQyazEwVFdvM1l6R0t4c2d3eGJwSmFWRndMdVRYWUxG?=
 =?utf-8?B?andqUGxZN1N0OVhjL2RFQ0E2cGgvM2wxSm5oSXVRNWtDREUrUWUxeGNOdWFV?=
 =?utf-8?B?cE9XbXQwRGdxSE9xWDdyY2Z2Mng0SFJnU3ZJK3pWQzhTOUoxWktTZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c72c9b9-0651-488d-280f-08dec7e0f24a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:43:28.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpRqtLMu2sQdO0uNSYTdGU7H2oJJ8IuOorpyQxEdbRdBrFQf3X8VmR5OEP6AVbHc/mOgBl1fBzToYOgBtceKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999152
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22133-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE096741B6



On 11/06/2026 18:54, Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 09:02:03 +0300 Mark Bloch wrote:
>> On 11/06/2026 2:50, Jakub Kicinski wrote:
>>> On Fri, 5 Jun 2026 21:10:25 +0300 Mark Bloch wrote:  
>>>> devl_register() makes the devlink instance visible to userspace. A later
>>>> patch also makes registration the point where devlink core may call
>>>> eswitch_mode_set() to apply a boot-time default eswitch mode.
>>>>
>>>> Move netdevsim registration after all objects (resources, params, regions,
>>>> traps, debugfs etc) are initialized, and after the initial eswitch mode is
>>>> set to legacy.
>>>>
>>>> Move devl_unregister() to the beginning of nsim_drv_remove(), before those
>>>> devlink objects are torn down. This keeps devlink register/unregister as
>>>> the notification barrier and makes the later object teardown paths run
>>>> after devlink is no longer registered, so they do not emit their own
>>>> netlink DEL notifications.  
>>>
>>> This is going backwards. At some point someone from nVidia thought that
>>> we can order our way out of locking, so mlx5 is likely ordered this way,
>>> but this must not be required, or in any way normalized.
>>> We (syzbot) quickly discovered that it doesn't cover all corner cases.
>>> devl_lock() is exposed specifically to allow the driver to finish
>>> whatever init it needs without letting user space invoke callbacks, yet.
>>> Almost (?) all driver callbacks hold devl_lock(), so maybe the devlink
>>> instance is "visible" to user space but that should not matter.  
>>
>> Let me clarify.
>>
>> No locking is changed here, and I don't want to make register/unregister
>> ordering a substitute for devl_lock().
>>
>> The only requirement I have for this series is that devl_register() is called
>> only once the driver is ready for devlink core to call eswitch_mode_set().
>> That follows from the earlier direction to have the core apply the default
>> mode from devl_register() instead of adding an explicit driver call.
> 
> This is exactly what I'm objecting to. AFAIU we are trading off
> explicit call to get the default value for an implicit behavior
> depending on order of calls. We want to optimize for how easy it
> is to get the API wrong, not for LoC.

Right, the reason I moved in this direction is that in v1 I had
the explicit driver call, and Jiri asked to make this transparent
from devlink core instead.

> 
> If we don't have a clean way to implement this without driver
> changes let's add the explicit API to get the default value.
> If driver doesn't call it schedule a work to go via the callback
> once devl_lock() is dropped. That way drivers which care can optimize
> themselves by reading the default value upfront. Drivers which don't 
> care will work correctly, and there's no API call order trap.

The workqueue fallback is possible, but I think it makes the semantics
more complicated.

We would need to track devlink instances which still need the default
applied, and the worker would have to skip/remove them once handled.

More importantly, the worker can race with userspace setting the
eswitch mode, so we would also need some state to tell whether the user
already changed the mode. That feels more fragile than an explicit
driver call.

> 
> Not ideal, but isn't that best we can do here?
> I still have flashbacks of the fallout from the call ordering games, 
> we have too many drivers to keep this straight...

That's why I started with the explicit call in the first place.

I can switch back to this model: drivers which support boot time eswitch
defaults will opt in and call the helper once they are ready. This keeps
the support explicit per driver and avoids making it depend on where
devl_register() happens in the init path.

With that, devlink can tell at register time whether the instance supports
boot time eswitch defaults. If the user configured a default for an instance
whose driver did not opt in, devlink can write to dmesg from
devl_register().

Not perfect, but at least the user gets a visible failure instead of the
config being silently ignored.

Mark

> 
>> So if the objection is to the commit message wording, I can fix that and drop
>> the "notification barrier" language.
>>
>> For unregister, I can probably leave the old ordering as-is. I moved it only
>> to mirror the register path, which felt cleaner, but it is not required for
>> the default-mode change and as the lock is held I see no issue with doing
>> that.


