Return-Path: <linux-rdma+bounces-12535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3833AB15436
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 22:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110921886E84
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D92BDC05;
	Tue, 29 Jul 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AZKKkmk5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F02BD5A3;
	Tue, 29 Jul 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820053; cv=none; b=ks1KUR08Fgg++70m/H2+7er9EldHd5Gx2maU+mRNo+sRyJeJUsJwhJzBd9tNhDuyMpQTWmjQLWv8I5QHbUJ2gbDI8D3o7olLtTGQt2YgM81Zkhq7o0Ly1G9Iw9qOT8mcCM9a6cxkcqmf02Rvmo0u+Ub/fvzjLp0tBWlKT77adhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820053; c=relaxed/simple;
	bh=0zLo7GL7I9TCHbOoGwzlGjXmLj8z6HIirp6t8PA646M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Doh6XRW1y39w+nOHsmOMvEzx/VJVIELzrXKv6vtkMUrQw2p79aP3/gq+DoTgeGEdaTUKFM+bUXFbyV+3qNtO3xzN7apsLD2q43qQ2DKOJqcbjMjZI/KV4ME8sgEMm/6meDczqIm3jo5OjCWRQjhF2Noen2cbLb7NtsS9caFMFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AZKKkmk5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id D71B7211765A; Tue, 29 Jul 2025 13:14:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D71B7211765A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753820050;
	bh=w82lBotzO3j4qBZjTpjjQRl5gaIsUvCtozgar8DJJBY=;
	h=Date:From:To:Subject:From;
	b=AZKKkmk5zeDxR6Vzmy5Q2aElEbkUdlIpviT4mLhNuGAX6LQ3EQxeuGboTK/yCHklG
	 sKxyjfA82137a1NcRPkOSsOGiANMtdn8rzZwOJvPzTE+A5Kj3T2snGr2PbQvsTvfyx
	 ioZjkkpo2Qp+cbSBiG8lo0TvAXyfXewHAZRsb/5o=
Date: Tue, 29 Jul 2025 13:14:10 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: horms@kernel.org, kuba@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
	michal.kubiak@intel.com, ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	rosenp@gmail.com, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com, dipayanroy@microsoft.com
Subject: [PATCH v3] net: mana: Use page pool fragments for RX buffers instead
 of full pages to improve memory efficiency.
Message-ID: <20250729201410.GA4555@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

This patch enhances RX buffer handling in the mana driver by allocating
pages from a page pool and slicing them into MTU-sized fragments, rather
than dedicating a full page per packet. This approach is especially
beneficial on systems with large page sizes like 64KB.

Key improvements:

- Proper integration of page pool for RX buffer allocations.
- MTU-sized buffer slicing to improve memory utilization.
- Reduce overall per Rx queue memory footprint.
- Automatic fallback to full-page buffers when:
   * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
   * The XDP path is active, to avoid complexities with fragment reuse.

Testing on VMs with 64KB pages shows around 200% throughput improvement.
Memory efficiency is significantly improved due to reduced wastage in page
allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
page for MTU size of 1500, instead of 1 rx buffer per page previously.

Tested:

- iperf3, iperf2, and nttcp benchmarks.
- Jumbo frames with MTU 9000.
- Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
  testing the XDP path in driver.
- Memory leak detection (kmemleak).
- Driver load/unload, reboot, and stress scenarios.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
Changes in v3:
  - Retained the pre-alloc rxbuf for driver reconfig paths
    to better handle low memory scenario during reconfig.

Changes in v2:
  - Fixed mana_xdp_set() to return error code on failure instead of
    always returning 0.
  - Moved all local variable declarations to the start of functions
    in mana_get_rxbuf_cfg.
  - Removed unnecessary parentheses and wrapped lines to <= 80 chars.
  - Use mana_xdp_get() for checking bpf_prog.
  - Factored repeated page put/free logic into a static helper function.
---
 .../net/ethernet/microsoft/mana/mana_bpf.c    |  36 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 147 ++++++++++++------
 include/net/mana/mana.h                       |   4 +
 3 files changed, 137 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index d30721d4516f..1cf470b25167 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -174,6 +174,8 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	struct bpf_prog *old_prog;
 	struct gdma_context *gc;
+	int err = 0;
+	bool dealloc_rxbufs_pre = false;
 
 	gc = apc->ac->gdma_dev->gdma_context;
 
