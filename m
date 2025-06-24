Return-Path: <linux-rdma+bounces-11566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0885AE5CF3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 08:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3725E175534
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 06:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1623F294;
	Tue, 24 Jun 2025 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RcqsA02m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636E20EB;
	Tue, 24 Jun 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747174; cv=fail; b=VGGRSDARL/sUNYxdineuXyNbAYcyF+NNcA8eBI+NE1fa86k5aCBXt3c7rxldkAnjF3CH7cb3JZI/M/Ww2Jkzc8azBqa56T4Jzk1tYLUrbAyQ7MZNLCjecVINsgsHom2pWSWdGeV1WOhJXWsHtzRAoqxy/yKkBiSBsE+XBMAq+uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747174; c=relaxed/simple;
	bh=f33aBtDYVTNorPDB8LZup4NpZSq7nzEck7rBonlo4Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u5IscgrhjbY9hvkkWwRgKf87SMIEeU6auhhya++LpVs0R8ynBCraFicBTiG9cgAAzQuWR688djrEdzOwtZk5bXRJv+w3H1fyUI73wEIpY17yVzQAozPad4rAl7ngLyUTFSvL2Iza5rj8RUhLijSN/t2hZHnrxWBQk3w9MZrqpgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RcqsA02m; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usI2k+eTKr5cCdcFMI7meuxOsoPRpfeYSguGMcnZ5OPM0U+ClidMkca158ROG1loiCElGiJZjWFMggdID/K+zIhCAKodgf5zkZ/bKSsKufvWqQmq0w7PeuyzqW/rqSdjViDc/JKOrYR6KPnMFgHfaGIV0+Et6Eux/MEqnVGo4nulvINOXk87ATjkjKR0bmdLU0J0P9F1KMqJ+aGE8pp5t3n7MFSm2tGlOD4HWW5aBxn8wRz/GHYJLe0tSiohmYro8IwuK0Hn1VfoYC+JsCWcjH2pAWwhRzUi+IO4V/bJdxFLckZ7elQfSRy1RfE2WEbtFwfOK5+Mv3jDZKu2Kl0ywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68D2nTMWrlxD2YwI/wprZpw7Tlctc3w5RDKxVQP2FKU=;
 b=k9XlaBzu2tqSIzS8uz1ioVyRfGniPxEWsZ+biZ0CNF01l4lqeehdZ5rsmL0qx0wYLDKf60rqx45hFsG6Y01S/pBSpq2gaD9gtjxkrdVfc1vYURMbWlCJjZSqMA5+nMnZ/UFEfITSVTbztqCrtM+ICyHn/e8apW6wQxpDGPjrrn4Ph1ahAKxEQO679px9U38SRrmmQ6cQbyLLmGg9vuTrcVDaDJwzdVa2UeyJKinGUcbDE4aLqr6tbLO4xqzcySE5oc4hyxyGzEY/TP84qC2UtnuTfaH/poganSCKPRZ1quw+407ON/UM6Md6VbX5o+mj4ZF3FTH8n3Ppx32VRmQZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68D2nTMWrlxD2YwI/wprZpw7Tlctc3w5RDKxVQP2FKU=;
 b=RcqsA02mSsN4Ak0jD+TNUz51tlC8pVytcLf11QcYS9t13N+ckkgVCfAxc/Y3zus5aUmhPG+4OLyAyxOAs1CiC3O2nFebB5SWd/AqA23KhCgBRK4sWkoDLsuMWqXuUWGBHe56ghEEeu/3X/WLdbgPa0FdLY4eOQCj1wnRAgHMJxCPr1lAwrCb3IKiGRoB45mcvcHGQx6Fem5no8/nkRkbwq2oL9Y+Yb8BvmWkPHtUAVKn+ZJWBpgrySk+rFpstj6+jMvWZRSTjohlgLH8CiyAeQwINK4HhuXIlYMjNG/6uNi4mS0z+dUFXV7By5/H+6HJBzeveWz0bc4EZH8peluzTA==
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 06:39:29 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::c2) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 06:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 06:39:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 23:39:12 -0700
Received: from [172.27.34.202] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 23:39:05 -0700
Message-ID: <10f5e28a-62f7-4166-94c9-76423c71471f@nvidia.com>
Date: Tue, 24 Jun 2025 09:39:01 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
	<saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jacob.e.keller@intel.com>,
	<shayd@nvidia.com>, <elic@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <anand.a.khoje@oracle.com>,
	<manjunath.b.patil@oracle.com>, <rama.nichanamatlu@oracle.com>,
	<rajesh.sivaramasubramaniom@oracle.com>, <rohit.sajan.kumar@oracle.com>,
	<qing.huang@oracle.com>
