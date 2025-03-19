Return-Path: <linux-rdma+bounces-8843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD7A6993E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FB3188F469
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8252144D5;
	Wed, 19 Mar 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rz5IjV/+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DB213235;
	Wed, 19 Mar 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412290; cv=fail; b=lnN8sdlwhcYHcihNGzeYRD0m47sIwHPuWfv6l5P1rtL92kQobP5TiZ4W6EJtsY9ZqhhVrlj6G/y++8vuCwijxDLpKI0ssTjajCDhF1SYfp4/O8J4RpnuMl9RmA36L7ky8oduBmrs9eVf0z9Ye2TQbZtLeBU9umfdXyk3TVQgupw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412290; c=relaxed/simple;
	bh=olDL2l0LCvizcRs+YQPiPMgLNh5zLCPg1HS+a7Rcd+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvSl+lXPYE99oOUyYCDhEnSNnoDpSESGBgLfpg1qKIQ4pppGWR9ZcqlA/5AzGZ7DY/w0A2FEMVVBRFcbGVXfcfRICSBcNsX3p33rfVJULQwRrcCDTY6xcd0q4cM6zK7/VQK0r0K+xFgGucT4gGhjT8ailNKiFUTCZMCbrM0eyEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rz5IjV/+; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVZh3Cvu/BhwtRMW67LKHeUvhayEt+qokvdoNEZyz4bjHDKwSrwcpo9glaSC9Nq/1Ms7anB4oAEpYKoA7FCFZaU+xzo+H2u6QY5lHRoCkkhFPrcKozn/y4DuI69ShWB1P50t2lCvBQd6dvfOtAS/RWZxFf7t3dW4WimRpT9BdrItaE+A22SIQgW7NdU7CSo/dy6Ta2hJH+jc49x/7LXZXKyiE8FqNTzVJ4HTJXP3paT5/A/ntD+YwQYH8GH9xgsfWkFnbXZk7Cx0ECUZPDyl3S9zN2l+Tb6nECjA1RgcbED7YDwxr8yDD98w6bMt+tX0yTFZdz6GY0QQvEue1QagPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDCB+eGydQUzaELt89YKNWz3HuIbO5rU+0c3oTHeQls=;
 b=IbxB0rbJk1cKpEzHm7fxAm0W29iRfsbIvrFOam28f25Cc9ED9DudwosexGARoi5FKFnFRkutaF7PdqkPE7oczkhIN8OOK6YCBk1ENv4GZWh2DhKlmqNuMlR/5A2kLTMDvTZJikf6VDV1gIEWZV6S2eUSKXa1MY+yU2QKf8FHqf5LT6kBldAKGpBouqOkOHanFWRm5FEYIvBnAvbbw3doA9x9534sGPtCWuTIf9aAg7/kE0NH7IJO0XpqDeYUHZH37qRO+BDiNf5PUPYa5yPBALYuldC0gyC8yzXANzmphfg+ukGoSBFQAqM5hitManPmvXguuXY2+QzUcyeFpogR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDCB+eGydQUzaELt89YKNWz3HuIbO5rU+0c3oTHeQls=;
 b=Rz5IjV/+kxP2t2zPw2taJFPUPXrXX+Jp4I0Zgw3/FyASANyizJMDpWYFt5J8FNnfQD47dhCt+kkvyR7GiDYwpygp1ZLJJnpCQaE4mAy5phjMVBDjP/rV2kqSwxvMIaKj+lUuM45ysf9nz7NXejagNRtVj7wSMn83HeXYWJSisgiTSm0Vb4Jp8LiOpBdhUzmySyAeGTmjq4Zndoa7tdcqPfza3pc3FCN7rtTh+mf4FpxwHTRgmRcOC6vqdcLux6IV7Oa3NIAPzXP42oKdpGmk1t5iOHrFTRZAv6E3vPpiK7B9GgIDEdMY4fKNhhpTRJC3CLDtTHtMUv/62b25FEjLxw==
