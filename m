Return-Path: <linux-rdma+bounces-14509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBCC61C96
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB1F1356633
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C3264A8D;
	Sun, 16 Nov 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyJAiVn0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3C25C6F1;
	Sun, 16 Nov 2025 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326042; cv=fail; b=VcE94aAymKA3E6Em4BjeEa1OqJULO7Fz9bldjZylk9vSrcS8hw9d1ZuGCgVMw1gvyKYNy5oF6dGm21XZKPv/yTUBSB873coQGm7Noq7ebAj/BUtetkkZwr48NMiSiM6+HDFPqmHkll/2XVMVi/oD5hxGE36IluwFmqVWm5OuN0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326042; c=relaxed/simple;
	bh=WSJYfoazkXMJnrISpQfxAXdiWrEJpKY5GJxCBiK7O9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ33WPi3DWxmSSxDPnUger+oNkLghHBY5oWHozg3eMDx7WdFbfrnwebYYwPnzPAaoklV3ax7GDJgXhMCzme8B7CPP+LbkJhMS94nAuZtMJNz8fF41pl82+eDTm1Lr7jcl8gu+zJ3H3F6RWlv43pdr8wmwlKDurcF03uI23/0gtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyJAiVn0; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlxjULqjufQafBG8jvP2fwcI1XQ3n1rABL3mJZw0tkRqm714g8QxWMG4kos1k3VthAFBeBpc1dNxNvr6Uuf+A0gRKXtVk82cEVsxdj5X3uqfgY91ETfTHi8MADsGnEKea//4tb1bJqCpTPRuSZQXbIievCFtgaxEViaNK970MZdfoDyv4p3w4VRsR2U5n2DAoVUzhHe3USYAggeZg+de5fUGll7KsuYOblHnWdQLnVyVangmkEqUaGuD0PYMLe3ArBON4XxDuHzFNx5wleHqdizR7oJVaFphuRx9XZYHOp/+o0thgc5bGTosutfcUaPYmVObA8xzbeHTP36/bqnQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zack/rEcs7PYV2uevqXQM1nUMpK06a02/ArsmTSzAJA=;
 b=orCtE5x8Sf+GxCigicDcBOeNHPkx1zWzu9Hj1i/MLU9rFKcSBHcAfHtNbemPT3NQ0qozOlkEmZIf2G4G2ewJ0W/WcjzS4MaTV/yxputPtJWE4m2YzPnihAfQBrLB2rbAJXYn3OuwEi5nbURbZ6oklA9hTUcM7MYraje72YvfoK5yU6l4lZohIy6exXfVVu41z5U7/Z5/yHiELpFrl0QWxb5ip3GTaAT/mr6ai/M2MGGOVVkRYk2XJGSrplaJuGWXd7q1M7fYsCKUed35Og7aph38YWGS6+kwDlu5KPubR4h2YdnXBqrUTK/Uv0mrs/WiB+fGf3nPWkT4aM/vRJVQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zack/rEcs7PYV2uevqXQM1nUMpK06a02/ArsmTSzAJA=;
 b=OyJAiVn0Fn9WBpbG+pmDEk2SPixlC3swUMeeVRKCzz4vRTJTmaFtLxxBQIpYpkcgXukHgDggJG1JFKS2Y5SFLgepDy8+mCkXgTr4FP01vsYXgA5zONcASjUuzvQHXAj3Zkxs4NmQ1WAT1LhIw6xcam9/q8VMTFBneKYOt5ayrikNB7pwdy8E3mGaK4NVNkaZOuxk0tRDOc/A2lfuIO7UDd1MJwzwQCMdHFXzSKrzcy06OgpTE7EKUrL2q3r13o+aZKMWgyLxC5EQoLJcFB01SdrspavzHvoqi4sQJ/LKyOMomDtngO2YFPouAhW5XZ/VBclGYEiSTCP00ybZqs2vRA==
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 20:47:15 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::c5) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 20:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:47:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:47:06 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:47:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:47:02 -0800
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
Subject: [PATCH net-next 2/6] net/mlx5: Move the esw mode notifier chain outside the devlink lock
Date: Sun, 16 Nov 2025 22:45:36 +0200
Message-ID: <1763325940-1231508-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: fe36841e-4a09-4deb-7d74-08de25515352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaaBWxXmUgIlgX7GKUrNpeUH5WatVhiHpMEyXNrvE3Fm9c/R4vZXT6RL5Q+q?=
 =?us-ascii?Q?4dmSGaSnahD3/9+Y6o7wxPBwaQI64yY9NlmTRfy4w2BtfIjpK4cVNZfDn9zd?=
 =?us-ascii?Q?+5Zlb3z8ah8duj46RbCw/AwvKGEgARbopFZChDvJ5iMO0wBjKU1lYrlaJbUA?=
 =?us-ascii?Q?cO++qilt89WWJ1Yg3xNQyzHCHNBdZ2Vqn2mH50Y1+rzDwqazqi6POcHkHtTZ?=
 =?us-ascii?Q?3sL2hWpygxTennx4NUgnHKPvcWuhwlJ+dlcUIvb1NvsroAnTjeoJ6sBVmwus?=
 =?us-ascii?Q?a004ZZdKOPVSzHsWzGGZIQu6UNCLKN9pAuBlSRvJu88SHn1ZgJYm2p8yaJio?=
 =?us-ascii?Q?70t5uW6IdRNaCzMQpOfl273hMol1BMKymYxpkpEgvHaVRlLpr3hWSmCdOqOA?=
 =?us-ascii?Q?hvXbbMDtUJex22dikbwnzOsEm4P7y4YzP/sGkavEHD7QKZurCVMZFBpU/1ae?=
 =?us-ascii?Q?G7uSdpFRNVIE93OsUZneD2um50SBpVuAPGs7pbPGiUucoHx4qkRD1MU8YwMq?=
 =?us-ascii?Q?6/uEB9xK7M9vE9/+hywoe27Lhf36bcJAbNPIq2o7DmNUS2dRJ2guloIzxgBc?=
 =?us-ascii?Q?JK3pxqHLyce7Vj+0hBTK6WZ6LPB6QLUTY9gMkwEdLur+F/qGFwdXp/7JxYwb?=
 =?us-ascii?Q?TwzfBcaCAyt9YylmTZKhrWGeoDFnhYNCrowVmziqkM3S8Rjlvasui+WJx70t?=
 =?us-ascii?Q?GgER7EUP4Ket4NOUrzxFAcxH75cqPeQLvxk1h1LLpRj8ViS4kJIucdaxqfN7?=
 =?us-ascii?Q?ThzB9X3Z+9Dxpd6ZcudSTZzpjtsWMSOJssx0a4aetXw5uSH+tQ8zOgFVN6u+?=
 =?us-ascii?Q?Vq0PRn3KSdRsertNkS4qpoQLFoiv6R6R6l5uQUFCZdkCvJutjWisOLfOaC0N?=
 =?us-ascii?Q?Xkt+o4IL7eevm4H0rA9QQqoIeiBnn7Q/OjKTEjHNTIDuUWVxWOBRnp7i4riC?=
 =?us-ascii?Q?f2HPGjPzNj3ZJeAyjJpnvlBZx9SEL1Q9XRSMzZJG0fZlm0K5BYLBKmoBnVdJ?=
 =?us-ascii?Q?gmWTk2hQPqST3/MoHX+rqog/jIIYSVDccuh3vnr+nsAzjXPT8yNq2G6pk9qm?=
 =?us-ascii?Q?3TwrB+HarR1MvilAPJ3lv3SO2Gq4RNwIoVYZZl3YeJuyhl5ummpNlq0jnQf6?=
 =?us-ascii?Q?9Cmmxu4+O9msK8uKfX+Lpy/NEZ37Thy65YgUSruYwc4zxuqDi4EjN+tqRf4B?=
 =?us-ascii?Q?qFybi/324Ly255wnnSJ0AKQHnN99fl96cmeq9B8adXSbWEq+iw+9vU6jm5F0?=
 =?us-ascii?Q?tqA+8aOVD4bBB4Z5M8iysEYr8QASE0Kpz2UVM99/je8t+7QdCVl8vYE09fs5?=
 =?us-ascii?Q?Ll3u5yMKNCuK68/LhpGNEQSVLlShEGuQgpCsxL9kJjawzUExDQGP+1ri82Y4?=
 =?us-ascii?Q?GYl0ZQDrNLEkDPVrqKikBzy86/hvwIYg2ODscigahlIbU0Y+Dy4FwV/TMGVb?=
 =?us-ascii?Q?dHUzRI/yyxgHJerzSg59DVBPlPLkAhVDYcNpYlowXGKTpLvikGbZXHvs4ahL?=
 =?us-ascii?Q?0QIf688SewZE7+maybMkSSrhnQTk5mfmpBvvfVVtnbundXVixHZAJEmPj+po?=
 =?us-ascii?Q?nu0BjTNFUgwmMe1/Goo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:47:15.2823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe36841e-4a09-4deb-7d74-08de25515352
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

