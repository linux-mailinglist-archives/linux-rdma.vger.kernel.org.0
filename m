Return-Path: <linux-rdma+bounces-21915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4NBJGQpQJWpbGwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:03:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F23650441
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=P8E9wj2P;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21915-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21915-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 608CC3011043
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4FE36F428;
	Sun,  7 Jun 2026 11:03:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5E1E98E3;
	Sun,  7 Jun 2026 11:03:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830210; cv=fail; b=PvRTmHkST8qiGRxCSpv9bqGxJRqCqrZHKbtt+KtOQrplv6oKTwRK+7Qib+cO4MXoJH3A9tfgcR//h5c7DEFTYIhbKHAMpem0QXEK12xSJOdf3d8pPXomqAGiPw20ssGrzpticHqk/nD2wct9YyzJG8Ila9A4hZlr9soTA7U8x8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830210; c=relaxed/simple;
	bh=L/9462SYi7YQl1EMAO68NWf+i9hbQFP01JNpsGZjHR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LYkCoA6M+iLVCsbbel6R0ligvw3tvoCc1HLeX1fN9qwbb/WS2kMa/sJoTg6FHD2cI0aoJ6Qqp2wrBohxdkjIOLazSYjskKt398nMxKxKAkF/ao3a0d7RkMZW+BYxKIGIwAAIEdCg5i3F+f3S7H06LsydLqeyUFDhL/0ZehVrW/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8E9wj2P; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRk/4ZVjoCu8vh37QrOANORsOMM9S+wHErB0hW/f+9t0f4ycKgvqbgaclB0LlahmgZCJ5ilsDx6xilClqVTGuEImbHH+ytDGaHLckhLPAIXlQvbIK8TS/bqdnyt3fQ8SSjZ5NtCDXHLiyJUnvA1FrNegfB6uGVgqc6I9ytZueSv64ovM/T3sKjdVNcxf7S8CTb8ZEAvpEfSo4WtELJ3dwjY5PljpQnB1x34Tdw6JEWSv84DRbYf2d2wC3dMCVMi25fBqVx5DSs4rKsOuoPDBiXX9AvHRaQvgaADElBdHngNvpwdaMv16J/+hiu/A2ghsw7lcFoz4aIB4764VmqbOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPP0PXVRJoMubThmpjmpAL0JfICP3pPyeV+3S11Iiy0=;
 b=ClceBBXm0I+tMzAvvWVDtFRSOKHR4wfl740yr3xHg30WAjOsJIUdrx1smhJTuidS4yKETLaknju1DtLSeWIypZja22nQ4p1jX7O40qaYtN482icwq1jSz7B5qIEoNo0TZE6QCyuaKYiUcbIZDAJqMSf19EpP39Ac/b9S2OomhCFeGtsrKYI0f6aSPsaD5fTTotBu7hitMmGhBFOdAY69DfJyHTLq641To0Cph2meFMT1desHjzr+5xejUWc42/bOGyzWYWB1HfUDJrxdiyGUu3iENq4CKVdeTRYP9I3wq8H5TvcC0pHvcmCYOYFm5uIvCw1PKwAFhkhz87bKMXmkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPP0PXVRJoMubThmpjmpAL0JfICP3pPyeV+3S11Iiy0=;
 b=P8E9wj2PiE8BKZXjx/8zVCmuKyFbgl7NE0s0CA81qmeJ15w25vhhd5clLxsbVokD/TxDsT7U+DNfsdO7cojmvxBCcCdWam4pYxz3Oh1+JMbjWuffOmuSy8S9h1xvkxMpM0TEMP34CoyQD/8J3SFpfn33VfpqAEpmMsUHpkf1aEDkE+bcLLr+go1PyboeHDmiKJoApm9WjvOxnk2mNGJO4z2aqmgxENVTWT1axyuLZJybsAtVWA9BWC9YStn0wjBviDDuI/8rUp5xg4jl7vbuNTSntueiKDFiYkTP2Bw75l/iDS/0cvBtz4fsiAdSk2E7WH33JuUbEccSYFs6loEVmQ==
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by CH1PPF6B6BCC42C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::612) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sun, 7 Jun 2026
 11:03:22 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::66) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Sun, 7
 Jun 2026 11:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 11:03:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:03:08 -0700
Received: from [10.125.203.115] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:03:01 -0700
Message-ID: <1d2215b4-0914-4996-ab44-1973b4e7a5c7@nvidia.com>
Date: Sun, 7 Jun 2026 14:03:01 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net/mlx5: SD, support switchdev mode
 transition with shared FDB
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
 <20260604114455.434711-8-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260604114455.434711-8-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH1PPF6B6BCC42C:EE_
