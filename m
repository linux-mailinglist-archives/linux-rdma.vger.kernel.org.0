Return-Path: <linux-rdma+bounces-23270-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPuHKqVQV2qIJAEAu9opvQ
	(envelope-from <linux-rdma+bounces-23270-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:19:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D99475C61E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ibNzwRpx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23270-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23270-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 971413004DD2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45241F7CF;
	Wed, 15 Jul 2026 09:19:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1141F7FB;
	Wed, 15 Jul 2026 09:19:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107170; cv=fail; b=O7wYxY+aX7oHfTVRtp2dPn+0f0rmknu0vd76lUZky8+BuiUH4/ojgujlxdMbpIPZjDYqsm/o+gVFTwKpUDdlFMmbP9GPC4sN5NL3TQ/dBTDKlPlevRBjFx0gMbzn7FAfVWz8SPIugOEY6vRLEl2vQHliwpMBZDqiiws51kC72wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107170; c=relaxed/simple;
	bh=YNbmiYVmzpVb3fKaLY/g61KSKhFq0sYRFm+oVj3MeFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elMhThop8Wq1cViko2wJcUDK37CuYYJ1n7Q63jFK2EJba21/4FUGBNMpzR359Vqds6ZgeooxKcR8r5/wJHyPbMdXW9qmupEleGrqXxhN9mBMCJ876G7ImUnppNHZBSM+JwQf2dMxxJpvX4lTQAzigH5Cf0SKtd1bzDjp8pI/uZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibNzwRpx; arc=fail smtp.client-ip=52.101.57.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adQRPL2595JueHWV+73jESpArQ9cNY+L0dtIDCVUDfAAwYllcrNoUqC13k2CendvAq/HhePKxIH8cHbLYwQwz1jQTuYyQzoPp2jq0qXW2RKFRUjJT9rv9ThgeOVLL3KxmFJIaSZ/jYEdvbBge6WVey9SucaCoU8y63/dmNrAzwL3LN/ptdZp1SWtRFxGghO6TxsGPkE/ExpLkA3Oek89dGkr14ZdAkV3GuXIsA6exsp6/QxKm9VUVhqMyjyvJjxR67GYTb1GQsTOYAFzRoOr12jXsSa26+Ur0Ei4bLkYlNzuQituz6s+qjmf9C91BlIB8wxTuhJTq2Jv1IVVypFUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJHJ1WJ0eUtGwO2OwykMfWrszi+syVUKKHwOOXWKMY0=;
 b=BJBM46Wkee8f97pwaqOW0Phl5vC2Y176wOn0OSANvpc90ecR/ELlN+LSN6RSMce03dZV7j0eDCT/UT/7VZzpz9Fc+7GU2dx5Uw9SakMXHKsFDFBHophwhKRsVocteGw4wNUZ1hzOcB7rZeYU3KyCNlHix98faAPmMyaDb1YiRc0Ag1mP7ezNNm/tf/8MPKm8TnipX2MwanAlxNV+5N0tbGg/YuxsEbo1LekZDuRQUL5/9aSQEbSpN6fjbpD/hCMvyzIpr/sRwesCYqjvnk1eLOXwEokHtHcdcOhu/QfHzz0Y8o6PoYXWvWmR3d3ppFRqSTjf5knqDoTjGcqsVjf3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJHJ1WJ0eUtGwO2OwykMfWrszi+syVUKKHwOOXWKMY0=;
 b=ibNzwRpxhK+j8o08nMAy4G3fGNRp3hASRk0pTaqVIDx6tGTj/cJLaceVeaIX4SC+SmAUEFswJF8QrYjs5nMogJ9GO3xU7HW6EzY5OdrC8d65F5PNOXRskuSAjmEs+Usu779qreYQymsxq77Td3jVgBpbTG1Wm/DOnk1fE9Pb3gsAE+B3X3YEvNAZJIzref9kbQ7ZEqXs0EwvFvLiLahVFwRVqVtLps3yRoRcAZ4H+AlPNX8YZXfOBVD0FtrSZ3qSjM0c8rAh6eTc42xirVEUsebQbWED8gtxZhIQ/ODfWck/XJG+pykLBrIaC4uJWaZZVIOf57LCiEv8UoPk8M5saw==
Received: from BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 by EAYPR12MB999157.namprd12.prod.outlook.com (2603:10b6:303:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Wed, 15 Jul
 2026 09:19:20 +0000
Received: from BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df]) by BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:19:14 +0000
Message-ID: <778ebed8-0805-4936-b689-cc633a1702b0@nvidia.com>
Date: Wed, 15 Jul 2026 12:19:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Use unique names for software steering
 caches
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alex Vesker <valex@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260715-kmem-dupliate-name-v1-1-85551c328155@nvidia.com>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20260715-kmem-dupliate-name-v1-1-85551c328155@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5873:EE_|EAYPR12MB999157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1072b755-321d-4262-f50f-08dee252237e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	DIRmZVCDPnMNncFQvRp4f+6KMq8LlnWb3rBm1BNYixgLh4ykROYWA24tKBNG4anEqF2BKqB0+4uFIFTIYT2sr0+Yu1zgiRWwJzg7s5tE0vOlcrnLfPnJ/d5EqiLUbELKO4IVSIs04VRAB6EOWQL7sxrkhQiN0zznE7KPEYbvxHr8Zd1F3CAJJaIS717l3fJigiiGrEvp0ebwGFvBFIOj9yOJhkIULifcuwUGvM3YUypB3gx4JCqOZo1zBZvGujdPZjj3KuvXOfOusxLhxXGBcJO7YTX6CC62efJP9QjCWPQp9mRRwQuX8pky/DbllOlJCv7fJJ/SygkrhGZMJiwvDP7/o+4Ufs8W2U1O4JNlQ2F7fPLh7kTftyTMZuqPksPjVk3vXcVRxkYUkSx8Ng+Zw4YB9ylJSb7mx1L+ROkdctAy4VJ+n0kZcQu79ySuTONwADa0BDL70ockfrcbhYU7QtF9yr7PnlAjb4huBs61XVAKeKXROeMTTLSqd6VuX/QDdgPuGKGZSLnQjhYxndPEn2zOODx7YAxS1e2OvVod+NF2+MIRy71b3LCLGoj+zZh6i+1C/bkIIRXOhcF5iEYAwVyEVmqEurDc2xkHzjiHJDHxxyR3OAlPkPy+uvn7shqzsNcK/hNJLcAYAzBpvR1Jt9QfFMVTOBVDyvoe0OJlRQnzB2wnfwZLel+QwmrKtuB4hYqJ86fYp7BxesHdj53fVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0dTS2NLdlUyRitONEpuMWZXcEJXc3Y4V1gzUWJ1VmdJRmN0WktPNTZLMmsx?=
 =?utf-8?B?TWlPR3FGS3VDNmJUTnVObnROV2dBekFvcTdDeUhMbER4SUR0KzRmOXNTOEFt?=
 =?utf-8?B?TlNLRU9RV3NvRDhlbER6U2NyRXEyT1VtTkdpRG9paE1TNnZmR09hZVdOQjB0?=
 =?utf-8?B?Y0lpdkN6allvVlh6QldUczl3cUlINFJWM2ZZTWljSE82VURwZ0s0dFhFY2ps?=
 =?utf-8?B?VmZIQUZZSEVUMTRybjlXT1hyNmp1a1ZVYUZYOW54eE0wVDNBeFYyakxjS0x2?=
 =?utf-8?B?WWlaNW43dWRvUHZIS3VCUE1Rd3ZnRVVId0syMFFzdnlTUUR2NFUvQS9rV091?=
 =?utf-8?B?N3RoRWhFbDNrTFJLeGZmMVpQMSt5TDhsUWpqOGhwUzkrajg2N2FnQTViRmQr?=
 =?utf-8?B?cFllYjBtQ0JTQXRGejVXR0pJcjVwN09FOCsyc1VZOTdlVGFiM3psb2IvamxI?=
 =?utf-8?B?WkNXZm94L3BzR0lkMW5ueVBaeFJnR25BQlg2Z2RUckg4cTVQMjRoNEtSanU4?=
 =?utf-8?B?dEJMUDk0aFBQNENEYThNOXdjd2hDRW1GazMyRGNveThWZDQ0dU92Ui9ySU9Y?=
 =?utf-8?B?R2lGeTFqVjNEekFvSlBUMWtEby85eGpZNFk4UmZvQktuck5vL3dVTVRoR0s3?=
 =?utf-8?B?SmtiYm5QWWdyNyt5TVF0ckJmSUFzcHUxTzZXejFySGE4bUdMMVYzcEhZeVJB?=
 =?utf-8?B?c3Z3b1Y5ZFJ1K3VpMDl6Q0VMRDBscVE3Tnk2MTJqN2d4WUVETFF1bmo2VkFM?=
 =?utf-8?B?NEJMb05XanBBQUNFcFo4QTd2U1JrN2tzYzY0cTFaa0R4SHhRVk1iRko5aHl2?=
 =?utf-8?B?VlBDTWJ4YWRpMFB4SUlvYWVnenVBbG5BY1owZ2c5UVRPbk9sVzFWZFl4SlZJ?=
 =?utf-8?B?cmJyT3JKb3dRQjlyZEhNTTNvSkVuRFE1a0swNlUyNW5kY3B1VndVU1A2R2xV?=
 =?utf-8?B?SlM5Y3hFcEk3cklTa2s5U2FyU1FoeVJxYk02NTJrTVVmTURqS0RtbXFNeitG?=
 =?utf-8?B?NnRHMEE1a0FHc2h6OEp4ZXEvTlBWMEVMcDQ1YzRKT0ViZnlYNWxsbFQwMFBX?=
 =?utf-8?B?UGxnSnc3T3ExcHduUm5sTThrYVFQY2lQdWJrUlJyYlpEdEFaSDV3NHVIWllr?=
 =?utf-8?B?eEhuK2g3ak4xaVVEUFN3WWltTVVuK2c2THhXd05Zc0pDV1VYL0w4bTZGQzJo?=
 =?utf-8?B?N1M3anlpUlovK1R0bXByQmJvc0lXdm5tbzg5ckRjbzlnSlVqQ3g1NXJzMHN1?=
 =?utf-8?B?M1BFYXByYU9rbm9TL05yKzhPQkFod0JjSzIxVnQ3aDFqT2EzbEQ5bFgwUTBu?=
 =?utf-8?B?Q21RenpjTjVONm13U2xoVVRKaGJueGxPc2FRY1hhb2RQV094bUpDOFBlOEdu?=
 =?utf-8?B?blJFUXFLUXFmeFZJMWp4dVd5ZTN6MWRaYmRLdThVSklvK09wZUJvU1ZyWWNZ?=
 =?utf-8?B?V2s1Q0p3LytVWVVOS1VTcFNaT1grNUV5UWNaTHplYXZDa3pUdXJLdWtScGND?=
 =?utf-8?B?bnJYT3dCZitHZGpTUStVWGsvaFBET1NQZHVJUzNkKzlGb0hBcUNrNUlFT1JQ?=
 =?utf-8?B?UUxsci96SEl2eEVJNEhMRmV1WG4wUkJGcmRXSnFiUFlpeTdoTllJMHJLcExn?=
 =?utf-8?B?K0U1UFFaR3JHNTlRQTFYRlhWSGN6ZkNucyt5MkhrNjFHQURJeFNMWkdJb3Ir?=
 =?utf-8?B?eUxCelVOeFY2ZzNtZWI4WE9sb3hUeWtrWG9ZaWs0a1JkWUtuK0Z5Q3ZoUDVm?=
 =?utf-8?B?STUwM3BiY2JQOVhNeHJDck90UCtOT2VlNnB6RG9OQ2dUUVdYTlhRWVZERVl0?=
 =?utf-8?B?VHFvUXNzQUg4dVpuMkN6RloxQjhQajNlcXB6VUpYVFRjdXlzSTNlQ0FmTU5l?=
 =?utf-8?B?VmxGcm1vWmxUZ0JhczhtMktzaDdyL0U1SEFBN3dXTE8rTjJCM0E5SER2SUFM?=
 =?utf-8?B?R1BKa0hCTzFXYXJUVDdFVFJHQi9OUnlQd2lEK0V5SXA1d0dlUEtwM2locE1O?=
 =?utf-8?B?NGdndFpNSU5nZlZxZkJRMkduTllGUWsrdXQrYk9jQ0hFNExlVXhZbFBnRWtl?=
 =?utf-8?B?Z1hkYUFrc3V1blk4MnU0OEhmdW1yL3gvZ2VsUzk4NEVIbFEzQm81T0c0RVhB?=
 =?utf-8?B?Kzc1YUFwR1pYMGxQTlNVSDkzSlU3WUFSUnAzMm1ZQ1h4ZGh5YTAwSW9OQmdV?=
 =?utf-8?B?SmN3RDZrUmpmM2FMTUtQcW8vcHFNNUNlYStPQTZHTTFNNDQ4QjlnYjBZTUFS?=
 =?utf-8?B?U0Nza1dlcFdaQVB5di9MVEZneEE2WjVmUVJpSUpnellKbDVhMXY5ZzhYaWZO?=
 =?utf-8?B?aUdHR2NaRjR1S1JVS3pqcTVZaDM0RDBwRkFGYVNNNVRndnZpc05Pdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1072b755-321d-4262-f50f-08dee252237e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:19:14.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DocMLi1SdGU7p/2bUyiMrCu8IQ7dh8KJxaUSN1xBe+ljgqo4Ah9oATvc85Vq91Allu9/Xtaf7Zg7t270KtW9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23270-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kliteyn@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:valex@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:borntraeger@linux.ibm.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kliteyn@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D99475C61E

