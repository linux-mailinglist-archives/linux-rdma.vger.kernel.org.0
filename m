Return-Path: <linux-rdma+bounces-2368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3B8C0D53
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50641F25956
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC814A62F;
	Thu,  9 May 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEVhY7VV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7C14A60D;
	Thu,  9 May 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246098; cv=fail; b=jGKECSi7usGVe/T4BQxGrVCd/m1wvICBUlUKo/NgBivquaqZFwAJWjQHzIFCZYGdO81xW39e53xkqSF+19NAEHv3JeLiJS6GGhPqbOD5/o9+FKeAsc9G6TEJ00tPS8/mIbbv07xki8OkJ2PJqpkAVRDY5NlclD4DI/SERc6J6cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246098; c=relaxed/simple;
	bh=RBvCj79vyynGwsDQGy+kuamZmRQsDItRyv9qMUJ/F48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR/mC+J5q+MmBYV8b/0fJfFIvScl3CdvBXAPIEfOXKpJJ5nbOij/g9ASIaBjlO6E6cOf+anlsE+8gBi0Uzxjx6ZCVe6JWYCw1aD90iwBV4UIQ00YUIRB3qWUiXgsIC58RALL058b8l6WPbaOVwMH9ndgPgd4EBSJAjkDNi1n6Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEVhY7VV; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/K5Q7jdvAs0PXkIX6xXTbZJhRt9coViTnISUi5RHRYfwzaYiwU3IMXoBY56tCD5TQYJfyqHLNZ1XXkoHV1JZyeZdGGVHqFjuWwipcCqcRqOI9+1iNssarR9dlVgy3a+fAwNOCCZaxhDiiGjyfuutRmCHU8S4atdrXdvs4wpvjjb41ntY5vIgmzPZLoxUKyl8WLj6hs0bJMzLQ6cJ9dG8WCYYXiJQ2VSpht2IycuUQZW3M0rSFdZmaMk/9JRZqKuJ1fMm4G+1sZtMgmtxBIjRsOjiPPr79ok4feVbr+bpHPaBJ94wyMQWf/Klp91ed036y8ao9GIpVb+/+vuovAtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP+qI0DnNJUSbxU4oLKLfJmVVNSjllEg+OgxlFGriyA=;
 b=G0ZG5wMbKIlqZhs8YHzda+XCBvrj5GNaeNbQNet7UTn2wjfPXnGOSJTRyob0vfO0i5Ehk3pWngdkh7SLzPA4DHVAnVNWAsDbuMBBUblCoqufvyTBuPkYyiJsGy23vXA8Oox/+kjNtQT8PqCZHbg1iL9dkRlUgZz/0qmszmMMkOlRKjRvSjlRqhxzEm7HbE/lF1BK64ruBC/3LEy+C5NAqqVAHN6oQca/F8nPhsfr/voHWbcnrRbdsF2hkdC/f0g8mH/xHwReA8dP3v3ubFyOPYnTCM2tlFawjQxKpVR9ufibmEaEqctRyZiitIX6FDcOcTVH/Afhk4Noyiyaw7RhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP+qI0DnNJUSbxU4oLKLfJmVVNSjllEg+OgxlFGriyA=;
 b=WEVhY7VVUuenuEooAsnhmKcXHSmWYXkG5bdjokmBKiBIjszepm6K+M7Sbb+qD50Q9/GrnEkUeSyGa6T/79BFer1zs3bn2tj6czA5/VphMl5tkamUVu82AHNJl2aFCXgl6hgimby9XJXNxJ/HqsDkuXhuAaLxJPHbG6roik/W1i1Xs/OokrtdfeyHfyk1HLxrXOHivDZjWfmpskwPv9pnca8cTgE9KdTjMZkiBMJJ5yVUttNKsXJW6WHhBKYbF+trGfi6FMf9JjCxycOt/kp3d8ouQ4CPR725DOQhfFd2GA5JZTRVKmkl84O63jWnduMV/1p6XHIoEi8l2TdJ2IWzJQ==
Received: from CH2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:610:4f::12)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 09:14:53 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::a1) by CH2PR18CA0002.outlook.office365.com
 (2603:10b6:610:4f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 09:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:14:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:14:42 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 02:14:38 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v4 2/2] net/mlx5: Expose SFs IRQs
