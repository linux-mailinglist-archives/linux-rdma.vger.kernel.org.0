Return-Path: <linux-rdma+bounces-11324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B728ADA125
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jun 2025 07:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A506117220C
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jun 2025 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C01DFE12;
	Sun, 15 Jun 2025 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HFcg07Fv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0A335BA;
	Sun, 15 Jun 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749966947; cv=fail; b=f8bi6wN1nSNirOHvjRfRTSHNnuta0n8njowX+BU9WpdpgoE3cdJU4DoZT5K9TlcCwwHt8/Ga5DGQw2Ra5twzJsCXXnIzXxEU0w1A7Ej8ye4natvDNgsARgoHf0t0lyci5xsUHhuvEJD+nEyKAxrjqVHLL3x+H68xyhD/kiHfZwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749966947; c=relaxed/simple;
	bh=QfB9dQZePqWEVmLSYTTmnfb9rnleLYRCrUTYNYsJVQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GolFpoODsNuDp/59aIMm7QnDZFJu6rBX++K42+QGWUpxlJEWhfHp9ImYXq3oN6z+bv5csJv+eZxD4RgoeW5G7ULN+M7rbcZAAs3QEG7HZleoTRCezu0Pt2Ok/f2fd/fl5KJtKJSkmDZY73ZbcQa48FSs3ccdZHeM/nzJd0hNtNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HFcg07Fv; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtMkoYA41TQDqyUB22p2NRFbyNhXg6hMW+wwAK7co5ROiFPFehby/7GPJEfHu3qgmfZWYuoexsJdNh6caFyACITjXlqJueAMf2drnc6ASvF2xD064lsrQsZ403ZcceKA1ebXjBJcYk92ttTOLO0H/y/pKKtkkvgzHLoRiYijAV+fzo2lESsdJUiUW8uoHIy+ZOEC5obH/XnQz5GohFx1wVWBgzitiAkgv9z9sCLUGH0j3XIi4cFpSwz0jZvAF/k83mViccnO057Ok/om9z5YlxOHNPtljhFUJMTNqzK4Hia5tJCIzJ2NUP7JtkeG9At8bkklldZnH1Atm0/Ngs9CIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27U2tpvjNkfMPUvqrmdbpGLTMZmuOPJGMpinFWaCxcw=;
 b=RGrLZgDwSFU9ZiKtScNzKTyeEEWrjRs/aJEXcxV9OMCm0KjY7fS4nj+VvohfHWQPffxBEYNkmcM0OM9oglXUKrZdZS5HjffDLyxC93r1yMYWk6i1Y2ovfAWJB0uPgoUpNF2dGRd3DB6yaQ9Beyr1cqEVu2nhIlR5dvyhgtZE4qIA+8g2X7A+5pW+4ptbsPDlJGtB6DbM/jbNrSgRtwHP26fweQ3qWpOQApfBOqnX5veJ06Ywcg9fc1WArT+Kxe6OMvLjlhUVwsc/btG2kuKTaLYKZOe81Zag1ZUSIb4dGCJ7KwgrqsrBlWxinmKJeGvbIjcqwNIxBrgiTCYW5yliGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27U2tpvjNkfMPUvqrmdbpGLTMZmuOPJGMpinFWaCxcw=;
 b=HFcg07FvpQMN41SOU7nBJdJ884JNN3ru3ww8mHD3SGKUGktgUOzCh6bGx8VYVMCZx3HMeZ+2DP1vyBFOcFuFouR4oWB6sI54GWmyoWAZERRxrMhH/64Y51zusGFjZhOFCkU+MBFUIQ+Ye6j2cTmJ9Hg15XeXlt1Zbh19EupApF7MQ2JdsKJd9UAbuWLgMaQfLYZSKLMQOeg9MA5oc5U8KMRANnzsK8IlBMsfLNM4q7eKDD9MZlhkbc53YyFD5nkPw+xaiaOX4t+xkSwE1C38h45urrp1p9Tzk8nXgwsKLjDM13tRlYpZSArKO6y5h9JczewgezobTLfkLlO0Vgha9Q==
