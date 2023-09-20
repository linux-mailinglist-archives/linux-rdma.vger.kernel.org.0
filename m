Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7247A7C93
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjITMCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjITMCa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 08:02:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA27B0;
        Wed, 20 Sep 2023 05:02:23 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RrH9l1NYFzNmm7;
        Wed, 20 Sep 2023 19:58:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 20:02:21 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Eric Dumazet <edumazet@google.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v9 3/6] page_pool: remove PP_FLAG_PAGE_FRAG
Date:   Wed, 20 Sep 2023 19:58:52 +0800
Message-ID: <20230920115855.27631-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230920115855.27631-1-linyunsheng@huawei.com>
References: <20230920115855.27631-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PP_FLAG_PAGE_FRAG is not really needed after pp_frag_count
handling is unified and page_pool_alloc_frag() is supported
in 32-bit arch with 64-bit DMA, so remove it.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                | 2 --
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c          | 3 +--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c            | 2 +-
 include/net/page_pool/types.h                            | 6 ++----
 net/core/page_pool.c                                     | 3 +--
 net/core/skbuff.c                                        | 2 +-
 8 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5cc0dbe12132..8c2e455f534d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3194,8 +3194,6 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
-		pp.flags |= PP_FLAG_PAGE_FRAG;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b4895c7b3efd..b9b66c1018d7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4931,8 +4931,7 @@ static void hns3_put_ring_config(struct hns3_nic_priv *priv)
 static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
 {
 	struct page_pool_params pp_params = {
-		.flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
-				PP_FLAG_DMA_SYNC_DEV,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order = hns3_page_order(ring),
 		.pool_size = ring->desc_num * hns3_buf_size(ring) /
 				(PAGE_SIZE << hns3_page_order(ring)),
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 997fedac3a98..b8646c306ebe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1403,7 +1403,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		return 0;
 	}
 
-	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
+	pp_params.flags = PP_FLAG_DMA_MAP;
 	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
 	pp_params.nid = NUMA_NO_NODE;
 	pp_params.dev = pfvf->dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a2ae791538ed..f3cf13a8bb19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -834,7 +834,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		struct page_pool_params pp_params = { 0 };
 
 		pp_params.order     = 0;
-		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_PAGE_FRAG;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pp_params.pool_size = pool_size;
 		pp_params.nid       = node;
 		pp_params.dev       = rq->pdev;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d158320bc15d..fe7cc67b7ee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -566,7 +566,7 @@ int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
-		.flags = PP_FLAG_PAGE_FRAG,
+		.flags = 0,
 		.nid = NUMA_NO_NODE,
 		.dev = dev->dma_dev,
 	};
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 887e7946a597..6fc5134095ed 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -17,10 +17,8 @@
 					* Please note DMA-sync-for-CPU is still
 					* device driver responsibility
 					*/
-#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
-				 PP_FLAG_DMA_SYNC_DEV |\
-				 PP_FLAG_PAGE_FRAG)
+				 PP_FLAG_DMA_SYNC_DEV)
 
 /*
  * Fast allocation side cache array/stack
@@ -45,7 +43,7 @@ struct pp_alloc_cache {
 
 /**
  * struct page_pool_params - page pool parameters
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV
  * @order:	2^order pages on allocation
  * @pool_size:	size of the ptr_ring
  * @nid:	NUMA node id to allocate from pages from
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 403b6df2e144..1927b9c36c23 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -756,8 +756,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page = pool->frag_page;
 
-	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
-		    size > max_size))
+	if (WARN_ON(size > max_size))
 		return NULL;
 
 	size = ALIGN(size, dma_get_cache_alignment());
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2198979470ec..54256753bf01 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5752,7 +5752,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* In general, avoid mixing page_pool and non-page_pool allocated
 	 * pages within the same SKB. Additionally avoid dealing with clones
 	 * with page_pool pages, in case the SKB is using page_pool fragment
-	 * references (PP_FLAG_PAGE_FRAG). Since we only take full page
+	 * references (page_pool_alloc_frag()). Since we only take full page
 	 * references for cloned SKBs at the moment that would result in
 	 * inconsistent reference counts.
 	 * In theory we could take full references if @from is cloned and
-- 
2.33.0

