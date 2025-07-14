Return-Path: <linux-rdma+bounces-12141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B873CB04286
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 17:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BE01886AAA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D19F258CEC;
	Mon, 14 Jul 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PqGrytZV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C520246778;
	Mon, 14 Jul 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505526; cv=fail; b=D/5hhjHn7XGh9BLzp2HsT2aYm5UvlHHH+lQWK+3K8WC+s3G9JbmAklervBpaf0EBeGhXNX1q400EOD7YKqF46n525mXaXCNMHdb1mOqZwlJHkeYyFmac/kXbUOnOei6aTXmczhW312gvCplM7c9kYq1aRifjKf+6DGNMRa7wzWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505526; c=relaxed/simple;
	bh=WgauV7bahmSBzxSVi1rc4TC01QrqP/S6NZQQ0oowJKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ukk3OPkRIfQntsFLfy6VTkVG7miArjO0NJmzrIeNgzrrSZNeayymDBsqF1XvBsw+0tUbiZic/8oi74En3JpKScLCfHb8Mx9rSF92+q/fJqbheZwH1TItwnCGvPOUblxIRxB24XvZ6UufLoJyveifsLVJfpOYGd97/a4pG8xr6mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PqGrytZV; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWJeZ7TnB00I6BeBenvZ1gcyORs/WxVP8AoEChC6Jsgg1ViwT7BoRJCZogJJSwW9CFGYgjm4hZ3SMn0yq5WQYoNplIXSOVyZ9+jZXpv0TKw5b9QSa3InzaroUpYJOJQglvQ6ZQ2Au2m+bOvX/rUxI9EL5D1mgJiRMY1DF3ofycvVGfLyGOMMqL0vyp+Ia9mdueydzkeRjHW+G37d1OYuJ8OHM//sHJRHbXxK1iVIj7hAHOpbPQjxdASOSLmyf2VXkZhfMLNwN8/S3b0ppNDwDLb2dMYl7Shj8DO8iUIp7yde0MDve6hCkQUBZ1yFYJShDUl4TCdd9QC3Z0VIc0OQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHuEMRDjP4vLREXR8Z8sFRSFOCSGYaJSrEfUFNhunpA=;
 b=ZSSGcS6RKpy6dz6VgRFPia9OxqBuiYozxiSb8hiVVoDJxEyyRQM9oEuAtSIK0rsqaSV1bxJvHet+sOZdFNs0LI9+1Ns14Ml4n28r4WEgyeMKG9Er5Nq/ya5GZp6Sd552WWfN5m4mpVNSFHB4F3CBP4xITpuZFUnzXnrGrjDj8xJLl6/yzFT2eyS3NUtfssmE6XDUddDJZuGSviK98wcQgWXK5L2NP1PTCsKBdtwOjyQeq2LUr2Zk5e/elSJch8KcqeQzPAVAMyHCLwj6ch74kWKL0Vrm5AcvwQHrUyw9q9Er7M79J6tnJ90556hmSyPbNAC0OojjaarijQZvoRU6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHuEMRDjP4vLREXR8Z8sFRSFOCSGYaJSrEfUFNhunpA=;
 b=PqGrytZVKbLh1AS6Z1H4fdd53oPf3lk11Qy5lgWkBK9fDuLVnj5tpsJmI453hpctOtcmqnCgGwBab1iW8nj9uzNyYANcD15m/4Bj+muWQS/nnwKoEJN5EpSAnx51Cedm1rz1SsvUciaKjyWeNiE0ixekPcm3gecCUkLG/OBqH3+S1AJfnDVdaCPnU/gZ81mbpwIZIp1FsYzt/XCKlKmCBtPZ4Y86b8EoE52PU9ZbU/J660UmJzIvcMGJpzkonHcY1DPK9zRKKJKOjVrBOrB83Td3JfEGqli/C9Yh9sqOl6xVRbKNyiS127A30zYPWStGW2UZ8DGrdmA74we2jauZZQ==
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 15:05:18 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::52) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Mon,
 14 Jul 2025 15:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 15:05:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 08:05:00 -0700
