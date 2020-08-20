Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE65524C7F7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgHTWrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHTWr1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9BC061388
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z22so3357070oid.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlbZ/2CJE0b/si/UP5Ee4Bgzp1f1N6is5T0nGHBtsDk=;
        b=h3f8cxVZKi8u3rliQ7FL+PpjV72RrI20ZT48EbVEXHPtuDiT+C700aDD9+GBP+Y3Es
         dMVp451zis+NLefR/b9RiLltl3IzEfL0I1t8TDsnRWbdyeznEYULUwAnjvGVhwLOJncp
         sqc72e5iBzgtUcKNjEoBhivsaO8zxDSud4FoxS+P+u6xWXeTgaNRuG/byvHgO1/wW0XU
         ctXtxzLGlasq/esvMYE6SUhVVpoY1Ku7BROo8S7dra71nKTFYqKa2DfXshaCG/pguJYD
         YjwhzSCBZmnx69KlM7RNvqUFxXH6IJrnVaLCXghLoRR8Xo814CpVuVoqELgznkS1SQNW
         KTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlbZ/2CJE0b/si/UP5Ee4Bgzp1f1N6is5T0nGHBtsDk=;
        b=JX6n2XJ8jk2OhdSA7HmCWF7ei/0xpC04Rb3iAXroLp/uXjfweVy/XJ1rE/a6m5yVfh
         A/ttVcWabEqaNPknzFWl4+nKXttAGceEA9ab2Tg2cgWhDBVtpNEfX3c3Vq7sQKju7ZqJ
         XooAvAUUfxRsFxjFW981urAkAS0U8f35u4aKV2CqRp7/kNwa49PpAt654BuRpZWqMkn6
         Z0bikjrJzEomkYE9BAc4ZtDwCEqpSo6o1Omv6RdZ5UI4iS1rAvpFK34Dn+Gzb9kBSbFj
         LqhS4ACziLPQn7XGjn8ENNdnW+GdJiaECUdOh9S8J5tnKekXb67mX65OeH6kHcVjyqeQ
         tGrw==
X-Gm-Message-State: AOAM532YxKy3EfN6ukv+QyhHTZv5NmTDp8zcripkLTsyo+loeN7dGL9N
        oRhEfpSPHNmrA6wuLHC8gGVAN6HQbnca9Q==
X-Google-Smtp-Source: ABdhPJyAtVtb000J8Nv6ysdkX6KFt31++s2Zj/uddhnd3+FLenzJl8WxD1zMM5jeCQDfjD5ZEJ+N6A==
X-Received: by 2002:aca:ed4e:: with SMTP id l75mr127734oih.44.1597963644547;
        Thu, 20 Aug 2020 15:47:24 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id q62sm16181ooa.12.2020.08.20.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 14/17] rdma_rxe: Added stub for invalidate mw
Date:   Thu, 20 Aug 2020 17:46:35 -0500
Message-Id: <20200820224638.3212-15-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleaned up calling of bind mw and invalidate mr/mw from
rxe_req.c and rxe_resp.
Cleaned up reference handling for rxe_mw.c.
Minor cleanup of rxe_loc.h.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 25 +++------
 drivers/infiniband/sw/rxe/rxe_mr.c    |  7 +++
 drivers/infiniband/sw/rxe/rxe_mw.c    | 16 ++++--
 drivers/infiniband/sw/rxe/rxe_req.c   | 62 ++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 76 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 10 ++++
 6 files changed, 117 insertions(+), 79 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b8ad96e4e005..12b43fa9087d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -73,49 +73,33 @@ struct rxe_mmap_info *rxe_create_mmap_info(struct rxe_dev *dev, u32 size,
 int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
-enum copy_direction {
-	to_mr_obj,
-	from_mr_obj,
-};
-
 void rxe_mr_init_dma(struct rxe_pd *pd,
 		      int access, struct rxe_mr *mr);
-
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
 		      u64 length, u64 iova, int access, struct ib_udata *udata,
 		      struct rxe_mr *mr);