Date: Thu, 9 May 2024 12:14:11 +0300
Message-ID: <20240509091411.627775-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240509091411.627775-1-shayd@nvidia.com>
References: <20240509091411.627775-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: b57bdaa0-4e5b-4d69-ca7f-08dc70087ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TG1X/NJ17mrLpQ3zjs2MB9EiQrvuKQPYm2a+OLwZIsMWjxh05ZL88bcuRGwf?=
 =?us-ascii?Q?F1JRkkoFFztOLP+xtDv1X5tTXYlT/0d6S3n7bpGEgwOesvOHKO2yOx1tpWmC?=
 =?us-ascii?Q?lDE1F8rdV7Nre+exOEXX5bFoiua4vcjuXf8n4Y56vX8aNcJMJ6pmoWpCXM5G?=
 =?us-ascii?Q?zVcXmRJPoDsdUgerynJvin33gVB49vUMw4msW9OUlwXfN3JPoMFlyvWyIZdr?=
 =?us-ascii?Q?0atEch8NnZcDJDj4HUqhrmVcJ8nrkN2DJFvXpDQDsrlnPDfGGwLaOrAd/XVf?=
 =?us-ascii?Q?dT5Xu4Nt5WybXibcG5+q4DV6iPz/87tzWxf4FMhm4/1RtA1gApyR3tqKtJp3?=
 =?us-ascii?Q?gFIEMtveyfOkChF6BCSHq4NUr132XAcUP6HCtD1GHSPIQ9D4RN+6b7vLNb9x?=
 =?us-ascii?Q?65Eo6dZjCF6hkd7iYSRtm2ulFC/Fp8ARseqs7iw9kyQiC7iNicTh0OL+HmEN?=
 =?us-ascii?Q?cCZ3yBkLoRViCaM+NixrVAt71MlJnNdPe4wP5jrojF2n60EZRoteXwcMCqND?=
 =?us-ascii?Q?OSNmjZ+iYPvCNr4gULzqPlzvdgcj34r5HLz7bVSLS4i0fc+YTIMG0OxVg1Sn?=
 =?us-ascii?Q?fMppyJSrrlS2p5gg7WZ/zw4ZIpPnHU6e1ipOtpxGRrjr1zcRQQTfc1mviEfp?=
 =?us-ascii?Q?3SMHFavLryX7z0Ab2Hu6IxbJxVGcCYe1MfmaYAtFrW8vAlc/IVPuqvUPa3r7?=
 =?us-ascii?Q?SefRMYOMbU+Y8EvLF+eOj0sQiJGWJndWE9Mk7uENKcOU2pMt1BNJUsQXuDe7?=
 =?us-ascii?Q?rHgq7PKvmPNV8gJIkxdT4UBeeiJYD+7c70LVZdqHQKnnKNLv0m8CQGmIYHpn?=
 =?us-ascii?Q?WazI5fjsiZfSJqBZJ1KNbyhvkX5ldVKJUm1EwG9S6DW94q+UTGzKnHERNBe9?=
 =?us-ascii?Q?iU3myrSLEEiz+y96SCh5YI6CHk1owhTx/vqVkPuBenK67WGJuAV4rGY7r08E?=
 =?us-ascii?Q?Zyr85kGpKAxKQ9Z2T4aVrV2DaGl8CHKZgklaIktBWurbCV2rKnquB+qGdBfi?=
 =?us-ascii?Q?3JOdS4pHt+qaw1w1Oj1rb/49VmfJu32uZ1utssAGyPp6lNuRMM9vd0bPH26L?=
 =?us-ascii?Q?NjKYOOH3StS+47z6WclistUtG9m5O4BrW4Dm2GGe0sXncQkYF2U2P2o/oys0?=
 =?us-ascii?Q?KrVC2I3RCWGeQomDGkeLjXcApTn4ofaU0x5TH0Z+DY09unlg7ff6y/eYwCVi?=
 =?us-ascii?Q?Fm0/Lpwa7YdI70D4U2wNkqk7u7ZkwLi+sq3UZ1gIx6SLc5/Cur3HUtAuN3mS?=
 =?us-ascii?Q?Or/AMuhQ26mK/WLPShZD55zqwb6aBR8bGKRyqyWNeFIRBuD5bSISoH/lSGCo?=
 =?us-ascii?Q?l9HAnqujHgimSwtHMqs/aKy9X+94wwss3SUYMTy8ubIV7zcZ1MTZb+JmZBg8?=
 =?us-ascii?Q?WeA9Y6I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:14:53.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57bdaa0-4e5b-4d69-ca7f-08dc70087ca4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
