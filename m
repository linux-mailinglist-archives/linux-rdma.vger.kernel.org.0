Return-Path: <linux-rdma+bounces-14720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF1C821F7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 19:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E609B4E6302
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE331A04D;
	Mon, 24 Nov 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eDAijSx3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7952BDC05;
	Mon, 24 Nov 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009467; cv=fail; b=rciU1XPHgGE4t5FzhU/rK+e5+8mYNHwpV8hRLlCxkG3HGfO1keSkz9wOdfHWi9GPN85dL+sZEamF7BNoLHIfxnqM4wBAhv9/ex0Rv998V6cDCTruFmqcPNNhnSRMSxUojN/PcHfnH+md2MoGjAyB00YMyO/Je8gaeM/SFzXHDSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009467; c=relaxed/simple;
	bh=ULcoLqxBQLzm3bReQkA7+yl+Sxs/dCB/f1BD0ttYZqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqf0ZvdkN1p+niAmV9M8Mq5yPNkgD0s597K8vvBeI2XVMT9NgQq0BJnSNEiTEPR6q1JmelaPjJR6VgcNN9A3caAJK5r/x0MZbkGJS4yHjv0dgsdJjb9lQKxpZP7QyPQwEotNzzfI0sxcC29NoOtUK4/vLOU6xnOtL3L4j7jAStc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eDAijSx3; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSF4EMdN7eeHxplFj5J6Hv2EpjhPP2xvH2ZyQEmnX3hjOVtG+HsOFguNIHE1+0nwafbNtFFriw1sB+izq2rC3LlIyCUrFS4pAye4hWfN0GSo9vakrT2l83FqEgcVoj2XlbDGCQR2I5eN0ybJZpFmB5x51rAXBQyL+bnASYowxcVpEAZLUcH8FC+x2yNAkkASLCfxcHgXiR5jAWrNYlWDHpCYoQmmDexdJgVACe3qVmSiekO4y0f2RTfFzwOeOm3zNRqTwwJJ/Y5lmhBDcDUmIlI8gQzKwW8r+R9CKwu9q86NdwCW6R26tQ4obh1qbhTgeRfdLcbDLxRwRxgKyDUupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osqKJO4ab4vJOxwrML3aBBBqcksUxgzqmkVnJuPaKP8=;
 b=rbXDwuOjo1fHOzcieoa/GvISPzz+9R6DeQgLiAVu4J4PE5gV4cdoPCKBjIre52K3j0O7She1wFJiJFKg8g2+T0k7/F0kXum6DrVB8r5e48qxJKZnMfLy3XzVM7TOZ9rw9JV/IAhm4zLI5HiwcrgF7+uxiQO8n3FcJ/6o6Ekx49Skfj8DA8tbIlDOOfKjtTuOMUw0sCv0lG90MP/l5Vv6+pyzyAxlmnKBTw1j5S60ok+EaHW7hq6jArzz00mYZGNgYqmcQt3KPS03yND0HHPeoCEjZQKzL00aoRhU+W47qwAA1geJMVFLtgvMOhRLNckqAIk/4tino9grK1Eqo6cUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osqKJO4ab4vJOxwrML3aBBBqcksUxgzqmkVnJuPaKP8=;
 b=eDAijSx3BKKHqVYXAosGg5bztAz1IMxC1ltssLSlXjx0PvZoHbRs018YRPhC+GB0MxSPlC/MN7n8g+TUZ+nvZf3MYXiI8z+TVzdpql4AkeGVG5H3R5DyBsIKC/i72Ae7/dQQZgYiwYir6LX39tfT/cKgF3jvydUsZA7imZboTt+Uj5g4PNzYCo3d7PNXO7zfsj45XE7U27xWTrZrrMw2OAspA1+JtC1Oh85mfGc2p8lYdyvMHu1LmqsQ/NyVCoVPso0AqYlVs0/38d0u3MMAvybasNJFBvSVJBkG5zrXHxpHeTJauCutzUikLb+lDx61sJ9D1pv52dGj5gG6gbqtVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 18:37:43 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:37:43 +0000
