Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5A58838D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiHBV2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 17:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiHBV2c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 17:28:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FA9B7E8
        for <linux-rdma@vger.kernel.org>; Tue,  2 Aug 2022 14:28:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k29-20020a9d701d000000b0061c99652493so10599252otj.8
        for <linux-rdma@vger.kernel.org>; Tue, 02 Aug 2022 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=gdI8Ro2vIi6jlhDYcOxmpsubCB6QZlYvy+jQZdjBnBo=;
        b=IYMXeGvqYlhsoq4sElDxIc/v7U2MvGXNDwTqwHI4wxgsuppLcP/Qb8gKVEXbRV2Y91
         7suYncdyi7IdVVzkBF3iOlh1CFPq4JE4kKIf1XYHahnJ/lK43wcODDp04RtzA/CkKzdm
         /Gk4gF86txj+FKwSkFepPMQH8vIRwtUd8XT0a2PdGpTwmXF1bovZ8WtVyUyAeLvgJ5UF
         n47c/1bXz6FwJO1twz/mstQjiw9GL70G/B+X/kC9pIXZMJifnUO5TqRGU4GdhvIs8Cde
         19Kk/EicwaCOr9k6ULNGk888GKTYv38K6x+Mdu72xacHGA/iaGQvIcKKI1N2Rq4+acqP
         hJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gdI8Ro2vIi6jlhDYcOxmpsubCB6QZlYvy+jQZdjBnBo=;
        b=CvZHBGRXeur7RYpQOND9mfu9CutTbauYG2jqVXn+jrWbDDLPE3K3LFXuzmAQpkM3fs
         JlFiZ8upntjPdqQKosf5YhEEOkzBUdBQX2A60If89D64MVGX51wiYnsWmCuod5kViEVO
         X836/iYZK7yk/ksV4NyZAN69WvRQpsKSpUDAT4Nh0TDQpQ2Eyjb4yfxt9Mnm/5d2Jta0
         y/T8RGaEV9UJ5pgVS/Zlnq/Gs+e76T+TY/IA5FVbxYH0wAD6Kk9STFh10kHR9uJndsog
         QHKM9Ph4DrxJ3H0HdVNbM6RjjZpA7Zslrb7Sye5KCj5CsWKKn6Ajp3Y43c/CWZqo5Mii
         RorQ==
X-Gm-Message-State: AJIora/QDmkG7nKSLTTm6uiXaIW0IOB5oZbc8G7vAQVtloYJwHyUvKrc
        V3HVfY4C3omFmPXvw2CeRGU=
X-Google-Smtp-Source: AGRyM1unETdZ6mBO2rRPXad2UXWxZ4jDX0E5Ri7HSkI20P2CjRnuUGrE56JGQL37KGXDX49Q70ZvUw==
X-Received: by 2002:a05:6830:2084:b0:61c:8178:c824 with SMTP id y4-20020a056830208400b0061c8178c824mr7797212otq.385.1659475709573;
        Tue, 02 Aug 2022 14:28:29 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056870b00400b0010ec94f8599sm2117681oae.36.2022.08.02.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:28:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions
Date:   Tue,  2 Aug 2022 16:27:32 -0500
Message-Id: <20220802212731.2313-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver does not guard changes to the mr state
against race conditions which can arise from races between
local operations and remote invalidate operations. This patch
adds a spinlock to the mr object and makes these state changes
atomic. It also introduces parameters to count the number of
active dma transfers and indicate that an invalidate operation
is pending.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Addressed issues raised by Jason Gunthorpe regarding preventing
  access to memory after a local or remote invalidate operation
  is carried out. The patch was updated to busy wait the invalidate
  operation until recent memcpy operations complete while blocking
  additional dma operations from starting.
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 149 +++++++++++++------
 drivers/infiniband/sw/rxe/rxe_req.c   |   8 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 200 ++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
 5 files changed, 204 insertions(+), 169 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 22f6cc31d1d6..e643950d58e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -73,8 +73,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum rxe_mr_lookup_type type);
+struct rxe_mr *rxe_get_mr(struct rxe_pd *pd, int access, u32 key);
+void rxe_put_mr(struct rxe_mr *mr);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
@@ -90,6 +90,8 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
+int rxe_invalidate_rkey(struct rxe_qp *qp, u32 rkey);
+
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 850b80f5ad8b..bf318c9da851 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -61,7 +61,8 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
-	mr->state = RXE_MR_STATE_INVALID;
+	spin_lock_init(&mr->lock);
+
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
@@ -109,7 +110,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 
 	mr->ibmr.pd = &pd->ibpd;
 	mr->access = access;
