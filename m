Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1806C50E7E4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 20:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiDYSTj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiDYSTj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 14:19:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4E3B282
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910594; x=1682446594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9HBHqCldgRDw/2FnBFmmwZTpKaxXVN5PYvtNfmMaBUA=;
  b=ICEjfrDK020pH0aOsapaoq/Vj6pjKkRLhBn4J7GcI7EfmeHp+oEKxhqU
   tuchufgGvoqXdZPKIJ4AnDtvAExbm3CGoPePHlEQdaGiqoXvHPtNTZ6bg
   VN1yOSbtQFLANNRVsIecXIZcyuMOHcvGT3pOZrQCAqjLJYrZysdMuyJxc
   z/u9tfeOgQuulFPipleXPCMhMnejZfyrQ7Q0JMBlCm8EFS67L2+kZA1Ii
   YRHWMHq51sHXRQoH2+3UjG+pnPKPiqyQ+q50HBHFV2XW2lBmz9G0IY9dq
   wpU6jNCxR6zuZ4iJthO2S+UBqGW9SNDlH7u7kgMN3/RcudNmquxSqqK1T
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325815448"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="325815448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:16:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537707953"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.50.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:16:33 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next] RDMA/irdma: Add SW mechanism to generate completions on error
Date:   Mon, 25 Apr 2022 13:16:24 -0500
Message-Id: <20220425181624.1617-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

HW flushes after QP in error state is not reliable. This can lead to
application hang waiting on a completion for outstanding WRs.
Implement a SW mechanism to generate completions for any
outstanding WR's after the QP is modified to error.

This is accomplished by starting a delayed worker after the QP is
modified to error and the HW flush is performed. The worker
will generate completions that will be returned to the application
when it polls the CQ. This mechanism only applies to Kernel
applications.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    |  31 ++++----
 drivers/infiniband/hw/irdma/utils.c | 147 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.c |  56 ++++++++------
 drivers/infiniband/hw/irdma/verbs.h |  13 +++-
 4 files changed, 210 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index ec477c4..dd3943d 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -61,7 +61,7 @@ static void irdma_iwarp_ce_handler(struct irdma_sc_cq *iwcq)
 	struct irdma_cq *cq = iwcq->back_cq;
 
 	if (!cq->user_mode)
-		cq->armed = false;
+		atomic_set(&cq->armed, 0);
 	if (cq->ibcq.comp_handler)
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
@@ -2689,24 +2689,29 @@ void irdma_flush_wqes(struct irdma_qp *iwqp, u32 flush_mask)
 	info.sq = flush_mask & IRDMA_FLUSH_SQ;
 	info.rq = flush_mask & IRDMA_FLUSH_RQ;
 
-	if (flush_mask & IRDMA_REFLUSH) {
-		if (info.sq)
-			iwqp->sc_qp.flush_sq = false;
-		if (info.rq)
-			iwqp->sc_qp.flush_rq = false;
-	}
-
 	/* Generate userflush errors in CQE */
 	info.sq_major_code = IRDMA_FLUSH_MAJOR_ERR;
 	info.sq_minor_code = FLUSH_GENERAL_ERR;
 	info.rq_major_code = IRDMA_FLUSH_MAJOR_ERR;
 	info.rq_minor_code = FLUSH_GENERAL_ERR;
 	info.userflushcode = true;
