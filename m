Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1624539EDAC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhFHE2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFHE2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:28:24 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F2C061795
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:26:19 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso1286822ook.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCXEcii86TnxHM+iTlFDpyBkTlzyeNdFA6xRxuTg7m0=;
        b=Xk3xbiAopBS7A2l+0wHi8WkzTVq+fIIpM8tbwrloyayW+APYADn1sh+XurBAmEIMe9
         jGsjXu+Zd0lX6uLHn+U71twlovuRzcuOJWRU5DnZFaIYSlaWh5sg1qvwHE5LdhYd97s2
         ujfgM+hC1n/U1Cshy1Nt8ptDFlR580oM9nQm8Er7LlXImZ0xVQ27mJMVvZWc1vyo5MoS
         RLEc6DLcXvYRxF07H32TYNGvzwiT/VBIIWkokDgHop+0NvCm3HMwyzS4kRf9wyQQfiZv
         qoj5dxs5IBY0qxdXkGEOvKgmi6sQJRcpIXUaHgiMxccqNxaaj5HCtgYE+PlZSjpYgblQ
         4uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCXEcii86TnxHM+iTlFDpyBkTlzyeNdFA6xRxuTg7m0=;
        b=a311biqoMj1WXDtM7pGfrLoaNC6Cu6GZmZ+44BdlWz0K0csU0pOJXBWMam7aalipSN
         u67ZCHIfPdiNZyk+vNZnjCQQXzXKx48gSeK+dAW+/WoE/1inVhpOHvZLQVD/56lopWwu
         nFUZgjgcCyHJmIYySkLLOd0r3FWsF07CzOd7G4oxXc5EUxYpKGFspsgL7GuvcSznXpwS
         WdVHXda3Gaw2XnvCePfil/n4rWJWaytF3w7diTasLorWOcxYuW8BqXtUd8Y36QMlKEZe
         Y1lOcDkYuUaiLRhwaXcOvMyEly4CTJSMPaMkM1qIucaW3mrPbMw/I9MJ28PscY3qOHJS
         J5HQ==
X-Gm-Message-State: AOAM532+a1TVB0PZTwZjt2lYdNk0A/woXIxq7hcV1JyZrG7cHM4g1KUI
        MPUhL+3UXUS3rQHIoqenu/MDPZTHg44=
X-Google-Smtp-Source: ABdhPJx9yA/6kTFdbSA8x5/TGJEfcpQmisW3rQR04PWHAQ/VQ0nRQ53Ou8V+D5AMdBk5Mjkxo5M2xA==
X-Received: by 2002:a4a:94ef:: with SMTP id l44mr15739329ooi.84.1623126378154;
        Mon, 07 Jun 2021 21:26:18 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id w6sm2839176otj.5.2021.06.07.21.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 08/10] RDMA/rxe: Implement invalidate MW operations
Date:   Mon,  7 Jun 2021 23:25:51 -0500
Message-Id: <20210608042552.33275-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement invalidate MW and cleaned up invalidate MR operations.

Added code to perform remote invalidate for send with invalidate.
Added code to perform local invalidation. Deleted some blank lines in
rxe_loc.h.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v6:
  Added rxe_ to subroutine names in lines that changed.
v3:
  Replaced enums in lower case with upper case and moved to
  rxe_verbs.h which is where enums live.
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   | 29 ++--------
 drivers/infiniband/sw/rxe/rxe_mr.c    | 81 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 67 ++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_req.c   | 18 +++---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 60 ++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 33 ++++++++---
 7 files changed, 199 insertions(+), 93 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 02bc93e186cc..d4ceb81a96df 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -349,7 +349,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), to_mr_obj, NULL);
+			payload_size(pkt), RXE_TO_MR_OBJ, NULL);
 	if (ret)
 		return COMPST_ERROR;
 
