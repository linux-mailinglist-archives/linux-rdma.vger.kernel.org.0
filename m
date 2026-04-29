Return-Path: <linux-rdma+bounces-19745-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN3WMVln8mkBqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19745-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:17:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F449A09B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E2930674E7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15F390223;
	Wed, 29 Apr 2026 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpdYkpio"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510F38BF96;
	Wed, 29 Apr 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493755; cv=fail; b=PBjqyTGS47utLS8jeNRsITTQ/P2mg6D6WNpaWxr11E3udu4uu8tqHwfJq25HOJtAU1kqQ+Wgu7L/XgFHcPozvxMAmIOsn1FezJTk/1m20HUEqm8WRB4DzLlhJ3O40cx9LIedcTJS0OQ6iNd0b3zcDB2tcwVfgdnUgvkzO8q6zg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493755; c=relaxed/simple;
	bh=xykN7VdBNgXIocXAUJRCSIui6dZn9tJPZ45DhmVURdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUe/2SPH2r5ZXb8a2G8BgE1MC34KbSvK++yE49DXIo/d23BLGl33EmAZZsekZ+q5y5IKXBvN6g0m9ytvYGW8qy8D5r9gOGJuJcLtC0gAlzxU0nD6WqA6AuHis4bU0sV9N5gmOgygDACy7EwWqHeCjgO4i6oPrcF/LmSenSC6J08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpdYkpio; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQKGBO+4ghv53XMEoszO2RgGLGB/vZH4AA2ABWOcyTJItiCuV04udT0k9swNfUHK0BxqRrRy2Z8wQiPN76A1CmVgHOeEmHQ9jjVsa8RPDD9zGnHMQILCgFJirEo4NVEjNcfuVcLBGVEiIkJFBkWww6NwhZm6pRQFvB8gDdwYQ06B6nZnLrX6gfHFGRdfgYKM48Lmwj0M3tuz5aezhjKJZa7z0pJrVnYoTxT59a6g+YG070DtWzmvK2pMjUO37oOHS8fRaNQ8IeLtaYhzrbuoQbboADSyA67zR0KcR4Qhoksk0/oY2wqK70sBpqo3PirjMewzXZ2s2n3RRbKHxfGj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAdT8yJR1+Npx1zVUpBI8rG2qD4lgDB8NCiCbgE06DM=;
 b=h4G9ig7mRKz/qxbdTsVZibvJ/HJZ1k7oixGO5TEHmYQ/J/99yfUiiwpfSmK+Jn/x/A/jERl2WSgGuR12dc0f1bG6oIgOMwnmUPFYBPnOPVmNQKpaBIV+pt2bR9qxK4eZd950NKSoQ7xSk9sj1o/CJ3b/oPdwI4lLi+lq+dF/d8EqRgERQKRRvkrECRjUMybbtZsa6Q8DclUrDeSxpjFK9UCKpwaqkJZQQWyNHvaQ9Bc8c3TmlAumJhqGyZ1/RH9z1vMm4MH42Hau5nF4RBrJP7z0C2/TcLlEu59nfsSIXQmcBTjfPdeI6NiD+nThqL4Z3KzOrTEBZt9iG7UDpK7yUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAdT8yJR1+Npx1zVUpBI8rG2qD4lgDB8NCiCbgE06DM=;
 b=tpdYkpioUYw/nf+SIou8dfdxjSbaE2dmQ/eb+CT0ypCLw/WQrDC0hc97uSqY7Ou7srHXZ2rRmqhnK70pTjo9q22jRcIkcwUON2VMs+uCzsDux8uuF9koAQ5g4HhPSzcbdFaApDF1YJjIHmjrOGxg1pvC3hY+kOtGJVDRQ+F/Z3Q5Ofsp4f9b3jUEEuiwsbnnFe3oAT2S70Y78BnhKXgms9LIDApmn2vE8ehLms8oUTGz/p/VYc7oFN5TuIF4CeX5jMGbEzzKU4gqJpWckXTy5TO5kYRQzkC0ZL2Y7z2oK1hlSXxVYX1Luix/jbdcufAYX7V8KUlvHC2Py0TyyBphmQ==
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 20:15:44 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::8a) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 20:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 20:15:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 13:15:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 13:15:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 13:15:23 -0700
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
Subject: [PATCH net-next V2 1/3] net/mlx5: wire frag buf pools lifecycle hooks
Date: Wed, 29 Apr 2026 23:14:27 +0300
Message-ID: <20260429201429.223809-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260429201429.223809-1-tariqt@nvidia.com>
References: <20260429201429.223809-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b8f554-0e43-494b-2196-08dea62c17d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dxECXSHkRu7+1GxNbznwoK/dxgLmnVDC9GmKCCeF5XVqmqUbumTuPVXm3RRskQddQssMSYEVPUp22rz58L9IsPLxTuVCm79kaLJ4WGGw20LOh7/IBc/3hDurEKLFtLz4MDcZXeZCp08kFoLMTE/upv1U9TEja29/CFCBBj26hoOHvz4YGHisxvMIifPSLqnlGPzF6fggAvrnyFCOWPkFlX+L8w0uZuy+CdYT/aRBA5ZGgapfNrtGzaa8eBa23/5KBv1AMJenm7SZP10MqPay/uTkNlq/yFwh8/mmfg1HSg5tZR0fnpfRFC6vJXVovHLorOekH6bRW7DE+9bBamyb63aBIeJ2a/eLSwobCxZGo99VsuHtYJWhcvGU1dPO0R+5vhkb6R8nxbQVq0bLLmIs6T7SjyvYO/IErn2E5jRpYfXI++W+s9hrF9a8/kfODv6ba653TQZBMIFbii+mM1LFIj28HNFs0evFW/6aM0Vd3k+XVnjuoj50wWd9LRj1W0nAoNlwVR9aS97nd8kwy0qUwxCWKOIhIryknWxmBoY3kD4VcbRGfuWDEekw7KHqgiRQ7H8ST233wFmm3aIU3uoE4QHUhQUG6G81/RJHnMaHAw20CbfCWzF4sFdcqrHWm4IJDhzLIPPfzkcyTOFX6veBGEVVyyvdv+75DnYV0O40AeySkkysmqBfwTaZRVaeqRgw4I6/kL3kAlDdw2oOTJFg/lZpniCzBwdwXodWIAB9Tvd5oez/8gwMfXf5mFKcDXtfp0YW5n0ON49zr/UhAB72Vg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0W7KKieYvfajsj2HcWMGd0g/tfCo4CvfFymMAJRilUUBufRkFfW1NeMJ25RfEPc3hObGSE62dGN9tY1r3lCRCLaDPtxi5K6CBl3fco9mZ/7NLciESNFJi3dpDK8Y1U5mH086izVhEI92n3h3KXHxDNxnrEEFczH3WFbj285zSv6pdtC3nDzFiWE7dybJ7B2V08J3XkwtU17Iht4bQ8m3UtDCW5bfHSZYQHicwo/gbflQWEjO0cSVBukfvTL9vM7Pa+TdV+MhhbgHuttAJvMSvyaL+7lCJGBz4OZrxRJVLjnczhyiEINfUzI6wXrjYSLAJls5GYl53UhxpqhYFSF94Rnlrd2MbqsOiupg9CiXk7J8QLjD6krsEJfqU2x8YFPfx0guAQl94Nvss/ZAgnWW118QJLplJlwttUdUpjwFUR5Hs2DZuc01f5JTuEfz07Fj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 20:15:43.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b8f554-0e43-494b-2196-08dea62c17d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548
X-Rspamd-Queue-Id: 5E1F449A09B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19745-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


