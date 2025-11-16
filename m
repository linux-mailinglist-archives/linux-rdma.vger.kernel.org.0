Return-Path: <linux-rdma+bounces-14512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911CC61CAD
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBFF035EDCB
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959127F727;
	Sun, 16 Nov 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FcduI2LM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80344277017;
	Sun, 16 Nov 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326054; cv=fail; b=tLOwF7r+1X9m0DNfIRNBs4NSyllNAP2hI0FSs7OjgVBpNf5/9dnaaMgFeXUL74VAwpXGgfudZFZ4aLsBBRICEjFXmZXrPfkCAOkK/YJ5Mdr/8DUck9u1aM4jqdrlOnVSk7M9RZvZwBWhmj6PdGK63BIHyKLiLjhHLb8NMxeIEHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326054; c=relaxed/simple;
	bh=DB9sTmQrFiNBcxvFnYGVhlzWiG/2V+StrQlaRVn1Dbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7sTk7hLTQtjznzqoTVUXRBN9KW8deKnubVYti6gcO8VuzS9dHwAS8u8MTrTSZXmbLBJO6vbTH2+YJYDLizzEtUg4wbm8UyDkO3J4ybTmm+CdCwHs4YtF5MZtlACENebB64bW8CAzfM5OTHReUTbIAMJNj1AMR8u1Q5GfxWwwzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FcduI2LM; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdQq46U0r2S0PP4we7JX5mKvGqGT6BgrC6VWQNOpWSKUK9cZDKPhRVoztUdSar4zflY5a92h8H/nWX693yI4yqchzaG78oL4auk+8s21IeYJen9vFsS2aceIr0fOLpPwZcE+74xXdw8WFMIR0cdXWG4KsHFMoIY3YLEBCx3tWfipkhHXK4urqiTqugk4rYuuJXj77LjDDyv1TSQ9gZG8uH5q2lzNifKu8a1mvv9S+GROdHhv4VYg74cpgTFAKfd8oACva5Wzq8EboF/h2G6+bFtlfQS0hGHRtBKzNO8urL0XFB2yIANKdOCz1Pq/AuTcvzrPvsImTZ4ncwetUAx8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1cuW9IVLR0r/aGbPvwdC3bjHa3byWwnvLumz66ullc=;
 b=SND2dW9WkbItxhxckkkVSrGeSrlQ/RpzzWx/MXqL5hiEIjLCuT7ZRY4U7cmN0gA6nwNO5VbZWRpOFnF75dlJ3wyI7z+RtsgairBC1eLeWaueQZJdNbj9Ape5BUzN0UGN7P4QGj1yYdqOTcb1yiuUpArY/t+2B7gAxqGCKdh5b4iXwQjGsi9obvrO05qAIZhPlOcvBwh+Ckl0plNQx7KWfOhtTd/99hq2/GZ5QedEy7OUFGUQHRhT+BmosbrXO+HNyFim7l1Wz+0Ti+MDeD5hLcLf6EVMIkB+wf3YLXlKaEmVv9kNj+RgmknMYknp0Zi/tOpiyifvvrpMTuZykaQAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1cuW9IVLR0r/aGbPvwdC3bjHa3byWwnvLumz66ullc=;
 b=FcduI2LMf0GBHkYM1uKybIMjiw7HBhRj2kq4BUB21jA2CyvC6ARugILoyWrmlEfrO5QXMzcbM7FvK4Y7EjFGTPCUruANxQAThoM5bvXW8+RoQImkQJS37gYH6CuPn6wVmYenh/Qth4ft9QkSd4WbWHYoPfNMjYnHRwDUfc4sa9lfXQFlJkOpzkN7IY0rpeoXFiDXxe6tbkd8ekwYOTIDK39dLGvPfVHZUFOFzpzYrKPtWzv3qL6uOTA60kr3UjlRcdhYostImPGP0xBePKsMIlnFLBWN0XBFfpyEhDRg5HaUz8OOQJv7JZYz+yXIgIQjJtBmGnrCmW2XkrazcUC56Q==
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 20:47:28 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::b) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 20:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:47:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:47:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:47:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:47:20 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 6/6] net/mlx5: Move SF dev table notifier registration outside the PF devlink lock
Date: Sun, 16 Nov 2025 22:45:40 +0200
Message-ID: <1763325940-1231508-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
References: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 0981ee17-d09c-4e2c-bf17-08de25515a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vDe7sVin4z7ia9pi5HbvDXpHW2+QnvA7lRlHp+7s/JqHSj18SGnb3kbdKtO3?=
 =?us-ascii?Q?oOUxbagv73lHByxUSIj7jc9W7znQDaubsMYkV3BQuHrqIPPKJQ7TUJpX3G5V?=
 =?us-ascii?Q?j57jey5tq6MBeExGDOXsbjIKIRifSF//m3Q1HP2PY/UFe1icEWG1Tr/WUjvk?=
 =?us-ascii?Q?T5gQh8kXnG5ft9tLnRP4RBCo7QB35XSiuTBBCg0vuuzMyYtnI8osFTV2GKdt?=
 =?us-ascii?Q?XF8vTyORIUeVH2mVRcM9B3T5V0fQ8d4RYNdvLQJUW2GHqrhuPwmqxGcEVXwm?=
 =?us-ascii?Q?HczeUZIMKvpNdEG8hxpfPT33wa+TXpZPzWAY9m24X7/jV6xTM4JoDCaI78Z+?=
 =?us-ascii?Q?PUeOnN/8Nmsai8M8TccNGIwIbkFJEouA2wwhqZgBZLLIVkaVITXkxrJShNkr?=
 =?us-ascii?Q?lelczp67gFEnBCCwO5krKmLbYIT8G3VLHThKIzfj+i96T5ZU8SYeau7VFDvp?=
 =?us-ascii?Q?LPriJ2ISrceXUXb3CDTEMTWCJTblBUdl6JbvJX33oX9mjVy/IrTXr2yXiB77?=
 =?us-ascii?Q?3yzo0FpxI2xeiS/bWvFgHB4rPK84ifWni3Z9ASzGYAEIv4Uj+udFDSSS+cEY?=
 =?us-ascii?Q?cPys/K9+STwpPt62aOa+XEM1snFiodpQYvfyD/E8sH0bsCuMQXEitJga9aQB?=
 =?us-ascii?Q?Es1omSQqHYhrOBpSLsPU6dEISNpFmGl112t5DhdD+7WMXCYiAK5gHAdjG8ls?=
 =?us-ascii?Q?PsPKVxgsySFnYbpKhyl+qYQXKTCZ30sw1B3VXhn57HBNSWXR2pk2X7tLBTM7?=
 =?us-ascii?Q?+P0zc6PYCwN65bY5P4r3YjWVEfsAeigFu8wCZZkCT9j5ui9SMTjEHd4aTZxp?=
 =?us-ascii?Q?ZVqn4T6j8X+R/zJ2Z3oeLMqmYACWf/QXrG+x5QYQt+2ef9plLV1v1drEvOoZ?=
 =?us-ascii?Q?UdvHM8YxJV5e5/hhOuU2IzWgAVPzwUXETMjkU8IPYcM6iI8P39Vbqm8vbNHW?=
 =?us-ascii?Q?Lajd3iw7wu8SNsDPUxAHudYXTGO5SlLssI9vJvDylEATLgwigA2dH814RsSJ?=
 =?us-ascii?Q?hIeaiTVZMprJShnGN4IEH84Dyoa2ko8iBqa4Q2VK1OqIktonWNvtAO8y+vC8?=
 =?us-ascii?Q?ykhY0VuE6tnBPXY0GF890LHGd1PfHkZIDo/Qe40U2ff7/PMp53KBPjpWeIfe?=
 =?us-ascii?Q?psGxjt181EEC8S5DxLWNk600loCBOWiLPs1Fh8kIv7N4zje2hO84dW74nIQv?=
 =?us-ascii?Q?OZDssJNpwrnZ2WytFIkF7vUDjC/JuetnD54EFbFtHNnlzx3IFX7b+ffevhin?=
 =?us-ascii?Q?k071/nyQiZgbbmOBBl7dlbRCCe+I/9J14M3znYoT6kpliabQJVQ8rkLN/pNk?=
 =?us-ascii?Q?wvM09WHjkXUjFc1o3onqbWudlCEQl78Cfde9J75ENfzCrI0ZTLvS0H1JiFax?=
 =?us-ascii?Q?V8EM9VABAeGVc21eivsoA9yu2tkQMb9BBhho8wZav7HolFBP+PwNI+lIAxl8?=
 =?us-ascii?Q?lXEpH7p7vTuThpNLHlDStOI//iF1QmFSQwkAWEOlX5DGNf+hjZ0I7LMe6nsk?=
 =?us-ascii?Q?kFCHarrPcR/EL7LyMoANjhMFllnEnPSf5nTlbr3kSoZc9SZ3p9Z8pDGPhFkk?=
 =?us-ascii?Q?dsKOBSNK3p0H4xRUqME=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:47:27.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0981ee17-d09c-4e2c-bf17-08de25515a98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8