X-MS-Office365-Filtering-Correlation-Id: 697f6219-62fd-4216-27b5-08dec4846395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|22082099003|11063799006|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	o7cGTcqlqrwkgt3dgHX/fsHfMhM/xhid/TvZAqwx/EU7NBeueB04C0esu+QbSfj1J30R/ZFiedRqnYO625jqRA2UkhNoSYHxP2bb5+JXuEXs9B3Q+E6TJof6LFk0UoNWYb64vwUBZHa0Xkt5rlmkjxEsI3v5MV6wSeORyjBAIvrxVYfraW7fjtWmsyWboK9MxHjJprtRELaz6ezwVl3Yi7uOpmrJyHKFBMJSecLF+du0os3omUSKPOmJUrf8Q1CkEA1tqbDF2hV525olFpT2ki2pnN8ljr7T8sn///mXeZgnCkeAFMyXJNg8NbuI37jAPNCad/oHXPSjF3TyEwuZ7QdM62xzWpIocyr+Eq6IBFsWmXctLRB5OnV6DyOJbgJZgO7g83+NbdkbTzJQATWaBs7YBm2X6QiHi4SjI4nVO4r4U/ZTp6jwsgdNB/HKDAl0NVNQgPSbzNc5ZoWuzV+PPc2bf11TJy57aLwvGiDgCNHbPIRN5Hj4ytl0Fzi0TjBmw6X+fFAyk3KFvY6VvY+zuyFIaoLiWCl8cQngp/GGpMKueBvWzXPfx+xQNjdud9gX9TI27xRlhaaB1rAlvUHSoOwmMNv5wQcNf/R2v2p3iYe1lqy6RUQ+bKbb1/3KdMHkXPrVTpXd6eQMNDxTJkhQpXbdgt4wUDLWUBAVnPbOI8ASyYz9W3ndk8/LIr/7PkVnGpq2PQ8n+4S/CGba9ocUaID4aC6NoacUCLwboP7lTHI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K265I4kX2iAFRclOL6H0RhcpaNKs0xwnBgy1jh0VMlv2YqxPByucjV5Tt7wAdPU2pMBKPejilR0l8NdgSxPS2KWmuEI8ifKHG+Shj/g2BZdxOxUhGS9l1p7hTJymj6qfsE3Q7eKnWsB+GrQOAEIwr7hboLjeA0Cws80aavyeFlV4l82xWP0y/66mkEKvV4+wcqMU3uHDjZRIV3aFHe9YCmT7ZEGau0Org6+T34jfVjsvpwIXiT0TD1mrJZNI1Q17rZlvocrisGFSOSYEJvkHuU6qZu7NqqJPMeP1xUKysGpN8w+WtuFdSTR1rDLE2qIm7vm8yeJvO1ZWdyU2dvzD9m6/ric36zALO2lCiFiuPzDyxF14w2dp0InwAHDiKQbMyFuvquLbk9CUxtwiEwUytmkVMG4UMwKfxVeUIPMgNTB3SZN0w8FESwbeJRkVfnVl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 11:03:21.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f6219-62fd-4216-27b5-08dec4846395
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6B6BCC42C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-21915-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
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
X-Rspamd-Queue-Id: C7F23650441