-
 int rxe_mr_init_fast(struct rxe_pd *pd,
 		      int max_pages, struct rxe_mr *mr);
-
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		 int length, enum copy_direction dir, u32 *crcp);
-
 int copy_data(struct rxe_pd *pd, int access,
 	      struct rxe_dma_info *dma, void *addr, int length,
 	      enum copy_direction dir, u32 *crcp);
-
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-
-enum lookup_type {
-	lookup_local,
-	lookup_remote,
-};
-
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			   enum lookup_type type);
-
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
-
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
-
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr);
+void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
@@ -268,4 +252,7 @@ static inline int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
+/* rxe_resp.c */
+int rxe_invalidate(struct rxe_qp *qp, u32 key);
+
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cebf16b2ab15..b8d3002d9df8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -543,6 +543,13 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	return mr;
 }
 
+/* stub for invalidate MR */
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
+{
+	mr->state = RXE_MEM_STATE_FREE;
+	return 0;
+}
+
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c4ba85c507a3..c41b5160bdba 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -10,6 +10,8 @@
 
 /* choose a unique non zero random number for rkey
  * use high order bit to indicate MR vs MW
+ * chance of failure to get a new key in more
+ * than one pass is negligable
  */
 static void rxe_set_mw_rkey(struct rxe_mw *mw)
 {
@@ -33,7 +35,6 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_mw *mw;
-	u32 rkey;
 	struct rxe_alloc_mw_resp __user *uresp = NULL;
 
 	if (udata) {
@@ -64,7 +65,6 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	mw->length		= 0;
 	mw->ibmw.pd		= ibpd;
 	mw->ibmw.type		= type;
-	mw->ibmw.rkey		= rkey;
 	mw->state		= (type == IB_MW_TYPE_2) ?
 					RXE_MEM_STATE_FREE :
 					RXE_MEM_STATE_VALID;
@@ -84,29 +84,37 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
-	struct rxe_pd *pd = to_rpd(ibmw->pd);
 	unsigned long flags;
 
 	spin_lock_irqsave(&mw->lock, flags);
 	mw->state = RXE_MEM_STATE_INVALID;
 	spin_unlock_irqrestore(&mw->lock, flags);
 
-	rxe_drop_ref(pd);
 	rxe_drop_ref(mw);
 
 	return 0;
 }
 
+/* stub for bind mw */
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	pr_err_once("%s: not implemented\n", __func__);
 	return -EINVAL;
 }
 
+/* stub for invalidate MW */
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	pr_err_once("%s: not implemented\n", __func__);
+	return -EINVAL;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
+	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
 
 	rxe_drop_index(mw);
 	rxe_drop_key(mw);
+	rxe_drop_ref(pd);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index be1871a34380..ec5a1677a2a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -526,9 +526,9 @@ static void save_state(struct rxe_send_wqe *wqe,
 		       struct rxe_send_wqe *rollback_wqe,
 		       u32 *rollback_psn)
 {
-	rollback_wqe->state     = wqe->state;
+	rollback_wqe->state	= wqe->state;
 	rollback_wqe->first_psn = wqe->first_psn;
-	rollback_wqe->last_psn  = wqe->last_psn;
+	rollback_wqe->last_psn	= wqe->last_psn;
 	*rollback_psn		= qp->req.psn;
 }
 
@@ -561,7 +561,6 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
@@ -573,6 +572,7 @@ int rxe_requester(void *arg)
 	int ret;
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
+	u32 rkey;
 
 	rxe_add_ref(qp);
 
