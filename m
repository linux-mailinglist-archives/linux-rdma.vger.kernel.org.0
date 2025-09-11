Return-Path: <linux-rdma+bounces-13266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2728B528D1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E9F7BB4AB
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4930827057D;
	Thu, 11 Sep 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8f69Dgk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DE2594BD;
	Thu, 11 Sep 2025 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572334; cv=fail; b=A/W7pEBBKIRYwRDgEADfTc6w3vYdtTVY7AdO0PivakRmHX4vVAsa+5RMICx1fP6gq2lKkJ+j5mEYallj1CZE38KrhnEqEdPU2s+wTs1nc/A7JL6JaP3FAgoS4JqIAHO/bmWfZsh58Wdyb5zXdvkFemhXh4/P3eHCEuNPZSqLdsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572334; c=relaxed/simple;
	bh=fa2VtRx+KgKkcjKtn/CHY9wvMV9YeYUVTdLqqtvwwcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJNKcANd8nD5Y2UqtwEvbCeppzASXV9aeOABR13iqLfwa2IGEeXaZg7A8Hj+NpyYZ2pnnq83LJOrXFzs0OMLqJJ6Zrf/p0o7vJugrJ023Sw3QsnmtM0Wp6sxy6KlmZnrNSiKNGrw73UB2W+iMd/IZK4wiDQWlJnicbY04fK7wEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8f69Dgk; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w01+/25POF/p/P0qhQEft5IjN8lbWsd7257WRL58NaBSD4mMJDWlGSxLCl7RGaZ7lpsIOa8OUG4OEy6BwApxy4ntjw3JBT/AYybAtLn6C6OMl2zKLA8Y39gD6eUQrgV5jfxkjKAJD1H83IKLF6gQW2UNqxCY65RK76pZEEMf27n8Bad6l3hk3PN2NDYHuiZGD65Czu/dduxzH3576q9mn8f7Vf4FO++q4OsCnbaSWAe9us55oDMjnD2oYF3okQ2XS3Osd/ZHZPr0bss6BD0+NlWXF0RqDFTF0LzDjXfBJzfcGEBvigr/tz6dtwSqjz5PBEj8XQaDxBrubkIiIY5Pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZIBciaJ19pOLC9vsrl7+r+Ee2dZKgIGdg2xIBQ07Gk=;
 b=AlQYXwUTqzZb78hTIBbEZku+wwa27vPtwzH6JJcLmGl6JGW3O/vwmexkPh9VauQ5XewzldCdWhuzTQAW9xLdRAEBkCehMt04gKJZuLbFPfQytloUGI99CPjD71Dfi0O6KprWsJ9crbHzhfLOl2S1GBIHHiVCrzSIqVMIOsbDCWIAAc/zaIll9Lid30xwLr3/BKN+ipMTTJBJz7cbyKlnicK49R2c2QAa8m2tqAbjX/T8hJVkLOSa5K8fuN1NLGyjC9EkTceZ+pW4s25wIsgOV9Dj4+BT6BydNTuZUs5SkqL+obezKBKdPEXf7r1JHBaDFHdi+r6IJzMpdkpwMLgrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZIBciaJ19pOLC9vsrl7+r+Ee2dZKgIGdg2xIBQ07Gk=;
 b=r8f69DgkWr9ReT690tTXPJ0hibPwQhhqeh8eGUxz/GfgTY7kqhvFUAOaarOaFDm3oMeZcHIvnMq7p9fQX3oLJoQwrg7sEN31fMfX6xXm328Avjz6fnrC1DAj5bAY9xB7MeIwDnWllBQcsnZvXyCJpEatO7sbUVgIM6y39cDGhbOSFwtAHMYrF8S+yllaRhJom02ymyRF7VvWtNqA33hYM/PCAoE+XlVzySqV8z1v7p+Je7nOxf4gjp125wmqWXrv+2m33CGN9WKxod3eZo4ZZauTqCK/6a45MQpbUIPwsmcLzFDLQcZfB4aQo20pOyGJ2d3JMre3JwElJQJ9ZLfsUg==
