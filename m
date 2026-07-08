Return-Path: <linux-rdma+bounces-22870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oO90AknjTWrg/gEAu9opvQ
	(envelope-from <linux-rdma+bounces-22870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 07:42:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D04D721FD4
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 07:42:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NnYwkClG;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22870-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22870-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 393E3302236A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 05:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACCB3BCD38;
	Wed,  8 Jul 2026 05:39:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718973BED24;
	Wed,  8 Jul 2026 05:39:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489156; cv=fail; b=L6tKa/urrzVFpgDVpYR1vRG5nkI8pmf68OEDrM63i05qndwtxKqJNYwTi7ntD5h4ZF7QF7CovS1ZpMYg4oJih02I9Hb17ggEpVVH1sO5rh0be7X3fGKHjoqYGwocGrwXXf/FPxUkz6SxYvoKgmJryjuuM3bSCXZ4mv0aCcZf47k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489156; c=relaxed/simple;
	bh=C72bZEY5L7BxEHJ7WXXaDfIQ2lnNO8iJnhvdcWLmhKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m8hJkcT1b8VVfins0hPrzeDYTtQhbEpuTdZ456a4Gh/zB2Y/HopYoGP0BLHXbdYOYYWOoyhgq0Z9aRUka+3XFi3EY1MgZOxx3t4mO79NX1RRvWLwD+sWwdIvXQoc+MjnXjaFg/NddFbdGOc0rjIZVwXrZTyupKgqCIfLQuS77AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NnYwkClG; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpmIm1pdhuWfPfk1FXacwqDoVKrbRWiXr55itIhqpdLheQ1i3n2QbbbNPyOBlud98DPocjzVXfmw0Nx8PhFwdunnEbbHZsAcYQNSnV9KuSXWUTIWuuoYl13qKTpJmzV0efBJkw7EoxE4by/8hnPgawPMGXanBJvy6NvJ5Y8EoXCuIdiI0cpFaz2wasS0tt2Q/KOZWUQjGHW4kH97vUQb4vi9J1ZJ/36Of96zeAbzYPFdfRmWzOPzwcUEcM3qVVAc816ug+T0mjq5w/WPDzFh9HOvojOvwJy1fj2W+jRWK6fnrJrpb0l/h656Sl0HmQiejFhjXh6+9En13Wsk9Lld9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kqgfgXA8gwbHn19yZbMkfeUg2trU5Cv1TCjxs4k+FY=;
 b=MfR3I7/pFIlkAWH26DCZesAntYgbmxyOnNOK8Q4vzuETPj9AIUBDlk2E5FDIjzVZU2mSKQcvRmBiWWOAMaNO1dKKHUE418hRl4acrMvtl6L1Hndko8oXCH+SXUzwB3v7TYRtyYzejuvOTvBQv1uoB5l11gY2FeT0Q+x30Z5T4D7W5EIrP1RHg9Jk13XbLiFdVyXr50eQ25fNESDuLdXGTl4ippJ28Nur1Ydm+trbKmnRjjTslZVH4+FWpBOWxLkBxmiVnrKKTYlDnnpKx8CKZbQcOyI8eGVxh0YCE5bCITpKtybzpqjQlXVZVwD4M/OrIEw8mQ3UhZ6b/R+eM6tztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kqgfgXA8gwbHn19yZbMkfeUg2trU5Cv1TCjxs4k+FY=;
 b=NnYwkClGNiMWk0D32f0AmKNGhPxrWCXa91LGCIHEFVys22TFwW4nilHpH/sFDsWDgFScF7rRdD+ApZHJKCOz5Js793POEUrmFKLWUJlhlKaOdSz8V6/Z10sJmAHCdq/3bEPmFaZ2y11o/MtXsfuycG+G8/Bs9w8PeQz8RtHaBCX5EBVakrMu+uFDc2CgEPCQ5j/Gu/VOoHkwyFfHUw9udKmpMuc4a07YgAKa70N2a64shA89liQfulLMxvQIlylLb3gWVFm7C4jvmm5wwylSFP7miUGxVollOgSAVMyEgxXKh7n6PcFC0EXzFjy4OiUUo2DoqD5+ZulieAaqotSfuA==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 05:39:11 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 05:39:11 +0000
Message-ID: <a97ff986-d625-44e1-90cf-027b079cb1d0@nvidia.com>
Date: Wed, 8 Jul 2026 08:39:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-5-zhipingz@meta.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260702181025.2694961-5-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb79d3e-bff6-4f19-ca37-08dedcb33c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UdMh3vt9V+C3DaELPRZwMy/L+g3d2+NH6XkZbcmfBnzBAbFIvVL+dPZRQ5E2Wm47XO+74EuvpOgEsxSu5jfBvAD2ctsoOIPhXThNnoXlB4JgjZTEEMrRlXRDevpmaJLvewiTEcKrt81sTiv/xdqlUNl+U8SChRzfaRZQ/vbmbB1qFY1bR436dVEVWeGHzZH7ptdnW2pzghQuyLUh+sHB5KeP4RvsX9NhPIM5wJoPCVvV9AKmBsw5ensmXCITtmC28b+oeMfpzxhq8BpGWx8lcrBnmioNpzH9mmLcy1Ag/bJnS958vppxGvc0+ncYdkMyrchTL39uR5qfzStCARqZ+D6GskeXODKpZZIuYubIS5VvLx5gaJW/BTA6Wcl+cGw6ySuTGuGHX871Lyj4KdTHniFBftziJ0fZuef+4D5PvZPe4gh4oT7Si7DKM4SyxFu7LeCAxvRULCXnNUMOm2rKGzA0nj6Sb5tss2/QdxldHGk3P4uoTFSMDBCshqj6KmYxQvHOKSBy+jSvT4s0DSof56WwbnbsnlAuk7qD+ssM90rk+xHDbDOBJOL/NJMaR7Es535ND/QJvoBfgTY9YyI+LbnQdXVKIXKdUvF6+FqLq5O0yhGKkgY0mJ0WK/ijvIayDdzAWxN5rGG3OafTY7pWA7Seb4U+QTrEElqdJL+xq5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpuQkVtTFBMcnlRbXBMWkt1and1VU9Lb3UremZZOW1QV2ZaVmp6N0RXRUE0?=
 =?utf-8?B?QzI5U0Q2MkM1ZVZUNWNsbW01TnlRK2drWndNYWhHcVN6T2N1WkRoQitVODRr?=
 =?utf-8?B?SHEvWDkrWkRvL20rMzNWK2NteUg3OTljazl5L1hDVnUzTzFLN3N3clJ3QlJB?=
 =?utf-8?B?dm4vU2lmR1Z2Q2s1a3NQbndRaE1UazRWYUxjTy9zWVBmMWM0M1U4Q3A4Y1lC?=
 =?utf-8?B?Tk5zNlVYNWIyYnpLSjRGcHZyL1JXVnZDckpUQ1BLWkRiT0YrTUpmaGZFTnB4?=
 =?utf-8?B?OENPZExKV0s3WDZWeVhmQk1lekdxZ3ZKY2wwZ05QdUhSZHZPbmprb0ppSyt4?=
 =?utf-8?B?SWVURDk0QlVIbmZsUWg4c3gyK2JDZlR2aDdUcWF6UUFnL2hOMm9wcTRDTXBW?=
 =?utf-8?B?NXY5aS80R3BMUXI2YmFBMGZvSlM3RmdFUkVZNEVtUVF2WEllQkp2eEpSOTNV?=
 =?utf-8?B?RE1iVFVLMS93OCtBUnBtS20vNGFxVUovUUdKQi82djFIMGgxdzAwSUhzSkZs?=
 =?utf-8?B?YmlmZXpCdkN3UGMvd09CQVNqWktKS0pBV0pCS0VGcWw5V0ROeFpEend0czJl?=
 =?utf-8?B?Y3l5dER2cnArWGowL0pDQlNwMzQwRHNUL3ZOTzJIV3lwQ3hZd3lydGN0anNR?=
 =?utf-8?B?b3pKcXVTWG54eFJYK2xBdEgzWE50RTlwYUs5ZFJXZXc0ckhYT2g5bjM0OWpQ?=
 =?utf-8?B?by9xTzFBNGUxWmMzcmcwa3dvN1RLNDBjRHk2c3BJcHp1UVN3bkxQalZMYWVy?=
 =?utf-8?B?UzFiRkFhRmM0ZlpCREdwdEswbUk0ZG0xbjYvdXhWZDVIRGVDSWQveW9JM1dL?=
 =?utf-8?B?VFN1UjZxQ1MwNTlSa0RWV1JQbTJFNkVNQzZyZDlYWUR4RHc1ZGIrRW02QkI0?=
 =?utf-8?B?U2p3T2dRV0h1cVovMG42NHk0dlNwbXIzWGtQcDdDcDJXaUdkN1puQms0bFdE?=
 =?utf-8?B?UVk1eE5La3NoSkh5c0p3ZVJLdmg2cmJNOXRHUW1mV0xmZUFCTDVWMXJ0ZVVj?=
 =?utf-8?B?V1loYnBXYnJYNXVNU1JZTW9OOElqeThlU3FRWlVNNTdESzNvL01vRlE1cTVq?=
 =?utf-8?B?MjR1ZzB5N3ZhdGZoQml5ajJhY1F2YXpXK3FTZi81TzlLY2c4eGg1dkVzdEwx?=
 =?utf-8?B?MjhkMjdObTJvdk5mdUpCQ2pHSVc0bTEwTWhsWWVZZnkrQWtxTFB2Q0w0Q1VC?=
 =?utf-8?B?dGNaejYxMlVRMXVpMTB2bkdqMys2ZEd5L0REd2xXNEhZbDJXeldjdkxPWHo4?=
 =?utf-8?B?dldHLzRXOFo1ZTQ2Z3Exd0NYK05PSlpkQVBVVkRuUDZPVWxtQUFCd3pZak1l?=
 =?utf-8?B?R1lsUWFYWFQvOTNTaTJhMzlBYmRzd2pPb1ZXUDV2a21NWGllOXVPWVpTZWZV?=
 =?utf-8?B?aXFuREI0ZWRydmRRWGVnUENFNnExR1lJNUlBK2VNVmRTcmNKdTc4dUphcTJy?=
 =?utf-8?B?QTR5WGpMMiszWXhhR3JSaWl3U2ZYN3k5QmQrbTg0Q1VNM3NKNDZXNGI3enZQ?=
 =?utf-8?B?SFdYanBZOHlNcnhVUGdhdW9CMW9sTkFDZXBkeVFGQnpIOUp4b0lMZWZxMEtv?=
 =?utf-8?B?YkpycDJQQ0hYOEUrd2I5OUZyRzhRSkk2b25GdVprSjl0SGxnY0o4U3R4QmVN?=
 =?utf-8?B?VFRZWUtjQlR0d2JOZklGajdmZnhZYmhiK1FFZ1FSbjVTZW9pT1ZONzZUZm5p?=
 =?utf-8?B?alcwQkkya3lIU05qaktpaTU2T2JOUTU5R3pkbW1CNW95WkZVSExNVU90NDJi?=
 =?utf-8?B?MnBUamNVYUxSeWlzSkFTTUV2SE1yVUZjTGYrYzYweUdxYWpuWkJPZkxldnVm?=
 =?utf-8?B?eWxmWUJOOFB0M1RGWmY4M3hqZVZvd3BKUnh4cEdKVDMrZDNROEpUbEp0WnF6?=
 =?utf-8?B?N1lJcG9zaTNSYS9vcDIxbjVTdEVkMWRsUXE4SWNFanVrZjZxaXRFL2FQanVR?=
 =?utf-8?B?Um4vVVNSZFJ5dzlNRU5qVjdiQ05LLzlPS0tuT0xkbW5EQy9kWng4ZDdETWhP?=
 =?utf-8?B?MldZSlNCTHhhenc4cDFKcngvRU8yNmpmQlJxL1FaSk93b01PcWl0ODEvdUF4?=
 =?utf-8?B?Z2JqbmVvcjg1eWREdldob0k1VnRaZjhoVCtaVWNPVE9nTks2UjQ3bk1Bb1J2?=
 =?utf-8?B?clI1MUk5SDliVWZsaHdVK3ZxZWdoY0h5QlZxdnhEa0ZIclFqS2JEYS82VFdx?=
 =?utf-8?B?ekdZRGUyWEFqaHhZdDhpRitMQkJKbE16dmFpY1gzQ081c2xoZzhyajFqeWRt?=
 =?utf-8?B?aktibVFSYkE3MWplLzJCaU9EUDkvOFMzV2VNeUJXWUkrMyt0SStyUXNoOUtp?=
 =?utf-8?B?SXBmaytSVktmWjQ4a0lKZ3llbzRIUUVvNjBmS0xmaXR1OVNIOXFkZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb79d3e-bff6-4f19-ca37-08dedcb33c9e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 05:39:11.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y1pWe9NQzoX2g2zxYu6bdW84Thp00Yme5nj7VBgiG4hlEJqqaoGxegSnxHZku2ES2ihfRPS7DhTu7uuuAE6JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22870-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D04D721FD4


On 7/2/2026 9:10 PM, Zhiping Zhang wrote:
> External email: Use caution opening links or attachments
>
>
> Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> (typically a GPU or a vfio-pci passthrough device) traverses the host
> PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> Processing Hint (TPH) Steering Tag yields the best placement for the
> traffic it will sink: per-endpoint hint selection lets the root complex
> or switch direct DMA to a specific cache slice / NUMA node, cutting
> cross-socket snoop traffic and DRAM pressure under sustained p2p
> workloads.
>
> Until now the mlx5 importer had no way to learn the exporter's chosen
> ST tag, so dma-buf MRs were registered without TPH and ran with the
> default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> patch wires up mlx5_ib to query that metadata at MR registration time
> for p2p access and use it to program requester-side TPH on the outbound
> mkey. If the exporter has no metadata, fall back to the existing
> no-TPH path so behavior for non-TPH-aware exporters is unchanged.
>
> Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> steering tags into local ST entries when table mode is active, and add
> mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> index.
>
> For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> creation and release it again when the MR is returned to the pool or
> the backing mkey is destroyed, while leaving the generic FRMR pool
> core unchanged.
>
> Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> modular mlx5_ib builds link cleanly.
>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>   drivers/infiniband/hw/mlx5/main.c             |   1 +
>   drivers/infiniband/hw/mlx5/mr.c               | 116 +++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
>   include/linux/mlx5/driver.h                   |  15 +++
>   4 files changed, 167 insertions(+), 14 deletions(-)
Reviewed-by: Michael Gur <michaelgur@nvidia.com>

Thanks.