@@ -369,7 +369,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), to_mr_obj, NULL);
+			sizeof(u64), RXE_TO_MR_OBJ, NULL);
 	if (ret)
 		return COMPST_ERROR;
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index e97048e77451..8a4633aeb2a8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -71,46 +71,29 @@ struct rxe_mmap_info *rxe_create_mmap_info(struct rxe_dev *dev, u32 size,
 int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
-enum copy_direction {
-	to_mr_obj,
-	from_mr_obj,
-};
-
 u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
-
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
-
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
-
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum copy_direction dir, u32 *crcp);
-
+		enum rxe_mr_copy_dir dir, u32 *crcp);
 int copy_data(struct rxe_pd *pd, int access,
 	      struct rxe_dma_info *dma, void *addr, int length,
-	      enum copy_direction dir, u32 *crcp);
-
+	      enum rxe_mr_copy_dir dir, u32 *crcp);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-
-enum lookup_type {
-	lookup_local,
-	lookup_remote,
-};
-
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum lookup_type type);
-
+			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
-
-void rxe_mr_cleanup(struct rxe_pool_entry *arg);
-
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cfd35a442c10..3fb58d2c7814 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -55,21 +55,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
-void rxe_mr_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
-	int i;
-
-	ib_umem_release(mr->umem);
-
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
-}
-
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
 	int i;
