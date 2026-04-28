Return-Path: <linux-rdma+bounces-19627-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDYlJhNG8GlYRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19627-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:30:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC847D9B8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE5D73011C87
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23183326D75;
	Tue, 28 Apr 2026 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GEQ1MCrj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3231D371;
	Tue, 28 Apr 2026 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354232; cv=fail; b=a+kNvvkMiuigyKFH67hPQ2OcQb+5LcIDYJ97NvGcoO4Ds267f7bgvvxNS+pjX25HygKQVkynK6gXr8mrFF0OxtIojD4oHPwBIrxCR2lUOBgTeF3B/XMKZc6o4eClu0uIcQVr7e6+BYAMtHHWXR978cphWKlWfu98TWR0eU0jKk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354232; c=relaxed/simple;
	bh=xykN7VdBNgXIocXAUJRCSIui6dZn9tJPZ45DhmVURdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbnuGWZ24RkFGi954pE6X6udYgl3vfgaRFAIAYkDuBUv5gPgBSDxJtGCEVPt12901d7lEMO0EpmStZ9nCezT3VFVJ2+Rrx3lxcgXj6Q4MoS98+jYdQXORCb0Rua2+6L08h2kxvjUYHvWcRVMFfMlVMPgmkeLRY6V/nekqOlxyYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GEQ1MCrj; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K09U/fVooE21rsyMvr5WXOc3AzEFc6gph1yVYNlMn+tBh9Sb6EbyG1dWbQ637sueVaGdKQy+JvjKHZ16jU7YBJe8PeRGRq797or6flpLrf6vTVidY0nthI5FgliDkTn8j3om3QO4FY8tt2uvWS4jzWAxikz4MmwGXBrh1zOPR0JxVSaPZER8wkYhZkLqrWBfQ8Y6wXZkV80/3ZveCARxQbWNt2/gjcXGcd7a8FstNrZA8dLGxQ0RYNNaVgEk0/58S3ZmoANM2tJtEKyF5tfc1MeQjr2twllb1SmUIof6GJVADS7+8M4Ur8j6illnQW5npPO/zr6vZt9CaYgv6VbWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAdT8yJR1+Npx1zVUpBI8rG2qD4lgDB8NCiCbgE06DM=;
 b=RXYxfMQ1wfM3JjrA9a1CCBITIcNIee0OXxHoCq5zTVDbxY0Khf21VTA64NcDvexQSqMMKLuRYsDNZAd56M9UG7rNO0D1kt+7YNkSbORrQ7x+FLVymuaEvddqLoF+gWbkxdZ1vRZW02IXyHHafVwQ1/52ydf2u8/ibAztYsMXx8aekR93fMzHvAb/OnShXawu6nIz4T2+zqF1dNZhFO+rxRFECg7c3lj09V/HGAkGIFnoZZL5QlCFX6gayaWODBC4iug+n9Y3I1g1REFtMswo2ofC/zGpr0DDL1vFSPx/wp24ruPl2GKAC/uSjIm98ex27rrA5A7DsS58uNImsEG0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAdT8yJR1+Npx1zVUpBI8rG2qD4lgDB8NCiCbgE06DM=;
 b=GEQ1MCrjGHxdVbTBnHKl1sC0UIGoRsKt3pdA9mhJsKNCSvCumRr6Kjn2TFtbnfaWWwzLmCy2dFgBDRHZMjJtI36WJeDx3U3z+tSY1Gx+hqpsV7qd7RwgNf85FVPc0Ktn3odsCZJNvFODP7HlXyVeyM6Dc6KUmSvUZ8lS80Avgu6jaljJJlVjgEmAUGEjItxTLwldUXpsXaQgGEnoIxa2lSfHL76yPRumEMjukMi2E6oT1C0mlwC0MnIKOtKhpr9eEFtz1xcxf/hmMioeywNLhEMjTwzddqMvt6UOtU5umEPs2vc9hXdoiRn2fdMUzOyqXqSgMm7xFOVpTmXF8GeuQA==