On 04/06/2026 14:44, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> When the eswitch transitions, propagate the change to SD: secondaries
> get their TX flow table root reconfigured for the new mode, and when
> all group devices move to switchdev, the per-group shared FDB is
> activated.
> 
> Shared FDB activation is best-effort - failure does not block the
> eswitch transition; the next transition retries.
> 
> Note: the existing mlx5_get_sd() guard that blocks switchdev for SD
> devices is intentionally retained. It will be removed once all
> supporting patches are in place.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../mellanox/mlx5/core/eswitch_offloads.c     |  24 +++-
>   .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 133 +++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   7 +
>   3 files changed, 156 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 366531d8ef02..1133267a53fb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -46,6 +46,7 @@
>   #include "fs_core.h"
>   #include "lib/mlx5.h"
>   #include "lib/devcom.h"
> +#include "lib/sd.h"
>   #include "lib/eq.h"
>   #include "lib/fs_chains.h"
>   #include "en_tc.h"
> @@ -3164,6 +3165,9 @@ static void esw_unset_master_egress_rule(struct mlx5_core_dev *dev,
>   	vport = mlx5_eswitch_get_vport(dev->priv.eswitch,
>   				       dev->priv.eswitch->manager_vport);
>   
> +	if (!vport->egress.acl)
> +		return;
> +
>   	esw_acl_egress_ofld_bounce_rule_destroy(vport, MLX5_CAP_GEN(slave_dev, vhca_id));
>   
>   	if (xa_empty(&vport->egress.offloads.bounce_rules)) {
> @@ -3182,6 +3186,9 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
>   	if (err)
>   		return err;
>   
> +	if (!mlx5_sd_is_primary(slave_esw->dev))
> +		return 0;
> +
>   	err = esw_set_master_egress_rule(master_esw->dev,
>   					 slave_esw->dev, max_slaves);
>   	if (err)
> @@ -3401,7 +3408,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
>   		return;
>   
>   	if ((MLX5_VPORT_MANAGER(esw->dev) || mlx5_core_is_ecpf_esw_manager(esw->dev)) &&
> -	    !mlx5_lag_is_supported(esw->dev))
> +	    (!mlx5_lag_is_supported(esw->dev) && !mlx5_get_sd(esw->dev)))
>   		return;
>   
>   	xa_init(&esw->paired);
> @@ -4219,11 +4226,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>   	if (IS_ERR(esw))
>   		return PTR_ERR(esw);
>   
> -	if (mlx5_fw_reset_in_progress(esw->dev)) {
> -		NL_SET_ERR_MSG_MOD(extack, "Can't change eswitch mode during firmware reset");
> -		return -EBUSY;
> -	}
> -
>   	if (esw_mode_from_devlink(mode, &mlx5_mode))
>   		return -EINVAL;
>   
> @@ -4233,11 +4235,18 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>   		return -EPERM;
>   	}
>   
> +	if (mlx5_fw_reset_in_progress(esw->dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Can't change eswitch mode during firmware reset");
> +		return -EBUSY;
> +	}
> +
>   	/* Avoid try_lock, active/inactive mode change is not restricted */
>   	if (mlx5_devlink_switchdev_active_mode_change(esw, mode))
>   		return 0;
>   
>   	mlx5_lag_disable_change(esw->dev);
> +
>   	err = mlx5_esw_try_lock(esw);
>   	if (err < 0) {
>   		NL_SET_ERR_MSG_MOD(extack, "Can't change mode, E-Switch is busy");
> @@ -4304,6 +4313,9 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>   	esw->eswitch_operation_in_progress = false;
>   unlock:
>   	mlx5_esw_unlock(esw);
> +	/* Shared FDB activation is creating LAG which is changing reps. */
> +	if (!err)
> +		mlx5_sd_eswitch_mode_set(esw->dev, mlx5_mode);
>   enable_lag:
>   	mlx5_lag_enable_change(esw->dev);
>   	return err;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 8b1f3a25d80d..d2ed156ed1c6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -5,6 +5,8 @@
>   #include "../lag/lag.h"
>   #include "mlx5_core.h"
>   #include "lib/mlx5.h"
> +#include "devlink.h"
> +#include "eswitch.h"
>   #include "fs_cmd.h"
>   #include <linux/mlx5/eswitch.h>
>   #include <linux/mlx5/vport.h>
> @@ -33,6 +35,8 @@ struct mlx5_sd {
>   		struct { /* secondary */
>   			struct mlx5_core_dev *primary_dev;
>   			u32 alias_obj_id;
> +			/* TX flow table root in switchdev (silent) config */
> +			bool tx_root_silent;
>   		};
>   	};
>   };
> @@ -669,6 +673,29 @@ static void sd_secondary_destroy_alias_ft(struct mlx5_core_dev *secondary)
>   				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
>   }
>   
> +static int mlx5_sd_secondary_conf_tx_root(struct mlx5_core_dev *secondary,
> +					  bool disconnect)
> +{
> +	struct mlx5_sd *sd = mlx5_get_sd(secondary);
> +	int err;
> +
> +	/* Idempotent: skip if TX root is already in the requested state. */
> +	if (sd->tx_root_silent == disconnect)
> +		return 0;
> +
> +	if (disconnect)
> +		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
> +	else
> +		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary,
> +							 sd->alias_obj_id,
> +							 false);
> +	if (err)
> +		return err;
> +
> +	sd->tx_root_silent = disconnect;
> +	return 0;
> +}
> +
>   static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
>   				struct mlx5_core_dev *primary,
>   				u8 *alias_key)
> @@ -688,7 +715,8 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
>   	if (err)
>   		goto err_unset_silent;
>   
> -	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id, false);
> +	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id,
> +						 false);
>   	if (err)
>   		goto err_destroy_alias_ft;
>   
> @@ -707,7 +735,7 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
>   	struct mlx5_sd *primary_sd;
>   
>   	primary_sd = mlx5_get_sd(mlx5_sd_get_primary(secondary));
> -	mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
> +	mlx5_sd_secondary_conf_tx_root(secondary, true);
>   	sd_secondary_destroy_alias_ft(secondary);
>   	if (!primary_sd->fw_silents_secondaries)
>   		mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
> @@ -936,6 +964,107 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
>   	return &primary_adev->adev;
>   }
>   
> +#ifdef CONFIG_MLX5_ESWITCH
> +/* All SD members must have completed esw_offloads_enable (i.e., reached
> + * mlx5_esw_offloads_devcom_init) and become eswitch-peers of the primary.
> + * Until then, mlx5_eswitch_is_peer() returns false for the not-yet-paired
> + * member and shared_fdb_supported_filter would reject. When all PFs transition
> + * in parallel, only the last one to finish satisfies this gate; the earlier
> + * ones return 0 silently here.
> + */
> +static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
> +{
> +	struct mlx5_eswitch *primary_esw = primary->priv.eswitch;
> +	struct mlx5_core_dev *pos;
> +	int i;
> +
> +	mlx5_sd_for_each_secondary(i, primary, pos) {
> +		if (!mlx5_eswitch_is_peer(primary_esw, pos->priv.eswitch))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
> +{
> +	struct mlx5_sd *sd = mlx5_get_sd(primary);
> +	struct mlx5_lag *ldev;
> +	struct lag_func *pf;
> +	int err;
> +	int i;
> +
> +	if (!mlx5_sd_all_paired(primary))
> +		return;
> +
> +	ldev = mlx5_lag_dev(primary);
> +	if (!ldev) {
> +		sd_warn(primary, "Shared FDB MUST have ldev\n");
> +		return;
> +	}
> +
> +	mutex_lock(&ldev->lock);
> +	/* Check if SD FDB is already active for this group */
> +	mlx5_lag_for_each(i, 0, ldev, sd->group_id) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		if (pf->sd_fdb_active)
> +			goto unlock;
> +		break;
> +	}
> +
> +	if (!mlx5_lag_shared_fdb_supported_filter(ldev, sd->group_id)) {
> +		sd_warn(primary, "Shared FDB not supported\n");
> +		goto unlock;
> +	}
> +
> +	err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, sd->group_id);

sashiko.dev says:

Does this setup race with concurrent eswitch teardown when deferred metadata
initialization runs?
In the final state of the series, mlx5_sd_activate_shared_fdb() iterates 
over
the SD group devices and calls mlx5_esw_offloads_init_deferred_metadata(esw)
on peer eswitches without acquiring their mode_lock:
	mlx5_sd_for_each_dev(i, primary, pos) {
		struct mlx5_eswitch *esw = pos->priv.eswitch;
		err = mlx5_esw_offloads_init_deferred_metadata(esw);
		...
Concurrently, a peer device transitioning to LEGACY mode executes
esw_offloads_disable() while holding its mode_lock. The initialization 
thread
only holds the sd->devcom lock, which the teardown thread briefly holds and
releases before entering esw_offloads_disable().
Could this concurrent execution allow the initialization thread to allocate
metadata or update ACLs on a peer eswitch while the teardown thread is 
actively
destroying them, leading to memory leaks or a use-after-free?

Indeed it can race.
will fix in V2


> +	if (err)
> +		sd_warn(primary, "Failed to create shared FDB: %d\n", err);
> +	else
> +		sd_info(primary, "Shared FDB created\n");
> +
> +unlock:
> +	mutex_unlock(&ldev->lock);
> +}
> +
> +void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode)
> +{
> +	struct mlx5_core_dev *primary;
> +	struct mlx5_sd *sd;
> +	int err;
> +
> +	sd = mlx5_get_sd(dev);
> +	if (!sd || !mlx5_devcom_comp_is_ready(sd->devcom))
> +		return;
> +
> +	mlx5_devcom_comp_lock(sd->devcom);
> +	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> +		goto unlock;
> +
> +	primary = mlx5_sd_get_primary(dev);
> +
> +	/* Secondary devices need TX root reconfiguration */
> +	if (dev != primary) {
> +		bool disconnect = (mlx5_mode == MLX5_ESWITCH_OFFLOADS);
> +
> +		err = mlx5_sd_secondary_conf_tx_root(dev, disconnect);
> +		if (err) {
> +			sd_warn(dev, "Failed to set TX root: %d\n", err);
> +			goto unlock;
> +		}
> +	}
> +
> +	/* Try to activate shared FDB when all devices are in switchdev.
> +	 * Shared FDB is optional - failure here doesn't fail the transition.
> +	 */
> +	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
> +		mlx5_sd_activate_shared_fdb(primary);
> +
> +unlock:
> +	mlx5_devcom_comp_unlock(sd->devcom);
> +}
> +
> +#endif /* CONFIG_MLX5_ESWITCH */
> +
>   void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
>   		      struct auxiliary_device *adev)
>   {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
> index 7a41adbcee71..cb88bf34079a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
> @@ -45,6 +45,13 @@ mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_MLX5_ESWITCH
> +void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode);
> +#else
> +static inline void
> +mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode) { return; }
> +#endif
> +
>   #define mlx5_sd_for_each_dev_from_to(i, primary, ix_from, to, pos)	\
>   	for (i = ix_from;							\
>   	     (pos = mlx5_sd_primary_get_peer(primary, i)) && pos != (to); i++)


