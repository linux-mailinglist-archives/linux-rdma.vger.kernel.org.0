Return-Path: <linux-rdma+bounces-14513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30FC61CB3
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 805A934F17A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB57287243;
	Sun, 16 Nov 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSi/Dctc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F526C38C;
	Sun, 16 Nov 2025 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326056; cv=fail; b=ZHHjarRxO+1ZFyGoBtDsvaBd/gd+UDt82JODU6V5t1Ju+j3Oavjwgvg4lLrSSNG5hwHgz7YK6pypfNp+49+Dy5VPQJOlWCzO62xLX6HjLTrWzDgBVVkGeW9XsfXKLht0+FZdQX/SLvKK2qqA3w08u1+LGVJNjSy6ZOUmPwsIHx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326056; c=relaxed/simple;
	bh=IhyIV9lT2Z4IfnqtNNdM6dvLhXJtTJBO1jWIubV8SjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQyA9/ce7rNfTEk4uWdr7mv4yJXtJwmVC+VADcpAE1pLBqKp0YCtL74rgSd4Pp9HwGzbwM41Tt2pCoEm74k6Rr9w/t7jg/o87Q/wHpov20YJgU2GLJCN3FCae645hCt243Kp7SoCYbxLKKfkyF3SaV3j9P5j64lqtYcJTUKSvHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSi/Dctc; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR4oZHub4Xaq75+1uTLv7BIk9XRXxGIzyLFOI/DFjGhC9Lp4MgohYrR7vTZX9lmJbzYh4zja26d0iD1+SlOnSc+5lRissWdDHvyXBBuBriD0b4pQi3QNug4KZN9UAeBhWIC2VLf9UcjGo73dv7wjoSMN7SmKsX2Z2yxjPTetm+J+/QsXw6UTkkx0gRwDZvcAfW4tz6XT67GFDQMegMolZgrVuf2N2oOABYHTWOFuccmC87q+GwYgl6QOerYbeSw46WODGkyK/jANEU8YHJ+DHsxn3zhgpoLVFAtfEXPEARf2YsuREl0aA6CFRfbj//Y+H8JlHs0w9HQJTJ3W93jB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX/ptg5s/0wChUpwpGX2zmgFvBSoFZ8gaG97I0f+Dlw=;
 b=AphQN22ZQ8F0z4TO8fRoTHUP9YibqZhXHK2wvnJenhq/wYiadtUcZIqurb4eNveHrqaHO922/gjh8SlS70qsz6QOTyzaZDMkTiQ90lvrNws2Tv3wa4mc4rtN7Q279C5QjeDTXS3dbkuplZ1wFY63PPdAFlkfzFUGzync0GPIdMDDKgRNdiUggDGtUGdjr/WjoWBMtDWNH+sCFUJk3wY0CEWDQR3FCqCwFVRthHfQlrn6ZBC70LlvLHdBChEgPunaeFFQMlzQS7qR3cHnJWDUGwdytrXWWLSJes+ptekPKI35aH8W0iBAykXvH1tnX48nYR4yKXjtRAEoK5BRGcKV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX/ptg5s/0wChUpwpGX2zmgFvBSoFZ8gaG97I0f+Dlw=;
 b=iSi/DctciX+lMnJ1sdnLBY6rTo2tk3LCA27tZG+hfmo8JOUvtjI1FWtfAYjiTrl8x+mOZwl+x4I0/FVLrMct2t13WlbVxHM9zPipDQ1GqLYlI3RgXRzuJl5dtS3Id4+dELMAuUYLbgejQY7lM3jhytj+XnFMc/bLeiEevf9omXZ9KZ4zHemxM1JcVb1YDZs6V4IEuh2/49eBpxzoftYB+/4fGtUWNWhvuGRBbNq6gWN2rhztgLUwkc9bsfg13Dh9pAKhRrzGikpgICN8EU0fEXWIZ2BXwbhNLEYaMkBSqZPqMQeIy8f60HRb6RQa/ZAz7zGJAqmP0WlGbcyi12tJgw==
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 20:47:27 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::a4) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Sun,
 16 Nov 2025 20:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:47:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:47:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:47:15 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:47:11 -0800
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
Subject: [PATCH net-next 4/6] net/mlx5: Move the SF HW table notifier outside the devlink lock
Date: Sun, 16 Nov 2025 22:45:38 +0200
Message-ID: <1763325940-1231508-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: e160a4aa-4aaa-45ff-ffba-08de25515a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9RaEGD8t3pWmseiTl+GPl9JIkFR6GxiiuZYz7SJxkbWZSXO8T8QfUEBev3j?=
 =?us-ascii?Q?8a1L0sZHzRdCHjxkUwcKxJwxb6P91gKQ3e+lyzOUZP0K5rkv1OoB1AlXl/bl?=
 =?us-ascii?Q?d7K6tRktCQtXhAZOGW/ZzGN6dW6EmFkAyH4bCAlhDB3HJ8ETtOaNFb5UnBb3?=
 =?us-ascii?Q?yw4i3eLaRNhstr/BBx5UWYAkkq3+XtoBYor+WXfGlF8Lp1/ie7OoPvtGsc4P?=
 =?us-ascii?Q?ucNQ8RGNTSzZZLpyv/SNE02rd5b0Jv0mmh1RtnreXZLKEZq6kQLFNz4EdLGy?=
 =?us-ascii?Q?0V9EIfBOGS7MSF8xRG5YyYv+XD8iTZW8mHdN8OqbrsWY4pJs8jtuMOfJk35G?=
 =?us-ascii?Q?SvQZ39PLTU2hh5Sz5O/lzFxfgiQ43QkK1uveMqxfuJ4xAR/7XMrTNuEx0w/u?=
 =?us-ascii?Q?WGkvcoj549hCUMEl4WnTa/ytdoIm6JsWfO6nMJdhNw5FKCUFUdSHs0f34/Sh?=
 =?us-ascii?Q?U8sZVrpy+g0IKqGciy2/DdhxEvuHLxTjPb7rZVcOuoz6iSPJOtmgy70AF2t/?=
 =?us-ascii?Q?gLvXlUTw7pkKW5zAhrM0urm/KgeIIl7UYu/LL2IGdnSbN0xdQm9ZP6QPFvEe?=
 =?us-ascii?Q?0DPXK43i8cnyoS5hbaw8Jya8A1DuOAgxxunITswe9o6TWnrLHnX+B1R4yPx9?=
 =?us-ascii?Q?TZR3MQ/gW2JxtQec717n8EoFTnJ31aIfx1UaXQ8z6pVG4HWsuaaVReCxw8MC?=
 =?us-ascii?Q?Y1EAkzqCHcb5/XZL1I/mC6+3SFjd3Y8vEP+ogCqjEibUhVnLoZ3W+nT0o5Me?=
 =?us-ascii?Q?o+MQJG5VpYoamiFF6z/x1ewGCscqq6uLEecA8fTXYEN90L3gWRANEFOKaJc/?=
 =?us-ascii?Q?KDekr79Wf4vmQylq5rY/Cafx72HB6t/UVYHnSYNSVvy3pzM/inRs7lkROK6m?=
 =?us-ascii?Q?WLYMrQ7z4+Fh9OCP6oXD7hsJgQXLxiNdc4gsVc+TWySJhe+aptgk99FGtqlE?=
 =?us-ascii?Q?OH6or2ll4VGS2NJPxPADHc12X12/7kLKi1Lwm2xFfqHPDwZ64Aot2+bwDHxW?=
 =?us-ascii?Q?R6ePszaMFfLP2b7OQg+EDGaTGI+OKGWa5VZsXKd8eKenEJBTPAzWOsghj4fU?=
 =?us-ascii?Q?09QKyiQibG+mhBy6K9Q+Q3IH7hlzzR/lhqOcU1T4np5KxjCI3eGjzpqlOULy?=
 =?us-ascii?Q?cLIwKPBqcokjS6WJ43GsUErokK9RlytKL+k/U1eifNlBXezbzDunDj5Pbuum?=
 =?us-ascii?Q?QiSybqvihFpRK1fuKMQoXrsMsCxjkwY2ts8kufLq+HsOv1+6VaJxvoFpDY1/?=
 =?us-ascii?Q?HiPgz3bKAM3///Dxk3pRLWEMWRZIRkjUlmdR7EeM5Xql9XGkG27sbojTVfgF?=
 =?us-ascii?Q?BsN0gByFKcrnwvsiEpfPsnsacMz0+5rSIMQ/DSiawwr3xZUak+7nElY+D6eM?=
 =?us-ascii?Q?iQNyg6c9DvXj2ZdC2iToSt/ThkxpAY5wSiDU0DtwUpmjPr5SqQjGqLBbzwXT?=
 =?us-ascii?Q?qhT1WOqgvHah+EEMcAHsP6xMytiqJyT48eCAotdsd4SrMm+YOln5wDuexHeW?=
 =?us-ascii?Q?szBJyMsL9uvK/kY0SlmEdEzYAJ/oc6UD+KwYxggcTHHwZuLX14sluLi7jB3o?=
 =?us-ascii?Q?t8RZBeqegOFv1I3FBcU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:47:26.6745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e160a4aa-4aaa-45ff-ffba-08de25515a1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

