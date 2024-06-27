Return-Path: <linux-rdma+bounces-3544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7991A95F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB872856C6
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D61487EB;
	Thu, 27 Jun 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBEDFfrr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2313DBBC;
	Thu, 27 Jun 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499150; cv=fail; b=uhxO4VlOJ49fvVX7tqpLCXBeK6EUWadDRQxRZAC6E/VsLk6x7NzasdgPZitYJGYwBXD33mKqwS2CIaNeLjpFM/A0drW3i7XMpHBuCNjN6frpHWh8HLkCAJlOWjcjQkBaFS2jYM/l8qtf6Q+PQh2y4isjhAxbJUrxeXpXvtRxAo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499150; c=relaxed/simple;
	bh=/TfvSavvbDaQP+zQb9ViwjwiqbUen33BBl2zYNDK13g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auh5tbxjRcybSq+jgUFcA2eTFQ0a7ZWiRIF8a38KM7OpHeDpgf/A6CPmKg6a5FU+LxcvJLF8xOUSi6bxsTnS/3oJj3t5wizrSYeVVCAq8UusAGWJkLxgutc4oMD0q8jhNg/i31MXpUpz2D/Pa7Zr1akLDLq2gVjQU/iu8E4pxJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBEDFfrr; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egbRPv69hJP0HbW1HqImrGhCsCmrwqT01y7oPS2WxrWwFAMdACX0+SS2Y7xIH7VRc2abvl9t5hSuqofujjJ9c59lmFVVjR2J+FGpQ0R04EIwMz1SAYg2U/FUf4EUcT9UeWwc2X9HmgeIeKq5PbLNoMBioVfJt+Y039V3uT0g40bkHrT4XML5Npk56Aebpu1/jOJJXhbtzGIQFFn0hFmQVypH8ICNy0rSTy4bAkMO6Jvn/Xmg3C0CcMIoJBbGdVq0F1avXPDG0ezR+udBCnl8fa/gk65y42GeO+5iDxShMl0RdP6wcQt3vxO+Qizu5FErYxyfOeU3wxhPc1ewJRsOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yty9ePQj69kxCx7zEiXqtwEQGIHXJ3wrXIRf5O7y/v4=;
 b=n32CFDBsptQalA4WYLJ1SSsHVQdBIqU7gk7KY9h1euoYNr+gWghOQLygAUVKYnwmjbhFr7DF4KrL6WGENzr3kF1ykgAyN8m8G/PO+pY/bgKCmDpeDsIeAaQtwIAXcMJLMuKDiraR+0hKwe90QrzImECnwnt4Ks8kEJoJsTZiDzu64SaPlaNvwBPeAQQXMyUOOEBFOe+2cPUuUcoeqL0n0fl4WZEeXPU659m+46NVSRabQlrgf7X4VrEBRBO4ko1rpD6aChT/nz9jArtoZhsCtZg0TvrW2lIhkjJmwtls9wI8eT0jdu45+VxmcbcBfpwVc0RGL9mUiUt+xI7feOsJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yty9ePQj69kxCx7zEiXqtwEQGIHXJ3wrXIRf5O7y/v4=;
 b=eBEDFfrrQ6apNZpNM/aV/7A4i/07KQMffVO4uJhFamt50c254IZsYno/xOyl5kKgb/bI5ZtfgwUgte0/zTfIyNCViqzgixENH9Yw4zCPryH781SpyJ6uKC7ONdVQ40qcLBYjSB0SHBLcKQhhvzyjj/VDP4ddAsYKXdM33nrpjLPlUspejcziN8UdCdUc7b+AMJp/MJIch5gAs/M66+RpA3CKsXWHtEcj6K/nIN2bRlOfcUtmWxyGskXQIpyhwMpI9FFO9+mD1nZCLIhKX5/pzQgr48J3TgmJwYAwedSC9cUgtKPTK/tMAiMTHc7WZPZUROGz3jU0jZ3eu5GRBtjAKw==
Received: from BY5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:1e0::27)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:39:01 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::75) by BY5PR03CA0017.outlook.office365.com
 (2603:10b6:a03:1e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Thu, 27 Jun 2024 14:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:39:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:38:34 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:38:30 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v8 2/2] net/mlx5: Expose SFs IRQs
