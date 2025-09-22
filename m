Return-Path: <linux-rdma+bounces-13552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F7B8F43E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5BC17E986
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F92F0694;
	Mon, 22 Sep 2025 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HliqVqhn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B82F1FD3;
	Mon, 22 Sep 2025 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525543; cv=fail; b=hoCGlxdBWoZ6f+evqHiEZa0rTx6zKYaWDmrEyDR0PYygZN6iShct/Ibh2+2QYIn7QQGqqY1WuPmXnm5adn5MRyAIr0kDae5xepJgGQXRhrSM2aeoY4mOu+uBeHn0ggiEb3IhtwoQPmM8IhINtxxwcxgEeEY8bOO7CrCeTt6afMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525543; c=relaxed/simple;
	bh=bgNmcSD1G/Hwr7BDfiFrWXfPqVxm2pSft+hg0PQ0W08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0c+mz01twbuqQvMBatInKp2JttF3UGNDtnz2j5fFRHzQn4q0BjHt76+9Jgvr5L+L5Oi3jged4F2ywMb8vpxLMPnxNOgBfdho5Eon7ZQv97Apk/cc+JFrScnu7oqrQE3xVXuWnQ/ZgyivFq/FSSQlYfbGsRjLRpmSuIWjYKSvfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HliqVqhn; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY3ckeUta8DZqHW88RNumKDRCTcX39jowos1l2tqBK2ij0BJngyhgCE1Uw57uLj7TD36TYImFajYhuBfRAqAsz61pU8Y0qWusqbeCbF+xYx/EZaj+DGB53QjdAe6nmvXljBcOXh3M54F9ljeTKMRX550aMt8TTb+ZDhx0rd/4IVB3WI9fELU7RxV+0t9ZGjqwQdM0SpcAJF3igGxuiekBL97MYLWbszaEhMBUeaffcEW9POCicCuh7GKTHfVVenUH7DTpSOYQ+lBQ2BIWr68mnJI+DxsJ6cyHk+skuSYyPRMcaXG3uxg6Iof5lSmsv9sNM1e881XkjxMwHdvw13fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CthVnZ7mmotEiBdXQ1gNCLE8kc/9ZzWMD0zWt5YiqWU=;
 b=rGDWWOO2yWV0LQBNFDGtzwOfwW6vwI2H9ol+mePau7w4FeVSBOs3GIp0uO9l1E2BXsGe5wgnErWTHqjFH0lwalwcXuKPgBF6vI2MySbKXXfu2tvuF/5My0j9uJvZCZ2z8FHIXTSIhhYPYUjPYItI6LPYpxcJzdZz7imZF3RVsYq3Y3vywx72x898HTic4XDX7uco4IRBWkGoqz1MoeekpcIphTuOoo+I+7qenPCOKTgfO3vo0yiqfcavDaojFFoZjsKSAbua6AV4r5RO7OuAvxbcxw0x6gvxgAfXQ9DJje5SX0HGBcsHHDImcZRX3jEaqMbUx7L6kwKXDLS6UQ28EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CthVnZ7mmotEiBdXQ1gNCLE8kc/9ZzWMD0zWt5YiqWU=;
 b=HliqVqhnLuezPylvVdYj/VOK1j9iQvi08ezfkuRtRYtFTFitIASs7IjfEGK9FlP9XM+BZJqB7E8dj9ec/1A83NYyVxR3dzuCl1+Z2tBTuXgB4UyPQDl7N72xUIK1Wrbd2R4GdkFctDrQJrncSITPLGe3b0sJMK7gBd24Th0uh9jsx2edkz49kLTyoOlc1rH7p73aEAeXSUXtIFeSjbxgn6kJuQ8E0f215E+9YDcnvzydVDyO9KRzW7OdNZjl5T60KrSVBRzcqcEhvjiqWraGv6VNdSjmG+ZbvEoAOlxxrmNogk6Y1xoIsgNrbf3COuhb1lZv/J3LVGgBpvZKdHCRSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 07:18:59 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:18:59 +0000