-	mr->state = RXE_MR_STATE_VALID;
+	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
 	mr->type = IB_MR_TYPE_DMA;
 }
 
@@ -182,7 +183,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->iova = iova;
 	mr->va = start;
 	mr->offset = ib_umem_offset(umem);
-	mr->state = RXE_MR_STATE_VALID;
+	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
 	mr->type = IB_MR_TYPE_USER;
 
 	return 0;
@@ -210,7 +211,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 
 	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
-	mr->state = RXE_MR_STATE_FREE;
+	smp_store_release(&mr->state, RXE_MR_STATE_FREE);
 	mr->type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
@@ -255,18 +256,22 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 	}
 }
 
+/**
+ * iova_to_vaddr - convert IO virtual address to kernel address
+ * @mr:
+ * @iova:
+ * @length:
+ *
+ * Context: should be called while mr is in the VALID state
+ *
+ * Returns: on success returns kernel address else NULL on error
+ */
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
 	int m, n;
 	void *addr;
 
-	if (mr->state != RXE_MR_STATE_VALID) {
-		pr_warn("mr not in valid state\n");
-		addr = NULL;
-		goto out;
-	}
-
 	if (!mr->map) {
 		addr = (void *)(uintptr_t)iova;
 		goto out;
@@ -397,7 +402,7 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
+		mr = rxe_get_mr(pd, access, sge->lkey);
 		if (!mr) {
 			err = -EINVAL;
 			goto err1;
@@ -409,7 +414,7 @@ int copy_data(
 
 		if (offset >= sge->length) {
 			if (mr) {
-				rxe_put(mr);
+				rxe_put_mr(mr);
 				mr = NULL;
 			}
 			sge++;
@@ -422,8 +427,7 @@ int copy_data(
 			}
 
 			if (sge->length) {
-				mr = lookup_mr(pd, access, sge->lkey,
-					       RXE_LOOKUP_LOCAL);
+				mr = rxe_get_mr(pd, access, sge->lkey);
 				if (!mr) {
 					err = -EINVAL;
 					goto err1;
@@ -454,13 +458,13 @@ int copy_data(
 	dma->resid	= resid;
 
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
 
 	return 0;
 
 err2:
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
 err1:
 	return err;
 }
@@ -498,34 +502,67 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mr corresponding to lkey/rkey
- *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mr pd
- * (3) verify that the mr can support the requested access
- * (4) verify that mr state is valid
+/**
+ * rxe_get_mr - lookup an mr from pd, access and key
+ * @pd: the pd
+ * @access: access requirements
+ * @key: lkey or rkey
+ *
+ * Takes a reference to mr
+ *
+ * Returns: on success return mr else NULL
  */
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum rxe_mr_lookup_type type)
+struct rxe_mr *rxe_get_mr(struct rxe_pd *pd, int access, u32 key)
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 	int index = key >> 8;
+	int remote = access & IB_ACCESS_REMOTE;
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, index);
 	if (!mr)
 		return NULL;
 
-	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
-		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
-		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
-		     mr->state != RXE_MR_STATE_VALID)) {
+	spin_lock_bh(&mr->lock);
+	if ((remote && mr->rkey != key) ||
+	    (!remote && mr->lkey != key) ||
+	    (mr_pd(mr) != pd) ||
+	    (access && !(access & mr->access)) ||
+	    (mr->state != RXE_MR_STATE_VALID)) {
+		spin_unlock_bh(&mr->lock);
 		rxe_put(mr);
-		mr = NULL;
+		return NULL;
 	}
+	mr->num_dma++;
+	spin_unlock_bh(&mr->lock);
 
 	return mr;
 }
 
+/**
+ * rxe_put_mr - drop a reference to mr with an active DMA
+ * @mr: the mr
+ *
+ * Undo the effects of rxe_get_mr().
+ */
+void rxe_put_mr(struct rxe_mr *mr)
+{
+	if (!mr)
+		return;
+
+	spin_lock_bh(&mr->lock);
+	if (mr->num_dma > 0) {
+		mr->num_dma--;
+		if (mr->invalidate && !mr->num_dma) {
+			mr->invalidate = 0;
+			mr->state = RXE_MR_STATE_FREE;
+		}
+	}
+	spin_unlock_bh(&mr->lock);
+
+	rxe_put(mr);
+}
+
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
@@ -534,32 +571,46 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
 	if (!mr) {
-		pr_err("%s: No MR for key %#x\n", __func__, key);
+		pr_debug("%s: No MR for key %#x\n", __func__, key);
 		ret = -EINVAL;
 		goto err;
 	}
 
 	if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
-		pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
+		pr_debug("%s: wr key (%#x) doesn't match mr key (%#x)\n",
 			__func__, key, (mr->rkey ? mr->rkey : mr->lkey));
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
 	if (atomic_read(&mr->num_mw) > 0) {
-		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
+		pr_debug("%s: Attempt to invalidate an MR while bound to MWs\n",
 			__func__);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
 	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
-		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+		pr_debug("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
-	mr->state = RXE_MR_STATE_FREE;
+	spin_lock_bh(&mr->lock);
+	if (mr->state == RXE_MR_STATE_INVALID) {
+		spin_unlock_bh(&mr->lock);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	} else if (mr->num_dma > 0) {
+		spin_unlock_bh(&mr->lock);
+		mr->invalidate = 1;
+		ret = -EAGAIN;
+		goto err_drop_ref;
+	} else {
+		mr->state = RXE_MR_STATE_FREE;
+	}
+	spin_unlock_bh(&mr->lock);
+
 	ret = 0;
 
 err_drop_ref:
@@ -581,32 +632,32 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	u32 key = wqe->wr.wr.reg.key;
 	u32 access = wqe->wr.wr.reg.access;
 
-	/* user can only register MR in free state */
-	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
-		pr_warn("%s: mr->lkey = 0x%x not free\n",
-			__func__, mr->lkey);
-		return -EINVAL;
-	}
-
 	/* user can only register mr with qp in same protection domain */
 	if (unlikely(qp->ibqp.pd != mr->ibmr.pd)) {
-		pr_warn("%s: qp->pd and mr->pd don't match\n",
+		pr_debug("%s: qp->pd and mr->pd don't match\n",
 			__func__);
 		return -EINVAL;
 	}
 
 	/* user is only allowed to change key portion of l/rkey */
 	if (unlikely((mr->lkey & ~0xff) != (key & ~0xff))) {
-		pr_warn("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
+		pr_debug("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
 			__func__, key, mr->lkey);
 		return -EINVAL;
 	}
 
-	mr->access = access;
-	mr->lkey = key;
-	mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
-	mr->iova = wqe->wr.wr.reg.mr->iova;
-	mr->state = RXE_MR_STATE_VALID;
+	spin_lock_bh(&mr->lock);
+	if (mr->state == RXE_MR_STATE_FREE) {
+		mr->access = access;
+		mr->lkey = key;
+		mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
+		mr->iova = wqe->wr.wr.reg.mr->iova;
+		mr->state = RXE_MR_STATE_VALID;
+	} else {
+		spin_unlock_bh(&mr->lock);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&mr->lock);
 
 	return 0;
 }
@@ -619,6 +670,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
 
+	spin_lock_bh(&mr->lock);
+	mr->state = RXE_MR_STATE_INVALID;
+	spin_unlock_bh(&mr->lock);
+
 	rxe_cleanup(mr);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 49e8f54db6f5..9a9ee2a3011c 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -570,11 +570,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
 		rkey = wqe->wr.ex.invalidate_rkey;
-		if (rkey_is_mw(rkey))
-			ret = rxe_invalidate_mw(qp, rkey);
-		else
-			ret = rxe_invalidate_mr(qp, rkey);
-
+		ret = rxe_invalidate_rkey(qp, rkey);
 		if (unlikely(ret)) {
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
 			return ret;
@@ -671,7 +667,7 @@ int rxe_requester(void *arg)
 
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
 		err = rxe_do_local_ops(qp, wqe);
-		if (unlikely(err))
+		if (err)
 			goto err;
 		else
 			goto done;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b36ec5c4d5e0..6c10f9759ae9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -314,7 +314,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	/* don't trust user space data */
 	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
 		spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
-		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
+		pr_debug("%s: invalid num_sge in SRQ entry\n", __func__);
 		return RESPST_ERR_MALFORMED_WQE;
 	}
 	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
@@ -402,6 +402,54 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	}
 }
 
+static struct rxe_mr *rxe_rkey_to_mr(struct rxe_qp *qp, int access, u32 rkey)
+{
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+
+	if (rkey_is_mw(rkey)) {
+		mw = rxe_lookup_mw(qp, access, rkey);
+		if (!mw)
+			return NULL;
+
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset = mw->addr;
+
+		mr = mw->mr;
+		if (!mr) {
+			rxe_put(mw);
+			return NULL;
+		}
+
+		spin_lock_bh(&mr->lock);
+		if (mr->state == RXE_MR_STATE_VALID) {
+			mr->num_dma++;
+			rxe_get(mr);
+		} else {
+			spin_unlock_bh(&mr->lock);
+			rxe_put(mw);
+			return NULL;
+		}
+		spin_unlock_bh(&mr->lock);
+
+		rxe_put(mw);
+	} else {
+		mr = rxe_get_mr(qp->pd, access, rkey);
+		if (!mr)
+			return NULL;
+	}
+
+	return mr;
+}
+
+/**
+ * check_rkey - validate rdma parameters for packet
+ * @qp: the qp
+ * @pkt: packet info for the current request packet
+ *
+ * Returns: next state in responder state machine
+ *	    RESPST_EXECUTE on success else an error state
+ */
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -415,6 +463,11 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
+	/*
+	 * Parse the reth header or atmeth header if present
+	 * to extract the rkey, iova and length. Else use the
+	 * updated parameters from the previous packet.
+	 */
 	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
@@ -438,46 +491,20 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	/* A zero-byte op is not required to set an addr or rkey. */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
-	    reth_len(pkt) == 0) {
+	    reth_len(pkt) == 0)
 		return RESPST_EXECUTE;
-	}
 
 	va	= qp->resp.va;
 	rkey	= qp->resp.rkey;
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	if (rkey_is_mw(rkey)) {
-		mw = rxe_lookup_mw(qp, access, rkey);
-		if (!mw) {
-			pr_debug("%s: no MW matches rkey %#x\n",
-					__func__, rkey);
-			state = RESPST_ERR_RKEY_VIOLATION;
-			goto err;
-		}
-
-		mr = mw->mr;
-		if (!mr) {
-			pr_err("%s: MW doesn't have an MR\n", __func__);
-			state = RESPST_ERR_RKEY_VIOLATION;
-			goto err;
-		}
-
-		if (mw->access & IB_ZERO_BASED)
-			qp->resp.offset = mw->addr;
-
-		rxe_put(mw);
-		rxe_get(mr);
-	} else {
-		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
-		if (!mr) {
-			pr_debug("%s: no MR matches rkey %#x\n",
-					__func__, rkey);
-			state = RESPST_ERR_RKEY_VIOLATION;
-			goto err;
-		}
-	}
+	/* get mr from rkey */
+	mr = rxe_rkey_to_mr(qp, access, rkey);
+	if (!mr)
+		return RESPST_ERR_RKEY_VIOLATION;
 
