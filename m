Return-Path: <linux-rdma+bounces-21920-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gZhtA2BVJWplHAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21920-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:26:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2FC6506B4
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:26:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=GUjPWdYR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21920-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21920-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2D1300F9C3
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8523A1A27;
	Sun,  7 Jun 2026 11:21:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F210303CAE;
	Sun,  7 Jun 2026 11:21:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780831269; cv=fail; b=I/Y++AJW9EQfWQ4Fehlw7DRaDS/N8ouD3lWVP9igDbQOkJ6CBp9P9tEFDkO96OScfBd/TR+Y6ah/6CTtc+Jo/alWzuRm5CK4m6GzVbM5dKD7qk2Unozs43t9qLnQzwTWVxeTugehsF/zkoa+/vX9+tPKo9j4CpopGJI7rJm/0zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780831269; c=relaxed/simple;
	bh=4xOC6a/03KBVSlEuuAUXOtI8ges3LNGo768fwN8kxLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j10dys0L7PfVXvDYCcNLeo0K9+oymY4iX3q48LNhSceXQer3hXzgMwTWEecTfNmYfQgUV/5kZ68nEOhJsx/+kr6w2NrGnZ5UdnlPU5TkeP5nmTTzv806d/FM49iVrtMjrKYOeSaXYOwJXyLMWWqLAcQs7aE3QREPMwcJrgpt5JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GUjPWdYR; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTNiEFGPOO1rhExZcKRZGJWpZkfHekKKliDd155Od5b6zq2avXCzkjXe5SIr84UzVQO3MKOK/NxgJ/kVdv3JI8oQIvdByhH0PDSW/C3xUuvRBg6YRiEYe4zLqeJiiUHDgdmdEof8s3jJgWxweyGnSpeKzRBzgsQZL34K7Bia/XKxaedu7VLfYXShoANYwunODgOYf3l16XJrbH3DQ9icH0wzI1cRK05CNXnqZ/8m22PfD0l9im7b2Gr1B7SL9qMKOrCktYFs/IjeU4M3rglDMSQBa94FAuL2AdLKWsMOP3lHQZmxujlMx+SNB6ky7eu55xBmYatmH2UMvQM1AKsOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNHtdVlJxkliu5J66D6+utyZdOgJ8GyOQmRlGht0I0M=;
 b=SB4SUiZziL3rBWjQprVtgjHVCCfalZ0YUYodh7nmqjtn05fzaF2SAmkEDj7LzY4S9jXtVjAyg30vPKmj9UwotnSK+gVGaxYzpD+acjEeQtjr8dLVQsc3MIEkoVuJYL9PX5L+tST9IJxA1/g5TkbKEi3afzR7EOum0nXsKunu5DDhTVQcw25iQfGDb6SCMGbabOn21hZrBZhYSNS5biqDmHZe3iQZhBA9/NGHaBAztA/7QquoRT2epup3ObkJh2BP1Qk1fcgREA3swCIUACvIM4OzoyeQJR2Lu+B03O3TY0e1ZuifK35K8ZzWgx0dztEspNAKCAlgCZO7RzaSWipCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNHtdVlJxkliu5J66D6+utyZdOgJ8GyOQmRlGht0I0M=;
 b=GUjPWdYRRf6KHMxWFZ6g5zo5YUSPXW9si/UE7TUZFuikd5sy4f2bipCt0S7/aKiNkpNOX2q3kYuzCCrW197dJrFjy4wrapMCvdt0+jAso7od7Amza3ZkkKcxOeEYqJQjEofRqnfsnhhfRRK6xHMocJc40pHVXTTdGFwkvFOu9/Xa6f/rwjExRKRllWxvFgWVWGAtCzjd/Z6ie2C800Xtt+5dKAId6AJuvIhL2GFLEGOdt5IO5ksjiK/q7KyqjMWW7wBxPOLGK7tftbg67wC2bChur15suiFqkUfFBU5Zyy4A9gQ2DUKMKkH1HUI98XcICUXGv9gA0e1o6/qJuNftsg==
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 11:21:00 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::31) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 11:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 11:21:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:20:47 -0700
Received: from [10.125.203.115] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:20:39 -0700
Message-ID: <2f076488-3d1a-4ae1-aa24-e9b80be08ec7@nvidia.com>
Date: Sun, 7 Jun 2026 14:20:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/15] net/mlx5: LAG, add MPESW over SD LAG
 support
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
 <20260604114455.434711-13-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260604114455.434711-13-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5a8416-b703-455f-d708-08dec486da8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	q1t4zPxjoo/Vw3UFfZ2hnh0Lb0MtKSteNS5GoMnil4QRB9kfIgP483DFb7xpZy43o1BH23edPBzf1pOPuwjeLHVx7i3GbDrpRSVnhDC0my3IWOkfak4ZjHvY4/QK9Tix/HIIzfJ0P654S8DC+NNMKHUq3SFUy7N1LIMrP8x3rbYcMmkwg2ymFo9xEZJgbIkPbikCSrZWz1cPKOqAkuExmPEFO15bnzEoz40Hbjo9dJzPUTgNcZ3SujT87dd0NpKgfTbQolYaoHuH4QdTbpQ+zbix5xafrWQhjcZTRdvijzzleiwRKZrKSIBWip0ZjkzkK6fgIKYXqyvw0AXRjZyszXfXjZcVajVRtNv+c4HiWli8n9m5JPTbNIkKQcDJOaOMo4icJQfwhFjZxRIP4uq50zDtohB+9A+bpIS+3WonZr1DdBxE1Npb9eMV+/Xck0GEJo6/1UlxFhRIJJoV/V0e35LnibHsq6a4fYSqM8yTQ23rARgQOK2g1ZGExq2l+++rfyiXlbmfH44wpCWLj9+cI+5qOjV5/YLnZJoZrXrrauti6IkdseZBi15zCcYJK9SWPpo+AOIPfjUW9k/lIZHY99apQLzM0rGLmi1qfMcJtlP2a52AhXc6c1TQs9f8/nus7Y6+pAo0E04PrLmSawXWAJmjeWmVGd+OIn3ILSzI49GIjnL/GY1suSloTG60cTXQJM6gMGnLiKvZIHP8ywRI+Ad0b4bWEXEeRfwIg3NmEgQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AQSBw+GAEiDk7PRW/+hp94W0FdU27DZcW4VTYuFCFiL81jYKaZ3MLk67tZzCTy8xEx3esuskzQI0S7UlTvMSZW9cWEU+MnvRBebkG3SpjKywJb9mZZ5ittPC0VUMTFO73xblpgts9FZpp9wmqycuxT5ASBTvocpyD9mH3U+saqhNY2w9DeEUB7aiYDb4uxls3F9kjyUAy4mOw9nwEy1aTFY3uoCiLGBTV05dOW5RpADxrRke5fcZPnFa3+HoJpAZyioP93xHyBOE0VTcgn3QT9ZmoDAnjNf6shOTjMHuaZ5VHgGrhjlV5nUeUbVveNSA4S+TogYiLiadvnu9yvIym4bhp/eTgTnefuVInHrne43egUXyCUAmOyDTs2DB86RiU6pPIu9ZHxT4QwpO19urFtQdDPEdxlu3KyBakUvXXpzAa5IQtM4iM+jrApvzK2Dd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 11:21:00.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5a8416-b703-455f-d708-08dec486da8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-21920-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D2FC6506B4



