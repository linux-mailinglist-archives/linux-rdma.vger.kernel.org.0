Return-Path: <linux-rdma+bounces-2230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1648BA60C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 06:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB71C22229
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 04:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4922EED;
	Fri,  3 May 2024 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3+wn3Vd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B978ED9;
	Fri,  3 May 2024 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714710706; cv=fail; b=YjKNOyo5wRsQRFlNYJ1lKKlTQk1J9hcBpqVNVLQcLc396RBwqujbZ9IZo48GSAY7WZiMMD1pdY0dnedHX5wdpoDAjs/DYZy7EWKh9ZKfUDL/PTYqalkBFpRfVQrgeJCT8veklWTjwAlrOnH9a1XNrlnInlxMRjJhErM9Wfv51Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714710706; c=relaxed/simple;
	bh=UkmuWBhgwe7W7Ey7mLX0XsK/Piq5HUsvs6fk0gg98YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4KstOW8LGK7hh2KU4kscnLCuxB232sZY8rMcFtsmdI0GZq+edLvco7cLDmpBpS9s1JeVujJMrWruNHhc3LMdz6VRt+G4mNYeNZJMKomeFp9k/5kLenmNpd+1DrZSoTfed6NDDGVD+Bex9VU1b5JrGVjxOVnHogLAqo4JmSK48c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3+wn3Vd; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfyuIGrNtFzgIQ0xd6nOrLjDGLhHlmC3KKzfJ0NO81htRGAfJPfFgLuccLgU23aRi+LEiVOO32VtEv5aVdj+XoSKr/C6MJauUsmMGvRYYd7gsWtHOPFwu0bpxdy4HuRWfFHFPtwG72zfKDjvPR3t6c74Fibvy2GOFdqMzjfY7lFsBlj+uZuu6mYdGx/tAaNcSgaBzri8cvrEuFGQtYIIXrRIGKWEhdpWi9nUT507L1WeIEuCV+k/w+rdYGDK8pA+mYWJUp8ITF9BBzvEhSyokp5MFspu3QkzGLdEy0rr7hcFT3/3OvoOjFfsGMXxVwm+zqEbNqbikL1fLHPEmDfc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88q5CsuIipzXnJmRy8n8Ex9QsBkf5TgTwqR37k3RL0Q=;
 b=SBZp4FT+xn+CrjO+2w2yB0PrSnqNLQu6ew3U/zvywp9Y943H3CYzpxnCuVpiwdleYCqH/CviOjXDCK6HuKWtMc81GeGoFRGGJR87oW3QRiBG3sH5BZQHBpxnARtLTaN+/doNpN6DyuibXhJuGS+rDCDcbINnU3d4dgkUDBwJlMUYNW8c/balxvyBK+ndBfzWMl0hWJQIxKEZItlB6nuzPaLVWgXXD39PlCpRBcDgSyGLbjaH7orojaIQ8/OMgSOp0fH4wbcMHm/sBtpqeKlpnB6wKKsITJOhSrPSI1rONOha9IPgynZfhbp05OfgJl01Q1cTlpbMf64GYfdU030BHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88q5CsuIipzXnJmRy8n8Ex9QsBkf5TgTwqR37k3RL0Q=;
 b=W3+wn3VdJusUWQJElnXjZTVxswDpc+wBlR4gK76xIfCrI4r2mVAW6UE/rwe5KW+GEYXjnAHqv05LflWfZKRA48ZMdNIerkMMRBoq9Bq9ruCpIt2MNce2gSrII8XvC7wqDMIJMCqzLImGHmLqRk8CTsR2hK4l25Bga3D5tRSG2cFTe1iIf+sWfYPe6Qfw4LUAdJrYeQo4toMGMuUuKJ42EPBKOJ37gVW9p4Vxp50kJe1PyCXXzFzVdWtkX8QmrtCVMsiTFNaN2s6Zx1cFxz8JVkjpGApzhm/PRvHWQwMiwXqWLhhi0ASpX6CmpgIZqyO1avkmNhdqk4Hl5NxsydDWaA==