+	/* check that dma fits into mr */
 	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
@@ -511,7 +538,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 err:
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
 	if (mw)
 		rxe_put(mw);
 
@@ -536,8 +563,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 				      struct rxe_pkt_info *pkt)
 {
 	enum resp_states rc = RESPST_NONE;
-	int	err;
 	int data_len = payload_size(pkt);
+	int err;
 
 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
 			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
@@ -610,11 +637,6 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	}
 
 	if (!res->replay) {
-		if (mr->state != RXE_MR_STATE_VALID) {
-			ret = RESPST_ERR_RKEY_VIOLATION;
-			goto out;
-		}
-
 		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
 					sizeof(u64));
 
@@ -701,59 +723,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	return skb;
 }
 
-/**
- * rxe_recheck_mr - revalidate MR from rkey and get a reference
- * @qp: the qp
- * @rkey: the rkey
- *
- * This code allows the MR to be invalidated or deregistered or
- * the MW if one was used to be invalidated or deallocated.
- * It is assumed that the access permissions if originally good
- * are OK and the mappings to be unchanged.
- *
- * TODO: If someone reregisters an MR to change its size or
- * access permissions during the processing of an RDMA read
- * we should kill the responder resource and complete the
- * operation with an error.
- *
- * Return: mr on success else NULL
- */
-static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
-{
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct rxe_mr *mr;
-	struct rxe_mw *mw;
-
-	if (rkey_is_mw(rkey)) {
-		mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
-		if (!mw)
-			return NULL;
-
-		mr = mw->mr;
-		if (mw->rkey != rkey || mw->state != RXE_MW_STATE_VALID ||
-		    !mr || mr->state != RXE_MR_STATE_VALID) {
-			rxe_put(mw);
-			return NULL;
-		}
-
-		rxe_get(mr);
-		rxe_put(mw);
-
-		return mr;
-	}
-
-	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-	if (!mr)
-		return NULL;
-
-	if (mr->rkey != rkey || mr->state != RXE_MR_STATE_VALID) {
-		rxe_put(mr);
-		return NULL;
-	}
-
-	return mr;
-}
-
 /* RDMA read response. If res is not NULL, then we have a current RDMA request
  * being processed or replayed.
  */