@@ -298,7 +283,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
  * crc32 if crcp is not zero. caller must hold a reference to mr
  */
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum copy_direction dir, u32 *crcp)
+		enum rxe_mr_copy_dir dir, u32 *crcp)
 {
 	int			err;
 	int			bytes;
@@ -316,9 +301,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (mr->type == RXE_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
-		src = (dir == to_mr_obj) ? addr : ((void *)(uintptr_t)iova);
+		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
 
-		dest = (dir == to_mr_obj) ? ((void *)(uintptr_t)iova) : addr;
+		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
 
 		memcpy(dest, src, length);
 
@@ -346,8 +331,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		u8 *src, *dest;
 
 		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == to_mr_obj) ? addr : va;
-		dest = (dir == to_mr_obj) ? va : addr;
+		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
+		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
 
 		bytes	= buf->size - offset;
 
@@ -392,7 +377,7 @@ int copy_data(
 	struct rxe_dma_info	*dma,
 	void			*addr,
 	int			length,
-	enum copy_direction	dir,
+	enum rxe_mr_copy_dir	dir,
 	u32			*crcp)
 {
 	int			bytes;
@@ -412,7 +397,7 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
 		if (!mr) {
 			err = -EINVAL;
 			goto err1;
@@ -438,7 +423,7 @@ int copy_data(
 
 			if (sge->length) {
 				mr = lookup_mr(pd, access, sge->lkey,
-					       lookup_local);
+					       RXE_LOOKUP_LOCAL);
 				if (!mr) {
 					err = -EINVAL;
 					goto err1;
@@ -520,7 +505,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
  * (4) verify that mr state is valid
  */
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum lookup_type type)
+			 enum rxe_mr_lookup_type type)
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
@@ -530,8 +515,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	if (!mr)
 		return NULL;
 
-	if (unlikely((type == lookup_local && mr_lkey(mr) != key) ||
-		     (type == lookup_remote && mr_rkey(mr) != key) ||
+	if (unlikely((type == RXE_LOOKUP_LOCAL && mr_lkey(mr) != key) ||
+		     (type == RXE_LOOKUP_REMOTE && mr_rkey(mr) != key) ||
 		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
 		     mr->state != RXE_MR_STATE_VALID)) {
 		rxe_drop_ref(mr);
@@ -540,3 +525,47 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	return mr;
 }
+
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
+	int ret;
+
+	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	if (!mr) {
+		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (rkey != mr->ibmr.rkey) {
+		pr_err("%s: rkey (%#x) doesn't match mr->ibmr.rkey (%#x)\n",
+			__func__, rkey, mr->ibmr.rkey);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	mr->state = RXE_MR_STATE_FREE;
+	ret = 0;
+
+err_drop_ref:
+	rxe_drop_ref(mr);
+err:
+	return ret;
+}
+
+void rxe_mr_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
+	int i;
+
+	ib_umem_release(mr->umem);
+
+	if (mr->map) {
+		for (i = 0; i < mr->num_map; i++)
+			kfree(mr->map[i]);
+
+		kfree(mr->map);
+	}
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 65215dde9974..594f8cef0a08 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -245,6 +245,73 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return ret;
 }
 
+static int rxe_check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	if (unlikely(mw->state == RXE_MW_STATE_INVALID))
+		return -EINVAL;
+
+	/* o10-37.2.26 */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void rxe_do_invalidate_mw(struct rxe_mw *mw)
+{
+	struct rxe_qp *qp;
+	struct rxe_mr *mr;
+
+	/* valid type 2 MW will always have a QP pointer */
+	qp = mw->qp;
+	mw->qp = NULL;
+	rxe_drop_ref(qp);
+
+	/* valid type 2 MW will always have an MR pointer */
+	mr = mw->mr;
+	mw->mr = NULL;
+	atomic_dec(&mr->num_mw);
+	rxe_drop_ref(mr);
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_FREE;
+}
+
+int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned long flags;
+	struct rxe_mw *mw;
+	int ret;
+
+	mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
+	if (!mw) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (rkey != mw->ibmw.rkey) {
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = rxe_check_invalidate_mw(qp, mw);
+	if (ret)
+		goto err_unlock;
+
+	rxe_do_invalidate_mw(mw);
+err_unlock:
+	spin_unlock_irqrestore(&mw->lock, flags);
+err_drop_ref:
+	rxe_drop_ref(mw);
+err:
+	return ret;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 6583f8ca95dc..c57699cc6578 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -487,7 +487,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		} else {
 			err = copy_data(qp->pd, 0, &wqe->dma,
 					payload_addr(pkt), paylen,
-					from_mr_obj,
+					RXE_FROM_MR_OBJ,
 					&crc);
 			if (err)
 				return err;
@@ -581,27 +581,25 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	u8 opcode = wqe->wr.opcode;
-	struct rxe_dev *rxe;
 	struct rxe_mr *mr;
 	u32 rkey;
 	int ret;
 
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
-		rxe = to_rdev(qp->ibqp.device);
 		rkey = wqe->wr.ex.invalidate_rkey;
-		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-		if (!mr) {
-			pr_err("No MR for rkey %#x\n", rkey);
+		if (rkey_is_mw(rkey))
+			ret = rxe_invalidate_mw(qp, rkey);
+		else
+			ret = rxe_invalidate_mr(qp, rkey);
+
+		if (unlikely(ret)) {
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
-			return -EINVAL;
+			return ret;
 		}
-		mr->state = RXE_MR_STATE_FREE;
-		rxe_drop_ref(mr);
 		break;
 	case IB_WR_REG_MR:
 		mr = to_rmr(wqe->wr.wr.reg.mr);
-
 		rxe_add_ref(mr);
 		mr->state = RXE_MR_STATE_VALID;
 		mr->access = wqe->wr.wr.reg.access;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9c0ce1a4f2ea..5eca374149f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -35,6 +35,7 @@ enum resp_states {
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
 	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
 	RESPST_ERROR,
@@ -68,6 +69,7 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			= "ERR_RNR",
 	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
 	[RESPST_ERROR]				= "ERROR",
@@ -449,7 +451,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
+	mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 	if (!mr) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
@@ -503,7 +505,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, to_mr_obj, NULL);
+			data_addr, data_len, RXE_TO_MR_OBJ, NULL);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -519,7 +521,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int data_len = payload_size(pkt);
 
 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt), data_len,
-			  to_mr_obj, NULL);
+			  RXE_TO_MR_OBJ, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -720,7 +722,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 
 	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, from_mr_obj, &icrc);
+			  payload, RXE_FROM_MR_OBJ, &icrc);
 	if (err)
 		pr_err("Failed copying memory\n");
 
@@ -770,6 +772,14 @@ static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
 		memcpy(&hdr->ibgrh, ipv6_hdr(skb), sizeof(hdr->ibgrh));
 }
 
+static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
+{
+	if (rkey_is_mw(rkey))
+		return rxe_invalidate_mw(qp, rkey);
+	else
+		return rxe_invalidate_mr(qp, rkey);
+}
+
 /* Executes a new request. A retried request never reach that function (send
  * and writes are discarded, and reads and atomics are retried elsewhere.
  */
@@ -809,6 +819,14 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		WARN_ON_ONCE(1);
 	}
 