Message-ID: <cbb5488b-4923-4032-a037-7ff851772a64@nvidia.com>
Date: Mon, 24 Nov 2025 20:37:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix validation logic in rate limiting
To: Danielle Costantino <dcostantino@meta.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, tariqt@nvidia.com, pabeni@redhat.com, saeedm@nvidia.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251124180043.2314428-1-dcostantino@meta.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251124180043.2314428-1-dcostantino@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9913a3-e23b-41f6-2479-08de2b888de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUxoQ09lSm41Zm1PM3BMVjJ2dUp3NkxYMG5zQXNKYmJsOXZ4dzVqbnJtRlBY?=
 =?utf-8?B?TFc1WVRVaDY4aXh6bERsYVc4OFJZcDFaWm5JZVVUbVJMeUlCc25RRTFBNjBl?=
 =?utf-8?B?VER6QnBaS3hXRU0zWW5IWkxZUFgwS0tvOXBJS3BmRzllUnI3MTI1ZkkxeFdP?=
 =?utf-8?B?bTF0SG1nUHhMUW4xOThzZTIwcFMzYmRSRlVwRi9BV0ZUVzMzWVBxTGluWlpC?=
 =?utf-8?B?SlpzY2lXdm1xZ3RxV2tMOXFYTnJhSjVEbkRjOS9GdiswVDJZV0FrM0FoWUhC?=
 =?utf-8?B?cWQzZVcvNzMyN0VxVXNhc0NYTnJNay84SVd5b0tSTEpSdEhXY2xPNE5DaVQ1?=
 =?utf-8?B?UFYwR1ZobE5ScFQyNFFjcElpRlFzTysrZlJjTEZVMVpMb09nMFpqZVZKd1ZT?=
 =?utf-8?B?dTc4WEx0bWdSOTArQjBxcnFUQUJWOFlCWktKejlhN1FhZzJrZ1RKdmFMRVdn?=
 =?utf-8?B?M0ZoMDJSTHpJaG5vS0pWQ292S3BJS0lKSmw5ZjNEanBodnNtMVVSaTkzK2VC?=
 =?utf-8?B?bDc2VTFRS2tsWEJHODh1d083a1FRa2JheDE3dlFMVWcvT2JzcXd6ZmxvR0Rk?=
 =?utf-8?B?elJvV0dzN1dUcDZWeExCZ3lsL3BiU0FPTWVBK0hxMW5VaitJVThGWXlSMjVS?=
 =?utf-8?B?eVNDT0JmRndYc2FFWDBIdjJ6OUwzSG1RdVVma05KbWlIUnRwM2p6Wkptb2dZ?=
 =?utf-8?B?Vnk3bWJZdVNNd3h3RXlpRFlvR0kzMk4vREtuT2h5VUV3VmhNZk5HYU9jNFJ0?=
 =?utf-8?B?dW5JK3BwK2k3MWVFcUJTbVdjbVlGS3Uwd01GMWwzOVREWkxHdVBBcmY3encv?=
 =?utf-8?B?azlVOVpCM09EclhUYzVLRkFzYVJoZkF6bzc3ZEQrQm0wTXJSY3JBN0Q3cERj?=
 =?utf-8?B?RHNvYmt3OGpQcnZlRGZvWGEzQjVmS09qK1J4b0NrdzNIbWdWN204VjM0NXBq?=
 =?utf-8?B?ZUlEN3NUNytKd29ENmtxMll3azdjbm56bWVFY0V1VnN0Z0FxQWNQQTQweXhG?=
 =?utf-8?B?SkxIeDQ0VE54RHg0azZ6eG5oN3B6cENFN1JyS2hpdkphakZqTTNCL24wazFQ?=
 =?utf-8?B?NG1Xc2Vpc3dSR3lXZWUvUnFjMUpvNS9oYzNJQ2R4dW1wTWNwQjg3MzZoSXR6?=
 =?utf-8?B?ZG5hWTMweHBBWHd0WWJyS0N4QTlCRjZleGFmOThqcHo1eG9YdmRlYTJjNlMx?=
 =?utf-8?B?TUkyQUJPeENidXNVTkovRjYzTStTZTgrL2d4MXdzVHBRSGtIeVpXN2JrMEl3?=
 =?utf-8?B?bm9hVk12R3VST1Q1bURwdFhIbU45RUdxd0dkRklhcDI1NWtEenVOOXpUbExO?=
 =?utf-8?B?L2JoZ2xGWnFiSDJ5bWlBYnVnOUpoM2xwcjY5am9TWHFITm9vdkY1YzVTWUJI?=
 =?utf-8?B?VTl0d2U0SDVtYzFoaFZhOGswaW4venVxekE0UGZmQ2E4TlFkSjdjWS9sMkNq?=
 =?utf-8?B?SjdrSWdDamJiRW40MmZGYVlEdTRHbUFZTjEzVms1SFBmekczU3ZpL3hDOEFC?=
 =?utf-8?B?dUdaTnpsS08yKy9RMkszZ1FYdkJ0aThQTWRmTm9zRlRlTC9lS0lZQXl4UXFI?=
 =?utf-8?B?aTgzRkVjZTMvaEVQaW9qa0RiZ3JFSzVsUzVlZTJPZ09TNjlJYkJHeGdCdTVQ?=
 =?utf-8?B?YUhHZ1ZPSnQxU0psOTczL3ZSbjlvVGVjb3RyRWpoM1pIMGdqR2xoRTZXY0dz?=
 =?utf-8?B?cGJXYU1VL1l1TW5xNEJyTCtHMnBKVzI5d0xmZ09WdEdqcit5dkxXSU41QXVW?=
 =?utf-8?B?a2h4NnhIQXY4NGJIQXpERmRQdHRPb2Nvc0JHTENINk1qOTcyZjRzV2N6TmJz?=
 =?utf-8?B?anovZW13bXJRNWVITnJiM2NQZlBXMTV2bEpKTDFTc3doOThDME9saXNEbW4v?=
 =?utf-8?B?VUk4YTFPQjhlSzljWGwxVXh4bHFRM2dYMXhVLy9KV2h3VytCTllDcUU2bDVQ?=
 =?utf-8?Q?H8GUM+84g8usCWXvawXlyV+oZF6FNTgH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWdGazVja1pwVFg5KzhDd3l2VEhRSW9vWStGaS9sa1dDV1VCTXI1dkYvK1RL?=
 =?utf-8?B?b2ExWnNrc2pmUHVWZGtDQzVHVGYySWc4clNwM016S0RXWDF5bnFaeXZ6am1F?=
 =?utf-8?B?SUxxY1V3eTBFTWtLZVVvb29ZQ2FBYksxYytsNkdVNk5LRWptV2hlUVNDb1ZY?=
 =?utf-8?B?T0h6SVRhY2NaVkVCalNjNWZTeEhRakNUSW1MMlZqaWFjcTRvcTRZME5xazlB?=
 =?utf-8?B?NTE5YkczbGwvdVYwT1U4WnZZNlVFU1NRbHExY0ZrYW5tcnNxQy93cjlGQ3h1?=
 =?utf-8?B?d2xLUzQxNHY0QjR2RC9pMExhVSs3YzRzZnlOV0x0NGZBZGNQWUQ3STZ5aEJt?=
 =?utf-8?B?RWlnVjBvQmVXUVB0ZHRKa0xFb09vRUNWNGRNV09ZaVVzRTNCbWxrWGtqbHhk?=
 =?utf-8?B?cVlHcEp4cHZ1ZUJ6QktiL2dUTWtxREJHRjdXVDRqYUIwbzJJdTQzSHJIRlRl?=
 =?utf-8?B?VDdPTTFnS3BvOStYMFBCR0Z3UDFTQnRFeGdWdmtlNVVGU0ZodEp1dUpmWlYw?=
 =?utf-8?B?QTRJY1lGNjAxVjEzY0FGRGpObTBoQU1MNk9IQTd5NGUxTGdNZlV6ZEFoUmlt?=
 =?utf-8?B?RzAyaWpHWU54d2MvY2hrWWtsRS9sVGFMRUhvcUFpcThZcXdqVmtyKzZ2TmFs?=
 =?utf-8?B?TWtlM1RUb0JxQmJmNjRmTDA3Mi9kRVJWVW1tVnpNVGxQQlRWVk16T280M2NX?=
 =?utf-8?B?SGloSWE3YjNKVVBqQlFERW9DUkdvK0tqY1lHYmhiQVh3N05uVk4zdms1bGZS?=
 =?utf-8?B?MzIxMG5UM3BlS2RKZXJLRHNWM0xSZElJY2dHc3B3ZmVmSExCRnZxcGp0SW10?=
 =?utf-8?B?aEN0TkxGamJtTEpUelViQ051SnA1dW5xRnJuRVZPSWxBT1VLWU1SZExoMkxB?=
 =?utf-8?B?aHAyNWxZWGNOUGg3c2p2QW5NSFFSbXQ3blo4MGpZZFh5bUljemhOZ2g5SG54?=
 =?utf-8?B?WTJDckI4SlgvTndNcjlOUVBIYWtacDZweFVUSk5DSkhKbU1vT25YUktlZ25s?=
 =?utf-8?B?azdnWjB1aTVXbHdxLzNLRkovVVgrOGhjMkl0WUcwaDZnQnNuM0U1aTFCbExt?=
 =?utf-8?B?TFY0RldHb0o0SEthMzk2cWxOaFFKd2NCSHlvY0cvRU5QU0NGazMydS8zcmlz?=
 =?utf-8?B?UTgraWlxdjkzN1pSaHIvb3Yyai9rNlI5WUxDRVQxMFhsTUhMOURJNHFyd0Z1?=
 =?utf-8?B?am1xRWhvaXFzTXhQNm8xdTk3NjZFMHUxTHV4OVBXNnFnV3dLYlJaUWErbHI2?=
 =?utf-8?B?Wmk0MUxkQjR1NnRvbWxKT1NUbzM0M3p6dFpld1FaeUxrM09aUGJTOThKdG5w?=
 =?utf-8?B?NDZwSjdqVW1Ub2wzTFJHSWJJbUh1Vkk5eXNaL255cjIwb0p3eHF6OUZhQVhi?=
 =?utf-8?B?Q1h3MVBibmtlVXhTb2lqTU5QWVlUYnZXaXdtNU1tOUhubFQzT0dXMGtSci9R?=
 =?utf-8?B?eGhZUm1qNFZMMm9SdWxZUktDSmFVbHJvWTROZlNkdExBK3ZnNENpaUEyeEJT?=
 =?utf-8?B?YWVUVkRMQVJvbEJvRElFaEJ2STBkcTl5L2MxREozV3lVRWpySnRtZWVzZGFO?=
 =?utf-8?B?Z2NoaVpPTVZJMWNvZE1oTFlKSFRkY2tsMW5yUC9XY0NkVVhaWjM1S25iUDlh?=
 =?utf-8?B?Sk1LbFFXRHc3RGFEK1ZzMFJoZjZzcldYa0FHOWRKMHJHdTUvMnVrdG5VMDE4?=
 =?utf-8?B?Y0x3Q2RITThMOW5aQUQ1ZVRYNUJtcFRXa0lIRjFIeG1Sa1puQm8xeGwzZ0Rs?=
 =?utf-8?B?aE81MVQ1dGxReFNhbVNCazRPQldZY0dPQVc3enc4cllodmVoYk9iZktFaFZk?=
 =?utf-8?B?YVVmOS9lZlJmS1BtdEQyL3p1K3JJb05SbEx2TDlKMFZ2UWF2Z1BCb2NONEIv?=
 =?utf-8?B?N0R6ZE5DNHpMS09hb3RacDZrZk1Pejc2RE1scjc5ZVBjQ3doMWgxN2xhd3p1?=
 =?utf-8?B?WDVIaktvWTBjNTk4ZUIvRW9YYWdCNzkraFNSWVZ6NUNFM2RzT2g2UzNraWVO?=
 =?utf-8?B?U3ZhWHBLTTNjem1SVm12cVRGdGRLeW5Sbm5sSkhBWmpBSXFGVnFCTEtHZlFP?=
 =?utf-8?B?Ukkyc2EvL29XWGdTTkU4ejFmdklXclVqK2NwRUY5N3FIWmRRamVteXpqTGlT?=
 =?utf-8?Q?wY9I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9913a3-e23b-41f6-2479-08de2b888de6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:37:43.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xU7iqNp3L0qbq9qlsbWAoHHvUl2lrrQGZ7xuFaqMsP+iPOnd7HUHqd6wtrh4GoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