References: <20250610143859.957848-1-mohith.k.kumar.thummaluru@oracle.com>
 <e1afda58-56b8-426a-a8e0-65e6609e9875@oracle.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <e1afda58-56b8-426a-a8e0-65e6609e9875@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea9eb56-f1e6-44b5-d403-08ddb2e9de91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0tWOVBoU3F3TXJMR29QbDV6ZE1jWSt4SmVjanNTd09uVnVZOCttcDdDZWsv?=
 =?utf-8?B?SHJ0S2k1MGxKK3pKa0hvTXJUQVNRcnJ5VWN0L3A0ZVdmSWV5V0RaODBTeFdS?=
 =?utf-8?B?alZ0WS9ZU2VTY1E4TWUyTXVVUndyZUFneDMrTVhXUW0vOWcxdjUrOU9WOUFt?=
 =?utf-8?B?bXF3YksrT25QSnRhU3ErUjVaVXZuWEVieDVsSVA0eUcxK1h2MFgxZHpLZ2ZH?=
 =?utf-8?B?WTdDVnB6aXU1ajd5VFBzRUtRcGF3SlBjTGg2dUZmTEtWN2Y1bXVsM2l1SWVj?=
 =?utf-8?B?NVBzdExXRUpnMktNR2JHV0RTaXZURmJNb1RyY0cwOEVCdmN6aVl6UFR1SWVZ?=
 =?utf-8?B?MkFJc1QzQlJoYXVSMEF2RDJSNnZjblhpckI0aEFycG4wQjZzcWNPcDJGeVlJ?=
 =?utf-8?B?YlBNQS9QTEpCUWR4ajBPajNIalNCZVFiSnhwbnFDVmFpVVRCRG01YjVmWUl0?=
 =?utf-8?B?VE1uUFBwSGd3MU5zMEtMZWVGWkR0S2ZOa0N3NXVZNTFaMlk4dDNDNzVkQ200?=
 =?utf-8?B?QXBzWUFoYUIvdThvN250WTNmWE1oZ0U0L2Q0RWlTYVhUcndnamxFcFQwMi80?=
 =?utf-8?B?ZWZwalZPWWY3dEpxN2sxTFdvakxqU2NqS2oyYmpGUVhJa1BtZDhSWGQraWlS?=
 =?utf-8?B?bkhTY2JxTVRvOHQrSDJXVFdybEg0R3dxNG5Rb3BRL0w4cFFwL0Iwd2JSbE9k?=
 =?utf-8?B?MzZabDN3clJVaHV6U0FNU2w5eW52ZVEyWnliejdzV1ZObTB3bHBNQ3RvdmxE?=
 =?utf-8?B?VjZqWDBoOHA3VEpxOHBiOStxcHZQTTY1UjhKNWcrMk9WdGUxYjRBcmRUM3ll?=
 =?utf-8?B?K3VlSFNrT3lBQUVsOS9nSkMweVdRWWJiN2RWenBDYXZmMU5pakNuN1BMZXNP?=
 =?utf-8?B?OEhUSmVldGh1VjhDQjVSanU0OWh6N2dKeGZ6UGNxOSs0ZzVHcFNvenlZenli?=
 =?utf-8?B?NE1pdzZ6Y1dqTjIxSHVHUW0rdmhDaDNyZGc5NkVNaXNUME1Vbnp6d3d0OS91?=
 =?utf-8?B?MWVIdWJpTlVmcTlVSWlmS251N2p5dXpyclhHci9zNWJ2MzEvQzNZZlZmQ29W?=
 =?utf-8?B?ZFZCOFRxUEx2OHNSMWkvemwxV0pmbEJBenFLRHUwaGdnZWF0K3d1alNsOURD?=
 =?utf-8?B?NG5VRVU5S21pNEd0WVdCNTdQellZN051NFVVaXM1aCtNbG5xRDd4U29ub3JW?=
 =?utf-8?B?aDNjQ3JPQU9SZkljdk1XWFJiMWdqNFp6b29JY2F3emdOVzUzeFFJUHMwNUFl?=
 =?utf-8?B?VSs5cjV1eXpqVmk2MjVSZ1ZXNXJyMENFWTJLVHFMMTUxcUpmMmFxenR5Zm4y?=
 =?utf-8?B?QndpNVMrRnZRLzMxSUJSTTVaUVRGUkkwUWRCbFd3UUFzTWc3Tk5mNkVWZlBP?=
 =?utf-8?B?a1IvajgrOEdCakhzdlBPNUg3dzNhMXQvdkNmaUFPcFpiNllvUUZ3RkU3ZW0r?=
 =?utf-8?B?OWN0WktydHV5aUFWMFYzTEttNitmb0lOR2hOWnpoeGt5VWxReHpEcjBUWTZh?=
 =?utf-8?B?QVNJN2lEV2RCQ1lnK3JWaWhOR0s1NkhqcG4wMWU3WnNUMzloMDU0OFpPTzB3?=
 =?utf-8?B?UzFmdkM2eU9yaVIrdTF0aFFqTzdPc2hqcUl4WkZ0QXF2QmlMeWhMaGtQRmFR?=
 =?utf-8?B?K1VzTHpPMzRzTUtYQS85Wk1WajIxR2htQllLcnVkQlhLbGVBMkxiand1aHMw?=
 =?utf-8?B?dytPZGNWOVhKcXJuUVV6WHUyTXFmOGNpUGx6RWM4Q28xOXdtblJXQUVscTFp?=
 =?utf-8?B?WWs1M0syVW9xdmVPU2hZQ2gxV2NPUkVVNjR2dk9MZ0hGNkNnUVpEcXpJdTZF?=
 =?utf-8?B?RzJOVmQyME1VQTNzUnJLT3YyQzhGNFF2SkthVk9qN2ZkNGdJTzNVNTNNSXhv?=
 =?utf-8?B?b2VIUzR4cVpQLzdYT1ZXOGhhQTRweDIyVG9GaS9rdVN2a1RsUEJKbmMyUU15?=
 =?utf-8?B?R2ZJYW1KazZZNkFLQWtRR2x6Qm4zU0FLNDF5QjVianBuQWhncTZraFdXSnpZ?=
 =?utf-8?B?R1dDRkdWZENMM1JBMVBTc3VjZGVyWTBKTXBzdDVyd1NxTFY0Q0o1Zk11YVVE?=
 =?utf-8?Q?TWvjPX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 06:39:28.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea9eb56-f1e6-44b5-d403-08ddb2e9de91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260



