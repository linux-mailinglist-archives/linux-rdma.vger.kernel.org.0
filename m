Return-Path: <linux-rdma+bounces-2624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385988D16FE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A83E1C22A2E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FA13D8A3;
	Tue, 28 May 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYAqvC5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9C13D2A2;
	Tue, 28 May 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887618; cv=fail; b=bCKV9Q0zyiD0JpSczY11lGtL4IaSmo3Ayln2e2d4/QyORIURJP/NM4ONS9gTU7XKm6kOXGDXGv99kAj9PAktZ8/L4b8vGCoUg/lhUVI7GNIvjQx+DjEVVsqQgPmdFEYnCX1OjUpeOC6lnsX8ycXqEmuDn19V15gCqx/9ebY98e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887618; c=relaxed/simple;
	bh=n80/g0gAcqEjHUSk3FigMlJTdjjBQLK9xp3MT1JdN44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIJ4aeXBBBBrS0rOfI7xCZqZGpG4eseEAHSkZPIAw618a4M/cWE+9P9bE/7+sd29XvzFOYBCLNm8BlhlJpVGSf7n4SVoUrkMzU0YBAO7ekJZUYsBq0UNJm6T2S16js3hcQQVvsNnFnBpxRQp56D407dnAuCh00aB0uoYg4J4G8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qYAqvC5o; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISCMH6D4NmNx9Ny+C4Gtwhkd07B3sGsYaNNCTjV1feXEmYvKJklFmZArPVPgI+h3h5/brGUSsk6hl1JzYy28frBHUW44usUVeI13jngq2ak6H1taZuxSeCcNmSrNxn2YuNTJ1GqdKlCMEo6y3zqFfp1gLKjgHuOTdPh++Xkk042iH4jdWjDxo2x723dTXBEHjr4k0E8mj0USnyq9roe+MI0SZc8Y3U5a5H/A1LPHSfTXkki1nWLyu/ggrVTXa113zajMqZGuku4xobUQztYWenMwAI1g8TaweAEjRqJAYVZrRQq5IIovMLwjYdYjHzx7u5obVYxUzpkGykpAR2sC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZGOlHcisXfcvg3r/fKMi5w9BDss6MPukS9/v952m/E=;
 b=NoHqhboBa0kbmZ0fw6qPg1PLeOBsBKTLoy5Gn8K4KANB4P5lVgSJY7cO22n08/AcNrKETJjIWHGOFuPGInsq4gY7G0qD6OA9UqLLVcrRcTKyVNLaGQUnumTr4mPSMRttguoLJIOTKhl9CZlzv8fsKiJIMLs8fvjbfuxNoE3p+R+RwsbQV7MBWkg1oMECLUhgT0Cn/S7i9oee8mEh+pSOtMnEJpzBt4TS3Z5K8TmOCP21UlAFu69EZSicsC2OgHBqJLrRwgZMl04g13kRtCcNg5HWjzbPa61VxR4yGKpoQTY047z7MI7EiafSC+LGD4/5syWWJxS7RVqMm6AU4/GEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZGOlHcisXfcvg3r/fKMi5w9BDss6MPukS9/v952m/E=;
 b=qYAqvC5ozohBKdCZbSXYg1y35THSzVTOtFqsLTxkgXD5QGWE6usE8nnHVw4eEq0WbusNH3PoSvlnKteab+T1IuEkzSt45ZP164Wx1jGy4FZ5VMH6JdyVO4e/L8B2YJh31FcI9zECQ3k7CouMv1pLGI7o61WCx/+ELlbN93UvKQomkEHF/15JBkUnKB0mjfxGFUgvgqiWxP+Uar7Qm8qG1jsbXOY1/oSNhK7U3CZxhE8Da6Ts9mAvxKxVzC4B9eIpO6stHY0VzN9oBBF+o3Pm1MMtrQQCX+XPB3XjvhrZQN13Wb3lTURZH01UTJXNmqIMLg6SL1LaGAr0ywFWVJf8rg==
Received: from CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::24)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:13:31 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::cf) by CH5P221CA0008.outlook.office365.com
 (2603:10b6:610:1f2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 09:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 09:13:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 02:13:18 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 02:13:14 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v5 2/2] net/mlx5: Expose SFs IRQs
