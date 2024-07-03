Return-Path: <linux-rdma+bounces-3623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED919254D0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 09:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AC2B235AC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3513775F;
	Wed,  3 Jul 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2/EyMei"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5332C8E;
	Wed,  3 Jul 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992387; cv=fail; b=GnNxBUCGgmDHE2oCVVJsnu/6PqOp8kyroy/8sq284PupgosWUok9gbLX5gINreBzlG1+LFsQwroQxR/zanx8pZov78ePhy8QxUDxOMWindA5k07AIG1QS5dd0jpGU50HBsgQnqtN1ydhC7+6nheZqziG6cbCzJLJDAtKbxD25TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992387; c=relaxed/simple;
	bh=sbUGog+i+YdCaGohu1NCzvXpCYmCdFu6b0Zf+wBYTtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egodjOfrjivuJAnD/dHrttWzQ9/oyeb7NzEsVoewoYq3zLa1TNY1coLWwrQRdwurXrbjDyVA3NLdbf/3oOwoEMk/5YiZ4gJZQ3/cahTEIPyI5xsrege4d468h7m7+1O3LMg2mlgXAtwlFgGjeMZDmQGpv8exxIF6EoC5koOvAkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c2/EyMei; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbq874SpdZf1cYdkpuNkp2FYbR4qp8mQYWpNRZVCjL2GsOyUTWDGevnyPDC1WxqkuAhCKH3QtXP8vrwSKv0x0wpz1Fm2WktyGkuDhoGRj8pPb27CXCcnDvDVNj/4OObGuj9Df+/ktOprWp0Gj/bV/O7HeitJ1wLs1nhoe5DNqsFGfKGf1mDfTDldpHOt+oX9uT1jBIqEyeiPoyuhTvySs/wk4K5xdH8ewg5/1Z3584PVCogpzDTkCYv+R1/cKW57lbmJwZFCo4AXBVADGPUERB5HGAtTxiFIwgabJpt04t/hbnzj3yk6zVoz3Kdsg9Pjmo2nK+p7d/NB8BDqaWUNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyLCG9AYi+w7rORP2szilVUiUziFcb0rl5Pzgjcvqvo=;
 b=DvI1tobeLILE+wEIHTIuwry+GYnAbHlbNyiUeCtJS3GcuAwYFvl9E3uy5dhkgh69H6edNQs2AStueLetOwTcWX9IjlsEqoVJIg16d27gwnihXgjE2hOpVVeH9jpD52qiwAQCK1KoCfo7WvQ2YxsV5ULMc9HS59GcI5DXAEQdsFiPhb7D2Qtmg1eC+9jZACMyA+TYaxz4+GiApG9nS3hPScqBxAhJbTVCkSMRjol+u7TYpvqpUn2SJuP1nnc7xesnUBqRX69zYG+bbPaueDC2SpD6feIKKoq9YXRNqW24ayh9F26kiq8BnB524HUHhdblChtMUkcDcwJzFD8Gu4N4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyLCG9AYi+w7rORP2szilVUiUziFcb0rl5Pzgjcvqvo=;
 b=c2/EyMeiDlBcmAvs+onIODhb5VNEBSHkDcxBoQk2+sftCZ117vJryw014dlKdsZIOBXvBMhlu8YVl7awlqNUqpEeMxDq4EeEYC7AvqUrRfOM/bRm/E7EVa2g53WOGLfsjQn5stM5elp0/Yq9Rj4gROxSfY0b5X0lZhraRxLSF1V8CX11yFSsjIB887LMIw4iSTYOeSk6sobOJSGmpaqLBt4jcejdOdWg1EllGHgfcykXC7VwP3cVrzYqiNIcfLzUcNdtzqZv3ORBjOi26cjkuzRTJ1VXT3d0eKYaBvRu8wCxGRWRpdGfpmW4BFI8oeTJToGPy5ONvjM9NSRG7WSXzg==
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 07:39:42 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::62) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Wed, 3 Jul 2024 07:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 07:39:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 00:39:26 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Jul 2024 00:39:22 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Parav Pandit
	<parav@nvidia.com>
