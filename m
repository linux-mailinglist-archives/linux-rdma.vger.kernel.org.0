Return-Path: <linux-rdma+bounces-21354-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N8zMBftFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21354-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:09:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A115E4A95
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A024305F718
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E923E7BA1;
	Wed, 27 May 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUHIGqJB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4D21E091;
	Wed, 27 May 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886544; cv=fail; b=ggoMI50ZB5qYFrtOi9O/rJbC3BP5B7g2MYn4637r/gjc91CpyBvSL5b9L5t1xTAdIk3Ljizy5Mq8lbeV7R+ZuYtRKIPb6itdS8Ylm6Yqgj+NguX/MA58PPBJd9h+FNZI8zZZ3gwV/hYrAgGrmzkynGhzTYoDH8dgLfESMMNzRuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886544; c=relaxed/simple;
	bh=uroEa6pu1atNHP7XGb00lrOqyWWGAHm15DCGGy7oeos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPEzvUVlq61QkHX+xwyldTu6/ob04ynzwe8Tbvy+FXqsJMN2rWolWAPbcoUACA8OTtaiQg/n2jXZ8D/nXtfoiTOvcnD6RH5exxoJZXRXp8eDYvQuXExv8ATd1P+z+8IkrQ6q9e2rXiJDY64yFlvdOcNcWoXv5aNpib4Aey73Cao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUHIGqJB; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1zgLJ5D+lA7/e5FSm1bEIVC1FlVfK8lmO3ajvnGF8PNjGVZwws3YJVlzPMlriCoCZb2/414X9J3gPklAd0wfoAlrgNhFebLiRMk54bu3l9nNgJTGyYwSpwHaI03cFBGjSa+7h/vDxxWDOZQegqJv3oHVd8KKDnHuG8X0XRU7VbGly65ZxuBj9W5RQwg40Sao3uwemj5IalDtc2kdQdulM+9k96E2DhPkuPgDpkVUAXVHKxr9VOWRcjXXbHMbs6IkZCG3galJUWYn/BdbQwA/mAaBnf5rs8Qdg99hTG3K+h6GZkRGQ1pwjPcX0YLTyw0fG6RDLBgcfXHngWu9RiLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMctzLE4xmlPJs4ftkNcHEum760GkvfQa3FKxuxxCco=;
 b=L1F/KeLVqQv8ekbSEotAyuGq/3v6laCOwlSsPT28QsM+fEc41EaJBZK0ZRyiC0p+pnH5IDFHKIyI9otowpLLzjoQdU2p9J606BTvbp3vv/wyrQozpL143yzsd9/+KsRBq7NwXDtHMNGucXNAtt9Y1JypakGaUwOCqPWPd5DEulP2Vei6BQfXpLIS3aqL7Biu3qT6lHI6GT2hCiovBFT/9+DD3z0xOkPFrnJs7UP/h1G0eWefpEEILAKDakx4YsFXUKSpbZKj4FG6iJJPhOblfq6gnsovO2fyJQ7JWivh2QjGQQNcWnr6hK7hAur2vXT0ltSS+U+0TrKplzK1cr7sGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMctzLE4xmlPJs4ftkNcHEum760GkvfQa3FKxuxxCco=;
 b=IUHIGqJBWT1w8QZWOmL3QC4+METFr5Mwl01aLtmDPEWVL/qdCKwpppH8he6qvqBfO7GIKE4B2DdCOar3wT+MICR26kneDaenmsJy+Gy2GviRwmayb8An2u0jqNmZ/uVVy+ywrUeV6V3gGcZH9z+2xdhScKHCeeZTB4zGz8e4gmQyGgEnf5yjzjiC2p8c5CofkEBve1Cw0dFE8Hr+uTj6+4lkiFl5RRYUqCcHCFRtNbFAsKqV49vVAcP3twOPOZJSiHspOSfD0kWKaOzhmanck9SOwbI5NSduecVbPVSbEl2DB8ucBMxkoE91wWOL4yP9MzhKy8AmMYatrm7eVBLOlA==
Received: from MW4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:303:16d::23)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 12:55:36 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::79) by MW4PR02CA0019.outlook.office365.com
 (2603:10b6:303:16d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 12:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:55:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 02/13] net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition
