Return-Path: <linux-rdma+bounces-19747-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIiSJBhn8mkBqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19747-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:16:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016649A07E
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9A5E300B1A3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A629392807;
	Wed, 29 Apr 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzV1Kc/l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E4391E7F;
	Wed, 29 Apr 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493766; cv=fail; b=iiBGbwFuWjY26+pFoirF0PoGp1bLZJEXZR0BlM2/VRI45aCMYv4n4URv/UgVzfoF/meIgya5wwdGOWJ+ptjHhECGhTHQ/kg9f2HfLgIcDtSziM2UUSg0M7SluIEVwLHyd3sUoFzjCqTlGGwQFvnZz7ziGlP5iiJvHzj8Gl/dQcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493766; c=relaxed/simple;
	bh=NjND37zevYRyGn3aVt1qtYfMRNm7hebyZ5faCA86tF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlvG0UF1CQlpBbRG0R7V/zQ7tEYJ+RL4YxYcp/gqv8pJQxwFCsCelmSUH90gM1ACudhI0reQtELT+8ov44jmyK6ob04k2SpdNjzBumkAfOymrGDbaWLni3s4SEQYdSJH4+9GHdb58BmMYAQ4LYkAFqU/PnqlrExFbdg3R/HzmiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzV1Kc/l; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Y803Rs7jWa8MqxjjIsabOXZd+xm070RKqFryBZvfQnBLDsw6c2PiVXdcnl+8c25Xn7damqTOxsx6k7WSliyPbVy+nulBlHsmTQ9ndb0kPkCJTDI7Tp5sXvjdcpdXixPDKTqx+2begYHR80Fy4ZF2zhbF8zw4roCu1C5gpVDsAy2txrHp1uB4HVyS2A5tEXWk6p8Nyk9ScLDaRhEQAaL21Ij1veBwCbvVGxjZHbmpcPOIIBVLPadyvgNSMKo1G1SVBxf8OMtr7uhlGjJIezWyIoZrAigmIWj+iYiaq4sgs0Caswz/iQXYXCHMsxERLuPebZdwcQ9ugOfm1NxJ39oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpfBuggc1F37DFEVglv8FdtpvN+MRYK94M9+jz333lE=;
 b=HnIS53TxAZqHGH1CJU20yuIRnwaQTzAMANPwewnNyimr8GXuqiGIbMxxuZvAT3oa8oM8xo2K1eppJsEASPQ6jMADN8Sy+kKZLQRYzkycYaYjapTzeckLhO0b2YpEmmZxN2sVIgClyiyUM8XDbTJHZ3La/kpZNOPTKhTm7rqvzQBC48josKMEWDvV8R8jNGW+luVobooRo92Kvh+MLiU6j4lcDVngVdD1rW9qnWyWgQniTf+8FgSlCBgxihYHUH6ZpljVzXbr4Px5RmaSihOilMtc3JWQfx/CCf39UV5yopocEzs5MQtIVXhNXZW4MHX51CKWBKHxOyP2npLoaqWGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpfBuggc1F37DFEVglv8FdtpvN+MRYK94M9+jz333lE=;
 b=KzV1Kc/lRSrf9Es2oeYNsvUmWzr5itSStEBj7pc3qRkOKnMTZTe2xfOEh8LTsW7qQ0nsf6fc7r+enxEKOgruud540156ohdsiGB/QPqqXwa0PQ2swox1ZpJEUZIsecgpMoOx8Ea5rA+Eo6R+6BSJRk5Kdsf3DNMDRWcUGpDoapg8fmbDok8CTdqeRHCBY2ZfeJ7MC5WmWDFfm1Y8QHgc5oZtZTk2Bkran0mHXqBB/ANHJlvwG3hfyStL/uQ+tm09eGgBddl+p2b9LyJV179Es+j54aEU0haxJOUvI0j/YdTWca3pjY4PjVeggP7yN92k8EQJY/hoUZP6+YAPRIVVzw==
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 20:15:49 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::62) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 20:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 20:15:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 13:15:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 13:15:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 13:15:27 -0700
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
Subject: [PATCH net-next V2 2/3] net/mlx5: add frag buf pools create/destroy paths
Date: Wed, 29 Apr 2026 23:14:28 +0300
Message-ID: <20260429201429.223809-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0548b8-fa82-4370-af6f-08dea62c1ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mIAyVS82kFzLhyG4HCIRBRAUiBgFQS6B7rFgdqj5BinVAxqU4cgM5Hm/N8rzPqHBcpc2OaZRTjQeA1NfGXi299F+yS1ViZ3DiDEJZxstr1rjonZWqbx0xehPw5joxI8Kk21m9NO/4RGEByCcibC537VKAuGCDzenFhep6dZ7rrR3N87B37FaEWHB2lsQLcjTZ9ZpEfuwygLF/HMgHcKhd2fwxtBGjfZm7eb7WYRaSbxDKvKWIZScjy9CSYkblyTXPJzrrlkbcAI0b353NNP9z0svTlDzWbJlQyFt5+9qibwMrH4JQznUQXtkqzmLBc+jjQacEB7qt7eC8v18/sKJtyYKhj4n6SDfst2y2XqG20fhBEy06PPEBMDy3a78MN8Ng7A4S2XWNPCZuYPv6kyIq6oZP3+mIHWYDXAIQgcuTTkcPMwt3Qcea3TUaIr/HbEWLJzPTQ1bqNTZcYczu6uO+s1FT2eRZnmbBEX9g+G4gpAxeY7Mma/ANMpcjEYr4hzCkuypx0UVGx+wc9HMbQVw4AwEhq67KE7TYBXf6NFZx88iDlvvWcnOyMLz/ef+qNrm+RfNvLlPvMyJIXRS97bFX0al4iIGDqR9NnjWlsp8Dgt22tKjH66zgVeCZlpO471BGZhQZM0Bro7BEY4Th0nZ9L8q96TEIVAeXCdFt96XDGpqBikIWGpHI2uLRYBFscrQ7JfI/caPI+d99CT9Uo2O1cI7ZEFUnrXCCxUz7I+K5yvBHwY0v+8wPW8danySF00K97LyOaKIefjyGrxr3Xd5KQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CFSlBlWXtGWhBjSpsbmogEaLB6Y6JJ8e9EGJ3UvFAZPonzEXdxT/zktyShmYMHRURY1qe57QOUvjIBwuqH8wpgxWDVJ89N/tm3M/Njg3cuEPuYu4yoDKs4GxuZ0ETswE6E8rE9gkd/Vsp1ePL95mxSeq+mA/4d9rL5gGg1BSgT2eiPgjsc/bHpNiB0/aZCcG2nHo8Ixpu9bewomuJH9Y0JKXlMrjchAn1s5nyoh6RZkNAy2JG7HYqaXvK4cit1kYu+pbHR3Mk42eOGG2wN/M8baoAtOy9kvntcVHnUppDtYuVSMHCHWXUO5wvFXV6JCCvDI4Drl+N7LiuZtABsaQRiMRQz1RH8evWuuiBstrBylS30JtRTMm/IHAeeBFoxJLQPA5I9/xuzyQw/xOfylCOdyIIOxLDcWGPSpPfn/GEfoajba8maxUwBAaqeK0SWLR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 20:15:48.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0548b8-fa82-4370-af6f-08dea62c1ab9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
X-Rspamd-Queue-Id: 4016649A07E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19747-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 116 +++++++++++++++++-
 include/linux/mlx5/driver.h                   |   7 +-
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index cebb3559d2c9..fcc859c5f810 100644
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
@@ -71,14 +97,100 @@ static void *mlx5_dma_zalloc_coherent_node(struct mlx5_core_dev *dev,
 	return cpu_handle;
 }
 
-/* Implemented later in the series */
+static void mlx5_dma_pool_destroy(struct mlx5_dma_pool *pool)
+{
+	mutex_destroy(&pool->lock);
+	kfree(pool);
+}
+
+static struct mlx5_dma_pool *mlx5_dma_pool_create(struct mlx5_core_dev *dev,
+						  int node, u8 block_shift)
+{
+	struct mlx5_dma_pool *pool;
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