Date: Tue, 28 May 2024 12:11:44 +0300
Message-ID: <20240528091144.112829-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240528091144.112829-1-shayd@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d94c18-1c2d-437b-07a8-08dc7ef671ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbxWLG8zwlmAZkxnyYAdjBtNuGpmEbafykWLvQ+HbAbRtlAILpuRCFi5+huU?=
 =?us-ascii?Q?YrrQIHBe1G1kNZ81ELcvFsa78jWoNub1+whsiyLaw3esOXWqCYT8psEKXZbq?=
 =?us-ascii?Q?My4AzH8uysIaqzb6C3Ed0noT1EyzxjRMVHkVK4EH5tWX07hW1DysIVHaVfVH?=
 =?us-ascii?Q?wAzZjuwm6bKy7OUH0iVOyFiTZAamNSAImRSKg5xb79CPkARWVYd9wTLo6lqW?=
 =?us-ascii?Q?7l8NVv9D/48ETQ2OaqH+ZXJVKrqly4bwq5qiXTgDZqbg7e5XengM7fRJ0lcf?=
 =?us-ascii?Q?l3pHSNStuAVkqP3chm0QSnW+Iv+8rYrVufo+nLsb/8zFXSCgridP+xxWSHYS?=
 =?us-ascii?Q?LWUOUiyBrGOe8C4E1Am9wRYtmmcVDVG4gad9Fn5wP4Td6SYYnmD5nqTvpXU9?=
 =?us-ascii?Q?aY4n6cP+/KmYNyEiyTCTFafdtA9KXtAddQGyAwrsYvVWMXaCNdk4gvjdFFne?=
 =?us-ascii?Q?V6ovIPfGe33kNwAw1/J3OyqiHL0e4C2OemG5ljYhbks9N8Lc4XX6oobSoCAw?=
 =?us-ascii?Q?P935iArJhfg06VMvfizeaEQSkamFU/G0BOKayHbv0Rku33XCqVs/YlWwmqfJ?=
 =?us-ascii?Q?3Zc6EkzLTMTy4TdLBrBt5HzzzuKTkNbueDLGp6Lhu7psj7g/4AAiV++HCfYA?=
 =?us-ascii?Q?MIyFFoppEU+mPFSj71wiKkxhQVmibOomk5Sa7eUPr4gtSAyvOKT0ztT5Zj1n?=
 =?us-ascii?Q?97Opq2KQKqtOvPS3WDRQmTFP8DOHRZfzzPTaIOIMcU9G1V43SWdipDua3L4E?=
 =?us-ascii?Q?CPMTH/RT+dxIRHI//ppOXisNvDNFXDxfebO7TDzurzfEFRE2KMAIS8VcTK7O?=
 =?us-ascii?Q?adecFUKfPIECp00Z8qhNFExSqQJK5YwqBnN7J/iobcaqsPdIkh9MGeDgaSu/?=
 =?us-ascii?Q?9FEwio3M+FgJyyo/nHwnQf9CtgAvGoFrkFiJ9SoN5lLmkkBk+ljcfMZfaARs?=
 =?us-ascii?Q?EMWZgD9NrYoV4rZY7bJpKSDPU9jfRrRYPfh0++HQwx8URHBpl6ELpXRiLhaH?=
 =?us-ascii?Q?13pZg3XUTRkejajXZyKOiragly1K+DLMEoUXDzQyoX4KPHspMOPW2bfHw/PE?=
 =?us-ascii?Q?iIo3RB1Lq6oi1dWEM4TPU/0AzYsMhdjJJ2sbSjyLY8v3mjs1Wjt6Jy+fw5Wo?=
 =?us-ascii?Q?fM8nAg9KyWvbOua4nRWu4KgZ8rsWKhQrPRMCUiO62KbRbKf80i0nheUDgAe4?=
 =?us-ascii?Q?uet2s18Y/EmylYY4zRhKr0cA/vE1BJ07yuFiygyRvXJIJepcg9mH9UV00yIw?=
 =?us-ascii?Q?dNgpPv2Opb71BGdmtEFVXuoueJ/O8lDKfcEPNLSbHmcTpxC12uxq4oAvulXR?=
 =?us-ascii?Q?FM1Xtf4ROJqD6duXSNzmHNcePGSFVn/FFD6O8rjDSgdxXNozK3Fp35j2M7X1?=
 =?us-ascii?Q?NkJHZrM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:13:31.2359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d94c18-1c2d-437b-07a8-08dc7ef671ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

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
index 612e666ec263..5c36aa3c57e0 100644
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
+			mlx5_core_err(dev, "Failed to create sysfs entry for irq %d, ret = %d\n",
+				      mlx5_irq_get_irq(least_loaded_irq), ret);
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