@@ -769,6 +738,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int err;
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
+	int access = IB_ACCESS_REMOTE_READ;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
@@ -780,7 +750,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 			mr = qp->resp.mr;
 			qp->resp.mr = NULL;
 		} else {
-			mr = rxe_recheck_mr(qp, res->read.rkey);
+			mr = rxe_rkey_to_mr(qp, access, res->read.rkey);
 			if (!mr)
 				return RESPST_ERR_RKEY_VIOLATION;
 		}
@@ -790,7 +760,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		else
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
-		mr = rxe_recheck_mr(qp, res->read.rkey);
+		mr = rxe_rkey_to_mr(qp, access, res->read.rkey);
 		if (!mr)
 			return RESPST_ERR_RKEY_VIOLATION;
 
@@ -812,9 +782,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
 	if (err)
-		pr_err("Failed copying memory\n");
+		pr_debug("Failed copying memory\n");
+
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
@@ -824,7 +795,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err) {
-		pr_err("Failed sending RDMA reply.\n");
+		pr_debug("Failed sending RDMA reply.\n");
 		return RESPST_ERR_RNR;
 	}
 
@@ -846,16 +817,27 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	return state;
 }
 
-static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
+int rxe_invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 {
-	if (rkey_is_mw(rkey))
-		return rxe_invalidate_mw(qp, rkey);
-	else
-		return rxe_invalidate_mr(qp, rkey);
+	int count = 100;
+	int err;
+
+	do {
+		if (rkey_is_mw(rkey))
+			err = rxe_invalidate_mw(qp, rkey);
+		else
+			err = rxe_invalidate_mr(qp, rkey);
+		udelay(1);
+	} while(err == -EAGAIN && count--);
+
+	WARN_ON(!count);
+
+	return err;
 }
 
