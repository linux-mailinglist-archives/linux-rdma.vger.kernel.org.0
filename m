Return-Path: <linux-rdma+bounces-21549-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMXJA1AfHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21549-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:45:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96C615D8C
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF250305D990
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA153384CFD;
	Sun, 31 May 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sr0VoRAl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B36384CD4;
	Sun, 31 May 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227654; cv=fail; b=hfQjeQwxeGysZepxVQCPNHlor6hWi2qI3XOwhUKA3l16LkRYvianKo2tdC6fG+zZ4LSIEPa+3dW15u/llPWfxs9nZj5yfzUYWJoOsGAWYj60xZY/sG6uopUO09y+mUsT2JpsFvkDEebpfdzIllZthS2x0FgTUpLFXf/019IBQps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227654; c=relaxed/simple;
	bh=C4Y+Hobmxj3/X9EaaSX50dLRw1gQ9SqbHyMY228H720=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctm7uH+YmSRCNszOIISOgibN1Ud2I004d3/Tzl15ZirZXj4IfNZYhe4m5f07fTNZiATy/iv016q1d0ltknJSM/+7N029TxYJESeIxBQrGR+Gcn4xeIVPJ3WUew/5y5zBroX0tIHemVzAdjnYvOXw1k8W3zR+7e5oinrSZCcWYSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sr0VoRAl; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+ti2xY99nQlg5TY55wuRURuwtDrynvNK8C5zYS6zWxH4gIv2BBNQos/gDH003lfysIbsuYp9zL09/9w/liBXYeHr5FWX0q+Kj7E1sOkG5xN4I7SnMH7x0I2/GzMH/UKLeLUZgT0Ths/B/Zdsf7RHyOaAbYXpdqyBFLo2wnxqZchjyZ4tRvdNOvHBg8vrSM8/QGjbXanDlIVsdfn1PBm3ZrBUg63r5UNuXwOXjHNo+QZyL0wx7mIRMmugdHbUosE0mTxXdQ1Go9NWZEBdwcYK150mAOatMX8SveCiu2qhGy/uT419ZKUyvQyC4NESqFXrd0LSl/hcD1qjm5WmXYfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WOJhN5mVG49U06374hmu5G3upuVJvHzNuBrj4aO1MA=;
 b=Ekx0XUEso0LLFPx2MAv3qp9KJQsq1aoicLlAF7F+YLVwZWqKS6QJVhANw2+Tvmk5AkPZ1H+18YEfm0fQx9YL7RrdF5Pruji/EFPvx8yND4kv6IrM/5CXpKs7PrX6/J9gQtgtvYQQk0Z1GLgHx5ggs85Wcs48ABFTOsx297gvoiyTzXNk2/3qt5uYD3P00DT2IUrVAN7Dat8fIZ+fXX5K0LafTkA5rXywWHJnlmKjrOjJ9OPDhuX19f29Rxe9RvXZCu2lNGis/BsEin8pt+ezn3IQWjt95Tr0t4FrgCDB7prpGZKd7hON779pbvB0ekBg/zVbXa0g4yOId+i9ZJS4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WOJhN5mVG49U06374hmu5G3upuVJvHzNuBrj4aO1MA=;
 b=sr0VoRAlC0oq/Yd5PyE1ARuhX4s5pcD+T+RbAsCOLsezI4scRVF9xJfysHAuvGnDa8HpupX+UzicfNGC72pvpB1JD3FYKzTtIyDSFrjxDMhlwyf6dTlz34JYA3K5FKk8sKc4FfP3e8ACXel9NAQLwwFs92f+LJli4jkyCxcloX64u98+CEuwECO0gOrspAO1VUJ2k9KaZLK0aaquKkaYf+/YOuWACgzT3ezTMlg37+NyoNRMzSP3SEWUvoGUqKU2yNa4BLSOgiS9hyGWXJz1ioLIc1PgYhyo54IPpEIwKRZ/PlOKcqxrA8Ox0TJtuIGbeU69fY5/OEQQdyzGxfNTng==
Received: from CY8PR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:4f::22)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 11:40:47 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:930:4f:cafe::12) by CY8PR10CA0005.outlook.office365.com
 (2603:10b6:930:4f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Sun, 31 May 2026 11:40:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 05/13] net/mlx5: LAG, prepare for SD device integration
