Return-Path: <linux-rdma+bounces-14770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D3C86F27
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BE134E07E2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277833C19B;
	Tue, 25 Nov 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nm47Gz0V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916C33FE0D;
	Tue, 25 Nov 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101283; cv=fail; b=Tw0zAuzk5Fqlk2Qp22LuID/14euAnh1gS/x6NwPUNWFjE6FdXSr1DZr8VFpVILBNPT3cj7eBwFdefNbF/CtaHHxsdK3WODfuPW0XvEMN5tUy4c1X4bCtnMWzETmCWvM23ITA1+5VJW+wGyOUTza2vWoBBYOT4F3ukc9Aj/kzgcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101283; c=relaxed/simple;
	bh=WXI4mPHSLY+tAy1zXP51/Q7vhoBiJyspgV9I95XoDtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGbjvyPEDxQBak6/Z16QfktOGBu6ZZL7Sq8/M/B1ZnFL2FsTAozAH9TQrB42y9FGTxgVq/4f7+DG8S2Yw55oItje4I/XD6em4AQJfYhttGRLm+xi6UlgFhnUO3Ti5okDZxZT3LwUr+UiPRIldwubEjDNTi/BiSAJ/ERILdhLofw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nm47Gz0V; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJcY6aacvMXGAVAS9rPhm5z6EMatgqZfmFKJRcK12Q4TySfDqjWOi1xyxwxPLPyXRXS3+dl4sZoeJ7nLgIWzkCj6weKFUtQtGfV44rAS1Z/GncCrA4tmXlhm5r0ygB1PLkE1YsY1VocN3p2qEYpjRQi9oF8B4edwF95e5v4J26wllz3hr+IQrp6BSbX88pDoYrPwBZa8xPsebMYmltkR/YlH6dJYLrZUZtnLcQgoWek4Q16tCFtMPVVxQHpc7HJd0Y4J8StsJzqvbLmm8BGzQXJZZjKYtriC7lIxPvbwG0MuXqNiXoa+yoUDc503/Rsmr5rIpeXbvRctLzcoI7Uhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=S7umYSdDJmoAtKLOSsDycxDs5ll2u24fGGw/jmw3JyZBNFMayUqUjxOkOZNakWVLiwHmI4yLfEnagD/Ij8Nc1D+xewmjbxtwr3bXb/06wpPJ4luc8ZNF8WMhYvv4X1NvKkX2MKYWCXly7ug9GJsH9OFMdf9wSTmWRdpwxr13QleBn9BBtM5B4otwK2ClpGb2wGKSXCyXdN5CtfQi6rPHrlikvlC7OG+jHzm6rItjCR9Qz+qguzqHCA8x53R3Qb1Spi2IQGzrZO1tDJkGzLFNkqqLAeYhHy4HT6A44W2QnWElrYU+GUCK+mnd/VHTR20VksmVoAbS6lpuxeYwZd6URw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=Nm47Gz0VB0VlTvg4uCLUVsPMw9Xy+g0bh+yprZ7qWlx1Et0UXO+YWtrBBIXOllIFQbapUXhmUtcaQ6hAGtY+kXi8eroeuvZPoYG1+wNvt/bTQDqwUjGfCyuwu6UzwIVVNMGIUUNvr1WrAd81Z24ypHSvf4CdV2jDNpyMFAbhNrydbqbJz9dwVjpVWv9PItkWucGGDNoZfJGn6dkiLFgfcERir5jy59LHJpFLq2EkLzjtAlt/Jh2s/FdOttOjW2ZR+xxfiNn/niSnvu971iqIOBZ5LmY+DADYrxz+W3HDGPhSgUiKVrI6/oMhquFP03kkXhkUhrRbJ3DvQt7nl/O53w==
Received: from PH7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:510:339::23)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 20:07:56 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::f7) by PH7PR03CA0023.outlook.office365.com
 (2603:10b6:510:339::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 20:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 10/14] net/mlx5: Expose a function to clear a vport's parent
