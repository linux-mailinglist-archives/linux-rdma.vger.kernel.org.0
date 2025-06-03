Return-Path: <linux-rdma+bounces-10938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E292ACCC1C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jun 2025 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDD7A273D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jun 2025 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D8323C4EE;
	Tue,  3 Jun 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DwN0fMrZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A41E5B62;
	Tue,  3 Jun 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971546; cv=fail; b=IvJMu2xRp/Ffqql7OB2TiAEp/rXrAvxtL/93AVGzCFOqUjcfY6CrGvVStjQkiCHkkAMkjjBwkk0FyT38j7VZQPZ/H+9dbbi8IZPFpfm1Lq7vs80VTsahP02RsGkqpziqu/zUKgYNzghrghCgsPa1MT9EHaClgM3MrRafvIxNloU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971546; c=relaxed/simple;
	bh=5QSbeTT/Y5Mim8agyE+DV7w/JkfoefiUimNIEluimeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EntAQSH8AXiH+UdbOxXaF/oOmDzfkxUKlK/e02gSUYYYB5UqhyQ0XZ0kDwFh0fZogXCvOKrBosPfsbnlHa48iChABl1KD7BwWi8id/gVIRIXZLeuDjdZtlgYfS952DKqb8HlaskO130m5S8L4L0Yc7mxa4BKBuA1k7yQgT2C3HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DwN0fMrZ; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPkWj3E4r6ZGQMIoWOePfP+V1UKwbwg7GEBj7dwljLYHs3s/YUbsV88NMz+MT2eL6z5L3uESLrj/0gzrsZsSw8vtNfjtIi+VBPpeohBcTourj8O7mhV0YCDxDvIpgD6XZeLMR2bRXUwbRbbID2Vtaj1q/rjN7wOuQd8irjX3tgcXimVo65VusblSkZ5MoxECVzKqfCFX1aCnbUWH8KoXFsuwubokmf/SHuzY5Qm8j9DHb2Plll/+toj33yBeP1Omm6r22Y1CQTv3YVvwVIAq8MEBiGLzK2wSDrLqC33hLTAdbOKbJNoh4hwliUGFcZNpt/S/PRYtojtGi0OKPAwVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4tFWQgXoCL/BHDL9wrzHXV9xg1ZLeBSrrELJ5B6oQc=;
 b=k4Z90WNm7ghZIjVT6k/8M623UsQ/9k88FQxZqTZKCXuLQeT+SdBvmzGdT1N1IxJ6ioqVUrf/s8HRPMOQmEZbMSHrR14BVBjdq77ZGZpoK1K5A7CaiyyDoplf4qiLs4zKgQN6HuW3cp+Q4cAgtDs5YX8S64+7i9P/EFpa2qq9hzHJM4pIgthoAgKRFkMXv9Stds3MAPbMEDeSdn+tu7ZU2GlPONyw2PlTPTOwCmAI7LD16pWvqKq6kA+dmiSZMM8AMZE68jx98ZVr/yLKKuHXi5BpLqCfpnDkQLfVzJoCUOTC4NNaB4bs6G6SaGKaMhrxpkgIoUPFYOgX4T4MP1f+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4tFWQgXoCL/BHDL9wrzHXV9xg1ZLeBSrrELJ5B6oQc=;
 b=DwN0fMrZWVmtJ3hfXawMh+AuUscv0a3gnvWQ+NvZQuwh9AVCpG2w2Fubf4Dxnf9SwzdYwCc2C4iQvXWoixtyPbTjNWN/EX7+L6oE9Pm+M84GClQ653tmR3e70Ya2a+m5oph7VykncYeZcIMpNlkKSanU4k0Tqac/1bfN9OIyrJDoX1JCFdN3gcR3/Aw50drA0JAwv9nGjA/O9aZd1Kk1D2eF5CnmAzI2AWUusSEakEo38c0JxNFsVqvRQOXvKLdwrFOpFDwYwsibpZ5L6M+sO/4dguhuPUPsid0fIEiFMO55OhDwCAOUWsQGZKcTR7jvr5MYGnGnfjA7yngfXfYblw==
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 17:25:41 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::a2) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 3 Jun 2025 17:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Tue, 3 Jun 2025 17:25:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 10:25:22 -0700
Received: from [172.27.55.204] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 10:25:18 -0700
Message-ID: <c37f034a-ec4d-4f73-8a65-1d3645184970@nvidia.com>
Date: Tue, 3 Jun 2025 20:25:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: Flag state up only after cmdif is ready
To: Chenguang Zhao <zhaochenguang@kylinos.cn>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20250603061433.82155-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250603061433.82155-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cad6cf-95c6-4d3a-8795-08dda2c3a9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUlHZmFYMW5vQ012RDY5aVNoY3NPVERJY2t0VjRHZkEvQ0RWdG1VcTdkN1lH?=
 =?utf-8?B?OUM0cDROMThYUzhicmZ2bTBHTkwydFBOOEI3YmdvRWRVeXNzRU1nZU1EVGF1?=
 =?utf-8?B?SEFxdzlFTHRROWlCRXl1OWg4Y2dxa2VmQjhzT1lsenFWN1lFbURyd21UZkxT?=
 =?utf-8?B?aG9QemJYdDdXWTN3MEh0NCtyQ1VRQWJIeWlGZks3WGx4Uk1BSDNsQno0eWd5?=
 =?utf-8?B?Z2VScUV3SE9ZV1d2eTRIaythK0hCbmhGaGlWdm1saXc1SG05T0JvQWQzRGFh?=
 =?utf-8?B?b2F2OVNCQlZCNHhuaDRja3FhNW94akRqZ1c5WjVRK1FhN2xKVU5OTXc4d2tS?=
 =?utf-8?B?ZjBSS0wyMlltdjcxLzR1SmJhdEJrZXpMenRzNEp4UmRCWUducGtjY3VJMVVB?=
 =?utf-8?B?N2lET2ROZjU2a2JIWmN0dzFEZmhucmgzQk41ZExBQnV1ZzZUVzd5elc5UHNk?=
 =?utf-8?B?NWl0YkNpTFk4bHBOdmtCQXAyR2J4YjhHNkp4NHZiWWtQdlFPcWovb2R0NjdO?=
 =?utf-8?B?WVdhMWRjOVdPUTBhaTFsb3lrQVpoUDUzUHc1Q0ovWDdONFlXMkZNWU1BUjls?=
 =?utf-8?B?QjhGOXg4eldNTUUxdk56bWZPYzNZb1hDSE1GR1NWQkNFYlpLbkNSREpmTm5H?=
 =?utf-8?B?dWovRWZyM0tqamczVHY5eitlZ3hhdElJTXNYLy8ydTFURUJtM2trL3NlSDNG?=
 =?utf-8?B?Mjcwa1I2cEVuaGZKSGk0eWR1UmwrR3dyQzcyQm15eE9MeUFXTFMvY0ZsQzJl?=
 =?utf-8?B?VkY0MiszeERYQ1hpTDZySHJvdjBTc3FrczV0SWhsdXc5cGZTR3NKUGIzZFds?=
 =?utf-8?B?TkEyMGtEYTFDMUtCNVNIL2g4ckNxYURrUDFDcDVQaGRzVmhGc29wRkorMWVL?=
 =?utf-8?B?dVlGNUZMNnYzRWozQVM3aVV1bjJEQlJZRlg2bGdXeklIRUpaWlM0UmRuYjBT?=
 =?utf-8?B?U0ZWUGZKNmlPamdjZzhQVlQzUmswUjJmMUgyNm5PRjVGY283S1ZxU2FWUDJr?=
 =?utf-8?B?em5mTU05emx5NmhCQ0xHaUVzeEpkNi9RdXFOMTBhUUZhQkV2THhoNy9oaXdz?=
 =?utf-8?B?ZWpUY0xJRllBcldHdk01QzdtSnNpdnlZRk1ZZzAxSU0yRWlFb1RVU0RSZTli?=
 =?utf-8?B?WkFvL0ZYcUpRbDFUbE8xcWIvUGE5bjVvVFd0SGcrb0tEM2lYTTNzZWRScFVD?=
 =?utf-8?B?ZDhlcjdIMG5GQmFtb05Ed2poa1hOSEVVWVl6NDdEWEd6VWFlMk9GdFF1S0tE?=
 =?utf-8?B?ckVIWVZpM1lONzVDQlo3UVRWY2owTFIrdmR3dyt5NDhFelVWRTF0Y0VsNm5U?=
 =?utf-8?B?SGZTdGZrODJvN2hEY3JBR010dW1kalRia0ZEYVdTaGlLRXc3aE5KTnp3K0wx?=
 =?utf-8?B?cGx5K2U4ckJBU2Jsa0J3RjJyMG1EelZidVBnUFlxMWxza0JIYngvdk9qbFYr?=
 =?utf-8?B?cndCYm82R3BnaC9HTUJneWJ0Q3BlRVNHTWw0TVF2cWNscmJCcU5sU1pzSHFa?=
 =?utf-8?B?bmt0MTc3bnBhZjM0dGdidXVGbEFUVUpDS2pmQTJTTmR6cU01VWJKQklSWXFJ?=
 =?utf-8?B?OWExZyswMm9acmNQdXF6SCsyQUtEUXRIMm5PVllrRGNldFNGWDg0aE1uMEtC?=
 =?utf-8?B?azZpcXJBSFJZL2dwQ1ZZaThFSERuRFdmRWprakZ6cU1MNXRjc1BOMm9zSHEx?=
 =?utf-8?B?ZDU1VW5TZnltVml6ODkwMWoxZkI3WU53WXJPKzk0TnRibklicEFncG1QV0oz?=
 =?utf-8?B?dVFOZ01CR0VDcVBGY1VaOGRLYW8vUU4rOHhXNmVqRnViRi9xVHRUUCtmRlZQ?=
 =?utf-8?B?RTk1K1FURndaNGRwSVpmQjZwTE1jVzJxNW9wd1dmMENIQXArc1V1cURhNXY0?=
 =?utf-8?B?WE4wNi9iTWQvbWFmMndISUNsRmMwa1B4Z2hCZkVnUEF5YWpTNmYxUDBkc0E0?=
 =?utf-8?B?WC9mdFhoVXdVSG1QTktCMjZwaHFTOFNweHU0bUpTS2ZKY0FpK2hJcmE4UGw4?=
 =?utf-8?B?VTNyZmtEZFhYVE10VGpyOGRYelFzaVZrNUsyRGo0TjFrSktyTVBrUmV1Rlhj?=
 =?utf-8?B?Y2UrUmw3Wmo2WjdQUTRoUHRIbEJzYlJIZmNyZz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:25:40.6875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cad6cf-95c6-4d3a-8795-08dda2c3a9e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974



