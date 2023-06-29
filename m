Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE13742552
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjF2MGL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 08:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjF2MFw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 08:05:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770383C18;
        Thu, 29 Jun 2023 05:05:20 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QsHB22YCZzqVVJ;
        Thu, 29 Jun 2023 20:02:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:04:47 +0800
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
Subject: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch with 64-bit DMA
Date:   Thu, 29 Jun 2023 20:02:21 +0800
Message-ID: <20230629120226.14854-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230629120226.14854-1-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

mlx5 calls page_pool_create() with PP_FLAG_PAGE_FRAG and is not
using the frag API, and the PP_FLAG_PAGE_FRAG checking will now
be removed in this patch, a new checking for the mlx5 driver is
needed to retain the old behavior. As we have not come up with a
better name yet, so PAGE_POOL_DMA_USE_PP_FRAG_COUNT is reused
here.

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
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 10 +++++
 include/net/page_pool.h                       | 45 ++++++++++++++++---
 net/core/page_pool.c                          | 18 ++------
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a7c526ee5024..42ccb77a1b6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -832,6 +832,16 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		/* Create a page_pool and register it with rxq */
 		struct page_pool_params pp_params = { 0 };
 
+		/* Return error here to avoid mlx5e_page_release_fragmented()
+		 * calling page_pool_defrag_page() to write to pp_frag_count
+		 * which is overlapped with dma_addr_upper in 'struct page' for
+		 * arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
+		 */
+		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
+			err = -EINVAL;
+			goto err_free_by_rq_type;
+		}
+
 		pp_params.order     = 0;
 		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_PAGE_FRAG;
 		pp_params.pool_size = pool_size;
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 126f9e294389..83bd13491105 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -32,7 +32,7 @@
 
 #include <linux/mm.h> /* Needed by ptr_ring */
 #include <linux/ptr_ring.h>
-#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
 					* map/unmap
@@ -50,6 +50,9 @@
 				 PP_FLAG_DMA_SYNC_DEV |\
 				 PP_FLAG_PAGE_FRAG)
 
+#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
+		(sizeof(dma_addr_t) > sizeof(unsigned long))
+
 /*
  * Fast allocation side cache array/stack
  *
@@ -219,8 +222,33 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-				  unsigned int size, gfp_t gfp);
+struct page *__page_pool_alloc_frag(struct page_pool *pool,
+				    unsigned int *offset, unsigned int size,
+				    gfp_t gfp);
+
+static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
+						unsigned int *offset,
+						unsigned int size, gfp_t gfp)
+{
+	unsigned int max_size = PAGE_SIZE << pool->p.order;
+
+	size = ALIGN(size, dma_get_cache_alignment());
+
+	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
+		    size > max_size))
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
 
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
@@ -322,8 +350,14 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
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
 
@@ -357,9 +391,6 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
-#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
-		(sizeof(dma_addr_t) > sizeof(unsigned long))
-
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 {
 	dma_addr_t ret = page->dma_addr;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3e12a61d456..9c4118c62997 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -14,7 +14,6 @@
 #include <net/xdp.h>
 
 #include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
 #include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
@@ -200,10 +199,6 @@ static int page_pool_init(struct page_pool *pool,
 		 */
 	}
 
-	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
-	    pool->p.flags & PP_FLAG_PAGE_FRAG)
-		return -EINVAL;
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
 	if (!pool->recycle_stats)
@@ -715,18 +710,13 @@ static void page_pool_free_frag(struct page_pool *pool)
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
-		return NULL;
-
-	size = ALIGN(size, dma_get_cache_alignment());
 	*offset = pool->frag_offset;
 
 	if (page && *offset + size > max_size) {
@@ -759,7 +749,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 	alloc_stat_inc(pool, fast);
 	return page;
 }
-EXPORT_SYMBOL(page_pool_alloc_frag);
+EXPORT_SYMBOL(__page_pool_alloc_frag);
 
 static void page_pool_empty_ring(struct page_pool *pool)
 {
-- 
2.33.0

