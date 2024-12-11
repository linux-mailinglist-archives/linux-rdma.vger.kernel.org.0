Return-Path: <linux-rdma+bounces-6412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1B9EC24A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC79316828C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC71FBC93;
	Wed, 11 Dec 2024 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cONS6KVJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92524C148;
	Wed, 11 Dec 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884594; cv=none; b=UiGj+YakzdZt1DTLKsFVFjXoM9kgQlkuQZwDee36UlzY/BgAP2NjaSsTYspDqbOM1qaePP1sTd1LrLURSx/z3BzJM7/vTEupqpeG2RBPJi8LM3SF93uAmT2VOlQ8Old+ZnmLzLh21iheblYw85LEbX5RNK7ESW0A5zpv/WGoAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884594; c=relaxed/simple;
	bh=y3tgUu3xsvD/Se7+EEQelrkNVOwntrehJ1CLWqoIEes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLz3T7T1X/h83dAZ+o6oFyHA84ioi0jb0oqA1quUySFQnR8H6aNEz1LeVKJQhaDNUTVcx+bbH9+JSokOv5BMH9YOKM8mLdjoq7a4yzdeFeCKjUH1uUF8icmesQFleIDXyKYYqFCrGPht0WuIj+ILbATzA0JXIIR/9eMhm2M5k/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cONS6KVJ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733884588; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=T/KjqVx96jLIjf5WSxOfM3Z6jNRUu5QEHlyF2xKv5XQ=;
	b=cONS6KVJCTRJCTIWpDTQEHFHTLCr/EinmHH5W5NMq5D1AvY68qmu93jHleIlvN7gOnE77Lc0bmdHG4jFRGIuZ1cwJ69NpgaHHt2nJYGDx9xJUvM6laflxn2kLgwtdxhFDoGWlx+uvLSfXO45H4yCGv8gvTF5F4CpWRDH7WNBZeA=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLGemVF_1733884266 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:31:06 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	pasic@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RESEND v3 1/2] net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1
Date: Wed, 11 Dec 2024 10:30:54 +0800
Message-Id: <20241211023055.89610-2-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For SMC-R V2, llc msg can be larger than SMC_WR_BUF_SIZE, thus every
recv wr has 2 sges, the first sge with length SMC_WR_BUF_SIZE is for
V1/V2 compatible llc/cdc msg, and the second sge with length
SMC_WR_BUF_V2_SIZE-SMC_WR_TX_SIZE is for V2 specific llc msg, like
SMC_LLC_DELETE_RKEY and SMC_LLC_ADD_LINK for SMC-R V2. The memory
buffer in the second sge is shared by all recv wr in one link and
all link in one lgr for saving memory usage purpose.

But not all RDMA devices with max_recv_sge greater than 1. Thus SMC-R
V2 can not support on such RDMA devices and SMC_CLC_DECL_INTERR fallback
happens because of the failure of create qp.

This patch introduce the support for SMC-R V2 on RDMA devices with
max_recv_sge equals to 1. Every recv wr has only one sge with individual
buffer whose size is SMC_WR_BUF_V2_SIZE once the RDMA device's max_recv_sge
equals to 1. It may use more memory, but it is better than
SMC_CLC_DECL_INTERR fallback.

Co-developed-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 net/smc/smc_core.c |  5 +++++
 net/smc/smc_core.h | 11 ++++++++++-
 net/smc/smc_ib.c   |  3 +--
 net/smc/smc_llc.c  | 21 +++++++++++++++------
 net/smc/smc_wr.c   | 42 +++++++++++++++++++++---------------------
 5 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..ede4d5f3111b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -795,9 +795,14 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	if (lgr->smc_version == SMC_V2) {
 		lnk->smcibdev = ini->smcrv2.ib_dev_v2;
 		lnk->ibport = ini->smcrv2.ib_port_v2;
+		lnk->wr_rx_sge_cnt = lnk->smcibdev->ibdev->attrs.max_recv_sge < 2 ? 1 : 2;
+		lnk->wr_rx_buflen = smc_link_shared_v2_rxbuf(lnk) ?
+			SMC_WR_BUF_SIZE : SMC_WR_BUF_V2_SIZE;
 	} else {
 		lnk->smcibdev = ini->ib_dev;
 		lnk->ibport = ini->ib_port;
+		lnk->wr_rx_sge_cnt = 1;
+		lnk->wr_rx_buflen = SMC_WR_BUF_SIZE;
 	}
 	get_device(&lnk->smcibdev->ibdev->dev);
 	atomic_inc(&lnk->smcibdev->lnk_cnt);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 69b54ecd6503..48a1b1dcb576 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -122,10 +122,14 @@ struct smc_link {
 	} ____cacheline_aligned_in_smp;
 	struct completion	tx_ref_comp;
 
