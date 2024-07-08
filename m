Return-Path: <linux-rdma+bounces-3705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39975929BDD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EF0B20E4A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9910A3D;
	Mon,  8 Jul 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YFmi62nQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF1156E4;
	Mon,  8 Jul 2024 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418197; cv=fail; b=XAE0fZzIdoTVqbEerSrdGWD6MGnXLMHEuU7kuRN9gaIYVZpIrvvpp8V9sW951kI5Lhjyhkzt7RYvPOLPI2kdhMh3ITKZjVaU/AII/47mvIurDvQCbjPczd7JQnMGH0JUGYQ5NXd4g48Lx6stE9hIFyMlJhCHlfKM36KdGxi3/eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418197; c=relaxed/simple;
	bh=Lf7bnZQwpbDklWycmIk1Xoo7Yc7NvIfhhCC2EIVnrPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTefHo3Xq7Wh41ySJRoJs3P8XJCQqtRjonk6KYqYq0PEIk53XcLkcnLbsbFBvZIcJOjj9XqRYSmO7fSSEyrhb3SwBRaMz+koYDyvkRZMAaZB6Ajnb5CgFKMk1mgB7vre6yoJGmsZ8DNh9oFNPWgRNkOf3bAmGHSpsw+W3d4n4+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YFmi62nQ; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLBiRF/YQH2ffXvSRH3VvYano+6NTi2dG3Cs8vOFU+DYxLEKuXFqwulPssbTZf+w+YkFkT/qaPSLGUv0+lf/FuzFdG2bZBftApR07o9nkqp7IK2sbud68b0DRJRF3cd+nuE+JIo6+9b6KOd/UHfUCGLwa73dKdCFo5o3zlEeczUwPQp+ZaKnsXbni2NS7oJVorAYVpYc7NUH14BKWpPpApPc6lnlZqjIbEFO4ElWmBVUDNiKvIBVmIbex4qZfsuCjxS61uemqVLFLT7CxKPTH6wbDaZpUxkvsoRTWnveTV6ZDkV3UzD+oVij+27HZxJ/yCIZIbe4MCJGOMu/I41wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwZ+PiTXljCCrA2VLC6SvBqr1GQNrnyuofAGUZmPQFg=;
 b=LKMpQ4XdoGpzNVakEW7XoOvUgdJlEKT+p9NMvR6IWASgnhdwwzmcBP5wnodNpZx+Fek+xg+AHK0fLD6WM3c5iVxVs3v6bF45zbEVXS2b6eVZXAVredh103F3HMjhAKLOBoYIdrIdd7SMk2ap2KtBsmZiYqFwhbHoc38kMMINo7wkZSE/+lUfcakyEzSYLN8VA2kmuTKDqjPb91HBrN8pxk4YGkCAJC872YSt4k1+5qnfroUvqXUhHyBYw5V7rtmkOTcKS1AG2N02+rQ67jOFWI5WYwLCrbMLmQGGaF8Jyn5op54Ziq38j0ueMpsiyS6F7TR4U35CsM0UBTKgtb1sFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwZ+PiTXljCCrA2VLC6SvBqr1GQNrnyuofAGUZmPQFg=;
 b=YFmi62nQzN5ylArcrCG8pSJKd6R9h8a67wIjwelXv+AhGY2+47nVAu+sVquR0v7OQCg//G6kstKFpDuqL2JqDeuFGAhk+ppT4q7DBb5zyppBFDySp6CUzO5/3TrWNb0m/5rCM8xoxvlXvYXrcfgAsSi97Nw+LktuuW0FuIcuqRp5hIHijed4FSMxJSUAc57MIjO9veTTyQ8H2aClvel1mjgQGb7FN0JFsf2hfHR3GUH9prq2pVlUGiJKCHHIQJGdF1vg9RaD+LgXzKrEhF+VbW78Y0uHpg6bV4OrTBbPq0XXhSEBFs1aRVWBXMzCvUbq0qQh1OcnzTzGbfMSC0yBrg==
Received: from MN2PR20CA0033.namprd20.prod.outlook.com (2603:10b6:208:e8::46)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:56:32 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::8) by MN2PR20CA0033.outlook.office365.com
 (2603:10b6:208:e8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34 via Frontend
 Transport; Mon, 8 Jul 2024 05:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 05:56:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 7 Jul 2024
 22:56:18 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Jul 2024 22:56:13 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v10 2/2] net/mlx5: Expose SFs IRQs
