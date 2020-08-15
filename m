Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1A2453D9
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHOWGg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgHOVuu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:50:50 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC0C061245
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a24so10023116oia.6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InR5d1hd9b3FcLVrQ7NRWlNcnQGBJgEgwy2RYEL1XZo=;
        b=jnxu74mYdJVmYo1k15ZooLlwGdJ98vWku7mv4wCGuSCylz4A2JBgbgKRvg/YLQqsVI
         kJ5Yvq2NqApYox9QVOvE2kP+IVg6Optn5NmqwX3pUBui4S2PWpKljIxLwqwXVyJLPJYv
         m39IKATmRH3JEPSkGBM9ODydwQtEjpz7b2A49j2bepP9U3dSZayUWaCTTdAw7aVcrlHr
         slv8FP5OQYZY3sOQrwG7BaDHeGIi4O99g4BbLqxNtJCiCh68hf6WdNDl+0kkgr7RZFbk
         vJkuN40xBTUVTZrUDIJR8uNA08jWxgaH/3WjpKkxKmFI0RXueOIrPRLa9/LFggXc+Osf
         GLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InR5d1hd9b3FcLVrQ7NRWlNcnQGBJgEgwy2RYEL1XZo=;
        b=DilYA1U4DcN5fSgkO98j/DU/OAQI8wHzNb8MueRCDLF2RDV3hFzbOzzwWk6XprXxJ8
         h9R6XL3uNt1uKHXeeiY5mcD3Jn2hWc6NDAFJY0OJq6XOOd3WxolhodGGjpeqykvDrjQU
         f4/zR/Boq/tvtacWHL1IAEOh6PAktkYoEd+MRu58i8lx8wcGmh9x9yvjePtV2ebk5SUb
         EghUS7HCtHxQxgSVTGTQ8cSsqpK247S2BKczarWlreNT13alqkiAYG2x/saljrwzWMoK
         mwuVhPHHcS9EyP3yXj1KMvGuqhlbOnVVrcrtg+o50ztAhvuaYblLL15mQ+PI/dFYPn5h
         MpuA==
X-Gm-Message-State: AOAM533TYAgA4CZWwkKHQGBxEe2bM46IQ/qc6QsunW84A6OCMEJ1Y8gK
        1IWyJCt2Jhrkn6vAhccHh82QyRQCgEnBfw==
X-Google-Smtp-Source: ABdhPJykrlBB7jxlE0D79tuII6qHhJY4nT9REdPMvtozxkfaCc64EY8xN6zhmdEOnc7lAEbaZN2hSQ==
X-Received: by 2002:aca:306:: with SMTP id 6mr3456506oid.53.1597467608350;
        Fri, 14 Aug 2020 22:00:08 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id 1sm2099287otc.44.2020.08.14.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 18/20] cleanup
Date:   Fri, 14 Aug 2020 23:58:42 -0500
Message-Id: <20200815045912.8626-19-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch culls some left over comments and made things a little
neater.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  10 +--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  37 +++------
 drivers/infiniband/sw/rxe/rxe_mr.c    | 106 ++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 115 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c   |  33 +++-----
 drivers/infiniband/sw/rxe/rxe_resp.c  |  57 ++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  17 ++--
 7 files changed, 208 insertions(+), 167 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2a094621486..ed9e27eeaadd 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -790,23 +790,19 @@ int rxe_completer(void *arg)
 		}
 	}
 
-	/* these are the same. need to merge them TODO */
 exit:
 	/* we come here if we are done with processing and want the task to
-	 * exit from the loop calling us -- to call us again later
-	 */
+	 * exit from the loop calling us */
 	WARN_ON_ONCE(skb);
 	atomic_dec(&qp->comp.task.entered);
 	rxe_drop_ref(qp);
 	return -EAGAIN;
 
 done:
-	/* we come here if we have processed a packet we want the task to call
-	 * us again to see if there is anything else to do
-	 */
+	/* we come here if we have processed a packet and we want
+	 * to be called again to see if there is anything else to do */
 	WARN_ON_ONCE(skb);
 	atomic_dec(&qp->comp.task.entered);
 	rxe_drop_ref(qp);
 	return 0;
-
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 652e0d67fe5c..2421ca311845 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -99,45 +99,26 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 void rxe_set_mr_lkey(struct rxe_mr *mr);
-
 enum copy_direction {
 	to_mr_obj,
 	from_mr_obj,
 };
-
-void rxe_mr_init_dma(struct rxe_pd *pd,
-		     int access, struct rxe_mr *mr);
-
-int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
-		      u64 length, u64 iova, int access, struct ib_udata *udata,
-		      struct rxe_mr *mr);
-
-int rxe_mr_init_fast(struct rxe_pd *pd,
-		      int max_pages, struct rxe_mr *mr);
-
+void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
+int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length,
+		     u64 iova, int access, struct ib_udata *udata,
+		     struct rxe_mr *mr);
+int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
-		 int length, enum copy_direction dir, u32 *crcp);
-
+		int length, enum copy_direction dir, u32 *crcp);
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
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			   enum lookup_type type);
-
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
-
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
-
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr);
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid);
 
 /* rxe_mw.c */
 void rxe_set_mw_rkey(struct rxe_mw *mw);
@@ -147,6 +128,8 @@ int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid);
 
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index a983a838bf4c..ce64d4101888 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -43,33 +43,14 @@ void rxe_set_mr_lkey(struct rxe_mr *mr)
 
 	do {
 		get_random_bytes(&lkey, sizeof(lkey));
-		lkey &= 0x7fffffff;
+		lkey &= ~IS_MW;
 		if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
 			return;
 	} while (tries++ < 10);
 	pr_err("unable to get random key for mr\n");
 }
 
-#if 0
-/*
- * lfsr (linear feedback shift register) with period 255
- */
-static u8 rxe_get_key(void)
-{
-	static u32 key = 1;
-
-	key = key << 1;
-
-	key |= (0 != (key & 0x100)) ^ (0 != (key & 0x10))
-		^ (0 != (key & 0x80)) ^ (0 != (key & 0x40));
-
-	key &= 0xff;
-
-	return key;
-}
-#endif
-
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
+static int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
 	switch (mr->type) {
 	case RXE_MEM_TYPE_DMA:
@@ -430,6 +411,25 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	return err;
 }
 
+static struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 lkey)
+{
+	struct rxe_mr *mr;
+	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
+
+	mr = rxe_pool_get_key(&rxe->mr_pool, &lkey);
+	if (!mr)
+		return NULL;
+
+	if (unlikely((mr->ibmr.lkey != lkey) || (mr->pd != pd) ||
+		     (access && !(access & mr->access)) ||
+		     (mr->state != RXE_MEM_STATE_VALID))) {
+		rxe_drop_ref(mr);
+		return NULL;
+	}
+
+	return mr;
+}
+
 /* copy data in or out of a wqe, i.e. sg list
  * under the control of a dma descriptor
  */