-	struct smc_wr_buf	*wr_rx_bufs;	/* WR recv payload buffers */
+	u8			*wr_rx_bufs;	/* WR recv payload buffers */
 	struct ib_recv_wr	*wr_rx_ibs;	/* WR recv meta data */
 	struct ib_sge		*wr_rx_sges;	/* WR recv scatter meta data */
 	/* above three vectors have wr_rx_cnt elements and use the same index */
+	int			wr_rx_sge_cnt; /* rx sge, V1 is 1, V2 is either 2 or 1 */
+	int			wr_rx_buflen;	/* buffer len for the first sge, len for the
+						 * second sge is lgr shared if rx sge is 2.
+						 */
 	dma_addr_t		wr_rx_dma_addr;	/* DMA address of wr_rx_bufs */
 	dma_addr_t		wr_rx_v2_dma_addr; /* DMA address of v2 rx buf*/
 	u64			wr_rx_id;	/* seq # of last recv WR */
@@ -506,6 +510,11 @@ static inline bool smc_link_active(struct smc_link *lnk)
 	return lnk->state == SMC_LNK_ACTIVE;
 }
 
+static inline bool smc_link_shared_v2_rxbuf(struct smc_link *lnk)
+{
+	return lnk->wr_rx_sge_cnt > 1;
+}
+
 static inline void smc_gid_be16_convert(__u8 *buf, u8 *gid_raw)
 {
 	sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9c563cdbea90..53828833a3f7 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -662,7 +662,6 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk)
 /* create a queue pair within the protection domain for a link */
 int smc_ib_create_queue_pair(struct smc_link *lnk)
 {
-	int sges_per_buf = (lnk->lgr->smc_version == SMC_V2) ? 2 : 1;
 	struct ib_qp_init_attr qp_attr = {
 		.event_handler = smc_ib_qp_event_handler,
 		.qp_context = lnk,
@@ -676,7 +675,7 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
 			.max_send_wr = SMC_WR_BUF_CNT * 3,
 			.max_recv_wr = SMC_WR_BUF_CNT * 3,
 			.max_send_sge = SMC_IB_MAX_SEND_SGE,
-			.max_recv_sge = sges_per_buf,
+			.max_recv_sge = lnk->wr_rx_sge_cnt,
 			.max_inline_data = 0,
 		},
 		.sq_sig_type = IB_SIGNAL_REQ_WR,
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 018ce8133b02..f865c58c3aa7 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -997,13 +997,14 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 }
 
 static void smc_llc_save_add_link_rkeys(struct smc_link *link,
-					struct smc_link *link_new)
+					struct smc_link *link_new,
+					u8 *llc_msg)
 {
 	struct smc_llc_msg_add_link_v2_ext *ext;
 	struct smc_link_group *lgr = link->lgr;
 	int max, i;
 
-	ext = (struct smc_llc_msg_add_link_v2_ext *)((u8 *)lgr->wr_rx_buf_v2 +
+	ext = (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
 						     SMC_WR_TX_SIZE);
 	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
 	down_write(&lgr->rmbs_lock);
@@ -1098,7 +1099,9 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	if (rc)
 		goto out_clear_lnk;
 	if (lgr->smc_version == SMC_V2) {
-		smc_llc_save_add_link_rkeys(link, lnk_new);
+		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
+			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
+		smc_llc_save_add_link_rkeys(link, lnk_new, llc_msg);
 	} else {
 		rc = smc_llc_cli_rkey_exchange(link, lnk_new);
 		if (rc) {
@@ -1498,7 +1501,9 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	if (rc)
 		goto out_err;
 	if (lgr->smc_version == SMC_V2) {
-		smc_llc_save_add_link_rkeys(link, link_new);
+		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
+			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;
+		smc_llc_save_add_link_rkeys(link, link_new, llc_msg);
 	} else {
 		rc = smc_llc_srv_rkey_exchange(link, link_new);
 		if (rc)
@@ -1807,8 +1812,12 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	if (lgr->smc_version == SMC_V2) {
 		struct smc_llc_msg_delete_rkey_v2 *llcv2;
 
-		memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
-		llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
+		if (smc_link_shared_v2_rxbuf(link)) {
+			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
+			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
+		} else {
+			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)llc;
+		}
 		llcv2->num_inval_rkeys = 0;
 
 		max = min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 994c0cd4fddb..b04a21b8c511 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -439,7 +439,7 @@ static inline void smc_wr_rx_demultiplex(struct ib_wc *wc)
 		return; /* short message */
 	temp_wr_id = wc->wr_id;
 	index = do_div(temp_wr_id, link->wr_rx_cnt);
-	wr_rx = (struct smc_wr_rx_hdr *)&link->wr_rx_bufs[index];
+	wr_rx = (struct smc_wr_rx_hdr *)(link->wr_rx_bufs + index * link->wr_rx_buflen);
 	hash_for_each_possible(smc_wr_rx_hash, handler, list, wr_rx->type) {
 		if (handler->type == wr_rx->type)
 			handler->handler(wc, wr_rx);
@@ -555,7 +555,6 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 
 static void smc_wr_init_sge(struct smc_link *lnk)
 {
-	int sges_per_buf = (lnk->lgr->smc_version == SMC_V2) ? 2 : 1;
 	bool send_inline = (lnk->qp_attr.cap.max_inline_data > SMC_WR_TX_SIZE);
 	u32 i;
 
@@ -608,13 +607,14 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 	 * the larger spillover buffer, allowing easy data mapping.
 	 */
 	for (i = 0; i < lnk->wr_rx_cnt; i++) {
-		int x = i * sges_per_buf;
+		int x = i * lnk->wr_rx_sge_cnt;
 
 		lnk->wr_rx_sges[x].addr =
-			lnk->wr_rx_dma_addr + i * SMC_WR_BUF_SIZE;
-		lnk->wr_rx_sges[x].length = SMC_WR_TX_SIZE;
+			lnk->wr_rx_dma_addr + i * lnk->wr_rx_buflen;
+		lnk->wr_rx_sges[x].length = smc_link_shared_v2_rxbuf(lnk) ?
+			SMC_WR_TX_SIZE : lnk->wr_rx_buflen;
 		lnk->wr_rx_sges[x].lkey = lnk->roce_pd->local_dma_lkey;
-		if (lnk->lgr->smc_version == SMC_V2) {
+		if (lnk->lgr->smc_version == SMC_V2 && smc_link_shared_v2_rxbuf(lnk)) {
 			lnk->wr_rx_sges[x + 1].addr =
 					lnk->wr_rx_v2_dma_addr + SMC_WR_TX_SIZE;
 			lnk->wr_rx_sges[x + 1].length =
@@ -624,7 +624,7 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 		}
 		lnk->wr_rx_ibs[i].next = NULL;
 		lnk->wr_rx_ibs[i].sg_list = &lnk->wr_rx_sges[x];
-		lnk->wr_rx_ibs[i].num_sge = sges_per_buf;
+		lnk->wr_rx_ibs[i].num_sge = lnk->wr_rx_sge_cnt;
 	}
 	lnk->wr_reg.wr.next = NULL;
 	lnk->wr_reg.wr.num_sge = 0;
@@ -655,7 +655,7 @@ void smc_wr_free_link(struct smc_link *lnk)
 
 	if (lnk->wr_rx_dma_addr) {
 		ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
-				    SMC_WR_BUF_SIZE * lnk->wr_rx_cnt,
+				    lnk->wr_rx_buflen * lnk->wr_rx_cnt,
 				    DMA_FROM_DEVICE);
 		lnk->wr_rx_dma_addr = 0;
 	}
@@ -740,13 +740,11 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
 
 int smc_wr_alloc_link_mem(struct smc_link *link)
 {
-	int sges_per_buf = link->lgr->smc_version == SMC_V2 ? 2 : 1;
-
 	/* allocate link related memory */
 	link->wr_tx_bufs = kcalloc(SMC_WR_BUF_CNT, SMC_WR_BUF_SIZE, GFP_KERNEL);
 	if (!link->wr_tx_bufs)
 		goto no_mem;
-	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, SMC_WR_BUF_SIZE,
+	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
 				   GFP_KERNEL);
 	if (!link->wr_rx_bufs)
 		goto no_mem_wr_tx_bufs;
@@ -774,7 +772,7 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
 	if (!link->wr_tx_sges)
 		goto no_mem_wr_tx_rdma_sges;
 	link->wr_rx_sges = kcalloc(SMC_WR_BUF_CNT * 3,
-				   sizeof(link->wr_rx_sges[0]) * sges_per_buf,
+				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
 				   GFP_KERNEL);
 	if (!link->wr_rx_sges)
 		goto no_mem_wr_tx_sges;
@@ -872,7 +870,7 @@ int smc_wr_create_link(struct smc_link *lnk)
 	smc_wr_tx_set_wr_id(&lnk->wr_tx_id, 0);
 	lnk->wr_rx_id = 0;
 	lnk->wr_rx_dma_addr = ib_dma_map_single(
-		ibdev, lnk->wr_rx_bufs,	SMC_WR_BUF_SIZE * lnk->wr_rx_cnt,
+		ibdev, lnk->wr_rx_bufs,	lnk->wr_rx_buflen * lnk->wr_rx_cnt,
 		DMA_FROM_DEVICE);
 	if (ib_dma_mapping_error(ibdev, lnk->wr_rx_dma_addr)) {
 		lnk->wr_rx_dma_addr = 0;
@@ -880,13 +878,15 @@ int smc_wr_create_link(struct smc_link *lnk)
 		goto out;
 	}
 	if (lnk->lgr->smc_version == SMC_V2) {
-		lnk->wr_rx_v2_dma_addr = ib_dma_map_single(ibdev,
-			lnk->lgr->wr_rx_buf_v2, SMC_WR_BUF_V2_SIZE,
-			DMA_FROM_DEVICE);
-		if (ib_dma_mapping_error(ibdev, lnk->wr_rx_v2_dma_addr)) {
-			lnk->wr_rx_v2_dma_addr = 0;
-			rc = -EIO;
-			goto dma_unmap;
+		if (smc_link_shared_v2_rxbuf(lnk)) {
+			lnk->wr_rx_v2_dma_addr =
+				ib_dma_map_single(ibdev, lnk->lgr->wr_rx_buf_v2,
+						  SMC_WR_BUF_V2_SIZE, DMA_FROM_DEVICE);
+			if (ib_dma_mapping_error(ibdev, lnk->wr_rx_v2_dma_addr)) {
+				lnk->wr_rx_v2_dma_addr = 0;
+				rc = -EIO;
+				goto dma_unmap;
+			}
 		}
 		lnk->wr_tx_v2_dma_addr = ib_dma_map_single(ibdev,
 			lnk->lgr->wr_tx_buf_v2, SMC_WR_BUF_V2_SIZE,
@@ -935,7 +935,7 @@ int smc_wr_create_link(struct smc_link *lnk)
 		lnk->wr_tx_v2_dma_addr = 0;
 	}
 	ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
-			    SMC_WR_BUF_SIZE * lnk->wr_rx_cnt,
+			    lnk->wr_rx_buflen * lnk->wr_rx_cnt,
 			    DMA_FROM_DEVICE);
 	lnk->wr_rx_dma_addr = 0;
 out:
-- 
2.24.3 (Apple Git-128)