On 6/3/2025 9:14 AM, Chenguang Zhao wrote:
> 
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
> v3:
>   - The recovery process of pci error is mlx5_load_one ->
>    mlx5_load_one_devl_locked -> mlx5_function_setup ->
>    mlx5_function_enable -> mlx5_cmd_enable. In the mlx5_cmd_enable
>    function, cmd->state will be set to MLX5_CMDIF_STATE_DOWN, and when the

Yes, but that is set when cmdif is being re-initialized while your 
change removes MLX5_DEVICE_STATE_UP before.

The trace points to cmdif, that's why we better handle it there.
I couldn't reproduce it using the scripts above, what is the 
reproduction frequency ? can you send me the whole log of reproduction ?

Thanks.

>    pci error recovery fails, it is the recovery of the entire device, so I
>    prefer to use MLX5_DEVICE_STATE_UP.
> 
> v2:
>   https://lore.kernel.org/all/b8c300f8-bb3b-421f-81c5-f493984f922d@nvidia.com/
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
>          dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
>          mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
> 
> +       /* remove any previous indication of internal error */
> +       dev->state = MLX5_DEVICE_STATE_UP;
> +
>          err = mlx5_core_enable_hca(dev, 0);
>          if (err) {
>                  mlx5_core_err(dev, "enable hca failed\n");
> @@ -1602,8 +1605,6 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>                  mlx5_core_warn(dev, "interface is up, NOP\n");
>                  goto out;
>          }
> -       /* remove any previous indication of internal error */
> -       dev->state = MLX5_DEVICE_STATE_UP;
> 
>          if (recovery)
>                  timeout = mlx5_tout_ms(dev, FW_PRE_INIT_ON_RECOVERY_TIMEOUT);
> --
> 2.25.1
> 


