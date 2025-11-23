Return-Path: <linux-rdma+bounces-14695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015DC7DD41
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53E9F354528
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAA2D4B40;
	Sun, 23 Nov 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j5r9L52E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F022298CCF;
	Sun, 23 Nov 2025 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882671; cv=fail; b=hQJuupy+1dkq4vnm7ZQ2vP2+wrj7ndmAs158fY3mYRC39OrJQYtHRVfFU8M2IkvpA7oHIbpxKIzbQhYIfAHB1/Nc/pNkh0zSJeRY00WfHkW9Ug/TVgI2VIPXMo4fySHP8R3+XxFMG89fmbU+vDbXEoQPNDoIMg+u6PwU7jCgUZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882671; c=relaxed/simple;
	bh=WXI4mPHSLY+tAy1zXP51/Q7vhoBiJyspgV9I95XoDtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWPB8XNdbgpryRcKo6RkiOtpe8zqESiQa3bWP9Sz0pCIz3M8Mn76MLmFK0h1HGvB3tCVwlV2wiofJJCdzKlKNjMhDmTccDB0+nOA7zwMXlXRBJ0IShMrG1rYqCFjeHWC6Um6yP2M9eXhe1FK96GQpGOIlmOd0nFr0Xl5KiSpIzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j5r9L52E; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk7eaBmCOzbSdYEhDTQq7ofzb0zdhsrYqDgjKHjbjIggCBU7EMTUO+kizsNlKVAEJuM0bnMXgaVmDvXBSmAKWF4nKQVc3steluUnI5+n85sXY9PSmM52YoM8itb6z9rWNL3V7NKy43Jw9veN8Bst/Rp6mqNk1Ffx1i5oqIqS3/QW5+9LyQtclqPdYUZWxRnhsWEODcgCGusFhI2HOq2SObz2bVDR1U8O04zaa2YEO+YMyjH5RBaeNmjbqSv9ipcvGd/czDPaEErdu7oOJwyiJkucEcUnbHRjBHl2XuZsyK0F+rF6pRGWK+13a2QlI8L0uZkLdEs5dOBhBYC3J0BP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=dJomSGuRNd+4XZ9IkQgwJ1TJyk2t/3HL7KrOGV+Pf+3P1LOrQodYgxtyNG8Z1xXTzTCvAZnaRKj9A/JolOTLdpbr2p4s83ettLrlReNgRepONoKVOeUAQlOSunEFxLfjwpaflKwvqAxfQnekjAl8wW9BUvr8e+gbJCC92D3om3I+MamFRwUgFudi9RgQYhakTIIfUWE6OpaHUcxICIy8Zn3F2blZrR+aH6YvtlaHUs5yb5C/wNBMkQSoFSEZqPcJoexwWtEz2UEZf9jDp7BUefJCPqf4n3ZF7iEYbWTgv9X/DQ7Ga7IZhjVicM/MWlUPsueGFflQ5ZNSiUUBWcdMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=j5r9L52ELYoys7uVOgxnuqIkRrStRMVgADwDwsYQIm3Xkms2OHAuKHovMhpz11FLpnPJI9pRnKNagqSXcfcPhJ3m3q/kYJmtefqxB0FJK4AreptpugnvEBSGhUGrPtxaFyAnhnQzJ+3vjb23XAVpS4WicqkuXcsofA2w419ayoOqYKQbbZZvyWAiOFpqpbOjSsaOQcWUgZIcrp0A92n7bQA8Canh2d2hdZDCvXqQ4upI1euNrXjNRdaaVWoZfFcJckMB9yKea/W+LCM5irY+LqgHZzJ24NPUPtOGHArmTiyUVW9RblLQ6rEm+xqgqNybQhRjyQEtFHe28EimZoJDwQ==
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sun, 23 Nov
 2025 07:24:24 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::2) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sun,
 23 Nov 2025 07:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:24:07 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 10/14] net/mlx5: Expose a function to clear a vport's parent