From: Cosmin Ratiu <cratiu@nvidia.com>

Move the SF HW table notifier registration/unregistration outside of
mlx5_init_one() / mlx5_uninit_one() and into the mlx5_mdev_init() /
mlx5_mdev_uninit() functions.

This is only done for non-SFs, since SFs do not have a SF HW table
themselves.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++---
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c | 62 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/sf/sf.h   |  9 ++-
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 097ba7ab90a4..843ee452239f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1377,12 +1377,6 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 
 	mlx5_vhca_event_start(dev);
 
-	err = mlx5_sf_hw_table_create(dev);
-	if (err) {
-		mlx5_core_err(dev, "sf table create failed %d\n", err);
-		goto err_vhca;
-	}
-
 	err = mlx5_ec_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to init embedded CPU\n");
@@ -1411,8 +1405,6 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 	mlx5_lag_remove_mdev(dev);
 	mlx5_ec_cleanup(dev);
 err_ec:
-	mlx5_sf_hw_table_destroy(dev);
-err_vhca:
 	mlx5_vhca_event_stop(dev);
 err_set_hca:
 	mlx5_fs_core_cleanup(dev);
@@ -1837,11 +1829,20 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 	BLOCKING_INIT_NOTIFIER_HEAD(&dev->priv.esw_n_head);
 	mlx5_vhca_state_notifier_init(dev);
 