On 6/23/2025 8:47 AM, Mohith Kumar Thummaluru wrote:
> Hi all,
> 
> Just a gentle reminder regarding this patch. I'd appreciate any feedback 
> or comments. Please let me know if additional context is required.
> 
> Thanks for your time!
> 
> Regards,
> Mohith Kumar Thummaluru.

Thanks for your fix !
Please resend as patch w/o RFC
Add : Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

> 
> On 10/06/25 8:08 pm, Mohith Kumar Thummaluru wrote:
>> The mlx5_irq_alloc() function can inadvertently free the entire rmap
>> and end up in a crash[1] when the other threads tries to access this,
>> when request_irq() fails due to exhausted IRQ vectors. This commit
>> modifies the cleanup to remove only the specific IRQ mapping that was
>> just added.
>>
>> This prevents removal of other valid mappings and ensures precise
>> cleanup of the failed IRQ allocation's associated glue object.
>>
>> Note: This error is observed when both fwctl and rds configs are enabled.
>>
>> [1]
>> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
>> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to 
>> request irq. err = -28
>> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while 
>> trying to test write-combining support
>> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for 
>> port 1
>> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
>> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to 
>> request irq. err = -28
>> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while 
>> trying to test write-combining support
>> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for 
>> port 1
>> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to 
>> request irq. err = -28
>> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to 
>> request irq. err = -28
>> general protection fault, probably for non-canonical address 
>> 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
>>
>> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
>> Call Trace:
>>   <TASK>
>>   ? show_trace_log_lvl+0x1d6/0x2f9
>>   ? show_trace_log_lvl+0x1d6/0x2f9
>>   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>>   ? __die_body.cold+0x8/0xa
>>   ? die_addr+0x39/0x53
>>   ? exc_general_protection+0x1c4/0x3e9
>>   ? dev_vprintk_emit+0x5f/0x90
>>   ? asm_exc_general_protection+0x22/0x27
>>   ? free_irq_cpu_rmap+0x23/0x7d
>>   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>>   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>>   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>>   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>>   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>>   create_comp_eq+0x71/0x385 [mlx5_core]
>>   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>>   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>>   ? xas_load+0x8/0x91
>>   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>>   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>>   mlx5e_open_channels+0xad/0x250 [mlx5_core]
>>   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>>   mlx5e_open+0x23/0x70 [mlx5_core]
>>   __dev_open+0xf1/0x1a5
>>   __dev_change_flags+0x1e1/0x249
>>   dev_change_flags+0x21/0x5c
>>   do_setlink+0x28b/0xcc4
>>   ? __nla_parse+0x22/0x3d
>>   ? inet6_validate_link_af+0x6b/0x108
>>   ? cpumask_next+0x1f/0x35
>>   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>>   ? __nla_validate_parse+0x48/0x1e6
>>   __rtnl_newlink+0x5ff/0xa57
>>   ? kmem_cache_alloc_trace+0x164/0x2ce
>>   rtnl_newlink+0x44/0x6e
>>   rtnetlink_rcv_msg+0x2bb/0x362
>>   ? __netlink_sendskb+0x4c/0x6c
>>   ? netlink_unicast+0x28f/0x2ce
>>   ? rtnl_calcit.isra.0+0x150/0x146
>>   netlink_rcv_skb+0x5f/0x112
>>   netlink_unicast+0x213/0x2ce
>>   netlink_sendmsg+0x24f/0x4d9
>>   __sock_sendmsg+0x65/0x6a
>>   ____sys_sendmsg+0x28f/0x2c9
>>   ? import_iovec+0x17/0x2b
>>   ___sys_sendmsg+0x97/0xe0
>>   __sys_sendmsg+0x81/0xd8
>>   do_syscall_64+0x35/0x87
>>   entry_SYSCALL_64_after_hwframe+0x6e/0x0
>> RIP: 0033:0x7fc328603727
>> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b 
>> ed ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 
>> 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
>> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
>> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
>> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>>   </TASK>
>> ---[ end trace f43ce73c3c2b13a2 ]---
>> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
>> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 
>> 00 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 
>> 31 f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
>> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
>> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
>> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
>> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
>> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 55555554
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range: 
>> 0xffffffff80000000-0xffffffffbfffffff)
>> kvm-guest: disable async PF for cpu 0
>>
>>
>> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
>> Signed-off-by: Mohith Kumar Thummaluru 
>> <mohith.k.kumar.thummaluru@oracle.com>
>> Tested-by: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> index 40024cfa3099..822e92ed2d45 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> @@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct 
>> mlx5_irq_pool *pool, int i,
>>   err_req_irq:
>>   #ifdef CONFIG_RFS_ACCEL
>>       if (i && rmap && *rmap) {
>> -        free_irq_cpu_rmap(*rmap);
>> -        *rmap = NULL;
>> +        irq_cpu_rmap_remove(*rmap, irq->map.virq);
>>       }
>>   err_irq_rmap:
>>   #endif
> 


