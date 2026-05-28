Return-Path: <linux-rdma+bounces-21424-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPRZCM8EGGqdZggAu9opvQ
	(envelope-from <linux-rdma+bounces-21424-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 11:03:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CD5EF240
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042A630B6F22
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34A38AC7C;
	Thu, 28 May 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SwiXCPId"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EF38A725;
	Thu, 28 May 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958435; cv=none; b=KcMxYO4XgSI6Ni0ozQ5xbpuk/GdH61R8GKeBy6DMl07NBwBvwlo9wgNyUNmBa2IizNwNIIfY0v+HTWaEac34RXEz88Ec4b4kSLPz02xV+//9Ak1f9RCkfKobx5JJl6nL+RySa/efc6T/wrwmXetFPBWv3K5X7OXAzF0Ua1ny2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958435; c=relaxed/simple;
	bh=+aV3xWkEw04qtEHwwqa5Y8i1gaXuIGBmAGw6cO9qTT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7rBq2iI+Y3qVRBZa2f8yl7b/7BPvu9dwi18JgJqiUEZcrqV0V6ASe3NxNX0WoPgDPWpl2Xf/fTQzEcl8ZMZPNW/hmZ2egjF+OjmVT4HwRdNLFJIuWMCM97FpzRy3S2DiLKFPepa3tp7qiTl6U9gye8WHRh6NcARMF3VbGLMvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SwiXCPId; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779958429; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VGush9br+zbPsc3lMpy23N2rxgJCIB3spGMusrtWOOI=;
	b=SwiXCPIdj/9J9TfTCVMRMjFpNRFra+ibrltzCGmBebVgt3jr0kAUT4839i6/EKKuClKtleEXYeJ9dVjOT6pTAPXg534eGBLSy/PYSRrX4Nqp7VSHvWLVm8Luu8yU0yXtlpiupDbx7Gvta8OFFsBocNu7c+eEspFQVfCBRI1O70k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3lvM2G_1779958104;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X3lvM2G_1779958104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 16:48:24 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 1/2] net/smc: transition to RDMA core CQ pooling
Date: Thu, 28 May 2026 16:48:18 +0800
Message-ID: <20260528084819.6059-2-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260528084819.6059-1-alibuda@linux.alibaba.com>
References: <20260528084819.6059-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21424-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,nvidia.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 599CD5EF240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current SMC-R implementation relies on global per-device CQs
and manual polling within tasklets, which introduces severe
scalability bottlenecks due to global lock contention and tasklet
scheduling overhead, resulting in poor performance as concurrency
increases.

Refactor the completion handling to utilize the ib_cqe API and
standard RDMA core CQ pooling. This transition provides several key
advantages:

1. Multi-CQ: Shift from a single shared per-device CQ to multiple
link-specific CQs via the CQ pool. This allows completion processing
to be parallelized across multiple CPU cores, effectively eliminating
the global CQ bottleneck.

2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
enables Dynamic Interrupt Moderation from the RDMA core, optimizing
interrupt frequency and reducing CPU load under high pressure.

3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
using container_of() on the embedded ib_cqe.

4. Code Simplification: This refactoring results in a reduction of
~150 lines of code. It removes redundant sequence tracking, complex lookup
helpers, and manual CQ management, significantly improving maintainability.

Performance Test: redis-benchmark with max 32 connections per QP
Data format: Requests Per Second (RPS), Percentage in brackets
represents the gain/loss compared to TCP.

| Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
|---------|----------|---------------------|---------------------|
| c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
| c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
| c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
| c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
| c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
| c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
| c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
| c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |

The results demonstrate that this optimization effectively resolves the
scalability bottleneck, with RPS increasing by over 110% at c=64
compared to the original implementation.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/smc/smc_core.c |   9 +-
 net/smc/smc_core.h |  28 ++--
 net/smc/smc_ib.c   | 113 +++++-----------
 net/smc/smc_ib.h   |   7 -
 net/smc/smc_tx.c   |   1 -
 net/smc/smc_wr.c   | 324 ++++++++++++++++++---------------------------
 net/smc/smc_wr.h   |  40 ++----
 7 files changed, 196 insertions(+), 326 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index cf6b620fef05..1c6c1340f12b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -815,17 +815,11 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->lgr = lgr;
 	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
 	lnk->link_idx = link_idx;
-	lnk->wr_rx_id_compl = 0;
 	smc_ibdev_cnt_inc(lnk);
 	smcr_copy_dev_info_to_link(lnk);
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
 	INIT_WORK(&lnk->link_down_wrk, smc_link_down_work);
-	if (!lnk->smcibdev->initialized) {
-		rc = (int)smc_ib_setup_per_ibdev(lnk->smcibdev);
-		if (rc)
-			goto out;
-	}
 	get_random_bytes(rndvec, sizeof(rndvec));
 	lnk->psn_initial = rndvec[0] + (rndvec[1] << 8) +
 		(rndvec[2] << 16);
@@ -863,6 +857,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	if (rc)
 		goto free_link_mem;
 	lnk->state = SMC_LNK_ACTIVATING;
+	smc_wr_init_cqes(lnk);
 	return 0;
 
 free_link_mem:
@@ -1373,7 +1368,7 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
 	smc_llc_link_clear(lnk, log);
 	smcr_buf_unmap_lgr(lnk);
 	smcr_rtoken_clear_link(lnk);
-	smc_ib_modify_qp_error(lnk);
+	smc_wr_drain_qp(lnk);
 	smc_wr_free_link(lnk);
 	smc_ib_destroy_queue_pair(lnk);
 	smc_ib_dealloc_protection_domain(lnk);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 5c18f08a4c8a..f98c0f0cb14b 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -89,8 +89,21 @@ struct smc_rdma_sges {				/* sges per message send */
 struct smc_rdma_wr {				/* work requests per message
 						 * send
 						 */
+	struct ib_cqe		cqe;
 	struct ib_rdma_wr	wr_tx_rdma[SMC_MAX_RDMA_WRITES];
-};
+} ____cacheline_aligned_in_smp;
+
+struct smc_ib_recv_wr {
+	struct ib_cqe		cqe;
+	struct ib_recv_wr	wr;
+	int idx;
+} ____cacheline_aligned_in_smp;
+
+struct smc_ib_send_wr {
+	struct ib_cqe		cqe;
+	struct ib_send_wr	wr;
+	int idx;
+} ____cacheline_aligned_in_smp;
 
 #define SMC_LGR_ID_SIZE		4
 