Received: from SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32) by
 DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Tue, 28 Apr 2026 05:30:26 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::e3) by SN6PR01CA0019.outlook.office365.com
 (2603:10b6:805:b6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:30:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:30:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: wire frag buf pools lifecycle hooks
Date: Tue, 28 Apr 2026 08:29:18 +0300
Message-ID: <20260428052920.219201-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428052920.219201-1-tariqt@nvidia.com>
References: <20260428052920.219201-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: e72a2a88-05bd-4e00-f91f-08dea4e73fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tQLwoK+Xsu2sSdcDu8MGeXq6zjLtG1U3+2KjhNkIher+YAhtvYnYRSXSULJS5E2WnLWzRggCD7pcjx9L7btp0iNr6RZNKe2sQdZXNOqozGyvhFNNOVVg04Gs+GxemhCUl3pUQt4IseUE8ycUQI7Tjvt86PXVkiShUEMYSzGVyy3W+wTV+VU+3JEgPkgg8VKDfmzi9xFFjKM6AGSNEUs4eBXL8cfPq8qKy5XAFj8IjehrOcTEFKmTkLNdyCojoUGfHALpfsgicI/UMCPJmIHZinAOH1LNwYqXgrXss6mtQcIyFJOMtnaMxQq8RGwL0swCc4CV5SWBez2agbi0Tw4fMnJEIXBKw4FCYEDlJBA3QnTPHy4PMNthmjUUehl35p2mY36/byCAcvGsObAWjCVqoj4Nj9ywQA9lD105raSQ86Zlv3bAbT7Jvb1CIdqM1EEZTEEtlP+QvG/jPAR6RYkJBw2NDP209UQ6AeQzDEFyOWtKGa4NWyCmqlmuvoJvXs0iE6ECM6mUDd6v4oZ4g+VXY13jT71SRAy/BtixvRCle5U9r1EET6zdRymqPYKsbrogOgVxoOKJk6U+VgTDwp7npt+XqvPP3Zjg/yxd652mOLn3yObKgLrOrEf7sFlRC4R78KsPKzU1rFPC6SoekLq8rOMg34LRX3lx/H9S8VWF1zm4Lma9s3exHPP9+/vjOu+uA4T9IgrqgxlUTOV508iaUG+jxcb2+ius3Ll2/Wm6D+acq6KVi1DK6KVm3SELRySk+N9rthUr1SrXk74627M1EQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OjB0DmdtPxb9uUIGgjfs6TVGM8vjm2lYzS5zqsIoDRnWLdXGEl8VjQDWyhn9bVR63+VX6sQgm+vN9qlYRyL6DldMVpb0clEzrMiioFd7OP6Qt9hrxyx9V2BxANYceijkr3RcHyt1k8wgViz5XOufebbIFtWVGIvJc2sWJuq+GWgbyNbGyIL7Sb8dLF2AAEBwBT9+pCp4Fm/S2arYKrWXmpIFl1EiLnqA7eyfSTWUvouv33jXf8FgY2LvFIUJiEImQCgPlhYZ3D20E5O0H9Fictdc7VPrDMFkhJHKeXHllKKGsAbgZhIlZnAmkOddARUwDc2FaYm+mRBhrr7ulS8xYYZNc3r6yX9kFiMYEi7rahF26QR9TgeprjT2GoWH/cuncLNsQQGN6wmolZyopB/5eiM0pB2i7gi4LMZgp9/s1FZzmKxRdXiUqwvi3LmOXFOe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:30:24.7384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72a2a88-05bd-4e00-f91f-08dea4e73fd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Rspamd-Queue-Id: 6EFC847D9B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19627-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Nimrod Oren <noren@nvidia.com>

Wire mlx5_frag_buf pools init/cleanup hooks into
mlx5_mdev_init()/uninit() and the init unwind path.

Keep temporary no-op stubs in alloc.c so lifecycle ordering is in place
before the coherent DMA sub-page allocator implementation is added in
follow-up patches.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c     | 11 +++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c      |  7 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index 202feab1558a..cebb3559d2c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -71,6 +71,17 @@ static void *mlx5_dma_zalloc_coherent_node(struct mlx5_core_dev *dev,
 	return cpu_handle;
 }
 
+/* Implemented later in the series */
+void mlx5_frag_buf_pools_cleanup(struct mlx5_core_dev *dev)
+{
+}
+
+/* Implemented later in the series */
+int mlx5_frag_buf_pools_init(struct mlx5_core_dev *dev)
+{
+	return 0;
+}
+
 int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 			     struct mlx5_frag_buf *buf, int node)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 74827e8ca125..b1b9ebfd3866 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1817,6 +1817,10 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	priv->dbg.dbg_root = debugfs_create_dir(dev_name(dev->device),
 						mlx5_debugfs_root);
 
+	err = mlx5_frag_buf_pools_init(dev);
+	if (err)
+		goto err_frag_buf_pools_init;
+
 	INIT_LIST_HEAD(&priv->traps);
 
 	err = mlx5_cmd_init(dev);
@@ -1878,6 +1882,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 err_timeout_init:
 	mlx5_cmd_cleanup(dev);
 err_cmd_init:
+	mlx5_frag_buf_pools_cleanup(dev);
+err_frag_buf_pools_init:
 	debugfs_remove(dev->priv.dbg.dbg_root);
 	mutex_destroy(&priv->pgdir_mutex);
 	mutex_destroy(&priv->alloc_mutex);
@@ -1902,6 +1908,7 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	mlx5_health_cleanup(dev);
 	mlx5_tout_cleanup(dev);
 	mlx5_cmd_cleanup(dev);
+	mlx5_frag_buf_pools_cleanup(dev);
 	debugfs_remove_recursive(dev->priv.dbg.dbg_root);
 	mutex_destroy(&priv->pgdir_mutex);
 	mutex_destroy(&priv->alloc_mutex);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 1507e881d962..87f01c4e8d65 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -436,6 +436,8 @@ mlx5_sf_coredev_to_adev(struct mlx5_core_dev *mdev)
 
 int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx);
 void mlx5_mdev_uninit(struct mlx5_core_dev *dev);
+int mlx5_frag_buf_pools_init(struct mlx5_core_dev *dev);
+void mlx5_frag_buf_pools_cleanup(struct mlx5_core_dev *dev);
 int mlx5_init_one(struct mlx5_core_dev *dev);
 int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev);
 void mlx5_uninit_one(struct mlx5_core_dev *dev);
-- 
2.44.0


