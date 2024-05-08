Return-Path: <linux-rdma+bounces-2336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61668BF528
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 06:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C6A1C238BF
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B815E8C;
	Wed,  8 May 2024 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WwjmOfdg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522A168DC;
	Wed,  8 May 2024 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141141; cv=fail; b=gJJDg6h+QSKM+e6LXTa7mlgJc+9a+5p+tNMdoFB/sTnpni5a0WBo7+TYShfkBQ2QzRHl1JwXrD8+OZlKSchtHGYXnhDzzO8MzxXPqDG0kxCb0CeCGZJDy/L1T0cgvfJ2tecG4FnLEtkjNESyEzddpKo4fxvgGpHNotD3b5ntSOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141141; c=relaxed/simple;
	bh=RBvCj79vyynGwsDQGy+kuamZmRQsDItRyv9qMUJ/F48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+yPi92TUQvlVXNWgocCchd7xJJAPfQC+j/S3nxz/8Fq6JfiPitJFznNz8GAJdVRRmJkbBt6EoIIjDE0Lvcu+r6VXFYA7TotbYo2Gk/ovX+5VGFxWtzsT3API+cyZc39Vqk971wGMzbSbXzL+JFcNNqB734MPHFbKJLyTjza+Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WwjmOfdg; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWN6WTHq6lbzZ5OWNc3a2fugSbSG9YDu7LBEm+Hs3mQRpAg8RxS9yntjQ7Ylicb20ZVo4+5zF/1E6YZB5ym7iMz5wMFLVKTnsNN7DDxaY2OOqBI3DINHvebRAxnFYE1evLuZRO0qtgMC2Pkh038NtlXspkTOxQrIwCwH0ztzGD/V7sQiUmtuDwAQzgjoCe0AGuflolKFEOiPm8az2ysL6OiWnwXqUqx8ScObd5DLyByg58gkIuASYS+fbhXUH+J74lX1VBf0LQrBdDZ9CKhwSsP95gtTosyj7mSxBH3YR+TlT9aT7/wQCo03pdBP5cQ3j9lB+aHxXYJxjmt+ZCFmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP+qI0DnNJUSbxU4oLKLfJmVVNSjllEg+OgxlFGriyA=;
 b=RUmOFr/cfnXO38iHEmSAfCHEPoRB5ew5EfkRWn2YbvD1zU66DFjPGcSTrhMkdp6NGPcGlNh6VZZfcrf4/yWL22SfVidm1D/1M/rdMBDy4CDa9hf7dki6HFQXOZHiaICDTN3Ya3F4pKl2kNRatvtAaP5RPm/zTLFD0GHXtiq22X3enBlbYRjiIxkGaH250eApjYScgmBrdi098YEqWMt2zArWGdSf22t5rtO26x4EGX8UCTXQcJ6mtDbUNm/SASU98S0/H/8i21SKN1Gmq1zDN3hQchFHWzuuNqiQztO33XCuliYVrSMG8pSid87WGckBP9RDupNphHVMD/66LWxJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP+qI0DnNJUSbxU4oLKLfJmVVNSjllEg+OgxlFGriyA=;
 b=WwjmOfdgtEt2i4iXnGTPp0fBfibsUflwoaeEJR5N9KLj5p/DeBu8dxy465Xi4R1uBbvbiquXAmmf9llmbMLfA+LaMqyICte3UWMSNPpTFLOCubbHGOZ/le9HbxUvdcK8bAbCE8VpJ3vCm3H+p7WLifhAanH1jn0D1dorscn6owhE/u8C87SJY5VMv95c3bftLKzArqwebXgcF7iE33AxVvAXDNxFBa3pAcIaI0ZJkwAfWxbPKCerDJAz1gfQI5+Ker7bnrb6YtyH2CDxk+w5LwVuiaJ5rYBJtY6El37FEscfdmP50/PR1ZdrXj59hcTu9OsjTxa4mc94w7dfD5npUw==
Received: from CH2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:610:4d::19)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 04:05:36 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:4d:cafe::38) by CH2PR19CA0009.outlook.office365.com
 (2603:10b6:610:4d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 04:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 04:05:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 21:05:17 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 21:05:13 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v3 2/2] net/mlx5: Expose SFs IRQs