Message-ID: <0b7a83ec-d505-40c3-afa4-8f6474cd78d9@nvidia.com>
Date: Mon, 22 Sep 2025 10:18:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <20250914115308.6e991f7d@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20250914115308.6e991f7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: f906e73c-020b-4557-9a39-08ddf9a84c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnJQWVNhRCtUdW9qbUNaR2ZLSTF6enNQTkQ3ZjBxWjdpK3k2Y1BxRVhBdHRJ?=
 =?utf-8?B?R0ZLVXJLQ3g5ZzFtek5qWVVKR3h0ZmVCcExqWVVPOHZyY2UvOHJDS2EwTzRI?=
 =?utf-8?B?VjZhSkFOandtS3Vza1U2N1BsYmJ5TXIzN08raTVvWkQ5enNFMDRuckM2T2dt?=
 =?utf-8?B?NzlTZHMrZWVBUVRTUlpDLyttdWc2YWVpSnk0Z2Uwb1lkc3lKZnZOOTAvWU12?=
 =?utf-8?B?NUFWTG5kVElaTnZEVWl0cnRUT1hhZGJiMm1hd1orQ3JCWUtrN1dsUTRWWVFO?=
 =?utf-8?B?UTY1aWp3MEk1TTVIbVRZaHpRbXN5eSs3SEZQTnAxa0p0T3NXY084WHVMQ2FO?=
 =?utf-8?B?RnYycDhYbVRvSW5WZmNJTjRPZ3l6VFVjb3dJU2c0RkdTbmQvVXozYkJHZXdO?=
 =?utf-8?B?WGdKS3kreTZBai9GN0lJQ3NWWkRnbFZSRWtLRkxBNHVGYU1ucUlQUUJPbVhQ?=
 =?utf-8?B?UkY3Z2oxcUoyU0Z3VW1PekI1VE9QWWg2Uzc0WDIvY1c4RXFSZDNOQTV4cWYw?=
 =?utf-8?B?LzhOdXRIWitObkFON3JLdkY2TmE2MVNzd3JKb1luaU4xa1hjNkEreFZFN2E3?=
 =?utf-8?B?Z1JmOFMrQ3JEOGhpelVtZXNSSjBBbzcxcXR4M0NMOHFLdmMyY29LRUtPbkdS?=
 =?utf-8?B?Y1hXYzJGSjhCZjQ3Y3NqMTQ5VzVwUUNyeEExTmZ6SUFkZmVqWDFKRXg3aGdW?=
 =?utf-8?B?ajZlMVhrcUkwaEQ0SWY0SVJvVlVwemF2c0dxajY5Zno3ZlhoRy80L1NWWm5D?=
 =?utf-8?B?Slc2NmwyTkFCWGFKWm11bVkwbjdZR1JiU1pXOWpxdjlxYWdhaW1XZGxPdFBq?=
 =?utf-8?B?WldoRnpycUxWRzBaT0tFZ0E3SlRFcjZzNFp1bWZ3b2h6WXFiSjJ6ekFKWEoz?=
 =?utf-8?B?UUFXV1VqZWRDV2ZoZDVDTXNERGVJWmVqTi9MYmNzaGhod2hMNGlTYjNSUkQx?=
 =?utf-8?B?VVYzMmdMYUtiRXdEeUZyekVhSWl0YmJ3cm9tYkNaNUt3bU0zMllRVm42a0pt?=
 =?utf-8?B?RFBYanpXNXZtZm4xWkcxeFJ3c08yQ0JaekxSbnFGQU5CVmJUN1VORzhEaHA2?=
 =?utf-8?B?SHdrK0pKbjZDMXBxVzUrS2pvNHcwT0ZhTjFMV3ZReWp5YnpCMTN5Q2V2VCsz?=
 =?utf-8?B?dHN0dWFWSWVEOVJoL0lEM2RBcXdCN3lmK2hsL0xWWjJubkpvYVZqZEI4N2dN?=
 =?utf-8?B?TXlWVU9Gb3hBTFhBRm1yRHZmOS91L3Qyc1V0bVZSb2tqRWVsemxwN1pXU1FL?=
 =?utf-8?B?dEtTRWQrTUhMRkxYdnlrRUh6TUt5ZFZGQzVFQTJ3WkFtQzUybHhGWlRwVlVz?=
 =?utf-8?B?aktwakJaNW9uclYvOUJJWW0vcFFIbXlPZml5UC92VVdHUWN5TFFDb2p2eWRt?=
 =?utf-8?B?b0x2aThSZy8xL2RUVEUwUFR0L3dSVU1TNEU4V1F1bGhMUHlXMDl6TTNUR3RP?=
 =?utf-8?B?eHQwaGlzR0R2dW02NWljTGlib2pnS2k0QTFuZDFjckExZk9aaXVVbzRsQXQw?=
 =?utf-8?B?bzF6YnI2MFN4THBEV3FIQUNEUG5UeWJYcURVckNsRjg0WHAyblRLRXdJbUZl?=
 =?utf-8?B?ZWFCejNVa1JZekpUcTgxVFRCblhVQ2EvNUN5TzlYNHBMeThERVpQN0h2OG5v?=
 =?utf-8?B?WS80Q2pSY0pIQ0F0ajVTbkc5T0FkRk9FbzVXWDZKNFFBZUNUUC9meE81Vlkr?=
 =?utf-8?B?NHJlZG5wS3o2akdtY211cSs5cEVqRnRuK09wUHdlbWZSeWxBYnRZUFFjaFA3?=
 =?utf-8?B?QnJ3eENHaEhZbE1aWVlJQWlBYmtRNmE4aDVFVGJwVXZoellvcDhoT09DcFFk?=
 =?utf-8?B?dzdVR0pKNUorR3d3UzB3M2NGVjFJQU9iNU4yczBMbjNEaTNhZVdvcE9ZcG9o?=
 =?utf-8?B?dkVzRWdyK0U1QUlEOE1CM2dCQ1ZGcUtnZWZUMTNEL3Vzd2tjNjVlNE9GcHhs?=
 =?utf-8?Q?1lHwznOik8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRZNEFuekVjazlYTzlveVBwRlliVFZiNW0vTHNGTzRXNnA0MzlNN09mRGJD?=
 =?utf-8?B?RlJxK3dVNTVDN0diYndhakhIWmJtS2xkYU9KK2JwV2l1eURFTGNoSWQyemtQ?=
 =?utf-8?B?V21OcmttUHg2MEEzTE5uam8zSkNVUkVKK2hVOEYyU25FbDBtWmorcjBVdkVG?=
 =?utf-8?B?eDVyU3NHOEhWbExYQ01JTHl4ZlRDTTVlMUpLMHp0WVJhTkJwK3I5ZGdWS0Rr?=
 =?utf-8?B?VDkrNnVNSldOS2I0ZkdYZ1BpSTRFT1FBV1oxOTdWcVJNVklNMHExTjVXSi9B?=
 =?utf-8?B?WXdhdjd5ZFozUkNZWkc1eXkyNzJZdWw5VnVKWVJkNVViRXllbUhzL3hEQk5J?=
 =?utf-8?B?Rzd1Mzl1a29wOU84NVFqOEZVUXRDWDJzVm1ZK09VT1FUVjJwM3FPdUlWc09J?=
 =?utf-8?B?TVlOUkIvbDlGeVFBR29Bc09VU0NuMXJWZmVjVWJCTlpyOGRhK1NuU3o0MFJK?=
 =?utf-8?B?MkRaSVNqVTBVKytGYytxelpnamRrMUJnWFIwZ212aHI4amdpUlE2bFdpNXFF?=
 =?utf-8?B?Z0dISytKVkN1YXMxZGxUSWZYVU1KcEhRaDhqRlRFRmFmUTZuYjQ2L0lIc1FQ?=
 =?utf-8?B?ay9DLzZxUndRVFN5MFJKREE5bFVXTlRrMWxabzU4d1Rwam45SGYwR0orRy9x?=
 =?utf-8?B?T0dsZ2RxZ3lhKzVEdnJmd2lyakJDRE1KbkdQYU44REpDMVRQKzFydk5mWlh1?=
 =?utf-8?B?QXBsZ1QxaWExMUZrNlFDVmcwalNXQnFQaFRMNXI1bzMwOEI2Q2EzaGVYVndl?=
 =?utf-8?B?bXkzMnV3aVNsaEpYV0dQMzI0eGFaZnlMRnAvR3ZielFDVXk2S0dTNkxuSVY5?=
 =?utf-8?B?WTJYWVVOUG5pMkpWMlI3Rk9tZE1QcVVFOXpuZTNnZk9nOUc2Sm9CWTRsamky?=
 =?utf-8?B?YnRpUmlCNHlDQVJjYmRLbWxqVnByMXpaYUhVZ0M0Y2trMndZTFNvV1d4bS9Y?=
 =?utf-8?B?WVJ0eFVxSFQvNWlQelFvRHhsY3duS0NRLzEvSE1veHNhelcybmZLbm8rZnVy?=
 =?utf-8?B?Q0NRQUhDUEZUbFBhMGZDUks2MXJkR09LMTRsTEtkczdRb2JraC93b3hNQkcv?=
 =?utf-8?B?NXlEd0N2OFBaOGZKczhPZWNWa2dPd0JGQWt1bkdiTFcrempnZy8rS2xVWDg5?=
 =?utf-8?B?SkpucnBFSXlaVVdwQmVtTzZFSURwWHpkbTJHaG8xWXVQc0ZqR294WmhuenFn?=
 =?utf-8?B?Q3lIcnEwMGpvZjgyS0VqMG0rakVzYWdiK2JhdFhYeUNUNWlVY210RTdhRFNp?=
 =?utf-8?B?NjVsbldmY0VwRG1Ic0huYWpHWEFvS01xTnR4eFJnSGVvOVBiSGNuYlNkaTY0?=
 =?utf-8?B?UzF6R2pMSDducDNQa1NDSVdqNGtkbW92aTV4aWNXYzYrMzZoSllWMG1WSENw?=
 =?utf-8?B?aFhCRXJkckswT3gzd3JpN1VOMjVMR1Z1MGxCSkxwSE5Lb0VxS1BJSnJtb2pi?=
 =?utf-8?B?QlBYTmVVMVpNUzNLQ01rQmFRNWNVL2dBLzIzMFJKd0k0cVJ6TWtaQUF6Mk1P?=
 =?utf-8?B?cmk3akVZWGtDcDlSRER5Y2drWTNWVUlIWlIyYlhpYWl4U3ExUHNTc24xMS92?=
 =?utf-8?B?c0x3NzBvUGFoMzZRVGhlMzkvV01yTUJNaEtIUitYbmpGMEdBZ2dXWXd5bWFB?=
 =?utf-8?B?QnI4bDNtSHhXUDYwazdPVFc0UUtTb2ZVb1Jtams2aWF6Rk8rNWxqTWtURVRn?=
 =?utf-8?B?RkV5S1JxbGZleVp1U1lxei9kUHlNbE93TXZNaHdka3VSb0d2YnlGNEhBZk02?=
 =?utf-8?B?RlNFdGVwTkF5SVV6YTF5OU9tQ3I4akpwbDBFbTd4SVBMTnFJeGxjVHFmKzdm?=
 =?utf-8?B?M1pPNTZNVjM4TkQ2dHBNaGZ6R203R01YZzMzeUR2MHNudVo2R0N2c01udE9z?=
 =?utf-8?B?Q3BFS3dDejByS3MrUFBQRS81UHpITEtJUTRPby9LSlZ0UVpRbDB2Mm9Rb3M5?=
 =?utf-8?B?TUk2MGJ5WUhEeTVUUG5OQXpOQVNDU3JvL1hicDFsNmIwV2l0TDBFQzh6bER0?=
 =?utf-8?B?OGNVY25NNjNyMnFVbDdUeVMrcmVtRUp5NTJ4TDVEd1A4bHl6b2wxakpDeTdU?=
 =?utf-8?B?ZHdBSzNOdVpXbHU5VEJsa2dabDFWQ2d6SEpzdmhHRktHcngxamdyZEYwRnNR?=
 =?utf-8?Q?nOhrpFAArTuWhs86XCP7EAuP0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f906e73c-020b-4557-9a39-08ddf9a84c7c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:18:59.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3+6vjvmXBwLrvWgEYAZM4fy4gmV5QZpqlc/qGRStz4fpYfYFYDt4Gof9eOOtePH3DIm/iTvCiWTHfzK2FEclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39



