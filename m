Return-Path: <linux-rdma+bounces-19832-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCa/G5Av9GlM/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19832-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:44:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0044AA60E
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900843036397
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D322D2FD69E;
	Fri,  1 May 2026 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k473HF2N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105662F6591;
	Fri,  1 May 2026 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610560; cv=fail; b=ldiKDcToNVVP2EwpRCXQcPQyK5MmtSvaErbK9XDiYs6WMm0mGbjljy8YssTbFBEKVKlrrzC/87THMW0zSgMdQeADOCgP1+tgLx3d1sPeKyaMJcUAV9lOFJa6s/odpvqSpEh83T4Sfj++yu06bYcoxexUklbWbcD5cnHPlhfJWnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610560; c=relaxed/simple;
	bh=K2/MIV7+tJh+CZBnb8pYkHHcDDIbavN7ZupkRXfFxYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGnccYiLmweBvBhlG/1A6cB1XCQC5gfAAiL6wuxd1CB0AAcUaiAjKy4duqU8iiZwDkvu5IFwMgJP/wa3uDQGCSbekb+TEDMWmTUMX471WWRomKB3ZTo3xcXnLQHgT7TytlSwbLF+yG9FJ7bzp+DgFy0YR6HgdlQTTfmzNk27x9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k473HF2N; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGDehPNvs8GGlKMLMLeQFu98jcJeAs3dW6OmLEMICCRPy4Z7iZGqN1wlHkGimgBvM5zVymk6VAFXiu6oCbmE3/lYf9IQt0VbZ+f3A0uyM6UH7cxSt+usdf+8xKZhquAL63zU5jTbdQF7yjFrYwyOirU/dUcsLiAB174RjWf7pYB0ad9wwTlNL0LkVie2mgasAp8RJSl9EpR2D6kRbGMcZEKgGo7qAPDMojRqahqyYO4bW8pbLy1zs1lIiIDICDXcb95dARjZ+6OEsFMYPA45WQvAvZlOGMXG+kiYF/k+UqXsqHrXs5ctB2/tBCSxmhdCGa3kz9Bjct9LaFa/cAV4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2EZ5NYUoKQT3I16W3+5ooLJ8PUS/E3jaZnYCanYk2c=;
 b=dyCx3J4lwZX5AAI43NMhi4sFvGfT279U8KqDCqo4xo8iT3wp4EKJCwiZ78n4pb9HIaK3o86WjQoqvqoE81U0bREZ2dw5qZJeKCR9RXGzfLVISzc9ivr5Z2kyzV2i0/6b0CP2sdl0kWujQSjIEm815j7mfImVNpoCYF3tXHq5sV/aX0jFHwr8mS49fpQH1TqVNniArsPIa/8jMZA6IS765ANG3ms4iyAMswMbbB/Msva0MTxYDtdd4KXTtJtObfJSxy7DMJJS1BwN+2Ks1cgt4orUS4lqiwoIht1LQFKSaS21BAUcCCSzbRIJt1FJNgfJrzEE12JXZLLxbC8ncPCYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2EZ5NYUoKQT3I16W3+5ooLJ8PUS/E3jaZnYCanYk2c=;
 b=k473HF2NJDXJu3/g2sBLg0oy0jrd5/KqApEs0pqe4nrFs+PJdxzqzdGle2Vd+4klYODwpfH8emU13mgWabsaagwOaiyEM88+Pz8zMxK6Uec8W/qXOKLRKFuaYWqg5aP6BQIKitAb6EPgjM3nc41mqogCRXTvd4iKiv4Q0HnQr584disbHNBwyhZENMFbef/OX5CZsQDwzkswuNuK4jISBieSWxxf9s0mq8QwDfyhELrHevrFurf3X1BTF2LeiAM9rz8SIxRbsZeic6tRKJydyZHtBryvVBGGSbtS7D4Y2W5Ih3VIcrFeuMy7R4jlNi5cBbWu3YQcS03klK+f37rfIQ==
Received: from PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::26)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Fri, 1 May
 2026 04:42:32 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH1PEPF000132E6.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:42:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:42:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: Make debugfs page counters by function type dynamic
