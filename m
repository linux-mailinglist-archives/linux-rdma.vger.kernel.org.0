Return-Path: <linux-rdma+bounces-3123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9990782B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238D8B23516
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95E1494D1;
	Thu, 13 Jun 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HfntwMKS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C52146D68;
	Thu, 13 Jun 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295655; cv=fail; b=EkUy9rDGTcBGbVaWasxfh0Fdy1qmiSzJw+2ueL+H/swZdZjcQt2kFsMm4qy1eMkwpo/IuRrSOpqcTaFHuF2x2Mxushz/EPG2tQfyWcCVQmBpeER/B1iAxILbv8bWpe+z6KsB6aYt28XSn9FVLoOxW95mMPT6fSIadOymK62GUi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295655; c=relaxed/simple;
	bh=LG6vDOSbe28cJzGdu6NQ29M47/EUeXJ+VHxswYfzJjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGQOpbEtb8223JD5BQh1cOv/67Vf3gWqAz5lCvlwI0KlKJvQW+EOV4mh8zmXL7bDVeDIWT0qJ/AaXG3w8l8wpbnSj9hOD4E3IPm3L8F2bkfLQcomYFu+Mz7hToiCJMwZziaEGpq6uCoCfXkWKKtbOmoNCZGofjJnGn47i138cHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HfntwMKS; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5YOxyy8pDE1cqJosAjdMzD1b/6YKJ1mO7R/kVHOc46/xOVNcEwCruY1vFmm7llCAg7Et37AOw3mEP/UAIpznTNwLH4ILbP3WaVDMtUyMM1gr2L0zDRKCbUtOjTFwZwViG2CJ8XmkV24H4gN4mZDf6FK5vYmOUBWAfvy+oKtYC5V9Nl+XctEkFPUUnYYaSEV5H8deMQ2H51TZcILXvk3SgrpKDG8qAlKj9lPJhKsDIQxizEXA6PA1170gx8f9PMG5w1CgCU6ylc2TXPPy9dxmjNGjj5dXNQYLZjAwCM2DPHn08FUvU6dwTRDb42s6efQgCAPHG2YYB9OSbKznFLv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya44U+ik57YqgFGF1fpVlBRJNIJ9riluAzX+fgUsAhw=;
 b=C4cnMLh0FnMbU4Mnp4QksFRcIYWt1W/ypa9vREOu4nYLZpJyYSxjtY5zjEbeCdahPLnggBsop5fvFVNTXE0X2SskW0Q50Wjtk2oct3ywivUVLEFLteOb9MfDkys7HpK14gP1oHNJMyJXspldrSvdB+sQvJesSg62BUHELXioXyykCS5I+Fl+AE4OGQ/RnXvgeQZDjwf6T6V193vADuXZBHjlhbIittGMn8KqxmElNJ4Fd/TWgk9e9FWxkZVXYvo4W/IuQYzzpu+Foa2FBlwbPuN+00pMjsRyb1Rqrn2LTNPpcDTznK1KaQ/rMq5qNXSCB9U04M23jWE++ZV7dtlL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya44U+ik57YqgFGF1fpVlBRJNIJ9riluAzX+fgUsAhw=;
 b=HfntwMKS4Rz1xPWxf3ZdvY6F6A0lt8aUlBqL3RN6Dtj/8h4jlOE9cXzt9gBod34wUd52IE/77IY6iuy3xqUP6FSa2LAMcYnZwo/nNBLKe8mNfqjiHZmJ12GIc847ox22eXFQW8RalUYJcYgFuRZjoe984NnqYmM0yc4Ad2/CwBLuIOpn8gfd6env3l8x3T9C7jzmWPYh7tTBcy70U9eSaGtmP1ofW3bXgnpwRllgiI9JWMmbDshbC7LrI1naTd1XXZVtyjKnH4sovx7jEYeS6yjr1BRRiWfrbnlOXuo2laWIlJA0zLdeQKApBq3fZnMQGQzbPb3AyDm4AXaTnqxopg==
Received: from PH7PR10CA0021.namprd10.prod.outlook.com (2603:10b6:510:23d::20)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 16:20:48 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::6f) by PH7PR10CA0021.outlook.office365.com
 (2603:10b6:510:23d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 16:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 16:20:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 09:20:30 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 09:20:25 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v6 2/2] net/mlx5: Expose SFs IRQs