@@ -598,55 +598,52 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
+	/* process local operations */
 	if (wqe->mask & WR_LOCAL_MASK) {
+		wqe->state = wqe_state_done;
+		wqe->status = IB_WC_SUCCESS;
+
 		switch (wqe->wr.opcode) {
 		case IB_WR_LOCAL_INV:
-			mr = rxe_pool_get_key(&rxe->mr_pool,
-					&wqe->wr.ex.invalidate_rkey);
-			if (!mr) {
-				pr_err("No mr for key %#x\n",
-				       wqe->wr.ex.invalidate_rkey);
-				wqe->state = wqe_state_error;
+			rkey = wqe->wr.ex.invalidate_rkey;
+			ret = rxe_invalidate(qp, rkey);
+			if (ret)
 				wqe->status = IB_WC_LOC_QP_OP_ERR;
-				/* TODO this should be goto err */
-				goto exit;
-			}
-			mr->state = RXE_MEM_STATE_FREE;
-			rxe_drop_ref(mr);
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
 			break;
 		case IB_WR_REG_MR:
+			if (qp->is_user) {
+				pr_err_once("Reg MR WR not supported from user space\n");
+				wqe->status = IB_WC_LOC_QP_OP_ERR;
+			}
 			mr = to_rmr(wqe->wr.wr.reg.mr);
 			mr->state = RXE_MEM_STATE_VALID;
 			mr->access = wqe->wr.wr.reg.access;
 			mr->lkey = wqe->wr.wr.reg.key;
 			mr->rkey = wqe->wr.wr.reg.key;
 			mr->iova = wqe->wr.wr.reg.mr->iova;
-			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			break;
 		case IB_WR_BIND_MW:
 			ret = rxe_bind_mw(qp, wqe);
-			if (ret) {
-				wqe->state = wqe_state_done;
+			if (ret)
 				wqe->status = IB_WC_MW_BIND_ERR;
-				goto err;
-			}
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
 			break;
 		default:
 			pr_err_once("unexpected LOCAL WR opcode = %d\n",
 					wqe->wr.opcode);
-			goto exit;
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		}
-		qp->req.wqe_index = next_index(qp->sq.queue,
-						qp->req.wqe_index);
+
+		qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
+
+		if (wqe->status != IB_WC_SUCCESS)
+			goto err;
 
 		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
-		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
+		    (qp->sq_sig_type == IB_SIGNAL_ALL_WR)) {
 			rxe_run_task(&qp->comp.task, 1);
+		}
+
 		goto next_wqe;
 	}
 
@@ -666,8 +663,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		/* TODO this should be goto err */
-		goto exit;
+		goto err;
 	}
 
 	mask = rxe_opcode[opcode].mask;
