Return-Path: <linux-rdma+bounces-8831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19DDA68E76
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2217A6F0B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04E1C5F25;
	Wed, 19 Mar 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usgGf1DR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDB1C5D51;
	Wed, 19 Mar 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393082; cv=fail; b=W+FU5RENm+4miQW2LF0noEFeao76Onp3KXDajHMakZGEDdmjIWveF1WkX89+YNc9ryNaSMpNrIRcj80quWJJwlQJiPbzOfT7b7Fp+JoYXkN0xE+/FaJPT8KfOAaz//GB/xZeuHecHiBjg7dqYlhKiLama7fpr09nZ0sM0vsM+6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393082; c=relaxed/simple;
	bh=dXyTRlP1I5lYfvB7puPsPWcojviMTUPV0PWj2ycFI/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2Ha7B+FD/VYpQG1/x6pAPth8kjVYFacSCc+/ZeEhgQESE1Jxum81pFJXnm4VOBJ4JF9ROzik/MyMn7BUaRQTVij2jupBYNM14Sg8OhUPkajsQVyusSkRtGFtzwUdmpk5QLIXw0gIa2nOCC/tK+uCIPJw35zT63FXirIi5MbloU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usgGf1DR; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXZPP4ERRMx5SUVDirOKyk2mlHc2rjBUwiT08/q64/bMj4skYeYkQgTZcTWukQLHqNufAXxbBUfCpSUGFyft2spmqDHZSXQgfGNi7WVh362JRZs2MJx+IGA7u/8dASuWCFzEpJw5j+VEYaML12v2CLBpKjqgBju3yQqvMfmYvYqiIWKfT6Br3Hytjl4HIse+6YmmxANjupuGrjOUuY1Hf6gqp5QJft9BrTF2ldM0wU3WGrpkPlBA7yW+ShvLxXcp90bidWdsS+iR3d9PicgUBd2bW56oOagNomobhoWQztNiqUEh3RzkvhJc+L641RY2HLph5FEFPfcHO6TygzDMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d2kuBDtSR58wFjRxStxTHRspgdbkRA21KQn24KfMYI=;
 b=Sz3t3JkTVQe/REYZwUSzJe9J+pi5vKRdJGobL9lSMrpQSq7ApvzO5QC3WJptU3bTdRkxvXpHbupYCrwJYHUBksI4MZqA1VRUjUVSlGNQxvNRIikU6yTdlZg9IjkNSxbZHG9i6YFxqW61qJTACtmWc3zF5ZstMvzuI241vxRTnYwljE7fWhSjXiJ0KeJxHZgmSm4A3USY3J2XtKLg99ncdQzRyRSP7FxEZ30BTaqCJ+/mCHEb81LEzPX/gH35ugc8hurgvNwu8SUHWISMH3Bn5CEgoAYFKnIgbXCB3rixvjOhHq2f0YdAigc08UpJxLBtEyJmmcCzNZ2EWsIwWesPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d2kuBDtSR58wFjRxStxTHRspgdbkRA21KQn24KfMYI=;
 b=usgGf1DRZ7GUpnbDrWgZlMDuxwizBCh8zukTHUozY0ohpGdmtJ6QhTw+lE+h1MJ60rvqxqdx39GlWSHOYahQEWqQeMptt1SdBqIjY6sJvoIM1rW+nvhEMxAZakxy5/N8hGFk2M/7NwhfsqjRI6DaCepkPoBrSMIiFDoZWYUS1RCKMHk6x1plvL5UVYrqnxaX8ZSya7FtcBpUswpJAWpUrmHC3vD6hlQ3XSMayAkKWsbNwVxrjhBon/eYa7uZSKxQEM9ilGUNqZbA7nvcdOpim+LMXkHd4Pz4pWmWGSDq7rK8/pN4OsRrkSol5xpQYlNlThAb/AfplYPWDP4cBYWjJQ==
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 14:04:36 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::57) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 14:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 14:04:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 07:04:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:04:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 07:04:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5: Update pfnum retrieval for devlink port attributes
Date: Wed, 19 Mar 2025 16:03:01 +0200
Message-ID: <1742392983-153050-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
References: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: fddf63a7-fe89-48b2-6ea0-08dd66eefaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AKSvmIT6qdLPT2YBd5iv+k2R6TnRtgDGnppkBX9syWmLE9cGf0muHfQQCvBd?=
 =?us-ascii?Q?/YgEYQnuxkuw68NNk7bqwr0mv4sOfPcmqq/e2+ritDUMzCYHXJFEiidmW83K?=
 =?us-ascii?Q?/Ue+KzugGaoXmgXDMMRxVJGInq20zRzPYUJqgBly6LGMZxYfAAdVblUTGTVd?=
 =?us-ascii?Q?pW1Y3kheZemACAxaTRucKHjdj/PnCVOcA++8A3aRfG2hk9E23oxGGqaZA9p3?=
 =?us-ascii?Q?UB8p+gis2oQoWvPcE/Gps7fgPNKJd1K2VVlNUbrdmd0j8Pn08BMDblkLIwI1?=
 =?us-ascii?Q?D05dmywTPrqBB1FtCo+1QRMZJppTqrmxlBPplTsFKiSbh7WetrqdYk6tX+Om?=
 =?us-ascii?Q?uUVPLlK3xUdXUt0n+9+VTKW+d4q3gfcx+vWnELQ9efqyR+tSc4rTLTiqgOMl?=
 =?us-ascii?Q?4qKXO6SdRVVJgOpWrMK1tifr/i2jUef+1/EPFHBuBubW6MUTtfxk6FmzetCS?=
 =?us-ascii?Q?1CU97EKT+XVvb38h9gS5QBrUaLStmhrHDST6PvqFOzMnjPRj0G4PWKqyzTFl?=
 =?us-ascii?Q?Pzh6SVHOpe6KqDcyR2dfGTI9698OpgVDGWrdxfWJkp38LI3/z2stx3dcxnAm?=
 =?us-ascii?Q?8sHMZbnh31sJ8FYbdVKastgBMJQ2sFk1985dUz7f/Rv3/v2qfG6lxKN8f3Db?=
 =?us-ascii?Q?J2p+RS43YNseHfH9ih2RMOalYMLJj8dDkVYwxyX4OHH07/q+9pVIRMwy0LYd?=
 =?us-ascii?Q?SxJW4BhoNlPOj9RWa5NKO7pHTJ6bn1Il5O2jk4d/2CEEZ51ob0SQ1d9xedba?=
 =?us-ascii?Q?zof5OLUZICeUUWKG1W/MXPwE9GKURYGKF141BiKckTtYpU7GMFKiY7AfxhGQ?=
 =?us-ascii?Q?Bo9y4f4BT92W4taddMjH9NI4K5K9Hoe/eSsiTdAEFdvn3fYPphuGC/iBUNBP?=
 =?us-ascii?Q?GpwFfbnNkvBPf1wD+U3eXT/aSGWbfrKe+D4Pw3itCNSCWXMLPKLsFIoqziBd?=
 =?us-ascii?Q?dUeJLCFpR6Km6r+3Uy95ZN3+/5u/F7xvtltnrVi5EuoOrGWZ1ZazRUWGG4Da?=
 =?us-ascii?Q?TuY6OwRfzaL9VjdDn9fhRRBY2iu/MbZwMNoUWP8dmbSOoE0gtxcQTwvUa2eE?=
 =?us-ascii?Q?GGv0IikI3rjI5G2TWwyCBPpA94VvJFQ72VuYB23d/xSS6JnPaL/SrMRyre06?=
 =?us-ascii?Q?gjKRKyQ81UoCgOLUdQL3PGrOqUz1Z3ycSyI0g1rBNHzZoEX2PavKO0cQ6Jq1?=
 =?us-ascii?Q?jBW0Dd0WL2yMqlV15uBbcws50lVRtQbOG9/VDqhjOHOW53buSBn4RyzUpZEI?=
 =?us-ascii?Q?0ELZUPbwdI9Rw3Cg19zKCwCYEJQPvM6eJFNG1ZKhJsklXk9mmXvWCqSOeIvO?=
 =?us-ascii?Q?jK/PPzOl0T28nYaLDnwPzynNIxKd5Cp0hNZvoaTw+ydtWYz+d3Cgu+G10N+q?=
 =?us-ascii?Q?0rc5miLEnNSZeV/M5lFhHn+1OSHmR8DAzSpvy5yJwuAJX0P1Bx4McV9eQX5C?=
 =?us-ascii?Q?GLmDzNQPmd7YbpIGY+aUHELk1ByzDbE4Y9rM4DO7NiN4Pwb14iztZBuzp5iP?=
 =?us-ascii?Q?x7AtoxjJ8ImdO3I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:04:35.3876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fddf63a7-fe89-48b2-6ea0-08dd66eefaee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

