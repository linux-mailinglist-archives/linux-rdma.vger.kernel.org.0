Return-Path: <linux-rdma+bounces-21917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IdsUBBtRJWqkGwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:08:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2ED650534
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rcYNigwm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21917-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21917-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1930C300492B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1D38E119;
	Sun,  7 Jun 2026 11:08:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4038AC85;
	Sun,  7 Jun 2026 11:08:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830488; cv=fail; b=JXlaBQWcTqsMEXAw+dEsRwHl1NaheLomwmXOkL7LP8x6FqMAgmF8/4sKTo/oCdD2qHUo+asQFyEUk89OxdFeh6Yx6C2/u9Cty50LL/UU7CUg6vFX2zfZPaCZPs0OB2hZNY7J8d3SWURI1cIPKPxwjoMb4e+jY1UiXX+sVheX9SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830488; c=relaxed/simple;
	bh=q2apU3ItwvHX43q9qNlV+JBXRc2nMejjTtJVuqT+QKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q3uXNQll1qaZJFZ+IQ+6duHARzRxkmefgFKfJ2D2LbOVUdFSnBZAzFIJ9fwbRTbngN1y7kyTLpLte2re3LtUAzUFNxaKe1ynkNDcqh96T9hz1qjjVypBP9JvprRfAqKCQOzE2Q85jK64CW6FQ6ispoIt1fegU+4pQp68VqZyyPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcYNigwm; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CweNShbbRIG+oh5N8mDeoSEQh/djEOE932QycrNaTBS+E1B2U1j9NdkvvphELJ8ERxd/wk/ERVFZ+IlnV8ZKxOLo9ycfTIjiMfm3iZdgZYqaJ3AeV2u0qhIaOo7lJ3k+g8wTQUMvEi0xMoFvHwRjf92NuUPPmtpQ/9cmFgBMRPk8fa6J8HYxxn3i97f3WQnhorwO7Y/Xv29CISpSZVReCTYdCDWAriznMMIqJop11NBIPbXklH3DQeMQyTKwuyGjs7BYiX8F3ibikZGATdOuKvk0CTLsAsKqoFY25VXU7jb4ua4PaX8LHzdhbfPA4CPnHHNh9a+C4aLQeNC/XyuGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thUb7Zu3c3xVwg4bfEjtno9PpMkRMMxzsi8LR1uA314=;
 b=aRH2xikx5+u1AoVK/0FJmFO84MnbB60rkud3Zm+8p/paVpnv97eoC5RKjrxIb56OVYpkTT2EAwIfJJ5A0PRemuOkNGIRegM8XzQP7Yeob3aCBuKKcvtOUW7V+P6VZLpWhMJaq8xzflB8K1SpN1FMSlq1thYPPmFYFB6x4aoD6RgO7dQig/nrWv0mzff+WUxb1TnErx7eu6l8J17bU0CMlcsgm9FQ8NZxWxVQ3MJWiS+A7HOkfmX1ljDrUZh3U3CLtirdIxlIZCrX7jcVxAhusHGihBYcfB0herHpw//TQb1RYkfBz6q/XECLtwX+I9glL7ZLzkLUgIFkjJGZGIceDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thUb7Zu3c3xVwg4bfEjtno9PpMkRMMxzsi8LR1uA314=;
 b=rcYNigwmhkgseBxrdGij/LRTZedYAa4dyXhvBLW3ctkMypmMg7H+m2NwNOKoZDYqd1oizbvZRMkrPXfr38QijNlQKZu56aPuJ38AAD1ChERB/YHWq6ivOxfsCAxdp4h4pPMFUVlNsRzeeRWD8bFwjWK20r/TLjvTXFyCWS7fvvjjL5/tIdgirDRMBE1QcBCp5Cva7Bfi4bJww4SqMjM/ZYN8p7+6Td2p1l3LNXGgdd5uWy8saUOmVWb2nuhBL8uiPM/ABgt5v0ZNTOUng517JVDgJWPwoyIlRB++2M90WwsqfhSty04L2mjrcn+QlTv5DW205iXM9pnHEhlppD/sKQ==