Received: from SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::7)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:32:09 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::9d) by SN7P222CA0022.outlook.office365.com
 (2603:10b6:806:124::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 06:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:32:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 23:31:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next 4/4] net/mlx5: Lag, add net namespace support
Date: Thu, 11 Sep 2025 09:31:07 +0300
Message-ID: <1757572267-601785-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b613f1-08dc-47a8-949e-08ddf0fcef11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9kO+fbM5SJy9Gprz1vm2EPkZpnsFDIaoCEXz6xdE1xv4q+J2mkKgfal57n9y?=
 =?us-ascii?Q?xavWtUPrLCR9vQzycD44Nqfpm3MlO+90usitXWbFc2fd6n/eTNIOSMWjTqEC?=
 =?us-ascii?Q?3rTU8ANQGojek2HmmedLdT4USaV4ziAbghiOxdyXYB0iYa9onI6nkGal0Fxz?=
 =?us-ascii?Q?XqHhb0PWuGch7cEer2iicVZs56rDItTReh08DviDzBN156CDGDIE08h+iPbn?=
 =?us-ascii?Q?Uu0dBDjLJkbAGHsOa10NsuyungOqfxlsdafsR7PtrlsaqknHNMZJE9O0NFmJ?=
 =?us-ascii?Q?u4Gla+L+pSQb7GIerkXSziB2tmBM5MTFcdc5JFU63oaXvuhy7k4r/L5R1nCg?=
 =?us-ascii?Q?jaIA67Iq7ppJX8tROZ7jcyKrzcnSnCMJ34jnWW2OfTs6FW3p6pViFd/DX5mw?=
 =?us-ascii?Q?Yp4KdNLOJhNR/DK5kaR1tFi8lm91nT7fCa+7/aShX4aW+dItalkRQAXbCtPz?=
 =?us-ascii?Q?cqDyA3vWr7Eo/fX9KtKd7WGGGWwWmPwg1SJnG/GjNLEm9BrICketbQRFqhGu?=
 =?us-ascii?Q?cD0cGqYoHHjcxBznKAY9ks42ZxIhPqnVsPhX+P+ICl2dmNdO62VNkN/eN7wp?=
 =?us-ascii?Q?gaaANqeQPBZxSOvFQ+IaJQWdyeWbee35WmDLvVJOdjnbaiWZ+ynvNIDVpr85?=
 =?us-ascii?Q?xq+bUqeRsyQulN9ev095mLZMU0Jrbo1zXIEn8cjdZkXelWwplsYmaJojiW4M?=
 =?us-ascii?Q?rkvNF3gVu42FzFMZPegiFV0taW/YKp5CE/f3YaFJ5dF95X78Rr/SmzyZXJ2F?=
 =?us-ascii?Q?66hB8pVZxmRyHBlo6BkgOMnRMSXF/tyxAjjDqnbJegg9/AejwEdCxa7ZUNFi?=
 =?us-ascii?Q?xoqjcjwY1HD7BoizPZoGTJuFhxnaLRksC/DJDjlUOfadF1PdU4bK7a82fjoC?=
 =?us-ascii?Q?WhEEoCI6incaVVIzMWxGj7mydG3zhcUXd4KBpyTkHdv/FtD4SnqclL9pJbLD?=
 =?us-ascii?Q?nSNKagt10Z0ADueExJrtBFXYrl8mB7MBlRVLI13/6dvgzuoz//HTsvOH7+3Y?=
 =?us-ascii?Q?ksUA4zXIFZZvczlTUu3JXx4lPm4iQ5eH5tyFGdRqMos/i4N0KCaWxqnn1cJ4?=
 =?us-ascii?Q?m1Mb8/vJb4elcPw0SjYbpKMDGR8oOrHiem7kqn3EsJcegpQEz8t8DsamGLA8?=
 =?us-ascii?Q?Qwu0o9pB/8z4rgK1Jy03d9UP+Up207TBnmZ4UDEn3AO9JUCbE2TA0YEcL1xe?=
 =?us-ascii?Q?PCW2pPWO0GKwyVOhVHFxI1mQcWHDpfUMZualcvuiOw/svQGRPZ/xmfwKE+Ws?=
 =?us-ascii?Q?meuqq4EQeRnNHqEYn2GI7HYCP8cs2LRKTN1HmBE651JYXsAzlFCbL/AaJbpg?=
 =?us-ascii?Q?o6xyS1Re+vc04exCxDyHAYQeoSRAjcY/6fA2uPzsWeMEsT8Y9N8c+fW9xwIR?=
 =?us-ascii?Q?/avcertP0QHk2kUULCBELfriYEvQ8XJ8KuCfLRyRnH734dgZT4isV+KUOihC?=
 =?us-ascii?Q?wqY/7oqVrrU9kNQrzzG/hHGFCcnvO+csmKY5HRZkH0XQCVeOj1pXFmRTDeJe?=
 =?us-ascii?Q?sQbDioEajLZ6b4Eez2+miTQ0U+gJrebeW7W+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:32:08.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b613f1-08dc-47a8-949e-08ddf0fcef11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

