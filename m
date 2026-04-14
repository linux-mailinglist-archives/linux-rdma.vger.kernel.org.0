Return-Path: <linux-rdma+bounces-19324-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNUkOEXs3WmulAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19324-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:27:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE103F69C7
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A4F53038D2C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907237DEB6;
	Tue, 14 Apr 2026 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9a+BWnk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F833ADAC;
	Tue, 14 Apr 2026 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151546; cv=fail; b=O3ShHg8u3JREg65L2ugadUNC4j6THjdZkQHHZPAI81B5csOw+HlmAmRz2yALlxVOVnYZIzjUgTb6/e+fwqrOXzn5vkAAlekgvHUjuQVW5cxEoenchgyssSj4sDM/et4MSYdSWL+CYLAydtdf0VgCfD3g2ThlxNXzyp9eqSg1Gf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151546; c=relaxed/simple;
	bh=jaEW5ggSsuICx+aMAh3dRsSKuIdUzoi5zb2MGxfga4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8QcGdlUTBG85Tw5OPuhPuDgsKNuy+VuI+YfiW3oPMj4TTXiTod+onFWrKqymIkgKUBgi+pIWhLW+jA+HCBst7alrRTg1POypVy20Jp0T4atwoSOg/E0+ifRsq+53EkgB3ihOpY8hFfIQsUyAk0rBGlGrt1z8mU3KPPqJfrOsgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9a+BWnk; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMpv3xnI1JY8/B2iJ+kjSkJTr70s1k9hebMm0M264cHtYJOV4wFMs/pCPyMTjsGN0X1Jz708jrEWDV4KQu8QM4UZ2IV+WjeWHi/w7AxgcYA/sNKT2wUwADmQdC9u3z1l/Oi7MlLcLojXJQUplVIjMSeFVfKU6m2DTUMWyKPEy80NeAVAr6bNaVYmQpVDP7tiH7T9ECdz/sBlMCaPPXFTYyZMiX/EC/3FyZIIwRIlYf2OSHIL3IWXBpsj3E6Bbuw4hW9wAxznzBhfNBk4wi487XDM0X5ZpCsTdVWnH8HevRl3D8Vcu3GBGtFmF+HESu2h6u1RNMaBSpS+ZsbmA1jv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yefMkiVixfOjOQlij1mkmoTAlXrD+Tp8TJTNc3P4LiQ=;
 b=pf6r06YCZVpLLmOmscRAQVShqe5/xtZhlEv6DTl68ICXqc/3a3r/wmU744nYtQgmUcMUibKkJ+zfQ2OpXqSJg1hrHpHxwMRM+zAMz3b5r1A3X693enz5ZXP2df6a9QGtiDUCduR+MAkyD9MQlu6Es4Pi2iY54fYGXjXJAoLf1NzQ+3zKJJ53uEt2YzLMr3bek8Om5g2+z1aVRELwCg5gI3UtudOOAFvUJCa29Hi+J2rw77p41MT5X4ZLp1S3Bbww0Y3vank0nz88Jg4zpewWMXGOQwUK4nB3XjD+lzzjjPql26nV/u1Y1cLJxt+f1Dcsfoc0sFUUE3zBUFsrD4Ga5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yefMkiVixfOjOQlij1mkmoTAlXrD+Tp8TJTNc3P4LiQ=;
 b=i9a+BWnkcJbeyXMIBR9e+SoAHC/7X/2SS2TkKZpqHLmPi9tNpaPkkOWyjb66S8cejA9dxknbkDrxRg0F4+KtX2M9BVJx2gsZEkdzImjoxFpv+Dzv0oq4Edy5mt0gMH5A0aH/KtzDrvNJc3cYr5KjRjw+QHSszsWYz3h2f8zFLapLRUJJyiBlP0GjKHyOqg8qSrRkQ4P5meXEf5Wc9NQ23MGDRbyttEzGOfvp8yplsDlmN4JhsEhGll5Khx85vvI655gIvsSsbuHG/wu6sLyqkpCFL8ogMMAJd2jOykI8piN+8cnoDfEd0ks17xv7S+ZD7Uz8gTCSFFmA6TTKi87vqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 14 Apr
 2026 07:25:42 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 07:25:35 +0000