Date: Tue, 25 Nov 2025 22:06:09 +0200
Message-ID: <1764101173-1312171-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdf43d5-23f0-44e0-356b-08de2c5e52b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?slN8w9IOzcDeVAQZSqZGt0UIkbMjC2O8Y+I/uabpCQCdAKF6KA1cjZDiB0zu?=
 =?us-ascii?Q?OJpOHO4rVIfjawlRKjlneOxLdSncfWZPBQR2YU6zId8yEIkpLaL6xA2+v/04?=
 =?us-ascii?Q?YoWSe83VvpfkNg+Q7THphifL0h+HIE0v0R2PlXI2/nqSNNKmU8AExSKUde0K?=
 =?us-ascii?Q?OLgdP+ZDlJuCjZgB837VqKoNvNMskZ41xUoNLQSIad7OKeF5yTTY6yZjGM4P?=
 =?us-ascii?Q?3od8XMno9dU6MNMdu5wl083mzxKpGeDo+Wh9el+1Z4eR9Xg47LQAWvCOdh4X?=
 =?us-ascii?Q?LnsGug0QWt+4cSENmnoxeGwFVMI8IVi0Z4FFTM2XG7UvQCZn6WGa8tlUqrt8?=
 =?us-ascii?Q?OD1JH1RNUCvkPrcC/fsTfnchAFCryehDXQ7YmSNkbe2TzB2ovww3snt4vjqY?=
 =?us-ascii?Q?FjnsggT541yplRi4igoqv0G8QFWQcJzQ6zeYs1Zr+IKEihgg4ZfDri/coho3?=
 =?us-ascii?Q?F99CFVFLfGYN5fkrE3BOH/Yud077Jdc3NolojIsReYRFeKdOxCNa1GGrEtzU?=
 =?us-ascii?Q?z7RYH7+f0ScvF2w2j+GC4DapDTWxk0u/x1X4Y2vvHdaG0rIRG8DELDWUWQhe?=
 =?us-ascii?Q?kZiriQ6FYKFRRzLidIPFCvPfbU0bXTX/KnIxeoz2doVKrAH2fhvVKwvBoRc8?=
 =?us-ascii?Q?swxdcR/98QBpxt8hV4hfYNtBsn5NBHT8uauDzI3nmswAqDl0BEQhqDygHVbu?=
 =?us-ascii?Q?Bb8RUJgExSWzkIwek+1p88eWwC8RG+6NOAotkkrynbcj+g9KXvxtuODH1EId?=
 =?us-ascii?Q?6B5cJZ+AhGtmfeVaxMzNjNQK0tl++yXrc8LvAy/j+7PXdXOkv+znwtych+4y?=
 =?us-ascii?Q?IHulNBVjkuAu2TU5VBMvqGdZt9r1IaBK58AtXea1sQ3WoOq6aMzraJmtgQH+?=
 =?us-ascii?Q?tLBn2ZqYvdDwbVpEbp2rnQLxqiguiAUD+KuEolJDcfW4xdp1CL7jtfVXWtp+?=
 =?us-ascii?Q?nZMN7IuW3FPRnAQ2vYl92nP+0QaKen+1xn+3gAQThoB768/aSNl2eaH7gqVI?=
 =?us-ascii?Q?q9uuvJ/VmVDjj3oXOTb6KaPh8ssyfrmAJriq6oSHUlqaN8qx2Y6Ji03u0aoZ?=
 =?us-ascii?Q?TrENICRwQyEgvtJEhchKG0L9Xgox2HJZPwMypH9dF06+HmOoCvAqBms2Vd80?=
 =?us-ascii?Q?ck9bOwtqLmJe0p7OQQ+L8+8ptQpet6p4B44/+Hn875bpTqK9j6ugf3WZPYMw?=
 =?us-ascii?Q?0ZQmrp41HOlTIxmZtZrC0veS6XxEpxc5Wbd/gFKPjuWTQtXjBOou0m4aPEeR?=
 =?us-ascii?Q?p5HnTShT8iGgPj5D1PG3JOV9cWCmua4GoXyB8r85X4WYbhZHFCHilhPEgd11?=
 =?us-ascii?Q?kW7DAWf1ukI0ueYjK/CY9wMJ99V4rTQgA5th8YV7Fj9ia/te4RYNFNjGZKO5?=
 =?us-ascii?Q?aN1zsNwGOCJlr7Lzk3GCElVLOcgLmElvXrZV3XIHSq5C2cPaKX7mbAhtvxpg?=
 =?us-ascii?Q?IPpdipDYbnV3ahw/+RWMVipHH3Hli1gOwYwKVIwJ6ltGxu30YyX6uRV/jaUg?=
 =?us-ascii?Q?5VRoY7T15WgJyhHBoXCWMLyCQeKrvT8kqYi/KZX+ENYfaixLHyrh6/3JtrHH?=
 =?us-ascii?Q?EdqYoWsl1w+p+fzeckw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:55.8148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdf43d5-23f0-44e0-356b-08de2c5e52b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, clearing a vport's parent happens with a call that looks like
this:
	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);

Change that to something nicer that looks like this:
	mlx5_esw_qos_vport_clear_parent(vport);

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c     | 11 +++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h     |  3 +--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 89a58dee50b3..31704ea9cdb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -202,7 +202,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	mlx5_esw_qos_vport_clear_parent(vport);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4278bcb04c72..8c3a026b8db4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1896,8 +1896,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int
+mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
+				 struct mlx5_esw_sched_node *parent,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
@@ -1922,6 +1924,11 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	return err;
 }
 
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
+{
+	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+}
+
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  struct devlink_rate *parent,
 					  void *priv, void *parent_priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..20cf9dd542a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -452,8 +452,7 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack);
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.31.1


