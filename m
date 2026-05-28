Return-Path: <linux-rdma+bounces-21455-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ1kKkuQGGrWlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21455-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:58:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F35F6C53
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7230B3041AAA
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1A330650;
	Thu, 28 May 2026 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUBakf//"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184232FA3C;
	Thu, 28 May 2026 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994619; cv=fail; b=c7PMbcav4GToJ1/jvHPwBz6nNtYuNok7doqjoVfTLP7SX7qLv1fXkE/L1RSX3yaYYLgdSXDR70VqSWm4Om7uPTVDg7cRzMGyiGMBuuj8JkjfgbICin/+tt8GYtI1uMZwZsbvSMR7D6tFRnAbVzw3jwBSLG5Le9nAopht3pkYhl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994619; c=relaxed/simple;
	bh=byCxj8zg7B563lSKK1Yy6vk0BF/dtIHqK5s8ZCO2B4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r2lxe8k4zY3ig0HH/wqshbR6lAxVM1YWi/HInYluIHDk8HSmUUYRAF2Ps3IZWOV0j5bfYaMJQej1VybX4Xj9wYSwep4W+TiltJv65aSuyls15hlnmfpaHaBIT46H2RA9qfgiPATQs10v9Pr3Z07Fri+XaaIUSPXlW5EWQFndQeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUBakf//; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipMp6o+Zrssw7eVjD13LGTYc2mJc8UruzsDe1le1tkyyTvxyF2jbLLPiGlrPAgu0A/AAzUexHYp8TKSQpxI4ldpGgtP/brtTVhSx2RvOwxkJBMjKPmKGeBVQP3aX/AETSC2vT3qjUbFhQ6LHnkL6IAFDjhMdXXB+w8tW802QxwjfH+Ujo+Hmt3wm+QdPBYF0/Mhwlv+fMbF+IjxrdZFbdOEBX8JKOuw9i8JTcCcx32Cu/v6iThotH5Uji8A5Zky1UZUuyW3Fe7QTwt4WyloCvNmcc+AF7l9OVPgQBrLTOMwpuGZigRcTlFRhyQBTijfsKNtFCvUW9Tx72BVQM17Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKQCmPuNnawXu17GwSOfUtE8l9xB/mXyozMMhaq0zCo=;
 b=NtT+i3XMPQ2xT21pVn5WOD0hjn+ChsHo7TCqJU94Ji5dX/zyuVJSyTjlQQPdjHIOlfExfc5vZPoTGo7/PiTwTKy2W2exXeDhVrPspS3W6ogksSuDJYTQac0wdlxlej52E5qZAC5za5MbtEUaS4fa2E+BqyCRjQuqI10afq987JfKhMak2hPIR6KqGLpnOSyo9/TW+tX3G3spzpoaCCec5guPpVtnwJtOpbpwASBe4kH0AaKOerFJu2RoTydbrCbDstvpXjBqCKnGW5T/FaeMRMwll+ykA9t1TYRMrAiNDG0dUUSEv5Okp5D3TgoqUV+BwOMEootv6kHJsoKmqajfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKQCmPuNnawXu17GwSOfUtE8l9xB/mXyozMMhaq0zCo=;
 b=YUBakf//wtdcrL9LPyVMiOxpfo1gW4WvekGfRs+oawLX9s8M8iWnqJoMwSx3R29a83ttLEX7JLkFydwA/R16yyC2M5Tdp3HcXc+tAcy8bLc81HgMuQic5OlavteN6ATjYsdspFA3INvhqJ8eTncoaGjRSxU/0ldRZGKgpSJ2wkxvwYmeZm9VellXe0+GWyg/lGe9pl3PpG3qwchs6umSTmfZdl6d41tdC1GumOEUfG6LmJNeEzo6DBPL5DmWpnNxozLGzahO2Yl5bTDG8aHq9yvitoCOAoOStFTFYo17MZjNYPZYFGEWF9BraAw3d8uo2Ii5mUq6KCeHh/IqE+nSeA==
