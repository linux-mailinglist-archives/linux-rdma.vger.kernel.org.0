Return-Path: <linux-rdma+bounces-22216-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8hoTLEvaLmoe4wQAu9opvQ
	(envelope-from <linux-rdma+bounces-22216-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 18:43:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390E6818BF
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 18:43:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Mq48xMEP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22216-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22216-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4BC53008893
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788753CAE7F;
	Sun, 14 Jun 2026 16:43:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06A39A045;
	Sun, 14 Jun 2026 16:43:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455432; cv=fail; b=k9ijb21G2nLgiSYnQor66AJ2Tj6mvU8w8/4tS2zPEob9GiPNv5wMOEVLoG422dVj+yeo2ZlFBDGYvAeYDozDlL4zQ+7TwpCXpYv6BGg4HGDL4R3HryzxAhvJ017tOCGlcUsHfp3ezXzWjsObA5O/IFRDNZBlCjo1xzK/FAb3B4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455432; c=relaxed/simple;
	bh=+N/GP0vbebM10m/42uKZ/6iSFohV9KRL2qILUHjhwac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UV8WH6NnOKNfUzGY6gPJ18eDaBq/lxNhwvwjFTgRFBiasm8tQxRjII2R/u/iR13CQx0ZQzsDalK5hoIgonv1D6MQCZ82YEXX4z6PUgnj0bf0a6Ri0poFEsEjE+bCSr4gNaGr+f8KGYzra6s9InlPnfcXMM4TsDG3bXUztPSiAhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mq48xMEP; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcMTI9KhAM00eSncrgYwbcP7XnJ0t84E/MU7OI/3n6htfZlwNT6OrJ7yMO+YFKyeMa+hKZ4cH5f6dWROinawQYCyPlvVW2PMOJ/nYS/Iy0g37+R2pCut/fpwRvj9ehlbxMgfxjTUr4KrY7y+mCvY0hHGMEld91GrwAm/TmuyEKPQDXl/nrjPRKWOWt+DMxTlAkTuYa+vIkuaWhbDN9FnGAJjsNqCyMaWtnDyUS0RAR0cCghYM0JUH296HpYbqwFfAl2yCKsmbJajM7+UOXzsdZdA+wdWAkmjMKAu3gWOp0u3szx2HJB+l4GEUr79hnu1701eIQReFeATuEeHv9ZYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhRBJgQfZe77/0nu8l0Sac+OIdfPXMXcNTWo4vlKq0Y=;
 b=yizkmpA5sNDTv6tPz9k6CD6fpW7Gb6gQ7t49zfnDttyyv2UXsf+8YPtnhSXZwBioPbo1cW96r2zvx5zZnvAeO6n0MGvWTetvPnvBxd/kRI3t9f5sPiCPDFJm3ORWu7uZmKmwf9iP0gmMqaxgLgJYvCSBef5ef6AHhTPPqYb6DcZAapMbXdDF9Nx4vGDK0dqkKojG1dID5pfcvVfWBCSyHu99iQNuSLSHe2xh4HCKQSEeXVGW7IhuTr5JC+AwbwXxvcM/V0CD0+wzxKcMY0zJ7n1/kS8tQYVZ3xR7f9qbNQPqZ3dxbNKFc01dTtSzwYaQoNc+jDBAmSxPlSxnkmpBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhRBJgQfZe77/0nu8l0Sac+OIdfPXMXcNTWo4vlKq0Y=;
 b=Mq48xMEP9xm0QPdV9pxJaZoVVdeCcZIRAJCwWsGS/aHH63B4ffjLD56M0coY/zMk5P+uCLP1HeQoVhGMO0yS5Ua/ax7Eg4D9zObeR3VkZRZe8b4JkhXz8tkAduIaS+9826QJYVdhMt/SKav/tft6DLUtFJ0G3vcwBjPyfVarqgX6EKQjOhvv+f17ECp0ZhnPA93i7IJCo1GrwtAZ8ZPS5eTEo4AdRyjSYTGifs3BPHQQdnhCG4ckivKpBFLbT9DQpFx2FJA7ZviwgYxJKzk1KzVGmPtfK6vu2JkoI2fGql4R4hjrklkHaMLHUAJfQdv9nO/eynGRmeqHxHt3ueqDmA==
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 16:43:47 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::25) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 16:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 16:43:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Jun
 2026 09:43:35 -0700
Received: from [10.221.208.116] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Jun
 2026 09:43:28 -0700