Date: Sun, 31 May 2026 14:39:45 +0300
Message-ID: <20260531113954.395443-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2dd984-7a39-4bd9-5bf3-08debf0974e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uwB0VrD5rBRiOhSVCJhXXf+AHcjdxUJi8cAPHGwVSmMvGh096H+fjUb81B/XsbDJ3VjvkxOyhbTbwcLgMFR8T7PjgLfH3OKtRxVVK6hTb+7gR/Uaxb1lwvrYKPLu88UwetBJQFadacdYzaCxUVgQx9c+bhmIrXmkB0Y/IvFQLavyWzS9rERvcgaosp/Y4fW/MdgALjydEhTyfZAUm9vd+BYFssNATU1QzHXcyeDcgaO+k+XdylGNzCu2DYv0WYwHn+qZkRjC6UOiQh8l3/jL0UVLGusiXnAhDTDbz+bMSyyFbWSE4wwn/yqaa8dpIS9xPNTjulffhfs4VHXk4y06B2FgulUmMpoOAGPNPtXL7bEbTzLPfyCzxw6peHX5WadjTvEBa6T379CPvq0zbJbrRWRD6WGALITrDETF7JbwMDGfKF03rSBVZXE48dauhiUAhMTY/jH1bgwYYx+nluOpF2rSyaY9obPwd9d+WWO5Uz4bt4oi0CL/8HBbZoXXQ2qk1jwe6qyzPSLodScblbnpOHwH9e7Hj7NRDEee/cKOlkB9vQX6sAH68A+LjN+r6VhrdZH/tHRUzKBK74XJ61NxA00XYZ5Zkj3fPm+6MLEbXgzH3vms0cty1nho4Y2ZYPTyi9FUH6+PlalaIDNq2efRtK7NabK7K8ZBtW5YJhH9x6TYNzJqodkYwU9Gomsi2GCat8g5FlLQLFMQTs7BzyWbECU6oUiBqS+Ww59axIhL4pg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	64U/LHeGuaflE9xDGhkgEsl08p1CgI0rOIWWe5gPbWO5jPioZ8tEMK21yIUpvduDj+ZtoZ7cjS1BaShAYUEM16X4eAQJU/jw0l0TtJKqkk5IuZ3i5reuDP7yGOH4GQiYE6TNXy9tCDv/BvxQjl03QqiFi709VifEwUGCyrZq6I+ehwmcAkJX3HgR5mZHCjwzpgPl0VnooM6b4juOi3zCzSt9tV+lE0hDmqFEyZEjhRlC6tklRi/lCf/wjyt996bSjgSkz73o+tPpM13oDMPsu+sditkTJXMWx8ON/MrI0MWW0Fg96a6c/hP69100+PPDCS7Losdcj0pUl04W/9YXQ5pU3mPN3z7P5ly3oF5xQ5forCwPIUfydfCQJSKOv4twjY3oNL5MQJDU0lHlzK7TR7NH2XVOwsXWHpr2e108ucy8WKx7BWaMU+3bsjcs4P0O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:46.8129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2dd984-7a39-4bd9-5bf3-08debf0974e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21549-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8E96C615D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Socket Direct (SD) secondaries devices will participate in LAG, even
though they are silent. SD secondary devices share the same physical
port as their primary but are separate PCI functions that need to be
tracked alongside regular LAG ports.

Extend lag_func with a group_id field to identify SD group membership
and introduce a unified iterator that can filter by group. Add APIs
for registering SD secondary devices in an existing LAG.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 59 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h | 53 +++++++++++++++--
 2 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 5dfdd799828f..03cb02c7000d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -242,7 +242,7 @@ static void mlx5_ldev_free(struct kref *ref)
 		unregister_netdevice_notifier_net(net, &ldev->nb);
 	}
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		pf = mlx5_lag_pf(ldev, i);
 		if (pf->port_change_nb.nb.notifier_call) {
 			struct mlx5_nb *nb = &pf->port_change_nb;
@@ -391,7 +391,7 @@ int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
 	if (pf && pf->dev == dev)
 		return 0;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		if (i == master_idx)
 			continue;
 		pf = mlx5_lag_pf(ldev, i);
@@ -1034,7 +1034,7 @@ static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev)
 
 	lockdep_assert_held(&ldev->lock);
 