@@ -100,23 +113,24 @@ struct smc_link {
 	struct ib_pd		*roce_pd;	/* IB protection domain,
 						 * unique for every RoCE QP
 						 */
+	unsigned int		nr_cqe;		/* number of CQ entries */
+	struct ib_cq		*ib_cq;		/* IB completion queue */
 	struct ib_qp		*roce_qp;	/* IB queue pair */
 	struct ib_qp_attr	qp_attr;	/* IB queue pair attributes */
 
 	struct smc_wr_buf	*wr_tx_bufs;	/* WR send payload buffers */
-	struct ib_send_wr	*wr_tx_ibs;	/* WR send meta data */
+	struct smc_ib_send_wr	*wr_tx_ibs;	/* WR send meta data */
 	struct ib_sge		*wr_tx_sges;	/* WR send gather meta data */
 	struct smc_rdma_sges	*wr_tx_rdma_sges;/*RDMA WRITE gather meta data*/
 	struct smc_rdma_wr	*wr_tx_rdmas;	/* WR RDMA WRITE */
 	struct smc_wr_tx_pend	*wr_tx_pends;	/* WR send waiting for CQE */
 	struct completion	*wr_tx_compl;	/* WR send CQE completion */
 	/* above four vectors have wr_tx_cnt elements and use the same index */
-	struct ib_send_wr	*wr_tx_v2_ib;	/* WR send v2 meta data */
+	struct smc_ib_send_wr	*wr_tx_v2_ib;	/* WR send v2 meta data */
 	struct ib_sge		*wr_tx_v2_sge;	/* WR send v2 gather meta data*/
 	struct smc_wr_tx_pend	*wr_tx_v2_pend;	/* WR send v2 waiting for CQE */
 	dma_addr_t		wr_tx_dma_addr;	/* DMA address of wr_tx_bufs */
 	dma_addr_t		wr_tx_v2_dma_addr; /* DMA address of v2 tx buf*/
-	atomic_long_t		wr_tx_id;	/* seq # of last sent WR */
 	unsigned long		*wr_tx_mask;	/* bit mask of used indexes */
 	u32			wr_tx_cnt;	/* number of WR send buffers */
 	wait_queue_head_t	wr_tx_wait;	/* wait for free WR send buf */
@@ -126,7 +140,7 @@ struct smc_link {
 	struct completion	tx_ref_comp;
 
 	u8			*wr_rx_bufs;	/* WR recv payload buffers */
-	struct ib_recv_wr	*wr_rx_ibs;	/* WR recv meta data */
+	struct smc_ib_recv_wr	*wr_rx_ibs;	/* WR recv meta data */
 	struct ib_sge		*wr_rx_sges;	/* WR recv scatter meta data */
 	/* above three vectors have wr_rx_cnt elements and use the same index */
 	int			wr_rx_sge_cnt; /* rx sge, V1 is 1, V2 is either 2 or 1 */
@@ -135,13 +149,11 @@ struct smc_link {
 						 */
 	dma_addr_t		wr_rx_dma_addr;	/* DMA address of wr_rx_bufs */
 	dma_addr_t		wr_rx_v2_dma_addr; /* DMA address of v2 rx buf*/
-	u64			wr_rx_id;	/* seq # of last recv WR */
-	u64			wr_rx_id_compl; /* seq # of last completed WR */
 	u32			wr_rx_cnt;	/* number of WR recv buffers */
 	unsigned long		wr_rx_tstamp;	/* jiffies when last buf rx */
-	wait_queue_head_t       wr_rx_empty_wait; /* wait for RQ empty */
 
 	struct ib_reg_wr	wr_reg;		/* WR register memory region */
+	struct ib_cqe		wr_reg_cqe;	/* ib_cqe for wr_reg */
 	wait_queue_head_t	wr_reg_wait;	/* wait for wr_reg result */
 	struct {
 		struct percpu_ref	wr_reg_refs;
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9bb495707445..a6d6b81830d3 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -111,15 +111,6 @@ int smc_ib_modify_qp_rts(struct smc_link *lnk)
 			    IB_QP_MAX_QP_RD_ATOMIC);
 }
 
-int smc_ib_modify_qp_error(struct smc_link *lnk)
-{
-	struct ib_qp_attr qp_attr;
-
-	memset(&qp_attr, 0, sizeof(qp_attr));
-	qp_attr.qp_state = IB_QPS_ERR;
-	return ib_modify_qp(lnk->roce_qp, &qp_attr, IB_QP_STATE);
-}
-
 int smc_ib_ready_link(struct smc_link *lnk)
 {
 	struct smc_link_group *lgr = smc_get_lgr(lnk);
@@ -133,10 +124,7 @@ int smc_ib_ready_link(struct smc_link *lnk)
 	if (rc)
 		goto out;
 	smc_wr_remember_qp_attr(lnk);
-	rc = ib_req_notify_cq(lnk->smcibdev->roce_cq_recv,
-			      IB_CQ_SOLICITED_MASK);
-	if (rc)
-		goto out;
+
 	rc = smc_wr_rx_post_init(lnk);
 	if (rc)
 		goto out;
@@ -657,38 +645,59 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk)
 	if (lnk->roce_qp)
 		ib_destroy_qp(lnk->roce_qp);
 	lnk->roce_qp = NULL;
+	if (lnk->ib_cq) {
+		ib_cq_pool_put(lnk->ib_cq, lnk->nr_cqe);
+		lnk->ib_cq = NULL;
+	}
 }
 
 /* create a queue pair within the protection domain for a link */
 int smc_ib_create_queue_pair(struct smc_link *lnk)
 {
+	int max_send_wr, max_recv_wr, rc;
+	struct ib_cq *cq;
+
+	/* include unsolicited rdma_writes as well,
+	 * there are max. 2 RDMA_WRITE per 1 WR_SEND.
+	 */
+	max_send_wr = 3 * lnk->lgr->max_send_wr + 1;	/* +1 for ib_drain_sq() */
+	max_recv_wr = lnk->lgr->max_recv_wr + 1;	/* +1 for ib_drain_rq() */
+
+	cq = ib_cq_pool_get(lnk->smcibdev->ibdev, max_send_wr + max_recv_wr, -1,
+			    IB_POLL_SOFTIRQ);
+
+	if (IS_ERR(cq)) {
+		rc = PTR_ERR(cq);
+		return rc;
+	}
+
 	struct ib_qp_init_attr qp_attr = {
 		.event_handler = smc_ib_qp_event_handler,
 		.qp_context = lnk,
-		.send_cq = lnk->smcibdev->roce_cq_send,
-		.recv_cq = lnk->smcibdev->roce_cq_recv,
+		.send_cq = cq,
+		.recv_cq = cq,
 		.srq = NULL,
 		.cap = {
 			.max_send_sge = SMC_IB_MAX_SEND_SGE,
 			.max_recv_sge = lnk->wr_rx_sge_cnt,
+			.max_send_wr = max_send_wr,
+			.max_recv_wr = max_recv_wr,
 			.max_inline_data = 0,
 		},
 		.sq_sig_type = IB_SIGNAL_REQ_WR,
 		.qp_type = IB_QPT_RC,
 	};
-	int rc;
 
-	/* include unsolicited rdma_writes as well,
-	 * there are max. 2 RDMA_WRITE per 1 WR_SEND
-	 */
-	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
-	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;
 	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
 	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
-	if (IS_ERR(lnk->roce_qp))
+	if (IS_ERR(lnk->roce_qp)) {
 		lnk->roce_qp = NULL;
-	else
+		ib_cq_pool_put(cq, max_send_wr + max_recv_wr);
+	} else {
 		smc_wr_remember_qp_attr(lnk);
+		lnk->nr_cqe = max_send_wr + max_recv_wr;
+		lnk->ib_cq = cq;
+	}
 	return rc;
 }
 
@@ -838,62 +847,6 @@ void smc_ib_buf_unmap_sg(struct smc_link *lnk,
 	buf_slot->sgt[lnk->link_idx].sgl->dma_address = 0;
 }
 
-long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
-{
-	struct ib_cq_init_attr cqattr =	{
-		.cqe = SMC_MAX_CQE, .comp_vector = 0 };
-	int cqe_size_order, smc_order;
-	long rc;
-
-	mutex_lock(&smcibdev->mutex);
-	rc = 0;
-	if (smcibdev->initialized)
-		goto out;
-	/* the calculated number of cq entries fits to mlx5 cq allocation */
-	cqe_size_order = cache_line_size() == 128 ? 7 : 6;
-	smc_order = MAX_PAGE_ORDER - cqe_size_order;
-	if (SMC_MAX_CQE + 2 > (0x00000001 << smc_order) * PAGE_SIZE)
-		cqattr.cqe = (0x00000001 << smc_order) * PAGE_SIZE - 2;
-	smcibdev->roce_cq_send = ib_create_cq(smcibdev->ibdev,
-					      smc_wr_tx_cq_handler, NULL,
-					      smcibdev, &cqattr);
-	rc = PTR_ERR_OR_ZERO(smcibdev->roce_cq_send);
-	if (IS_ERR(smcibdev->roce_cq_send)) {
-		smcibdev->roce_cq_send = NULL;
-		goto out;
-	}
-	smcibdev->roce_cq_recv = ib_create_cq(smcibdev->ibdev,
-					      smc_wr_rx_cq_handler, NULL,
-					      smcibdev, &cqattr);
-	rc = PTR_ERR_OR_ZERO(smcibdev->roce_cq_recv);
-	if (IS_ERR(smcibdev->roce_cq_recv)) {
-		smcibdev->roce_cq_recv = NULL;
-		goto err;
-	}
-	smc_wr_add_dev(smcibdev);
-	smcibdev->initialized = 1;
-	goto out;
-
-err:
-	ib_destroy_cq(smcibdev->roce_cq_send);
-out:
-	mutex_unlock(&smcibdev->mutex);
-	return rc;
-}
-
-static void smc_ib_cleanup_per_ibdev(struct smc_ib_device *smcibdev)
-{
-	mutex_lock(&smcibdev->mutex);
-	if (!smcibdev->initialized)
-		goto out;
-	smcibdev->initialized = 0;
-	ib_destroy_cq(smcibdev->roce_cq_recv);
-	ib_destroy_cq(smcibdev->roce_cq_send);
-	smc_wr_remove_dev(smcibdev);
-out:
-	mutex_unlock(&smcibdev->mutex);
-}
-
 static struct ib_client smc_ib_client;
 
 static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
@@ -952,7 +905,6 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 	INIT_WORK(&smcibdev->port_event_work, smc_ib_port_event_work);
 	atomic_set(&smcibdev->lnk_cnt, 0);
 	init_waitqueue_head(&smcibdev->lnks_deleted);
-	mutex_init(&smcibdev->mutex);
 	mutex_lock(&smc_ib_devices.mutex);
 	list_add_tail(&smcibdev->list, &smc_ib_devices.list);
 	mutex_unlock(&smc_ib_devices.mutex);
@@ -1001,7 +953,6 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 	pr_warn_ratelimited("smc: removing ib device %s\n",
 			    smcibdev->ibdev->name);
 	smc_smcr_terminate_all(smcibdev);
-	smc_ib_cleanup_per_ibdev(smcibdev);
 	ib_unregister_event_handler(&smcibdev->event_handler);
 	cancel_work_sync(&smcibdev->port_event_work);
 	kfree(smcibdev);
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index ef8ac2b7546d..a75fe8bcef3a 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -37,17 +37,12 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	struct ib_device	*ibdev;
 	struct ib_port_attr	pattr[SMC_MAX_PORTS];	/* ib dev. port attrs */
 	struct ib_event_handler	event_handler;	/* global ib_event handler */
-	struct ib_cq		*roce_cq_send;	/* send completion queue */
-	struct ib_cq		*roce_cq_recv;	/* recv completion queue */
-	struct tasklet_struct	send_tasklet;	/* called by send cq handler */
-	struct tasklet_struct	recv_tasklet;	/* called by recv cq handler */
 	char			mac[SMC_MAX_PORTS][ETH_ALEN];
 						/* mac address per port*/
 	u8			pnetid[SMC_MAX_PORTS][SMC_MAX_PNETID_LEN];
 						/* pnetid per port */
 	bool			pnetid_by_user[SMC_MAX_PORTS];
 						/* pnetid defined by user? */
-	u8			initialized : 1; /* ib dev CQ, evthdl done */
 	struct work_struct	port_event_work;
 	unsigned long		port_event_mask;
 	DECLARE_BITMAP(ports_going_away, SMC_MAX_PORTS);
@@ -96,8 +91,6 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk);
 int smc_ib_create_queue_pair(struct smc_link *lnk);
 int smc_ib_ready_link(struct smc_link *lnk);
 int smc_ib_modify_qp_rts(struct smc_link *lnk);