Date: Thu, 27 Jun 2024 17:38:10 +0300
Message-ID: <20240627143810.805224-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240627143810.805224-1-shayd@nvidia.com>
References: <20240627143810.805224-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9798b130-5e26-41ab-2c7d-08dc96b6e2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2RDHyz+/HfuMefDBd/BcCmtQE6EDgnZlK1E47DkB01jWSFVWMvZal7kXF0Dr?=
 =?us-ascii?Q?XRj6+1CQnUWj2QelaxUNgvVO+2cY6EIGp0pxwntakrpiXsPNf1vB1QwJ5ebA?=
 =?us-ascii?Q?vBvIV4bZH6XK2e+rcGyBR1BTinmpUPXpBdHSoBFs4DHyAJ/lfLOvpkHZ5zWS?=
 =?us-ascii?Q?sKR0Uiy2Psgp6JFZJ33oW/cj/jbEzp2myHlPFP3e++Q4ktE8tZ0jhOC88HUP?=
 =?us-ascii?Q?U6dDVeno8BHVgMxMYYKsqcyWlbLnRqyO8VjHXjvi4/NOcR6jQ5/TMWHWeDzn?=
 =?us-ascii?Q?o0dKdxN8U4YNGUz5/xcsn/V0YmbL1gDeHgCQbPOWG0SzKCy5xC3R2q3DG70J?=
 =?us-ascii?Q?XL8d0KDDJEE7wd4ySwauKHIc9mtI9ZV2TVTF0XlLuAhvSe9rSsOx4Yq9NcBn?=
 =?us-ascii?Q?bx66mzRPbX94yo2X5tSY5dC7tM9o6X47XJ3crm5Cq3xjeYTwhQ2vfoZt3kOn?=
 =?us-ascii?Q?yVlYIEiPeuvRhqrhv0YWtf5NfYW+0h8D7h6+sXzeyK2riX5OWh4IWHqCPfp4?=
 =?us-ascii?Q?uBL67ftNBYQmjHnUf01Xh2wyCV/wMgU9dL76fxgNFVZQczkB8c9Bhr5lcCNi?=
 =?us-ascii?Q?89HPpvKnlkIj/angmYKivJoqu4bR3A4m8Vxt2XGrJVxLTcgaqN6EUhkLODgH?=
 =?us-ascii?Q?oobJeI14PJA6ZZ11V0AI5dLYNtfIPUxVgV3jOlRPC1qb9O3Bn4KLmLxXl6fo?=
 =?us-ascii?Q?mo4fq87yC0uH2hFYCMVpfRkOqgcoM9PjGYDYcSBCgNc9tXjF/2SwrOOzgubj?=
 =?us-ascii?Q?+bjHWPoVWGnDMyBjicURStSWxoudOdyFtwkDjMWpcq9AI8N4at3HrB4vKUBo?=
 =?us-ascii?Q?H/YQfnM/ZYvkmI2ovWghY6GIc6x+AO4uB/l0iVhaozt3Vcl2mqj0bYWms/Gw?=
 =?us-ascii?Q?3WM/kdAEKL5ORZsPV7+5FnrbbMrY9WxhGjvBKK4xmBbq8r65tBCM+bf5sKvS?=
 =?us-ascii?Q?1QNCCx2CTOKUPcjBK7bYgftHQjGSwu79Xms9kHDkU8dwLRTVeFUCrvIpU34J?=
 =?us-ascii?Q?nThGba7Lv4+Kym26m2AzWXdzerSvXWocW37CsfKgzwjMkAX/qOOLpE1VXHbc?=
 =?us-ascii?Q?JEA1mOo9mOsddzVcX9gB+d3z//5h9UqfqsapRW5n2e16MMBGNMpE7u5Ir0n4?=
 =?us-ascii?Q?YeArp6zaIyDbhVGFXGBiJCCdILbzaYDwxSQHpWg39HqVD5F5WajhP0MYLHEg?=
 =?us-ascii?Q?HO9BmKhcpk7E+yI6tlO98Owa26e+rOlPPUuLpkYEH7evfmB6Y2RIABqcruga?=
 =?us-ascii?Q?oCVQlwLAihqjSXFymJQ11dqIvDVhKeEyaviy3mEUiSh2tR5rwjVCM3AjoSLx?=
 =?us-ascii?Q?tLwrJLF7T59lfNWN44tIOY73+oM4XcNQ8lAHawzMWivQJIy9wziIXp0ZCBVX?=
 =?us-ascii?Q?elFm5rAmKxGZS2NWXdXpIRhTRJhUonBqHvW8uxIXwYg0h3mkyNqw6XYDax9g?=
 =?us-ascii?Q?5r6E4P3afLIQfLcqLL0Lj6fBTjgl3VT6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:39:00.8854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9798b130-5e26-41ab-2c7d-08dc96b6e2a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
