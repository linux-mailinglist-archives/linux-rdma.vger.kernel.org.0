Return-Path: <linux-rdma+bounces-13994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FBEBFF616
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A95E18C6DFB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609B22F14C;
	Thu, 23 Oct 2025 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JROhqFUP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0D2BDC29;
	Thu, 23 Oct 2025 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201913; cv=fail; b=YrWrHnrbbWo0jYkrGicHfELwEF0k9M47NCu+DIWi1HkBDa0x/cO7WsUwwt9dFwyCe9MJuuwKXZuAwz4Q5n9Oz6gTZrac0GMRVtrcMDGttXfyVN5GKcH5teZwDkxMR+yLY1rfPX4TrPqQIdfB3Zy1vInYh0fOleMmHueWPt3gubo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201913; c=relaxed/simple;
	bh=I4TFCOLqf/azxLcu03FhPlmQLGDWu9C8PmToSNQcorw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNHnBgtQiOndw8gFjP7sXjN1VGMNAhLVY36a7lxhM/FXnJY4kokY3RL/i0HKolPcNG9gb9jxqciDLLMoy4q1wra+e3vt+Q8Fy4yU2FAy06k+/nwOaoFwd5NU8iz/dRdVAVOKC0qigmgZy59YUpuoAXUw1jAIaeAzNc2Vka5vF3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JROhqFUP; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiEqLb8kP2iQca7Zbu8HzVScItngGsdfR8GV57bldYuJ3iHDUpHOU955HuyBp6BVm4ejVwd87w6FwyiSCOd/G7bVlqKFthLw8vQnr6ehaNezi0SChX8Dzph6aZpq1Nka+BeNR8mSK4EySBdeHrXY4PEA4j9hKoVZKt+tEzX0iy7M7eCqaKvhM/YhcR530JNDeqs6C7+S6mrbZPtYsSE2WEy3/TOSFxbOzrQSKO2Uj94dYy+GtH083zHA4qcOgUPIJfmTypIeXfSACH5DeBpmEgqDJqJJRRbFu/Tz/Sn2MQ8ti/jitDcSV+XpxAox65+XtTiW26N966uzZqevK0LdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnkentxdRAyL3QZeXj+PjIX5klgYcCiB90CJ40jpb+w=;
 b=cDb1gbjbGW7nq2EJaPHwnLByHRmxGKlPJlKz2i9r2uaOGxxWfXTjG+Qq6jFeD2pxT/S0RTs00AqHlZ6excfMv3Mt4oRz5EFtByPut3IcQc0DqeaGOlHmgsVuIcHwPoGlRyW7O4hd991yW1B6MoUgPocmLoL5CLMGYGvvKVw7ZlzkL25U4lxcoQcmkXvSGKLDt6pwDLF4yRiFZ9MomBFi0BoSQTYRJNwrifU+xsgfHVg2LCM7Fn3FsozadMWohb1Z5QSIIuyfG2k8J6qocQKhX5HqFZduHTB97wPGoofQlQzoBEccHpu3wZJeR5PrW1PR4TBKyASj2Kk8qD8Drnw1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnkentxdRAyL3QZeXj+PjIX5klgYcCiB90CJ40jpb+w=;
 b=JROhqFUPgR0DaULmGSQdUvswFyaXcluEakb1qNuQyQv5+rSD65keAaSkMzWTz1lZopRyJsVKCcLmiwemS9/tJMxcutuPAommQeAshnzVOXgp1r/8xxaCLVtuBrH3LfOCajk4jlkOxMIgRnXNCoYgwqX6olrSRKHXAmds3Qj35Fp0F31dZ1JZkdLXAMcOyVYlrqtl5ly1fcX+78BXl8eZe/z4326HmJhTswKcsyB/pqmGv9oZrMLrWIyuaT8tmV4ehUS5/z1aqb035kN7dbz0MQ4tiXKjCfiZ1/bCBHbeYcbuyRt2PthtGoFLH+aXo/RaMipnCewgePrTXvPFwpFPRQ==
Received: from CH2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:610:5b::30)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:45:05 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::b4) by CH2PR07CA0056.outlook.office365.com
 (2603:10b6:610:5b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 06:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 23:44:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:44:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:44:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/7] net/mlx5e: Enhance function structures for self loopback prevention application