Date: Fri, 1 May 2026 07:41:55 +0300
Message-ID: <20260501044156.260875-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501044156.260875-1-tariqt@nvidia.com>
References: <20260501044156.260875-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY1PR12MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c30a58-f046-47c4-f80a-08dea73c0ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RiBx9tagm+iJjy3OK11sZgaYJZDKbO0jVJxmcQAsnP4BVG/kisLqmmYiJwpMp7AmVPYf62DaN78F4XuHx67odIrDgcvC3cKD6SAIR/mWX5r2GOYc6qxMGbpiM6iE2Dni9H7R+22XUc4+IFFggksRrAkZHQ3EnDxwf4a1Qni3UGrtMe67vyOgUfjEo2JIPYynSj5Afw6b9fPlsJhlnvNX+8njjLofjajBOZC1sozXGzAq3LAXZ152N8Vvwx3GyzoVW5yT1Zx9ln81lnOdbZkkBWfSY2YFiIB+uKPhhjXHDqCqVODM3xPt05f77h06Nxjh3MYNQMSS8/bnovS8yRlbOSTWyiiHFHWPmPEXR/SIqMtLbR+7EQSTWZwuG8+K9HcEY8zaBmZu54fX78R68+BMFZcF4mGWUV2HGk9YYp7HIkcFDwl9hvy7Teh44ivYUeeckhsX+Med215F8NHNN65SwHBEeSthSDwC5Y46ygMgyQkbtJPkIRbSsTwPMNpgJeQm0Bca07BZaW1a+BUz/RKt6A/TPqZAGwUcuTwTErGQjF0Z/xC96tlbyQMm2m8wliS3rRGTuMo5wLf4VSR0I6EkAU27GQHErFJTIxu7o0sYVvzZVDfnZVNGtGCnrXAHfGlNap/GC8qpJkKVFwoJXm2qh/qleDYT6zmBD70h2GDH7wr5ahsmcfXiAz/7KxfPWuRTWQlxC6/9irRT+2GJMBcFql+jMm+4RylxhDWN4cB6izQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SbhHGXla3SEGOgNR4FQ6xh/sDEXPpM9HGCtIWaA0ay1tS2hnIQcDEeMUPi+z0VOIvSOQ1Ycsl2ceyY8AvybN2DShZdMmRTS8NUxA/Xe3SyOJQrjAgD6uzfhAEiVFSxILS/opAPGzKWB/bghjmpqx8wZEqH5bAjlnsYPEp8UY6O0D7vU7bfESUWToU5xsThLxqYTp01ByRRhOEj4RWIiZHuosI+S0YkVLN8b4x8Xdkbp0wEjqOXQbzphpIlqvHWkCMMd0/tTI4AuyHLstG0iF4r2zOXboBWhcE4/SGxFqmKvLzFpzqjihvsQhaDfy4ZWogcZ+RgqaeIe1b/Umqev2AOxzhhonaFCulIXhVVck30wwClDJst+HArs26CqjICJhDO+mCtvW4uEsuBNSJuN7ZZuJE6wo3di+aCvaP11dMYy5ptqFrYaUzASB8O2I0rj9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:42:32.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c30a58-f046-47c4-f80a-08dea73c0ed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676
X-Rspamd-Queue-Id: BF0044AA60E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19832-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Make the per function type debugfs page counters dynamically added after
mlx5_eswitch_init(). When page management operates in vhca_id mode, only
the function acting as either eSwitch or vport manager can initialize
the eSwitch structure and translate the vhca_id to function type for the
functions to which it supplies pages. The next patch will add support
for page management in vhca_id mode.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 39 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++-
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 8fe263190d38..6347957fefcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -285,10 +285,6 @@ void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev)
 	pages = dev->priv.dbg.pages_debugfs;
 
 	debugfs_create_u32("fw_pages_total", 0400, pages, &dev->priv.fw_pages);