@@ -459,7 +459,7 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		mr = lookup_mr(pd, access, sge->lkey);
 		if (!mr) {
 			err = -EINVAL;
 			goto err1;
@@ -484,8 +484,7 @@ int copy_data(
 			}
 
 			if (sge->length) {
-				mr = lookup_mr(pd, access, sge->lkey,
-						 lookup_local);
+				mr = lookup_mr(pd, access, sge->lkey);
 				if (!mr) {
 					err = -EINVAL;
 					goto err1;
@@ -560,34 +559,6 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mr (mr or mw) corresponding to lkey/rkey
- *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mr pd
- * (3) verify that the mr can support the requested access
- * (4) verify that mr state is valid
- */
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum lookup_type type)
-{
-	struct rxe_mr *mr;
-	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
-
-	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
-	if (!mr)
-		return NULL;
-
-	if (unlikely((type == lookup_local && mr->ibmr.lkey != key) ||
-		     (type == lookup_remote && mr->ibmr.rkey != key) ||
-		     mr->pd != pd ||
-		     (access && !(access & mr->access)) ||
-		     mr->state != RXE_MEM_STATE_VALID)) {
-		rxe_drop_ref(mr);
-		mr = NULL;
-	}
-
-	return mr;
-}
-
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
 	// much more TODO here, can fail
@@ -599,6 +570,37 @@ int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 	return 0;
 }
 
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid)
+{
+	int ret;
+	struct rxe_pd *pd = to_rpd(mr->ibmr.pd);
+
+	if (unlikely(mr->state != RXE_MEM_STATE_VALID)) {
+		pr_err("attempt to access a MR that is"
+			" not in the valid state\n");
+		return -EINVAL;
+	}
+
+	/* C10-56 */
+	if (unlikely(pd != qp->pd)) {
+		pr_err("attempt to access a MR with a"
+			" different PD than the QP\n");
+		return -EINVAL;
+	}
+
+	/* C10-57 */
+	if (unlikely(access && !(access & mr->access))) {
+		pr_err("attempt to access a MR that does"
+			" not have the required access rights\n");
+		return -EINVAL;
+	}
+
+	ret = mr_check_range(mr, va, resid);
+
+	return ret;
+}
+
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 0c774aadf6c7..6b998527b34b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -44,8 +44,8 @@ void rxe_set_mw_rkey(struct rxe_mw *mw)
 
 	do {
 		get_random_bytes(&rkey, sizeof(rkey));
-		rkey |= 0x80000000;
-		if (likely((rkey & 0x7fffffff) &&
+		rkey |= IS_MW;
+		if (likely((rkey & ~IS_MW) &&
 			   (rxe_add_key(mw, &rkey) == 0)))
 			return;
 	} while (tries++ < 10);
@@ -77,10 +77,10 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 
 	switch (type) {
 	case IB_MW_TYPE_1:
-		mw->state	= RXE_MW_STATE_VALID;
+		mw->state	= RXE_MEM_STATE_VALID;
 		break;
 	case IB_MW_TYPE_2:
-		mw->state	= RXE_MW_STATE_FREE;
+		mw->state	= RXE_MEM_STATE_FREE;
 		break;
 	default:
 		pr_err("attempt to allocate MW with unknown type\n");
@@ -166,7 +166,7 @@ static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 
 	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) &&
-			(mw->state != RXE_MW_STATE_VALID))) {
+			(mw->state != RXE_MEM_STATE_VALID))) {
 		pr_err("attempt to bind a type 1 MW not in the"
 			" valid state\n");
 		return -EINVAL;
@@ -195,7 +195,7 @@ static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	/* o10-37.2.30: */
 	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) &&
-			(mw->state != RXE_MW_STATE_FREE))) {
+			(mw->state != RXE_MEM_STATE_FREE))) {
 		pr_err("attempt to bind a type 2 MW not in the"
 			" free state\n");
 		return -EINVAL;
@@ -217,9 +217,6 @@ static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		return -EINVAL;
 	}
 
-	/* MR duplicates address and length in the private and ib
-	 * parts of the rxe_mr struct. TODO should only keep one. */
-
 	/* C10-75: */
 	if (mw->access & IB_ZERO_BASED) {
 		if (unlikely(wqe->wr.wr.umw.length > mr->length)) {
@@ -240,13 +237,29 @@ static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	return 0;
 }
 
-static void do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			struct rxe_mw *mw, struct rxe_mr *mr)
 {
+	int ret;
 	u32 rkey;
+	u32 new_rkey;
+
+	/* key part of new rkey is provided by user for type 2
+	 * and ibv_bind_mw() for type 1 MWs */
+	rkey = mw->ibmw.rkey;
+	rxe_drop_key(mw);
+	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
+	ret = rxe_add_key(mw, &new_rkey);
+	if (ret) {
+		/* this should never happen */
+		pr_err("shouldn't happen unable to set new rkey\n");
+		/* try to put back the old one */
+		rxe_add_key(mw, &rkey);
+		return ret;
+	}
 
 	mw->access = wqe->wr.wr.umw.access;
-	mw->state = RXE_MW_STATE_VALID;
+	mw->state = RXE_MEM_STATE_VALID;
 	mw->addr = wqe->wr.wr.umw.addr;
 	mw->length = wqe->wr.wr.umw.length;
 
@@ -272,14 +285,7 @@ static void do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		mw->qp = qp;
 	}
 