From: Cosmin Ratiu <cratiu@nvidia.com>

This completes the previous patches by moving notifier registration for
SF dev tables outside the devlink locked critical section in
mlx5_init_one() / mlx5_uninit_one() and into the mlx5_mdev_init() /
mlx5_mdev_uninit() functions.

This is only done for non-SFs, since SFs do not have a SF HW table
themselves.

After this patch, notifiers can grab the PF devlink lock (soon to be
necessary) without creating a locking cycle.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  | 47 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.h  | 11 +++++
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0c3613ef39b1..024339ce41f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1837,8 +1837,14 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sf_notifiers;
 
+	err = mlx5_sf_dev_notifier_init(dev);
+	if (err)
+		goto err_sf_dev_notifier;
+
 	return 0;
 
+err_sf_dev_notifier:
+	mlx5_sf_notifiers_cleanup(dev);
 err_sf_notifiers:
 	mlx5_sf_hw_notifier_cleanup(dev);
 err_sf_hw_notifier:
@@ -1848,6 +1854,7 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 
 static void mlx5_notifiers_cleanup(struct mlx5_core_dev *dev)
 {
+	mlx5_sf_dev_notifier_cleanup(dev);
 	mlx5_sf_notifiers_cleanup(dev);
 	mlx5_sf_hw_notifier_cleanup(dev);
 	mlx5_events_cleanup(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index a68a8ee24dce..f310bde3d11f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -16,7 +16,6 @@ struct mlx5_sf_dev_table {
 	struct xarray devices;
 	phys_addr_t base_address;
 	u64 sf_bar_length;
-	struct notifier_block nb;
 	struct workqueue_struct *active_wq;
 	struct work_struct work;
 	u8 stop_active_wq:1;
@@ -156,18 +155,23 @@ static void mlx5_sf_dev_del(struct mlx5_core_dev *dev, struct mlx5_sf_dev *sf_de
 static int
 mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_code, void *data)
 {
-	struct mlx5_sf_dev_table *table = container_of(nb, struct mlx5_sf_dev_table, nb);
+	struct mlx5_core_dev *dev = container_of(nb, struct mlx5_core_dev,
+						 priv.sf_dev_nb);
+	struct mlx5_sf_dev_table *table = dev->priv.sf_dev_table;
 	const struct mlx5_vhca_state_event *event = data;
 	struct mlx5_sf_dev *sf_dev;
 	u16 max_functions;
 	u16 sf_index;
 	u16 base_id;
 
-	max_functions = mlx5_sf_max_functions(table->dev);
+	if (!table)
+		return 0;
+
+	max_functions = mlx5_sf_max_functions(dev);
 	if (!max_functions)
 		return 0;
 
-	base_id = mlx5_sf_start_function_id(table->dev);
+	base_id = mlx5_sf_start_function_id(dev);
 	if (event->function_id < base_id || event->function_id >= (base_id + max_functions))
 		return 0;
 
@@ -177,19 +181,19 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
 	case MLX5_VHCA_STATE_INVALID:
 	case MLX5_VHCA_STATE_ALLOCATED:
 		if (sf_dev)
-			mlx5_sf_dev_del(table->dev, sf_dev, sf_index);
+			mlx5_sf_dev_del(dev, sf_dev, sf_index);
 		break;
 	case MLX5_VHCA_STATE_TEARDOWN_REQUEST:
 		if (sf_dev)
-			mlx5_sf_dev_del(table->dev, sf_dev, sf_index);
+			mlx5_sf_dev_del(dev, sf_dev, sf_index);
 		else
-			mlx5_core_err(table->dev,
+			mlx5_core_err(dev,
 				      "SF DEV: teardown state for invalid dev index=%d sfnum=0x%x\n",
 				      sf_index, event->sw_function_id);
 		break;
 	case MLX5_VHCA_STATE_ACTIVE:
 		if (!sf_dev)
-			mlx5_sf_dev_add(table->dev, sf_index, event->function_id,
+			mlx5_sf_dev_add(dev, sf_index, event->function_id,
 					event->sw_function_id);
 		break;
 	default:
@@ -315,6 +319,15 @@ static void mlx5_sf_dev_destroy_active_works(struct mlx5_sf_dev_table *table)
 	}
 }
 
+int mlx5_sf_dev_notifier_init(struct mlx5_core_dev *dev)
+{
+	if (mlx5_core_is_sf(dev))
+		return 0;
+
+	dev->priv.sf_dev_nb.notifier_call = mlx5_sf_dev_state_change_handler;
+	return mlx5_vhca_event_notifier_register(dev, &dev->priv.sf_dev_nb);
+}
+
 void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_dev_table *table;
@@ -329,17 +342,12 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 		goto table_err;
 	}
 
-	table->nb.notifier_call = mlx5_sf_dev_state_change_handler;
 	table->dev = dev;
 	table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
 	table->base_address = pci_resource_start(dev->pdev, 2);
 	xa_init(&table->devices);
 	dev->priv.sf_dev_table = table;
 
-	err = mlx5_vhca_event_notifier_register(dev, &table->nb);
-	if (err)
-		goto vhca_err;
-
 	err = mlx5_sf_dev_create_active_works(table);
 	if (err)
 		goto add_active_err;
@@ -351,10 +359,8 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 
 arm_err:
 	mlx5_sf_dev_destroy_active_works(table);
-add_active_err:
-	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
 	mlx5_vhca_event_work_queues_flush(dev);
-vhca_err:
+add_active_err:
 	kfree(table);
 	dev->priv.sf_dev_table = NULL;
 table_err:
@@ -372,6 +378,14 @@ static void mlx5_sf_dev_destroy_all(struct mlx5_sf_dev_table *table)
 	}
 }
 
+void mlx5_sf_dev_notifier_cleanup(struct mlx5_core_dev *dev)
+{
+	if (mlx5_core_is_sf(dev))
+		return;
+
+	mlx5_vhca_event_notifier_unregister(dev, &dev->priv.sf_dev_nb);
+}
+
 void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_dev_table *table = dev->priv.sf_dev_table;
@@ -380,7 +394,6 @@ void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev)
 		return;
 
 	mlx5_sf_dev_destroy_active_works(table);