From: Cosmin Ratiu <cratiu@nvidia.com>

The esw mode change notifier chain is initialized/cleaned up in
mlx5_init_one() / mlx5_uninit_one() with the devlink lock held.

Move the notifier head from the eswitch struct into mlx5_priv directly,
and initialize it outside the critical section. This will allow notifier
registration to happen earlier in the init procedure in subsequent
patches.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   | 13 +++++++------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h   |  7 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/main.c      |  2 ++
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c    |  6 +++---
 include/linux/mlx5/driver.h                         |  1 +
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 25af8bd7f077..3adf2b1cd26a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1474,7 +1474,7 @@ static void mlx5_esw_mode_change_notify(struct mlx5_eswitch *esw, u16 mode)
 
 	info.new_mode = mode;
 
-	blocking_notifier_call_chain(&esw->n_head, 0, &info);
+	blocking_notifier_call_chain(&esw->dev->priv.esw_n_head, 0, &info);
 }
 
 static int mlx5_esw_egress_acls_init(struct mlx5_core_dev *dev)
@@ -2050,7 +2050,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_BASIC;
 	else
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
-	BLOCKING_INIT_NOTIFIER_HEAD(&esw->n_head);
 
 	esw_info(dev,
 		 "Total vports %d, per vport: max uc(%d) max mc(%d)\n",
@@ -2379,14 +2378,16 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 		dev1->priv.eswitch->mode == MLX5_ESWITCH_OFFLOADS);
 }
 
