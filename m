Return-Path: <linux-rdma+bounces-19564-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAn8I6oS7mkbqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19564-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:27:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73A469F5F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82294300A4ED
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EF736212C;
	Sun, 26 Apr 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvcEqmE4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720D9463;
	Sun, 26 Apr 2026 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210019; cv=fail; b=r5KYGz++9gv2zljNO/Qz72GHbbTjw1g88lvbT8AhKBCXS/xEMyjb8JICkj2CK8rtWxqYjxVR354pPH47D5fnJZYc5Vb3jQujA0o5uGdj1xlmea5l0ggeej7bd0fNORX3vJtdfRDDBS7Kl4LVfmZ30AGhiiSE+JB3d05VBXc8wQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210019; c=relaxed/simple;
	bh=3arWQCQwPX22sTb853Lf+vl5LTrn7vSdD4Cd5eWFSgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eFvafQBqsfUep+59JCVvKsiW4fVKTYsWWKXH+ZcgeuJm70YoROt2qybFok7R75DVFEiGDH003TOaSjMVYryUxo0naXGO5xsJfi7DWNVEaWtkwZCmZx2joES4o45HDOhN8zR8EnK+qJy4decj6IDkzCVcvj3s5IFHFiqk2bxePYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvcEqmE4; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jN/plfZIdK6gBtTVhPuTWBSIHCe1GI4KSuqkbNgLeH0EVyAcFTLb/JxFBdk3ETcpuNFgnhsmlA2sBRm/doRhnWp3p7CkEIlBmBfdSV0A0slZskHEL61yoNvjzxycRdHYF0hiVZEQZtpH752yKKCF9OjKsUkPw6Ba2htfAiHkKdtJcYH24Pm90vsCDWlauPcvaHv5j9SvFR4/Hl7SixRNUvZmDizqyDIGv3ezdtRGW5O9IGzykvBn8OQ3ruzeu6vjdp0p80npa3oiVp9pHrR5zR736nYhSqqkfTMeI2w/zyiBqMHJA7/VR6HSbN0LPfL/VYEGEYKGlnZ0dzd/BK5cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcWRDs+ynGG6AwMKcePkk6SR6NqJAgYRF5uWZMfIc8E=;
 b=u3rlH0ht1HpF1MxCQmktZxUbJUeSJEj10XqUMuLJnkJGDwFLDYOiMKY9uaMCYfsOg27oWQVKRHYf6Em1tjV4/cm0rDGzaRsCrHgJdnkuDopFsFU17zuyLpf8c1nigAtC6gnCtUO+8LiQEDolvmVg7B67piLYbVrIFesjF9ZKD3XTRJg+qz93+OSc1wyFPUW8I6YcfsPC/6mPecLcaQ/YOZIw2kjtlGGdUlQK0kqzNZQTT5Qt3hi5reLVss+Uv7XL6fY69ojVH8mo/dHir+PWk5jH31jjriZQgrW3xDrno7MHjSK5nUVwWwrbJW+8BJQvVGFRZLjZyvmJTKuXrAFg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcWRDs+ynGG6AwMKcePkk6SR6NqJAgYRF5uWZMfIc8E=;
 b=HvcEqmE4t4vx5GfGnm85e3C+3r2BrqBDjNeHP7IKk9hr7SKiKEUDOPhJYweV2yJeyyjpQFy6hdOPSY1AOCFzPazO9xSf0zYs9R8MsKLd+RkxUgVJ98g+BdBXY7l8RgX3hJyHOgdsymgJg2BwjU0SsSJ3rPyQS99T7RgN37VkDFv7HqLjpv1UipsHQMmYENkLITPMtiDTEECcy3l2yiZU2l3xN1+FEELK2uGTJrqe4VZlgqFuEXbTWvNINAOrgPowITZhw73F9Y2y0thccepdq+tjDFpLXzYSheOs9oVmwYwuW48v3JA3WbBjSLFVXQuhSxa/wRtaCJ3NxKLMlE/DMA==
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sun, 26 Apr
 2026 13:26:52 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::5a) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 13:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sun, 26 Apr 2026 13:26:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 06:26:42 -0700