-	i = mlx5_get_next_ldev_func(ldev, 0);
+	i = mlx5_get_next_lag_func(ldev, 0, MLX5_LAG_FILTER_PORTS);
 	if (i < MLX5_MAX_PORTS) {
 		pf = mlx5_lag_pf(ldev, i);
 		devcom = pf->dev->priv.hca_devcom_comp;
@@ -1482,7 +1482,7 @@ struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
 	int i;
 
 	mutex_lock(&ldev->lock);
-	i = mlx5_get_next_ldev_func(ldev, 0);
+	i = mlx5_get_next_lag_func(ldev, 0, MLX5_LAG_FILTER_PORTS);
 	if (i < MLX5_MAX_PORTS) {
 		pf = mlx5_lag_pf(ldev, i);
 		devcom = pf->dev->priv.hca_devcom_comp;
@@ -1965,8 +1965,9 @@ static void mlx5_ldev_remove_netdev(struct mlx5_lag *ldev,
 	spin_unlock_irqrestore(&lag_lock, flags);
 }
 
-static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
-			      struct mlx5_core_dev *dev)
+int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
+		       struct mlx5_core_dev *dev,
+		       u32 group_id)
 {
 	struct lag_func *pf;
 	u32 idx;
@@ -1985,8 +1986,14 @@ static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
 
 	pf->idx = idx;
 	pf->dev = dev;
+	pf->group_id = group_id;
 	dev->priv.lag = ldev;
 
+	if (group_id)
+		return 0;
+
+	xa_set_mark(&ldev->pfs, idx, MLX5_LAG_XA_MARK_PORT);
+
 	MLX5_NB_INIT(&pf->port_change_nb,
 		     mlx5_lag_mpesw_port_change_event, PORT_CHANGE);
 	mlx5_eq_notifier_register(dev, &pf->port_change_nb);
@@ -1994,13 +2001,13 @@ static int mlx5_ldev_add_mdev(struct mlx5_lag *ldev,
 	return 0;
 }
 
-static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
-				  struct mlx5_core_dev *dev)
+void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
+			   struct mlx5_core_dev *dev)
 {
 	struct lag_func *pf;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		pf = mlx5_lag_pf(ldev, i);
 		if (pf->dev == dev)
 			break;
@@ -2035,7 +2042,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 			mlx5_core_err(dev, "Failed to alloc lag dev\n");
 			return 0;
 		}
-		err = mlx5_ldev_add_mdev(ldev, dev);
+		err = mlx5_ldev_add_mdev(ldev, dev, 0);
 		if (err) {
 			mlx5_core_err(dev, "Failed to add mdev to lag dev\n");
 			mlx5_ldev_put(ldev);
@@ -2050,7 +2057,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 		return -EAGAIN;
 	}
 	mlx5_ldev_get(ldev);
-	err = mlx5_ldev_add_mdev(ldev, dev);
+	err = mlx5_ldev_add_mdev(ldev, dev, 0);
 	if (err) {
 		mlx5_ldev_put(ldev);
 		mutex_unlock(&ldev->lock);
@@ -2187,27 +2194,47 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
 	mlx5_queue_bond_work(ldev, 0);
 }
 
-int mlx5_get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
+int mlx5_get_pre_lag_func(struct mlx5_lag *ldev, int start_idx, int end_idx,
+			  u32 filter)
 {
 	struct lag_func *pf;
 	int i;
 
 	for (i = start_idx; i >= end_idx; i--) {
 		pf = xa_load(&ldev->pfs, i);
-		if (pf && pf->dev)
+		if (!pf || !pf->dev)
+			continue;
+		if (filter == MLX5_LAG_FILTER_PORTS) {
+			if (xa_get_mark(&ldev->pfs, i, MLX5_LAG_XA_MARK_PORT))
+				return i;
+		} else if (filter == MLX5_LAG_FILTER_ALL ||
+			   filter == pf->group_id) {
 			return i;
+		}
 	}
 	return -1;
 }
 