+	err = mlx5_sf_hw_notifier_init(dev);
+	if (err)
+		goto err_sf_hw_notifier;
+
 	return 0;
+
+err_sf_hw_notifier:
+	mlx5_events_cleanup(dev);
+	return err;
 }
 
 static void mlx5_notifiers_cleanup(struct mlx5_core_dev *dev)
 {
+	mlx5_sf_hw_notifier_cleanup(dev);
 	mlx5_events_cleanup(dev);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
index a14b1aa5fb5a..bd968f3b3855 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
@@ -30,9 +30,7 @@ enum mlx5_sf_hwc_index {
 };
 
 struct mlx5_sf_hw_table {
-	struct mlx5_core_dev *dev;
 	struct mutex table_lock; /* Serializes sf deletion and vhca state change handler. */
-	struct notifier_block vhca_nb;
 	struct mlx5_sf_hwc_table hwc[MLX5_SF_HWC_MAX];
 };
 
@@ -71,14 +69,16 @@ mlx5_sf_table_fn_to_hwc(struct mlx5_sf_hw_table *table, u16 fn_id)
 	return NULL;
 }
 
-static int mlx5_sf_hw_table_id_alloc(struct mlx5_sf_hw_table *table, u32 controller,
+static int mlx5_sf_hw_table_id_alloc(struct mlx5_core_dev *dev,
+				     struct mlx5_sf_hw_table *table,
+				     u32 controller,
 				     u32 usr_sfnum)
 {
 	struct mlx5_sf_hwc_table *hwc;
 	int free_idx = -1;
 	int i;
 
-	hwc = mlx5_sf_controller_to_hwc(table->dev, controller);
+	hwc = mlx5_sf_controller_to_hwc(dev, controller);
 	if (!hwc->sfs)
 		return -ENOSPC;
 
@@ -100,11 +100,13 @@ static int mlx5_sf_hw_table_id_alloc(struct mlx5_sf_hw_table *table, u32 control
 	return free_idx;
 }
 
-static void mlx5_sf_hw_table_id_free(struct mlx5_sf_hw_table *table, u32 controller, int id)
+static void mlx5_sf_hw_table_id_free(struct mlx5_core_dev *dev,
+				     struct mlx5_sf_hw_table *table,
+				     u32 controller, int id)
 {
 	struct mlx5_sf_hwc_table *hwc;
 
-	hwc = mlx5_sf_controller_to_hwc(table->dev, controller);
+	hwc = mlx5_sf_controller_to_hwc(dev, controller);
 	hwc->sfs[id].allocated = false;
 	hwc->sfs[id].pending_delete = false;
 }
@@ -120,7 +122,7 @@ int mlx5_sf_hw_table_sf_alloc(struct mlx5_core_dev *dev, u32 controller, u32 usr
 		return -EOPNOTSUPP;
 
 	mutex_lock(&table->table_lock);
-	sw_id = mlx5_sf_hw_table_id_alloc(table, controller, usr_sfnum);
+	sw_id = mlx5_sf_hw_table_id_alloc(dev, table, controller, usr_sfnum);
 	if (sw_id < 0) {
 		err = sw_id;
 		goto exist_err;
@@ -151,7 +153,7 @@ int mlx5_sf_hw_table_sf_alloc(struct mlx5_core_dev *dev, u32 controller, u32 usr
 vhca_err:
 	mlx5_cmd_dealloc_sf(dev, hw_fn_id);
 err:
-	mlx5_sf_hw_table_id_free(table, controller, sw_id);
+	mlx5_sf_hw_table_id_free(dev, table, controller, sw_id);
 exist_err:
 	mutex_unlock(&table->table_lock);
 	return err;
@@ -165,7 +167,7 @@ void mlx5_sf_hw_table_sf_free(struct mlx5_core_dev *dev, u32 controller, u16 id)
 	mutex_lock(&table->table_lock);
 	hw_fn_id = mlx5_sf_sw_to_hw_id(dev, controller, id);
 	mlx5_cmd_dealloc_sf(dev, hw_fn_id);
-	mlx5_sf_hw_table_id_free(table, controller, id);
+	mlx5_sf_hw_table_id_free(dev, table, controller, id);
 	mutex_unlock(&table->table_lock);
 }
 
@@ -216,10 +218,12 @@ static void mlx5_sf_hw_table_hwc_dealloc_all(struct mlx5_core_dev *dev,
 	}
 }
 
-static void mlx5_sf_hw_table_dealloc_all(struct mlx5_sf_hw_table *table)
+static void mlx5_sf_hw_table_dealloc_all(struct mlx5_core_dev *dev,
+					 struct mlx5_sf_hw_table *table)
 {
-	mlx5_sf_hw_table_hwc_dealloc_all(table->dev, &table->hwc[MLX5_SF_HWC_EXTERNAL]);
-	mlx5_sf_hw_table_hwc_dealloc_all(table->dev, &table->hwc[MLX5_SF_HWC_LOCAL]);
+	mlx5_sf_hw_table_hwc_dealloc_all(dev,
+					 &table->hwc[MLX5_SF_HWC_EXTERNAL]);
+	mlx5_sf_hw_table_hwc_dealloc_all(dev, &table->hwc[MLX5_SF_HWC_LOCAL]);
 }
 
 static int mlx5_sf_hw_table_hwc_init(struct mlx5_sf_hwc_table *hwc, u16 max_fn, u16 base_id)
@@ -301,7 +305,6 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 	}
 
 	mutex_init(&table->table_lock);
-	table->dev = dev;
 	dev->priv.sf_hw_table = table;
 
 	base_id = mlx5_sf_start_function_id(dev);
@@ -338,19 +341,22 @@ void mlx5_sf_hw_table_cleanup(struct mlx5_core_dev *dev)
 	mlx5_sf_hw_table_hwc_cleanup(&table->hwc[MLX5_SF_HWC_LOCAL]);
 	mutex_destroy(&table->table_lock);
 	kfree(table);
+	dev->priv.sf_hw_table = NULL;
 res_unregister:
 	mlx5_sf_hw_table_res_unregister(dev);
 }
 
 static int mlx5_sf_hw_vhca_event(struct notifier_block *nb, unsigned long opcode, void *data)
 {
-	struct mlx5_sf_hw_table *table = container_of(nb, struct mlx5_sf_hw_table, vhca_nb);
+	struct mlx5_core_dev *dev = container_of(nb, struct mlx5_core_dev,
+						 priv.sf_hw_table_vhca_nb);
+	struct mlx5_sf_hw_table *table = dev->priv.sf_hw_table;
 	const struct mlx5_vhca_state_event *event = data;
 	struct mlx5_sf_hwc_table *hwc;
 	struct mlx5_sf_hw *sf_hw;
 	u16 sw_id;
 
-	if (event->new_vhca_state != MLX5_VHCA_STATE_ALLOCATED)
+	if (!table || event->new_vhca_state != MLX5_VHCA_STATE_ALLOCATED)
 		return 0;
 
 	hwc = mlx5_sf_table_fn_to_hwc(table, event->function_id);
@@ -365,20 +371,28 @@ static int mlx5_sf_hw_vhca_event(struct notifier_block *nb, unsigned long opcode
 	 * Hence recycle the sf hardware id for reuse.
 	 */
 	if (sf_hw->allocated && sf_hw->pending_delete)
-		mlx5_sf_hw_table_hwc_sf_free(table->dev, hwc, sw_id);
+		mlx5_sf_hw_table_hwc_sf_free(dev, hwc, sw_id);
 	mutex_unlock(&table->table_lock);
 	return 0;
 }
 
-int mlx5_sf_hw_table_create(struct mlx5_core_dev *dev)
+int mlx5_sf_hw_notifier_init(struct mlx5_core_dev *dev)
 {
-	struct mlx5_sf_hw_table *table = dev->priv.sf_hw_table;
-
-	if (!table)
+	if (mlx5_core_is_sf(dev))
 		return 0;
 
-	table->vhca_nb.notifier_call = mlx5_sf_hw_vhca_event;
-	return mlx5_vhca_event_notifier_register(dev, &table->vhca_nb);
+	dev->priv.sf_hw_table_vhca_nb.notifier_call = mlx5_sf_hw_vhca_event;
+	return mlx5_vhca_event_notifier_register(dev,
+						 &dev->priv.sf_hw_table_vhca_nb);
+}
+
+void mlx5_sf_hw_notifier_cleanup(struct mlx5_core_dev *dev)
+{
+	if (mlx5_core_is_sf(dev))
+		return;
+
+	mlx5_vhca_event_notifier_unregister(dev,
+					    &dev->priv.sf_hw_table_vhca_nb);
 }
 
 void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev)
@@ -388,10 +402,8 @@ void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev)
 	if (!table)
 		return;
 