On 15-Jul-26 11:22, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Each software steering domain creates its own slab caches, but all
> domains use the same names. When domains for two devices are alive at
> once, the second kmem_cache_create() triggers the following splat:
> 
> WARNING: mm/slab_common.c:111 at __kmem_cache_create_args+0xca/0x480, CPU#18: devlink/331372
> Modules linked in: act_mirred act_skbedit cls_matchall act_gact cls_flower sch_ingress
> vhost_vdpa veth nfnetlink_cttimeout openvswitch macvtap macvlan vfio_ap kvm nf_nat_tftp
> nf_conntrack_tftp nsh nf_conncount vfio_pci_core irqbypass scsi_debug vhost_net tap tun
> vhost_vsock vmw_vsock_virtio_transport_common vsock vhost nft_masq nft_reject_ipv4 act_csum
> cls_u32 sch_htb smc_diag smc ppp_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc loop
> algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> nf_tables mlx5_vdpa vdpa mlx5_ib dm_service_time ib_uverbs_support vringh ib_core vhost_iotlb
> mlx5_core s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core
> dm_multipath drm_panel_orientation_quirks uvdevice diag288_wdt watchdog hmac_s390 prng aes_s390
> zfcp scsi_transport_fc pkey_pckmo pkey_cca pkey_ep11 zcrypt paes_s390 phmac_s390 rng_core
> scsi_dh_alua pkey scsi_dh_rdac scsi_dh_emc crypto_engine autofs4 ecdsa_generic ecc sha512 [last unloaded: openvswitch]
> CPU: 18 UID: 0 PID: 331372 Comm: devlink Tainted: G        W           7.2.0-20260712.rc2.git0.e3321fa3034d.300.fc44.s390x+debug #1 PREEMPT
> Tainted: [W]=WARN
> Hardware name: IBM 9175 ME1 701 (LPAR)
> Krnl PSW : 0704c00180000000 0000038139a6771a (__kmem_cache_create_args+0xda/0x480)
>              R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 0000000000000000 000003813b7de578 00000380b9eb8974
>              00000276c417f690 00000380b9eb8974 0000030144623348 00000277234a1660
>              0000000000000020 00000380b9eb8974 00000277234a1600 000003813b686d30
>              0000000000000000 00000380b9e9a810 0000038139a6771a 0000030144623238
> Krnl Code: 0000038139a6770a: c02000ebb737       larl    %r2,000003813b7de578
>              0000038139a67710: b9040039           lgr     %r3,%r9
>             *0000038139a67714: c0e5006e2eb2       brasl   %r14,000003813a82d478
>             >0000038139a6771a: a7390020           lghi    %r3,32
>              0000038139a6771e: b9040029           lgr     %r2,%r9
>              0000038139a67722: c0e5006cf98f       brasl   %r14,000003813a806a40
>              0000038139a67728: ec26018e007c       cgij    %r2,0,6,0000038139a67a44
>              0000038139a6772e: 58d0f0a4           l       %r13,164(%r15)
> Call Trace:
>    [<0000038139a6771a>] __kmem_cache_create_args+0xda/0x480
> ([<0000038139a676a2>] __kmem_cache_create_args+0x62/0x480)
>    [<00000380b9da1c70>] dr_domain_init_mem_resources+0x80/0x240 [mlx5_core]
>    [<00000380b9da226e>] dr_domain_init_resources.constprop.0+0x7e/0x2c0 [mlx5_core]
>    [<00000380b9da28b2>] mlx5dr_domain_create+0x132/0x250 [mlx5_core]
>    [<00000380b9dc1e20>] mlx5_cmd_dr_create_ns+0x30/0x90 [mlx5_core]
>    [<00000380b9cd8dbe>] mlx5_flow_namespace_set_mode+0x6e/0x130 [mlx5_core]
>    [<00000380b9d846ec>] esw_create_offloads_fdb_tables+0xac/0x5a0 [mlx5_core]
>    [<00000380b9d865b6>] esw_offloads_steering_init+0x1c6/0x480 [mlx5_core]
>    [<00000380b9d86e8e>] esw_offloads_enable+0x13e/0x410 [mlx5_core]
>    [<00000380b9d7b04a>] mlx5_eswitch_enable_locked+0x36a/0x540 [mlx5_core]
>    [<00000380b9d84ff0>] esw_offloads_start+0x50/0x1d0 [mlx5_core]
>    [<00000380b9d8774a>] mlx5_devlink_eswitch_mode_set+0x35a/0x3f0 [mlx5_core]
>    [<000003813a791e68>] devlink_nl_eswitch_set_doit+0x88/0x120
>    [<000003813a5b93ea>] genl_family_rcv_msg_doit+0xea/0x150
>    [<000003813a5b95c2>] genl_family_rcv_msg+0x172/0x210
>    [<000003813a5b96c2>] genl_rcv_msg+0x62/0xc0
>    [<000003813a5b7cac>] netlink_rcv_skb+0x5c/0x120
>    [<000003813a5b8f0c>] genl_rcv+0x3c/0x50
>    [<000003813a5b74a4>] netlink_unicast+0x1f4/0x2b0
>    [<000003813a5b783c>] netlink_sendmsg+0x2dc/0x460
>    [<000003813a4c9764>] __sock_sendmsg+0x64/0xd0
>    [<000003813a4cc878>] __sys_sendto+0x108/0x160
>    [<000003813a4cdf50>] __do_sys_socketcall+0x350/0x460
>    [<000003813a8184d2>] __do_syscall+0x172/0x750
>    [<000003813a82d5d2>] system_call+0x72/0x90
> 
> Prefix each cache name with the device name to make it unique.
> 
> Fixes: fd785e5213f0 ("net/mlx5: DR, Allocate icm_chunks from their own slab allocator")
> Fixes: fb628b71fb2a ("net/mlx5: DR, Allocate htbl from its own slab allocator")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Closes: https://lore.kernel.org/all/a3cea501-4d1f-47d5-b6d0-fcda9a0aab16@linux.ibm.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> index fedefb565a21..c9f20a9033eb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> @@ -98,9 +98,12 @@ int mlx5dr_domain_get_recalc_cs_ft_addr(struct mlx5dr_domain *dmn,
>   
>   static int dr_domain_init_mem_resources(struct mlx5dr_domain *dmn)
>   {
> +	char name[80];
>   	int ret;
>   
> -	dmn->chunks_kmem_cache = kmem_cache_create("mlx5_dr_chunks",
> +	snprintf(name, sizeof(name), "%s-mlx5_dr_chunks",
> +		 dev_name(dmn->mdev->device));
> +	dmn->chunks_kmem_cache = kmem_cache_create(name,
>   						   sizeof(struct mlx5dr_icm_chunk), 0,
>   						   SLAB_HWCACHE_ALIGN, NULL);
>   	if (!dmn->chunks_kmem_cache) {
> @@ -108,7 +111,9 @@ static int dr_domain_init_mem_resources(struct mlx5dr_domain *dmn)
>   		return -ENOMEM;
>   	}
>   
> -	dmn->htbls_kmem_cache = kmem_cache_create("mlx5_dr_htbls",
> +	snprintf(name, sizeof(name), "%s-mlx5_dr_htbls",
> +		 dev_name(dmn->mdev->device));
> +	dmn->htbls_kmem_cache = kmem_cache_create(name,
>   						  sizeof(struct mlx5dr_ste_htbl), 0,
>   						  SLAB_HWCACHE_ALIGN, NULL);
>   	if (!dmn->htbls_kmem_cache) {
> 
> ---
> base-commit: f8d04b0c74e989c515e0fa17bf779b730077f63e
> change-id: 20260715-kmem-dupliate-name-b151167f5119
> 
> Best regards,
> --
> Leon Romanovsky <leonro@nvidia.com>
> 

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>