Received: from BN9PR03CA0954.namprd03.prod.outlook.com (2603:10b6:408:108::29)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 04:31:42 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::69) by BN9PR03CA0954.outlook.office365.com
 (2603:10b6:408:108::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Fri, 3 May 2024 04:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Fri, 3 May 2024 04:31:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 21:31:29 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 2 May 2024 21:31:25 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: Expose SFs IRQs
Date: Fri, 3 May 2024 07:31:04 +0300
Message-ID: <20240503043104.381938-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240503043104.381938-1-shayd@nvidia.com>
References: <20240503043104.381938-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7014dbe8-2575-4b8b-507a-08dc6b29ee99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bc24N7qhdgpGl6RtNsxq81O2nX8ufwt2WZZMbX5lpd1aE2Jnz9XLtLCBoV07?=
 =?us-ascii?Q?WNBXBZusQvfrYDFpmdzqkFncdcrLWpFIYTx07jAQUwjfVpe9cVUijMsoMNYa?=
 =?us-ascii?Q?1JjyDxrGyyNRqXH7eTCMTZT2+nmAcVj8PHqDP1HwVkb/TXeMf1HcxNsIpvy9?=
 =?us-ascii?Q?iU68YmZbXknxbimrl8ChCcVb253YmklCfpH/d6JQX6447ZXfYadaStTZYqfX?=
 =?us-ascii?Q?Mmw3Yy6RzY+6YzoCMH4xNJcmhOnXUG9gxYa2ji8SEHtfVwt7FFq450NvS56k?=
 =?us-ascii?Q?5yOrQys19Aluf7nR3pqcKyfCrQOCWJUZRxrzE21zwODPd+bHtOT84mVXQAyf?=
 =?us-ascii?Q?at3wCGImYrRrHrc2yUggl6BVOZli6Ke2uVYLawSvXenOLuDslbL3zbnKK1o8?=
 =?us-ascii?Q?29dVweiVBUinCBeOu3O6RS4JkFv+CqOqc49BNng5ifoCZjtivDoA24awG26d?=
 =?us-ascii?Q?plV/zwp/k62cTnMoI1UCT6gjj82W+sJXA52uIgPNbioFU5xRmvg+BwLbGL3y?=
 =?us-ascii?Q?/esbrf3lNvZ3UcJIx08gWX491qCAdOFJhpebswGcdraJlfqStkd1v9euTf9P?=
 =?us-ascii?Q?E0tn7sjgG62j7il6h+VtJ+Zaxc86p9sGA5NFNfln21VtRcdbuGzlwr0DiMGe?=
 =?us-ascii?Q?oSJHDTKgPvzzKFMSPJ92CJ0YdjKMV3AlksW3zrrKzniBllyOLUrQwyZI3lZt?=
 =?us-ascii?Q?HZyALH3wxl2ml3+dg0/g6Jz8EzNw8DF39wU0XuraYx0zKdYMKD/NXcxHY6Ya?=
 =?us-ascii?Q?RtKdxLCFNBGfwOoaQvl6/LzpKt/ujbc9mzVjURPlyKfWgC4pSMtZUhBy8JQp?=
 =?us-ascii?Q?lVZtDTMT6g7XFIMoA0XaldMBE3KZyLDjrrNiRacqpD8A22Tfu656qnMULHQM?=
 =?us-ascii?Q?OkFs68YaN7YyX561M2EcPXxK897O+7rbqFYqqZVi0A5vphKioOCgvd7quauO?=
 =?us-ascii?Q?3DSARrSTeJMRaaPQK2o5ljkOwWrpG5ThB6EDFe5Q0Q1NWck5B6r9HiAcsbM2?=
 =?us-ascii?Q?NvjSxlKEVBgk9tD5SSZcHqUQh+UgBFIQjdbYD4eNvL7mjS+8p1ZCEe+NgS/f?=
 =?us-ascii?Q?kBbJq8ptrFUj2i1ck46703rba/3SfAZCf8I51VyTVi+vVk3RHJjDTBuCNNIS?=
 =?us-ascii?Q?4BRVhT4IKbWmwOP+cXY7iqRj83aqZwOIA46g0hkMp5TXhF+Cl18hF3WBKgyK?=
 =?us-ascii?Q?+kTF9YMKs4hMe7O6iSkur/7RpjFfzPrtb+a0oF5bO5BfJSBvxwhRiCa42RUQ?=
 =?us-ascii?Q?WIfweicpaM6rVYaaOxTiqkZNQTV9BXqDwi+k9F7QXfi0O4b3eK+4KXZtyCFG?=
 =?us-ascii?Q?G/t7eZ5O4ESZCuGpo/FOMMlgKgxTFZvUrupMQnqp/MAh+eNeD+1YlHkSOYLl?=
 =?us-ascii?Q?rxgt2D8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:31:41.8592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7014dbe8-2575-4b8b-507a-08dc6b29ee99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c      |  6 +++---
 .../ethernet/mellanox/mlx5/core/irq_affinity.c    | 15 ++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h   |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_irq.h    | 12 ++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 +++++++++---
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c  |  2 +-
 6 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 40a6cb052a2d..85b93bac2529 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -708,7 +708,7 @@ static int create_async_eqs(struct mlx5_core_dev *dev)
 err1:
 	mlx5_cmd_allowed_opcode(dev, CMD_ALLOWED_OPCODE_ALL);
 	mlx5_eq_notifier_unregister(dev, &table->cq_err_nb);
-	mlx5_ctrl_irq_release(table->ctrl_irq);
+	mlx5_ctrl_irq_release(dev, table->ctrl_irq);
 	return err;
 }
 
@@ -723,7 +723,7 @@ static void destroy_async_eqs(struct mlx5_core_dev *dev)
 	cleanup_async_eq(dev, &table->cmd_eq, "cmd");
 	mlx5_cmd_allowed_opcode(dev, CMD_ALLOWED_OPCODE_ALL);
 	mlx5_eq_notifier_unregister(dev, &table->cq_err_nb);
-	mlx5_ctrl_irq_release(table->ctrl_irq);
+	mlx5_ctrl_irq_release(dev, table->ctrl_irq);
 }
 
 struct mlx5_eq *mlx5_get_async_eq(struct mlx5_core_dev *dev)
@@ -911,7 +911,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
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
index 58732f44940f..469d86afbfb4 100644
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
index 99219ea52c4b..39fad18fc58c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -127,7 +127,7 @@ static void mlx5_sf_dev_add(struct mlx5_core_dev *dev, u16 sf_index, u16 fn_id,
 		goto add_err;
 	}
 
-	err = auxiliary_device_add(&sf_dev->adev);
+	err = auxiliary_device_add_with_irqs(&sf_dev->adev);
 	if (err) {
 		auxiliary_device_uninit(&sf_dev->adev);
 		goto add_err;
-- 
2.38.1


