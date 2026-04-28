Return-Path: <linux-rdma+bounces-19628-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB5AGy5G8GlYRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19628-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:31:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC247D9DE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 346C63017DAA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6C31D371;
	Tue, 28 Apr 2026 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TPYV4Qy2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC6341062;
	Tue, 28 Apr 2026 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354238; cv=fail; b=r6BsxxCC1Y0OXc5iK2Hf2taCUv4QQfMPH7x8kVSCOYoOgfL64SqTwHAYnB6+wjTrE6tyPUnC5UDBNgi+RV2XcFzIwfc8j8jUF4DhJ6YJFsjQCYelgjt+oetnE1d+49hKXt7Ur+wPqMHcHn1hw2u0v5CLQq/IqDglPoQ9dABkMhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354238; c=relaxed/simple;
	bh=Iyq+szSJED7k4p+w7rikAyjpfaUQxRWXfr+IicCBjoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwSiYYiQ1ej8ICmZfr5o6xrIZoici+RA76AMuZ+fII9IrmzEgt7fN9tT7DXnrk3UymFf5r2whdPcOc2XpO4TpUlr9FvpQRkyi363rzbz8ZFJSdZ077QBKvdN4jQMeiD+I2iZ4aJFaXhb1/m8ALuAI6FDd17n6rbLg2/0NKU/QWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TPYV4Qy2; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyPhs0RlfiQs+dPcq0Uda105fRENL3cIBDADKvKNgy/37J5ADziAEeNMsSaQM+HbZ9H7bpRzrbiASm7+9WZTrxiy47+Jl3XEuKLGEvL6buQacIlxS137xh524cSkaswtnsXeBJOnHwDksXgcezUAQF3MY7d1g/Xx4s2lGhbkWFXBWeXGBXOpiJU6oGqdn3K9UXeYUSw4IC4qGSIIxIBU1OVJD+QDHjZ8npOhrBbmj3tJUFsXeIOnS3U2RPLZDfXXIS4tevnrK4mEK2UWGr8cV1Mqlv8f3KEShqtkfOHDZtUfvuBoxbjp+N+8tdJ4nluGolIXyTS3a3ZWXLbVirJ4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CyD+fSxVnvNIdcCwmT+APnowtbJyIClsSUc/sz2qRc=;
 b=a8sfyL7X61mJEUqXqKYhMYm9QyFko7we+EAtibrTtD38434AltiquJDINS+9DvauwTYnXRrmg955WokC+DYzahH53U40wsYviyqaSkjLZDKfeFPlogB3oPHDcRwJ7skzV7UEflffPJb0ISK+CYO1aMWYm8hTnAkZpx0oCWWcY7r38/p+JGKVQopefo2E/CMBXHbSeTxB4dgz3OI7DAAgU2AeZoqer1k4WCkbiyaGh7EO9SLuRtHm/vYwNhlMTJU6ZP8SnTmQoHc+t7wl2JP6bOTJJ15+G3IXPGSnJScfEhrhvaPIXLWjdlm6c7wswkLsdfBRFqM0nu3pU7U4lnsiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CyD+fSxVnvNIdcCwmT+APnowtbJyIClsSUc/sz2qRc=;
 b=TPYV4Qy2qqDOJmwUEuRHqJVVdQL7rJAimlfBHG7rOwgjbaIDY5KjCSvjr0gEIZrxN+D9qqR5xFhV1jAhImarGaGffAlRevEVA0es21d6SNqtHWetgiG33xQIpgsWmigL0I1WYQ0Xmf0uqtYRy7nMsQYzCqTdvDvjWqCB/rlysr0L7bnF+MigrXJ3EDE7qtXZgLcAhiVC0HjicqIF3rDMHNDoQNwcM5/XRF7YcmWp896ZCqiS1TcHZpJpWOnic/n1Az7TtYJyVnShuvrU+RUsnkD82OHr8g7e8RDaHWXiNmB8hNxazdUR85YtF3QdcrqwQAfGpQwwfF0zukCt7ntAPw==