Subject: [PATCH net-next v9 2/2] net/mlx5: Expose SFs IRQs
Date: Wed, 3 Jul 2024 10:38:58 +0300
Message-ID: <20240703073858.932299-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703073858.932299-1-shayd@nvidia.com>
References: <20240703073858.932299-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 763aafa4-d43c-4da6-e1ab-08dc9b334d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmRfOsve0EHh4+obNYAd4Du0ro4WaaQ67jTd12BMONlmqis7ikCoSGXQ48Zc?=
 =?us-ascii?Q?bWX76G0SYs8qXDZihukcb8eNPmNHKJ9gnMkjSbHF++vAgNdKsIwiwAKWzZJD?=
 =?us-ascii?Q?X4nufGj7IQpPBOZOKZi0aEnW34fIsEO+An9+QtA5sAW/HiqTJ0Q3T90HzMya?=
 =?us-ascii?Q?PkihpBOB43g0swWl9OEJqjj03rosCghSunRqbxEOCbihRicRrDL77XcxPZnm?=
 =?us-ascii?Q?1QiRn0OFpiVmkV3CDrmAFzRbRQXlKrZnWJI9EaJX+JIUMMPWirq0odZNq37S?=
 =?us-ascii?Q?AG4w7v+UIHJdgsd+qXe2m3dlfbTG5qmwheX3wn/e2A51PpfXUiHfF3vSl52p?=
 =?us-ascii?Q?GgyaH6K6TDyqmIVIUi+gWv2w7X61ldIbEPgFazPVOE9IcYeXcAslivIYEi9i?=
 =?us-ascii?Q?Z9XSwsZCwkUgmMHv7SDZSMaq4y+HfEAYcIcMdQV0VJZc1lbo4CJkHOzr+tpa?=
 =?us-ascii?Q?54c1+DQ+e4smpNsGgP0BbsHdRhnevcIcKGh5m5VKRgSFu0KxHS7/0iDB1Tsp?=
 =?us-ascii?Q?l6a446RFweHST2ujxn2L+U8v7bXh+5XdBxNEIzdQjTabzY4jyIw31JuHTglr?=
 =?us-ascii?Q?+oQpvIN9CAIRILNyQ3u7wwDuXHY2jsZhAo9IB5h/+LpMXqEu3XIceue1cpap?=
 =?us-ascii?Q?cQC8j21yuu3gs3XDhG3cOYecsmDSw665n/Q4ovcUOlgwFf+rNex0Yx6dpq9j?=
 =?us-ascii?Q?uz+0H+Fa+u2hIjmCw3HGHFGTC1VwRmCLEGVrO0aglh0pWXJpsrAoA7u74evm?=
 =?us-ascii?Q?vOPbMSj74kP3zl8R8oWilgxBB4WwUNDZeHet/nbxQX4zeh64e5SCKmn29oJt?=
 =?us-ascii?Q?QOQxVPMSHDLCxED07A90CnIP4IpMxbKpWqaV3KvrJdUa+793QZz7G444qJg/?=
 =?us-ascii?Q?llRneYJ/O4pIlPYGhPPrc6jLSBuh6SmySXDf4XUBwyhx/yJirYcJuzihEi/n?=
 =?us-ascii?Q?SFHTHDtVGSgqGUbd9cqDZjuB9wB44M56Vl6GnP1QqipZQ2Uaw8bcELpIan7h?=
 =?us-ascii?Q?p1zBV/wzci7AYAnmy0CtYDzHwAsrKVXdcnpfgJ1YmwqqARnnMaSp6BDyN3Uu?=
 =?us-ascii?Q?7TJsMm8hbYlQkGjkTajsfujlpTP0KmmHme+vYH6s7z4TMECw0eD4QTU/ioH2?=
 =?us-ascii?Q?DsM2Ybnz8Cn2mqKTRHOOuSOxkMy/zv8RRbZ2PZr9RaTgOOuIaOUUBwkrT1h1?=
 =?us-ascii?Q?egTdYi9Q6E14gigYnm2DyKPnXgxw+ggK4zRmDnfeBhDQxmNwZYOsxmot124W?=
 =?us-ascii?Q?KkYgWKWW4ljZXdsbcSnC0d1x5yMqoFwv65hexYIGmlReUpYT7OcRbrl7QuFs?=
 =?us-ascii?Q?wq6V2MFuJDYbyU01+RfsYcrLtvYcG4Ha2EANKJUdf5xdVfmeCb145CiUwpaj?=
 =?us-ascii?Q?GgYf4ehuPcJZsQvUwi4tNFcKLAbiW7lVWRSwZEiR0489pQwAk8bmvOXq/IC0?=
 =?us-ascii?Q?ilc+GEeMtR8jKjWYBoero+fjsbJaKvP+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:39:41.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763aafa4-d43c-4da6-e1ab-08dc9b334d42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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


