Return-Path: <linux-rdma+bounces-18950-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBpUNJrIzmmtqAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18950-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 21:50:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927738DCB5
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B147303E4BA
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF33ECBDD;
	Thu,  2 Apr 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iz0gfrbC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55112372EEF;
	Thu,  2 Apr 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159407; cv=fail; b=SFRk0Pb3ZvVxNeqzN2KpeOx9CE2DRoTZy6bl1ISjkPNReV9+mAFGb8+Hesc7AVcG6/h0U+8FqrweglW+zDeczm0zXTa4z97g2MAE+qQT22UG0beEXoGjQP1m5q/z3qAlnpmEeRW5xzAn6wvWOQHWGHq5PHfXUwR00XU8NGOKpus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159407; c=relaxed/simple;
	bh=FP8ukfp6NsKB1o/vw5kzHJcwvwu9wJNM0GwU2w4+EiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZQpXMCZarWn/Y4qDhsRNdsIBAr+FUCH4f2dHTXv1VZrXwBBluFV0j5NgKLrTeLxzbcU0cL0j5GfECkwL8BWOwkiy6CFfYRmsnKwDTO17MTIUotFUPNRrXM9R2g4ZWNdwDQ4v3hV25mvxRAN+7K2u6uyUmjfzprSzUkT+60XpKTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iz0gfrbC; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfBQTDQRUiUhMWqHu5TfLvELG7uQXun1HqokyAIZ/aOshhGNGOpEoLzzqlYChD0C/UMmKUj+2dC9LLaIw1gE2rrTdiE7oHGdWgykHVm++XMHBxEdKUiNrWx0qBSQTbrB7B1S5sjCZUuVPaz1y1O3vV2etCqnuV940dilCfnBGtAdQ56JpyPtYN0XRKdblyMYEXq6jBy36ov+aRwgVY2RbI/5Xx3+LG8Jt4emymxz1xkOxxVzWP8V5NL2CpA7SXjMqf/ylbj6rG1n9e3ovgYohip9bzH8cRUcrVdHOUt3QlNSP7S55QyaX2p3RvMoqraYNIkSbrhH4+iyjeEnSBE+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmnBaRhO1z61QHrJ7qTMivnzXVIEB6d5s9cMxBZL6dM=;
 b=SmM9ptQPCRfB2VM6o2wD4XA6q4Z530H9xApwdhsJ6410dYjdsefG3k5S+R8H34pjPTv/Np3ycgjK20TiVxyMP4xgQeK8WAx6ykdBnWM3bLe7jHE3IUmg3deUz+FtMhyimCnJOC8q/lGjK1zJgiQ85So6V1KxJKU2dDfin/+FHfCvG6Y0uVhIQzVccFdCyAv3tMmC0IgOgru/sJtMX6QgZ1XwMDN/ZXnQIawhxZQAAV+1vSGgMTXEX0lw82HuqhrTAoGAKm+/OtWDycJCD8Hu2ldGDjOQqGeJRJp1FVOSYlcP0TPdWVg3oK7bOM61auorMqxtUpIlotcWp4Z1shQHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmnBaRhO1z61QHrJ7qTMivnzXVIEB6d5s9cMxBZL6dM=;
 b=iz0gfrbCfZreSFcSD/p3Y6WPiXpTi6adr9AerI7t6vHqWrQQS+iu/Pia7hjab504VRJFYT6yJj7aJDhNHjygqWSyJMbDWyj4AmKPKASJKL81nXeUngSE9Rvw6u+FFU2Bmpxiem/NiS61bX+6xQW1D3LQAOW7srLwa7+VlBxumg4Z2BfQ5Bv6Wr49twdd4c7WxxpciYEeNyhlICCLBUeHjIoieGkxuJkpvvFZlS8I9rriSyAgv81NML+MzLA6akb5WBRjOf795d/oAsAF328XhZyh+VG1xIWXWiUl0DT0KhHaDmiacuugek2eXSNJeoj35TPY/E3ZD1Kz+Y2HNYYRuQ==