On 24/11/2025 20:00, Danielle Costantino wrote:
> The rate limiting validation condition currently checks the output
> variable max_bw_value[i] instead of the input value
> maxrate->tc_maxrate[i]. This causes the validation to compare an
> uninitialized or stale value rather than the actual requested rate.
> 
> The condition should check the input rate to properly validate against
> the upper limit:
> 
>     } else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
> 
> This aligns with the pattern used in the first branch, which correctly
> checks maxrate->tc_maxrate[i] against upper_limit_mbps.
> 
> The current implementation can lead to unreliable validation behavior:
> 
> - For rates between 25.5 Gbps and 255 Gbps, if max_bw_value[i] is 0
>   from initialization, the GBPS path may be taken regardless of whether
>   the actual rate is within bounds
> 
> - When processing multiple TCs (i > 0), max_bw_value[i] contains the
>   value computed for the previous TC, affecting the validation logic
> 
> - The overflow check for rates exceeding 255 Gbps may not trigger
>   consistently depending on previous array values
> 
> This patch ensures the validation correctly examines the requested rate
> value for proper bounds checking.
> 
> Fixes: 43b27d1bd88a ("net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps")
> Signed-off-by: Danielle Costantino <dcostantino@meta.com>

Thanks Danielle!
Reviewed-by: Gal Pressman <gal@nvidia.com>