Received: from IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::14)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.13; Thu, 28 May 2026 18:56:45 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::69) by IA4P220CA0001.outlook.office365.com
 (2603:10b6:208:558::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 18:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 18:56:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:56:22 -0700
Received: from [10.125.202.189] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:56:15 -0700
Message-ID: <ded7826e-ac60-4350-9e21-654344fb9c4c@nvidia.com>
Date: Thu, 28 May 2026 21:56:13 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/13] net/mlx5: LAG, prepare for SD device
 integration
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
 <20260527125427.385976-6-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260527125427.385976-6-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: f8206f80-01ca-481d-8ecb-08debceadd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|18002099003|22082099003|11063799006|6133799003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	Buo1+I9V/2A7Bz/patqe0odu2yp5BT64b8g+3bn/UDHGFR5KQe3mi7aVqlb+gguYy09jwyjpaKfiH9aAu+NMVEfVAHAUz0F5dvr6Aj/wjvbSRDFbQCdJJGNhxDg8ntoK46RT+/VvmM1QF4JS4hOghawOi1avIecR/8JwYSFYKFhW1ZRR/AEd+sTWFgJoVBLNQHu6tAoIVTUwEAHGKu7nO2v21croU2k+TZsCxqoTRa0jP+YTHYfQHKnwCRce3+y1x1ysNNOFxElitv5LBe4+uL6sa4Tmfq5eVIaHUVQptc1GGRl5PjFwBE7ctCsuSFS5D9Yr962clhefjHCpI+/Br65AjWT89Niv6K/2wwr5qaN8Igy19pBcqoVeZyqJNPqUuiDyktVyqurtYUSzFcciYK99bc6HATMgZN8+0oTshHc0RZ5Uyb7dBr+GG5VcxIQ478s2rUwHztjBuGufIB7TjRg6beZu/L3BayOn3ngMyYEE8tPfS12ljrofSDOrJq1DJ6cNUcl1GNMvbxi9/1Vm5JSyJSdC1p1xnwJgyLyYX7N1yVkl0PLuF820H0ofcwDI+Keiz7aM8EYcj1s+ZZLTfx2o2hxCNYrPegr/RCD41OoEFCD4OOHnyjWLwJFerRA418yeCjE9z3Bs9PzNSTeGfi9CHjWr5g2DQR0KxiNJecZ6R4bvvay73qD0Qdu67AfXXZVaCXR1HaqRGRIKu9CseWQPs9bCYDAx5JweraHtGso=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ioShHpplxL6hz2NX71dpdd6ncuLH1OpzR2lq+5TQJ2ZWVAOJBE1Koe6gop7EXVw3R5Dv8ykDSwfsxS1OUCIoM4gOdKePV3LsdaLtv04Io1/t/xnh2+6Xb41Ihhr3YFp1Zp9nOPOOzXaTKbXqF3WIGlNF1s6+2rXeVUGC9U3U9+gfOyN6AdbdGVR62LowXVqYUBp/X5gQRTwsFrZrSqcTDXLLvOaG40BJ2ZLpv3yUZKlzbpBHBqFNmcUsMu17dR7AXn4DHx/QvMFwFD3bn76tTq52rV63Uc/k6HD6HMxcSgP3t72bKBI0gFw/PbHzQyM1fkshOUb6n40xraFKac/S2s4te4JU8osgoaZMGKJGe73MT9TALAmmlwYp9yKQEmTMY7NPdFhZhkC3c4+q8FGBv/HbEznnrf7xrmc7enpBNetywosWBNGcN8nDQsLt4SR7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:56:44.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8206f80-01ca-481d-8ecb-08debceadd16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21455-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 008F35F6C53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 15:54, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Socket Direct (SD) secondaries devices will participate in LAG, even