@@ -198,15 +200,45 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
-	if (apc->port_is_up)
+	if (apc->port_is_up) {
+		/* Re-create rxq's after xdp prog was loaded or unloaded.
+		 * Ex: re create rxq's to switch from full pages to smaller
+		 * size page fragments when xdp prog is unloaded and vice-versa.
+		 */
+
+		/* Pre-allocate buffers to prevent failure in mana_attach later */
+		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
+		if (err) {
+			netdev_err(ndev,
+				   "Insufficient memory for rx buf config change\n");
+			goto out;
+		}
+		dealloc_rxbufs_pre = true;
+
+		err = mana_detach(ndev, false);
+		if (err) {
+			netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
+			goto out;
+		}
+
+		err = mana_attach(ndev);
+		if (err) {
+			netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
+			goto out;
+		}
+
 		mana_chn_setxdp(apc, prog);
+	}
 
 	if (prog)
 		ndev->max_mtu = MANA_XDP_MTU_MAX;
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
 
-	return 0;
+out:
+	if (dealloc_rxbufs_pre)
+		mana_pre_dealloc_rxbufs(apc);
+	return err;
 }
 
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a7973651ae51..591f3081d395 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -56,6 +56,14 @@ static bool mana_en_need_log(struct mana_port_context *apc, int err)
 		return true;
 }
 
+static void mana_put_rx_page(struct mana_rxq *rxq, struct page *page, bool from_pool)
+{
+	if (from_pool)
+		page_pool_put_full_page(rxq->page_pool, page, false);
+	else
+		put_page(page);
+}
+
 /* Microsoft Azure Network Adapter (MANA) functions */
 
 static int mana_open(struct net_device *ndev)
@@ -629,21 +637,40 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 }
 
 /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
-static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, u32 *alloc_size,
-			       u32 *headroom)
+static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
+			       int mtu, u32 *datasize, u32 *alloc_size,
+			       u32 *headroom, u32 *frag_count)
 {
-	if (mtu > MANA_XDP_MTU_MAX)
-		*headroom = 0; /* no support for XDP */
-	else
-		*headroom = XDP_PACKET_HEADROOM;
+	u32 len, buf_size;
 
-	*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+	/* Calculate datasize first (consistent across all cases) */
+	*datasize = mtu + ETH_HLEN;
 
-	/* Using page pool in this case, so alloc_size is PAGE_SIZE */
-	if (*alloc_size < PAGE_SIZE)
-		*alloc_size = PAGE_SIZE;
+	/* For xdp and jumbo frames make sure only one packet fits per page */
+	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
+		if (mana_xdp_get(apc)) {
+			*headroom = XDP_PACKET_HEADROOM;
+			*alloc_size = PAGE_SIZE;
+		} else {
+			*headroom = 0; /* no support for XDP */
+			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
+						     *headroom);
+		}
 
-	*datasize = mtu + ETH_HLEN;
+		*frag_count = 1;
+		return;
+	}
+
+	/* Standard MTU case - optimize for multiple packets per page */
+	*headroom = 0;
+
+	/* Calculate base buffer size needed */
+	len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+	buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
+
+	/* Calculate how many packets can fit in a page */
+	*frag_count = PAGE_SIZE / buf_size;
+	*alloc_size = buf_size;
 }
 
 int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_queues)
@@ -655,8 +682,9 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
 	void *va;
 	int i;
 
-	mana_get_rxbuf_cfg(new_mtu, &mpc->rxbpre_datasize,
-			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom);
+	mana_get_rxbuf_cfg(mpc, new_mtu, &mpc->rxbpre_datasize,
+			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom,
+			   &mpc->rxbpre_frag_count);
 
 	dev = mpc->ac->gdma_dev->gdma_context->dev;
 
@@ -1841,8 +1869,11 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 
 drop:
 	if (from_pool) {
-		page_pool_recycle_direct(rxq->page_pool,
-					 virt_to_head_page(buf_va));
+		if (rxq->frag_count == 1)
+			page_pool_recycle_direct(rxq->page_pool,
+						 virt_to_head_page(buf_va));
+		else
+			page_pool_free_va(rxq->page_pool, buf_va, true);
 	} else {
 		WARN_ON_ONCE(rxq->xdp_save_va);
 		/* Save for reuse */
@@ -1858,33 +1889,43 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 			     dma_addr_t *da, bool *from_pool)
 {
 	struct page *page;
+	u32 offset;
 	void *va;
-
 	*from_pool = false;
 
-	/* Reuse XDP dropped page if available */
-	if (rxq->xdp_save_va) {
-		va = rxq->xdp_save_va;
-		rxq->xdp_save_va = NULL;
-	} else {
-		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
+	/* Don't use fragments for jumbo frames or XDP (i.e when fragment = 1 per page) */
+	if (rxq->frag_count == 1) {
+		/* Reuse XDP dropped page if available */
+		if (rxq->xdp_save_va) {
+			va = rxq->xdp_save_va;
+			page = virt_to_head_page(va);
+			rxq->xdp_save_va = NULL;
+		} else {
+			page = page_pool_dev_alloc_pages(rxq->page_pool);
+			if (!page)
+				return NULL;
+
+			*from_pool = true;
+			va = page_to_virt(page);
+		}
+
+		*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
+				     DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, *da)) {
+			mana_put_rx_page(rxq, page, *from_pool);
 			return NULL;
+		}
 
-		*from_pool = true;
-		va = page_to_virt(page);
+		return va;
 	}
 