v6->v7:
- remove not needed changes to mlx5 sfnum SF sysfs
v5->v6:
- fail IRQ creation in case auxiliary_device_sysfs_irq_add() failed
  (Parav and Przemek)
v2->v3:
- fix mlx5 sfnum SF sysfs
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c   |  6 +++---
 .../ethernet/mellanox/mlx5/core/irq_affinity.c | 18 +++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h    |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_irq.h | 12 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c  | 12 +++++++++---
 5 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 5693986ae656..5661f047702e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -714,7 +714,7 @@ static int create_async_eqs(struct mlx5_core_dev *dev)
 err1:
 	mlx5_cmd_allowed_opcode(dev, CMD_ALLOWED_OPCODE_ALL);
 	mlx5_eq_notifier_unregister(dev, &table->cq_err_nb);
-	mlx5_ctrl_irq_release(table->ctrl_irq);
+	mlx5_ctrl_irq_release(dev, table->ctrl_irq);
 	return err;
 }
 
@@ -730,7 +730,7 @@ static void destroy_async_eqs(struct mlx5_core_dev *dev)
 	cleanup_async_eq(dev, &table->cmd_eq, "cmd");
 	mlx5_cmd_allowed_opcode(dev, CMD_ALLOWED_OPCODE_ALL);
 	mlx5_eq_notifier_unregister(dev, &table->cq_err_nb);
-	mlx5_ctrl_irq_release(table->ctrl_irq);
+	mlx5_ctrl_irq_release(dev, table->ctrl_irq);
 }
 
 struct mlx5_eq *mlx5_get_async_eq(struct mlx5_core_dev *dev)
@@ -918,7 +918,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 	af_desc.is_managed = 1;
 	cpumask_copy(&af_desc.mask, cpu_online_mask);
 	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
-	irq = mlx5_irq_affinity_request(pool, &af_desc);
+	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 612e666ec263..f7b01b3f0cba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -112,15 +112,18 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
 
 /**
  * mlx5_irq_affinity_request - request an IRQ according to the given mask.
+ * @dev: mlx5 core device which is requesting the IRQ.
  * @pool: IRQ pool to request from.
  * @af_desc: affinity descriptor for this IRQ.
  *
  * This function returns a pointer to IRQ, or ERR_PTR in case of error.
  */
 struct mlx5_irq *
-mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
+mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
+			  struct irq_affinity_desc *af_desc)
 {
 	struct mlx5_irq *least_loaded_irq, *new_irq;
+	int ret;
 
 	mutex_lock(&pool->lock);
 	least_loaded_irq = irq_pool_find_least_loaded(pool, &af_desc->mask);
@@ -153,6 +156,16 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 			      mlx5_irq_read_locked(least_loaded_irq) / MLX5_EQ_REFS_PER_IRQ);
 unlock:
 	mutex_unlock(&pool->lock);
+	if (mlx5_irq_pool_is_sf_pool(pool)) {
+		ret = auxiliary_device_sysfs_irq_add(mlx5_sf_coredev_to_adev(dev),
+						     mlx5_irq_get_irq(least_loaded_irq));
+		if (ret) {
+			mlx5_core_err(dev, "Failed to create sysfs entry for irq %d, ret = %d\n",
+				      mlx5_irq_get_irq(least_loaded_irq), ret);
+			mlx5_irq_put(least_loaded_irq);
+			least_loaded_irq = ERR_PTR(ret);
+		}
+	}
 	return least_loaded_irq;
 }
 