@@ -680,13 +676,9 @@ int rxe_requester(void *arg)
 	payload = (mask & RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
 	if (payload > mtu) {
 		if (qp_type(qp) == IB_QPT_UD) {
-			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
-			 * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
-			 * shall not emit any packets for this message. Further, the CI shall not
-			 * generate an error due to this condition.
+			/* C10-93.1.1
+			 * fake a successful UD send
 			 */
-
-			/* fake a successful UD send */
 			wqe->first_psn = qp->req.psn;
 			wqe->last_psn = qp->req.psn;
 			qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 96ab9f62a8fa..9997eaab235d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -759,6 +759,7 @@ static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
 static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	enum resp_states err;
+	u32 rkey;
 
 	if (pkt->mask & RXE_SEND_MASK) {
 		if (qp_type(qp) == IB_QPT_UD ||
@@ -775,6 +776,13 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		err = send_data_in(qp, payload_addr(pkt), payload_size(pkt));
 		if (err)
 			return err;
+
+		if (pkt->mask & RXE_IETH_MASK) {
+			rkey = ieth_rkey(pkt);
+			err = rxe_invalidate(qp, rkey);
+			if (err)
+				return RESPST_ERR_RKEY_VIOLATION;
+		}
 	} else if (pkt->mask & RXE_WRITE_MASK) {
 		err = write_data_in(qp, pkt);
 		if (err)
@@ -809,6 +817,41 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_CLEANUP;
 }
 
+/* common code for rxe_resp.c and rxe_req.c
+ * invalidate MW or MR with matching rkey
+ */
+int rxe_invalidate(struct rxe_qp *qp, u32 rkey)
+{
+	int ret;
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+
+	if (rkey & IS_MW) {
+		mw = rxe_pool_get_key(&rxe->mw_pool, &rkey);
+		if (mw) {
+			ret = rxe_invalidate_mw(qp, mw);
+			rxe_drop_ref(mw);
+		} else {
+			ret = -EINVAL;
+			pr_err_once("No MW matches invalidate rkey = 0x%x\n",
+					rkey);
+		}
+	} else {
+		mr = rxe_pool_get_key(&rxe->mr_pool, &rkey);
+		if (mr && mr->ibmr.rkey == rkey) {
+			ret = rxe_invalidate_mr(qp, mr);
+			rxe_drop_ref(mr);
+		} else {
+			ret = -EINVAL;
+			pr_err_once("No MR matches invalidate rkey = 0x%x\n",
+					rkey);
+		}
+	}
+
+	return ret;
+}
+
 static enum resp_states do_complete(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
@@ -817,6 +860,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	struct ib_uverbs_wc *uwc = &cqe.uibwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	u32 rkey = ieth_rkey(pkt);
 
 	if (unlikely(!wqe))
 		return RESPST_CLEANUP;
@@ -824,13 +868,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	memset(&cqe, 0, sizeof(cqe));
 
 	if (qp->rcq->is_user) {
-		uwc->status             = qp->resp.status;
-		uwc->qp_num             = qp->ibqp.qp_num;
-		uwc->wr_id              = wqe->wr_id;
+		uwc->status		= qp->resp.status;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
 	} else {
-		wc->status              = qp->resp.status;
-		wc->qp                  = &qp->ibqp;
-		wc->wr_id               = wqe->wr_id;
+		wc->status		= qp->resp.status;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
 	}
 
 	if (wc->status == IB_WC_SUCCESS) {
@@ -841,7 +885,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		wc->vendor_err = 0;
 		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
 				pkt->mask & RXE_WRITE_MASK) ?
-					qp->resp.length : wqe->dma.length - wqe->dma.resid;
+					qp->resp.length :
+					wqe->dma.length - wqe->dma.resid;
 
 		/* fields after byte_len are different between kernel and user
 		 * space
@@ -856,7 +901,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 
 			if (pkt->mask & RXE_IETH_MASK) {
 				uwc->wc_flags |= IB_WC_WITH_INVALIDATE;
-				uwc->ex.invalidate_rkey = ieth_rkey(pkt);
+				uwc->ex.invalidate_rkey = rkey;
 			}
 
 			uwc->qp_num		= qp->ibqp.qp_num;
@@ -885,20 +930,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mr *rmr;
-
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
-				wc->ex.invalidate_rkey = ieth_rkey(pkt);
-
-				rmr = rxe_pool_get_key(&rxe->mr_pool,
-						 &wc->ex.invalidate_rkey);
-				if (unlikely(!rmr)) {
-					pr_err("Bad rkey %#x invalidation\n",
-					       wc->ex.invalidate_rkey);
-					return RESPST_ERROR;
-				}
-				rmr->state = RXE_MEM_STATE_FREE;
-				rxe_drop_ref(rmr);
+				wc->ex.invalidate_rkey = rkey;
 			}
 
 			wc->qp			= &qp->ibqp;
@@ -909,6 +942,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			wc->port_num		= qp->attr.port_num;
 		}
 	}
+	/* TODO why aren't values returned when the packet fails ? */
 
 	/* have copy for srq and reference for !srq */
 	if (!qp->srq)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a042fa47aa40..8b0fddac3817 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -264,6 +264,16 @@ struct rxe_qp {
 	struct execute_work	cleanup_work;
 };
 
+enum copy_direction {
+	to_mr_obj,
+	from_mr_obj,
+};
+
+enum lookup_type {
+	lookup_local,
+	lookup_remote,
+};
+
 /* common state values for mr and mw */
 enum rxe_mem_state {
 	RXE_MEM_STATE_ZOMBIE,
-- 
2.25.1