-	*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
-			     DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, *da)) {
-		if (*from_pool)
-			page_pool_put_full_page(rxq->page_pool, page, false);
-		else
-			put_page(virt_to_head_page(va));
-
+	page =  page_pool_dev_alloc_frag(rxq->page_pool, &offset, rxq->alloc_size);
+	if (!page)
 		return NULL;
-	}
+
+	va  = page_to_virt(page) + offset;
+	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
+	*from_pool = true;
 
 	return va;
 }
@@ -1901,9 +1942,9 @@ static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
 	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 	if (!va)
 		return;
-
-	dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
-			 DMA_FROM_DEVICE);
+	if (!rxoob->from_pool || rxq->frag_count == 1)
+		dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
+				 DMA_FROM_DEVICE);
 	*old_buf = rxoob->buf_va;
 	*old_fp = rxoob->from_pool;
 
@@ -2314,15 +2355,15 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		if (!rx_oob->buf_va)
 			continue;
 
-		dma_unmap_single(dev, rx_oob->sgl[0].address,
-				 rx_oob->sgl[0].size, DMA_FROM_DEVICE);
-
 		page = virt_to_head_page(rx_oob->buf_va);
 
-		if (rx_oob->from_pool)
-			page_pool_put_full_page(rxq->page_pool, page, false);
-		else
-			put_page(page);
+		if (rxq->frag_count == 1) {
+			dma_unmap_single(dev, rx_oob->sgl[0].address, rx_oob->sgl[0].size,
+					 DMA_FROM_DEVICE);
+			mana_put_rx_page(rxq, page, rx_oob->from_pool);
+		} else {
+			page_pool_free_va(rxq->page_pool, rx_oob->buf_va, true);
+		}
 
 		rx_oob->buf_va = NULL;
 	}
@@ -2428,11 +2469,22 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	struct page_pool_params pprm = {};
 	int ret;
 
-	pprm.pool_size = mpc->rx_queue_size;
+	pprm.pool_size = mpc->rx_queue_size / rxq->frag_count + 1;
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
 	pprm.netdev = rxq->ndev;
 	pprm.order = get_order(rxq->alloc_size);
+	pprm.queue_idx = rxq->rxq_idx;
+	pprm.dev = gc->dev;
+
+	/* Let the page pool do the dma map when page sharing with multiple fragments
+	 * enabled for rx buffers.
+	 */
+	if (rxq->frag_count > 1) {
+		pprm.flags =  PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pprm.max_len = PAGE_SIZE;
+		pprm.dma_dir = DMA_FROM_DEVICE;
+	}
 
 	rxq->page_pool = page_pool_create(&pprm);
 
@@ -2471,9 +2523,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	rxq->rxq_idx = rxq_idx;
 	rxq->rxobj = INVALID_MANA_HANDLE;
 
-	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
-			   &rxq->headroom);
-
+	mana_get_rxbuf_cfg(apc, ndev->mtu, &rxq->datasize, &rxq->alloc_size,
+			   &rxq->headroom, &rxq->frag_count);
 	/* Create page pool for RX queue */
 	err = mana_create_page_pool(rxq, gc);
 	if (err) {
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index e1030a7d2daa..0921485565c0 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -65,6 +65,8 @@ enum TRI_STATE {
 #define MANA_STATS_RX_COUNT 5
 #define MANA_STATS_TX_COUNT 11
 
+#define MANA_RX_FRAG_ALIGNMENT 64
+
 struct mana_stats_rx {
 	u64 packets;
 	u64 bytes;
@@ -328,6 +330,7 @@ struct mana_rxq {
 	u32 datasize;
 	u32 alloc_size;
 	u32 headroom;
+	u32 frag_count;
 
 	mana_handle_t rxobj;
 
@@ -510,6 +513,7 @@ struct mana_port_context {
 	u32 rxbpre_datasize;
 	u32 rxbpre_alloc_size;
 	u32 rxbpre_headroom;
+	u32 rxbpre_frag_count;
 
 	struct bpf_prog *bpf_prog;
 
-- 
2.43.0