-	debugfs_create_u32("fw_pages_vfs", 0400, pages, &dev->priv.page_counters[MLX5_VF]);
-	debugfs_create_u32("fw_pages_ec_vfs", 0400, pages, &dev->priv.page_counters[MLX5_EC_VF]);
-	debugfs_create_u32("fw_pages_sfs", 0400, pages, &dev->priv.page_counters[MLX5_SF]);
-	debugfs_create_u32("fw_pages_host_pf", 0400, pages, &dev->priv.page_counters[MLX5_HOST_PF]);
 	debugfs_create_u32("fw_pages_alloc_failed", 0400, pages, &dev->priv.fw_pages_alloc_failed);
 	debugfs_create_u32("fw_pages_give_dropped", 0400, pages, &dev->priv.give_pages_dropped);
 	debugfs_create_u32("fw_pages_reclaim_discard", 0400, pages,
@@ -300,6 +296,41 @@ void mlx5_pages_debugfs_cleanup(struct mlx5_core_dev *dev)
 	debugfs_remove_recursive(dev->priv.dbg.pages_debugfs);
 }
 
+void mlx5_pages_by_func_type_debugfs_init(struct mlx5_core_dev *dev)
+{
+	struct dentry *pages = dev->priv.dbg.pages_debugfs;
+
+	if (!pages)
+		return;
+
+	if (!dev->priv.eswitch &&
+	    MLX5_CAP_GEN(dev, icm_mng_function_id_mode) ==
+	    MLX5_ID_MODE_FUNCTION_VHCA_ID)
+		return;
+
+	debugfs_create_u32("fw_pages_vfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_VF]);
+	debugfs_create_u32("fw_pages_ec_vfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_EC_VF]);
+	debugfs_create_u32("fw_pages_sfs", 0400, pages,
+			   &dev->priv.page_counters[MLX5_SF]);
+	debugfs_create_u32("fw_pages_host_pf", 0400, pages,
+			   &dev->priv.page_counters[MLX5_HOST_PF]);
+}
+
+void mlx5_pages_by_func_type_debugfs_cleanup(struct mlx5_core_dev *dev)
+{
+	struct dentry *pages = dev->priv.dbg.pages_debugfs;
+
+	if (!pages)
+		return;
+
+	debugfs_lookup_and_remove("fw_pages_vfs", pages);
+	debugfs_lookup_and_remove("fw_pages_ec_vfs", pages);
+	debugfs_lookup_and_remove("fw_pages_sfs", pages);
+	debugfs_lookup_and_remove("fw_pages_host_pf", pages);
+}
+
 static u64 qp_read_field(struct mlx5_core_dev *dev, struct mlx5_core_qp *qp,
 			 int index, int *is_str)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 74827e8ca125..a242053f3a58 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -987,11 +987,12 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 		mlx5_core_err(dev, "Failed to init eswitch %d\n", err);
 		goto err_sriov_cleanup;
 	}
+	mlx5_pages_by_func_type_debugfs_init(dev);
 
 	err = mlx5_fpga_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to init fpga device %d\n", err);
-		goto err_eswitch_cleanup;
+		goto err_page_debugfs_cleanup;
 	}
 
 	err = mlx5_vhca_event_init(dev);
@@ -1034,7 +1035,8 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	mlx5_vhca_event_cleanup(dev);
 err_fpga_cleanup:
 	mlx5_fpga_cleanup(dev);
-err_eswitch_cleanup:
+err_page_debugfs_cleanup:
+	mlx5_pages_by_func_type_debugfs_cleanup(dev);
 	mlx5_eswitch_cleanup(dev->priv.eswitch);
 err_sriov_cleanup:
 	mlx5_sriov_cleanup(dev);
@@ -1072,6 +1074,7 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_sf_hw_table_cleanup(dev);
 	mlx5_vhca_event_cleanup(dev);
 	mlx5_fpga_cleanup(dev);
+	mlx5_pages_by_func_type_debugfs_cleanup(dev);
 	mlx5_eswitch_cleanup(dev->priv.eswitch);
 	mlx5_sriov_cleanup(dev);
 	mlx5_mpfs_cleanup(dev);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..b460b3bae195 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1034,6 +1034,8 @@ void mlx5_pagealloc_start(struct mlx5_core_dev *dev);
 void mlx5_pagealloc_stop(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_cleanup(struct mlx5_core_dev *dev);
+void mlx5_pages_by_func_type_debugfs_init(struct mlx5_core_dev *dev);
+void mlx5_pages_by_func_type_debugfs_cleanup(struct mlx5_core_dev *dev);
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot);
 int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev);
 void mlx5_register_debugfs(void);
-- 
2.44.0


