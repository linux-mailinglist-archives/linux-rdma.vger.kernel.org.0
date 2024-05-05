Return-Path: <linux-rdma+bounces-2280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D348BC18B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AB21C20A65
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7937160;
	Sun,  5 May 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECnvr+1z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612C2C69A;
	Sun,  5 May 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920834; cv=fail; b=XLRfOkuWNOXTaNcqbsEjIFKINRnJlKJijyw1aS0Sc9VRMVltzr9kSYg2jJbzK/4/I9UkQzyI3Z6VgihAH5VvH8pY2mXgcmL3tF8RRn3+GAHt+sq2AQkprHn5bXiv5+CuoJMfQiELBFBcUl0fSUZqVx38t+3mqLpwJLo8ke7ZWy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920834; c=relaxed/simple;
	bh=UkmuWBhgwe7W7Ey7mLX0XsK/Piq5HUsvs6fk0gg98YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1GFkffhR5AWZkMcAO2cxViw4Ndg8yyXR/KN0Lij4bilL7g7p8ji++RXOU2oYKZsQC/Oj4Jf7MuD7dn1RkD0ONhwoAIjO3OOFErM8tvdru8aov19A5ZQdi+qVIuV8ELNCLl6xVmVWuiip5HgNxRlp1VFqwUm011gmfGxSs2Iess=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECnvr+1z; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itueNVv8H3GtEYeSn4sk8P8gnHwfDV7bMhMbuHLYA2Wr7tO63YV3GZLCaxVJWMqjkAfqH87h7MLxQE/smQ+7qgk/ZPDP9vqUaIAkA7tHWVTs1KenFzFPxmOsEYKQXLG4TZzgx4vY845hWeB0QcGuJTyhmRQSl4/HsPcT2jCPFtoOvLBo/E/Q2GOHOGiTCfNcuQApAvA5sc+QZWTix6tj0PNiFtohh4KCcJ1liDgGcQuq9GaQcHVcokthde/YKXYIOyIMRGziOGf+ovgIrNNyWPFPizR/2Oqb/JyCgM0gnRKFU2SzkCIvhSnD1iADqIatRS21dYF0tr1ywCQ5JPyj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88q5CsuIipzXnJmRy8n8Ex9QsBkf5TgTwqR37k3RL0Q=;
 b=i2a9JqwbWznw2E+jk0QCAjjJUT7OwXjoZ+RfWF7QJpLAjbra7DajH0oM8i+vecjsiBVDBMBJpAKlj2v+Y7cSIFYuBNSIIBFm+aDn/8zcjoTMid31qKnLO5pgvAay/JHMq3Rtb7V8gC3iKciO6qPezEPMNZkP10Uap6thaIyNE3mADyMgYJyiu3vPD2a7CjEQhHOyYgTEwdA4IRJfh/aCrgeoLjb8XuITLvCTXnTZcIEg0gTHvqNmkIZ0HFQKrA3JBzU5QUeM4zBicUCQLDThJ2reiE5ATCAP1R4rlXioGiKdSOZ2x8ObHuBcN2oni1bP7UFVQfCmq/f5jficJQmBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88q5CsuIipzXnJmRy8n8Ex9QsBkf5TgTwqR37k3RL0Q=;
 b=ECnvr+1z7Nm74mV2MmTtkUCwjtEuTeiWRo0Ounzfu3wEfHeViUMjvWjXV8pRnw6MykNEWsMm4rjMP/wDwKgaVWXmAmmx2nOe9TBg43uwAu3ZMD/5nru/IPhOgS+04R0eMYMEiSeisgpCGxGU/aE3sM+NTmwLaIw33qsh0fCB2CIsrfvZ+ttgyY0mU8X3VTI7Xfw54Zu+QESx9fo+x3RCIFS3WWVlMSDn6IKvwF1nxx+OUYXsw2YmUUBAxkIYzV1KEbvL0lAe8G0ZFRx3CeJ3gAg9NwVsdVonMde7pYNU1iVoC0T6s3vDlNMPubLuU0wcrw3+bXoK2WjfqjXoNrAhQQ==
Received: from CY5PR15CA0081.namprd15.prod.outlook.com (2603:10b6:930:18::23)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Sun, 5 May
 2024 14:53:49 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::3d) by CY5PR15CA0081.outlook.office365.com
 (2603:10b6:930:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Sun, 5 May 2024 14:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Sun, 5 May 2024 14:53:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 May 2024
 07:53:41 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 5 May 2024 07:53:37 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v2 2/2] net/mlx5: Expose SFs IRQs
