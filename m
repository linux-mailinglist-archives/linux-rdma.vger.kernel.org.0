Return-Path: <linux-rdma+bounces-10265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F9AB2841
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D311897D00
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F6256C8A;
	Sun, 11 May 2025 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8x/mh5Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59D19C54F;
	Sun, 11 May 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746967956; cv=fail; b=f/I8rMLF8JvsQ4JyaEOL2p193PF9IKw/w+NsTmb4NlWBXpmoa2/0xpF6yLIFazRmju8gWBtsduSWWLJFMGm4AFxzUnH5LwUsgRFsNWBsaNvNuauQu5YXWKihHIClsno4YreYPh8cmYmUKtlUKYZto9lMNUu+iVdpdZ0P6SPw7ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746967956; c=relaxed/simple;
	bh=CD5Ilb8LUdtFeC+3zo9T/GbICM0VsTRQwsXHXoBHmrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BO5nbCaaxlXaLLmMMjmeYGAxEIr6uWpsyvLg6WPckewRpzo+Gl5hE9vxUF4PaI3tcSlHasG4b40asOfdAUn+3v8KU/r8ZCFrvwhKd3vwTcCJeUPixRhiIvKcp1OmNQB9Ou44CF/pOX8D6Aa1lXjQTGxJNpItWT1HkB9c0lD1Vls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8x/mh5Q; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u20Pj0pFmiGfeGbB27ikKe9fV5Jbm/wcfSBWl6jp11HeATFLxdKhAQNewGcViyV/bW7NYyYMV4JFAetluJsg5piKpGZ/ZbA6r+d+aADlmI63hQ8O2T2yYRpUbwSkoby/KcrgZ3GQ29d+oXZQ8B9vWCqY1dUvTSAFuN02MH3PCQqSVB8HYc8HLjAoZt6ZZyrI1XI/fNTa7/H9T6axqgwF5Q+ISl1ePkRGWDQyfmiK2d2NpjoHGmD2lPRsWJl20GIel+4Vmn+LYV9s3/Jg/TLzhlMlzU5msSb9mr70Cdi3ViPI2IxlvhaBehJk/L7dzAQb3yxqQMrPdLRu/txge2Deyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Dhnai3rlBQ/aZc8PwjhymHoOU6uStvR4tNVvvml2ow=;
 b=pp8wDizywdsfeOxd+kapwMUHU95oHRoH+tBe38LhEoT3f8xXKYtBRhwkL/mBsol+24klnqxAm/seTzUZHSuxVgTpVDbzpdJatXnWrxN7FAksfG7Fljug99YG4g8GBkYVkvMmEGPbJriMNR9m0UHZgXG5Z4VBVZB56WIlWaxrcDQevrsyXGPsLTh8zWWoyOD6gLK8yATglt5ZUwbJd0SOrT1DUCF9f+XO9YF9Af9YFTRhUwd0iggQnpilitaQc8eybKd0tYWQymv4fW7+a9402tr7ux7V05XdE70+YW/OMDbCuPl5UY8ACb/wKmvCI3vMPT4BBloJSyNgVfgHapcKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=jaguarmicro.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dhnai3rlBQ/aZc8PwjhymHoOU6uStvR4tNVvvml2ow=;
 b=t8x/mh5QgvuqXyZ5Yo81ggjW7/W/Kw2j44P/fC7UPqPH8rfDtiTsX4rRVEvK/Y1exJ9pPsMslUhREsGN5gTb9VIL6zIzbmvBmQzG+VWNjYZt9EUC1CdxWkNolWOGOynLLzpII+mCjuNkvqAhvIsTWDAtueHs4vX4MPgGIPLMjSuxY4Sd3YE2cnnkc+9SQATIktwhN+dZ5h5FzWdTQKu3s7eq3c9GUxMLNy1xZP+MGkjNreU5X+PUK5xAY68U+LwaET1dO/gLIS0r1Dn2U6sjmBrBbUd22OQCz+amT+D4J6OCyVwOBpMSrpcJ422W3IgjnhO4RaTuhSRcg7+ro4oKsQ==