> though they are silent. SD secondary devices share the same physical
> port as their primary but are separate PCI functions that need to be
> tracked alongside regular LAG ports.
> 
> Extend lag_func with a group_id field to identify SD group membership
> and introduce a unified iterator that can filter by group. Add APIs
> for registering SD secondary devices in an existing LAG.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 59 ++++++++++++++-----
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.h | 53 +++++++++++++++--
>   2 files changed, 90 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 5dfdd799828f..03cb02c7000d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -242,7 +242,7 @@ static void mlx5_ldev_free(struct kref *ref)
>   		unregister_netdevice_notifier_net(net, &ldev->nb);
>   	}
>   
> -	mlx5_ldev_for_each(i, 0, ldev) {
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
>   		pf = mlx5_lag_pf(ldev, i);
>   		if (pf->port_change_nb.nb.notifier_call) {
>   			struct mlx5_nb *nb = &pf->port_change_nb;
> @@ -391,7 +391,7 @@ int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
>   	if (pf && pf->dev == dev)
>   		return 0;
>   
> -	mlx5_ldev_for_each(i, 0, ldev) {
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
>   		if (i == master_idx)
>   			continue;
>   		pf = mlx5_lag_pf(ldev, i);
> @@ -1034,7 +1034,7 @@ static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev)
>   
>   	lockdep_assert_held(&ldev->lock);
>   
> -	i = mlx5_get_next_ldev_func(ldev, 0);
> +	i = mlx5_get_next_lag_func(ldev, 0, MLX5_LAG_FILTER_PORTS);
>   	if (i < MLX5_MAX_PORTS) {
>   		pf = mlx5_lag_pf(ldev, i);
>   		devcom = pf->dev->priv.hca_devcom_comp;
> @@ -1482,7 +1482,7 @@ struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
>   	int i;
>   
>   	mutex_lock(&ldev->lock);
> -	i = mlx5_get_next_ldev_func(ldev, 0);
> +	i = mlx5_get_next_lag_func(ldev, 0, MLX5_LAG_FILTER_PORTS);
>   	if (i < MLX5_MAX_PORTS) {
>   		pf = mlx5_lag_pf(ldev, i);
>   		devcom = pf->dev->priv.hca_devcom_comp;
> @@ -1965,8 +1965,9 @@ static void mlx5_ldev_remove_netdev(struct mlx5_lag *ldev,
>   	spin_unlock_irqrestore(&lag_lock, flags);
>   }
>   
> -static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
> -			      struct mlx5_core_dev *dev)
> +int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
> +		       struct mlx5_core_dev *dev,
> +		       u32 group_id)
>   {
>   	struct lag_func *pf;
>   	u32 idx;
> @@ -1985,8 +1986,14 @@ static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
>   
>   	pf->idx = idx;
>   	pf->dev = dev;
> +	pf->group_id = group_id;

Sashiko.dev says:
"Since xa_alloc() was called earlier in this function to insert the
newly allocated pf into the XArray, does this publish the entry before
its fields (dev, group_id) are fully initialized?
Concurrently, if userspace adds a TC rule on the primary device,
mlx5e_tc_add_fdb_flow() iterates over all devcom peers. Because the 
secondary
device is added to devcom before being added to LAG, the TC thread will 
invoke
mlx5_lag_get_dev_seq() on the secondary device."

At mlx5_ldev_add_mdev() time the netdev hasn't been registered yet,
so userspace cannot reach this device — no TC rule add.


>   	dev->priv.lag = ldev;
>   
> +	if (group_id)
> +		return 0;
> +
> +	xa_set_mark(&ldev->pfs, idx, MLX5_LAG_XA_MARK_PORT);
> +
>   	MLX5_NB_INIT(&pf->port_change_nb,
>   		     mlx5_lag_mpesw_port_change_event, PORT_CHANGE);
>   	mlx5_eq_notifier_register(dev, &pf->port_change_nb);
> @@ -1994,13 +2001,13 @@ static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
>   	return 0;
>   }
>   
> -static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
> -				  struct mlx5_core_dev *dev)
> +void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
> +			   struct mlx5_core_dev *dev)
>   {
>   	struct lag_func *pf;
>   	int i;
>   
> -	mlx5_ldev_for_each(i, 0, ldev) {
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
>   		pf = mlx5_lag_pf(ldev, i);
>   		if (pf->dev == dev)
>   			break;
> @@ -2035,7 +2042,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>   			mlx5_core_err(dev, "Failed to alloc lag dev\n");
>   			return 0;
>   		}
> -		err = mlx5_ldev_add_mdev(ldev, dev);
> +		err = mlx5_ldev_add_mdev(ldev, dev, 0);
>   		if (err) {
>   			mlx5_core_err(dev, "Failed to add mdev to lag dev\n");
>   			mlx5_ldev_put(ldev);
> @@ -2050,7 +2057,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>   		return -EAGAIN;
>   	}
>   	mlx5_ldev_get(ldev);
> -	err = mlx5_ldev_add_mdev(ldev, dev);
> +	err = mlx5_ldev_add_mdev(ldev, dev, 0);
>   	if (err) {
>   		mlx5_ldev_put(ldev);
>   		mutex_unlock(&ldev->lock);
> @@ -2187,27 +2194,47 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>   	mlx5_queue_bond_work(ldev, 0);
>   }
>   
> -int mlx5_get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
> +int mlx5_get_pre_lag_func(struct mlx5_lag *ldev, int start_idx, int end_idx,
> +			  u32 filter)
>   {
>   	struct lag_func *pf;
>   	int i;
>   
>   	for (i = start_idx; i >= end_idx; i--) {
>   		pf = xa_load(&ldev->pfs, i);
> -		if (pf && pf->dev)
> +		if (!pf || !pf->dev)
> +			continue;
> +		if (filter == MLX5_LAG_FILTER_PORTS) {
> +			if (xa_get_mark(&ldev->pfs, i, MLX5_LAG_XA_MARK_PORT))
> +				return i;
> +		} else if (filter == MLX5_LAG_FILTER_ALL ||
> +			   filter == pf->group_id) {
>   			return i;
> +		}
>   	}
>   	return -1;
>   }
>   
> -int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
> +int mlx5_get_next_lag_func(struct mlx5_lag *ldev, int start_idx, u32 filter)
>   {
>   	struct lag_func *pf;
>   	unsigned long idx;
>   
> -	xa_for_each_start(&ldev->pfs, idx, pf, start_idx)
> -		if (pf->dev)
> +	if (filter == MLX5_LAG_FILTER_PORTS) {
> +		xa_for_each_marked_start(&ldev->pfs, idx, pf,
> +					 MLX5_LAG_XA_MARK_PORT, start_idx)
> +			if (pf->dev)
> +				return idx;
> +		return MLX5_MAX_PORTS;
> +	}
> +
> +	xa_for_each_start(&ldev->pfs, idx, pf, start_idx) {
> +		if (!pf->dev)
> +			continue;
> +		if (filter == MLX5_LAG_FILTER_ALL ||
> +		    filter == pf->group_id)
>   			return idx;
> +	}
>   	return MLX5_MAX_PORTS;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index 23c0457ce799..70baa7997364 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -15,6 +15,13 @@
>    * Note: XA_MARK_0 is reserved by XA_FLAGS_ALLOC for free-slot tracking.
>    */
>   #define MLX5_LAG_XA_MARK_MASTER XA_MARK_1
> +/* XArray mark for port-level entries (excludes SD secondaries) */
> +#define MLX5_LAG_XA_MARK_PORT   XA_MARK_2
> +
> +/* Like xa_for_each_marked but starting from a given index */
> +#define xa_for_each_marked_start(xa, index, entry, filter, start)	\
> +	for (index = start, entry = xa_find(xa, &index, ULONG_MAX, filter); \
> +	     entry; entry = xa_find_after(xa, &index, ULONG_MAX, filter))
>   
>   #include "mlx5_core.h"
>   #include "mp.h"
> @@ -50,6 +57,8 @@ struct lag_func {
>   	bool has_drop;
>   	unsigned int idx; /* xarray index assigned by LAG */
>   	struct mlx5_nb port_change_nb;
> +	u32 group_id;        /* SD group ID, 0 = not SD */
> +	bool sd_fdb_active;  /* set on all SD group members */
>   };
>   
>   /* Used for collection of netdev event info. */
> @@ -125,6 +134,20 @@ mlx5_lag_pf_by_dev_idx(struct mlx5_lag *ldev, int dev_idx)
>   	return NULL;
>   }
>   
> +/* Find lag_func by mlx5_core_dev pointer */
> +static inline struct lag_func *
> +mlx5_lag_pf_by_dev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
> +{
> +	struct lag_func *pf;
> +	unsigned long idx;
> +
> +	xa_for_each(&ldev->pfs, idx, pf) {
> +		if (pf->dev == dev)
> +			return pf;
> +	}
> +	return NULL;
> +}
> +
>   static inline bool
>   __mlx5_lag_is_active(struct mlx5_lag *ldev)
>   {
> @@ -214,20 +237,38 @@ static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
>   	return true;
>   }
>   
> -#define mlx5_ldev_for_each(i, start_index, ldev) \
> -	for (int tmp = start_index; tmp = mlx5_get_next_ldev_func(ldev, tmp), \
> +/* Iterator filter constants for mlx5_lag_for_each() */
> +#define MLX5_LAG_FILTER_ALL   0        /* iterate ALL devices */
> +#define MLX5_LAG_FILTER_PORTS U32_MAX  /* iterate ports only (XA_MARK_PORT) */
> +/* any other value = iterate devices with that specific group_id */
> +
> +#define mlx5_lag_for_each(i, start_index, ldev, filter) \
> +	for (int tmp = start_index; \
> +	     tmp = mlx5_get_next_lag_func(ldev, tmp, filter), \
>   	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
>   
> -#define mlx5_ldev_for_each_reverse(i, start_index, end_index, ldev)      \
> +#define mlx5_lag_for_each_reverse(i, start_index, end_index, ldev, filter) \
>   	for (int tmp = start_index, tmp1 = end_index; \
> -	     tmp = mlx5_get_pre_ldev_func(ldev, tmp, tmp1), \
> +	     tmp = mlx5_get_pre_lag_func(ldev, tmp, tmp1, filter), \
>   	     i = tmp, tmp >= tmp1; tmp--)
>   
> -int mlx5_get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx);
> -int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
> +/* Convenience wrappers - keeps existing behavior */
> +#define mlx5_ldev_for_each(i, start_index, ldev) \
> +	mlx5_lag_for_each(i, start_index, ldev, MLX5_LAG_FILTER_PORTS)
> +
> +#define mlx5_ldev_for_each_reverse(i, start_index, end_index, ldev) \
> +	mlx5_lag_for_each_reverse(i, start_index, end_index, ldev, \
> +				  MLX5_LAG_FILTER_PORTS)
> +
> +int mlx5_get_pre_lag_func(struct mlx5_lag *ldev, int start_idx, int end_idx,
> +			  u32 filter);
> +int mlx5_get_next_lag_func(struct mlx5_lag *ldev, int start_idx, u32 filter);
>   int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
>   int mlx5_lag_num_devs(struct mlx5_lag *ldev);
>   int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
>   int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
>   					bool cont_on_fail);
> +int mlx5_ldev_add_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev,
> +		       u32 group_id);
> +void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev);
>   #endif /* __MLX5_LAG_H__ */