Received: from CY8PR10CA0010.namprd10.prod.outlook.com (2603:10b6:930:4f::16)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 11:08:00 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::2) by CY8PR10CA0010.outlook.office365.com
 (2603:10b6:930:4f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 11:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 11:07:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:07:49 -0700
Received: from [10.125.203.115] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:07:43 -0700
Message-ID: <780469a1-1fe4-4985-8253-2d24f3b7cf84@nvidia.com>
Date: Sun, 7 Jun 2026 14:07:38 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/15] net/mlx5: LAG, disable both regular and SD
 LAG on lag_disable_change
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
 <20260604114455.434711-11-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260604114455.434711-11-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3b31bd-cc4d-4297-3812-08dec485093d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	boW9M42mBDzkQv8fC5PPJgoG8REBA+MO/ya2Y5uNHpmeOJotqrTcuRr9lHAwThLkbkE3gNoUTxCLukhg0z3zK88YWQ4zNNZa6/Y2SvVjhtb8QUQyBAQZoi+0VEF+TNQ9+bkdk0C7Zg7t870IeuXim0VPZQHznOTeEjqDcAe0CUSystJAU6R8OYBt0S5HwRniKUf/L3sjSrqYKEtSaqMadFW6hMzIyCZKaLY4hdmCU3GStts/xJa5zkgvXNrddmHjErebyCchQr59uS8EC2D+7+nWa/SUkZiHLfYcnzbmCEF+7UpN3MVYURyBJ3OHL9g1ncc+A5dhgKtazjRKhkGtwdU6uU3rZKuy5XK5eS9yWSQszJY7uZ1iCs96RVI+NPOzc44DdQIFMGtv/Eqmd7AUA3zm3K1TKXiwcSgz3MKOhkcxwQyvuigXZYDM70G7Ofxs1zBSyWNVmDZXlnb7uAp2qm+UhERzNsNM0kHUuoS/qNxfOUV2nFkaeWiMXd6/E5bsjmLjE51fyMK/nYsi1M4APNo9z7oaN9g22Ql4HN1e1Q6XSJq5+zwWFLws3UX81Dvl51oyHM/CQX22FGHU6oF94thqL+oWs1rdhAMlLDQIUkgDHHHSCoB2AGbV6W3Di4/P1PMkjr/Jkcl9FN19dwI7n9apg/bWmfTKMXfXQcA/AKgYO93A89ryT3JBcjuUi9pQizzPHFOvzkdrdEEqopiJEeCQR0LjuMTYfnMyWMRYgAg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gMQIm0bb2ww+GT6xqjXYpBTbpeL/5wspHeyNOkj3ftbt3Jjl7f/RBtQGe12kifuduSEL4g1V4Tv7VM06vz0N11B8w2dAR7DQ7TFRov6HXet31nzYK5wyW3ufDgJPzebZTxJyJAe3p4kr0Flv1FOQLXk3x3ZqdL4x/7q+/S1xGzXJoh6iJENxTH9/tx4iK4BCoAGbmC/hRDA9+O8el6ZCjZv4b0n+S3yZdiI3tCgrlHeHSXbOt8iJIjT1tlWM05FlQXLX5f5LHBgxLxpWBUURiTI/BQxcGJLns7Iplc1G2Vv9n/NVURDszvrNqXgbNrICrrhyUVf2sLl9/fTje4+Q6ag9UQUDk7FYKPLqstk1TYoaDHyqQ8TTI3s15bvub71/IoTbXtn9hJv74YsmAKux8U6Cp3oEGZdmyRLTiUgJNcTaYOXEu3x7VNb2NiKKWJDa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 11:07:59.7290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3b31bd-cc4d-4297-3812-08dec485093d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-21917-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2ED650534



On 04/06/2026 14:44, Tariq Toukan wrote:
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
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 25 +++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index e23c1e81b98f..b660253ffc6d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -2494,13 +2494,18 @@ EXPORT_SYMBOL(mlx5_lag_is_shared_fdb);
>   
>   void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
>   {
> +	struct mlx5_devcom_comp_dev *sd_devcom = mlx5_sd_get_devcom(dev);
> +	struct mlx5_core_dev *primary;
>   	struct mlx5_lag *ldev;
> +	struct lag_func *pf;
> +	int i;
>   
>   	ldev = mlx5_lag_dev(dev);
>   	if (!ldev)
>   		return;
>   
> -	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
> +	primary = mlx5_sd_get_primary(dev) ?: dev;
> +	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);

sashiko.dev says:
Could this lockless retrieval of the primary device pointer lead to a
use-after-free if the primary device is concurrently unbound?
For secondary devices, mlx5_sd_get_primary() reads sd->primary_dev without
acquiring a reference count or holding the sd->devcom lock. In a hot-unplug
scenario where the primary PF is being unbound:
CPU1 (Unbind Primary)
mlx5_sd_cleanup()
     mlx5_devcom_comp_lock(sd->devcom);
     peer_sd->primary_dev = NULL; // cleared for all secondaries
     mlx5_devcom_comp_unlock(sd->devcom);
     // proceeds to free the primary mlx5_core_dev
CPU2 (eswitch mode change on secondary PF)
mlx5_lag_disable_change()
     primary = mlx5_sd_get_primary(dev); // reads pointer before CPU1 
clears it
If CPU2 reads the pointer before CPU1 clears it, wouldn't CPU2 then
dereference a freed primary device when calling
mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp) shortly after?
Should the SD devcom lock be acquired before fetching the primary device
to guarantee its valid lifecycle?

Added the lock in V2

>   	mutex_lock(&ldev->lock);
>   
>   	ldev->mode_changes_in_progress++;
> @@ -2512,7 +2517,23 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
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
>   }
>   
>   void mlx5_lag_enable_change(struct mlx5_core_dev *dev)