Received: from [10.19.161.12] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 08:04:56 -0700
Message-ID: <d03d6fd7-b86e-4c1f-92ef-ffc26339bf97@nvidia.com>
Date: Mon, 14 Jul 2025 23:04:54 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net/mlx5: HWS, Enable IPSec hardware offload
 in legacy mode
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-2-git-send-email-tariqt@nvidia.com>
 <aHSm7SHg1xTMNE0F@mev-dev.igk.intel.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aHSm7SHg1xTMNE0F@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f954d58-726d-4b4d-6f48-08ddc2e7d801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejRpSlR1Yk5QVjNlRUErTUhqRVhVcUEzd0FBQ0N6NXYrbjJZK1Y4eEZPTTZT?=
 =?utf-8?B?WlVodmJXTXRqRTB1UktWNk56TVl0bFZDd1ZnaHRtbzNRc0ZteG9WQ2M5L25r?=
 =?utf-8?B?d0FoaENsNVNwc3ZqaUlQeW1Ha1FlbXRSRGUvWXE1MlFFVmVIZjR3QUFhNGgy?=
 =?utf-8?B?MERKY05VNEphNTdKN2FHTVNRUlZ6LzRUMmViOWdVN1p6Z1hBVitnUnN5YkpF?=
 =?utf-8?B?OUJuOG95Rm12bC9tZ1dxa3FpTEJzU290TGJaRFZMaFpWaXBDa3FXN0tFTk1L?=
 =?utf-8?B?OVZDYXBXUlZtQk5JWkl6cXlhMkVJV0haZVVrbGhQL0Q1VUV2UW80K3FGNllS?=
 =?utf-8?B?ZnVCODVqQUd3VWlOa2UyN25BWlpZMnV1dFZJQWtuTm80cU1MZUQwVW83NnFV?=
 =?utf-8?B?WHdBd281ZDhPbUc3c1ZBZUE4VzBwaVFLMk1CcnhwWkdvQ1BQQnVGUG1Jd3pN?=
 =?utf-8?B?bWtDQVpta2phQXA5ZXZuNGhDSjRmMGl3SWl3VDhsYjhrK081V053ZXd1N2h1?=
 =?utf-8?B?bnRTM1RHb1ZEbEVLZ1NHUnFqczlPKyt2RjloNWYzTFpDL29YQTN1OEFlTzFQ?=
 =?utf-8?B?djdSOEtqQXNhd3FabHZUMlo2Uy9Sa1hvYXh2djZSMStGRERFRkpTTWtDVkNF?=
 =?utf-8?B?MmgrVnBvM3Nsb0NVbHU5M01mU3hTaExNM044VlhtcW1CUjVRVm5JQlkzK05Y?=
 =?utf-8?B?UXVWTWtYeEx6T3dudG85TDdIazd1SUMvaVpOUmlZbTg0VlZTWXlwOUcyajls?=
 =?utf-8?B?eEVDY0oyZkpOMEFwdlJlQkV5b0RjamtQNklEOC9JOHRWYi9VL280U0UveGZs?=
 =?utf-8?B?cWpOMkU3STdqL0l1RzB1WkRoQWdxYWg0QTBZOVlXYjlKL2thbzltbTBxVngv?=
 =?utf-8?B?ZGE3ZEJDMWd5bXMveGgzYm9Ja2Z4aW83S2wrbDVJSkd2cS91WHRxN2tKZU9z?=
 =?utf-8?B?TlpJUElPdTJ1eDJsSlkrNkdsU21CeS9oQ2NvcWNxTUgvY0hQSkJqbk9hTUxY?=
 =?utf-8?B?N1lDQWpjVm14U0NXUnViQUZ3TWFrb2c2cmRWTUhqc1k4UUVCaGt1aVcvNTJO?=
 =?utf-8?B?cHp0RDJadi9uVElBWXRxYytuZmhyLzNUTGpRTURxK09JcHZQUUdQa2dYQUlF?=
 =?utf-8?B?c090MVFza3pwUllOTnhiYmwvWURtZWlCZ3FpWnRpYW5qVThSK2pETjhCb3FR?=
 =?utf-8?B?SUpxajM4QUJacHdhS2RxM0J1UStjU3ZrWWNBcjY2WFRZQWRHYlB6QnllNmJH?=
 =?utf-8?B?WE9NOFdqaXR2NjlNRS8zMFFMRUtxUGQ3YVRLRGE0L3k5MXVOU1dRRXprMmdL?=
 =?utf-8?B?ZmQ5eFZSOE1mZ0hEZldwRkJRMmFub29GdGtVYkJYbkM5NndWSTR6dFdFSXlI?=
 =?utf-8?B?ZnhHZnlNNm5zZFlXZFluUy9YUWxWZTdhbEpMUlNqQmRSb3pqSnR1eVk3dnFN?=
 =?utf-8?B?TEswL0xuR3JNM090ZDFtSjVGSUxGV3Rac2E3dkNXSVorUE9lazhLTHFJeWdD?=
 =?utf-8?B?ZnNvSkJiZzZlb2Rzb0hsM1BXYWFsaDdkbHRPSHA3Z0hkNUovVnFTL2JxTkxQ?=
 =?utf-8?B?QXNkY3ZCZDVjdEx4S1UxdktjazFGaDFFV3J6Y2lKZ1BUemNJTXIrajRwQVNS?=
 =?utf-8?B?NlZPWjdzdGlqK1JNUzZydGIvNFhkMnV5TkNFb3pieEkzd2ZnSjJCWXFhdDRu?=
 =?utf-8?B?VkRIUnEwS0QzRkRqRnU5SEVpakpwZytyVHJJMXRkSFFmdGx0bGsrOEM5M2t3?=
 =?utf-8?B?YkxMYTRkRWJTSmVNQkg4TkMycU80RzVmNXp5Vm9Pb1NDZ3lUT21CaHNVMlVx?=
 =?utf-8?B?UDFndERYaXRSSGlxRG5HNDhGRTBSeE4vbW4yemx0QmsvalFrejBJU2NwenI1?=
 =?utf-8?B?ZlVGTThHUzl2cGlId0FWOVZBMHBzb3N3TmFPTERZV1ZzZXhvMitCK3hUeGph?=
 =?utf-8?B?YTZiNDFIU3RqRmc2S3NzcmFTTzFWYldnSTVudDIvdHBmb0dCZnRhaWlLL1N2?=
 =?utf-8?B?NkNjOU9MWXZpNlRSaXhuanRlekRDNjBPRU9FWWkwWitGWE9GbEJERlBaZTg4?=
 =?utf-8?Q?5j54NX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:05:17.3302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f954d58-726d-4b4d-6f48-08ddc2e7d801
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301