-int smc_ib_modify_qp_error(struct smc_link *lnk);
-long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev);
 int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
 			     struct smc_buf_desc *buf_slot, u8 link_idx);
 void smc_ib_put_memory_region(struct ib_mr *mr);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3144b4b1fe29..d301df9ed58b 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -321,7 +321,6 @@ static int smc_tx_rdma_write(struct smc_connection *conn, int peer_rmbe_offset,
 	struct smc_link *link = conn->lnk;
 	int rc;
 
-	rdma_wr->wr.wr_id = smc_wr_tx_get_next_wr_id(link);
 	rdma_wr->wr.num_sge = num_sges;
 	rdma_wr->remote_addr =
 		lgr->rtokens[conn->rtoken_idx][link->link_idx].dma_addr +
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 59c92b46945c..130bc6c26fb3 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -31,14 +31,11 @@
 #include "smc.h"
 #include "smc_wr.h"
 
-#define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
-
 #define SMC_WR_RX_HASH_BITS 4
 static DEFINE_HASHTABLE(smc_wr_rx_hash, SMC_WR_RX_HASH_BITS);
 static DEFINE_SPINLOCK(smc_wr_rx_hash_lock);
 
 struct smc_wr_tx_pend {	/* control data for a pending send request */
-	u64			wr_id;		/* work request id sent */
 	smc_wr_tx_handler	handler;
 	enum ib_wc_status	wc_status;	/* CQE status */
 	struct smc_link		*link;
@@ -63,109 +60,67 @@ void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
 	wait_event(link->wr_tx_wait, !smc_wr_is_tx_pend(link));
 }
 
-static inline int smc_wr_tx_find_pending_index(struct smc_link *link, u64 wr_id)
+static void smc_wr_tx_rdma_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
 {
-	u32 i;
+	struct smc_link *link = wc->qp->qp_context;
 
-	for (i = 0; i < link->wr_tx_cnt; i++) {
-		if (link->wr_tx_pends[i].wr_id == wr_id)
-			return i;
-	}
-	return link->wr_tx_cnt;
+	/* terminate link */
+	if (wc->status)
+		smcr_link_down_cond_sched(link);
+}
+
+static void smc_wr_reg_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct smc_link *link = wc->qp->qp_context;
+
+	if (wc->status)
+		link->wr_reg_state = FAILED;
+	else
+		link->wr_reg_state = CONFIRMED;
+	smc_wr_wakeup_reg_wait(link);
 }
 