-	if (flush_code) {
-		if (info.sq && iwqp->sc_qp.sq_flush_code)
-			info.sq_minor_code = flush_code;
-		if (info.rq && iwqp->sc_qp.rq_flush_code)
-			info.rq_minor_code = flush_code;
+
+	if (flush_mask & IRDMA_REFLUSH) {
+		if (info.sq)
+			iwqp->sc_qp.flush_sq = false;
+		if (info.rq)
+			iwqp->sc_qp.flush_rq = false;
+	} else {
+		if (flush_code) {
+			if (info.sq && iwqp->sc_qp.sq_flush_code)
+				info.sq_minor_code = flush_code;
+			if (info.rq && iwqp->sc_qp.rq_flush_code)
+				info.rq_minor_code = flush_code;
+		}
+		if (!iwqp->user_mode)
+			queue_delayed_work(iwqp->iwdev->cleanup_wq,
+					   &iwqp->dwork_flush,
+					   msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 	}
 
 	/* Issue flush */
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 346c2c5..7f1526f 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2498,3 +2498,150 @@ bool irdma_cq_empty(struct irdma_cq *iwcq)
 
 	return polarity != ukcq->polarity;
 }
+
+void irdma_remove_cmpls_list(struct irdma_cq *iwcq)
+{
+	struct irdma_cmpl_gen *cmpl_node;
+	struct list_head *tmp_node, *list_node;
+
+	list_for_each_safe (list_node, tmp_node, &iwcq->cmpl_generated) {
+		cmpl_node = list_entry(list_node, struct irdma_cmpl_gen, list);
+		list_del(&cmpl_node->list);
+		kfree(cmpl_node);
+	}
+}
+
+int irdma_generated_cmpls(struct irdma_cq *iwcq, struct irdma_cq_poll_info *cq_poll_info)
+{
+	struct irdma_cmpl_gen *cmpl;
+
+	if (list_empty(&iwcq->cmpl_generated))
+		return -ENOENT;
+	cmpl = list_first_entry_or_null(&iwcq->cmpl_generated, struct irdma_cmpl_gen, list);
+	list_del(&cmpl->list);
+	memcpy(cq_poll_info, &cmpl->cpi, sizeof(*cq_poll_info));
+	kfree(cmpl);
+
+	ibdev_dbg(iwcq->ibcq.device,
+		  "VERBS: %s: Poll artificially generated completion for QP 0x%X, op %u, wr_id=0x%llx\n",
+		  __func__, cq_poll_info->qp_id, cq_poll_info->op_type,
+		  cq_poll_info->wr_id);
+
+	return 0;
+}
+
+/**
+ * irdma_set_cpi_common_values - fill in values for polling info struct
+ * @cpi: resulting structure of cq_poll_info type
+ * @qp: QPair
+ * @qp_num: id of the QP
+ */
+static void irdma_set_cpi_common_values(struct irdma_cq_poll_info *cpi,
+					struct irdma_qp_uk *qp, u32 qp_num)
+{
+	cpi->comp_status = IRDMA_COMPL_STATUS_FLUSHED;
+	cpi->error = true;
+	cpi->major_err = IRDMA_FLUSH_MAJOR_ERR;
+	cpi->minor_err = FLUSH_GENERAL_ERR;
+	cpi->qp_handle = (irdma_qp_handle)(uintptr_t)qp;
+	cpi->qp_id = qp_num;
+}
+
+static inline void irdma_comp_handler(struct irdma_cq *cq)
+{
+	if (!cq->ibcq.comp_handler)
+		return;
+	if (atomic_cmpxchg(&cq->armed, 1, 0))
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+}
+
+void irdma_generate_flush_completions(struct irdma_qp *iwqp)
+{
+	struct irdma_qp_uk *qp = &iwqp->sc_qp.qp_uk;
+	struct irdma_ring *sq_ring = &qp->sq_ring;
+	struct irdma_ring *rq_ring = &qp->rq_ring;
+	struct irdma_cmpl_gen *cmpl;
+	__le64 *sw_wqe;
+	u64 wqe_qword;
+	u32 wqe_idx;
+	bool compl_generated = false;
+	unsigned long flags1;
+
+	spin_lock_irqsave(&iwqp->iwscq->lock, flags1);
+	if (irdma_cq_empty(iwqp->iwscq)) {
+		unsigned long flags2;
+
+		spin_lock_irqsave(&iwqp->lock, flags2);
+		while (IRDMA_RING_MORE_WORK(*sq_ring)) {
+			cmpl = kzalloc(sizeof(*cmpl), GFP_ATOMIC);
+			if (!cmpl) {
+				spin_unlock_irqrestore(&iwqp->lock, flags2);
+				spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
+				return;
+			}
+
+			wqe_idx = sq_ring->tail;
+			irdma_set_cpi_common_values(&cmpl->cpi, qp, qp->qp_id);
+
+			cmpl->cpi.wr_id = qp->sq_wrtrk_array[wqe_idx].wrid;
+			sw_wqe = qp->sq_base[wqe_idx].elem;
+			get_64bit_val(sw_wqe, 24, &wqe_qword);
+			cmpl->cpi.op_type = (u8)FIELD_GET(IRDMAQPSQ_OPCODE, IRDMAQPSQ_OPCODE);
+			/* remove the SQ WR by moving SQ tail*/
+			IRDMA_RING_SET_TAIL(*sq_ring,
+				sq_ring->tail + qp->sq_wrtrk_array[sq_ring->tail].quanta);
+
+			ibdev_dbg(iwqp->iwscq->ibcq.device,
+				  "DEV: %s: adding wr_id = 0x%llx SQ Completion to list qp_id=%d\n",
+				  __func__, cmpl->cpi.wr_id, qp->qp_id);
+			list_add_tail(&cmpl->list, &iwqp->iwscq->cmpl_generated);
+			compl_generated = true;
+		}
+		spin_unlock_irqrestore(&iwqp->lock, flags2);
+		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
+		if (compl_generated)
+			irdma_comp_handler(iwqp->iwrcq);
+	} else {
+		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
+		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
+				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
+	}
+
+	spin_lock_irqsave(&iwqp->iwrcq->lock, flags1);
+	if (irdma_cq_empty(iwqp->iwrcq)) {
+		unsigned long flags2;
+
+		spin_lock_irqsave(&iwqp->lock, flags2);
+		while (IRDMA_RING_MORE_WORK(*rq_ring)) {
+			cmpl = kzalloc(sizeof(*cmpl), GFP_ATOMIC);
+			if (!cmpl) {
+				spin_unlock_irqrestore(&iwqp->lock, flags2);
+				spin_unlock_irqrestore(&iwqp->iwrcq->lock, flags1);
+				return;
+			}
+
+			wqe_idx = rq_ring->tail;
+			irdma_set_cpi_common_values(&cmpl->cpi, qp, qp->qp_id);
+
+			cmpl->cpi.wr_id = qp->rq_wrid_array[wqe_idx];
+			cmpl->cpi.op_type = IRDMA_OP_TYPE_REC;
+			/* remove the RQ WR by moving RQ tail */
+			IRDMA_RING_SET_TAIL(*rq_ring, rq_ring->tail + 1);
+			ibdev_dbg(iwqp->iwrcq->ibcq.device,
+				  "DEV: %s: adding wr_id = 0x%llx RQ Completion to list qp_id=%d, wqe_idx=%d\n",
+				  __func__, cmpl->cpi.wr_id, qp->qp_id,
+				  wqe_idx);
+			list_add_tail(&cmpl->list, &iwqp->iwrcq->cmpl_generated);
+
+			compl_generated = true;
+		}
+		spin_unlock_irqrestore(&iwqp->lock, flags2);
+		spin_unlock_irqrestore(&iwqp->iwrcq->lock, flags1);
+		if (compl_generated)
+			irdma_comp_handler(iwqp->iwrcq);
+	} else {
+		spin_unlock_irqrestore(&iwqp->iwrcq->lock, flags1);
+		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
+				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
+	}
+}
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f70ddf9..83ba188 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -535,6 +535,9 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS)
 		irdma_modify_qp_to_err(&iwqp->sc_qp);
 