From: Shay Drory <shayd@nvidia.com>

Align mlx5 driver usage of 'pfnum' with the documentation clarification
introduced in commit bb70b0d48d8e ("devlink: Improve the port attributes
description").

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 982fe3714683..b7102e14d23d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -32,7 +32,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 	u16 pfnum;
 
 	mlx5_esw_get_port_parent_id(dev, &ppid);
-	pfnum = mlx5_get_dev_index(dev);
+	pfnum = PCI_FUNC(dev->pdev->devfn);
 	external = mlx5_core_is_ecpf_esw_manager(dev);
 	if (external)
 		controller_num = dev->priv.eswitch->offloads.host_number + 1;
@@ -110,7 +110,7 @@ static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw
 	struct netdev_phys_item_id ppid = {};
 	u16 pfnum;
 
-	pfnum = mlx5_get_dev_index(dev);
+	pfnum = PCI_FUNC(dev->pdev->devfn);
 	mlx5_esw_get_port_parent_id(dev, &ppid);
 	memcpy(dl_port->attrs.switch_id.id, &ppid.id[0], ppid.id_len);
 	dl_port->attrs.switch_id.id_len = ppid.id_len;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index b96909fbeb12..0864ba625c07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -285,7 +285,7 @@ mlx5_sf_new_check_attr(struct mlx5_core_dev *dev, const struct devlink_port_new_
 		NL_SET_ERR_MSG_MOD(extack, "External controller is unsupported");
 		return -EOPNOTSUPP;
 	}
-	if (new_attr->pfnum != mlx5_get_dev_index(dev)) {
+	if (new_attr->pfnum != PCI_FUNC(dev->pdev->devfn)) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid pfnum supplied");
 		return -EOPNOTSUPP;
 	}
-- 
2.31.1


