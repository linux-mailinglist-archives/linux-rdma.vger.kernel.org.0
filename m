Return-Path: <linux-rdma+bounces-9709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E432A983EC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E705A02F2
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C529281370;
	Wed, 23 Apr 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XPIBvcqC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814227585E;
	Wed, 23 Apr 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397420; cv=fail; b=dx+yOm0/cqUFwRE0YpDwBHii4vJAEj3TkaPharJh8CeLU3WvNoByyYBm/mxmchfi/Z8RefluPFeVNNwnbUsuYzsNkUSHVvsHAXdVwYJnvwzvgAzEZj5150xwJ+5tM1iKM20qgjfPXNnPvucUZ1v5skXbXukJHNpQdXBmgp8vuEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397420; c=relaxed/simple;
	bh=c8qQiGnaaQUxwIN3xhTt1bqyBVBN+mv0BGDJZffP2nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7koy62sS0mLcBREF/vai9ovM3NO9Wyz9u8DHfTSqDJ7vrqEjZ9PfkJqYShvzxzQFRL3jusIhy63exvpAq7+138UREOaHKOlD44Uag+/gmUjAoQKLL8Vg4+BH4sDmbFpvEB2I0Ne1z1v0RhcMk4UC8JN3kmv8DnP6vkUhH9o/Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XPIBvcqC; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNtiz+LrmfotBOhVVHJx1CdTDe3QZ3oNZEe2hNZLgY7j5ldbEkorrxHWZg2qys3wGMb+LZOh3VeYZuG6h6u4hMsT8+BhdQXq/sb/0Ca65k1kKZULwACGeKN4VUuTfQjjAQf+Ipr97DyMwtElNUcMUyS5/tmYt19O98SVBTOZGwwWBipnhWqjn12H7pCg10hfKxLT+W6iqQ1b9oC4y1i0d2O136q5vIVvMxeV3wZe35W9Ul1XbNvB6HZ5PLuUC+VE0HXrTmbdfaPBbDU4+8ylnt5fp81lKrU8lJ+YNLuIdvz0Qh+c4JsU0SkGNwpmC7qerVLJ3YJgi+4IfEvlwTYVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzgMSOwQQI9hmZLiSBV9+OWV/jFepbCv5DYJH1gbqpM=;
 b=o1DigLCnXT8pyvPLWzTKAUXV6XtGq5x+o5G+3alnnefo6I9JgQ1wbvR6czjqxuglb2VbuijZfDUeBMFtnK+iFGehJ3kEAJC/gIzWdNUdl/wbFv72/YBELk7eGh5X1vC11eb80So30l0nTyYC8VtRKWr64vjokSi3XIbfS8rqxOvVpoo788GFbNaAArUM5mMnHE//EkdZTxcUvrkaDS7D5CCqZ3OwSSfoTy7cr3/14LIAyCJeN4BQIq7ZfoWWiNErq4XY/JKEYYWzaH0eMeWMcMSKA/u1xlbedwuZ0fXe4aUMArlmX7liRPpDRt3JDSapNfJU9ZCrqP95l7u9f/iiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzgMSOwQQI9hmZLiSBV9+OWV/jFepbCv5DYJH1gbqpM=;
 b=XPIBvcqC3dgJTshXpHE6baMy0u8xtySIW8JC4RRttPkhiEYS4Z3pban6xqtTnGoj7wgN0wny+xF5ofRE/oiTgk/oucoXooR99/UJYBwTUCoqzmh4JX/TUIQG6Boo0PKu0OYJVBIUMrkW1/blGohk03lJ/2YGM5O5kv8XczVGr2d82nxZsnjNaXmIr6fh5EyF5WjzSXflIfGPIKYlw5KSIHFVdymITdU1B6JJw715hXxVVNyfPDQGe0GGQG+QFJ7TF44US8LM68a8GC2IYMUP6VgiJAG+UEfK9Vf9n6qKjNU+igaonw+2tEWUYsBlvpNrTeXjHtsN1Lws4uH6VNjowA==
Received: from BN9PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:fb::12)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 08:36:54 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::13) by BN9PR03CA0037.outlook.office365.com
 (2603:10b6:408:fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 08:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 08:36:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 01:36:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 01:36:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 01:36:38 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chris Mi
	<cmi@nvidia.com>, Roi Dayan <roid@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 5/5] net/mlx5: E-switch, Fix error handling for enabling roce