+	if (!iwqp->user_mode)
+		cancel_delayed_work_sync(&iwqp->dwork_flush);
+
 	irdma_qp_rem_ref(&iwqp->ibqp);
 	wait_for_completion(&iwqp->free_qp);
 	irdma_free_lsmm_rsrc(iwqp);
@@ -790,6 +793,14 @@ static int irdma_validate_qp_attrs(struct ib_qp_init_attr *init_attr,
 	return 0;
 }
 
+static void irdma_flush_worker(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct irdma_qp *iwqp = container_of(dwork, struct irdma_qp, dwork_flush);
+
+	irdma_generate_flush_completions(iwqp);
+}
+
 /**
  * irdma_create_qp - create qp
  * @ibqp: ptr of qp
@@ -909,6 +920,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		init_info.qp_uk_init_info.abi_ver = iwpd->sc_pd.abi_ver;
 		irdma_setup_virt_qp(iwdev, iwqp, &init_info);
 	} else {
+		INIT_DELAYED_WORK(&iwqp->dwork_flush, irdma_flush_worker);
 		init_info.qp_uk_init_info.abi_ver = IRDMA_ABI_VER;
 		err_code = irdma_setup_kmode_qp(iwdev, iwqp, &init_info, init_attr);
 	}
@@ -1400,11 +1412,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			}
 			if (iwqp->ibqp_state > IB_QPS_RTS &&
 			    !iwqp->flush_issued) {
-				iwqp->flush_issued = 1;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				irdma_flush_wqes(iwqp, IRDMA_FLUSH_SQ |
 						       IRDMA_FLUSH_RQ |
 						       IRDMA_FLUSH_WAIT);
+				iwqp->flush_issued = 1;
 			} else {
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 			}
@@ -1757,6 +1769,8 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iwcq->lock, flags);
+	if (!list_empty(&iwcq->cmpl_generated))
+		irdma_remove_cmpls_list(iwcq);
 	if (!list_empty(&iwcq->resize_list))
 		irdma_process_resize_list(iwcq, iwdev, NULL);
 	spin_unlock_irqrestore(&iwcq->lock, flags);
@@ -1961,6 +1975,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	cq->back_cq = iwcq;
 	spin_lock_init(&iwcq->lock);
 	INIT_LIST_HEAD(&iwcq->resize_list);
+	INIT_LIST_HEAD(&iwcq->cmpl_generated);
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
@@ -3046,15 +3061,12 @@ static int irdma_post_send(struct ib_qp *ibqp,
 	unsigned long flags;
 	bool inv_stag;
 	struct irdma_ah *ah;
-	bool reflush = false;
 
 	iwqp = to_iwqp(ibqp);
 	ukqp = &iwqp->sc_qp.qp_uk;
 	dev = &iwqp->iwdev->rf->sc_dev;
 
 	spin_lock_irqsave(&iwqp->lock, flags);
-	if (iwqp->flush_issued && ukqp->sq_flush_complete)
-		reflush = true;
 	while (ib_wr) {
 		memset(&info, 0, sizeof(info));
 		inv_stag = false;
@@ -3204,15 +3216,14 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		ib_wr = ib_wr->next;
 	}
 
-	if (!iwqp->flush_issued && iwqp->hw_iwarp_state <= IRDMA_QP_STATE_RTS) {
-		irdma_uk_qp_post_wr(ukqp);
+	if (!iwqp->flush_issued) {
+		if (iwqp->hw_iwarp_state <= IRDMA_QP_STATE_RTS)
+			irdma_uk_qp_post_wr(ukqp);
 		spin_unlock_irqrestore(&iwqp->lock, flags);
-	} else if (reflush) {
-		ukqp->sq_flush_complete = false;
-		spin_unlock_irqrestore(&iwqp->lock, flags);
-		irdma_flush_wqes(iwqp, IRDMA_FLUSH_SQ | IRDMA_REFLUSH);
 	} else {
 		spin_unlock_irqrestore(&iwqp->lock, flags);
+		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
+				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 	}
 	if (err)
 		*bad_wr = ib_wr;
@@ -3235,14 +3246,11 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 	struct irdma_post_rq_info post_recv = {};
 	unsigned long flags;
 	int err = 0;
-	bool reflush = false;
 
 	iwqp = to_iwqp(ibqp);
 	ukqp = &iwqp->sc_qp.qp_uk;
 
 	spin_lock_irqsave(&iwqp->lock, flags);
-	if (iwqp->flush_issued && ukqp->rq_flush_complete)
-		reflush = true;
 	while (ib_wr) {
 		post_recv.num_sges = ib_wr->num_sge;
 		post_recv.wr_id = ib_wr->wr_id;
@@ -3258,13 +3266,10 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 	}
 
 out:
-	if (reflush) {
-		ukqp->rq_flush_complete = false;
-		spin_unlock_irqrestore(&iwqp->lock, flags);
-		irdma_flush_wqes(iwqp, IRDMA_FLUSH_RQ | IRDMA_REFLUSH);
-	} else {
-		spin_unlock_irqrestore(&iwqp->lock, flags);
-	}
+	spin_unlock_irqrestore(&iwqp->lock, flags);
+	if (iwqp->flush_issued)
+		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
+				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 
 	if (err)
 		*bad_wr = ib_wr;
@@ -3476,6 +3481,11 @@ static int __irdma_poll_cq(struct irdma_cq *iwcq, int num_entries, struct ib_wc
 	/* check the current CQ for new cqes */
 	while (npolled < num_entries) {
 		ret = irdma_poll_one(ukcq, cur_cqe, entry + npolled);
+		if (ret == -ENOENT) {
+			ret = irdma_generated_cmpls(iwcq, cur_cqe);
+			if (!ret)
+				irdma_process_cqe(entry + npolled, cur_cqe);
+		}
 		if (!ret) {
 			++npolled;
 			cq_new_cqe = true;
@@ -3557,13 +3567,13 @@ static int irdma_req_notify_cq(struct ib_cq *ibcq,
 	if (iwcq->last_notify == IRDMA_CQ_COMPL_SOLICITED && notify_flags != IB_CQ_SOLICITED)
 		promo_event = true;
 
-	if (!iwcq->armed || promo_event) {
-		iwcq->armed = true;
+	if (!atomic_cmpxchg(&iwcq->armed, 0, 1) || promo_event) {
 		iwcq->last_notify = cq_notify;
 		irdma_uk_cq_request_notification(ukcq, cq_notify);
 	}
 
-	if ((notify_flags & IB_CQ_REPORT_MISSED_EVENTS) && !irdma_cq_empty(iwcq))
+	if ((notify_flags & IB_CQ_REPORT_MISSED_EVENTS) &&
+	    (!irdma_cq_empty(iwcq) || !list_empty(&iwcq->cmpl_generated)))
 		ret = 1;
 	spin_unlock_irqrestore(&iwcq->lock, flags);
 
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 08ba24d..4309b71 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -4,6 +4,7 @@
 #define IRDMA_VERBS_H
 
 #define IRDMA_MAX_SAVED_PHY_PGADDR	4
+#define IRDMA_FLUSH_DELAY_MS		20
 
 #define IRDMA_PKEY_TBL_SZ		1
 #define IRDMA_DEFAULT_PKEY		0xFFFF
@@ -115,7 +116,7 @@ struct irdma_cq {
 	u16 cq_size;
 	u16 cq_num;
 	bool user_mode;
-	bool armed;
+	atomic_t armed;
 	enum irdma_cmpl_notify last_notify;
 	u32 polled_cmpls;
 	u32 cq_mem_size;
@@ -126,6 +127,12 @@ struct irdma_cq {
 	struct irdma_pbl *iwpbl_shadow;
 	struct list_head resize_list;
 	struct irdma_cq_poll_info cur_cqe;
+	struct list_head cmpl_generated;
+};
+
+struct irdma_cmpl_gen {
+	struct list_head list;
+	struct irdma_cq_poll_info cpi;
 };
 
 struct disconn_work {
@@ -166,6 +173,7 @@ struct irdma_qp {
 	refcount_t refcnt;
 	struct iw_cm_id *cm_id;
 	struct irdma_cm_node *cm_node;
+	struct delayed_work dwork_flush;
 	struct ib_mr *lsmm_mr;
 	atomic_t hw_mod_qp_pend;
 	enum ib_qp_state ibqp_state;
@@ -229,4 +237,7 @@ static inline u16 irdma_fw_minor_ver(struct irdma_sc_dev *dev)
 void irdma_ib_unregister_device(struct irdma_device *iwdev);
 void irdma_ib_dealloc_device(struct ib_device *ibdev);
 void irdma_ib_qp_event(struct irdma_qp *iwqp, enum irdma_qp_event_type event);
+void irdma_generate_flush_completions(struct irdma_qp *iwqp);
+void irdma_remove_cmpls_list(struct irdma_cq *iwcq);
+int irdma_generated_cmpls(struct irdma_cq *iwcq, struct irdma_cq_poll_info *cq_poll_info);
 #endif /* IRDMA_VERBS_H */
-- 
1.8.3.1