Received: from BN8PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:d4::27)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 19:49:59 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::f1) by BN8PR04CA0053.outlook.office365.com
 (2603:10b6:408:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 19:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:49:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:49:44 -0700
Received: from [10.221.201.51] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:49:38 -0700
Message-ID: <526b3aa8-f601-4e6d-a1f4-16ec6501eaa5@nvidia.com>
Date: Thu, 2 Apr 2026 22:49:35 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net/mlx5: SD: Serialize init/cleanup
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <mbloch@nvidia.com>,
	<leon@kernel.org>, <horms@kernel.org>, <kees@kernel.org>, <parav@nvidia.com>,
	<phaddad@nvidia.com>, <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260330193412.53408-4-tariqt@nvidia.com>
 <20260402030914.878606-1-kuba@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260402030914.878606-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e97d1c-8ac2-4a93-0bad-08de90f105ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xb5FhbBPcC2nN+ebOp3OWdxsrFZuKXeasU1biCKkKqKn9ATUdqGDFANtQr+NK6dMrmpdBHRcihnMSPoTw/OsbuVnqw9GtvHcW1/OiiWZhqN53eU5Ss/THgEKaDSC6uQ7H9SlL5cYX4BGb2Rn7kEpSWUJYyGy3HcAUkz8nKcpyuakqX5uxEQGO9kpX0grRyxBFTcm0h7jHLX63D4Lz69WIdsDfr5W9CqyFcH8d8keXFa7l/t9zuYFudeniPT1FhUzx/aBDwsJ2vV8zYQHYzCcCAkcmYfcMctxFLbwKX4ONIEKL/A497pqo4xR+i5Jdu7sy3iHd+BPkLcaDKiHGXemfZySRKde3TygBJ8p4jWfq9vhYtdi7RduRwA7I9enM7i6mTxWtjEN8DkrcyHG7FguJ5yXjRFRUgwN1Yv+RV98qynFb4GElv57aLT53yRnrUyYr/PAvHNP9H9/Wn3zLGC+rFfTf6uYcr3l1s3SGXGFJWFTRXTkpXi7e32/ifQESo7c4qP5IpwKvFCvVrR6fSya/d4LmOar8uCkmbfV7yMnzLIkQmf9js5BEykrZC2rqnoRmlhJxwL13Krdy+bJqd7CxPoXJvc9O3DOMfmcn7waVNQnNNNpf5I62t0cRPfHWRiGhul53LnbGvGbr6OzVZkQ1+TQ5FdZpGeTzT9l4RW2FYNbiI+Sb1Ruk3AELp50xgS3n4urTsPp+cVVpMCpILSCJHlYPvdWLbjZTgKN2auzGIyWA9475gxRgr9xCKYcBF/4FnTcw2POCukW2nZ/UeMNCg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ResU4bUNmXSb6l8GF1gR1nH0cvwIKijzuM9kiWcrqZDnRaAypCKgOhfeJA52yPyGnrZ2S/qmBVlP3K2M9cNVJvzbRThdBNhmyIW2nAl5W5p8tj4TzWRg6ehKOKCL7Rcc8JHsWH+YxMy8kGTNxHkNlM2kM3a9Tf5wF2/zD2lWF9R+hzS/nwD8Vf5ofFYzYYA+GIuLyd+uKkxGTEwkRhd0mTeRytcqEAAoLGFeElProT0XIrKSVn7epDC5VAmFE0mtTsHC7FdLJRf51mCYYydaEWmmhtOfyYFLQMbi8gU9FYFR6UVvpUvVqbl/7t/2Lu8s+0RwE7LR6/Pohkc3Gh2dFES6MwA1VdD8TjVqxOOoazGrgmvWuGS4fCJmnSVt3WI+w8ukXn3KjF5tmf9i5gvE/nrPIfcwd2UTdqTfCtVE1DN1vqeXLa1KHNK7LcfYUsIa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:49:59.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e97d1c-8ac2-4a93-0bad-08de90f105ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18950-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4927738DCB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 02/04/2026 6:09, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: SD: Serialize init/cleanup
> 
> This commit introduces a state tracker and locking around the Socket-Direct
> init and cleanup routines. It prevents multiple physical functions from
> concurrently bringing up or tearing down the SD group.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index 4c80b9d25283..374f27b78fbe 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> 
> [ ... ]
> 
>> @@ -505,11 +520,16 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>>        if (!sd)
>>                return;
>>
>> +     mlx5_devcom_comp_lock(sd->devcom);
>>        if (!mlx5_devcom_comp_is_ready(sd->devcom))
>> -             goto out;
>> +             goto out_unlock;
>>
>>        primary = mlx5_sd_get_primary(dev);
>>        primary_sd = mlx5_get_sd(primary);
>> +
>> +     if (primary_sd->state != MLX5_SD_STATE_UP)
>> +             goto out_unlock;
>> +
>>        mlx5_sd_for_each_secondary(i, primary, pos)
>>                sd_cmd_unset_secondary(pos);
>>        sd_cmd_unset_primary(primary);
>> @@ -517,7 +537,9 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>>        primary_sd->dfs = NULL;
>>
>>        sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
>> -out:
>> +     primary_sd->state = MLX5_SD_STATE_DOWN;
>> +out_unlock:
>> +     mlx5_devcom_comp_unlock(sd->devcom);
>>        sd_unregister(dev);
>>        sd_cleanup(dev);
>>   }
> 
> Is there a race condition if a secondary PF calls mlx5_sd_init() while the
> primary PF is running mlx5_sd_cleanup()?
> 
> In mlx5_sd_cleanup(), the code sets the state to MLX5_SD_STATE_DOWN and drops
> the devcom lock before calling sd_unregister(). At this point, the primary
> PF is still registered in the devcom group, so mlx5_devcom_comp_is_ready()
> remains true.
> 
> If a secondary PF is concurrently probed, could it acquire the devcom lock
> and observe this intermediate state?
> 
> CPU1
> mlx5_sd_cleanup()
>      primary_sd->state = MLX5_SD_STATE_DOWN;
>      mlx5_devcom_comp_unlock(sd->devcom);
>      // Preempted before sd_unregister(dev)
> 
> CPU2 would see this in mlx5_sd_init():
>      mlx5_devcom_comp_lock(sd->devcom);
>      if (!mlx5_devcom_comp_is_ready(sd->devcom)) // returns true
>          goto out;
> 
>      primary = mlx5_sd_get_primary(dev);
>      primary_sd = mlx5_get_sd(primary);
> 
>      if (primary_sd->state == MLX5_SD_STATE_UP) // returns false
>          goto out;
>      ...
>      debugfs_create_file("primary", 0400, primary_sd->dfs, primary, &dev_fops);
> 
> Would CPU2 proceed to initialize the group using the dying primary PF?
> 
> If CPU1 then resumes and finishes sd_cleanup(), it would free the primary_sd
> structure and the primary device. This might leave the secondary PF with
> dangling pointers in the debugfs files, potentially leading to a
> use-after-free on access.
> 
> Furthermore, when the secondary is later removed, mlx5_sd_cleanup(secondary)
> might see is_ready as false and skip the teardown entirely, leaving the
> dangling debugfs files permanently.

Thank, Good catch. will fix in V2


