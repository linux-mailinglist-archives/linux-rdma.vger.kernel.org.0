Return-Path: <linux-rdma+bounces-10904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841AAAC80D4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45B03A31F4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD122CBF8;
	Thu, 29 May 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rn7QQvI7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C619AD90;
	Thu, 29 May 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535870; cv=fail; b=Ek6XXm04StnUrdRP+MksGsdb/qR3J+zvlvbioAO4vdOAQHaxD/qqH6H1HyGis5S70X9+T9brYnO/bXR+Wg51XuviEatEb/30Qn24PD+OnwQDyFTAPpxLPFAcef+W2U3lWin1NevoN0Ooo3lq7WjDVaskxWpPYvHiELNUzhqkmhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535870; c=relaxed/simple;
	bh=/9LWGQFLUthHBbC5RmWiUEU0VJ5/jcXjrK9Btfl3P7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RtP/6xnsjHvrT/yc6hom18dFTdyjS3miUgNO0tmb7coPkyDq7hjsNOHcvXr71iHkfp3+1NWEBuuM2vC4lfroVr++99PXThXzylHMMXXyHkWU7hV4cUKLD1yB+uo8G2smY7n2/zDCCBDGnNNtdbbBfyZ/OJi5OIPG9C29myuGvMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rn7QQvI7; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO3K15NVKeCM+ZgRpNzpX7hmi/JM3lLnSzH0GWYFH0P8UsOov/dAvkVRr0CX+jko9F0/JZQkbeO4cxcn4x0a0Ke2ts6GAi0DgjVOPzWVDyyNfmtFWmXsrGk0nQpjabx+dr5Jq9He1Gg+zDyKJValJ8gd/CsmG4sG1VdSIIDvR0EfLYdRefrloG/3c1wkNQoPIqZm/yfIf1YPwXh7VPFiWtpuPnjPVkTurY2B6c7y6e8g+bnrg+CxTHKKjjd+F5v1cm6G0Lqhk61ISGU98aUDBd5lDG5wIqgt1cJI5nxAaHzWNgeZIq35vDUGBjkjmMMTRgO8TwommWm0lP29FdQ1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqMIQRvjXHZr/dxOUCPcsFi5tYQOlDJ9Uds42tUfRqU=;
 b=pW/x1wP/jmzQkBQx+iJRy5IJhw3CDV1minUBY82xY/0ecaRCkcoBaHKdVq65MQ23mBhn9e8d8lvV6VhTqV1p3+YgEpTBF231qp+Ott8v1JKLpeEGlKUqFZ+ZZ9VDAA9tTh9XJTAV7t6cxQZypgESPo8xEs7vxSBkXyO99anjegkL9XkztlKg1c+tPoV9YHcxaZwKj7lyXNNRakG2kDrqex+7IwLEGCAJpQTunqoP6Qhw1LUh6s8rd8sl30/deqZd+rKBY+QfNzKbSvFLvOKlaT83R4KJ6kyObclE3Z87FpOQag+VTNziYaAuF9K42UnVjb1J6vP/KVF0RXgp78InZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqMIQRvjXHZr/dxOUCPcsFi5tYQOlDJ9Uds42tUfRqU=;
 b=rn7QQvI7J77lyoXU8A3G6+aTHHoJT9Pp7QmN+08nHU44mVVzO8tqgjWe8m2TZj/UZ7oE9B7d2qeYlWaLjjxrnPtjzs5GPKbXnQ4+amRNyTFq8o/IT9E6f9gixb1TTxda838gyaSuQ5YAsqefvfCEjp3kypwfrT6CMFPqfeJ+wPEnEvaBqKX0VKqFSkI5qMaRQqrc63VV1jntypM4YzOyTD/3jRzTSgmEL4w7NUr9QdrJWzaJutn4g2A876NTYBRuNxsVSbbHOHCetcF+IjRCPkQUoCvIUj5qDFlT5q38sgTUrvc3j8fFSEpJFx83ETJgbns+u9hHHrVuFz+VELKwaQ==