-static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
+static void smc_wr_tx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct smc_wr_tx_pend pnd_snd;
+	struct smc_wr_tx_pend *tx_pend, pnd_snd;
+	struct smc_ib_send_wr *send_wr;
 	struct smc_link *link;
 	u32 pnd_snd_idx;
 
+	/* ib_drain_qp() is called before link free, so link is safe here */
 	link = wc->qp->qp_context;
 
-	if (wc->opcode == IB_WC_REG_MR) {
-		if (wc->status)
-			link->wr_reg_state = FAILED;
-		else
-			link->wr_reg_state = CONFIRMED;
-		smc_wr_wakeup_reg_wait(link);
-		return;
-	}
+	send_wr = container_of(wc->wr_cqe, struct smc_ib_send_wr, cqe);
+	pnd_snd_idx = send_wr->idx;
+
+	tx_pend = (pnd_snd_idx == link->wr_tx_cnt) ? link->wr_tx_v2_pend :
+		&link->wr_tx_pends[pnd_snd_idx];
+
+	tx_pend->wc_status = wc->status;
+	memcpy(&pnd_snd, tx_pend, sizeof(pnd_snd));
+	/* clear the full struct smc_wr_tx_pend including .priv */
+	memset(tx_pend, 0, sizeof(*tx_pend));
 
