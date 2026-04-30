Return-Path: <linux-rdma+bounces-19780-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIUVNi8j82nIxQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19780-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 11:38:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058749FF14
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C80C93019819
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483113A6B99;
	Thu, 30 Apr 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPCCdW8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019733A5E81;
	Thu, 30 Apr 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541931; cv=fail; b=MYvoi91ypuWy+kdzZPBhESNxTDJ3Vln1yqj4WMXihOir6VFE1dEZxJpJjoVcmLtpr0oJL/b3qQ/akLduJBrApvxUIXfuAg/bzrT107SmLe2102uhE7EhyJc0m4kocQnJj1D2ZRf+lFDgrIfmI2XJuOmdHpS7m7Ukyvw48b2etww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541931; c=relaxed/simple;
	bh=QNmrffibYpEjwPxMmits6zquyZqW4UofHlr+1rKAiHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N4HIgQrq2LIgPPmf7yX5Cer16UyTBzUrwCFyRXphIUGCyKQofKtj3hSiHk9faMFsBxcmd81tHe3fHueothxmQDPjtQxWLN3kXWfhaIaWqe160h6OO+9D9kJVxNV+kPjQQJp/1Bw9OX03nGnSzrjtdTdyp6I9zpzR4xzp5fB/gao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jPCCdW8a; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ4zAlsLHIc8z9GWdDc2vjo6bkKcf41JtykMCTux65VLpXGbhaEORbxke5Q857oW8boNj+dyw4ps0Ld2OdGiFxF1Gy1ryakxSGrUKhCHRsXvFXQOKxvMx0weVzZRTpRlOQ2VI/O8qoHOz7FnIyN1y/TWssatcuzi8yRmhCqAyLpK1VYgaDvbtQknmSubFc5CA+X611RyNfqMEdxLGUWCX/2dsUNuTokY+CWFsH73cAc0Oi0ZzBERaBg60S9qc4QRfAp1hXafANfF0t1r3xOtlXWenK/S4TcF/YdU9uV6HThLb7b7ic0+VeiqOQRV7LF1IW/W06GpUHIZV0FdbbIe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo8oA2A/f2YXESPHSr8fqb54ivwgsE2lX5zQo091J5s=;
 b=iSNaZaCrPW8DgSaSS3PmMu6Lh5vpf+SAcGmHmC//2+0R4FbqTlRJsgc8HJigfGnP7XOTKuNdDVq22nxzqwtJT1wNr29cbCyHeeIEfqehSPPPxVUyg6/JhlUdxoBnngGYIm7v9HWbRmFIxtap3qBk5dZQS8jdjQPA+zJ1YhAxXic58qQ9aMZpQHEP61dbuw8jBh5sukKhiU53gYb/huntliTcfXACYM6HbVVPCoa8aWj75Oi/SxyV2CiJe+o2H7c3/iD07R6KeZ+PCMwljXBb5yH26y/2+IDlFIUwoSa58/Q6QskoIbtzGWGi9q/vPK3E+KYiWGvEtjQ+ihEdJhLt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo8oA2A/f2YXESPHSr8fqb54ivwgsE2lX5zQo091J5s=;
 b=jPCCdW8aOtKrxcAJfzsk4xidgOT238NVa9HOg2u6U6UPzZOWF8f2uGT2K9a2ECIZRTqc66dM63fBay8ANrZPh90pbiqHJjA8C5ewsNsddm+wm3ECaqzrE44EGy4hugFHp1GoGmDdVUjRu9PbmCxseJlYNNSWB+lQqJHBxWcWfexrNR8Y/vEOo0MoPMDI4nhlT8mS9WVEa3x3615J9et6Ornr5wzivmCFpsOb/VG2NP2E22Gkaqcfj3Gd/lsF0sZO8Q5WJN7PpEyvmCLW380VEvHOLt1mKBTQoZz53PhfCtOfKWJs4k2fSiY5Kg2ZRVfDLVwGsHdPtUmovoJjJiSNrw==
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:38:43 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e4) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 09:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 02:38:29 -0700
Received: from [10.242.158.87] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 02:38:23 -0700
Message-ID: <a88d1885-8f78-45ef-9cd6-6949e3d10757@nvidia.com>
Date: Thu, 30 Apr 2026 12:38:21 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V4 1/4] net/mlx5: SD: Serialize init/cleanup
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <mbloch@nvidia.com>,
	<leon@kernel.org>, <horms@kernel.org>, <phaddad@nvidia.com>,
	<kees@kernel.org>, <parav@nvidia.com>, <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dtatulea@nvidia.com>