Date: Wed, 27 May 2026 15:54:16 +0300
Message-ID: <20260527125427.385976-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d41d194-f867-4c95-a050-08debbef3f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Lcf5YAjAxCLZTulMHMc72WLRtSaGXokFN02QtXQ+bdjhlkMRU8t6jnmNEueJW7gT1QCL5jVhoKYOGj+B20sDv0eUF/aSY67gxpls2LBr7gbf87BBVL/tgvyrHLuUJje3ImGNQP8sJMh1eXvii2q6neKAdEJZ2g7TZzcb0S4EvELCuuFo7+4rpa57G+YividYyn0DTEOzUQH/ot2fzoDdVxZjJ9zjKF7x1a717dOxwM0PXdbxBsj29b+J/K2nqW5vRGSQve5jNr7OTPzxfl1s4oUTRsCgLe7vOjsCj/vIn7hwDaheviCNl3miLpXBNhYek2YpfLzcJQMRWlubL0CinUrL9UckR6Xjw8iYp2kWL1u3zA7IE9afdLnb9ii+HOs6TqiC81tztLLcVv/kX9qLhki2Uqi4VH3UpnCCc1acGZasm3l4vONUgc82TCd2uByLsT7qLmyqRgy6QMwByqNb30KfBcu/orv1+VC34A8bg0UCwS/2ymce6AqDpXmSvBKyX1+BdUAji0Cv/TgUQ/qZBbPAjGaCK6DQP4m+WTRX/aAdaZ6AkB6ADn+bzJ66R7sZVlpa/V3wwsbMMe+fPpTwMec73nVPAFs1ezSUhXjtT45cKlrNfMNGojDm8XUvIa/fPEqZ048cwAI1NLLCDBb1e+04mzf5d8ZiJ65waLbyqZ2LRlJW+fXuxYG4c395XCfmrPXgNp5tvVYHkbiFXPokrTGnvZke02mRIEK0FpYBhA4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nWoL9J/BpQTCjMqNrG3ujo3IRO1WKyTRzboPWQY4f2M3G46YMAa2gh/KenUgP7AF0ccxoeW6KnuxPf8b48oZNauS7MRVQlFchzJYFgZeeW91sJK/XoAUQcCmrt9xk9a3Cdhbq+ViGogD5V5nM7j+h5KHIqzQcvTyRax5Pj4pe3TpvVMfqOpI8FhRxr4ko56sPcwrkkwXxgnmQAMeMKR7I2VDjt/FE6OhffUi4NoOnuMTXZHOZCLmCKKF6YyxqRnuFZ3Xt5lZnNGE9SIr2RDPlEo4fpKxMnYzQjp5QYksWair7CjxqnhZ0Xda4TColgJkN54E9R2ARorcnwyp3IiM8Bix+D1WFstfuXTtfzY8Bb77cuTYkl5IKCubiQMWbL20Tw8/W7mfGyZfb/GTDsOPjXhS96xr84pTvOFiXHsYt6GwA67kfK4Kq4fe3nTtawtp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:55:36.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41d194-f867-4c95-a050-08debbef3f43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21354-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 12A115E4A95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

This patch align the eswitch disable sequence with the
switchdev-to-legacy mode transition, where eswitch must be disabled
before device detachment. The consistent ordering is required for proper
SD LAG cleanup which depends on eswitch state during teardown.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0c6e4efe38c8..fd285aeb9630 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1369,7 +1369,6 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 
 static void mlx5_unload(struct mlx5_core_dev *dev)
 {
-	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_devlink_traps_unregister(priv_to_devlink(dev));
 	mlx5_vhca_event_stop(dev);
 	mlx5_sf_dev_table_destroy(dev);
@@ -1484,6 +1483,7 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 
 	mlx5_hwmon_dev_unregister(dev);
 	mlx5_crdump_disable(dev);
+	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_unregister_device(dev);
 
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
@@ -1568,6 +1568,7 @@ void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev, bool suspend)
 	devl_assert_locked(priv_to_devlink(dev));
 	mutex_lock(&dev->intf_state_mutex);
 
+	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_detach_device(dev, suspend);
 
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
-- 
2.44.0


