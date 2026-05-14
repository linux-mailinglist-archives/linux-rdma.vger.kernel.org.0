Return-Path: <linux-rdma+bounces-20682-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMojC/OoBWrtZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20682-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:50:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C6D540987
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D35F8301573A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D83B0AE1;
	Thu, 14 May 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ky/6UWlv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611D3ACEFF;
	Thu, 14 May 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755821; cv=fail; b=AMjcyDNwa5zorVSjeeOzzOl2xyGPcxKrgrFd3ZqVfQD8TqvegmJtfou4i/FQ+Mrg/C3LxsSL1oNYmGPcLD2HbT4gJecZRSKUCPFJANhnTAn/w5RTjT78njyrHq/dGo3wW+g8IJdAtJ1a6Wxe07Dpgy4P8pkeS81r/rsKwoKVt+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755821; c=relaxed/simple;
	bh=z0NBJLTZASfwVqffgXEhLV5b2FaHSc94NHpb0wXRpO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOuXYeM/BYq3xWicDyyQC2rHIBVzYTmQR1VLZs8BtfMEOcegVuDLYWPjLiZghcwHwFK3rErD6tv5F7odcQDIW7Vdg5t46mpeSPOvu60+im+mMjx7wtfZI/3tIMotzfuISmtVM9bC7Ud7K1AF5bIf49cDLq0dBQDXpPEewtdAFAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ky/6UWlv; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hr/zcawj08kiLmM8AjMRClQu2pq0jd6WlZnVJz89WZtt2WmRNdg4LVdF35B7Y9wASC2MCTGtJEyLhxGOW/+MscAo4c9njXjYL97bCoJVU4YN+mHIwMSNYhLFxcnTPf5TrpqVk2ZQQQ/LhRo3mYk7l1EM28uGoJh/j+KksJ7A9eYs81QnQUTWm/qK8ndkD5Wqdq4+ViTpgx8E+n7Jwf3cXPz2wh2xkcfNuZUJ4F5e3C5uaFN5gtYaJI8xe82wHjYtgoLH34el28p5QfbWJ8TQA8wV7SLznDx6Kpvhc1+nXXCfnAVUouc1bvxEFAgsTI5WdYOw9mYzh6G85uIpsFgF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhozOqRqFmtX7b4nTFMQDUEBIDvz91xDEgMn/fveeEo=;
 b=fYJDDZmaYoBp+WkedkhSpqBd/2HZeKdOX9hS6IV8ErqaRc6NPOFOkERKcRbIr5MZKa+EVXUbUJoSdBkzE0d9ciN2SCtHot5FcrVeYNrvJOz2JLJVtNRgiIqlFMSUQrnSGB1heelFhTNmBKt4BTFmjiYO4xYvyL6OSi205ooMDNhukboYRexCrEERsLvcdkp//0sjG/gAfU0i3c6+5s959VWFWGO3McnXeppacixUv4nMHJ4MtF4Xcw6is8U8DJNiSyN2oyQiUaoTIPovajhMugBblhzKH9LDdC+yC1HHPQBdAsnDd0v4zqQHoH7olf5851eYcYFiq/y24PSVN7jx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhozOqRqFmtX7b4nTFMQDUEBIDvz91xDEgMn/fveeEo=;
 b=ky/6UWlvzwQaf0c1I9GgJ+przaUORQ5kLQ1G35ixiYbPaXDJmQZ4ic5sPVxVTH+U1FDS7CKs0MphWJORmc7m+u9ziaAearEK6cP96c6Mg7Wg7Cpd+WtWF21GrVMW2yG26TksPUdrqWln0gR2PPA3udF8iJlIQiWAYMnKdBeVIVWx2FjE80yy5+kMrSsSKDxrIVOud3C9f/Zi6vpxhMnxzQ/B/VRG3kVK2lYJAy1IcWi0P0SCR6gHM2iBCgjDsHG3gL23sN4wMGUclTuDaVDFSPrIL57Ra2f9iO8qBRUfMQn66uv93Z+gyGkny+6ucvJ/SH1z8eMU/zClOutuPU3iSw==