References: <20260428060111.221086-2-tariqt@nvidia.com>
 <20260430014207.2375703-1-kuba@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260430014207.2375703-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ac5f75-5e3b-47f6-2895-08dea69c44e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CtosCMitrtkwGpZZ4AtG3dnu2W1S2n4bkysRgjwC0icvTEyjbkWbG6UW2siXaBOUA6dC3q2tJ33YhR5i0fspNG4nIjzlXhRWyr/M8SP0PdmkaNhsdz/GkS0+kFd2DSF+CbAfpMJP5pt7LHZi5CqDqhvXgSMOct6DywnbT4DNQeNMGZUhE4crHHp7ac7QnxyE1eERmqzzb7tNF+YaMgKo09CGBqnI+BsjqqNIvnaBuLZoh9+yr/iplDo1k6S298xcys+2E+QDnIambyO1+0BNH6NXqJX+wpxnv0gYbHlET17HUBx12oOcQXBrwjKx9prpNWMYr23x1XJUvF5kNgZ5gekzJKZybvDySJ3j1J9OjJ2EsUnQRfTRam0fkX92XeixwxygOZRRSERhC/P7zxXoIUXy8mppILoppGRkwNQqXTR44bMOvvQ8kT+9UvFEG1U7DOw1y0uchN1BQNLqgRjOkGOV7uBZOmNHt+yb9N0lTEbTmb+5NM3WwdWIKOt2p8P5IflIzaI0wwa98w8DR9E2JZFbEJNS47Vr+6MyhcywdZkAGYGCCaBhRthvG+qDhk/rJ0WI35C09HYwrCEgIzQATsD3lRiCJSOwLtwjNVa1f4di5n5W6FcJlB+Y2WmUw5uYWJiBefV1QeKiiO0cD5nvSxWNOzOiiJNu7y7m9nGmOA1piBjgR9KnlnJ95CpsEmkedANl8CCYH3Hx9NdpjnLYmscuEBHcP3wOW5MA8aHn0BkXYqr0f6Sn/zl4INsrKN6WwhLPtCpuTxyLZx0C3WNvkw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/ywkjYArQIkTpBKYf+DFCXJwHko6LWf+pXxtEL87D0AfPtFr30oGqGyJVDqT8l7gNC93KJpsLUTtWBkbbeWYVvwXbRdmaXWkxi2y9w2ootlAZ0T9BVy6qiia9+U842ZAkcEOyEmtqDgG0LXHpCrW9MoIeG5vW1ZtE5zmK5De0XFxZMfFXfcshyIDYi32il86z9RkrXJjOrYaliZ8O/37IJcq+5riUtRkTPDCz1ZVLQO0ZxsAP6C4motZSOAFiGk/3ypy+lS1//JBdalH/JJg4/XKNRDP0LWEQbW0XAlsFWFLhO9152ehXDIv3UjiUQp5oEDVA3IVxHD261/+uj0I9WzHEQaPzuMdWB+G7O5GZm1Frc2W6PrUvlW2fYwjj9LNYWtloe9NWIrm32tXyPFTUEzX899SNsK16ZgplxTxkdkSAA+tZiHAhbfpVPaqT2p2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:38:43.3787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ac5f75-5e3b-47f6-2895-08dea69c44e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
X-Rspamd-Queue-Id: 5058749FF14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19780-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
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



On 30/04/2026 4:42, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: SD: Serialize init/cleanup
> 
> This commit protects the Socket-Direct (SD) init/cleanup paths with the
> devcom component lock and tracks the SD group state on the primary device.
> It skips init if the primary is already UP, and skips cleanup unless the
> primary is UP, serializing the bring-up/tear-down sequence across PFs.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index 762c783156b4..d42c283cbb38 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> 
> [ ... ]
> 
>> @@ -491,22 +507,34 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>>   {
>>        struct mlx5_sd *sd = mlx5_get_sd(dev);
>>        struct mlx5_core_dev *primary, *pos;
>> +     struct mlx5_sd *primary_sd;
>>        int i;
>>
>>        if (!sd)
>>                return;
>>
>> +     mlx5_devcom_comp_lock(sd->devcom);
>>        if (!mlx5_devcom_comp_is_ready(sd->devcom))
>> -             goto out;
>> +             goto out_unlock;
>>
>>        primary = mlx5_sd_get_primary(dev);
>> +     if (!primary)
>> +             goto out_unlock;
>> +
>> +     primary_sd = mlx5_get_sd(primary);
>> +     if (primary_sd->state != MLX5_SD_STATE_UP)
>> +             goto out_unlock;
> 
> If the device is unbound during the race window where the devcom component
> is ready but the state is still MLX5_SD_STATE_DOWN (for example, just after
> sd_register() finishes but before mlx5_sd_init() sets the state to UP), does
> this early exit leave the component marked as ready?
> 
> Since mlx5_devcom_comp_set_ready(sd->devcom, false) was moved out of
> sd_unregister() and into this function, skipping it here means the device will
> unregister and free its struct mlx5_sd while the group is still ready.
> 
> Could a concurrent mlx5_sd_init() on another peer acquire the devcom lock,
> observe that it is ready, and proceed? If the unregistered device was the
> primary, mlx5_get_sd(primary) would return NULL, causing a NULL pointer
> dereference at primary_sd->state. If it was a secondary, mlx5_sd_init()
> would iterate over primary_sd->secondaries and access the freed device
> structure, resulting in a use-after-free.

This is correct :(
will fix in next version

> 
>> +
>>        mlx5_sd_for_each_secondary(i, primary, pos)
>>                sd_cmd_unset_secondary(pos);
>>        sd_cmd_unset_primary(primary);
>>        debugfs_remove_recursive(sd->dfs);
> 
> This isn't a regression introduced in this patch, but does storing sd->dfs
> locally instead of on the primary device cause debugfs entries to leak?
> 
> If a different peer is unbound first, its sd->dfs is NULL, making the call
> to debugfs_remove_recursive() a no-op. The cleanup then finishes and marks
> the group as unready.
> 
> When the original device that created the debugfs directory is later unbound,
> it sees the group is no longer ready and skips this block entirely, never
> freeing its sd->dfs. Since these files hold pointers to the mlx5_core_dev
> structs, accessing them from userspace after the devices are freed could
> trigger a use-after-free.
> 
> I note this was fixed later in the series by commit "net/mlx5: SD, Keep
> multi-pf debugfs entries on primary", but wanted to highlight it here.

like mention, this is fixed later and I don't see a reason to change the
patches order

> 
>>
>>        sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
>> -out:
>> +     primary_sd->state = MLX5_SD_STATE_DOWN;
>> +     mlx5_devcom_comp_set_ready(sd->devcom, false);
>> +out_unlock:
>> +     mlx5_devcom_comp_unlock(sd->devcom);
>>        sd_unregister(dev);
>>        sd_cleanup(dev);
>>   }
> --
> pw-bot: cr