-int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
+int mlx5_get_next_lag_func(struct mlx5_lag *ldev, int start_idx, u32 filter)
 {
 	struct lag_func *pf;
 	unsigned long idx;
 
-	xa_for_each_start(&ldev->pfs, idx, pf, start_idx)
-		if (pf->dev)
+	if (filter == MLX5_LAG_FILTER_PORTS) {
+		xa_for_each_marked_start(&ldev->pfs, idx, pf,
+					 MLX5_LAG_XA_MARK_PORT, start_idx)
+			if (pf->dev)
+				return idx;
+		return MLX5_MAX_PORTS;
+	}
+
+	xa_for_each_start(&ldev->pfs, idx, pf, start_idx) {
+		if (!pf->dev)
+			continue;
+		if (filter == MLX5_LAG_FILTER_ALL ||
+		    filter == pf->group_id)
 			return idx;
+	}
 	return MLX5_MAX_PORTS;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 23c0457ce799..70baa7997364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -15,6 +15,13 @@
  * Note: XA_MARK_0 is reserved by XA_FLAGS_ALLOC for free-slot tracking.
  */
 #define MLX5_LAG_XA_MARK_MASTER XA_MARK_1
+/* XArray mark for port-level entries (excludes SD secondaries) */
+#define MLX5_LAG_XA_MARK_PORT   XA_MARK_2
+
+/* Like xa_for_each_marked but starting from a given index */
+#define xa_for_each_marked_start(xa, index, entry, filter, start)	\
+	for (index = start, entry = xa_find(xa, &index, ULONG_MAX, filter); \
+	     entry; entry = xa_find_after(xa, &index, ULONG_MAX, filter))
 
 #include "mlx5_core.h"
 #include "mp.h"
@@ -50,6 +57,8 @@ struct lag_func {
 	bool has_drop;
 	unsigned int idx; /* xarray index assigned by LAG */
 	struct mlx5_nb port_change_nb;
+	u32 group_id;        /* SD group ID, 0 = not SD */
+	bool sd_fdb_active;  /* set on all SD group members */
 };
 
 /* Used for collection of netdev event info. */
@@ -125,6 +134,20 @@ mlx5_lag_pf_by_dev_idx(struct mlx5_lag *ldev, int dev_idx)
 	return NULL;
 }
 
+/* Find lag_func by mlx5_core_dev pointer */
+static inline struct lag_func *
+mlx5_lag_pf_by_dev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
+{
+	struct lag_func *pf;
+	unsigned long idx;
+
+	xa_for_each(&ldev->pfs, idx, pf) {
+		if (pf->dev == dev)
+			return pf;
+	}
+	return NULL;
+}
+
 static inline bool
 __mlx5_lag_is_active(struct mlx5_lag *ldev)
 {
@@ -214,20 +237,38 @@ static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
 	return true;
 }
 
-#define mlx5_ldev_for_each(i, start_index, ldev) \
-	for (int tmp = start_index; tmp = mlx5_get_next_ldev_func(ldev, tmp), \
+/* Iterator filter constants for mlx5_lag_for_each() */
+#define MLX5_LAG_FILTER_ALL   0        /* iterate ALL devices */
+#define MLX5_LAG_FILTER_PORTS U32_MAX  /* iterate ports only (XA_MARK_PORT) */
+/* any other value = iterate devices with that specific group_id */
+
+#define mlx5_lag_for_each(i, start_index, ldev, filter) \
+	for (int tmp = start_index; \
+	     tmp = mlx5_get_next_lag_func(ldev, tmp, filter), \
 	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
 
-#define mlx5_ldev_for_each_reverse(i, start_index, end_index, ldev)      \
+#define mlx5_lag_for_each_reverse(i, start_index, end_index, ldev, filter) \
 	for (int tmp = start_index, tmp1 = end_index; \
-	     tmp = mlx5_get_pre_ldev_func(ldev, tmp, tmp1), \
+	     tmp = mlx5_get_pre_lag_func(ldev, tmp, tmp1, filter), \
 	     i = tmp, tmp >= tmp1; tmp--)
 
-int mlx5_get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx);
-int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
+/* Convenience wrappers - keeps existing behavior */
+#define mlx5_ldev_for_each(i, start_index, ldev) \
+	mlx5_lag_for_each(i, start_index, ldev, MLX5_LAG_FILTER_PORTS)
+
+#define mlx5_ldev_for_each_reverse(i, start_index, end_index, ldev) \
+	mlx5_lag_for_each_reverse(i, start_index, end_index, ldev, \
+				  MLX5_LAG_FILTER_PORTS)
+
+int mlx5_get_pre_lag_func(struct mlx5_lag *ldev, int start_idx, int end_idx,
+			  u32 filter);
+int mlx5_get_next_lag_func(struct mlx5_lag *ldev, int start_idx, u32 filter);
 int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
 int mlx5_lag_num_devs(struct mlx5_lag *ldev);
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
 int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
 					bool cont_on_fail);
+int mlx5_ldev_add_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev,
+		       u32 group_id);
+void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev);
 #endif /* __MLX5_LAG_H__ */
-- 
2.44.0