Date: Sun, 23 Nov 2025 09:22:56 +0200
Message-ID: <1763882580-1295213-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: e3add27b-7298-45f0-c6dd-08de2a61541f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPiVybYHHBuEOERgR+E+9YJdYfDEQMBesz417RuJS4OWisbG1uyVfGAzl4tE?=
 =?us-ascii?Q?wG45AktyUlJfvOrg6tOSUPrhNYADrKsfCG6OmKAX+dyv3CGue5bwjMnDTfJw?=
 =?us-ascii?Q?r07+sPY5FCJdfms2P1Ffv5W6TsbcO9oW9p9MV3FCcHKKXxVaQhBDtzTSRtZL?=
 =?us-ascii?Q?OzDJ/bGlEuNcQHk/4vszuEkdetPar6ga/Bh/aK8euPeQyn812FHVqF6fhZ0Z?=
 =?us-ascii?Q?kKN/H3Cz2ihyZeWQ6BWyHIeu9cACVBJ1XqLWpunbCCsgi/V8xw86lMNKEq5w?=
 =?us-ascii?Q?eGk+Nk698X27uKACesYD3PHJiCBb0bQs8CQfX6mP9c3YD/N+Rr+n/py5wjXb?=
 =?us-ascii?Q?aJstqYN7eanwGe3AjHK9rLA7ic0DauS7Ks3McbX7ocsuZ/3WaCY6iLWUf/tN?=
 =?us-ascii?Q?0vzGu3StweLv8RGHOc2qrhqPJjTpFmDURW/Ipbm3dXk78fQjyH8S6OX52AYG?=
 =?us-ascii?Q?ncLNR+0iHjCzWJ+gWU+LetZcHA4hToeFbFjKwLi6EGkkaOvMLobDa6Nm35p0?=
 =?us-ascii?Q?P+YZ0Tr1lJUfGvP+PzzUWrLogkTrKgHCAdNcZnK1EE+DXTIO3LyGdeb1nNL2?=
 =?us-ascii?Q?1qIQSDfmKlubypmHINhkQKgGWhd12g8eDUkqgQXMfmyrs5sbQsANmCjX1ccK?=
 =?us-ascii?Q?QvwA29yDE4vD1mhGLxvHp4d1X9A/qOu3EaY0JXcOjIFnCqdem8wpcAmSCMvm?=
 =?us-ascii?Q?YG5aZFbsrJB4KW2fLl7GEyNe6YI+wGJPCgYfLl3hKkYiufpsn1lE/tx5A32U?=
 =?us-ascii?Q?zPOmEUkGkQVDmS4Ny4vhK8LO2tgStSurWMIKDILQOZt+jYzSVsVW6V1egBuo?=
 =?us-ascii?Q?0Ic+wOgDyscBYrPKTqkNQV3L1oX/tthdszjR/BlRYrbflXfYgGNLQwdjPLSH?=
 =?us-ascii?Q?2st2mZV8gSh8lFygpGs9zB3IVfGnWasqNtlhI77tPMpvKawxZ3XVOp92oQDy?=
 =?us-ascii?Q?gg9MMEeRC5R9c32GXEcpuQNKFG/I40/FKBTbOkArlS029ocpRZgPxdV6oUmg?=
 =?us-ascii?Q?PTlCm/4o+HXug9EEdnYqzewkwlGJv90rzbEjcvcF4oGhWXiu1a+wuqoBcN+D?=
 =?us-ascii?Q?1oP4tcO0CSLrYQZ9Z8YpI5+04cXeaVj9ESv3bAFnlCZwsZ9Ts1EMKK18sTuC?=
 =?us-ascii?Q?M5g73e2xcH19FvW3aHae/Z15i7KC34OeKb5c6+SFaJd2OJNvfOPoxxU6CpRW?=
 =?us-ascii?Q?2gEaAkzNt6yuXSz8r7U5sM1xp68EwdvgyJkIo/Q5pcG0XoaLlIhig5dJD2xy?=
 =?us-ascii?Q?5OZJtjAXuY90yPsEvF0yjWJ2qhr0PZfBSwO50m3nEX/jLSngKYpshSUXnyUk?=
 =?us-ascii?Q?aOEFknxBMM51UiOKUMNS1z3vrvuTNm9wdKw0iuAbWFYYfE2VA+6SlQefwCfN?=
 =?us-ascii?Q?yM097YDi5m8Irwa7BFwIAHd69gt92Fr3kwrh/6WIU71c2jGeZVu4GpNXOz8B?=
 =?us-ascii?Q?L1OAcTVCxXKCEb0UaSdWY4k5kDBpTs4V8qppvefLeY07EKdMGo2Kty7YeCe7?=
 =?us-ascii?Q?lWLCxQMBQ231lWrC4bS0YKg/FYiZ3XjQrzdVsedCjHyiNEPQrJoarIiLs2Vy?=
 =?us-ascii?Q?v4vM1SCBp9QLz/kN1s4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:24.3452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3add27b-7298-45f0-c6dd-08de2a61541f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770

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


