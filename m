Return-Path: <linux-rdma+bounces-11478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5EAE0B6D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C043AC26F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C22253FC;
	Thu, 19 Jun 2025 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mc9BXWEp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAA18A92D;
	Thu, 19 Jun 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350737; cv=fail; b=AYp8rRoiHQ7DorDiT/qp9cjKOUkMy+BYQAx7D/wVDjK6V5UJT+QMHqP5Lso26W5eLK461NFJFM3pVRId+iKFfQ8ogcV1tajJTSqZngmYHOadFqrkjiagdJ1IA+UlTDs7bvpoOLqw/dTFA0/FFU0MpYIANWyozoONTyNWV2R1vAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350737; c=relaxed/simple;
	bh=HPDht9YAEeQR8dKUFcWeY/2g3PObP7CKr/H8gcXQ0mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQTZ37ri6SFKnNvsDxjE8M7koQtoJr0QK3KrpqrMdT/4dlcHi4M7Q9b6BvCJoe9Il/UvQx4LtYLHij61BrgiF2BzdQiM6BPoHNRqPdLBIiJlpxiRGX6aiRODS5xlY8KDSyiulvby/PUbj4dZMiVnE+lgh5bU8Hu9pmydRxNDOOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mc9BXWEp; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO5M+o4Uuqi2cF8RT02T9C8NIMQq4jSPPglx6E+yid+GZ5GGci3dtzuvctC4ZxyHTaTtnCDOdLuuz/zsBSDXQit5gJ9He7d74w9q6COO6ajnWwGFo7JvcbLR/JMnnhXp3kCPePdh1w+or84ux6+cvPrFF590OK7mD7A6E+KflouWfH9Uich2sV3hER7ynM3hl/OfXBT3ozr4g+emWLNO9VbDl4bg+LD5WkbBezRXuUgjH6V1OUsK8UaMKA9R27QWTPF5no8/FiWNufPQckLiOwNS96MjtfzxXy9KqQSJ91KzfFKndrMvPvpL1921BF7DnhVDprhUIg7O+QXJms2XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QP87amUtCkJN2TwGiE61o6YTI4TpVfQ5fX+m5Jb2Uw=;
 b=yIjzww7vvnoKFsnQo0i9X0DtYFmc4vILmjnU8jj3AuXAFUmnV2Ibr8aQ/YD0ugDiNqsuRYtiZsOn+N6czKtMJxkcUB3kXko9eOcp6trNZLmNgwullL+9wSudf0F9oJrJwDWxwCfVQOQw2PaaVNJJMXqk9bT3M0SdtDuBsaiYozX7nFlarjWPg9uPXtpsdRG4Rz2BKLGxk1bYwC5PWbbE0tBVOwNX/mHvcL2YvG8lQsHaOOlGZ36zuEUCOb8UPhZep6IVv90WMVDYKC9rq9Owt5cmOMjoesIzsoQxfJr/BncLKbn5Jxd2AcAShvoXgDLsI6eiWVjgkFxyy7CexX/BhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QP87amUtCkJN2TwGiE61o6YTI4TpVfQ5fX+m5Jb2Uw=;
 b=Mc9BXWEpiv+NqCbHUFsLXC1mcVi/mLg9IGQ3eX120qf8hr/2ZxM0HXz9rt28mOsVSoRZt5Kuh+fdcqa3cYNr4xuI58KZt0gHzGN5oDPYS4DZUcJ1xeCBQYh3EyrocKrZ9PhM/lqI+ztkBC71oEtwMM7u7zYuyzEwo1Bt3mOjznCm6SNyZC3sgr4FfBlLgNEFBSeOJVP9ds+X1Kij9rN6ew11X4julvqkyYuRYkHLjhndDY+gF9yakbyes0lWxWkusIg4vT0twmLBthv7/oVEqvp3N1Me2kEhKSGlVkr2qRuaqzS1kfBoz3FNST2HXJLzeMZPzFfKqKavkJyveI6Udg==