Received: from SN7PR04CA0173.namprd04.prod.outlook.com (2603:10b6:806:125::28)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 16:24:26 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::40) by SN7PR04CA0173.outlook.office365.com
 (2603:10b6:806:125::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 29 May 2025 16:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 16:24:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 May
 2025 09:24:11 -0700
Received: from [172.27.21.18] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 29 May
 2025 09:24:07 -0700
Message-ID: <b8c300f8-bb3b-421f-81c5-f493984f922d@nvidia.com>
Date: Thu, 29 May 2025 19:24:00 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: Flag state up only after cmdif is ready
To: Chenguang Zhao <zhaochenguang@kylinos.cn>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20250529075849.243096-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250529075849.243096-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc78dcd-8e61-46f7-d7c8-08dd9ecd46e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhQcDNRazhValV3ZkVJaSt2Sjk4VkUrTlQ5K0M3b2Z6NUtJZGlTMHdIazVZ?=
 =?utf-8?B?REtpOGVwNU5DMlg5OEJxQ3orSEZTZDRoYTFYV1l6MHdKWjVQMnUxbjJQN2ZX?=
 =?utf-8?B?a05Qd3MyUTBTS1QvWjJQN29aY1MzME1hV2FpUCtpa3FnN0drcXZ6eVhxVDRx?=
 =?utf-8?B?VnJaWFZuUlFsdE1wU05jZ0wraUpaU0NlbEVzUnRQMGVqV1ROY2FRMXMxTlo0?=
 =?utf-8?B?Zzl5ZUNBQ2ord24wWTJLOTRQVjZwMHczaExVVUhZdTlGazlTWmpJSU5BOG1n?=
 =?utf-8?B?RWQ4WElUQ1NWeitWUG5RRXJFekgrWW0zTGxLYVBUQXJSWXBqZGNIZ0NQUmY2?=
 =?utf-8?B?TGE4MzZ2UWxVaUkrOWVpK3dvdnZIbjljR1dqc0xTcU1ta3dnNDQ1cVJhUERH?=
 =?utf-8?B?YUQwSWFxSnFFdHN2Vk9kR29ia0NpUXVmTUhDVEtZMExlSnRNRlVzek43RXVI?=
 =?utf-8?B?ZGUrSDZhcGZFNVkwL3VSNHZjWURpRGNiUTlSV0dzMWxQalNBNUxkaTArY3Fk?=
 =?utf-8?B?bFVFTktBeFMvMDFhSWNGTXRHRHRleEwrUUU3YzRTS3hlTi9FdlpWZjFuSzA2?=
 =?utf-8?B?YVA0UHovcjkvbG9FbXpQRDNrL3JuNkxER3JmM0pWWDJWSzRsVnRLT09sY1FF?=
 =?utf-8?B?QXJQWEV0V09FWDZ5UlpVdFFvSEJuQ2VaR2pLTElvNWs2VGxNeUNHV2RJemxH?=
 =?utf-8?B?LzZ1emJKMzI2eDFETTgwczNhRWtyRVE5bHd5QllyWUdTOWJoMGtpYUxPb0Fs?=
 =?utf-8?B?WTVpbi9tTFBvZXhlWHlEMjhpczJjYjY2bGE4WmRWRUtkNTNyRjQwdUlWMlIw?=
 =?utf-8?B?MzNtK1JrVmVYMkpRa0cyQjVIZys4TlNBeFc1VGZETXZiUzU1QWxzUXQwY2Mw?=
 =?utf-8?B?b0VtWm1CY3k4VEs4ZmRRcVFteHZJdDFoNkh2eFY0aURnSGRnN0tLM3RnZ3BX?=
 =?utf-8?B?cSs1UjE5dVQ4T1h6Zm9NdmhCK2NxK0xYQWZCY3pWQlArdEt4cHhGOU0wYWNi?=
 =?utf-8?B?ZWJXRFhUWlhHMzhMTXRnTHdHWm1zUnFrejBYTkVteVgzUGlyZzIxdms3TDND?=
 =?utf-8?B?N0xFaTRPaDhIa2xiRWw1ME5HeEpHSTZVbWtlYTIycmYvN1pjNEExOG9ZWXc5?=
 =?utf-8?B?TzM2NzNEUHRMU1ZqOGJMYy8vcUZDWms0TWFHdUpIYzNndHVZWXA5U0lpeEJh?=
 =?utf-8?B?NEZueDU1WU1KS0VQb3lTUm5rOXRnN2d5bzFVNTdqUHhhV1pOVWpRaGtBc1ZZ?=
 =?utf-8?B?amEvbnBsSVJHc2x3S1pWWGU1VGNZUWtZSGx0NkI4RmJKVm9Dc1NTNmN2MTZX?=
 =?utf-8?B?cjBFUlVXOU93WTRKV0FzYzZGV2dMY2MvMXYxa3MwVlRnSFFXR3gyV2Q2L0lo?=
 =?utf-8?B?V0hhY3ptKzlwdHZ3dFNNNXNEYVpkZ2VMVTI2V1VzeGRFMG16TXZMVFFzSzFW?=
 =?utf-8?B?dlhzWmMrUTJyVXhFcWhFdTJrb3JPZktqN3RxcVdhTDhLYkxUdGlqQlZiQ21x?=
 =?utf-8?B?SzR2REh6aksxTlYyVm1Qb0lXSUZXSUZwYWFGQ3BXMUd1QkFvS3lkUWJxalVz?=
 =?utf-8?B?dDYvUVF5eGg3WDJHNW1BZU1LNlkxTkZ1Rk4vUkJ5SGk1cG9GZmQyMDZzWnRM?=
 =?utf-8?B?RGREVzlkaHR0WUU3ZVV1VWxPQ1grMU9CSzdUZElveFRVZkxkV1Mra3l4R21q?=
 =?utf-8?B?RjNKQkI0NUlpOUtYQ1Y3RzF3WFYvMlpFZm5mTXdyZVNldkx2d2tRR1pONUgr?=
 =?utf-8?B?SklyUy93eDc0YVJQbEFENDdNbEpLRDhDUnNVdkdzS1RTNmpZOGNLOTE5UGY4?=
 =?utf-8?B?dFFXeGd3SlhTOVdvMCtZQ2htRUNrUUdPcGJaak1xY2lNd3M2V3p6M3BBV2pY?=
 =?utf-8?B?UVZ1SkxJZXRwa3FnUmMveTY3VUw4d2ZZdXZhSU1mU09FeDJzVlIyNTE0NEZI?=
 =?utf-8?B?NU52ZnhJQjVWaWhLaWdmUXZCWEdJVjNWSG52aktYcVJnWGthWUVma0FXdnZJ?=
 =?utf-8?B?S0UyRjFxMzI4NHRaUkJPdm1palVFVUVIVi81bnNQRE9ZdEZjOG84aU53YTBr?=
 =?utf-8?Q?pe1Ypw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 16:24:24.9981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc78dcd-8e61-46f7-d7c8-08dd9ecd46e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339



On 5/29/2025 10:58 AM, Chenguang Zhao wrote:
> When driver is reloading during recovery flow, it can't get new commands
> till command interface is up again. Otherwise we may get to null pointer
> trying to access non initialized command structures.
> 
> The issue can be reproduced using the following script:
> 
> 1)Use following script to trigger PCI error.
> 
> for((i=1;i<1000;i++));
> do
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
> echo “pci reset test $i times”
> done
> 
> 2) Use following script to read speed.
> 
> while true; do cat /sys/class/net/eth0/speed &> /dev/null; done
> 
> task: ffff885f42820fd0 ti: ffff88603f758000 task.ti: ffff88603f758000
> RIP: 0010:[] [] dma_pool_alloc+0x1ab/0×290
> RSP: 0018:ffff88603f75baf0 EFLAGS: 00010046
> RAX: 0000000000000246 RBX: ffff882f77d90c80 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 00000000000080d0 RDI: ffff882f77d90d10
> RBP: ffff88603f75bb20 R08: 0000000000019ba0 R09: ffff88017fc07c00
> R10: ffffffffc0a9c384 R11: 0000000000000246 R12: ffff882f77d90d00
> R13: 00000000000080d0 R14: ffff882f77d90d10 R15: ffff88340b6c5ea8
> FS: 00007efce8330740(0000) GS:ffff885f4da00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000003454fc6000 CR4: 00000000003407e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call trace:
>   mlx5_alloc_cmd_msg+0xb4/0×2a0 [mlx5_core]
>   mlx5_alloc_cmd_msg+0xd3/0×2a0 [mlx5_core]
>   cmd_exec+0xcf/0×8a0 [mlx5_core]
>   mlx5_cmd_exec+0x33/0×50 [mlx5_core]
>   mlx5_core_access_reg+0xf1/0×170 [mlx5_core]
>   mlx5_query_port_ptys+0x64/0×70 [mlx5_core]
>   mlx5e_get_link_ksettings+0x5c/0×360 [mlx5_core]
>   __ethtool_get_link_ksettings+0xa6/0×210
>   speed_show+0x78/0xb0
>   dev_attr_show+0x23/0×60
>   sysfs_read_file+0x99/0×190
>   vfs_read+0x9f/0×170
>   SyS_read+0x7f/0xe0
>   tracesys+0xe3/0xe8
> 
> Fixes: a80d1b68c8b7a0 ("net/mlx5: Break load_one into three stages")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
>   - Add net subject prefix as Paolo suggested
>   - Add Fixes tag
>   - Add issus reproduction script and call trace
> 
> v1:
>   https://lore.kernel.org/all/20250527013723.242599-1-zhaochenguang@kylinos.cn/
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 41e8660c819c..713f1f4f2b42 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1210,6 +1210,9 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
>   	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);

Up to this point cmd state should be down or uninitialized and that 
seems to be the issue reached in the trace above

>   	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
>   
> +	/* remove any previous indication of internal error */
> +	dev->state = MLX5_DEVICE_STATE_UP;
> +
>   	err = mlx5_core_enable_hca(dev, 0);
>   	if (err) {
>   		mlx5_core_err(dev, "enable hca failed\n");
> @@ -1602,8 +1605,6 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>   		mlx5_core_warn(dev, "interface is up, NOP\n");
>   		goto out;
>   	}

So preferred instead of moving the dev->state change, add here: 
mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);


> -	/* remove any previous indication of internal error */
> -	dev->state = MLX5_DEVICE_STATE_UP;

Please try this change instead.
Thanks !

>   
>   	if (recovery)
>   		timeout = mlx5_tout_ms(dev, FW_PRE_INIT_ON_RECOVERY_TIMEOUT);