Received: from PH7PR17CA0024.namprd17.prod.outlook.com (2603:10b6:510:324::21)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 15 Jun
 2025 05:55:40 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:510:324:cafe::89) by PH7PR17CA0024.outlook.office365.com
 (2603:10b6:510:324::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Sun,
 15 Jun 2025 05:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sun, 15 Jun 2025 05:55:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 22:55:26 -0700
Received: from [172.27.33.145] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 22:55:21 -0700
Message-ID: <524cf976-a734-4d30-915b-2480a6139e27@nvidia.com>
Date: Sun, 15 Jun 2025 08:55:20 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/9] net/mlx5: Ensure fw pages are always allocated on
 same NUMA
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Mark Bloch <mbloch@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
 <20250610151514.1094735-2-mbloch@nvidia.com>
 <1688e772-3067-4277-ad45-6564b4fbbddf@linux.dev>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <1688e772-3067-4277-ad45-6564b4fbbddf@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc6f2bd-caa9-4749-811f-08ddabd141dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0dWUGF3N2JTS2VuM1RIUEJlWWJMczNMQjVCVlhCaEcwaU1uMlNEVFd1VGRi?=
 =?utf-8?B?MGhxWVBUMjFQY1Q2RXIwMzRRZkw0Ry9wR0J4aWxQOWJxQnVQeUcrWnNHNno3?=
 =?utf-8?B?RFRvalJlVEE1RWk5UVoyUTVnU2NydGtyUTlCRjJXZ2dvR3Ywc2UxWjJyUy8w?=
 =?utf-8?B?eEF6cEpYNFBDSG1MMDlSSGZlc1JVSUxoTEtLdi9iV3NucExDL3R6cDBKNXQ4?=
 =?utf-8?B?dXV4empCdkcrRG44QVovd0g1SWEwTEUwSzZwaVFaeVU4ak91TG94ck9aWkJD?=
 =?utf-8?B?Q1BzcjhVeFAvSHZKZVBBY3JncXNXYlVub2twY0tkN1dNQUVVRDVKKzNFQ0hJ?=
 =?utf-8?B?R2hHNFg5NExmOGdZZ1U0bjlmMUxURGJaL1V3UHEydElZakUxM05ZNzU3Y0Zt?=
 =?utf-8?B?Nkx5SERCVDhreTRpSUs3ZVpvbm40Nm9sN2NxWjROL2RPWFJwV3FMT3lyaTdr?=
 =?utf-8?B?bnEvcnc1K1FNZVlBS0JGY2NTemxKOU1GTTZRYnZSRFBJS0ttdTJnRkhoano0?=
 =?utf-8?B?Q2NqSEhrTWN6Z2R5My9CMlZTVjh1cFZ0dm9TeHpuMVBBZmpzVkppSG9QeUc0?=
 =?utf-8?B?U0dLZlRLbGg3dUcxcVVsSC9kZ1IwR1JLYzdxaTBjbFVXTEYya3JQV0tFc1RE?=
 =?utf-8?B?cEg0Mmh3cHI5cFZGaDlDTDFWdkdQN0ZKWlRsQTdtQmZCMDJJVk5zK2JXMEJx?=
 =?utf-8?B?QVkzbzlRL0Mrb00rL0N1ZEJhbHcxcncrTUFRZFloRXZjNkQ5T0FVbWhiZE5P?=
 =?utf-8?B?ek5xekZ4R0pBQ2FMMk1xdVJRaVk5a3dCcmV2am1xUmZMUERHSEtqOUtna1pu?=
 =?utf-8?B?VFJQRTlUQjRpVGxLREF5d202elVrazJyQWRJK3FjdTJIS1ZBWm5FNnkxR2dO?=
 =?utf-8?B?V0ZYZ1NncWowMFFhTnJldmxKZEVBd3RaVy9ncnUrVEVlNXdvaWNVekdSMU0v?=
 =?utf-8?B?THQyVnlJM3VxemFDYm0rWWZlSlg0eGY3cHltcGJEenArc3NPd0RRNDlPSFhr?=
 =?utf-8?B?M2VxUzdoOEswbmErcFZJZStCRjZwOEVQanFxMUFxR0Y2NzQ3R2hOTnhIUjhx?=
 =?utf-8?B?SjlCZ2ZaMEdHZ3hEQTV2V3dUY0pUVTBTeWZOdFZXY25BbUZScjFEQ2FUZUlm?=
 =?utf-8?B?cXgzRmJUc2ZEN3NqR09hWDg4M0tBa0gwM3lwSHBWUEhpMTA1QU96SHdJanc1?=
 =?utf-8?B?NzJ1N1FQbEUzSi9BNGttdTFHK2VneFF5bU05OHpHNzNDRWJ6bnErd0htQzVh?=
 =?utf-8?B?MUF0SnMyQ0dPaFg0WTUveGgrRW5PQkdRcUJrVGVwQ1JFeUY5VW5kN0gwSitZ?=
 =?utf-8?B?Y0N5ZVRvMXQ1Z1AyOEFZL2pSWmg4R0ZKSUplOGsvTmlBUmFmRUhwbzFlcWNB?=
 =?utf-8?B?ek44Wjk2cHBnWXppWThSdXdTNE5uVjl3aFhMUUY2M2hjMWNjb2phZUZOUG40?=
 =?utf-8?B?QS8xRE9Na00vRXFQYlAyc3lHMjZoWWpyRk9LM0p5amthZVRKUzVxdFVJKzB3?=
 =?utf-8?B?bEtnL1psZklUcXhxZklybThuZXBienBRTUN1TUoxZWVZYzMvVFIwS2VKMXgv?=
 =?utf-8?B?VzNlemFsYTQrNERTckdQY21WTFhLQzZ6aklBenNLanFDOFlpNWZ6bzFEbkwx?=
 =?utf-8?B?K2M0TGQyOUVmejdkVGYrSmJhaCtvRDZINnlhWjlQemdoY05YV0s5N29aeFBs?=
 =?utf-8?B?dEd6cGNhb2htcXRnU1M2YjNrODF6VEx6QklJOXluWUxwNzNHbnJwQ1NwdGRu?=
 =?utf-8?B?Mnlvd2svcTV6ZXo1bFVrUWhCOUFEQzZKVGQ1THVwaFhwWWl5aUcxWmFPMG92?=
 =?utf-8?B?ZWoxWVpOQ3J0OWJ5cDNJTm1XWFBqeHBZckVHNDIxSVlSK01sOHROdkZqUllK?=
 =?utf-8?B?YURSV1lnenVhS1AxYUVMK0JFb3VNQjduSWJuK2V0bXZHV3ZhejVpVEVFS2NX?=
 =?utf-8?B?Z0l3WXhqSkxuNGhoNW1aSnEvMmNhMVkyNXNxTHowd2JsTk9vMXpsdllVOFhy?=
 =?utf-8?B?eThvczloWVNjN3dvQ2xNUS8vbGFTRU5nSXI0SUVIU20vS25MYSs1K0dhZkJu?=
 =?utf-8?Q?qQXsUz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2025 05:55:39.5991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc6f2bd-caa9-4749-811f-08ddabd141dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779