Received: from BY5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:180::22)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 16:32:10 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::ee) by BY5PR13CA0009.outlook.office365.com
 (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.8 via Frontend Transport; Thu,
 19 Jun 2025 16:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 16:32:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 09:31:53 -0700
Received: from [172.27.21.80] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 19 Jun
 2025 09:31:48 -0700
Message-ID: <c79b50bc-bebb-4e4c-8c82-8af07de907bb@nvidia.com>
Date: Thu, 19 Jun 2025 19:31:45 +0300
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
 <524cf976-a734-4d30-915b-2480a6139e27@nvidia.com>
 <fb6c6cc5-aa19-4f10-baf7-e20f021553ab@linux.dev>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <fb6c6cc5-aa19-4f10-baf7-e20f021553ab@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c1059f-4fdd-42bf-df4b-08ddaf4ed66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm9VODlzTmpqZGZkMHhRN2NhcTZFYklpMmEyTTRiazRhRFhCVWpMQy91MExJ?=
 =?utf-8?B?d0c0Ty9ITkZpV3RsUXV2bWJ1N0IvMFgza29UODR4a3V3MTJJS3NPQnpyeklU?=
 =?utf-8?B?QVlrMmN3S0xpT1p4Rm9RWVdueEpRcTIvTml0cG1TS08yS20xeFZ6WVBEMklN?=
 =?utf-8?B?RkdsRXNoVjZDZ2R3NmtOMTRka21xZWxXWllZRGljNFBJN29HcjZseUpSNUs1?=
 =?utf-8?B?bExOaXpicjRRY25LN0NBQytWVmx6QUVmRVhKTktrT0Q5VGhuSmtqMG5nUFV6?=
 =?utf-8?B?S0xTdGQzL2RLUkdENUkrMHVsMVpqZ08xemxSaS9XSFEva0RQNXJyMDdTU0xs?=
 =?utf-8?B?NGpXVnV6WUtBZ1dsb2lYNnA0WmJYWU1pZUZZeFFPVDhTeDFoLzlESU5zTGtu?=
 =?utf-8?B?TDRIaDQzaHQrbnRmM2p6MzZxUDlKSWN1NE0yanhMRGZaVmpsa0ZmVmVmNmtJ?=
 =?utf-8?B?MzZEK1NIWjBZckwrZ25MK0FxU1UvUmtwRkRBQkZRSENFcGgvTUZhdGVsdlZk?=
 =?utf-8?B?YUdmcHdrTm1KcTZ1ck9MMHNSZ0xheEtPdWIyOHpBMnlWeW9hK2hFNGxzTXY2?=
 =?utf-8?B?VExsQkhsTjVXMTlGY2NUcXp2RlZpME9NM2dtV0dKUUFYMmRFMkhHVFZSdVdI?=
 =?utf-8?B?S3dvaDR1YjRLYjBqN0xUckthMEliS2wwRkRLSjlXMGc3L0R3Mlhvdmd3alA2?=
 =?utf-8?B?TVd1MDArMGtmc2V0bE12a3RhNGR1YkRqaHJxbG5mZnd5eU1pRUIxaTBoVTVN?=
 =?utf-8?B?cUU3aWtBcGFFem5waE9HQ2NtdXhzMUpMNWlUSHg4djBzWmRiT3lZMmdDUTNC?=
 =?utf-8?B?UVpNazl1WEdUa2Fic3B5OWR0TGxONkdKSUo3Wk9ZSmxvNFIyak1tYkNDeWxi?=
 =?utf-8?B?Q28xUllqc05RblVDUWtMVS9remw3V2tNVWVZZ2xOVXk1dDE1QWh2Sk9HNzZa?=
 =?utf-8?B?a3F2TVhFZnY2ZzIveTJZWlZMZ0NzeHJ0TTlDMlVxamV5T2psYVF6R0FxT0Nz?=
 =?utf-8?B?VjFxU2ZrcE1OVlhaQis4U3o3RGZpaEgzckIvTjhEVDB2RmI1REpnT29HY1Fl?=
 =?utf-8?B?SEJ2U0JTbU84M094ZHVkbzFITlFPQVlFSmVKUlN4L2RvUklwWWNwOEZVeWRl?=
 =?utf-8?B?L2xCazhraGxiVm53REZualVwcWJGNE02dkpmOVRaZHFhQ0pkR3pXTit2Q0J2?=
 =?utf-8?B?WDRkL284NUNoYS80SUVpallqRDlzVWVmYVVLMUgwVHJVUXMvRlZHWFREaG5n?=
 =?utf-8?B?a2p4STByTUs3MGQyVm15dXZGVjJtSFZ6MUpENms3SnAzZE9HZGFnOU00REZ4?=
 =?utf-8?B?U3FRRklWdktDRW9qTnRCRHk0NWM3akNvUU1weWdXUWd1TG5DTllSZFVITmdF?=
 =?utf-8?B?dGZQT0xHL0gxQ0NiaVlKSytnYnBJblFKN1YwSklrd3ljT04yTEE5M09yeTJJ?=
 =?utf-8?B?aEZOVHVXbkxMYXp5M3dKRG5JSzMyditBSENkWldxbEh2SUpWejJBTDRXTzQr?=
 =?utf-8?B?TUtLWW1UNHpQMVlleWxxWlBtcFpvOVphSkZEU3R5Y3RvV3haSDNYYUdNZTZV?=
 =?utf-8?B?cXJVSTRHVWJJUkVZR1RZSFNZWm9RMFN4d05ZVFNzeFU3dTFNWWtzV092enFF?=
 =?utf-8?B?OVVHZjhKc1ZJd3cvSURBdk5yZFFHejhuUVk4eUVzSGJXZ3NGMGxZMTRVNWNk?=
 =?utf-8?B?TlJZYVZDZUozaG9ZRnpRV3lEYkkxbHpVZE96YXJRZWxjT3BkSkNsUEYxa2p6?=
 =?utf-8?B?VEs5N2ZJTHRmdlVhVjFtQTNKK2xIUmJxUG9vQno1QzlBUU9NTVk3a0xaSlo5?=
 =?utf-8?B?d205RjE2MXFWSXJ0YlE5S1NCMWxvQy9vN2R6ZjRaMEFzQ0JRZlhDNTFkdjN0?=
 =?utf-8?B?TFRwMnovMVVheXgwaTU2K214U0ZtNXgvclpiQ3NHVWNsNUVjZzVLa0U0R040?=
 =?utf-8?B?U3I5RlJNNm9DcGFKQ1RCVkdoR3ZIQnkrdDJDYkV5bnBNNXJqT1dpdVNKYm5j?=
 =?utf-8?B?QTNLRnp4VWRLRk5PNEpzOGlWbkRoTHRRbmIzUG1WdC92S1lIK004ME9ibDZM?=
 =?utf-8?Q?tvnFuH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:32:09.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c1059f-4fdd-42bf-df4b-08ddaf4ed66a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245



On 6/15/2025 5:44 PM, Zhu Yanjun wrote:
> External email: Use caution opening links or attachments
> 
> 
> 在 2025/6/14 22:55, Moshe Shemesh 写道:
>>
>>
>> On 6/13/2025 7:22 PM, Zhu Yanjun wrote:
>>> 在 2025/6/10 8:15, Mark Bloch 写道:
>>>> From: Moshe Shemesh <moshe@nvidia.com>
>>>>
>>>> When firmware asks the driver to allocate more pages, using event of
>>>> give_pages, the driver should always allocate it from same NUMA, the
>>>> original device NUMA. Current code uses dev_to_node() which can result
>>>> in different NUMA as it is changed by other driver flows, such as
>>>> mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
>>>> allocating firmware pages.
>>>
>>> I'm not sure whether NUMA balancing is currently being considered or
>>> not.
>>>
>>> If I understand correctly, after this commit is applied, all pages will
>>> be allocated from the same NUMA node — specifically, the original
>>> device's NUMA node. This seems like it could lead to NUMA imbalance.
>>
>> The change is applied only on pages allocated for FW use. Pages which
>> are allocated for driver use as SQ/RQ/CQ/EQ etc, are not affected by
>> this change.
>>
>> As for FW pages (allocated for FW use), we did mean to use only the
>> device close NUMA, we are not looking for balance here. Even before
>> the change, in most cases, FW pages are allocated from device close
>> NUMA, the fix only ensures it.
> 
> Thanks a lot. I’m fine with your explanations.
> 
> In the past, I encountered a NUMA-balancing issue where memory
> allocations were dependent on the mlx5 device. Specifically, memory was
> allocated only from the NUMA node closest to the mlx5 device. As a
> result, during the lifetime of the process, more than 100GB of memory
> was allocated from that single NUMA node, while other NUMA nodes saw no
> significant allocations. This led to a NUMA imbalance problem.
> 
> According to your commit, SQ/RQ/CQ/EQ are not affected—only the firmware
> (FW) pages are. These FW pages include Memory Region (MR) and On-Demand
> Paging (ODP) pages. ODP pages are freed after use, and the amount of MR
> pages remains fixed throughout the process lifecycle. Therefore, in
> theory, this commit should not cause any NUMA imbalance. However, since
> production environments can be complex, I’ll monitor for any NUMA
> balancing issues after this commit is deployed in production.

Thanks for monitoring it.
Just to clarify, this change does not affect also MR allocation. It 
affects pages allocated for FW internal use, handling requests from FW 
using give_pages() function and manage_pages command.

> 
> In short, I’m fine with both this commit and your explanations.
> 

Thanks,
Moshe.

> Thanks,
> 
> Yanjun.Zhu
> 
>>
>>>
>>> By using dev_to_node, it appears that pages could be allocated from
>>> other NUMA nodes, which might help maintain better NUMA balance.
>>>
>>> In the past, I encountered a NUMA balancing issue caused by the mlx5
>>> NIC, so using dev_to_node might be beneficial in addressing similar
>>> problems.
>>>
>>> Thanks,
>>> Zhu Yanjun
>>>
>>>>
>>>> Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on
>>>> reader NUMA node")
>>>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>>>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>> ---
>>>>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/
>>>> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>>> index 972e8e9df585..9bc9bd83c232 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>>> @@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev,
>>>> u64 addr, u32 function)
>>>>   static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>>>>   {
>>>>       struct device *device = mlx5_core_dma_dev(dev);
>>>> -     int nid = dev_to_node(device);
>>>> +     int nid = dev->priv.numa_node;
>>>>       struct page *page;
>>>>       u64 zero_addr = 1;
>>>>       u64 addr;
>>>
>>
> -- 
> Best Regards,
> Yanjun.Zhu
> 