-	pnd_snd_idx = smc_wr_tx_find_pending_index(link, wc->wr_id);
 	if (pnd_snd_idx == link->wr_tx_cnt) {
-		if (link->lgr->smc_version != SMC_V2 ||
-		    link->wr_tx_v2_pend->wr_id != wc->wr_id)
-			return;
-		link->wr_tx_v2_pend->wc_status = wc->status;
-		memcpy(&pnd_snd, link->wr_tx_v2_pend, sizeof(pnd_snd));
-		/* clear the full struct smc_wr_tx_pend including .priv */
-		memset(link->wr_tx_v2_pend, 0,
-		       sizeof(*link->wr_tx_v2_pend));
 		memset(link->lgr->wr_tx_buf_v2, 0,
 		       sizeof(*link->lgr->wr_tx_buf_v2));
 	} else {
-		link->wr_tx_pends[pnd_snd_idx].wc_status = wc->status;
-		if (link->wr_tx_pends[pnd_snd_idx].compl_requested)
+		if (pnd_snd.compl_requested)
 			complete(&link->wr_tx_compl[pnd_snd_idx]);
-		memcpy(&pnd_snd, &link->wr_tx_pends[pnd_snd_idx],
-		       sizeof(pnd_snd));
-		/* clear the full struct smc_wr_tx_pend including .priv */
-		memset(&link->wr_tx_pends[pnd_snd_idx], 0,
-		       sizeof(link->wr_tx_pends[pnd_snd_idx]));
 		memset(&link->wr_tx_bufs[pnd_snd_idx], 0,
 		       sizeof(link->wr_tx_bufs[pnd_snd_idx]));
 		if (!test_and_clear_bit(pnd_snd_idx, link->wr_tx_mask))
 			return;
 	}
 
-	if (wc->status) {
-		if (link->lgr->smc_version == SMC_V2) {
-			memset(link->wr_tx_v2_pend, 0,
-			       sizeof(*link->wr_tx_v2_pend));
-			memset(link->lgr->wr_tx_buf_v2, 0,
-			       sizeof(*link->lgr->wr_tx_buf_v2));
-		}
-		/* terminate link */
+	/* terminate link */
+	if (wc->status)
 		smcr_link_down_cond_sched(link);
-	}
 	if (pnd_snd.handler)
 		pnd_snd.handler(&pnd_snd.priv, link, wc->status);
 	wake_up(&link->wr_tx_wait);
 }
 
-static void smc_wr_tx_tasklet_fn(struct tasklet_struct *t)
-{
-	struct smc_ib_device *dev = from_tasklet(dev, t, send_tasklet);
-	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
-	int i = 0, rc;
-	int polled = 0;
-
-again:
-	polled++;
-	do {
-		memset(&wc, 0, sizeof(wc));
-		rc = ib_poll_cq(dev->roce_cq_send, SMC_WR_MAX_POLL_CQE, wc);
-		if (polled == 1) {
-			ib_req_notify_cq(dev->roce_cq_send,
-					 IB_CQ_NEXT_COMP |
-					 IB_CQ_REPORT_MISSED_EVENTS);
-		}
-		if (!rc)
-			break;
-		for (i = 0; i < rc; i++)
-			smc_wr_tx_process_cqe(&wc[i]);
-	} while (rc > 0);
-	if (polled == 1)
-		goto again;
-}
-
-void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
-{
-	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
-
-	tasklet_schedule(&dev->send_tasklet);
-}
-
 /*---------------------------- request submission ---------------------------*/
 
 static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
@@ -201,8 +156,6 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 	struct smc_link_group *lgr = smc_get_lgr(link);
 	struct smc_wr_tx_pend *wr_pend;
 	u32 idx = link->wr_tx_cnt;
-	struct ib_send_wr *wr_ib;
-	u64 wr_id;
 	int rc;
 
 	*wr_buf = NULL;
@@ -226,14 +179,10 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 		if (idx == link->wr_tx_cnt)
 			return -EPIPE;
 	}
-	wr_id = smc_wr_tx_get_next_wr_id(link);
 	wr_pend = &link->wr_tx_pends[idx];
-	wr_pend->wr_id = wr_id;
 	wr_pend->handler = handler;
 	wr_pend->link = link;
 	wr_pend->idx = idx;
-	wr_ib = &link->wr_tx_ibs[idx];
-	wr_ib->wr_id = wr_id;
 	*wr_buf = &link->wr_tx_bufs[idx];
 	if (wr_rdma_buf)
 		*wr_rdma_buf = &link->wr_tx_rdmas[idx];