-	mlx5_vhca_event_notifier_unregister(dev, &table->vhca_nb);
-
 	/* Dealloc SFs whose firmware event has been missed. */
-	mlx5_sf_hw_table_dealloc_all(table);
+	mlx5_sf_hw_table_dealloc_all(dev, table);
 }
 
 bool mlx5_sf_hw_table_supported(const struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
index 89559a37997a..3922dacffae8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
@@ -12,7 +12,8 @@
 int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev);
 void mlx5_sf_hw_table_cleanup(struct mlx5_core_dev *dev);
 
-int mlx5_sf_hw_table_create(struct mlx5_core_dev *dev);
+int mlx5_sf_hw_notifier_init(struct mlx5_core_dev *dev);
+void mlx5_sf_hw_notifier_cleanup(struct mlx5_core_dev *dev);
 void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev);
 
 int mlx5_sf_table_init(struct mlx5_core_dev *dev);
@@ -44,11 +45,15 @@ static inline void mlx5_sf_hw_table_cleanup(struct mlx5_core_dev *dev)
 {
 }
 
-static inline int mlx5_sf_hw_table_create(struct mlx5_core_dev *dev)
+static inline int mlx5_sf_hw_notifier_init(struct mlx5_core_dev *dev)
 {
 	return 0;
 }
 
+static inline void mlx5_sf_hw_notifier_cleanup(struct mlx5_core_dev *dev)
+{
+}
+
 static inline void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev)
 {
 }
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 57368db0a5b7..a51bea44d57c 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -620,6 +620,7 @@ struct mlx5_priv {
 	struct mlx5_core_dev *parent_mdev;
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
+	struct notifier_block sf_hw_table_vhca_nb;
 	struct mlx5_sf_hw_table *sf_hw_table;
 	struct mlx5_sf_table *sf_table;
 #endif
-- 
2.31.1