On 04/06/2026 14:44, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Enable MPESW LAG creation over SD LAG members, forming a composite LAG
> hierarchy. This allows bonding multiple SD groups together under a
> single MPESW configuration with shared FDB.
> 
> When enabling composite MPESW, the individual SD LAG shared FDB
> configurations are temporarily torn down and recreated when the
> composite LAG is disabled.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  6 ++
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  8 ++
>   .../ethernet/mellanox/mlx5/core/lag/mpesw.c   | 95 +++++++++++++++++--
>   .../ethernet/mellanox/mlx5/core/lag/mpesw.h   |  4 +
>   4 files changed, 105 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 9566fbf59fdb..25a9012e3014 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -2545,6 +2545,7 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
>   	struct mlx5_core_dev *primary;
>   	struct mlx5_lag *ldev;
>   	struct lag_func *pf;
> +	bool mpesw;
>   	int i;
>   
>   	ldev = mlx5_lag_dev(dev);
> @@ -2553,6 +2554,9 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
>   
>   	primary = mlx5_sd_get_primary(dev) ?: dev;
>   	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);
> +	mpesw = ldev->mode == MLX5_LAG_MODE_MPESW;
> +	if (mpesw)
> +		mlx5_mpesw_sd_devcoms_lock(ldev);
>   	mutex_lock(&ldev->lock);
>   
>   	ldev->mode_changes_in_progress++;
> @@ -2564,6 +2568,8 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
>   	}
>   
>   	mutex_unlock(&ldev->lock);
> +	if (mpesw)
> +		mlx5_mpesw_sd_devcoms_unlock(ldev);
>   	mlx5_devcom_comp_unlock(primary->priv.hca_devcom_comp);
>   
>   	if (!sd_devcom)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index 34350b0a7307..3a90d360d724 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -157,6 +157,14 @@ __mlx5_lag_is_sd(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
>   	return pf && pf->group_id != 0;
>   }
>   
> +static inline bool
> +__mlx5_lag_dev_is_port(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
> +{
> +	struct lag_func *pf = mlx5_lag_pf_by_dev(ldev, dev);
> +
> +	return pf && xa_get_mark(&ldev->pfs, pf->idx, MLX5_LAG_XA_MARK_PORT);
> +}
> +
>   static inline bool
>   __mlx5_lag_is_active(struct mlx5_lag *ldev)
>   {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> index 2cb44084e239..50bfb450c71e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> @@ -15,7 +15,7 @@ static void mlx5_mpesw_metadata_cleanup(struct mlx5_lag *ldev)
>   	u32 pf_metadata;
>   	int i;
>   
> -	mlx5_ldev_for_each(i, 0, ldev) {
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
>   		dev = mlx5_lag_pf(ldev, i)->dev;
>   		esw = dev->priv.eswitch;
>   		pf_metadata = ldev->lag_mpesw.pf_metadata[i];
> @@ -36,7 +36,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
>   	u32 pf_metadata;
>   	int i, err;
>   
> -	mlx5_ldev_for_each(i, 0, ldev) {
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
>   		dev = mlx5_lag_pf(ldev, i)->dev;
>   		esw = dev->priv.eswitch;
>   		pf_metadata = mlx5_esw_match_metadata_alloc(esw);
> @@ -52,7 +52,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
>   			goto err_metadata;
>   	}
>   
> -	mlx5_ldev_for_each(i, 0, ldev) {
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
>   		dev = mlx5_lag_pf(ldev, i)->dev;
>   		mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_MULTIPORT_ESW,
>   					 (void *)0);
> @@ -65,6 +65,48 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
>   	return err;
>   }
>   
> +static void mlx5_mpesw_restore_sd_fdb(struct mlx5_lag *ldev)
> +{
> +	struct lag_func *pf;
> +	int err, i;
> +
> +	mlx5_ldev_for_each(i, 0, ldev) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, pf->group_id);

sashiko.dev says:

Does this accidentally activate global FW LAG for non-SD ports?
This loop unconditionally calls mlx5_lag_shared_fdb_create() using
pf->group_id. For standalone non-SD ports, pf->group_id is 0.
Inside mlx5_lag_shared_fdb_create(), passing group_id = 0 sets the filter
to MLX5_LAG_FILTER_ALL, which bypasses the SD-specific single-FDB path and
incorrectly triggers a full global LAG activation via mlx5_activate_lag().
Should there be a check for pf->group_id != 0 or pf->sd_fdb_active here,
similar to the check in mlx5_mpesw_teardown_sd_fdb()?


pf->sd_fdb_active is false here by definition-we are re-creating it.
And this API is already gated by pf->group_id check.
When MPESW is destroyed, all PFs have group ID (if this is SD NIC)

> +		if (err)
> +			mlx5_core_warn(pf->dev,
> +				       "Failed to restore SD shared FDB (%d)\n",
> +				       err);
> +	}
> +}
> +
> +static int mlx5_mpesw_teardown_sd_fdb(struct mlx5_lag *ldev)
> +{
> +	struct lag_func *pf;
> +	int i;
> +
> +	mlx5_ldev_for_each(i, 0, ldev) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		if (!pf->sd_fdb_active)
> +			continue;
> +		mlx5_lag_shared_fdb_destroy(ldev, pf->group_id);
> +	}
> +	return 0;
> +}
> +
> +static bool mlx5_lag_has_sd_group(struct mlx5_lag *ldev)
> +{
> +	struct lag_func *pf;
> +	int i;
> +
> +	mlx5_ldev_for_each(i, 0, ldev) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		if (pf->group_id)
> +			return true;
> +	}
> +	return false;
> +}
> +
>   static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>   {
>   	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
> @@ -92,10 +134,17 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>   	if (err)
>   		return err;
>   
> +	if (mlx5_lag_has_sd_group(ldev))
> +		mlx5_mpesw_teardown_sd_fdb(ldev);
> +
>   	err = mlx5_lag_shared_fdb_create(ldev, NULL, MLX5_LAG_MODE_MPESW,
>   					 MLX5_LAG_FILTER_ALL);
>   	if (err) {
> -		mlx5_core_warn(dev0, "Failed to create LAG in MPESW mode (%d)\n", err);
> +		mlx5_core_warn(dev0,
> +			       "Failed to create LAG in MPESW mode (%d)\n",
> +			       err);
> +		if (mlx5_lag_has_sd_group(ldev))
> +			mlx5_mpesw_restore_sd_fdb(ldev);
>   		mlx5_mpesw_metadata_cleanup(ldev);
>   		return err;
>   	}
> @@ -105,9 +154,36 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>   
>   void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
>   {
> -	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
> -		mlx5_mpesw_metadata_cleanup(ldev);
> -		mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
> +	if (ldev->mode != MLX5_LAG_MODE_MPESW)
> +		return;
> +
> +	mlx5_mpesw_metadata_cleanup(ldev);
> +	mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
> +	if (mlx5_lag_has_sd_group(ldev))
> +		mlx5_mpesw_restore_sd_fdb(ldev);
> +}
> +
> +void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev)
> +{
> +	struct mlx5_devcom_comp_dev *sd_devcom;
> +	int i;
> +
> +	mlx5_ldev_for_each(i, 0, ldev) {
> +		sd_devcom = mlx5_sd_get_devcom(mlx5_lag_pf(ldev, i)->dev);

sashiko.dev says:
Can this lead to a use-after-free on the pf pointer?
The mlx5_ldev_for_each() loop iterates over the ldev->pfs xarray, 
fetching pf
pointers via mlx5_lag_pf() and dereferencing pf->dev.
However, this helper is called in mlx5_lag_disable_change() before acquiring
ldev->lock and without an explicit rcu_read_lock(). Because xa_load() drops
its internal RCU locks before returning, the returned pf pointer is 
completely
unprotected.
If a concurrent device unload via mlx5_lag_remove_mdev() acquires 
ldev->lock,
calls xa_erase(), and frees the pf object with kfree(pf), would this access
to pf->dev trigger a use-after-free?


No. mlx5_mpesw_sd_devcoms_lock() runs only when ldev->mode == MPESW
(checked under the held HCA devcom_comp). mlx5_lag_remove_mdev() is
reachable only after mlx5_eswitch_disable()/mlx5_lag_disable_change()
has torn down MPESW for that LAG (setting ldev->mode = NONE).
The shared HCA devcom_comp serializes the two paths, so any thread
that reaches remove_mdev's xa_erase has already moved ldev->mode out
of MPESW, and any concurrent disable_change waiting on HCA devcom
will then see mpesw=false and skip the iteration.


> +		if (sd_devcom)
> +			mlx5_devcom_comp_lock(sd_devcom);
> +	}
> +}
> +
> +void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev)
> +{
> +	struct mlx5_devcom_comp_dev *sd_devcom;
> +	int i;
> +
> +	mlx5_ldev_for_each_reverse(i, MLX5_MAX_PORTS, 0, ldev) {
> +		sd_devcom = mlx5_sd_get_devcom(mlx5_lag_pf(ldev, i)->dev);
> +		if (sd_devcom)
> +			mlx5_devcom_comp_unlock(sd_devcom);
>   	}
>   }
>   
> @@ -122,6 +198,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
>   		return;
>   
>   	mlx5_devcom_comp_lock(devcom);
> +	mlx5_mpesw_sd_devcoms_lock(ldev);
>   	mutex_lock(&ldev->lock);
>   	if (ldev->mode_changes_in_progress) {
>   		mpesww->result = -EAGAIN;
> @@ -134,6 +211,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
>   		mlx5_lag_disable_mpesw(ldev);
>   unlock:
>   	mutex_unlock(&ldev->lock);
> +	mlx5_mpesw_sd_devcoms_unlock(ldev);
>   	mlx5_devcom_comp_unlock(devcom);
>   	complete(&mpesww->comp);
>   }
> @@ -199,7 +277,8 @@ bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
>   
> -	return ldev && ldev->mode == MLX5_LAG_MODE_MPESW;
> +	return ldev && ldev->mode == MLX5_LAG_MODE_MPESW &&
> +	       __mlx5_lag_dev_is_port(ldev, dev);
>   }
>   EXPORT_SYMBOL(mlx5_lag_is_mpesw);
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
> index b767dbb4f457..5099723ba0f7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
> @@ -33,8 +33,12 @@ void mlx5_lag_mpesw_disable(struct mlx5_core_dev *dev);
>   int mlx5_lag_mpesw_enable(struct mlx5_core_dev *dev);
>   #ifdef CONFIG_MLX5_ESWITCH
>   void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev);
> +void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev);
> +void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev);
>   #else
>   static inline void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev) {}
> +static inline void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev) {}
> +static inline void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev) {}
>   #endif /* CONFIG_MLX5_ESWITCH */
>   
>   #ifdef CONFIG_MLX5_ESWITCH