Received: from BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sun, 11 May
 2025 12:52:29 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0::4) by BY5PR03CA0024.outlook.office365.com
 (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Sun,
 11 May 2025 12:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 12:52:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 05:52:20 -0700
Received: from [10.223.2.16] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 05:52:17 -0700
Message-ID: <ffb70369-e64e-4e2a-8555-c36c6013b32f@nvidia.com>
Date: Sun, 11 May 2025 15:52:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MLX5: Fix semaphore leak on command timeout
To: Shawn.Shao <shawn.shao@jaguarmicro.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <xiaowu.ding@jaguarmicro.com>
References: <20250509064848.164-1-shawn.shao@jaguarmicro.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250509064848.164-1-shawn.shao@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddfaaa1-d941-43c4-01d8-08dd908ab011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MytLWG03V2pkMmlmZ2xnMnZBcG1JRVBmeXQxQXY5VHN0ZWZiMEgyaG9rTjZy?=
 =?utf-8?B?VkR5ajFDYVhpMnlIUGlFVXphdjFla2NmMGduNTVxU29UN1E2SUFpWTNPYmZJ?=
 =?utf-8?B?YVFqSEd1TEF2Sys0TWRjNGdjNDBuL1YreGhyYy9YNkhvK3FwUGduUmRBNFFk?=
 =?utf-8?B?OGZNdzJtSDVlejJIaEF6ZkVTbGxEU3Y5V2ErZ0lKUmkrVnJIaDlXTllhMUZi?=
 =?utf-8?B?Snh5YVNib1dTQk91ckhWcGhzREFnbUhUZVpiZndtN243ZG1aSVlVOWhuQVZx?=
 =?utf-8?B?Rm9lQi9iRFUwSUMzZzhUUTZlTVY0WUNjeHlRdlNOOG1JTmc1SXZ2ZUY4U3FX?=
 =?utf-8?B?a3BTWm1QaVMwb3pRTkk3Umw3cVlHV1pxZzdHOG93UzVVdHV4NFJOSXY2OGtM?=
 =?utf-8?B?eG5wSUdqa2h6NGpaTzVBWlhmdDFtZFFDdFpmbjdOMk4rWGVYZnhsa1dNeWtN?=
 =?utf-8?B?YlF6NEc4RHVFQ0RmeVgrV09zb3ArOGVFZCtOSGpIdUpDcDN4bStvL1lZZDQ2?=
 =?utf-8?B?Tktyd3plTTBlbXRQTlB5anRIUk1PbnRmZEVadktFY3BoU01UUjJPYVZIUHM3?=
 =?utf-8?B?YUpQYytMTWJ1MEJaNThZbnY5cGs2WkhOY2o3Q0dBdWxmV0t3aDlpY0VPK1V4?=
 =?utf-8?B?ZWR4NzUxMjRLbmoyc2J6aTcwK1NrdTVsVi9xNS9MZkR5clk1QXpJQ2NLT3lN?=
 =?utf-8?B?ZEtScXRFUThGQXovM0xyK1lwMjROdnJST2JRa09qaGl6VjI0VWZkTnhTUkNM?=
 =?utf-8?B?V1VVcE5qeEpqckxYYTlZTm8ybjQ1anhiRnlyNjU4dE1JYXh4UzRDQ0JsZ0lp?=
 =?utf-8?B?akd5blVvVlBnbU1lQ1dhWXBWa3RKQURkSlpFVmxOVU1QamNkcHNtWFVnZjNl?=
 =?utf-8?B?cGd6TExIMUpxYW9DYll0MkJmS2RvdEIxWkNJMC9OOUYvU0I3VUQ5MXpNSVRw?=
 =?utf-8?B?QkY2QWlZR3lka3RqMGQvQllFNmc3b0V1Qjk0VHQxSjBXNnRlWkV4d2JXNlJr?=
 =?utf-8?B?aC9lZTZnU0g0OUpocEJ0cVNrbHFKOXFzSUlOMDZ5eXBDUHVFZmFMY1F1SHBH?=
 =?utf-8?B?QTBKMUdzYjVXa1RiNjBUMEx3dmx2QU9FemVRNkJmcURLNVViN0hGZCtOWmVr?=
 =?utf-8?B?ZkR6ckVPeTA1ZjBFc2UyVzhtamNlR1I3Vis5WW5XanUvR05ndlFIWDgrR3Zn?=
 =?utf-8?B?OHhweGJrN21sMTZDeHVQSWVQM0l2SmJWMHBDNWZ3VExJQVJEc1puWmlITlRm?=
 =?utf-8?B?cmh1Z1Z4SmVXc1FRUXlKYlVmV2xJNGJzZTVtL0VHZlJZcmRCTlM5ZDVxamRO?=
 =?utf-8?B?NXdKMlVsQlBPak1yZWZoVTk3TnhacjVTOHI4djZiN1c5cGFmTkU4QXYrTzlj?=
 =?utf-8?B?dXpyYThTUys1bWNjYktYZ096bVFRRkt3THl6bWVTdHU0LzFUVDk0YjNTMDA3?=
 =?utf-8?B?TU9velU2OHFPK2dYaUFXUDQ4UGhNZ2UyL0thdWpEeDhkREw5VE13SjYrUGVM?=
 =?utf-8?B?eXJ6Q3R6RGtUN2VscHIvbDRhQkVtSlY0RWw1Ry9BSy9lMlhwcStob1Z6N1FM?=
 =?utf-8?B?K1lNanZSYlNIV2tlR0pRMWVyRi83blFBVk9KalRieG1XU25zblFZaHFuV3A5?=
 =?utf-8?B?K1dpVkRPSkY1WjZmODV2QXRNa0NJQ2lIazVHdVhqQXJDR3U1N2FQcXR4U2Uz?=
 =?utf-8?B?SnZXV0xJMGNPZ0xmQmR4Z1dNV0YyaWtreDVMVDdCVzZ1NmJINld6cU5KUXhB?=
 =?utf-8?B?VFUxcU5WMklBZExoZm1yZlNkOWdPMjMwNisvUWQwdVVrZzZ3NHdPNjVJd1dO?=
 =?utf-8?B?SThZVTMvclVHemNzV3BjNEdZSjFpb3hrZytnSjRnRWliWTZyclp1dTlKaG83?=
 =?utf-8?B?eVV4aUYvZWtFMlUrNkZuYzVpekc4amMwVUpJaENOZnBpeVhtVk5wcVlXN3Nu?=
 =?utf-8?B?cXZDMzU5c2ZuSnBkMkhTcUlSUThHKzVQaXVCc3B6c1FZVTV2c3kreEMybFNK?=
 =?utf-8?B?N0JJNEZrMHJXRXlZWk9Fa0E0elorRDhXUGFYQ2NSYVVEL3hiTUdUTEM5a3cy?=
 =?utf-8?B?YXdWSm5wTGpJSGNGenNnSVhuTlE1dTFKVnh5QT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 12:52:28.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddfaaa1-d941-43c4-01d8-08dd908ab011
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117



On 5/9/2025 9:48 AM, Shawn.Shao wrote:
> From: Shawn Shao <shawn.shao@jaguarmicro.com>
> 
> Fixes a resource leak in the MLX5 driver when handling command timeouts.
> The command entry reference count (`mlx5_cmd_work_ent`) was not properly
> decremented during timeouts, causing the semaphore to remain unreleased.
> 
> In the current flow, the reference count is incremented but not decremented
> in timeout cases. This prevents proper release of the semaphore.
> 
> Add a condition to decrement the reference count when a timeout occurs,
> ensuring the semaphore is released and preventing resource leaks:
> 
>      if (!forced || mlx5_cmd_is_down(dev)
> 	    ||!opcode_allowed(cmd, ent->op)
> 	    || ent->ret == -ETIMEDOUT)
>          cmd_ent_put(ent);
> 
> This ensures the semaphore is released properly on command timeouts.

We can't release it on command timeout. The firmware may still write the 
answer on the command slot memory, even if driver had timeout.

Note: few lines above in this code, there is a comment "only real 
completion can free the cmd slot". There it will be released:

/* only real completion can free the cmd slot */
if (!forced) {
         mlx5_core_err(dev, "Command completion arrived after timeout 
(entry idx = %d).\n",
                       ent->idx);
         cmd_ent_put(ent);
}


> 
> Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index e53dbdc0a7a1..7f1f6345d90c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1714,7 +1714,8 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
>   
>   			if (!forced || /* Real FW completion */
>   			     mlx5_cmd_is_down(dev) || /* No real FW completion is expected */
> -			     !opcode_allowed(cmd, ent->op))
> +			     !opcode_allowed(cmd, ent->op) ||
> +			     ent->ret == -ETIMEDOUT)
>   				cmd_ent_put(ent);
>   
>   			ent->ts2 = ktime_get_ns();


