Return-Path: <linux-rdma+bounces-8550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93CEA5A6AA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E1B3AEBB0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D51E5B62;
	Mon, 10 Mar 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GPtNFtNB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAE1E51EA;
	Mon, 10 Mar 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644188; cv=fail; b=jWHxyTzGXiNaNKPiYCwDGPfuriFB7CvfAp47+wFevmMSLMbHhaW1uNs0Bh3htW22f1x8VyRBBEvW4hCR9FtAuhh7Tze13mU3vgOy8g+pxa+z+E7R/U7pXFiYYuhwhth9JC/Xj84r9TeACCHtcTkVLiV9cyqnOzUFoH5IKKTuXMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644188; c=relaxed/simple;
	bh=46tCwXHKjzLlL0mhe7rEVLuHXyX9HcJmq3emUvA/7UY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBKbVVOvJXHv0wXo7glg+n/g7iqfkOQ+4vFjWidas+kv08lh+4Suox6k4vSUvZ7O08rUOzWZZsyS8PFSaGq+cV6K646ia0GjnDoWV+kJRdunfsxLWkLw3iqm+acRLPDuTTDE98N9mvPJY8F3dplXFOTKfjOWX9+necXA3Zyrfg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GPtNFtNB; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXSDJhLH4E9RTJZZbX7TINjsBL74iwf2zUbvQ4l4RgjU9wHgGOUKmHM/mRTZNCaftuRnwI/ray1Qx/K1mwNhKSEoyUSNUbMCZrWDqEvOiUcjhql9Egy9aDdaA6B6w9+r+xFm241iPSnnj7tyngU7YgIxZJb6FyJNHzh9w1cx1yYWuYAaxhd1kqoDl2akavKDDCJVO5oYkD4o276A/Y2mPwBXiaOoFLHcUDNiQQ6Q0MgDJfM2DzAVIQUsqjsPmD9flI2s2c1V976V4i1EoJEJMXv3N8goXtw7aQooN8uOnoZcf7zFLEUeUIZEDZYuYqJc148hxTGaJqR4EoOCfw5NHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U2PcmCUSil6wwKlIZaqnrzNamPaFzZ3jjiVAdw79LQ=;
 b=XMwi7OCCZPiZU/54AIq3R0fAObMSE9oa0I+zMkkyNy/Q5kEx9W2jraX4T/4ODC/tzzJArpoIE1xXkom73CADCPLGef9l3FPWeEAglpxL6KYuUFEx9EY/wYYMiAkCO/2GeeYxig5UTW6WRJatWsO25rKiqcPfAhzSo2EsbZiJp9u0uX/mBPdFO3uODx77PRYOBYo8BCZ+LAAs4eIx5u/qL6/5G3ahM792PMDZqQ4RogFhvQmJti2oKPxRHCpmKFFtfi8X+EhzraQjnZxxaqPb1rqpFuhKvVX29JPQFKCIEpTYpJasfEoS5OeF6sNs649OmJqc4DG6D3mN/MS0OdfFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U2PcmCUSil6wwKlIZaqnrzNamPaFzZ3jjiVAdw79LQ=;
 b=GPtNFtNBvAqBcwKGlJnt2GTFDZrMuYgj9YNpZZnKLIUEqnsRAJfdxtDMFv3LTSDHXU1cKY1kS+n5EhZcL3FZugCROvLgSAjFsWAAWoZEFw21Vbs1vzCrtOxl8z/8nBFYYyRIrn3RR6GhbgUZZ+LNC0RNo1JACDQ79/4JWiSi6p7sJDi64od6sixJwLX2nlLgWsCXgOPIGJdVEFVIspHE/uz8cU4tMlbsT3R3lCBYlt81bMKuUwWRFKp6Uj9djx9RyM3hMM/oGHniObd/MHrhYlA+FwNi4HZBHyb57mys4y/dN7CVaLg9HpdEkLnA69+SE7ClCDP84a9WajP8TtoGvQ==
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:03:01 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::2) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 22:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:03:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:02:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:02:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:02:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 3/6] net/mlx5: Fix incorrect IRQ pool usage when releasing IRQs
Date: Tue, 11 Mar 2025 00:01:41 +0200
Message-ID: <1741644104-97767-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bb048f-1187-4500-d877-08dd601f52e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4X/Dw3t1t4LX8Cdt6Avd8joFSq1Ekb4uz8nI4co5ATv0iy02pG8dA5BDdHJ?=
 =?us-ascii?Q?04OuwaKrBK51qlkeCtnmGs4mYmizH6YRTouAmjacJh3TdDVO0BhiBI85JOnv?=
 =?us-ascii?Q?sIB1iVNFJiqSk0R7ifaXZcd67HUyeEXGwlvljsr4XNc4zpJKzZoKZWQz5v7o?=
 =?us-ascii?Q?PxZ40WKRfEmguDH+QZ7d33X2uy28X5nm9lUrgVjYtv71xRFKLOkYnJx95dFz?=
 =?us-ascii?Q?NVTLNMdABSQ8LRCAK4rkCsz9xRIBTm82m7L1at36F9OsT2hOYPXtMii91Enj?=
 =?us-ascii?Q?eBkQrZ/cmTrHq6omZlTOZoqUD1aJP3HLt1dT1zRoanra3qIyNdPOZ8UsAwBe?=
 =?us-ascii?Q?xnhBVeJJbLQvwBLhFSNB/5nr7OpPKDaee04uUCgNybeD4YRvWbMhsTpGK5P+?=
 =?us-ascii?Q?9x9/bLQ1g/UeqNw5HyVpTtIFqg/PfKeLdP9BsjAjYCjTyIp7Pjb+zD4wGTN6?=
 =?us-ascii?Q?c0FzR/o9AeF4CukwXG1kNP/G/E/y7cUHAuYqc0hZdvjfHjedh1eYH1mTqPAX?=
 =?us-ascii?Q?HVvOUoYHnKowWTvZNQg5+yWiRGylC7KJ+NwjJ75toqMvo6C7Zesmof1ILVSo?=
 =?us-ascii?Q?AoFG8ShgO3LRfR9K8f+yxpIWJdw41+rUlqGP0sEaE6y/1yenb5TIklzIfkUg?=
 =?us-ascii?Q?M1HUhT7ObE2H06qwOqFU6G9ycnclVl187ro3p9go9B1X4rNN/N2sFEfqmu+N?=
 =?us-ascii?Q?UufH70HfKpLUzwIXMHDsyp/W2rbXEERxJE0eHoevC6ISmo4FFOAzYluZyIrS?=
 =?us-ascii?Q?IvRDQfVnXrBqT1Xf8WB0JXLswB3B/qwjK2ZEOTYjQ4NuXh8don4fsKKhpuqc?=
 =?us-ascii?Q?OVrs8V+en30bY4Ekn1Laww3MJoq/cqTC3NIkbmqJbEmhL2Eue5xj6NMMWYt8?=
 =?us-ascii?Q?U6IfKo9RnxRODsZnjPJw+OxNi+ZzOEnXXJGUUOyz+SINPQq6gaONnGQtJwTy?=
 =?us-ascii?Q?xZWq/aMCYsdQyuPFS8Z3PVNQ2oaLXeQng5A9mPRIPTlzAiAZWPnl9QOQcJLe?=
 =?us-ascii?Q?ZuRLrrlODhGFoV8hNzyBcV2O3bJwLa7mCg53/3zrvS/adqqX5mxil//huLyD?=
 =?us-ascii?Q?IdYxgStJkon4iKJXv4rtVGjogB3yf4egigvNZJqLXG5vbx/st90RsFEITsPE?=
 =?us-ascii?Q?RMgwO+dmQXVdypPzCHGb8znAw5jp14lOWJsPrBP7fn0QZ0Xbh1C1iqB2Qp6q?=
 =?us-ascii?Q?lbL0WRzHcJLt7lGeCE8qQat37KNLfFqpC8uEN4gFzyykSd4QklF+cI6AnA2r?=
 =?us-ascii?Q?lgnAKptaTwqjAcQjG7Z+m2bx+g9rWgwPH+Mga/0rFxdwh1BKyijfd9CJO6KR?=
 =?us-ascii?Q?AJjJHqn05lQiiZ1zKcJSC3XMSSJOVimtcT+M3II5LE1UN4JOUfZG5QhjoLgq?=
 =?us-ascii?Q?5UUJ0lDUsR01fu10EDM4K2efjMTiM6lBE3W0cyllzkQVc639Uf04j+EsWq1w?=
 =?us-ascii?Q?5BdU4heZHEVQjCJYWqIdZX+jSVDkk0l+dPcTpUJaSaZrUFs9L56BR6L4Vn9H?=
 =?us-ascii?Q?0QOEvhShL70rPYI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:03:00.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bb048f-1187-4500-d877-08dd601f52e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