Date: Wed, 8 May 2024 07:04:53 +0300
Message-ID: <20240508040453.602230-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240508040453.602230-1-shayd@nvidia.com>
References: <20240508040453.602230-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 289960bc-cc44-4770-2705-08dc6f141d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CL2yysK458X4UEkJrlcEnj1h4UiDDZs8qGcHCgwIeDWslnZo14ijSNsjI95?=
 =?us-ascii?Q?V8WSubwPBH20piokTlwJcfYeAwzmqfy7EJGcDZXdxn3elWLJTnRTQTH+z1Q7?=
 =?us-ascii?Q?U8uVKkPxRJN9TSpLFmRgOwG/kuP80O1NWnpVlVQ8XNy/3hBA5WNNfW5CfFC9?=
 =?us-ascii?Q?Ygi+1IcXBFpPdTcvnM2hGd85aMKCQkAMz3A089YmeE3djsYloxjToKaBQWQD?=
 =?us-ascii?Q?7yPYvbOkM4td3O2OTF4CtXR9WoXZZ09lfb8zaoF8o92Fi0zudGg/QUZZGp4/?=
 =?us-ascii?Q?2pldopuI/yMJl+XEnXDdDRAoRIYCmb6RIvULPpfLdW1nutaWBThZPBaBg6eI?=
 =?us-ascii?Q?fHvcWWabk1rPnd3KQdpgomJXajx2oKr3MwA4i0W88dKS6mi5nrCAX5YHF858?=
 =?us-ascii?Q?1ml0wm0B3yPVOFFBr25WO1045EMW9y4+5M6Dt5QU49tIB4mRAiVvBg1IaI6X?=
 =?us-ascii?Q?6/WcC1lCsnFCbZi9qqXSPFiD4DrCPeKgKPyzFnjBa74spEdxStCADttBYMnK?=
 =?us-ascii?Q?JH0ofvjkihB3mF13XcrncjZp5tJHL2c0qt8TyjsUldtexKIu62y5KFd5FeYB?=
 =?us-ascii?Q?jVCIGbuO9ZFWCHVDAnpOu3slgcEv2RLGZPR5TxTCkiwGcCaNnwV5B4kpg+b3?=
 =?us-ascii?Q?J7xerEA+l/RtawuEPJzE7yQsr/soMAhzDXBmy9VNTieywFCZj3cMpibbdKZZ?=
 =?us-ascii?Q?QwZ/RhYKnxS645m7yUj/PGYmuXL5KCbQF603MVaW1ff4uLSw4mTMoaqY4aL4?=
 =?us-ascii?Q?+vqFq5XZpZ4lnSPApNcyh1yOAwaiG+4UvkgJX4DobeCh0wgACxaijqfEkk6Q?=
 =?us-ascii?Q?avGZUfH6GsjoyPo9Ui6fsFz1ZQpZg28Q34nvlQjTlnlAZ7WoPP+GA6GS05tC?=
 =?us-ascii?Q?BqbM5kOkqly88P28nZhL9mpbBO4HfQoDNIMyMaXChVimkCoEhmtCLX54ZsPL?=
 =?us-ascii?Q?vgkCqp3ZRaJVMd3GGVa5rH+B7PgxO3FCHApOGHheav9cNuKzJ1fQKPKdkWZ6?=
 =?us-ascii?Q?9feGoXj7bNZc17UWqisgkRu2He63pCaJrCNY5Y+8q9SWrNqeIAmXzffF9Jb1?=
 =?us-ascii?Q?yMIgN94MMFYiC7u6mmi5a5AGO+GfPAJq7y4NURfe0zh/ZZwPY6gehWulJoqH?=
 =?us-ascii?Q?Doac55tBMx5OWH59lLRfZ1vFDcusNbzFlgSrFP19r1rtQxVxxMmYwO6Q31uS?=
 =?us-ascii?Q?ivfqJUh1FYA6o2gr4Sbn0Zdrl3BNG/0bFRaEn232eO0355nnXvLslpL+WAeU?=
 =?us-ascii?Q?1r/oJ0WbThL9rHGtAb6tO11YyYlWydy2K9VVn4OO1gEua4VW859tVR7qhmZM?=
 =?us-ascii?Q?Ca7axwB/D/hBHVbzBjUBcOHiRo6W4uBWDR2RNPkSsAKoIAzPdHSHs3xyFpzQ?=
 =?us-ascii?Q?b4sCy40=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 04:05:36.4613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289960bc-cc44-4770-2705-08dc6f141d96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

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