Date: Wed, 23 Apr 2025 11:36:11 +0300
Message-ID: <20250423083611.324567-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423083611.324567-1-mbloch@nvidia.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 438e063d-4e2a-41c3-ea93-08dd8242008f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zyv4gYEHWm0V8XQPXtp547JDcMvAGDI/wNWq5AsO8lnIv2ngRCMYbfeJ7hnI?=
 =?us-ascii?Q?mQGQ/ll2Qj6aFhyQ28zEGVrOvq0p/9uwY2s30jHqhY1h7EFrv3ZgaGLHnsiR?=
 =?us-ascii?Q?wQV3FSHI1NpWfW8kmfPMouu/2zVvzyK1RCzXEyHnr8bc0AQ9T5YTGA6oB0q0?=
 =?us-ascii?Q?Q+HYTYUNZ52SkWqo0yqPSlqqXVpnBMTW38w/5xFKF/iySOVsekmSDr/dwOKQ?=
 =?us-ascii?Q?ZkdjQGgh/vuwIlJzml2bH3+DzzRSkDaYnj5Ol3jOH6yB1pEnxXyXCpkqIF/q?=
 =?us-ascii?Q?3PznMEar/j27Xh1AYGoczs3U5Cw4RJCX9psb0fTkq/oy1ONMT/mTOSMIdktk?=
 =?us-ascii?Q?HRKSy9FWl6znf9q9aMGag0N2FKg/xSwFio+KtD4n3o2oUqtZOLYS/agkR3Dr?=
 =?us-ascii?Q?jM/Vs4PKbYapli6QcSsQVoH5kGWx2ggME8kw8E7wzchvOk8vtu6jsKZ848XB?=
 =?us-ascii?Q?85mdB1XbGso6eCGLcvIkny5C4c6GPjSNdnV9rSf3xyXbvLCoxGFZJr697KLt?=
 =?us-ascii?Q?X6PTyQvBF6s+XbmeC/ElkjUl0S0IhnspGllMYXmCg9cnu9hj0CkTy8XDUG0T?=
 =?us-ascii?Q?gqcfwomX+QEogFrgZrsG124gTKyoikzFG6uNulv3NMQ1AtWxI910eQW59Qnd?=
 =?us-ascii?Q?x0WS47ITACXArDi1MbuzJdQExTv5NZqY7lrirSoc4uhwFreOPAmgWxUT1e8N?=
 =?us-ascii?Q?yWaXgR3ihTfDUg9hi1+RmnQWD6sKhssdYndBD4gfLYmNOTokKTacRpThJdxh?=
 =?us-ascii?Q?BdMYVLK2A7PICFcS06Lo4N9sDyeglb+nTnskK59lk9Uyk2IWg3jlN5wOey3i?=
 =?us-ascii?Q?KAzGbA40Ml3sFbMEVcLFxwmpNhVzO/dczh0j0dT2qtV5HkziScRqqyiw+Vwk?=
 =?us-ascii?Q?Mes0sPNHcL8mJuUDq0T8/ARGYJCr8EQyPpMh+6jUa1/kK8efhEcEsIWtP6Yy?=
 =?us-ascii?Q?tuyCfKKp+5tWqnOpwo2A3YtHmfVdopj96QbGQSAS9bN/CPcWZihnpq5GLkuV?=
 =?us-ascii?Q?jrAlcLThIpxX0+S4bshW9b+A/z+eATSSxjrd7Ea1KANkDarxFtTcS5Iiq8oP?=
 =?us-ascii?Q?kQycLSggp0RTVoHzgFvT/32fvzl4GpUD/FdlmTwokc1CTBRQO3t+qTmQfnVv?=
 =?us-ascii?Q?IxLUZYP5NCtya0qQcx6i+pamXPlLTmnNVZtGpi7cs+lCttYDNwRSNrXxZFfs?=
 =?us-ascii?Q?Bx+RRxO6FEskKjrFW2IzhKJ5c3dN7n3J9ox8/NLxyLAS/VD6p1sG29zKu+vc?=
 =?us-ascii?Q?kzeFc4PZN/Enmufs84hdsCiaWxATdlaZwUAmOOAgqjMOLa9fLLahc5dTiBM+?=
 =?us-ascii?Q?lg7b4jiqnaRmKxkK9Ab8IeCUE8QDAPfJyFuUnJciKmmIxXUvM+dC1IAtJief?=
 =?us-ascii?Q?Y9AwnZA0Tb1zkCKPF6KTr5fscw2g0bQyFxrNx6pakTzajM4zgOxn/tMJOgBz?=
 =?us-ascii?Q?bycbkP3i22xVx1VS2LvWJziTtQe8MqPvJWs+pciYEPLo51vI4S7QeskMKwEy?=
 =?us-ascii?Q?Bj92B89KuaO9d7XsXcZfJlfmRP/bryAVV3fB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:36:54.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438e063d-4e2a-41c3-ea93-08dd8242008f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

From: Chris Mi <cmi@nvidia.com>

The cited commit assumes enabling roce always succeeds. But it is
not true. Add error handling for it.

Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 5 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c           | 9 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/rdma.h           | 4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a6a8eea5980c..0e3a977d5332 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3533,7 +3533,9 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	int err;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
-	mlx5_rdma_enable_roce(esw->dev);
+	err = mlx5_rdma_enable_roce(esw->dev);
+	if (err)
+		goto err_roce;
 
 	err = mlx5_esw_host_number_init(esw);
 	if (err)
@@ -3594,6 +3596,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	esw_offloads_metadata_uninit(esw);
 err_metadata:
 	mlx5_rdma_disable_roce(esw->dev);
+err_roce:
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index f585ef5a3424..5c552b71e371 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -140,17 +140,17 @@ void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev)
 	mlx5_nic_vport_disable_roce(dev);
 }
 
-void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
+int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 {
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, roce))
-		return;
+		return 0;
 
 	err = mlx5_nic_vport_enable_roce(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to enable RoCE: %d\n", err);
-		return;
+		return err;
 	}
 
 	err = mlx5_rdma_add_roce_addr(dev);
@@ -165,10 +165,11 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 		goto del_roce_addr;
 	}
 
-	return;
+	return err;
 
 del_roce_addr:
 	mlx5_rdma_del_roce_addr(dev);
 disable_roce:
 	mlx5_nic_vport_disable_roce(dev);
+	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
index 750cff2a71a4..3d9e76c3d42f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
@@ -8,12 +8,12 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
+int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
 void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev);
 
 #else /* CONFIG_MLX5_ESWITCH */
 
-static inline void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) {}
+static inline int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev) {}
 
 #endif /* CONFIG_MLX5_ESWITCH */
-- 
2.34.1