Message-ID: <a498597b-0053-4a3b-8f73-558019245c70@nvidia.com>
Date: Tue, 14 Apr 2026 10:25:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] net/mlx5: E-Switch, block representors
 during reconfiguration
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shay Drory <shayd@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Simon Horman <horms@kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, Kees Cook <kees@kernel.org>,
 Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Parav Pandit <parav@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-6-tariqt@nvidia.com>
 <20260413152229.7700b89b@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260413152229.7700b89b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 64390caa-9913-4bc8-4e13-08de99f704fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	a2J3ybYsTfD19h6o9WeiE1dmT7O3xORVYdFl6LOU0MAGm2oiHPZZd4oNCN5VIYInLd7pt4VYTsxsF/tXbDDdZ42LKXOe6LPFFxaaYR/x0gSIhBxMZrmr+BZvRSjjamrgdpE2URZ7fOSV33DQwzQwQqt8CX7n0fzH88aVIOnLt80UhaPR1TNXCK8BX4xq+tyMHAd5Cq071/c2NfsRWmE1GO88znwT6Jv6RaHyM4Zx+hOXhlp9aNw8TCKH5JcDonNc+qDeskVMu/LGRHNOlf8uUHp7rCx79NlY4+eWKbF2epoqnqp6i0qNIPzvn6iYI3D5cAwA1a6ZS6oDAKea/Bz+V6fRhEO/kRBzjou6NNySdF0DCEgwNIO1EJscGMmB2r6SdTCIhLQI5VAhR3juoPgqIODi6LLClXL01dUAi6l9F1oo/mIPjVa/9x87QQK2CXY2KjjULGoqVF1o3S2YK3Cz1bOZqCNdt/9QdiT299Fo09fp0EeXZ0JI0iDKX9NCpxq+/mbgb3AmbA5ujJvgR9scEololyhXLv4tewkGK3wmRj6QH6OlBFklqzb9EYzZRkQ+o1LbERBLON+AIyjdZK66TC5F1mFHAf3HfIX6/gu+i1OJH41DiUPQ5Zv6friIIOIjyVK4Ypm2IZH9yxIxD4uQSrW39KD/Ybylmje9qZd6czzjC7XKdnMhRDG5yRErDCHbP/Npru/qzpPHarLD79g419Pj88jlvwxToH4T+TDEu+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTJlbDdMN3NyMEE1UFFDclgzV0ozSTlWcjJMNjBIWWs5aEI3RXppL1Eyc05N?=
 =?utf-8?B?Ym9CaElaSnNpeVJTT0lqTzJXcjJVOW9nZTBOanc2amc3ZUFvMnVUUkVrWjli?=
 =?utf-8?B?WmhWd1hYUG9zdG8rb1ptUHZUMjRqaWtITzhtanZja21wZGJpU1grUlRzU3Fa?=
 =?utf-8?B?WStlb3ZpdU1Bbk11Zzg0ZHV0VGVubDl6dGp4QWVFdHg3RGZlTmxUQ2U1Zkcr?=
 =?utf-8?B?WS94dHZtU3J3QmRBaXNiK1JyMlAvRU4yUG5NN05MdGZpS1lVdk1VeTRyWGhl?=
 =?utf-8?B?eWNsVSthMndzWFIva2dQVGlhWmFtMHl1aWhnbVNQeWg3THlFSnBRWkRqQzA5?=
 =?utf-8?B?dlpsWkNxOVBSQlUrK1JIdFdWSWRWeTRFMHlnbDE2WE5RQmc0T0dSMVNqVVpZ?=
 =?utf-8?B?ZEFtd2Y0MHdnSHJrUTd0TkpoM1dMZVZmWU85WXF6c1ZSMmZJQzlTTkVBV25n?=
 =?utf-8?B?QzJzR0JqaEFBUG8vcEVFYlI3aTdUaDh4SW82elNlelFwNlo4YTd4TjEyeXNN?=
 =?utf-8?B?QkZDM2lpVXVxWGZlTGdvUlV3RnN2aENiOHlYM3JWbzB3WmZ1V0NabWhiZHFD?=
 =?utf-8?B?NElpTVdlTzR2bjc3em4zK04vWWpYZmJRS0ZYcFlHRXdiNFk0T0daTVdrb2xU?=
 =?utf-8?B?MnQvTHNUV0JJb1NTYXRDL3FsazRzVWFNTmpORkhVeWNISCt2N3MzYm44VGY5?=
 =?utf-8?B?cnlZZUFvVTY0OHB3U1FSNjJvSjRWUFdINlJqb3BEQ1JzM1MzdEFDb3E1MXZZ?=
 =?utf-8?B?TW1jZjJ2U1JDaEJvR01lSUJ3WUd3MTJqVjB1QnFYMGljTG1XcEFCbnpwcmp1?=
 =?utf-8?B?ZFB6MVp2S2ExVHhDNDNGVndROTdzMUtmRVo1dUxIZXpMWUVwbTZXYS92TUdi?=
 =?utf-8?B?YmQ0Vk9tczJraFIvVUw1NkRZbWhaTzRIMVkza1hYaUlsNEhsekdaYzVONm1D?=
 =?utf-8?B?Q3dQcVJFckhRc1MwU3JDeW9YUWVDZXJDdWhnRFpxbVZXdzluYWtDNmxxOGJq?=
 =?utf-8?B?emYyOXdJdEpZQXlZcDZuSUJLTnA0aG5temtJaENhd1FPMytvTDdDZlJFQUp2?=
 =?utf-8?B?eTY0MnhqZXBZSWgrVGp1ME1RblVycUFEVWRRemZFaDVST0MxbUQ5ZjNXUXhu?=
 =?utf-8?B?RTdLaHk5T2Z6ajJKYkk0NkxIakF2R0FDdHp1L1prRXRBMXRFeFZSQ1NoWkxz?=
 =?utf-8?B?ci9oVGdjNFB5eEpiSEhwQ2U0djFIbys4NDlQQUhNN0xIcnlMT21FYk8xM2FQ?=
 =?utf-8?B?RG03OTVIK1lraTBTcUJiSlJyUUdtYkRnaktBSzFQNXdQZzBmRjEycE5Ta0xU?=
 =?utf-8?B?eEloVUdTWkh6cUtRSlNLSDVobzIvbWM1UzVPTENUeFR0Yk9saytyYkRNT3Ax?=
 =?utf-8?B?VkZ4Vk15eCs5eEtyUFF1Ync4Z3NsSEY2czNrNTN5bUJPaDkvVkE1SlpoSEk3?=
 =?utf-8?B?a3RiVjAxZUo2MlNJUFNSZzRZMDdWREV2ZXQrcjBsT0hzTSsxV2Y2QXoyeDJL?=
 =?utf-8?B?YTNwaGJlUXh3b1IwUmVSdm9CL3VMV002MExEZ2pYVG5OT3M3RkRZRWxQcUpF?=
 =?utf-8?B?VXM3c2ovakhYbk5yQVZmVElhcUxpSElFRURoekhTYkRBVXljVGtES3A3SEhW?=
 =?utf-8?B?WGFxMHdtZDg4NGhSQytuN3Z5TkZNRDROMitRTk5TanJzeVMzektSTmV3QUZE?=
 =?utf-8?B?RWQ5OVhQcGEraDMxNFFUOW0wd2djazZmYjNzM28wY2lWNmZlbEduS0wrRmVv?=
 =?utf-8?B?VCt1b0FPMGFIbFZTdWQ1dTJ2TjBramFSN3owTHVka1BieVlqV2F4aHFkNlRH?=
 =?utf-8?B?d2R0RmJvOGwwWnBLOHBxZkc2R04vU1NQTUdxZmwzYnkxUldXVmxxdWVOTEU4?=
 =?utf-8?B?b1dISTdySzdwZ2lTR2pTdEJOSlZGaWJkQzlhZlBZS1FUMDdEV1NUTHBrdWtM?=
 =?utf-8?B?ZG1DVXBDeER0dnZ6ZElyYVc1TlQ1WHBiR01BOWtTSW1GVFFDRjYzN011TkNR?=
 =?utf-8?B?aEhFcmNyOWFOblpFTEpRNGVTaXUrenJqenM4RXhsR2J6Q3hwRmlnMmpDV1Fr?=
 =?utf-8?B?KzM5TVpYY3V6UWxSRzY3RUlxTytHUXB0WEYvdEpxZUR4aitGZnBiM1Nkd0Fv?=
 =?utf-8?B?QXRyZUg2UHdjVUJKbnR0bHJtTXNjOE0zUk01blpYUS9XekZvUjZvOExtQ2ti?=
 =?utf-8?B?U0xjRjlkNld0WjE5UXpqc1JYc0cvQm11MWpaRkR2NHAwekZEUDVUb0F5amlV?=
 =?utf-8?B?NUo5OU9OZy9zK2dsblRqT0h4b1h3SG8yLzFUSUFFYyswamlUL2REMDJvdXdU?=
 =?utf-8?B?WXdZSllYSHZYTm0yUXJJSm9NcVRRL1Vvc0FPbTV1WHRaS01CYjF2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64390caa-9913-4bc8-4e13-08de99f704fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 07:25:35.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I015FO8tV042azcUj07mrl4Aa2L7xdveZBI5tL4CVhJ7VfdF5pMsm+i4g6szgaIaII9OZVmyJejlAwNxGssXdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-19324-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 5CE103F69C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 14/04/2026 1:22, Jakub Kicinski wrote:
> On Thu, 9 Apr 2026 14:55:48 +0300 Tariq Toukan wrote:
>> A spinlock is out because the protected work can sleep (RDMA ops,
>> devcom, netdev callbacks). A mutex won't work either: esw_mode_change()
>> has to drop the guard mid-flight so mlx5_rescan_drivers_locked() can
>> reload mlx5_ib, which calls back into mlx5_eswitch_register_vport_reps()
>> on the same thread. Beyond that, any real lock would create an ABBA
>> cycle: the LAG side holds the LAG lock when it calls reps_block(), and
>> the mlx5_ib side holds RDMA locks when it calls register_vport_reps(),
>> and those two subsystems talk to each other. The atomic CAS loop avoids
>> all of this - no lock ordering, no sleep restrictions, and the owner
>> can drop the guard and let a nested caller win the next transition
>> before reclaiming it.
> 
> You gotta explain to me how a busy loop waiting for a bit to go 
> to "UNBLOCKED" state is anything else than a homegrown lock :S

It is indeed lock like in the sense that it serializes progress, but the
main reason for using atomics here is that I need a "wait until state
changes" mechanism. I could have implemented it with a spinlock, for
example:

+static void mlx5_esw_mark_reps(struct mlx5_eswitch *esw,
+                              enum mlx5_esw_offloads_rep_type_state old,
+                              enum mlx5_esw_offloads_rep_type_state new)
+{
+again:
+       spin_lock(&esw->offloads.reps_conf_lock);
+
+       if (esw->offloads.reps_conf_state == old) {
+               esw->offloads.reps_conf_state = new;
+       } else {
+               spin_unlock(&esw->offloads.reps_conf_lock);
+               goto again;
+       }
+
+       spin_unlock(&esw->offloads.reps_conf_lock);
+}

but this effectively turns the spinlock into a busy-wait loop, which
felt a bit odd to me. That said, if you think the spinlock based
approach is preferable here, I can switch to that.

> 
> Also what purpose does the atomic_cond_read_relaxed() serve?
> I haven't seen it being used before.

I've decide to use for a few reasons:
- It uses READ_ONCE(), and I don’t need acquire semantics at that
  point since the actual state transition is done with
  atomic_cmpxchg().

- The common implementation includes cpu_relax(), so it avoids a tight
  spin loop.

- On some architectures (e.g., arm64) it may map to more efficient
  wait-for-change instructions. In practice I didn't test on arm64
  but looking at the kernel code it has the logic for that (see:
  __cmpwait_case_##sz in arch/arm64/include/asm/cmpxchg.h)

Mark