-	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
 
 	/* Now that event handler is not running, it is safe to destroy
 	 * the sf device without race.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
index b99131e95e37..3ab0449c770c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
@@ -25,7 +25,9 @@ struct mlx5_sf_peer_devlink_event_ctx {
 	int err;
 };
 
+int mlx5_sf_dev_notifier_init(struct mlx5_core_dev *dev);
 void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev);
+void mlx5_sf_dev_notifier_cleanup(struct mlx5_core_dev *dev);
 void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev);
 
 int mlx5_sf_driver_register(void);
@@ -35,10 +37,19 @@ bool mlx5_sf_dev_allocated(const struct mlx5_core_dev *dev);
 
 #else
 
+static inline int mlx5_sf_dev_notifier_init(struct mlx5_core_dev *dev)
+{
+	return 0;
+}
+
 static inline void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 {
 }
 
+static inline void mlx5_sf_dev_notifier_cleanup(struct mlx5_core_dev *dev)
+{
+}
+
 static inline void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev)
 {
 }
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 7dbef112deaf..6ff52bde1f40 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -616,6 +616,7 @@ struct mlx5_priv {
 #ifdef CONFIG_MLX5_SF
 	struct mlx5_nb vhca_state_nb;
 	struct blocking_notifier_head vhca_state_n_head;
+	struct notifier_block sf_dev_nb;
 	struct mlx5_sf_dev_table *sf_dev_table;
 	struct mlx5_core_dev *parent_mdev;
 #endif
-- 
2.31.1