-/* Executes a new request. A retried request never reach that function (send
- * and writes are discarded, and reads and atomics are retried elsewhere.
+/* Executes a new request packet. A retried request never reaches this
+ * function (send and writes are discarded, and reads and atomics are
+ * retried elsewhere.)
  */
 static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
@@ -900,7 +882,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 	if (pkt->mask & RXE_IETH_MASK) {
 		u32 rkey = ieth_rkey(pkt);
 
-		err = invalidate_rkey(qp, rkey);
+		err = rxe_invalidate_rkey(qp, rkey);
 		if (err)
 			return RESPST_ERR_INVALIDATE_RKEY;
 	}
@@ -1043,7 +1025,7 @@ static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending ack\n");
+		pr_debug("Failed sending ack\n");
 
 err1:
 	return err;
@@ -1064,7 +1046,7 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending atomic ack\n");
+		pr_debug("Failed sending atomic ack\n");
 
 	/* have to clear this since it is used to trigger
 	 * long read replies
@@ -1103,7 +1085,7 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 	}
 
 	if (qp->resp.mr) {
-		rxe_put(qp->resp.mr);
+		rxe_put_mr(qp->resp.mr);
 		qp->resp.mr = NULL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a24fbe984066..77ac6308997c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -271,11 +271,6 @@ enum rxe_mr_copy_dir {
 	RXE_FROM_MR_OBJ,
 };
 
-enum rxe_mr_lookup_type {
-	RXE_LOOKUP_LOCAL,
-	RXE_LOOKUP_REMOTE,
-};
-
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
 
 struct rxe_phys_buf {
@@ -302,7 +297,12 @@ struct rxe_mr {
 
 	u32			lkey;
 	u32			rkey;
+
 	enum rxe_mr_state	state;
+	int			invalidate;
+	int			num_dma;
+	spinlock_t		lock;	/* guard state */
+
 	enum ib_mr_type		type;
 	u64			va;
 	u64			iova;
-- 
2.34.1