From: Shay Drory <shayd@nvidia.com>

Update the LAG implementation to support net namespace isolation.

With recent changes to the devcom framework allowing namespace-aware
matching, the LAG layer is updated to register devcom clients with the
associated net namespace. This ensures that LAG formation only occurs
between mlx5 interfaces that reside in the same namespace.

This change ensures that devices in different namespaces do not interfere
with each other's LAG setup and behavior. For example, if two PCI PFs are
in the same namespace, they are eligible to form a hardware LAG.

In addition, reload behavior for LAG is adjusted to handle namespace
contexts appropriately.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 -----
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 14 +++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a0b68321355a..bfa44414be82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -204,11 +204,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return 0;
 	}
 
-	if (mlx5_lag_is_active(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
-		return -EOPNOTSUPP;
-	}
-
 	if (mlx5_core_is_mp_slave(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported for multi port slave");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ccb22ed13f84..59c00c911275 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -35,6 +35,7 @@
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
+#include "lib/mlx5.h"
 #include "lib/devcom.h"
 #include "mlx5_core.h"
 #include "eswitch.h"
@@ -231,9 +232,13 @@ static void mlx5_do_bond_work(struct work_struct *work);
 static void mlx5_ldev_free(struct kref *ref)
 {
 	struct mlx5_lag *ldev = container_of(ref, struct mlx5_lag, ref);
+	struct net *net;
+
+	if (ldev->nb.notifier_call) {
+		net = read_pnet(&ldev->net);
+		unregister_netdevice_notifier_net(net, &ldev->nb);
+	}
 
-	if (ldev->nb.notifier_call)
-		unregister_netdevice_notifier_net(&init_net, &ldev->nb);
 	mlx5_lag_mp_cleanup(ldev);
 	cancel_delayed_work_sync(&ldev->bond_work);
 	destroy_workqueue(ldev->wq);
@@ -271,7 +276,8 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);
 
 	ldev->nb.notifier_call = mlx5_lag_netdev_event;
-	if (register_netdevice_notifier_net(&init_net, &ldev->nb)) {
+	write_pnet(&ldev->net, mlx5_core_net(dev));
+	if (register_netdevice_notifier_net(read_pnet(&ldev->net), &ldev->nb)) {
 		ldev->nb.notifier_call = NULL;
 		mlx5_core_err(dev, "Failed to register LAG netdev notifier\n");
 	}
@@ -1413,6 +1419,8 @@ static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 {
 	struct mlx5_devcom_match_attr attr = {
 		.key.val = mlx5_query_nic_system_image_guid(dev),
+		.flags = MLX5_DEVCOM_MATCH_FLAGS_NS,
+		.net = mlx5_core_net(dev),
 	};
 
 	/* This component is use to sync adding core_dev to lag_dev and to sync
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index c2f256bb2bc2..4918eee2b3da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -67,6 +67,7 @@ struct mlx5_lag {
 	struct workqueue_struct   *wq;
 	struct delayed_work       bond_work;
 	struct notifier_block     nb;
+	possible_net_t net;
 	struct lag_mp             lag_mp;
 	struct mlx5_lag_port_sel  port_sel;
 	/* Protect lag fields/state changes */
-- 
2.31.1