v2->v3:
- fix mlx5 sfnum SF sysfs
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c     |  6 +++---
 .../ethernet/mellanox/mlx5/core/irq_affinity.c   | 15 ++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_irq.h   | 12 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c    | 12 +++++++++---
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 16 +++++++---------
 6 files changed, 47 insertions(+), 20 deletions(-)

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
index 612e666ec263..9803ab0029b8 100644
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
@@ -152,6 +155,13 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 					     mlx5_irq_get_index(least_loaded_irq)), pool->name,
 			      mlx5_irq_read_locked(least_loaded_irq) / MLX5_EQ_REFS_PER_IRQ);
 unlock:
+	if (mlx5_irq_pool_is_sf_pool(pool)) {
+		ret = auxiliary_device_sysfs_irq_add(mlx5_sf_coredev_to_adev(dev),
+						     mlx5_irq_get_irq(least_loaded_irq));
+		if (ret)
+			mlx5_core_err(dev, "Failed to create sysfs entry for irq %d\n",
+				      mlx5_irq_get_irq(least_loaded_irq));
+	}
 	mutex_unlock(&pool->lock);
 	return least_loaded_irq;
 }
@@ -164,6 +174,9 @@ void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *i
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
index 4dcf995cb1a2..831efde44b2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -365,6 +365,11 @@ struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq)
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
@@ -438,11 +443,12 @@ static void _mlx5_irq_release(struct mlx5_irq *irq)
 
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
@@ -471,7 +477,7 @@ struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
 		/* Allocate the IRQ in index 0. The vector was already allocated */
 		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
 	} else {
-		irq = mlx5_irq_affinity_request(pool, &af_desc);
+		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
 	}
 
 	return irq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index 99219ea52c4b..27dfa56c27db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -60,11 +60,6 @@ static const struct attribute_group sf_attr_group = {
 	.attrs = sf_device_attrs,
 };
 
-static const struct attribute_group *sf_attr_groups[2] = {
-	&sf_attr_group,
-	NULL
-};
-
 static void mlx5_sf_dev_release(struct device *device)
 {
 	struct auxiliary_device *adev = container_of(device, struct auxiliary_device, dev);
@@ -111,7 +106,6 @@ static void mlx5_sf_dev_add(struct mlx5_core_dev *dev, u16 sf_index, u16 fn_id,
 	sf_dev->adev.name = MLX5_SF_DEV_ID_NAME;
 	sf_dev->adev.dev.release = mlx5_sf_dev_release;
 	sf_dev->adev.dev.parent = &pdev->dev;
-	sf_dev->adev.dev.groups = sf_attr_groups;
 	sf_dev->sfnum = sfnum;
 	sf_dev->parent_mdev = dev;
 	sf_dev->fn_id = fn_id;
@@ -127,18 +121,22 @@ static void mlx5_sf_dev_add(struct mlx5_core_dev *dev, u16 sf_index, u16 fn_id,
 		goto add_err;
 	}
 
-	err = auxiliary_device_add(&sf_dev->adev);
+	err = auxiliary_device_add_with_irqs(&sf_dev->adev);
 	if (err) {
 		auxiliary_device_uninit(&sf_dev->adev);
 		goto add_err;
 	}
 
+	err = devm_device_add_group(&sf_dev->adev.dev, &sf_attr_group);
+	if (err)
+		goto add_group_err;
+
 	err = xa_insert(&table->devices, sf_index, sf_dev, GFP_KERNEL);
 	if (err)
-		goto xa_err;
+		goto add_group_err;
 	return;
 
-xa_err:
+add_group_err:
 	mlx5_sf_dev_remove_aux(dev, sf_dev);
 add_err:
 	mlx5_core_err(dev, "SF DEV: fail device add for index=%d sfnum=%d err=%d\n",
-- 
2.38.1