Date: Sun, 5 May 2024 17:53:18 +0300
Message-ID: <20240505145318.398135-3-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240505145318.398135-1-shayd@nvidia.com>
References: <20240505145318.398135-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4d3b45-cd6d-4305-6232-08dc6d132c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ABEa619oBWvfk3yumykA37MEocja8ReEa89Qq8Bod4Ty/xP0vpzld3SvUJPY?=
 =?us-ascii?Q?RhOh2yYUpsxe6+BL9evBgwZz9tLi24Qxo1iOpRpIRUCA/fOr5PdCUApb93Ed?=
 =?us-ascii?Q?F/QIpEmd7oVEPJHnMHq0vTKWs9LFp9PcoqfV/qPjg8biPRQNZ277OwJSStLY?=
 =?us-ascii?Q?BbOepNKCCZkuMxcvYaSNImBbjjqqimyfyfvn+37oUOUxsnpMgFgZWj7fCwwz?=
 =?us-ascii?Q?EjLVpcFAzfANdEOXfPNyUP68wGhaAAK/NnKzX8gVKvrLebnt4r7zZvpdaSmT?=
 =?us-ascii?Q?2E891wiZneoVRXTKqvLIvAFObVY+mfij05Y/f2862diRKWpdqm9Qr7rqowjE?=
 =?us-ascii?Q?2PgzuF7Py+p/yzUbuiiyQ0OdA4hjik5rcjxAnqsPiaDa2EgMG6ID6aL5aGHw?=
 =?us-ascii?Q?/bdwsfQKM3DnSxU3YmdjV76r5d6OqfMI2wrREUTRZRKT7IA3yhou8VZGk9Wi?=
 =?us-ascii?Q?GFQk4ST5dhgVDHYfZROESxtzBeWtIdqG1atZ5yqjeYcsl2FpcHkbIrwlsBV1?=
 =?us-ascii?Q?PSUY5OfJTlUv0PSlsJF6r6OPVPYK1egqhSfS7/o8yJKkf8z5V1tUDtQaTKlU?=
 =?us-ascii?Q?EIg28BQ1UPKBvIB1G3ZN6yyKQWzc5/XXI5uQfPO0/5zseWVajpNGxAj8XvCU?=
 =?us-ascii?Q?67JLq8Jm0YPXUAPkvLOt0u8XsXkE4pzkK3DIS3iFyNjoqMPyx0UpTmLXRjUA?=
 =?us-ascii?Q?O+wWr2nii7KS+oejgomL3bCnW2xT4He8cy89nNXMugwLkUtE7bRElMoognDV?=
 =?us-ascii?Q?p1tD+2haUkzHjmBKIPpsmS2rCOMHDXLEZDT19SoOm4GZu4iE2wi6SdhLNkP3?=
 =?us-ascii?Q?icpmwDPbbndWXJ/WOXoKTOvFwoxI9DpVlZw8/3qlNHA83gZ/PpXYPYxZtZOK?=
 =?us-ascii?Q?W2N1AATS78n4Js/VJpatmXkgRLLZBtmsJNTlLmSyEV8EJM16zvdgspe5z/fX?=
 =?us-ascii?Q?njTjA0Yi4NRogbYJzaqANYFtZdE+aRHfWZ8n+tvdW+M+tuQo+2d0I+tP43pT?=
 =?us-ascii?Q?A32QgxpDjvkQ92fV5+34Db1y7HK3RpMtGvAbFd/Dc18CBvbwODVKg9O7vRmK?=
 =?us-ascii?Q?jZnZGC86xtO9eo4xmu/KG0Lah6wASjVvLm1n/suAMZEQmoXHwcPJBvp4nTk0?=
 =?us-ascii?Q?+M4pP1/+1MdyGMXWm0MT+P1FYi39vZHlB1U3T6Isz2lJvBmCXi0/98hmfAkE?=
 =?us-ascii?Q?K0vR6Aa3ChbiIbZNDs/qpg9HUWE1HAXZiWFUNyhyW2Ui/arCQdT4NVfYt3uQ?=
 =?us-ascii?Q?ClJwH2Q4AFzcP3LDRzcczF2O2JA772kUtQ6GbCr16uX4XAjvZXYWhfJLYy7+?=
 =?us-ascii?Q?Ky2iwjQEia4BzapdTknBfwrVL3iJqPK2ITEpJLXpTA5PhJIlbXariMN41r0k?=
 =?us-ascii?Q?8bK9BPA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:53:49.1888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4d3b45-cd6d-4305-6232-08dc6d132c33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

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