From: Shay Drory <shayd@nvidia.com>

mlx5_irq_pool_get() is a getter for completion IRQ pool only.
However, after the cited commit, mlx5_irq_pool_get() is called during
ctrl IRQ release flow to retrieve the pool, resulting in the use of an
incorrect IRQ pool.

Hence, use the newly introduced mlx5_irq_get_pool() getter to retrieve
the correct IRQ pool based on the IRQ itself. While at it, rename
mlx5_irq_pool_get() to mlx5_irq_table_get_comp_irq_pool() which
accurately reflects its purpose and improves code readability.

Fixes: 0477d5168bbb ("net/mlx5: Expose SFs IRQs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c        |  2 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h  |  4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c   | 13 ++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h   |  2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 2b229b6226c6..dfb079e59d85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -871,8 +871,8 @@ static void comp_irq_release_sf(struct mlx5_core_dev *dev, u16 vecidx)
 
 static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
+	struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
 	struct irq_affinity_desc af_desc = {};
 	struct mlx5_irq *irq;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 1477db7f5307..2691d88cdee1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -175,7 +175,7 @@ mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
 
 void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq)
 {
-	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
+	struct mlx5_irq_pool *pool = mlx5_irq_get_pool(irq);
 	int cpu;
 
 	cpu = cpumask_first(mlx5_irq_get_affinity_mask(irq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
index 0881e961d8b1..586688da9940 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
@@ -10,12 +10,15 @@
 
 struct mlx5_irq;
 struct cpu_rmap;
+struct mlx5_irq_pool;
 
 int mlx5_irq_table_init(struct mlx5_core_dev *dev);
 void mlx5_irq_table_cleanup(struct mlx5_core_dev *dev);
 int mlx5_irq_table_create(struct mlx5_core_dev *dev);
 void mlx5_irq_table_destroy(struct mlx5_core_dev *dev);
 void mlx5_irq_table_free_irqs(struct mlx5_core_dev *dev);
+struct mlx5_irq_pool *
+mlx5_irq_table_get_comp_irq_pool(struct mlx5_core_dev *dev);
 int mlx5_irq_table_get_num_comp(struct mlx5_irq_table *table);
 int mlx5_irq_table_get_sfs_vec(struct mlx5_irq_table *table);
 struct mlx5_irq_table *mlx5_irq_table_get(struct mlx5_core_dev *dev);
@@ -38,7 +41,6 @@ struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq);
 int mlx5_irq_get_index(struct mlx5_irq *irq);
 int mlx5_irq_get_irq(const struct mlx5_irq *irq);
 
-struct mlx5_irq_pool;
 #ifdef CONFIG_MLX5_SF
 struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
 						    struct cpumask *used_cpus, u16 vecidx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index d9362eabc6a1..2c5f850c31f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -378,6 +378,11 @@ int mlx5_irq_get_index(struct mlx5_irq *irq)
 	return irq->map.index;
 }
 
+struct mlx5_irq_pool *mlx5_irq_get_pool(struct mlx5_irq *irq)
+{
+	return irq->pool;
+}
+
 /* irq_pool API */
 
 /* requesting an irq from a given pool according to given index */
@@ -405,18 +410,20 @@ static struct mlx5_irq_pool *sf_ctrl_irq_pool_get(struct mlx5_irq_table *irq_tab
 	return irq_table->sf_ctrl_pool;
 }
 
-static struct mlx5_irq_pool *sf_irq_pool_get(struct mlx5_irq_table *irq_table)
+static struct mlx5_irq_pool *
+sf_comp_irq_pool_get(struct mlx5_irq_table *irq_table)
 {
 	return irq_table->sf_comp_pool;
 }
 
-struct mlx5_irq_pool *mlx5_irq_pool_get(struct mlx5_core_dev *dev)
+struct mlx5_irq_pool *
+mlx5_irq_table_get_comp_irq_pool(struct mlx5_core_dev *dev)
 {
 	struct mlx5_irq_table *irq_table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = NULL;
 
 	if (mlx5_core_is_sf(dev))
-		pool = sf_irq_pool_get(irq_table);
+		pool = sf_comp_irq_pool_get(irq_table);
 
 	/* In some configs, there won't be a pool of SFs IRQs. Hence, returning
 	 * the PF IRQs pool in case the SF pool doesn't exist.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
index c4d377f8df30..cc064425fe16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
@@ -28,7 +28,6 @@ struct mlx5_irq_pool {
 	struct mlx5_core_dev *dev;
 };
 
-struct mlx5_irq_pool *mlx5_irq_pool_get(struct mlx5_core_dev *dev);
 static inline bool mlx5_irq_pool_is_sf_pool(struct mlx5_irq_pool *pool)
 {
 	return !strncmp("mlx5_sf", pool->name, strlen("mlx5_sf"));
@@ -40,5 +39,6 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 int mlx5_irq_get_locked(struct mlx5_irq *irq);
 int mlx5_irq_read_locked(struct mlx5_irq *irq);
 int mlx5_irq_put(struct mlx5_irq *irq);
+struct mlx5_irq_pool *mlx5_irq_get_pool(struct mlx5_irq *irq);
 
 #endif /* __PCI_IRQ_H__ */
-- 
2.31.1