@@ -164,6 +177,9 @@ void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *i
 	cpu = cpumask_first(mlx5_irq_get_affinity_mask(irq));
 	synchronize_irq(pci_irq_vector(pool->dev->pdev,
 				       mlx5_irq_get_index(irq)));
+	if (mlx5_irq_pool_is_sf_pool(pool))
+		auxiliary_device_sysfs_irq_remove(mlx5_sf_coredev_to_adev(dev),
+						  mlx5_irq_get_irq(irq));
 	if (mlx5_irq_put(irq))
 		if (pool->irqs_per_cpu)
 			cpu_put(pool, cpu);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c38342b9f320..e764b720d9b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -320,6 +320,12 @@ static inline bool mlx5_core_is_sf(const struct mlx5_core_dev *dev)
 	return dev->coredev_type == MLX5_COREDEV_SF;
 }
 
+static inline struct auxiliary_device *
+mlx5_sf_coredev_to_adev(struct mlx5_core_dev *mdev)
+{
+	return container_of(mdev->device, struct auxiliary_device, dev);
+}
+
 int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx);
 void mlx5_mdev_uninit(struct mlx5_core_dev *dev);
 int mlx5_init_one(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
index 1088114e905d..0881e961d8b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
@@ -25,7 +25,7 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int devfn,
 int mlx5_get_default_msix_vec_count(struct mlx5_core_dev *dev, int num_vfs);
 
 struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev);
-void mlx5_ctrl_irq_release(struct mlx5_irq *ctrl_irq);
+void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq);
 struct mlx5_irq *mlx5_irq_request(struct mlx5_core_dev *dev, u16 vecidx,
 				  struct irq_affinity_desc *af_desc,
 				  struct cpu_rmap **rmap);
@@ -36,13 +36,15 @@ int mlx5_irq_attach_nb(struct mlx5_irq *irq, struct notifier_block *nb);
 int mlx5_irq_detach_nb(struct mlx5_irq *irq, struct notifier_block *nb);
 struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq);
 int mlx5_irq_get_index(struct mlx5_irq *irq);
+int mlx5_irq_get_irq(const struct mlx5_irq *irq);
 
 struct mlx5_irq_pool;
 #ifdef CONFIG_MLX5_SF
 struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
 						    struct cpumask *used_cpus, u16 vecidx);
-struct mlx5_irq *mlx5_irq_affinity_request(struct mlx5_irq_pool *pool,
-					   struct irq_affinity_desc *af_desc);
+struct mlx5_irq *
+mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
+			  struct irq_affinity_desc *af_desc);
 void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq);
 #else
 static inline
@@ -53,7 +55,8 @@ struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
 }
 
 static inline struct mlx5_irq *
-mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
+mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
+			  struct irq_affinity_desc *af_desc)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -61,6 +64,7 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 static inline
 void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq)
 {
+	mlx5_irq_release_vector(irq);
 }
 #endif
 #endif /* __MLX5_IRQ_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index fb8787e30d3f..ac7c3a76b4cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -367,6 +367,11 @@ struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq)
 	return irq->mask;
 }
 
+int mlx5_irq_get_irq(const struct mlx5_irq *irq)
+{
+	return irq->map.virq;
+}
+
 int mlx5_irq_get_index(struct mlx5_irq *irq)
 {
 	return irq->map.index;
@@ -440,11 +445,12 @@ static void _mlx5_irq_release(struct mlx5_irq *irq)
 
 /**
  * mlx5_ctrl_irq_release - release a ctrl IRQ back to the system.
+ * @dev: mlx5 device that releasing the IRQ.
  * @ctrl_irq: ctrl IRQ to be released.
  */
-void mlx5_ctrl_irq_release(struct mlx5_irq *ctrl_irq)
+void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
 {
-	_mlx5_irq_release(ctrl_irq);
+	mlx5_irq_affinity_irq_release(dev, ctrl_irq);
 }
 
 /**
@@ -473,7 +479,7 @@ struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
 		/* Allocate the IRQ in index 0. The vector was already allocated */
 		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
 	} else {
-		irq = mlx5_irq_affinity_request(pool, &af_desc);
+		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
 	}
 
 	return irq;
-- 
2.38.1