On 7/14/2025 2:43 PM, Michal Swiatkowski wrote:
> On Mon, Jul 14, 2025 at 08:39:40AM +0300, Tariq Toukan wrote:
>> From: Lama Kayal <lkayal@nvidia.com>
>>
>> IPSec hardware offload in legacy mode should not be affected by the
>> steering mode, hence it should also work properly with hmfs mode.
> 
> What about dmfs mode? I am not sure, if you didn't remove it because it
> is still needed or just forgot about removing it.
>

It is still needed.
We support packet offload for all steering modes in legacy, and only 
dmfs in switchdev. This is the logic we added before:

             dmfs    smfs
legacy       Y       Y
switchdev    Y       N

Now we support hmfs. It is the same as smfs. So the table becomes:
             dmfs    smfs   hmfs
legacy       Y       Y      Y
switchdev    Y       N      N

Instead of adding "mdev->priv.steering->mode == 
MLX5_FLOW_STEERING_MODE_HMFS", We removed "mdev->priv.steering->mode == 
MLX5_FLOW_STEERING_MODE_SMFS", and the code is simpler and clean.


> In case it is ok as it is:
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>

Yes, it's ok. Thanks for the review.

Jianbo

> Thanks
> 
>>
>> Remove steering mode validation when calculating the cap for packet
>> offload, this will also enable the missing cap MLX5_IPSEC_CAP_PRIO
>> needed for crypto offload.
>>
>> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
>> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
>> index 820debf3fbbf..ef7322d381af 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
>> @@ -42,8 +42,7 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
>>   
>>   	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload) &&
>>   	    (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS ||
>> -	     (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS &&
>> -	     is_mdev_legacy_mode(mdev)))) {
>> +	     is_mdev_legacy_mode(mdev))) {
>>   		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
>>   					      reformat_add_esp_trasport) &&
>>   		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
>> -- 
>> 2.40.1
>>
> 