+	if (pkt->mask & RXE_IETH_MASK) {
+		u32 rkey = ieth_rkey(pkt);
+
+		err = invalidate_rkey(qp, rkey);
+		if (err)
+			return RESPST_ERR_INVALIDATE_RKEY;
+	}
+
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
 	qp->resp.ack_psn = qp->resp.psn;
@@ -841,13 +859,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
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
@@ -902,27 +920,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mr *rmr;
-
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
-
-				rmr = rxe_pool_get_index(&rxe->mr_pool,
-							 wc->ex.invalidate_rkey >> 8);
-				if (unlikely(!rmr)) {
-					pr_err("Bad rkey %#x invalidation\n",
-					       wc->ex.invalidate_rkey);
-					return RESPST_ERROR;
-				}
-				rmr->state = RXE_MR_STATE_FREE;
-				rxe_drop_ref(rmr);
 			}
 
-			wc->qp			= &qp->ibqp;
-
 			if (pkt->mask & RXE_DETH_MASK)
 				wc->src_qp = deth_sqp(pkt);
 
+			wc->qp			= &qp->ibqp;
 			wc->port_num		= qp->attr.port_num;
 		}
 	}
@@ -1336,6 +1341,13 @@ int rxe_responder(void *arg)
 			}
 			break;
 
+		case RESPST_ERR_INVALIDATE_RKEY:
+			/* RC - Class J. */
+			qp->resp.goto_error = 1;
+			qp->resp.status = IB_WC_REM_INV_REQ_ERR;
+			state = RESPST_COMPLETE;
+			break;
+
 		case RESPST_ERR_LENGTH:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 3d0ab8b7804f..47399bf7517e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -278,6 +278,16 @@ enum rxe_mr_type {
 	RXE_MR_TYPE_MR,
 };
 
+enum rxe_mr_copy_dir {
+	RXE_TO_MR_OBJ,
+	RXE_FROM_MR_OBJ,
+};
+
+enum rxe_mr_lookup_type {
+	RXE_LOOKUP_LOCAL,
+	RXE_LOOKUP_REMOTE,
+};
+
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
 
 struct rxe_phys_buf {
@@ -289,6 +299,13 @@ struct rxe_map {
 	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
 };
 
+static inline int rkey_is_mw(u32 rkey)
+{
+	u32 index = rkey >> 8;
+
+	return (index >= RXE_MIN_MW_INDEX) && (index <= RXE_MAX_MW_INDEX);
+}
+
 struct rxe_mr {
 	struct rxe_pool_entry	pelem;
 	struct ib_mr		ibmr;
@@ -314,23 +331,23 @@ struct rxe_mr {
 	u32			max_buf;
 	u32			num_map;
 
-	struct rxe_map		**map;
-
 	atomic_t		num_mw;
+
+	struct rxe_map		**map;
 };
 
 enum rxe_mw_state {
-	RXE_MW_STATE_INVALID = RXE_MR_STATE_INVALID,
-	RXE_MW_STATE_FREE = RXE_MR_STATE_FREE,
-	RXE_MW_STATE_VALID = RXE_MR_STATE_VALID,
+	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
+	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
+	RXE_MW_STATE_VALID	= RXE_MR_STATE_VALID,
 };
 
 struct rxe_mw {
-	struct			ib_mw ibmw;
-	struct			rxe_pool_entry pelem;
+	struct ib_mw		ibmw;
+	struct rxe_pool_entry	pelem;
 	spinlock_t		lock;
 	enum rxe_mw_state	state;
-	struct rxe_qp		*qp;	/* Type 2 only */
+	struct rxe_qp		*qp; /* Type 2 only */
 	struct rxe_mr		*mr;
 	int			access;
 	u64			addr;
-- 
2.30.2