-	/* key part of new rkey is provided by user for type 2
-	 * and ibv_bind_mw() for type 1 MWs */
-	rkey = mw->ibmw.rkey;
-	rxe_drop_key(mw);
-	rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
-	rxe_add_key(mw, &rkey);
-
-	return;
+	return 0;
 }
 
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
@@ -326,7 +332,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		goto err3;
 
 	/* implement the change */
-	do_bind_mw(qp, wqe, mw, mr);
+	ret = do_bind_mw(qp, wqe, mw, mr);
 err3:
 	spin_unlock_irqrestore(&mw->lock, flags);
 
@@ -340,15 +346,15 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 {
-	/* o10-37.2.26: */
-	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
-		pr_err("attempt to invalidate a type 1 MW\n");
+	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
+		pr_warn("attempt to invalidate a MW that"
+			" is not valid\n");
 		return -EINVAL;
 	}
 
-	if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
-		pr_warn("attempt to invalidate a MW that"
-			" is not valid\n");
+	/* o10-37.2.26: */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
+		pr_err("attempt to invalidate a type 1 MW\n");
 		return -EINVAL;
 	}
 
@@ -366,7 +372,7 @@ static void do_invalidate_mw(struct rxe_mw *mw)
 	mw->access = 0;
 	mw->addr = 0; 
 	mw->length = 0;
-	mw->state = RXE_MW_STATE_FREE;
+	mw->state = RXE_MEM_STATE_FREE;
 }
 
 int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
@@ -387,7 +393,7 @@ int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 	return ret;
 }
 
-static void do_deallocate_mw(struct rxe_mw *mw)
+static void do_dealloc_mw(struct rxe_mw *mw)
 {
 	mw->qp = NULL;
 
@@ -397,10 +403,11 @@ static void do_deallocate_mw(struct rxe_mw *mw)
 		mw->mr = NULL;
 	}
 
+	mw->ibmw.pd = NULL;
 	mw->access = 0;
 	mw->addr = 0; 
 	mw->length = 0;
-	mw->state = RXE_MW_STATE_INVALID;
+	mw->state = RXE_MEM_STATE_INVALID;
 }
 
 int rxe_dealloc_mw(struct ib_mw *ibmw)
@@ -411,7 +418,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 
 	spin_lock_irqsave(&mw->lock, flags);
 
-	do_deallocate_mw(mw);
+	do_dealloc_mw(mw);
 
 	spin_unlock_irqrestore(&mw->lock, flags);
 