Received: from PH8P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::15)
 by CY3PR12MB9655.namprd12.prod.outlook.com (2603:10b6:930:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Tue, 28 Apr
 2026 05:30:30 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::c8) by PH8P220CA0040.outlook.office365.com
 (2603:10b6:510:2d9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:30:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:30:06 -0700
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
Subject: [PATCH net-next 2/3] net/mlx5: add frag buf pools create/destroy paths
Date: Tue, 28 Apr 2026 08:29:19 +0300
Message-ID: <20260428052920.219201-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|CY3PR12MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 481488a6-ceaf-491a-6780-08dea4e742e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AUswuXAM36gxX2tBf2xFwileE/uIdEVwLO0QaLhW2OJ3LAY087zEY3VVSpdGlSQwmi6/dsdbdNmBa3MOCgaCI+b8t4L9cb0b+Xv7zsifc06uibsD5ecs/h0up75HivE+dufRdqbwK3sU0uHv7RxCAPq9ZG1FBljfjdstWcOPyq5cA+jxtyVKAVkVfdX4XXeMdaPCbBqozmFT43BZCniC5jukwpejoPHSvFvni9AxaIZsnyLMEZeQQpQ1vn/ZYazojmGqPMBrxaYujFcyevwwsEMHiyRtaEuTdM4mjbPbDYHRwMLU8xlrtOFPnZGX81wYtf9YdLMOxbDc5SiTSRcpOvbSGUDmxaGTJ4nPr+mVzOpXYscFnGLDp7YmhnJtsjjICOkoVuc1/UtNVx74ft7gtLzfClwyuGkFEFagg20R/7bNPUhRzE9uyAfSOMHFx00xj2yPpmVbivkjzcmrX1P67FR6uewqYRstz7d1KfuqEO5T6hEfJnIM94mYhlXWXDyAn690nqWJkhOlvQBWgLmQhiI9ssiA6y+m0dhPfTZp5KjtKKcO2T1xkRC8DvyFzWek+D8vPVPuilCdJVE7HQ0Q/28PtzMxeZvlyuGz7bErNPP5uNXIDXAev8wqk6dNCFXUEZiy3Xb85yoAMMVTwfi6KzkWM9rqJ3UUmFG85CXe3HfHqMWnVqapsX2ky31YcXMYKaL4KYnyE3NWjKJJD1ttnRlVNveaEMa8jq1GX8/QFBiHP4A+C2In49R/epYDyt2zTLOW0Udi0yq0pRbBNOVJhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pOuyEAd6b3JtSJXKuk6MxOYkS96MWxihBflUmyY9jM9CeR+0MA+TEa3s6qalZqJEGn3C/bAf5AZBpQsZ4HxU7taEo4nx7fB1ZQydDMLzcvk2Fj6ne5WeCzmS23WqveGDBMqFPhoaM1zyhCf6h+0x65FKc9u8LXSefbCe26SajoZUFaM8vif3j6I24tkdsv52c9D+Zr3LLZrO0ILase/igtc/nP0gfl2ADIrY8bpZnwGLyeJM6DUKUUZJWtCMd3/G3gLhHU/vMalTkJSjP86ShUMgdcZaxNr5LLQfHBuX+9ceTGq6YrGe9XgMHNSDmDzlfTjjXxbs92BoO//FIb2x/jlDrG9KpWqKfqLaI9enaii+Z/HysU1qfBLhk6kFCSRXp9RnhCKMa+Fn/+5ttyFpALT0jaI+fy8WwcmiXpLikdLZRkeUaad1z+jDhJgMfl5b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:30:29.8247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481488a6-ceaf-491a-6780-08dea4e742e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9655
X-Rspamd-Queue-Id: 02DC247D9DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19628-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Nimrod Oren <noren@nvidia.com>

Introduce mlx5 DMA pool and pool-page data structures, and add the
creation and teardown paths.

Each NUMA node owns a set of mlx5_dma_pool instances, each one with a
different block size. The sizes are defined as all powers of two
starting from MLX5_ADAPTER_PAGE_SHIFT and up to PAGE_SHIFT. Since
mlx5_frag_bufs are used to back objects whose sizes are encoded relative
to MLX5_ADAPTER_PAGE_SHIFT, a smaller block_shift value cannot be used.
Requests larger than PAGE_SIZE continue to be handled as page-sized
fragments, as in the existing frag-buf allocation model.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 136 +++++++++++++++++-
 include/linux/mlx5/driver.h                   |   7 +-
 2 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index cebb3559d2c9..918cf027bcbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -37,10 +37,15 @@
 #include <linux/bitmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
+#include <linux/nodemask.h>
 #include <linux/mlx5/driver.h>
 
 #include "mlx5_core.h"
 
+#define MLX5_FRAG_BUF_POOL_MIN_BLOCK_SHIFT	MLX5_ADAPTER_PAGE_SHIFT
+#define MLX5_FRAG_BUF_POOLS_NUM \
+	(PAGE_SHIFT - MLX5_FRAG_BUF_POOL_MIN_BLOCK_SHIFT + 1)
+
 struct mlx5_db_pgdir {
 	struct list_head	list;
 	unsigned long	       *bitmap;
@@ -48,6 +53,27 @@ struct mlx5_db_pgdir {
 	dma_addr_t		db_dma;
 };
 
+struct mlx5_dma_pool {
+	/* Protects page_list and per-page allocation bitmaps. */
+	struct mutex lock;
+	struct list_head page_list;
+	struct mlx5_core_dev *dev;
+	int node;
+	u8 block_shift;
+};
+
+struct mlx5_dma_pool_page {
+	struct mlx5_dma_pool *pool;
+	struct list_head pool_link;
+	unsigned long *bitmap;
+	void *buf;
+	dma_addr_t dma;
+};
+
+struct mlx5_frag_buf_node_pools {
+	struct mlx5_dma_pool *pools[MLX5_FRAG_BUF_POOLS_NUM];
+};
+
 /* Handling for queue buffers -- we allocate a bunch of memory and
  * register it in a memory region at HCA virtual address 0.
  */
@@ -72,13 +98,121 @@ static void *mlx5_dma_zalloc_coherent_node(struct mlx5_core_dev *dev,
 }
 
 /* Implemented later in the series */
+static void mlx5_dma_pool_page_free(struct mlx5_core_dev *dev,
+				    struct mlx5_dma_pool_page *page)
+{
+}
+
+static void mlx5_dma_pool_destroy(struct mlx5_dma_pool *pool)
+{
+	struct list_head *page_list = &pool->page_list;
+	struct mlx5_dma_pool_page *page, *tmp;
+
+	if (WARN(!list_empty(page_list),
+		 "mlx5 dma pool destroy with non-empty pool: block_shift=%u\n",
+		 pool->block_shift))
+		list_for_each_entry_safe(page, tmp, page_list, pool_link) {
+			list_del(&page->pool_link);
+			mlx5_dma_pool_page_free(pool->dev, page);
+		}
+
+	mutex_destroy(&pool->lock);
+	kfree(pool);
+}
+
+static struct mlx5_dma_pool *mlx5_dma_pool_create(struct mlx5_core_dev *dev,
+						  int node, u8 block_shift)
+{
+	struct mlx5_dma_pool *pool;
+
+	if (WARN_ONCE(block_shift > PAGE_SHIFT,
+		      "mlx5 dma pool invalid block_shift: %u (max %d)\n",
+		      block_shift, PAGE_SHIFT))
+		return NULL;
+
+	pool = kzalloc_obj(*pool);
+	if (!pool)
+		return NULL;
+
+	INIT_LIST_HEAD(&pool->page_list);
+	mutex_init(&pool->lock);
+	pool->dev = dev;
+	pool->node = node;
+	pool->block_shift = block_shift;
+	return pool;
+}
+
+static void
+mlx5_frag_buf_node_pools_destroy(struct mlx5_frag_buf_node_pools *node_pools)
+{
+	for (int i = 0; i < MLX5_FRAG_BUF_POOLS_NUM; i++)
+		if (node_pools->pools[i])
+			mlx5_dma_pool_destroy(node_pools->pools[i]);
+	kfree(node_pools);
+}
+
+static struct mlx5_frag_buf_node_pools *
+mlx5_frag_buf_node_pools_create(struct mlx5_core_dev *dev, int node)
+{
+	struct mlx5_frag_buf_node_pools *node_pools;
+
+	node_pools = kzalloc_obj(*node_pools);
+	if (!node_pools)
+		return NULL;
+
+	for (int i = 0; i < MLX5_FRAG_BUF_POOLS_NUM; i++) {
+		u8 block_shift = MLX5_FRAG_BUF_POOL_MIN_BLOCK_SHIFT + i;
+
+		node_pools->pools[i] = mlx5_dma_pool_create(dev, node,
+							    block_shift);
+		if (!node_pools->pools[i]) {
+			mlx5_frag_buf_node_pools_destroy(node_pools);
+			return NULL;
+		}
+	}
+
+	return node_pools;
+}
+
 void mlx5_frag_buf_pools_cleanup(struct mlx5_core_dev *dev)
 {
+	struct mlx5_priv *priv = &dev->priv;
+	int node;
+
+	for_each_node_state(node, N_POSSIBLE) {
+		struct mlx5_frag_buf_node_pools *node_pools;
+
+		node_pools = priv->frag_buf_node_pools[node];
+		if (!node_pools)
+			continue;
+		mlx5_frag_buf_node_pools_destroy(node_pools);
+	}
+
+	kfree(priv->frag_buf_node_pools);
+	priv->frag_buf_node_pools = NULL;
 }
 
-/* Implemented later in the series */
 int mlx5_frag_buf_pools_init(struct mlx5_core_dev *dev)
 {
+	struct mlx5_priv *priv = &dev->priv;
+	int node;
+
+	priv->frag_buf_node_pools = kzalloc_objs(*priv->frag_buf_node_pools,
+						 nr_node_ids);
+	if (!priv->frag_buf_node_pools)
+		return -ENOMEM;
+
+	for_each_node_state(node, N_POSSIBLE) {
+		struct mlx5_frag_buf_node_pools *node_pools;
+
+		node_pools = mlx5_frag_buf_node_pools_create(dev, node);
+		if (!node_pools) {
+			mlx5_frag_buf_pools_cleanup(dev);
+			return -ENOMEM;
+		}
+		priv->frag_buf_node_pools[node] = node_pools;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..71f7615ab553 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -558,6 +558,7 @@ enum mlx5_func_type {
 	MLX5_FUNC_TYPE_NUM,
 };
 
+struct mlx5_frag_buf_node_pools;
 struct mlx5_ft_pool;
 struct mlx5_priv {
 	/* IRQ table valid only for real pci devices PF or VF */
@@ -581,14 +582,16 @@ struct mlx5_priv {
 
 	struct mlx5_debugfs_entries dbg;
 
-	/* start: alloc staff */
+	/* start: alloc stuff */
 	/* protect buffer allocation according to numa node */
 	struct mutex            alloc_mutex;
 	int                     numa_node;
 
 	struct mutex            pgdir_mutex;
 	struct list_head        pgdir_list;
-	/* end: alloc staff */
+
+	struct mlx5_frag_buf_node_pools **frag_buf_node_pools;
+	/* end: alloc stuff */
 
 	struct mlx5_adev       **adev;
 	int			adev_idx;
-- 
2.44.0