-int mlx5_esw_event_notifier_register(struct mlx5_eswitch *esw, struct notifier_block *nb)
+int mlx5_esw_event_notifier_register(struct mlx5_core_dev *dev,
+				     struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&esw->n_head, nb);
+	return blocking_notifier_chain_register(&dev->priv.esw_n_head, nb);
 }
 
-void mlx5_esw_event_notifier_unregister(struct mlx5_eswitch *esw, struct notifier_block *nb)
+void mlx5_esw_event_notifier_unregister(struct mlx5_core_dev *dev,
+					struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&esw->n_head, nb);
+	blocking_notifier_chain_unregister(&dev->priv.esw_n_head, nb);
 }
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index beaec450a734..ad1073f7b79f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -403,7 +403,6 @@ struct mlx5_eswitch {
 	struct {
 		u32             large_group_num;
 	}  params;
-	struct blocking_notifier_head n_head;
 	struct xarray paired;
 	struct mlx5_devcom_comp_dev *devcom;
 	u16 enabled_ipsec_vf_count;
@@ -864,8 +863,10 @@ struct mlx5_esw_event_info {
 	u16 new_mode;
 };
 
-int mlx5_esw_event_notifier_register(struct mlx5_eswitch *esw, struct notifier_block *n);
-void mlx5_esw_event_notifier_unregister(struct mlx5_eswitch *esw, struct notifier_block *n);
+int mlx5_esw_event_notifier_register(struct mlx5_core_dev *dev,
+				     struct notifier_block *n);
+void mlx5_esw_event_notifier_unregister(struct mlx5_core_dev *dev,
+					struct notifier_block *n);
 
 bool mlx5_esw_hold(struct mlx5_core_dev *dev);
 void mlx5_esw_release(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 612fc4de9d3c..05f16f3e9c4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1834,6 +1834,8 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 		return err;
 	}
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&dev->priv.esw_n_head);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 3304f25cc805..2ece4983d33f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -481,7 +481,7 @@ int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 	xa_init(&table->function_ids);
 	dev->priv.sf_table = table;
 	table->esw_nb.notifier_call = mlx5_sf_esw_event;
-	err = mlx5_esw_event_notifier_register(dev->priv.eswitch, &table->esw_nb);
+	err = mlx5_esw_event_notifier_register(dev, &table->esw_nb);
 	if (err)
 		goto reg_err;
 
@@ -496,7 +496,7 @@ int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 	return 0;
 
 vhca_err:
-	mlx5_esw_event_notifier_unregister(dev->priv.eswitch, &table->esw_nb);
+	mlx5_esw_event_notifier_unregister(dev, &table->esw_nb);
 reg_err:
 	mutex_destroy(&table->sf_state_lock);
 	kfree(table);
@@ -513,7 +513,7 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 
 	mlx5_blocking_notifier_unregister(dev, &table->mdev_nb);
 	mlx5_vhca_event_notifier_unregister(table->dev, &table->vhca_nb);
-	mlx5_esw_event_notifier_unregister(dev->priv.eswitch, &table->esw_nb);
+	mlx5_esw_event_notifier_unregister(dev, &table->esw_nb);
 	mutex_destroy(&table->sf_state_lock);
 	WARN_ON(!xa_empty(&table->function_ids));
 	kfree(table);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 046396269ccf..27eeadbcff50 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -599,6 +599,7 @@ struct mlx5_priv {
 
 	struct mlx5_flow_steering *steering;
 	struct mlx5_mpfs        *mpfs;
+	struct blocking_notifier_head esw_n_head;
 	struct mlx5_eswitch     *eswitch;
 	struct mlx5_core_sriov	sriov;
 	struct mlx5_lag		*lag;
-- 
2.31.1