@@ -421,6 +428,54 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	return 0;
 }
 
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid)
+{
+	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
+
+	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
+		pr_err("attempt to access a MW that is"
+			" not in the valid state\n");
+		return -EINVAL;
+	}
+
+	/* C10-76.2.1 */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) && (pd != qp->pd))) {
+		pr_err("attempt to access a type 1 MW with a"
+			" different PD than the QP\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.43 */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) && (mw->qp != qp))) {
+		pr_err("attempt to access a type 2 MW that is"
+			" associated with a different QP\n");
+		return -EINVAL;
+	}
+
+	/* C10-77 */
+	if (unlikely(access && !(access & mw->access))) {
+		pr_err("attempt to access a MW that does"
+			" not have the required access rights\n");
+		return -EINVAL;
+	}
+
+	if (mw->access & IB_ZERO_BASED) {
+		if (unlikely((va + resid) > mw->length)) {
+			pr_err("attempt to access a MW out of bounds\n");
+			return -EINVAL;
+		}
+	} else {
+		if (unlikely((va < mw->addr) ||
+			((va + resid) > (mw->addr + mw->length)))) {
+			pr_err("attempt to access a MW out of bounds\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ad747f230318..f0fa195fcc70 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -591,7 +591,7 @@ static int local_invalidate(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 key = wqe->wr.ex.invalidate_rkey;
 
-	if ((mr = rxe_pool_get_key(&rxe->mr_pool, &key))) {
+	if (!(key & IS_MW) && (mr = rxe_pool_get_key(&rxe->mr_pool, &key))) {
 		ret = rxe_invalidate_mr(qp, mr);
 		rxe_drop_ref(mr);
 	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &key))) {
@@ -732,12 +732,7 @@ int rxe_requester(void *arg)
 	payload = (mask & RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
 	if (payload > mtu) {
 		if (qp_type(qp) == IB_QPT_UD) {
-			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
-			 * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
-			 * shall not emit any packets for this message. Further, the CI shall not
-			 * generate an error due to this condition.
-			 */
-
+			/* C10-93.1.1 */
 			/* fake a successful UD send */
 			wqe->first_psn = qp->req.psn;
 			wqe->last_psn = qp->req.psn;
@@ -747,8 +742,13 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			// TODO why?? why not just treat the same as a
-			// successful wqe and go to next wqe?
+
+			/* TODO why?? why not just treat the same as a
+			 * successful wqe and go to next wqe?
+			 * __rxe_do_task probably shouldn't be used
+			 * it reenters the completion task which may
+			 * already be running
+			 */
 			__rxe_do_task(&qp->comp.task);
 			goto again;
 		}
@@ -789,7 +789,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
-		wqe->status = IB_WC_LOC_PROT_ERR;	// ?? FIXME
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -797,17 +797,12 @@ int rxe_requester(void *arg)
 
 	goto next_wqe;
 
-	// TODO this can be cleaned up
 err:
 	/* we come here if an error occured while processing
 	 * a send wqe. The completer will put the qp in error
 	 * state and no more wqes will be processed unless
-	 * the qp is cleaned up and restarted. We do not want
-	 * to be called again */
+	 * the qp is cleaned up and restarted. */
 	wqe->state = wqe_state_error;
-	// ?? we want to force the qp into error state before
-	// anyone else has a chance to process another wqe but
-	// this could collide with an already running completer
 	__rxe_do_task(&qp->comp.task);
 	ret = -EAGAIN;
 	goto done;
@@ -816,14 +811,12 @@ int rxe_requester(void *arg)
 	/* we come here if either there are no more wqes in the send
 	 * queue or we are blocked waiting for some resource or event.
 	 * The current wqe will be restarted or new wqe started when
-	 * there is work to do. */
+	 * there is something to do. */
 	ret = -EAGAIN;
 	goto done;
 
 again:
-	/* we come here if we are done with the current wqe but want to
-	 * get called again. Mostly we loop back to next wqe so should
-	 * be all one way or the other */
+	/* we come here if we need to exit and reenter the task */
 	ret = 0;
 	goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 49cd77cd6264..0bfea50505d1 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -417,7 +417,9 @@ static enum resp_states check_length(struct rxe_qp *qp,
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
-	struct rxe_mr *mr = NULL;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -425,6 +427,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	int mtu = qp->mtu;
 	enum resp_states state;
 	int access;
+	unsigned long flags;
 
 	if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
@@ -432,13 +435,16 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 			qp->resp.rkey = reth_rkey(pkt);
 			qp->resp.resid = reth_len(pkt);
 			qp->resp.length = reth_len(pkt);
+			qp->resp.offset = 0;
 		}
-		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
-						     : IB_ACCESS_REMOTE_WRITE;
+		access = (pkt->mask & RXE_READ_MASK)
+				? IB_ACCESS_REMOTE_READ
+				: IB_ACCESS_REMOTE_WRITE;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		qp->resp.va = atmeth_va(pkt);
 		qp->resp.rkey = atmeth_rkey(pkt);
 		qp->resp.resid = sizeof(u64);
+		qp->resp.offset = 0;
 		access = IB_ACCESS_REMOTE_ATOMIC;
 	} else {
 		return RESPST_EXECUTE;
@@ -456,18 +462,31 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
-	if (!mr) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
-	}
+	if ((rkey & IS_MW) && (mw = rxe_pool_get_key(&rxe->mw_pool, &rkey))) {
+		spin_lock_irqsave(&mw->lock, flags);
+		if (rxe_mw_check_access(qp, mw, access, va, resid)) {
+			spin_unlock_irqrestore(&mw->lock, flags);
+			rxe_drop_ref(mw);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
 
-	if (unlikely(mr->state == RXE_MEM_STATE_FREE)) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
-	}
+		mr = mw->mr;
+		rxe_add_ref(mr);
+
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset = mw->addr;
 
-	if (mr_check_range(mr, va, resid)) {
+		spin_unlock_irqrestore(&mw->lock, flags);
+		rxe_drop_ref(mw);
+	} else if ((mr = rxe_pool_get_key(&rxe->mr_pool, &rkey)) &&
+		   (mr->rkey == rkey)) {
+		if (rxe_mr_check_access(qp, mr, access, va, resid)) {
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
+	} else {
+		pr_err("no MR/MW found with rkey = 0x%08x\n", rkey);
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
@@ -525,8 +544,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
-			   data_len, to_mr_obj, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+			payload_addr(pkt), data_len, to_mr_obj, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -545,17 +564,11 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
 static enum resp_states process_atomic(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	u64 iova = atmeth_va(pkt);
 	u64 *vaddr;
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
 
-	if (mr->state != RXE_MEM_STATE_VALID) {
-		ret = RESPST_ERR_RKEY_VIOLATION;
-		goto out;
-	}
-
-	vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
+	vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
 
 	/* check vaddr is 8 bytes aligned. */
 	if (!vaddr || (uintptr_t)vaddr & 7) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 2fe8433d0801..b4855d3ea6f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -210,6 +210,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
+	u64			offset;
 	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
@@ -289,7 +290,8 @@ struct rxe_qp {
 	struct execute_work	cleanup_work;
 };
 
-enum rxe_mr_state {
+/* common state for rxe_mr and rxe_mw */
+enum rxe_mem_state {
 	RXE_MEM_STATE_ZOMBIE,
 	RXE_MEM_STATE_INVALID,
 	RXE_MEM_STATE_FREE,
@@ -325,7 +327,7 @@ struct rxe_mr {
 	u32			lkey;
 	u32			rkey;
 
-	enum rxe_mr_state	state;
+	enum rxe_mem_state	state;
 	enum rxe_mr_type	type;
 	u64			va;
 	u64			iova;
@@ -349,24 +351,21 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
-enum rxe_mw_state {
-	RXE_MW_STATE_INVALID,
-	RXE_MW_STATE_FREE,
-	RXE_MW_STATE_VALID,
-};
-
 enum rxe_send_flags {
 	/* flag indicaes bind call came through verbs API */
 	RXE_BIND_MW		= (1 << 0),
 };
 
+/* use high order bit to separate MW and MR rkeys */
+#define IS_MW	(1 << 31)
+
 struct rxe_mw {
 	struct rxe_pool_entry	pelem;
 	struct ib_mw		ibmw;
 	struct rxe_mr		*mr;
 	struct rxe_qp		*qp;	/* type 2B only */
 	spinlock_t		lock;
-	enum rxe_mw_state	state;
+	enum rxe_mem_state	state;
 	u32			access;
 	u64			addr;
 	u64			length;
-- 
2.25.1