Date: Thu, 23 Oct 2025 09:43:34 +0300
Message-ID: <1761201820-923638-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f5f294-102c-431d-6bce-08de11ffb330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0U3BcuS391ek3lxn4bkL/5/EK87s19ecTx5w+/CzJdOYoWozrtPhy0LW8n4?=
 =?us-ascii?Q?0Av7UNfr2kfB3iJp3MjAbT+jn6F1/C27i+sbPO9ECS6CxNWwmnwHag918Vri?=
 =?us-ascii?Q?KUjw/IccRRYY3Jx0yRF9aUUCKXjACK8QwZwVCxIkP4Ryr3RpcXDmm6R3O6UE?=
 =?us-ascii?Q?f9FAZRzpP0WieDgR7yC2m1UElxF6ppf/Fmm5vW9SG0IxaYm3KZK6ooQpiZEx?=
 =?us-ascii?Q?u30+nL95Wkp1VvE5J9bOIYrhplsGYtroYqE+VnvGfq/WWSEK7oRHa/9KFE6s?=
 =?us-ascii?Q?Y6eMQvRHSjzRu0sFZu2FYzfQeiYRGIOK7FT4t2Kh92gjnmBOrwsGn3z83yvW?=
 =?us-ascii?Q?LEkrNNCpxPr3P09e+M92dpjn9hl1Mq/5EZDq0R22KFakb8cr1OxF3YKv+JBK?=
 =?us-ascii?Q?V4VE6+/phqrZI8XsHR70Kh2fjw1PaZFaV8kgJhhuJqTX50SV3JjsnDT0Mvhm?=
 =?us-ascii?Q?f1FRwL/WkzhqF6VShfC3zILNQakSoumAdQdt4BIsoIwV2tZcQR2IAETzVjFp?=
 =?us-ascii?Q?JSFnvjbhv69juF/OSccGwFbGfVL5qPLZnGvapeq5VC8q+EwpLP1lcQDrHA8u?=
 =?us-ascii?Q?JjDkuPC7+BYKQVMvSeO4w8fsAxYeKlFTb3tOh/h/ibC+NAA8Ce9kcAAGtifA?=
 =?us-ascii?Q?QQp4oHchNGlK2S240gZ5kE1nzSHF1vNoQSCGfYfhW+rK5+lB1YD7tq4doDsB?=
 =?us-ascii?Q?8A8ajUYv0QFznry4h9clCGUOJUuwrEX0M1r2jrcqeGAWe2wxWUXeWp0UC5Ax?=
 =?us-ascii?Q?DurwQBkuKvRkRdjJqQO8qnJ+uRMQsWpk65X6mNu0efL/RjDPKhOCoEX9g1U9?=
 =?us-ascii?Q?789oKkPUOuoWmOZms0XEWmZxrq3kulP/Wghv4V2led3A2HGysXxolFl/QUyS?=
 =?us-ascii?Q?xH6lbD91Xa/5/Mpv05380S/bBRlMgY2ZCsA/1kpwVmXbjHfUUM0TgDXxnwb0?=
 =?us-ascii?Q?U1EJ3vgkiq1q4up6VAq9Y1FkVa2JBwQE4jRveotzqtSxp5CeEb+N1nPIvLnf?=
 =?us-ascii?Q?XShxKUZcWlAnL0UbIwvZ4EQcXT2bXcS3Hu/TyUAW55q8AUELKrxiM3/7fJSC?=
 =?us-ascii?Q?/4Ryc22FjhKvN8TzJ+XsXImeeYUSeuAuThA4xqsOPRf0ckbhuj2JXdlvkjye?=
 =?us-ascii?Q?DffVrVlZ261pLYHqQo4fGWHgKMc7is4kPjtwvk/XOSuPpr0QWHprOyigFCS0?=
 =?us-ascii?Q?ollG23Q+Qnc505jXJexTJA1trIHb1Vf7cUHEmePwVHTwZJetHwpbkrS5smzO?=
 =?us-ascii?Q?DBTosbmQuvPr5VjKRTKEd1Vgu+pSDlPqnmC8Bbp1Xqk+KipA7ek/n55MdiXl?=
 =?us-ascii?Q?oVIaqRHisOXdu2ivd+L4ELA3njcUcO6GbafenlZMYgIAZahtWHo9kmb9z6oD?=
 =?us-ascii?Q?0SPW66gNmw2hZN9Jc7waHQdynQeDV82hBnW4zuZzQPSeAvXC2sn088wexymE?=
 =?us-ascii?Q?GRZEb/T8vGMwZdU4NVKDTJzmD/d9X27euUL7q64yRJfAiFtp48hL5Uvg8tQ7?=
 =?us-ascii?Q?U9hlTOSSfWlywrvb27TRqdhMYOXcs8czEpid3w0pX6XODU0WpNt2SC3DxrXT?=
 =?us-ascii?Q?MaZlg3yPWEdMw1/7Uj4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:05.2314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f5f294-102c-431d-6bce-08de11ffb330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