Message-ID: <4cf4b485-50a3-456b-841c-9625c2beff4b@nvidia.com>
Date: Sun, 14 Jun 2026 19:43:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 10/15] net/mlx5: LAG, disable both regular and
 SD LAG on lag_disable_change
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
 <20260612113904.537595-11-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260612113904.537595-11-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: a3085bd3-39de-4866-5b95-08deca341a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xyflI9U+k2CE1ZZ/pjdB9cVEtXcMnhphG+p0ecGsONJERcCVv8uimhUaWL85eeOMjI0L3gaCEPIeoZOr/OuHPE89YoJHYLPdC9imKgSIKXjfDSq+Mzs1I3gXr+XfFGLqLukXuA6YIgY98eeYW7MQwlI7TZO248JY1VBkGsMn0O0T8YvAuDymUOnTqTupqDpp4n60wl0NxR+rguDmfOQWvlFzS5FpjxC2fmDJ5jL/UnS3936D512d7ZPJAduDiSlptk0QjITrbSNwS+9AGfCWUirFyUT8Fs13Botwl2h5jFbtZj8nkdDc+ZW5O0VJJHKcS3L8SKnZ0oIUyAPk7QWjLcZ0qCq5p9BaIeZenBbyB6J4OtMAM6PWap3v9WG1ZXGDJ9IkdcmZ/gp3dMMJ9F5Pmz5e7q8H8Ol0HQLeIsjnAuWPn9ww97V1CS85mXfus2azrB/kNVDfNHQgTiruQakNw8Y9CTZesFLUy/I/IVjpweqZsEHEPIu2gt7s8z87TvuGQiNqbdyh+AmVJZqWSVej5szEcZ6XLhEXsry1kjWwkWx0hgazCNScpoZTvu5JrPTLlRLkyVACgFmj9+iXBYvcUg6MaQZnEYWGth62YlsKLQmjdHErAX6YpCoawggFdjpBqK0jq5KEL90wvJL0AwTrKTNzsymvxFTelxqYePVYyHUXdaZNj/sU4BjezfFyGR5tescvLFpNdYe28aLYTaD9WXqpN9Jk1iPcbaFASQIDcjc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2IVRrcBKlPNcYE5XjSE0qgRC51UqK4uiQY5Epkq0IMbUyxorZrRXmafkawAKkacMa/+e+jDziIXlez30HKaTTfLO21HEctmG3gz+WAgcMjw79tO555f4t3BS77W4mmrbDbYy3Ml6VPMg5bSN+KlZtV2qy0mv62kwddambR3G2iHMpt9kLR9fgt7pq1n7cHJ3jzEs2lWcCg2E1w8pBmHbbvcgHHsF5fTPMuOEhl2I9pQ7keVQas/yBe5HT2d0EnsDG0yBsEeUkDlkjqFK8a8iZUEa0iTBVpB4h1ekkDQ7PEAEmmBd3rTUrnnw858eFq4xeSfFIfq558wuadgOr85b9sOKCIpjhrM4gXeZsmBlaRfNGaX7ELTLfwnSzhybroctSYGfSeO0r/UCkqTxYpUw01tbgUaDAYPMCeqikyauZr3GcUEQ4J4zCdz+0wuvOYQb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 16:43:46.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3085bd3-39de-4866-5b95-08deca341a94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22216-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2390E6818BF



On 12/06/2026 14:38, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Extend mlx5_lag_disable_change() to properly disable both regular LAG
> and SD LAG when requested. Each LAG type uses its own devcom component
> for locking.
> 
> Use mlx5_sd_get_devcom() helper to retrieve the SD devcom component,
> needed for proper locking when disabling SD LAG.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 29 +++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index e23c1e81b98f..84eff995cad1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -2494,13 +2494,22 @@ EXPORT_SYMBOL(mlx5_lag_is_shared_fdb);
>   
>   void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
>   {
> +	struct mlx5_devcom_comp_dev *sd_devcom = mlx5_sd_get_devcom(dev);
> +	struct mlx5_core_dev *primary = dev;
>   	struct mlx5_lag *ldev;
> +	struct lag_func *pf;
> +	int i;
>   
>   	ldev = mlx5_lag_dev(dev);
>   	if (!ldev)
>   		return;
>   
> -	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
> +	if (sd_devcom) {
> +		mlx5_devcom_comp_lock(sd_devcom);
> +		primary = mlx5_sd_get_primary(dev) ?: dev;
> +		mlx5_devcom_comp_unlock(sd_devcom);
> +	}
> +	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);
>   	mutex_lock(&ldev->lock);
>   
>   	ldev->mode_changes_in_progress++;
> @@ -2512,7 +2521,23 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
>   	}
>   
>   	mutex_unlock(&ldev->lock);
> -	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
> +	mlx5_devcom_comp_unlock(primary->priv.hca_devcom_comp);
> +
> +	if (!sd_devcom)
> +		return;
> +
> +	/* Teardown SD shared FDB for this device's group if active */
> +	mlx5_devcom_comp_lock(sd_devcom);
> +	mutex_lock(&ldev->lock);
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		if (pf->dev == dev && pf->sd_fdb_active) {
> +			mlx5_lag_shared_fdb_destroy(ldev, pf->group_id);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ldev->lock);
> +	mlx5_devcom_comp_unlock(sd_devcom);

sashiko.dev says:
Does holding the sd_devcom lock while calling mlx5_lag_shared_fdb_destroy()
introduce an AB-BA deadlock with auxiliary device probe?
This path acquires sd_devcom, and mlx5_lag_shared_fdb_destroy() eventually
reaches mlx5_rescan_drivers_locked() calling device_del() on auxiliary
devices, which attempts to acquire device_lock(&adev->dev). This gives us:
sd_devcom -> device_lock()
However, during auxiliary device probe, the driver core holds
device_lock(&adev->dev) before calling mlx5e_probe().
mlx5e_probe() then calls mlx5_sd_get_adev() which acquires sd_devcom,
giving us the reverse:
device_lock() -> sd_devcom
Could the teardown be performed without holding the sd_devcom lock here
to prevent this deadlock?

[SD] No — the teardown's device_del runs on the IB aux devices, while
the device_lock held during probe is the ETH aux device (mlx5e_probe);
different struct devices, so no AB-BA

>   }
>   
>   void mlx5_lag_enable_change(struct mlx5_core_dev *dev)