Received: from [10.221.206.176] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 06:26:35 -0700
Message-ID: <f66dfe61-aeb0-472a-8393-c4d28e66758d@nvidia.com>
Date: Sun, 26 Apr 2026 16:26:26 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 4/4] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260423123104.201552-1-tariqt@nvidia.com>
 <20260423123104.201552-5-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260423123104.201552-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcbf6c0-dbcb-460e-7078-08dea3977a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qgdM0EqQg06IZiv2sBPiskbmDShepxlkVtwVQs2Pim5mfPLRzcfgMfxiMB4lzQtp3g9iWCg5fRQIGVllB8FUNfAHS/lcaEtaB4pjkx7lvcGYq0RVl5zqaMEEjS+zItUH3wcLgHjoWIm5sgA+cnPGXUR+0Cjz8dscJ9cy+oM2JEqOYc8TkerSxGK0cRxE9If0DQC1mZc0QMKK8ZQVCIYvpJSAD+frmYBKH/ebM9mMb8N4hOoAeybtQjObInOjY2zsupnvk9jFA6k7aR7USsO+fjKmJuvEpYI7ZfeWtAtXHx9g6YwIpoxOveA/WrGr//eR8dhS7slw5u91gsHEpPnPgPwUf1VLg/DxXgT+r0RQprDyHXAKX/aQqA8SLBL4ZCQSvn6zhbOLdbxZ7Xwz2T+7UCB4lurqn2mbXAstVRpZA/6GaCxxuatbBONXdlvWptct9+jPRvUgfmfVRCf2DxBagJ0G6qP09FF48QurjDR3eIbfl9C2xvz1u4OF2yMpp3OLWBEJ9ju4/5ZTrLx9sndRM5xqkWpmEDuh7IsXW6LpKa0h/EwEQtNBdwYBw0SOjQbXmTZO6nW2xcsiH6/PKwS0vU/R1S4vXkSO+ia5NjyXrEeUjEAZwtm6D2y6rhIfcI5Mp046imG2yrwGrzah4nEVDmJZnwgL6fa74DXkzUYTqS46DuJOmjde4QL+WhM4uinJqn7b9Pm710KFpqm8E0I8kJ3H4gNV3D6VWNbLvF3+UaXMOMuLSyhIVRyVypN+p5LvN5NIEVpSBqDvf8WfCS7BCA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ssW+25ztXBCQxNoC5wzT7fTQ/7H1rzp5priSCa1oS21DLMGXQ+/nxoMzlfPlvPPRHO94iPDEY+mpBMWai4DkMQs9CPQui9SJ2P7SnWRjBHKkt3PnIof+He76upWZjHwOIjxIrPzmajL5JU3kIdGbeJS43T8uIc2WPyjmQaNeatWkS0IuqAsYsSkv8jvWJz7k4TTiHDvvjX9UpWiTMz9I7WoP/tVJLGoVghBMwOHWQEAKIT+uoaKw5jPd/jBwKNZlR4RFeunoiJorNsO0ooW2Z05U4l1nRb6ipJRaDt3gasGKvcewYE3OSwQH/m18Tl1gLZ1tr/6flaled+tQJ/nHNllQm2jZSxRiwc+4Ub4byB3Ka2UGzWoxYkCIMvd/1NymfgieGbUTG67E/beIpL5/IEUPLma4KA9UCPLuT8J2tuodlAwcU+RCkzonZJLzaIqC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 13:26:51.8315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcbf6c0-dbcb-460e-7078-08dea3977a4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Rspamd-Queue-Id: 0B73A469F5F
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
	TAGGED_FROM(0.00)[bounces-19564-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
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



On 23/04/2026 15:31, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> When utilizing Socket-Direct single netdev functionality the driver
> resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
> the current implementation returns the primary ETH auxiliary device
> without holding the device lock, leading to a potential race condition
> where the ETH device could be unbound or removed concurrently during
> probe, suspend, resume, or remove operations.[1]
> 
> Fix this by introducing mlx5_sd_put_adev() and updating
> mlx5_sd_get_adev() so that secondaries devices would acquire the device
> lock of the returned auxiliary device. After the lock is acquired, a
> second devcom check is needed[2].
> In addition, update The callers to pair the get operation with the new
> put operation, ensuring the lock is held while the auxiliary device is
> being operated on and released afterwards.
> 
> The "primary" designation is determined once in sd_register(). It's set
> before devcom is marked ready, and it never changes after that.
> In Addition, The primary path never locks a secondary: When the primary
> device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
> no additional lock is taken.
> Therefore lock ordering is always: secondary_lock -> primary_lock. The
> reverse never happens, so ABBA deadlock is impossible.
> 
> [1]
> for example:
> BUG: kernel NULL pointer dereference, address: 0000000000000370
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 4 UID: 0 PID: 3945 Comm: bash Not tainted 6.19.0-rc3+ #1 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:mlx5e_dcbnl_dscp_app+0x23/0x100 [mlx5_core]
> Call Trace:
>   <TASK>
>   mlx5e_remove+0x82/0x12a [mlx5_core]
>   device_release_driver_internal+0x194/0x1f0
>   bus_remove_device+0xc6/0x140
>   device_del+0x159/0x3c0
>   ? devl_param_driverinit_value_get+0x29/0x80
>   mlx5_rescan_drivers_locked+0x92/0x160 [mlx5_core]
>   mlx5_unregister_device+0x34/0x50 [mlx5_core]
>   mlx5_uninit_one+0x43/0xb0 [mlx5_core]
>   remove_one+0x4e/0xc0 [mlx5_core]
>   pci_device_remove+0x39/0xa0
>   device_release_driver_internal+0x194/0x1f0
>   unbind_store+0x99/0xa0
>   kernfs_fop_write_iter+0x12e/0x1e0
>   vfs_write+0x215/0x3d0
>   ksys_write+0x5f/0xd0
>   do_syscall_64+0x55/0xe90
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [2]
>      CPU0 (primary)                     CPU1 (secondary)
> ==========================================================================
> mlx5e_remove() (device_lock held)
>                                       mlx5e_remove() (2nd device_lock held)
>                                        mlx5_sd_get_adev()
>                                         mlx5_devcom_comp_is_ready() => true
>                                         device_lock(primary)
>   mlx5_sd_get_adev() ==> ret adev
>   _mlx5e_remove()
>   mlx5_sd_cleanup()
>   // mlx5e_remove finished
>   // releasing device_lock
>                                         //need another check here...
>                                         mlx5_devcom_comp_is_ready() => false
> 
> Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_main.c   | 10 ++++++++++
>   .../net/ethernet/mellanox/mlx5/core/lib/sd.c    | 17 +++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/lib/sd.h    |  2 ++
>   3 files changed, 29 insertions(+)


I went over all Sashiko comments on this patch and they are false
positive

> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 9c340ad2fe09..c4cb5369f0a0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6778,11 +6778,14 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>   		err = _mlx5e_resume(actual_adev);
>   		if (err)
>   			goto sd_cleanup;
> +		mlx5_sd_put_adev(actual_adev, adev);
>   	}
>   	return 0;
>   
>   sd_cleanup:
>   	mlx5_sd_cleanup(mdev);
> +	if (actual_adev)
> +		mlx5_sd_put_adev(actual_adev, adev);
>   	return err;
>   }
>   
> @@ -6822,6 +6825,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
>   		err = _mlx5e_suspend(actual_adev, false);
>   
>   	mlx5_sd_cleanup(mdev);
> +	if (actual_adev)
> +		mlx5_sd_put_adev(actual_adev, adev);
>   	return err;
>   }
>   
> @@ -6923,11 +6928,14 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>   		err = _mlx5e_probe(actual_adev);
>   		if (err)
>   			goto sd_cleanup;
> +		mlx5_sd_put_adev(actual_adev, adev);
>   	}
>   	return 0;
>   
>   sd_cleanup:
>   	mlx5_sd_cleanup(mdev);
> +	if (actual_adev)
> +		mlx5_sd_put_adev(actual_adev, adev);
>   	return err;
>   }
>   
> @@ -6980,6 +6988,8 @@ static void mlx5e_remove(struct auxiliary_device *adev)
>   		_mlx5e_remove(actual_adev);
>   
>   	mlx5_sd_cleanup(mdev);
> +	if (actual_adev)
> +		mlx5_sd_put_adev(actual_adev, adev);
>   }
>   
>   static const struct auxiliary_device_id mlx5e_id_table[] = {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 897b0d81b27d..f7b226823ab4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -538,6 +538,10 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>   	sd_cleanup(dev);
>   }
>   
> +/* Cannot take devcom lock as a gate for device lock. ABBA deadlock:
> + * primary:  actual_adev_lock -> SD devcom comp lock
> + * secondary: SD devcom comp lock -> actual_adev_lock
> + */
>   struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
>   					  struct auxiliary_device *adev,
>   					  int idx)
> @@ -555,5 +559,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
>   	if (dev == primary)
>   		return adev;
>   
> +	device_lock(&primary->priv.adev[idx]->adev.dev);
> +	/* In case primary finish removing its adev */
> +	if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
> +		device_unlock(&primary->priv.adev[idx]->adev.dev);
> +		return NULL;
> +	}
>   	return &primary->priv.adev[idx]->adev;
>   }
> +
> +void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
> +		      struct auxiliary_device *adev)
> +{
> +	if (actual_adev != adev)
> +		device_unlock(&actual_adev->dev);
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
> index 137efaf9aabc..9bfd5b9756b5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
> @@ -15,6 +15,8 @@ struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int c
>   struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
>   					  struct auxiliary_device *adev,
>   					  int idx);
> +void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
> +		      struct auxiliary_device *adev);
>   
>   int mlx5_sd_init(struct mlx5_core_dev *dev);
>   void mlx5_sd_cleanup(struct mlx5_core_dev *dev);