Received: from MN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:52d::7)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:24:44 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::73) by MN0PR04CA0011.outlook.office365.com
 (2603:10b6:208:52d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 19:24:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 12:24:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 12:24:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Mar 2025 12:24:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: Remove NULL check before dev_{put, hold}
Date: Wed, 19 Mar 2025 21:23:17 +0200
Message-ID: <1742412199-159596-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
References: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fb9190-28b8-41ae-f50b-08dd671bb3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9B9b15KUVIU83yvUS5ZipcShgu8HuXbayUaSG36TAZ5/Zn8qPcjeP8+KDvG?=
 =?us-ascii?Q?Sx8os+3Xp4NMSFtH/X19xwWUvFsGU7ND5n5KQiuzEnb7KVzGZsZfF/WbwcDK?=
 =?us-ascii?Q?15Lie4SziLdpMwc8TQDAGTbqodVSUJJX0lHSPVLGvlr7/jLhP02Tv3/DLUm/?=
 =?us-ascii?Q?3RhPaKtrYYuTXqzv826vuzwsiOqjT0JTXLfvD/fsRQK/MqiEbsoZ9CA9/Giu?=
 =?us-ascii?Q?Rtj8viGfUBOziRHXZhVRPmhyQ0LALmpkqsO/6cWLRCsdRbr4fYy97dliWOIV?=
 =?us-ascii?Q?rLusbwBVQ2rkyWtrGiamGbqn712p+9ejTEh7UI6km/x3/pSOA+NQu5ugOmnW?=
 =?us-ascii?Q?WCHOPyL/BtDxzR4OBcDTM2+Nc6/6s5XRrdiSYw++5ECcw9V1weHEpG95hkB+?=
 =?us-ascii?Q?2Jbc7BRcx94nJYHhAetHn6Y18DEafqXKCjA5lSZTzhsuKwsNWgtCrwc3geUi?=
 =?us-ascii?Q?wsTf3Gk0Qe0ADKocAdHluiWZBtyPrzAeetfV72UekQkBWffVL809IlnH7PAt?=
 =?us-ascii?Q?3sssEYoeuDS9H338JcK5jkp2Z2YZqYNbEIwbEzSvNN0N6G1kX1Vm0Q43CJrZ?=
 =?us-ascii?Q?Qx/4JreL77VXBS0CS7KnkIl+09CTsTkCLkvmBCn9viKToI9O8WLdEplptbxn?=
 =?us-ascii?Q?uTprBcdiZYWO++u/dVR82O5ySdBxzqT7hDC8+Tn0wf2K4NnXTkZBRR8rEXm7?=
 =?us-ascii?Q?fvbdkWQ0gSSBzTVO8mGdUtMaV87fVHCHqcH0TTyU4SOMG6CFiv4eLBxwx1kh?=
 =?us-ascii?Q?U13Ijb8cL9NnnBpux0ROMnFpHrhCoo7iPOXPTS7qZjc3uDQePtiKfPJWEPXX?=
 =?us-ascii?Q?RQ7bqXbXO/+gMDZCe/1+Pb/m+zOS3W6LxtpNgq3Mh4TFGxpOfV/HDS8qPI8W?=
 =?us-ascii?Q?VsBaKSbfSh9bsFUDCyVWCBLbori7PXwtA4VuKzgJC1n4e+AKXen+HdURlo3J?=
 =?us-ascii?Q?6/JlZpbf3F42jlR20ksW2rAS5hIgB9Ge1S4lyPVN3r5HIcAaLw38V+YgrSQq?=
 =?us-ascii?Q?xTZz2WTq7bOxAgLwjQFSqaKYaE3fpO0QknyDeUSADnzSIB+0xWFY6+EkobvR?=
 =?us-ascii?Q?AFYk7lGOitJPgHawRd1adqT+VQVN7ZY9pa53Qi4l/94EJhqbxiXWPTsD3TBu?=
 =?us-ascii?Q?qQxDntTB7+S1ZQU7/TF/s04DbSBoLk/S1FdjP14+f8jV+xOcRbKvnXlkzP2X?=
 =?us-ascii?Q?XID6X0DcXhu0hiX4N/LYSgsCgDN3LVwgHWoohBA0StSx5Kqrup9/QmD9G5cW?=
 =?us-ascii?Q?80yz6iDtSUmjvmmomuNObANjBdTJ8ac5umw3qbU5dn2ZlHeY0sYW7YyKO7qU?=
 =?us-ascii?Q?0JCMoYIpS07VNdq5rDfb/alLy246IvAyJT2JAIiEEijTh9CXaaOEjPUt3fkw?=
 =?us-ascii?Q?Yc4Z8vi5Pei6R2cCLriWINscs0OwIjMOB/ch7XRpBlUTDWOzkk1C8TN/0kwH?=
 =?us-ascii?Q?NdEAd3LJrd0meCWw2T0l0UbisedLJ+BT3wT/p4wm34jpAeLQCty8AzR5J8zb?=
 =?us-ascii?Q?Y2NG7s6dFxSQzxI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:43.4770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fb9190-28b8-41ae-f50b-08dd671bb3e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

From: Gal Pressman <gal@nvidia.com>

Fix coccinelle warnings:
WARNING: NULL check before dev_{put, hold} functions is not needed.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c      | 9 +++------
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c    | 9 +++------
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c        | 3 +--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 721f35e59757..2162d776fe35 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -31,8 +31,7 @@ static void mlx5e_tc_tun_route_attr_cleanup(struct mlx5e_tc_tun_route_attr *attr
 {
 	if (attr->n)
 		neigh_release(attr->n);
-	if (attr->route_dev)
-		dev_put(attr->route_dev);
+	dev_put(attr->route_dev);
 }
 
 struct mlx5e_tc_tunnel *mlx5e_get_tc_tun(struct net_device *tunnel_dev)
@@ -68,16 +67,14 @@ static int get_route_and_out_devs(struct mlx5e_priv *priv,
 	 * while holding rcu read lock. Take the net_device for correctness
 	 * sake.
 	 */
-	if (uplink_upper)
-		dev_hold(uplink_upper);
+	dev_hold(uplink_upper);
 	rcu_read_unlock();
 
 	dst_is_lag_dev = (uplink_upper &&
 			  netif_is_lag_master(uplink_upper) &&
 			  real_dev == uplink_upper &&
 			  mlx5_lag_is_sriov(priv->mdev));
-	if (uplink_upper)
-		dev_put(uplink_upper);
+	dev_put(uplink_upper);
 
 	/* if the egress device isn't on the same HW e-switch or
 	 * it's a LAG device, use the uplink
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index e7e01f3298ef..a0fc76a1bc08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -42,8 +42,7 @@ static int mlx5e_set_int_port_tunnel(struct mlx5e_priv *priv,
 						&attr->action, out_index);
 
 out:
-	if (route_dev)
-		dev_put(route_dev);
+	dev_put(route_dev);
 
 	return err;
 }
@@ -753,8 +752,7 @@ static int mlx5e_set_vf_tunnel(struct mlx5_eswitch *esw,
 	}
 
 out:
-	if (route_dev)
-		dev_put(route_dev);
+	dev_put(route_dev);
 	return err;
 }
 
@@ -788,8 +786,7 @@ static int mlx5e_update_vf_tunnel(struct mlx5_eswitch *esw,
 	mlx5e_tc_match_to_reg_mod_hdr_change(esw->dev, mod_hdr_acts, VPORT_TO_REG, act_id, data);
 
 out:
-	if (route_dev)
-		dev_put(route_dev);
+	dev_put(route_dev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ed2ba272946b..ba41dd149f53 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -523,8 +523,7 @@ static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev
 		ndev = ldev->pf[last_idx].netdev;
 	}
 
-	if (ndev)
-		dev_hold(ndev);
+	dev_hold(ndev);
 
 unlock:
 	spin_unlock_irqrestore(&lag_lock, flags);
-- 
2.31.1