The re-application of self loopback prevention attributes in TIRs is
necessary in old firmwares (where tis_tir_td_order cap is cleared) after
recreation of SQs.

However, this is not needed in new firmware with tis_tir_td_order=1.

As a preparation patch, enhance the function structures to differentiate
between an explicit loopback prevention configuration apply, and the
re-apply operation required by old firmware.

Loopback selftests should now call mlx5e_modify_tirs_lb() directly, as
their use case is not related to the firmware limitation.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h     |  4 +++-
 .../net/ethernet/mellanox/mlx5/core/en_common.c  | 16 ++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c    |  2 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c    |  4 ++--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c    |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..a25588fe2773 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1154,7 +1154,9 @@ extern const struct ethtool_ops mlx5e_ethtool_ops;
 int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey);
 int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises);
 void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev);
-int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
+int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
+			 bool enable_mc_lb);
+int mlx5e_refresh_tirs(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 		       bool enable_mc_lb);
 void mlx5e_mkey_set_relaxed_ordering(struct mlx5_core_dev *mdev, void *mkc);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 30424ccad584..376a018b2db1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -247,10 +247,9 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 	memset(res, 0, sizeof(*res));
 }
 
-int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
-		       bool enable_mc_lb)
+int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
+			 bool enable_mc_lb)
 {
-	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_tir *tir;
 	u8 lb_flags = 0;
 	int err  = 0;
@@ -285,7 +284,16 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 
 	kvfree(in);
 	if (err)
-		netdev_err(priv->netdev, "refresh tir(0x%x) failed, %d\n", tirn, err);
+		mlx5_core_err(mdev,
+			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
+			      tirn,
+			      enable_uc_lb, enable_mc_lb, err);
 
 	return err;
 }
+
+int mlx5e_refresh_tirs(struct mlx5_core_dev *mdev, bool enable_uc_lb,
+		       bool enable_mc_lb)
+{
+	return mlx5e_modify_tirs_lb(mdev, enable_uc_lb, enable_mc_lb);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a56825921c23..8e13f2542d8d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6130,7 +6130,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 
 static int mlx5e_update_nic_rx(struct mlx5e_priv *priv)
 {
-	return mlx5e_refresh_tirs(priv, false, false);
+	return mlx5e_refresh_tirs(priv->mdev, false, false);
 }
 
 static const struct mlx5e_profile mlx5e_nic_profile = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 2f7a543feca6..fcad464bc4d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -214,7 +214,7 @@ static int mlx5e_test_loopback_setup(struct mlx5e_priv *priv,
 			return err;
 	}
 
-	err = mlx5e_refresh_tirs(priv, true, false);
+	err = mlx5e_modify_tirs_lb(priv->mdev, true, false);
 	if (err)
 		goto out;
 
@@ -243,7 +243,7 @@ static void mlx5e_test_loopback_cleanup(struct mlx5e_priv *priv,
 		mlx5_nic_vport_update_local_lb(priv->mdev, false);
 
 	dev_remove_pack(&lbtp->pt);
-	mlx5e_refresh_tirs(priv, false, false);
+	mlx5e_modify_tirs_lb(priv->mdev, false, false);
 }
 
 static int mlx5e_cond_loopback(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 79ae3a51a4b3..49ab0de762c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -316,7 +316,7 @@ void mlx5i_destroy_underlay_qp(struct mlx5_core_dev *mdev, u32 qpn)
 
 int mlx5i_update_nic_rx(struct mlx5e_priv *priv)
 {
-	return mlx5e_refresh_tirs(priv, true, true);
+	return mlx5e_refresh_tirs(priv->mdev, true, true);
 }
 
 int mlx5i_create_tis(struct mlx5_core_dev *mdev, u32 underlay_qpn, u32 *tisn)
-- 
2.31.1