Received: from DM6PR10CA0005.namprd10.prod.outlook.com (2603:10b6:5:60::18) by
 MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.18; Thu, 14 May 2026 10:50:07 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::4f) by DM6PR10CA0005.outlook.office365.com
 (2603:10b6:5:60::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 10:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:50:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 03:49:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 03:49:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 14
 May 2026 03:49:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5: add debugfs stats for frag buf dma pools
Date: Thu, 14 May 2026 13:49:25 +0300
Message-ID: <20260514104925.337570-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260514104925.337570-1-tariqt@nvidia.com>
References: <20260514104925.337570-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bd3da1-8802-4947-5696-08deb1a68f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P9wE6xW4Imlkvh1kVBGTtrW0F2CB6ZU/K0YPsf5pRliT7fGJwaOwMTa6e8wslU/k1SdiRSR5P3DzhGKNTQ1FPWqbucO/rBNsybCpH8Ssi75GcnebeOWz6HZv07MVT8xCKuegyzOOA/n7jfGySi/xatJDLl6KzE2g02sZZIJtHb/8fgM57my3wSE6lKoSCKdA7xbD1jisEmZAlB7QTudTctcGQuCZqhch7p/b4kt54/k5fYtICHcdXXpTUwJcDlKZpdTcdzQd5T1JHToio/5BYQFt9hwMfdq4GA9FnM72zDLINj2g9ZU3bQU9O/hP7HsyRmHFnZlqPt1l/VIuvwC9VpmPLVOF9yMMBcEA33VOqpS+6hkZ+wQBzDHsSz45LT9LkSm16iVsxb4dFlS9fKAvP363VJeXoMISvahrvaDLPejZRAwO9Cl+cNQ114Us9Ol3sBtIlGAufOVCRMWNTvJGCSFOVY4YlNf5Xte649rNOKlQpfc/ACn4HEYvRvDWxilJ+udNkzm/UuZ+wXaBztoEi1abAu7roHB4Eevif0aY37CN4iBMENeA0PlYbYpQIl45suDZwOj7Ws+w+DZqHFEpu9/JoDV8Mmn2QmRTHcHZozoMuF0sCNfbXdS3hjg5+hsCv/JUtRtxuqDHSIe96EiAe2v/9KdFO0OY12PIpFglBD7rCGL8n8vNLeV34aeEBkAl/cPljdrMt3mWZpGE/Io7wdhcCqmmcdWRhSHIyqp9Il8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ilXrTKz3fH+jEaoSdqwqSCt34e/+spRzRU4q9JbtOPjJxAXZRLmFjxc2AS8zasD7QQonuwDT2FURffwb+xi16h1g6iXVW9LHYiIuawkP5L7KUnFVkEtsaVFNUi5Zup+rWI4Q7kwk4psHEiaiAR1sgoz2iHLP33DTv/ck1JPN59GBgqEWH+KCrTTJ12o/akplp6Jby2//Ej9gFplDAUgBKyoLWn66UEFNItrAFLtxk6NRTRlQByJ8Dc/+yQU5nxSsm3Ogi+OjXbiiloRIKRlgo28Kbh7XPwt4/bHROLTHz715SvzmePJIhQMSQYMZbWNwlNhatI7rJysOKdyCEsJV8sUfL8mPgJIw4NKrQUqEfJKTLihsTSkTZMP6nZ47hRPox8iUpadmg1frytG0PRW79ZTESOu37TGSlJsmmMlKACwGG1EhxhZuM9kYCNiWeUS6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:50:06.4150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bd3da1-8802-4947-5696-08deb1a68f9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-Rspamd-Queue-Id: B2C6D540987
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20682-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Nimrod Oren <noren@nvidia.com>

Add a debugfs file exposing per-node DMA pool usage for mlx5_frag_buf
allocations.

  # cat /sys/kernel/debug/mlx5/<dev>/frag_buf_dma_pools
  node  block_size  used_blocks  allocated_blocks
     0        4096            0                 0
     0        8192            0                 0
     0       16384            0                 0
     0       32768            0                 0
     0       65536            0                 0
     1        4096            0                 0
     1        8192            0                 0
     1       16384            0                 0
     1       32768            0                 0
     1       65536            0                 0

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 86 +++++++++++++++++++
 include/linux/mlx5/driver.h                   |  1 +
 2 files changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index 16d6b126a486..4fe9d7d4f143 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -38,6 +38,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
 #include <linux/nodemask.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include <linux/mlx5/driver.h>
 
 #include "mlx5_core.h"
@@ -74,6 +76,13 @@ struct mlx5_frag_buf_node_pools {
 	struct mlx5_dma_pool *pools[MLX5_FRAG_BUF_POOLS_NUM];
 };
 
+struct mlx5_dma_pool_stats {
+	int node;
+	size_t block_size;
+	size_t used_blocks;
+	size_t allocated_blocks;
+};
+
 /* Handling for queue buffers -- we allocate a bunch of memory and
  * register it in a memory region at HCA virtual address 0.
  */
@@ -225,6 +234,43 @@ static void mlx5_dma_pool_free(struct mlx5_dma_pool *pool,
 	mutex_unlock(&pool->lock);
 }
 
+static void mlx5_dma_pool_debugfs_get_stats(struct mlx5_dma_pool *pool,
+					    struct mlx5_dma_pool_stats *stats)
+{
+	int blocks_per_page = BIT(PAGE_SHIFT - pool->block_shift);
+	struct mlx5_dma_pool_page *page;
+	size_t free_blocks = 0;
+	size_t pages = 0;
+
+	mutex_lock(&pool->lock);
+	list_for_each_entry(page, &pool->page_list, pool_link) {
+		pages++;
+		free_blocks += bitmap_weight(page->bitmap, blocks_per_page);
+	}
+	mutex_unlock(&pool->lock);
+
+	stats->node = pool->node;
+	stats->block_size = BIT(pool->block_shift);
+	stats->allocated_blocks = pages * blocks_per_page;
+	stats->used_blocks = stats->allocated_blocks - free_blocks;
+}
+
+static void mlx5_dma_pool_debugfs_stats_print(struct seq_file *file,
+					      struct mlx5_dma_pool *pool)
+{
+	struct mlx5_dma_pool_stats stats = {};
+
+	mlx5_dma_pool_debugfs_get_stats(pool, &stats);
+	seq_printf(file, "%4d       %5zu      %7zu           %7zu\n",
+		   stats.node, stats.block_size, stats.used_blocks,
+		   stats.allocated_blocks);
+}
+
+static void mlx5_dma_pools_debugfs_print_header(struct seq_file *file)
+{
+	seq_puts(file, "node  block_size  used_blocks  allocated_blocks\n");
+}
+
 static void
 mlx5_frag_buf_node_pools_destroy(struct mlx5_frag_buf_node_pools *node_pools)
 {
@@ -257,11 +303,46 @@ mlx5_frag_buf_node_pools_create(struct mlx5_core_dev *dev, int node)
 	return node_pools;
 }
 
+static int
+mlx5_frag_buf_dma_pools_debugfs_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_core_dev *dev = file->private;
+	int node;
+
+	mlx5_dma_pools_debugfs_print_header(file);
+
+	if (!dev->priv.frag_buf_node_pools)
+		return 0;
+
+	for_each_node_state(node, N_POSSIBLE) {
+		struct mlx5_frag_buf_node_pools *node_pools;
+
+		node_pools = dev->priv.frag_buf_node_pools[node];
+		if (!node_pools)
+			continue;
+
+		for (int i = 0; i < MLX5_FRAG_BUF_POOLS_NUM; i++) {
+			struct mlx5_dma_pool *pool = node_pools->pools[i];
+
+			if (!pool)
+				continue;
+
+			mlx5_dma_pool_debugfs_stats_print(file, pool);
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(mlx5_frag_buf_dma_pools_debugfs);
+
 void mlx5_frag_buf_pools_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_priv *priv = &dev->priv;
 	int node;
 
+	debugfs_remove(priv->dbg.frag_buf_dma_pools_debugfs);
+	priv->dbg.frag_buf_dma_pools_debugfs = NULL;
+
 	for_each_node_state(node, N_POSSIBLE) {
 		struct mlx5_frag_buf_node_pools *node_pools;
 
@@ -296,6 +377,11 @@ int mlx5_frag_buf_pools_init(struct mlx5_core_dev *dev)
 		priv->frag_buf_node_pools[node] = node_pools;
 	}
 
+	priv->dbg.frag_buf_dma_pools_debugfs =
+		debugfs_create_file("frag_buf_dma_pools", 0444,
+				    priv->dbg.dbg_root, dev,
+				    &mlx5_frag_buf_dma_pools_debugfs_fops);
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8b4d384125d1..9a4bb25d8e0a 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -547,6 +547,7 @@ struct mlx5_debugfs_entries {
 	struct dentry *eq_debugfs;
 	struct dentry *cq_debugfs;
 	struct dentry *cmdif_debugfs;
+	struct dentry *frag_buf_dma_pools_debugfs;
 	struct dentry *pages_debugfs;
 	struct dentry *lag_debugfs;
 };
-- 
2.44.0