On 6/13/2025 7:22 PM, Zhu Yanjun wrote:
> 在 2025/6/10 8:15, Mark Bloch 写道:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> When firmware asks the driver to allocate more pages, using event of
>> give_pages, the driver should always allocate it from same NUMA, the
>> original device NUMA. Current code uses dev_to_node() which can result
>> in different NUMA as it is changed by other driver flows, such as
>> mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
>> allocating firmware pages.
> 
> I'm not sure whether NUMA balancing is currently being considered or not.
> 
> If I understand correctly, after this commit is applied, all pages will
> be allocated from the same NUMA node — specifically, the original
> device's NUMA node. This seems like it could lead to NUMA imbalance.

The change is applied only on pages allocated for FW use. Pages which 
are allocated for driver use as SQ/RQ/CQ/EQ etc, are not affected by 
this change.

As for FW pages (allocated for FW use), we did mean to use only the 
device close NUMA, we are not looking for balance here. Even before the 
change, in most cases, FW pages are allocated from device close NUMA, 
the fix only ensures it.

> 
> By using dev_to_node, it appears that pages could be allocated from
> other NUMA nodes, which might help maintain better NUMA balance.
> 
> In the past, I encountered a NUMA balancing issue caused by the mlx5
> NIC, so using dev_to_node might be beneficial in addressing similar
> problems.
> 
> Thanks,
> Zhu Yanjun
> 
>>
>> Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on 
>> reader NUMA node")
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> index 972e8e9df585..9bc9bd83c232 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> @@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 
>> addr, u32 function)
>>   static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>>   {
>>       struct device *device = mlx5_core_dma_dev(dev);
>> -     int nid = dev_to_node(device);
>> +     int nid = dev->priv.numa_node;
>>       struct page *page;
>>       u64 zero_addr = 1;
>>       u64 addr;
> 


