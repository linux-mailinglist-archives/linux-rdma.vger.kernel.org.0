Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF277DE25
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbjHPKFH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243681AbjHPKEf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 06:04:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABBAC1;
        Wed, 16 Aug 2023 03:04:33 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQkDR4nrxzFqgc;
        Wed, 16 Aug 2023 18:01:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 18:04:08 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit arch with 64-bit DMA
Date:   Wed, 16 Aug 2023 18:01:08 +0800
Message-ID: <20230816100113.41034-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230816100113.41034-1-linyunsheng@huawei.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently page_pool_alloc_frag() is not supported in 32-bit
arch with 64-bit DMA because of the overlap issue between
pp_frag_count and dma_addr_upper in 'struct page' for those
arches, which seems to be quite common, see [1], which means
driver may need to handle it when using frag API.

In order to simplify the driver's work when using frag API
this patch allows page_pool_alloc_frag() to call
page_pool_alloc_pages() to return pages for those arches.

Add a PP_FLAG_PAGE_SPLIT_IN_DRIVER flag in order to fail the
page_pool creation for 32-bit arch with 64-bit DMA when driver
tries to do the page splitting itself.

Note that it may aggravate truesize underestimate problem for
skb as there is no page splitting for those pages, if driver
need a accurate truesize, it may calculate that according to
frag size, page order and PAGE_POOL_DMA_USE_PP_FRAG_COUNT
being true or not. And we may provide a helper for that if it
turns out to be helpful.

1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 include/net/page_pool/helpers.h               | 38 +++++++++++++++--
 include/net/page_pool/types.h                 | 42 ++++++++++++-------
 net/core/page_pool.c                          | 15 +++----
 4 files changed, 68 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bc9d5a5bea01..ec9c5a8cbda6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -834,7 +834,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		struct page_pool_params pp_params = { 0 };
 
 		pp_params.order     = 0;
-		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_PAGE_FRAG;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+					PP_FLAG_PAGE_SPLIT_IN_DRIVER;
 		pp_params.pool_size = pool_size;
 		pp_params.nid       = node;
 		pp_params.dev       = rq->pdev;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 94231533a369..cb18de55f239 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -29,8 +29,12 @@
 #ifndef _NET_PAGE_POOL_HELPERS_H
 #define _NET_PAGE_POOL_HELPERS_H
 
+#include <linux/dma-mapping.h>
 #include <net/page_pool/types.h>
 
+#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
+		(sizeof(dma_addr_t) > sizeof(unsigned long))
+
 #ifdef CONFIG_PAGE_POOL_STATS
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
@@ -73,6 +77,29 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
+static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
+						unsigned int *offset,
+						unsigned int size, gfp_t gfp)
+{
+	unsigned int max_size = PAGE_SIZE << pool->p.order;
+
+	size = ALIGN(size, dma_get_cache_alignment());
+
+	if (WARN_ON(size > max_size))
+		return NULL;
+
+	/* Don't allow page splitting and allocate one big frag
+	 * for 32-bit arch with 64-bit DMA, corresponding to
+	 * the checking in page_pool_is_last_frag().
+	 */
+	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
+		*offset = 0;
+		return page_pool_alloc_pages(pool, gfp);
+	}
+
+	return __page_pool_alloc_frag(pool, offset, size, gfp);
+}
+
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
 						    unsigned int size)
@@ -134,8 +161,14 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
 static inline bool page_pool_is_last_frag(struct page_pool *pool,
 					  struct page *page)
 {
-	/* If fragments aren't enabled or count is 0 we were the last user */
+	/* We assume we are the last frag user that is still holding
+	 * on to the page if:
+	 * 1. Fragments aren't enabled.
+	 * 2. We are running in 32-bit arch with 64-bit DMA.
+	 * 3. page_pool_defrag_page() indicate we are the last user.
+	 */
 	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
+	       PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
 	       (page_pool_defrag_page(page, 1) == 0);
 }
 
@@ -197,9 +230,6 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
-#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
-		(sizeof(dma_addr_t) > sizeof(unsigned long))
-
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
  * @page:	page allocated from a page pool
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 887e7946a597..079337c42aa6 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,21 +6,29 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 
-#define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
-					* map/unmap
-					*/
-#define PP_FLAG_DMA_SYNC_DEV	BIT(1) /* If set all pages that the driver gets
-					* from page_pool will be
-					* DMA-synced-for-device according to
-					* the length provided by the device
-					* driver.
-					* Please note DMA-sync-for-CPU is still
-					* device driver responsibility
-					*/
-#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
+/* Should page_pool do the DMA map/unmap */
+#define PP_FLAG_DMA_MAP			BIT(0)
+
+/* If set all pages that the driver gets from page_pool will be
+ * DMA-synced-for-device according to the length provided by the device driver.
+ * Please note DMA-sync-for-CPU is still device driver responsibility
+ */
+#define PP_FLAG_DMA_SYNC_DEV		BIT(1)
+
+/* for page frag feature */
+#define PP_FLAG_PAGE_FRAG		BIT(2)
+
+/* If set driver will do the page splitting itself. This is used to fail the
+ * page_pool creation because there is overlap issue between pp_frag_count and
+ * dma_addr_upper in 'struct page' for some arches with
+ * PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
+ */
+#define PP_FLAG_PAGE_SPLIT_IN_DRIVER	BIT(3)
+
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
 				 PP_FLAG_DMA_SYNC_DEV |\
-				 PP_FLAG_PAGE_FRAG)
+				 PP_FLAG_PAGE_FRAG |\
+				 PP_FLAG_PAGE_SPLIT_IN_DRIVER)
 
 /*
  * Fast allocation side cache array/stack
@@ -45,7 +53,8 @@ struct pp_alloc_cache {
 
 /**
  * struct page_pool_params - page pool parameters
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG,
+ *		PP_FLAG_PAGE_SPLIT_IN_DRIVER
  * @order:	2^order pages on allocation
  * @pool_size:	size of the ptr_ring
  * @nid:	NUMA node id to allocate from pages from
@@ -183,8 +192,9 @@ struct page_pool {
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-				  unsigned int size, gfp_t gfp);
+struct page *__page_pool_alloc_frag(struct page_pool *pool,
+				    unsigned int *offset, unsigned int size,
+				    gfp_t gfp);
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
 struct xdp_mem_info;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 77cb75e63aca..7d5f0512aa13 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -14,7 +14,6 @@
 #include <net/xdp.h>
 
 #include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
 #include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
@@ -212,7 +211,7 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
-	    pool->p.flags & PP_FLAG_PAGE_FRAG)
+	    pool->p.flags & PP_FLAG_PAGE_SPLIT_IN_DRIVER)
 		return -EINVAL;
 
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -737,18 +736,16 @@ static void page_pool_free_frag(struct page_pool *pool)
 	page_pool_return_page(pool, page);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool,
-				  unsigned int *offset,
-				  unsigned int size, gfp_t gfp)
+struct page *__page_pool_alloc_frag(struct page_pool *pool,
+				    unsigned int *offset,
+				    unsigned int size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page = pool->frag_page;
 
-	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
-		    size > max_size))
+	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG)))
 		return NULL;
 
-	size = ALIGN(size, dma_get_cache_alignment());
 	*offset = pool->frag_offset;
 
 	if (page && *offset + size > max_size) {
@@ -781,7 +778,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 	alloc_stat_inc(pool, fast);
 	return page;
 }
-EXPORT_SYMBOL(page_pool_alloc_frag);
+EXPORT_SYMBOL(__page_pool_alloc_frag);
 
 static void page_pool_empty_ring(struct page_pool *pool)
 {
-- 
2.33.0