On 14/09/2025 21:53, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 09:47:40 +0300 Tariq Toukan wrote:
>> When a netdev issues an RX async resync request, the TLS module
>> increments rcd_delta for each new record that arrives. This tracks
>> how far the current record is from the point where synchronization
>> was lost.
>>
>> When rcd_delta reaches its threshold, it indicates that the device
>> response is either excessively delayed or unlikely to arrive at all
>> (at that point, tcp_sn may have wrapped around, so a match would no
>> longer be valid anyway).
>>
>> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
>> to explicitly cancel resync requests when a device response failure
>> is detected.
>>
>> This patch adds a final safeguard: cancel the async resync request when
>> rcd_delta crosses its threshold, as reaching this point implies that
>> earlier cancellation did not occur.
> 
> Missing a Fixes tag
Will add
> 
>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>> index f672a62a9a52..56c14f1647a4 100644
>> --- a/net/tls/tls_device.c
>> +++ b/net/tls/tls_device.c
>> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
>>  		/* shouldn't get to wraparound:
>>  		 * too long in async stage, something bad happened
>>  		 */
>> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
>> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
>> +			/* cancel resync request */
>> +			atomic64_set(&resync_async->req, 0);
> 
> we should probably use the helper added by the previous patch (I'd
> probably squash them TBH)
It's not trivial to use the helper here, since we don't have the socket.
We can maybe add another inner helper that performs the 0 setting and
call it here and inside the helper introduced in previous patch.