Date: Thu, 13 Jun 2024 19:19:12 +0300
Message-ID: <20240613161912.300785-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240613161912.300785-1-shayd@nvidia.com>
References: <20240613161912.300785-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a647e-7164-4220-bc94-08dc8bc4c937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|82310400021|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYQwj/LiY/W3FM6u+LfB8VGp/BQcJKO10HXtXxqR8E774Nx/eFU1Q2gKrqQO?=
 =?us-ascii?Q?DRuHtJ0RFd8sQqUKAVWjHAhprwfMVV5hnyyCXfPZiv8BV3kJPsK85jNUJAvR?=
 =?us-ascii?Q?WahXmn2bUBDWSCdHliT+fb+wG9mYr2SVtahsuBUZjE9ayoFxRjEgIL+hOTLT?=
 =?us-ascii?Q?1FtWwdy6GvXG2beXM+eiqhTjrE9oh7AeffO6/RNHZ9Zw/sfU4teAhHE9SUoh?=
 =?us-ascii?Q?VhMWf/OYf3sqTvdDOkHnQ1LqYP8NQbQHUfd+g6IsSfi8NFpKOB0MrSjnfybr?=
 =?us-ascii?Q?7pOBTdtCXJeyzCj/Pkgxj+JdpbbhZEkKMlA1ja/hCLmTajuTSDoQ2pj2XjL+?=
 =?us-ascii?Q?seeFt3+r1Bsels4dKUD47z0gafH37em6+8cLmp0wdDyi7l65kY3ya5MxQO6/?=
 =?us-ascii?Q?SA6BDFo2kzDhlQKo8BpBxbcTM15eT8NuHksINWYYZ3LQpAkjlUfZZvAm1sl/?=
 =?us-ascii?Q?BTZsKoaW5hPlUf3Vliam/SJJ7TtjLOjlhBbKXpkI7j+rvD2ykbdFo30MIkOd?=
 =?us-ascii?Q?rCUAQ5JOhKlJDlD2b74ZTSs1j9Sf25qX3NrowqwmCEvScyhbrIF/PSX9ZmMI?=
 =?us-ascii?Q?JT82Jy2EP2m94C2UxoBgn2h/3t6GlW7LPvbVNtIg4AXZ3QiOkQflF8oMf4Tq?=
 =?us-ascii?Q?amKDebmjOVzNm/eez5XDBiS590u8hsr1B/syB3eNbHjnao36AJP1s4orV1YW?=
 =?us-ascii?Q?ebH84iCcNL0mAryypEluPwL62g9rUf+ugyKRZLmYZn55f38X0BJiMRgXGVq9?=
 =?us-ascii?Q?otk6hJdl+EwmLAAQxxSL8oRTp+VWOFZeXvzRrE8L0w3/BB8Pc/VE82MZfD9s?=
 =?us-ascii?Q?O9ocwDMGNlHYY0oJJ+BkiwiqhMYggoMSoO2lT9a4iBs/1QRKKIGQrhL/WkwC?=
 =?us-ascii?Q?U3jF/+J7CJDb81DzhYa1GsmYN/aYlPkNouNIJNuun0yAuBNU9kqVnz/uSiZ0?=
 =?us-ascii?Q?tSbUjttW8clX1NcyOHFkxSfxtM9D4/F+0sfNkp82e0PCQB690g1G47GqLn3O?=
 =?us-ascii?Q?Y5UnPhtSA2Qrug4AzA6ttdmChyCWlJpxuyYlo1aCtUtS46U1VvM9mk1RiPZL?=
 =?us-ascii?Q?NN9+yKdNYHF6tlfjEJ9MU9dvm3Cg8XibIVpQyuQXqcnbZIqG+OcW+l6eaG7b?=
 =?us-ascii?Q?DHOgSsL+x796pHdy/QTOSx+lDFp/VSJZSDlwG0qM+lJOwWpCmDUbm4zfAYFG?=
 =?us-ascii?Q?YB8V23e4CYxgJzRVpuVtUa4wyeVNdmg0uaH3vLI/dRvOgTEG3PH/uKEq/72r?=
 =?us-ascii?Q?8D8U1AB2QEVX68IpP2nXQZ0lWT/DFGGzIPXK3Wtg0peHQjQgMZM4u844FErA?=
 =?us-ascii?Q?0sKY3/bTt7M0JBABpgIQjU/w8NxhdNogGBGCvVhDTEIslNWUVd1WbFU25DR6?=
 =?us-ascii?Q?If7kx0tzrndb/7bzU+mIG5NHvxHnpJ/W1FZk5KtF2pI6+VJtkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(82310400021)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:20:48.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a647e-7164-4220-bc94-08dc8bc4c937
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
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
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c   | 16 +++++++---------
 6 files changed, 50 insertions(+), 20 deletions(-)

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