Date: Mon, 8 Jul 2024 08:55:37 +0300
Message-ID: <20240708055537.1014744-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240708055537.1014744-1-shayd@nvidia.com>
References: <20240708055537.1014744-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4415c5b2-23ac-4669-995b-08dc9f12b7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ulvv7AxYujeyLPu2pdkfLS8JQ++EiKG87Oz1jjQjgbqe/KIZjXY78jgyhSSB?=
 =?us-ascii?Q?pfK8cVfJq+5dt69FONswy2SvBnFRKjZvslxWV6MzwGoATz8cnxxgx8+wKtlV?=
 =?us-ascii?Q?YXTzPX+XDZaYPgL3dzXR3ZLDdebMqTxeMb1ttGFUF7WrOI/lWfVIa4NjWXSv?=
 =?us-ascii?Q?8QRWBssxFFZTB96gd9zsR+h95Pz/M2TYZsM6z8HZ2eHk4pIrtRXECJCOUE2m?=
 =?us-ascii?Q?Rrmcp2b/iB8oGTPLdDXc+Ei+SYXQlEXWJAXWmvoNsKFs2MS6ZUn0GGhk3LVa?=
 =?us-ascii?Q?XCQptLH8rqSXal9BRKaPUBOHNLEnQ6uJv4EW6vLtg6OQKOMtkhVtYl7XIFgy?=
 =?us-ascii?Q?9U20tdqVvEy/oR6T9xzv9o5BplVhkujVzUXN83ucKgW4Vm4kPc6KdA6etHXu?=
 =?us-ascii?Q?1breul2Svg5DN8lWJX1NgOHCGJXiLbgK8J0T/F/ziiEAUlokcJb1LRJGp8lC?=
 =?us-ascii?Q?2PsAC9aSR8Uonv7O81X6AMAWtDoyKM7JkqleGPkY0N0ziO3PSa4AKsKHJkN0?=
 =?us-ascii?Q?90yS3pcY20sDYrfx7+t3H+HbEOf9UZI4sSQXWPjHQAee57xGOgF5pNHWlAmr?=
 =?us-ascii?Q?GUmmd3buGK+ldcmS2A3NF6fBH3ZfOLGp+twdUq0ZB2QzRep+u7v9H0NbX7j2?=
 =?us-ascii?Q?LR7x5qBIrhwWlIgQadi/EcY8Zhod0HHRewoIzmlE/tyPtuar8I88xKa+LsQr?=
 =?us-ascii?Q?YzPLRa+RgEt/8Gb6+KXmraAiMp08KhjPwAi/RYXJouJv9naFYBjtL5KSsoVG?=
 =?us-ascii?Q?2Laa2HznfDvj7XbSatTvQNX1XxKmZju137U15Lf30YEl1b1J0JWoaUZSgO0o?=
 =?us-ascii?Q?CeY7PY8OfO3BeGclXv1EBqpgkb+iCmv7YFoNp3xwqZeQmnYtJ0MucHFDQYj/?=
 =?us-ascii?Q?7F4wpDmJpA6zj/pHEI72zfTi+Ocb0NqNWevYa8uUEC8Ykk9homQgzsJvmMzv?=
 =?us-ascii?Q?oeC70Z3LgMU/zkim3aSTv8TDUqnkUT9gjJWNr83R/gzFaiV8qZNKSlJtyZhB?=
 =?us-ascii?Q?RA3EUOtIz+IM7F9YXb3RUwEHxwwWSrqxN70L0IstldhVpTGGLd8FOU3ZfKF8?=
 =?us-ascii?Q?MgvZnATs6ooAHJr8AnWEoUJ/MDBFnk/aiv8ZXCrI00Bu35V98wYfmp7dnCh/?=
 =?us-ascii?Q?36bGz7KO/fgGe81T/RmhFZzhkl3bGNC5na8bQgy/r8Fbz0MzeDpree+P1O/v?=
 =?us-ascii?Q?GbhqRaKXA4Jra3aXgWLo3ZFrugInw1cIqHcRSyj/G06qeMHNQUZvvtAWxpfw?=
 =?us-ascii?Q?PhRfaLvzQlVeyPifl4CgojNGqlikr8IhEeQPg4y0Azr7XSvyFuJKwOwH140f?=
 =?us-ascii?Q?c7n2ZYGHYiDVPJnf99H5dgsIoMDDGLr4eUHkxsWS3r8fujKkPBuX8yexyjU5?=
 =?us-ascii?Q?RY9ZCswn5Y7aJrn8TDjZzzl38Wm2GwTCKqWz1xb5k8etnykDBkdaw2XYSq0s?=
 =?us-ascii?Q?qJRwW4WqpGGe7T2/axGDJXAY4XnVCtmP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 05:56:31.8948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4415c5b2-23ac-4669-995b-08dc9f12b7c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
v8-v9:
- add Przemek RB
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
index ac1565c0c8af..50ed23f9ac6a 100644
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
index a7fd18888b6e..62c770b0eaa8 100644
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
index 401d39069680..3a9858111701 100644
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