@@ -247,22 +196,16 @@ int smc_wr_tx_get_v2_slot(struct smc_link *link,
 			  struct smc_wr_tx_pend_priv **wr_pend_priv)
 {
 	struct smc_wr_tx_pend *wr_pend;
-	struct ib_send_wr *wr_ib;
-	u64 wr_id;
 
 	if (link->wr_tx_v2_pend->idx == link->wr_tx_cnt)
 		return -EBUSY;
 
 	*wr_buf = NULL;
 	*wr_pend_priv = NULL;
-	wr_id = smc_wr_tx_get_next_wr_id(link);
 	wr_pend = link->wr_tx_v2_pend;
-	wr_pend->wr_id = wr_id;
 	wr_pend->handler = handler;
 	wr_pend->link = link;
 	wr_pend->idx = link->wr_tx_cnt;
-	wr_ib = link->wr_tx_v2_ib;
-	wr_ib->wr_id = wr_id;
 	*wr_buf = link->lgr->wr_tx_buf_v2;
 	*wr_pend_priv = &wr_pend->priv;
 	return 0;
@@ -306,10 +249,8 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
 	struct smc_wr_tx_pend *pend;
 	int rc;
 
-	ib_req_notify_cq(link->smcibdev->roce_cq_send,
-			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
 	pend = container_of(priv, struct smc_wr_tx_pend, priv);
-	rc = ib_post_send(link->roce_qp, &link->wr_tx_ibs[pend->idx], NULL);
+	rc = ib_post_send(link->roce_qp, &link->wr_tx_ibs[pend->idx].wr, NULL);
 	if (rc) {
 		smc_wr_tx_put_slot(link, priv);
 		smcr_link_down_cond_sched(link);
@@ -322,10 +263,8 @@ int smc_wr_tx_v2_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
 {
 	int rc;
 
-	link->wr_tx_v2_ib->sg_list[0].length = len;
-	ib_req_notify_cq(link->smcibdev->roce_cq_send,
-			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
-	rc = ib_post_send(link->roce_qp, link->wr_tx_v2_ib, NULL);
+	link->wr_tx_v2_ib->wr.sg_list[0].length = len;
+	rc = ib_post_send(link->roce_qp, &link->wr_tx_v2_ib->wr, NULL);
 	if (rc) {
 		smc_wr_tx_put_slot(link, priv);
 		smcr_link_down_cond_sched(link);
@@ -367,10 +306,7 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 {
 	int rc;
 
-	ib_req_notify_cq(link->smcibdev->roce_cq_send,
-			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
 	link->wr_reg_state = POSTED;
-	link->wr_reg.wr.wr_id = (u64)(uintptr_t)mr;
 	link->wr_reg.mr = mr;
 	link->wr_reg.key = mr->rkey;
 	rc = ib_post_send(link->roce_qp, &link->wr_reg.wr, NULL);
@@ -431,94 +367,74 @@ static inline void smc_wr_rx_demultiplex(struct ib_wc *wc)
 {
 	struct smc_link *link = (struct smc_link *)wc->qp->qp_context;
 	struct smc_wr_rx_handler *handler;
+	struct smc_ib_recv_wr *recv_wr;
 	struct smc_wr_rx_hdr *wr_rx;
-	u64 temp_wr_id;
-	u32 index;
 
 	if (wc->byte_len < sizeof(*wr_rx))
 		return; /* short message */
-	temp_wr_id = wc->wr_id;
-	index = do_div(temp_wr_id, link->wr_rx_cnt);
-	wr_rx = (struct smc_wr_rx_hdr *)(link->wr_rx_bufs + index * link->wr_rx_buflen);
+
+	recv_wr = container_of(wc->wr_cqe, struct smc_ib_recv_wr, cqe);
+
+	wr_rx = (struct smc_wr_rx_hdr *)(link->wr_rx_bufs + recv_wr->idx * link->wr_rx_buflen);
 	hash_for_each_possible(smc_wr_rx_hash, handler, list, wr_rx->type) {
 		if (handler->type == wr_rx->type)
 			handler->handler(wc, wr_rx);
 	}
 }
 
-static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
+static void smc_wr_rx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct smc_link *link;
-	int i;
+	struct smc_link *link = wc->qp->qp_context;
 
-	for (i = 0; i < num; i++) {
-		link = wc[i].qp->qp_context;
-		link->wr_rx_id_compl = wc[i].wr_id;
-		if (wc[i].status == IB_WC_SUCCESS) {
-			link->wr_rx_tstamp = jiffies;
-			smc_wr_rx_demultiplex(&wc[i]);
-			smc_wr_rx_post(link); /* refill WR RX */
-		} else {
-			/* handle status errors */
-			switch (wc[i].status) {
-			case IB_WC_RETRY_EXC_ERR:
-			case IB_WC_RNR_RETRY_EXC_ERR:
-			case IB_WC_WR_FLUSH_ERR:
-				smcr_link_down_cond_sched(link);
-				if (link->wr_rx_id_compl == link->wr_rx_id)
-					wake_up(&link->wr_rx_empty_wait);
-				break;
-			default:
-				smc_wr_rx_post(link); /* refill WR RX */
-				break;
-			}
+	if (wc->status == IB_WC_SUCCESS) {
+		link->wr_rx_tstamp = jiffies;
+		smc_wr_rx_demultiplex(wc);
+		smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
+	} else {
+		/* handle status errors */
+		switch (wc->status) {
+		case IB_WC_RETRY_EXC_ERR:
+		case IB_WC_RNR_RETRY_EXC_ERR:
+		case IB_WC_WR_FLUSH_ERR:
+			smcr_link_down_cond_sched(link);
+			break;
+		default:
+			smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
+			break;
 		}
 	}
 }
 
-static void smc_wr_rx_tasklet_fn(struct tasklet_struct *t)
+int smc_wr_rx_post_init(struct smc_link *link)
 {
-	struct smc_ib_device *dev = from_tasklet(dev, t, recv_tasklet);
-	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
-	int polled = 0;
-	int rc;
+	int i, rc = 0;
 
-again:
-	polled++;
-	do {
-		memset(&wc, 0, sizeof(wc));
-		rc = ib_poll_cq(dev->roce_cq_recv, SMC_WR_MAX_POLL_CQE, wc);
-		if (polled == 1) {
-			ib_req_notify_cq(dev->roce_cq_recv,
-					 IB_CQ_SOLICITED_MASK
-					 | IB_CQ_REPORT_MISSED_EVENTS);
-		}
-		if (!rc)
-			break;
-		smc_wr_rx_process_cqes(&wc[0], rc);
-	} while (rc > 0);
-	if (polled == 1)
-		goto again;
+	for (i = 0; i < link->wr_rx_cnt; i++)
+		rc = smc_wr_rx_post(link, &link->wr_rx_ibs[i].cqe);
+	return rc;
 }
 
-void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
-{
-	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
+/***************************** init, exit, misc ******************************/
 
-	tasklet_schedule(&dev->recv_tasklet);
+static void smc_wr_reg_init_cqe(struct ib_cqe *cqe)
+{
+	cqe->done = smc_wr_reg_process_cqe;
 }
 
-int smc_wr_rx_post_init(struct smc_link *link)
+static void smc_wr_tx_init_cqe(struct ib_cqe *cqe)
 {
-	u32 i;
-	int rc = 0;
+	cqe->done = smc_wr_tx_process_cqe;
+}
 
-	for (i = 0; i < link->wr_rx_cnt; i++)
-		rc = smc_wr_rx_post(link);
-	return rc;
+static void smc_wr_rx_init_cqe(struct ib_cqe *cqe)
+{
+	cqe->done = smc_wr_rx_process_cqe;
 }
 
-/***************************** init, exit, misc ******************************/
+static void smc_wr_tx_rdma_init_cqe(struct ib_cqe *cqe)
+{
+	cqe->done = smc_wr_tx_rdma_process_cqe;
+}
 
 void smc_wr_remember_qp_attr(struct smc_link *lnk)
 {
@@ -550,7 +466,7 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
 			       lnk->qp_attr.cap.max_send_wr);
 	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
-			       lnk->qp_attr.cap.max_recv_wr);
+			       lnk->qp_attr.cap.max_recv_wr - 1);	/* -1 for ib_drain_rq() */
 }
 
 static void smc_wr_init_sge(struct smc_link *lnk)
@@ -571,14 +487,14 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 			lnk->roce_pd->local_dma_lkey;
 		lnk->wr_tx_rdma_sges[i].tx_rdma_sge[1].wr_tx_rdma_sge[1].lkey =
 			lnk->roce_pd->local_dma_lkey;
-		lnk->wr_tx_ibs[i].next = NULL;
-		lnk->wr_tx_ibs[i].sg_list = &lnk->wr_tx_sges[i];
-		lnk->wr_tx_ibs[i].num_sge = 1;
-		lnk->wr_tx_ibs[i].opcode = IB_WR_SEND;
-		lnk->wr_tx_ibs[i].send_flags =
+		lnk->wr_tx_ibs[i].wr.next = NULL;
+		lnk->wr_tx_ibs[i].wr.sg_list = &lnk->wr_tx_sges[i];
+		lnk->wr_tx_ibs[i].wr.num_sge = 1;
+		lnk->wr_tx_ibs[i].wr.opcode = IB_WR_SEND;
+		lnk->wr_tx_ibs[i].wr.send_flags =
 			IB_SEND_SIGNALED | IB_SEND_SOLICITED;
 		if (send_inline)
-			lnk->wr_tx_ibs[i].send_flags |= IB_SEND_INLINE;
+			lnk->wr_tx_ibs[i].wr.send_flags |= IB_SEND_INLINE;
 		lnk->wr_tx_rdmas[i].wr_tx_rdma[0].wr.opcode = IB_WR_RDMA_WRITE;
 		lnk->wr_tx_rdmas[i].wr_tx_rdma[1].wr.opcode = IB_WR_RDMA_WRITE;
 		lnk->wr_tx_rdmas[i].wr_tx_rdma[0].wr.sg_list =
@@ -592,11 +508,11 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 		lnk->wr_tx_v2_sge->length = SMC_WR_BUF_V2_SIZE;
 		lnk->wr_tx_v2_sge->lkey = lnk->roce_pd->local_dma_lkey;
 
-		lnk->wr_tx_v2_ib->next = NULL;
-		lnk->wr_tx_v2_ib->sg_list = lnk->wr_tx_v2_sge;
-		lnk->wr_tx_v2_ib->num_sge = 1;
-		lnk->wr_tx_v2_ib->opcode = IB_WR_SEND;
-		lnk->wr_tx_v2_ib->send_flags =
+		lnk->wr_tx_v2_ib->wr.next = NULL;
+		lnk->wr_tx_v2_ib->wr.sg_list = lnk->wr_tx_v2_sge;
+		lnk->wr_tx_v2_ib->wr.num_sge = 1;
+		lnk->wr_tx_v2_ib->wr.opcode = IB_WR_SEND;
+		lnk->wr_tx_v2_ib->wr.send_flags =
 			IB_SEND_SIGNALED | IB_SEND_SOLICITED;
 	}
 
@@ -622,10 +538,11 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 			lnk->wr_rx_sges[x + 1].lkey =
 					lnk->roce_pd->local_dma_lkey;
 		}
-		lnk->wr_rx_ibs[i].next = NULL;
-		lnk->wr_rx_ibs[i].sg_list = &lnk->wr_rx_sges[x];
-		lnk->wr_rx_ibs[i].num_sge = lnk->wr_rx_sge_cnt;
+		lnk->wr_rx_ibs[i].wr.next = NULL;
+		lnk->wr_rx_ibs[i].wr.sg_list = &lnk->wr_rx_sges[x];
+		lnk->wr_rx_ibs[i].wr.num_sge = lnk->wr_rx_sge_cnt;
 	}
+
 	lnk->wr_reg.wr.next = NULL;
 	lnk->wr_reg.wr.num_sge = 0;
 	lnk->wr_reg.wr.send_flags = IB_SEND_SIGNALED;
@@ -641,7 +558,6 @@ void smc_wr_free_link(struct smc_link *lnk)
 		return;
 	ibdev = lnk->smcibdev->ibdev;
 
-	smc_wr_drain_cq(lnk);
 	smc_wr_wakeup_reg_wait(lnk);
 	smc_wr_wakeup_tx_wait(lnk);
 
@@ -826,18 +742,6 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
 	return -ENOMEM;
 }
 
-void smc_wr_remove_dev(struct smc_ib_device *smcibdev)
-{
-	tasklet_kill(&smcibdev->recv_tasklet);
-	tasklet_kill(&smcibdev->send_tasklet);
-}
-
-void smc_wr_add_dev(struct smc_ib_device *smcibdev)
-{
-	tasklet_setup(&smcibdev->recv_tasklet, smc_wr_rx_tasklet_fn);
-	tasklet_setup(&smcibdev->send_tasklet, smc_wr_tx_tasklet_fn);
-}
-
 static void smcr_wr_tx_refs_free(struct percpu_ref *ref)
 {
 	struct smc_link *lnk = container_of(ref, struct smc_link, wr_tx_refs);
@@ -857,8 +761,6 @@ int smc_wr_create_link(struct smc_link *lnk)
 	struct ib_device *ibdev = lnk->smcibdev->ibdev;
 	int rc = 0;
 
-	smc_wr_tx_set_wr_id(&lnk->wr_tx_id, 0);
-	lnk->wr_rx_id = 0;
 	lnk->wr_rx_dma_addr = ib_dma_map_single(
 		ibdev, lnk->wr_rx_bufs,	lnk->wr_rx_buflen * lnk->wr_rx_cnt,
 		DMA_FROM_DEVICE);
@@ -906,7 +808,6 @@ int smc_wr_create_link(struct smc_link *lnk)
 	if (rc)
 		goto cancel_ref;
 	init_completion(&lnk->reg_ref_comp);
-	init_waitqueue_head(&lnk->wr_rx_empty_wait);
 	return rc;
 
 cancel_ref:
@@ -931,3 +832,42 @@ int smc_wr_create_link(struct smc_link *lnk)
 out:
 	return rc;
 }
+
+void smc_wr_init_cqes(struct smc_link *lnk)
+{
+	int i;
+
+	/* init CQE for WR fast reg */
+	smc_wr_reg_init_cqe(&lnk->wr_reg_cqe);
+	lnk->wr_reg.wr.wr_cqe = &lnk->wr_reg_cqe;
+
+	/* init CQE for WR WRITE */
+	for (i = 0; i < lnk->wr_tx_cnt; i++) {
+		int n;
+
+		smc_wr_tx_rdma_init_cqe(&lnk->wr_tx_rdmas[i].cqe);
+		for (n = 0; n < SMC_MAX_RDMA_WRITES; n++)
+			lnk->wr_tx_rdmas[i].wr_tx_rdma[n].wr.wr_cqe = &lnk->wr_tx_rdmas[i].cqe;
+	}
+
+	/* init CQEs for WR RECV */
+	for (i = 0; i < lnk->wr_rx_cnt; i++) {
+		smc_wr_rx_init_cqe(&lnk->wr_rx_ibs[i].cqe);
+		lnk->wr_rx_ibs[i].wr.wr_cqe = &lnk->wr_rx_ibs[i].cqe;
+		lnk->wr_rx_ibs[i].idx = i;
+	}
+
+	/* init CQEs for WR SEND */
+	for (i = 0; i < lnk->wr_tx_cnt; i++) {
+		smc_wr_tx_init_cqe(&lnk->wr_tx_ibs[i].cqe);
+		lnk->wr_tx_ibs[i].wr.wr_cqe = &lnk->wr_tx_ibs[i].cqe;
+		lnk->wr_tx_ibs[i].idx = i;
+	}
+
+	/* init CQE for SMC-Rv2 WR SEND */
+	if (lnk->lgr->smc_version == SMC_V2) {
+		smc_wr_tx_init_cqe(&lnk->wr_tx_v2_ib->cqe);
+		lnk->wr_tx_v2_ib->wr.wr_cqe = &lnk->wr_tx_v2_ib->cqe;
+		lnk->wr_tx_v2_ib->idx = lnk->wr_tx_cnt;
+	}
+}
diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index aa4533af9122..6873b86cff90 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -44,19 +44,6 @@ struct smc_wr_rx_handler {
 	u8			type;
 };
 
-/* Only used by RDMA write WRs.
- * All other WRs (CDC/LLC) use smc_wr_tx_send handling WR_ID implicitly
- */
-static inline long smc_wr_tx_get_next_wr_id(struct smc_link *link)
-{
-	return atomic_long_inc_return(&link->wr_tx_id);
-}
-
-static inline void smc_wr_tx_set_wr_id(atomic_long_t *wr_tx_id, long val)
-{
-	atomic_long_set(wr_tx_id, val);
-}
-
 static inline bool smc_wr_tx_link_hold(struct smc_link *link)
 {
 	if (!smc_link_sendable(link))
@@ -70,9 +57,10 @@ static inline void smc_wr_tx_link_put(struct smc_link *link)
 	percpu_ref_put(&link->wr_tx_refs);
 }
 
-static inline void smc_wr_drain_cq(struct smc_link *lnk)
+static inline void smc_wr_drain_qp(struct smc_link *lnk)
 {
-	wait_event(lnk->wr_rx_empty_wait, lnk->wr_rx_id_compl == lnk->wr_rx_id);
+	if (lnk->qp_attr.cur_qp_state != IB_QPS_RESET)
+		ib_drain_qp(lnk->roce_qp);
 }
 
 static inline void smc_wr_wakeup_tx_wait(struct smc_link *lnk)
@@ -86,18 +74,12 @@ static inline void smc_wr_wakeup_reg_wait(struct smc_link *lnk)
 }
 
 /* post a new receive work request to fill a completed old work request entry */
-static inline int smc_wr_rx_post(struct smc_link *link)
+static inline int smc_wr_rx_post(struct smc_link *link, struct ib_cqe *cqe)
 {
-	int rc;
-	u64 wr_id, temp_wr_id;
-	u32 index;
-
-	wr_id = ++link->wr_rx_id; /* tasklet context, thus not atomic */
-	temp_wr_id = wr_id;
-	index = do_div(temp_wr_id, link->wr_rx_cnt);
-	link->wr_rx_ibs[index].wr_id = wr_id;
-	rc = ib_post_recv(link->roce_qp, &link->wr_rx_ibs[index], NULL);
-	return rc;
+	struct smc_ib_recv_wr *recv_wr;
+
+	recv_wr = container_of(cqe, struct smc_ib_recv_wr, cqe);
+	return ib_post_recv(link->roce_qp, &recv_wr->wr, NULL);
 }
 
 int smc_wr_create_link(struct smc_link *lnk);
@@ -107,8 +89,6 @@ void smc_wr_free_link(struct smc_link *lnk);
 void smc_wr_free_link_mem(struct smc_link *lnk);
 void smc_wr_free_lgr_mem(struct smc_link_group *lgr);
 void smc_wr_remember_qp_attr(struct smc_link *lnk);
-void smc_wr_remove_dev(struct smc_ib_device *smcibdev);
-void smc_wr_add_dev(struct smc_ib_device *smcibdev);
 
 int smc_wr_tx_get_free_slot(struct smc_link *link, smc_wr_tx_handler handler,
 			    struct smc_wr_buf **wr_buf,
@@ -126,12 +106,12 @@ int smc_wr_tx_v2_send(struct smc_link *link,
 		      struct smc_wr_tx_pend_priv *priv, int len);
 int smc_wr_tx_send_wait(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
 			unsigned long timeout);
-void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context);
 void smc_wr_tx_wait_no_pending_sends(struct smc_link *link);
 
 int smc_wr_rx_register_handler(struct smc_wr_rx_handler *handler);
 int smc_wr_rx_post_init(struct smc_link *link);
-void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context);
 int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr);
 
+void smc_wr_init_cqes(struct smc_link *lnk);
+
 #endif /* SMC_WR_H */
-- 
2.45.0


