Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC12452B2
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgHOVyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgHOVwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFECC061244
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id h3so9986526oie.11
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t17wqw+dfna8L/zhx55t2XMFpesJUAGIa/Mi9u6M7/o=;
        b=gR8LI3dV66T+Q3qzkfQFc5dmFqGDZnGBsk5WwjBbvWX5xffjT1SuBbdKtgkgrlvNTa
         QDAaCBrN01iw77mutgdw5IMtvdk56FnuCVAquVJn9tm6lYvFhvcVlIjehWuq+iA21R5/
         x4ZTmaG6f7ZCi+ZBf2qrMc3Ns7KNCHuZzOO8kGBZF1xwCXTLwQNESHdaf8LtagumMAA/
         49Yu1jkmoscfBGc6+bO1w/dkIZnqQxWvQ0tGUHVVpA33HfdkE6m9M6cGUhRxc9CQYZl7
         5h4gD8zPAyp6PCUf6R49mZ84hId9Yb03QPftnmPL3PVhK88mFldBuxJtRt/0N/GknIaY
         sW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t17wqw+dfna8L/zhx55t2XMFpesJUAGIa/Mi9u6M7/o=;
        b=thR17XG4G+OTx9nESxwFQ0onskiKDnBfW+QRC2FKcCJwcj0VOK88cw0ZBQVUCKqPXc
         PwnRTAYV3LfCuC40LnNa1ePA7hwuxzg6uy7Ed9vbWoSp7XI0AzT87SFyrKqSRHEFMQPZ
         XGjtWQN8CtOU83gZxUaTRzUp/6ZOQ9CLP1rk4VlCdtaXGvYCeZNvzU3HdreEnB/cOHgS
         VA7o0zqqUyjBWOrGgQdG6XhxQP8FeNwVgKK4iEQSCmMY2bqhifP1ARGCAWAjStMTKlyh
         HVowcotEpkHa4PjcNS2BHVgewXU7SP+XAWOVihyrUfXwxeiDAilbGDdGXUrPvlkc56+1
         eGGg==
X-Gm-Message-State: AOAM530jMEPo4FNvLPZiHTlCaN+XeAJl3OmP0LVrVK75IOANRGzM2kD9
        gldObIPOqiY0lfJVcPuIHqNCR6gztdt0Zg==
X-Google-Smtp-Source: ABdhPJwnR+pP8Uz9iAPymU5AJrSHda5dFsnnkgVE//7uyMPCWDn3zRqgXqJ+Xk5aJMhOcIJgWM7S7Q==
X-Received: by 2002:aca:fc4e:: with SMTP id a75mr3691102oii.46.1597467607669;
        Fri, 14 Aug 2020 22:00:07 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id l4sm2091823oog.1.2020.08.14.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 17/20] Implemented functional invalidate APIs
Date:   Fri, 14 Aug 2020 23:58:41 -0500
Message-Id: <20200815045912.8626-18-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Made progress on details of mw alloc, bind, invalidate
and dealloc. added a private flags field in rxe_send_wqe to allow ibv_bind_mw
to safely tell the kernel that bind has come through ibv_bind_mw.
The IBA requires that type 1 MWs can only be bound by the ibv_bind_mw
API and type 2 MWs by send WRs. But we implement the bind_mw call with
WRs too since rdma-core does not implement the verbs call. Need to
cleanly separate the two cases.

After implementing the checking core for MWs it is clear that MRs require
more effort to comply with the standard.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  44 +--
 drivers/infiniband/sw/rxe/rxe_mw.c    | 383 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_param.h |   2 +
 drivers/infiniband/sw/rxe/rxe_req.c   |  23 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  25 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   9 +-
 include/uapi/rdma/rdma_user_rxe.h     |   2 +
 9 files changed, 366 insertions(+), 138 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1ddd1b5721d8..652e0d67fe5c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -137,7 +137,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-int rxe_invalidate_mr(struct rxe_mr *mr, int remote);
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr);
 
 /* rxe_mw.c */
 void rxe_set_mw_rkey(struct rxe_mw *mw);
@@ -146,7 +146,7 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
-int rxe_invalidate_mw(struct rxe_mw *mw, int remote);
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
 
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bebcce06e804..a983a838bf4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -109,25 +109,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->map_shift		= ilog2(RXE_BUF_PER_MAP);
 }
 
-void rxe_mr_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
-	int i;
-
-	if (mr->umem)
-		ib_umem_release(mr->umem);
-
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
-
-	rxe_drop_index(mr);
-	rxe_drop_key(mr);
-}
-
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
 	int i;
@@ -607,11 +588,32 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	return mr;
 }
 
-int rxe_invalidate_mr(struct rxe_mr *mr, int remote)
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
-	// more TODO here, can fail
+	// much more TODO here, can fail
+	// mw is closer to what is needed
+	// but for another day
 
 	mr->state = RXE_MEM_STATE_FREE;
 
 	return 0;
 }
+
+void rxe_mr_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
+	int i;
+
+	if (mr->umem)
+		ib_umem_release(mr->umem);
+
+	if (mr->map) {
+		for (i = 0; i < mr->num_map; i++)
+			kfree(mr->map[i]);
+
+		kfree(mr->map);
+	}
+
+	rxe_drop_index(mr);
+	rxe_drop_key(mr);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 7092045a2691..0c774aadf6c7 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -52,29 +52,17 @@ void rxe_set_mw_rkey(struct rxe_mw *mw)
 	pr_err("unable to get random rkey for mw\n");
 }
 
-
-/* place holder alloc and dealloc routines
- * TODO add cross references between qp and mr with mw
- * and cleanup when one side is deleted. Enough to make
- * verbs function correctly for now */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata)
 {
 	int ret;
+	int index;
 	struct rxe_mw *mw;
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_alloc_mw_resp __user *uresp;
 
-	if (udata) {
-		if (udata->outlen < sizeof(*uresp)) {
-			ret = -EINVAL;
-			goto err1;
-		}
-	}
-
-	if (unlikely((type != IB_MW_TYPE_1) &&
-		     (type != IB_MW_TYPE_2))) {
+	if (unlikely(udata && (udata->outlen < sizeof(*uresp)))) {
 		ret = -EINVAL;
 		goto err1;
 	}
@@ -82,22 +70,29 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	rxe_add_ref(pd);
 
 	mw = rxe_alloc(&rxe->mw_pool);
-	if (!mw) {
-		rxe_drop_ref(pd);
+	if (unlikely(!mw)) {
 		ret = -ENOMEM;
-		goto err1;
+		goto err2;
 	}
 
-	rxe_add_index(mw);
-	rxe_set_mw_rkey(mw);
+	switch (type) {
+	case IB_MW_TYPE_1:
+		mw->state	= RXE_MW_STATE_VALID;
+		break;
+	case IB_MW_TYPE_2:
+		mw->state	= RXE_MW_STATE_FREE;
+		break;
+	default:
+		pr_err("attempt to allocate MW with unknown type\n");
+		ret = -EINVAL;
+		goto err3;
+	}
 
-	spin_lock_init(&mw->lock);
+	rxe_add_index(mw);
+	index = mw->pelem.index;
 
-	if (type == IB_MW_TYPE_2) {
-		mw->state		= RXE_MW_STATE_FREE;
-	} else {
-		mw->state		= RXE_MW_STATE_VALID;
-	}
+	/* o10-37.2.32: */
+	rxe_set_mw_rkey(mw);
 
 	mw->qp			= NULL;
 	mw->mr			= NULL;
@@ -106,96 +101,330 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
         mw->ibmw.pd		= ibpd;
         mw->ibmw.type		= type;
 
+	spin_lock_init(&mw->lock);
+
 	if (udata) {
 		uresp = udata->outbuf;
-		if (copy_to_user(&uresp->index, &mw->pelem.index,
-				 sizeof(u32))) {
+		if (copy_to_user(&uresp->index, &index, sizeof(index))) {
 			ret = -EFAULT;
-			goto err2;
+			goto err3;
 		}
 	}
 
 	return &mw->ibmw;
-err2:
+err3:
 	rxe_drop_ref(mw);
+err2:
 	rxe_drop_ref(pd);
 err1:
 	return ERR_PTR(ret);
 }
 
-int rxe_dealloc_mw(struct ib_mw *ibmw)
+/* Check the rules for bind MW oepration. */
+static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			 struct rxe_mw *mw, struct rxe_mr *mr)
 {
-	struct rxe_mw *mw = to_rmw(ibmw);
-	struct rxe_pd *pd = to_rpd(ibmw->pd);
-	unsigned long flags;
+	/* check to see if bind operation came through
+	 * ibv_bind_mw verbs API. */
+	switch (mw->ibmw.type) {
+	case IB_MW_TYPE_1:
+		/* o10-37.2.34: */
+		if (unlikely(!(wqe->wr.wr.umw.flags & RXE_BIND_MW))) {
+			pr_err("attempt to bind type 1 MW with send WR\n");
+			return -EINVAL;
+		}
+		break;
+	case IB_MW_TYPE_2:
+		/* o10-37.2.35: */
+		if (unlikely(wqe->wr.wr.umw.flags & RXE_BIND_MW)) {
+			pr_err("attempt to bind type 2 MW with verbs API\n");
+			return -EINVAL;
+		}
 
-	spin_lock_irqsave(&mw->lock, flags);
-	mw->state = RXE_MW_STATE_INVALID;
-	spin_unlock_irqrestore(&mw->lock, flags);
+		/* C10-72: */
+		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
+			pr_err("attempt to bind type 2 MW with qp"
+				" with different PD\n");
+			return -EINVAL;
+		}
 
-	rxe_drop_ref(pd);
-	rxe_drop_ref(mw);
+		/* o10-37.2.40: */
+		if (unlikely(wqe->wr.wr.umw.length == 0)) {
+			pr_err("attempt to invalidate type 2 MW by"
+				" binding with zero length\n");
+			return -EINVAL;
+		}
+
+		if (unlikely(!mr)) {
+			pr_err("attempt to invalidate type 2 MW by"
+				" binding to NULL mr\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) &&
+			(mw->state != RXE_MW_STATE_VALID))) {
+		pr_err("attempt to bind a type 1 MW not in the"
+			" valid state\n");
+		return -EINVAL;
+	}
+
+	/* o10-36.2.2: */
+	if (unlikely((mw->access & IB_ZERO_BASED) &&
+			(mw->ibmw.type == IB_MW_TYPE_1))) {
+		pr_err("attempt to bind a zero based type 1 MW\n");
+		return -EINVAL;
+	}
+
+	if ((wqe->wr.wr.umw.rkey & 0xff) == (mw->ibmw.rkey & 0xff)) {
+		pr_err("attempt to bind MW with same key\n");
+		return -EINVAL;
+	}
+
+	/* remaining checks only apply to a nonzero MR */
+	if (!mr)
+		return 0;
+
+	if (unlikely(mr->access & IB_ZERO_BASED)) {
+		pr_err("attempt to bind MW to zero based MR\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.30: */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) &&
+			(mw->state != RXE_MW_STATE_FREE))) {
+		pr_err("attempt to bind a type 2 MW not in the"
+			" free state\n");
+		return -EINVAL;
+	}
+
+	/* C10-73: */
+	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
+		pr_err("attempt to bind an MW to an MR without"
+			" bind access\n");
+		return -EINVAL;
+	}
+
+	/* C10-74: */
+	if (unlikely((mw->access & (IB_ACCESS_REMOTE_WRITE |
+				    IB_ACCESS_REMOTE_ATOMIC)) &&
+	    !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
+		pr_err("attempt to bind an MW with write/atomic"
+			" access to an MR without local write access\n");
+		return -EINVAL;
+	}
+
+	/* MR duplicates address and length in the private and ib
+	 * parts of the rxe_mr struct. TODO should only keep one. */
+
+	/* C10-75: */
+	if (mw->access & IB_ZERO_BASED) {
+		if (unlikely(wqe->wr.wr.umw.length > mr->length)) {
+			pr_err("attempt to bind a ZB MW outside"
+				" of the MR\n");
+			return -EINVAL;
+		}
+	} else {
+		if (unlikely((wqe->wr.wr.umw.addr < mr->iova) ||
+		    ((wqe->wr.wr.umw.addr + wqe->wr.wr.umw.length) >
+		     (mr->iova + mr->length)))) {
+			pr_err("attempt to bind a VA MW outside"
+				" of the MR\n");
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
 
+static void do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	u32 rkey;
+
+	mw->access = wqe->wr.wr.umw.access;
+	mw->state = RXE_MW_STATE_VALID;
+	mw->addr = wqe->wr.wr.umw.addr;
+	mw->length = wqe->wr.wr.umw.length;
+
+	/* get rid of existing MR if any, type 1 only */
+	if (mw->mr) {
+		rxe_drop_ref(mw->mr);
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
+	}
+
+	/* if length != 0 bind to new MR */
+	if (mw->length) {
+		mw->mr = mr;
+		atomic_inc(&mr->num_mw);
+		rxe_add_ref(mr);
+	}
+
+	/* remember qp if type 2, cleared by invalidate
+	 * this is weak since qp can go away legally
+	 * only used to compare with qp used to perform
+	 * memory ops */
+	if (mw->ibmw.type == IB_MW_TYPE_2) {
+		mw->qp = qp;
+	}
+
+	/* key part of new rkey is provided by user for type 2
+	 * and ibv_bind_mw() for type 1 MWs */
+	rkey = mw->ibmw.rkey;
+	rxe_drop_key(mw);
+	rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
+	rxe_add_key(mw, &rkey);
+
+	return;
+}
+
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
+	int ret;
 	struct rxe_mw *mw;
 	struct rxe_mr *mr;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned long flags;
 
 	if (qp->is_user) {
+		mw = rxe_pool_get_index(&rxe->mw_pool,
+					wqe->wr.wr.umw.mw_index);
+		if (!mw) {
+			pr_err("mw with index = %d not found\n",
+				wqe->wr.wr.umw.mw_index);
+			ret = -EINVAL;
+			goto err1;
+		}
+		mr = rxe_pool_get_index(&rxe->mr_pool,
+					wqe->wr.wr.umw.mr_index);
+		if (!mr && wqe->wr.wr.umw.length) {
+			pr_err("mr with index = %d not found\n",
+				wqe->wr.wr.umw.mr_index);
+			ret = -EINVAL;
+			goto err2;
+		}
 	} else {
 		mw = to_rmw(wqe->wr.wr.kmw.ibmw);
-		mr = to_rmr(wqe->wr.wr.kmw.ibmr);
-	}
-
-#if 0
-	wqe->wr.wr.bind_mw
-	__aligned_u64	addr;
-	__aligned_u64	length;
-	__u32	mr_rkey;
-	__u32	mw_rkey;
-	__u32	rkey;
-	__u32	access;
-
-	mw
-	struct rxe_pool_entry	pelem;			// alloc
-	struct ib_mw		ibmw;			// alloc
-		struct ib_device	*device;	// alloc
-		struct ib_pd		*pd;		// alloc
-		struct ib_uobject	*uobject;	// alloc
-		u32			rkey;
-		enum ib_mw_type         type;		// alloc
-	struct rxe_qp		*qp;			// bind
-	struct rxe_mem		*mr;			// bind
-	spinlock_t		lock;			// alloc
-	enum rxe_mw_state	state;			// all
-	u32			access;			// bind
-	u64			addr;			// bind
-	u64			length;			// bind
-#endif
+		rxe_add_ref(mw);
+		if (wqe->wr.wr.kmw.ibmr) {
+			mr = to_rmr(wqe->wr.wr.kmw.ibmr);
+			rxe_add_ref(mr);
+		} else {
+			mr = NULL;
+		}
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	/* check the rules */
+	ret = check_bind_mw(qp, wqe, mw, mr);
+	if (ret)
+		goto err3;
+
+	/* implement the change */
+	do_bind_mw(qp, wqe, mw, mr);
+err3:
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	if (mr)
+		rxe_drop_ref(mr);
+err2:
+	rxe_drop_ref(mw);
+err1:
+	return ret;
+}
+
+static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	/* o10-37.2.26: */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
+		pr_err("attempt to invalidate a type 1 MW\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
+		pr_warn("attempt to invalidate a MW that"
+			" is not valid\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-void rxe_mw_cleanup(struct rxe_pool_entry *arg)
+static void do_invalidate_mw(struct rxe_mw *mw)
 {
-	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
+	mw->qp = NULL;
 
-	rxe_drop_index(mw);
-	rxe_drop_key(mw);
+	rxe_drop_ref(mw->mr);
+	atomic_dec(&mw->mr->num_mw);
+	mw->mr = NULL;
+
+	mw->access = 0;
+	mw->addr = 0; 
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_FREE;
 }
 
-int rxe_invalidate_mw(struct rxe_mw *mw, int remote)
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 {
-	/* type 1 MWs don't support invalidate */
-	if (mw->ibmw.type == IB_MW_TYPE_1) {
-		pr_err("attempt to %s-invalidate a type 1 mw\n",
-			remote ? "send" : "local");
-		return -EINVAL;
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = check_invalidate_mw(qp, mw);
+	if (ret)
+		goto err;
+
+	do_invalidate_mw(mw);
+err:
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	return ret;
+}
+
+static void do_deallocate_mw(struct rxe_mw *mw)
+{
+	mw->qp = NULL;
+
+	if (mw->mr) {
+		rxe_drop_ref(mw->mr);
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
 	}
 
-	mw->state = RXE_MEM_STATE_FREE;
+	mw->access = 0;
+	mw->addr = 0; 
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_INVALID;
+}
+
+int rxe_dealloc_mw(struct ib_mw *ibmw)
+{
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	do_deallocate_mw(mw);
+
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(pd);
+	rxe_drop_ref(mw);
 
 	return 0;
 }
+
+void rxe_mw_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
+
+	rxe_drop_index(mw);
+	rxe_drop_key(mw);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 7f914dde98a7..41e7b74efcbc 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -75,7 +75,9 @@ enum rxe_device_param {
 					| IB_DEVICE_SYS_IMAGE_GUID
 					| IB_DEVICE_RC_RNR_NAK_GEN
 					| IB_DEVICE_SRQ_RESIZE
+					| IB_DEVICE_MEM_WINDOW
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
 					| IB_DEVICE_ALLOW_USER_UNREG,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 2a38b7cdf4a8..ad747f230318 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -583,18 +583,19 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  jiffies + qp->qp_timeout_jiffies);
 }
 
-static int local_invalidate(struct rxe_dev *rxe, struct rxe_send_wqe *wqe)
+static int local_invalidate(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	int ret;
 	struct rxe_mr *mr;
 	struct rxe_mw *mw;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 key = wqe->wr.ex.invalidate_rkey;
 
 	if ((mr = rxe_pool_get_key(&rxe->mr_pool, &key))) {
-		ret = rxe_invalidate_mr(mr, 0);
+		ret = rxe_invalidate_mr(qp, mr);
 		rxe_drop_ref(mr);
 	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &key))) {
-		ret = rxe_invalidate_mw(mw, 0);
+		ret = rxe_invalidate_mw(qp, mw);
 		rxe_drop_ref(mw);
 	} else {
 		ret = -EINVAL;
@@ -607,7 +608,6 @@ static int local_invalidate(struct rxe_dev *rxe, struct rxe_send_wqe *wqe)
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
@@ -621,8 +621,6 @@ int rxe_requester(void *arg)
 	u32 rollback_psn;
 	int entered;
 
-	pr_info("rxe_requester: called\n");
-
 	rxe_add_ref(qp);
 
 	// this code is 'guaranteed' to never be entered more
@@ -655,13 +653,18 @@ int rxe_requester(void *arg)
 		goto exit;
 
 	/* process local operations */
+	/* current behavior if an error occurs
+	 * for any of these local operations
+	 * is to generate an error work completion
+	 * then error the QP and flush any
+	 * remaining WRs */
 	if (wqe->mask & WR_LOCAL_MASK) {
 		wqe->state = wqe_state_done;
 		wqe->status = IB_WC_SUCCESS;
 
 		switch (wqe->wr.opcode) {
 		case IB_WR_LOCAL_INV:
-			if ((ret = local_invalidate(rxe, wqe)))
+			if ((ret = local_invalidate(qp, wqe)))
 				wqe->status = IB_WC_LOC_QP_OP_ERR;
 			break;
 		case IB_WR_REG_MR:
@@ -677,8 +680,10 @@ int rxe_requester(void *arg)
 				wqe->status = IB_WC_MW_BIND_ERR;
 			break;
 		default:
-			pr_err("rxe_requester: unexpected local WR opcode = %d\n",
-				wqe->wr.opcode);
+			pr_err("rxe_requester: unexpected local"
+				" WR opcode = %d\n", wqe->wr.opcode);
+			/* these should be memory operation errors
+			 * but there isn't one available */
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index aac50c0a43c7..49cd77cd6264 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -834,19 +834,17 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_CLEANUP;
 }
 
-static int send_invalidate(struct rxe_dev *rxe, u32 rkey)
+static int send_invalidate(struct rxe_qp *qp, struct rxe_dev *rxe, u32 rkey)
 {
 	int ret;
 	struct rxe_mr *mr;
 	struct rxe_mw *mw;
 
-	pr_info("send_invalidate: called\n");
-
 	if ((mr = rxe_pool_get_key(&rxe->mr_pool, &rkey))) {
-		ret = rxe_invalidate_mr(mr, 1);
+		ret = rxe_invalidate_mr(qp, mr);
 		rxe_drop_ref(mr);
 	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &rkey))) {
-		ret = rxe_invalidate_mw(mw, 1);
+		ret = rxe_invalidate_mw(qp, mw);
 		rxe_drop_ref(mw);
 	} else {
 		pr_err("send invalidate failed for rkey = 0x%x\n", rkey);
@@ -883,9 +881,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	}
 
 	if (pkt->mask & RXE_IETH_MASK) {
-		ret = send_invalidate(rxe, rkey);
+		ret = send_invalidate(qp, rxe, rkey);
 		if (ret) {
-			pr_err("do_complete: send invalidate failed\n");
+			pr_err("send with invalidate failed\n");
 			// TODO
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b11ab3ae87a3..caaacfabadbc 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -172,8 +172,6 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	pr_info("rxe_alloc_pd: called\n");
-
 	return rxe_add_to_pool(&rxe->pd_pool, &pd->pelem);
 }
 
@@ -181,8 +179,6 @@ static void rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	pr_info("rxe_dealloc_pd: called\n");
-
 	rxe_drop_ref(pd);
 }
 
@@ -414,8 +410,6 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 	struct rxe_qp *qp;
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
-	pr_info("rxe_create_qp: called\n");
-
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return ERR_PTR(-EINVAL);
@@ -463,8 +457,6 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 
-	pr_info("rxe_modify_qp: called\n");
-
 	err = rxe_qp_chk_attr(rxe, qp, attr, mask);
 	if (err)
 		goto err1;
@@ -484,8 +476,6 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
 
-	pr_info("rxe_query_qp: called\n");
-
 	rxe_qp_to_init(qp, init);
 	rxe_qp_to_attr(qp, attr, mask);
 
@@ -496,8 +486,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
 
-	pr_info("rxe_destroy_qp: called\n");
-
 	rxe_qp_destroy(qp);
 	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
@@ -794,8 +782,6 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_create_cq_resp __user *uresp = NULL;
 
-	pr_info("rxe_create_cq: called\n");
-
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
@@ -821,8 +807,6 @@ static void rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
-	pr_info("rxe_destroy_cq: called\n");
-
 	rxe_cq_disable(cq);
 
 	rxe_drop_ref(cq);
@@ -862,8 +846,6 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	struct rxe_cqe *cqe;
 	unsigned long flags;
 
-	pr_info("rxe_poll_cq: called\n");
-
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
 		cqe = queue_head(cq->queue);
@@ -934,8 +916,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_reg_mr_resp __user *uresp = NULL;
 
-	pr_info("rxe_reg_user_mr: called\n");
-
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
@@ -980,7 +960,10 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 
-	pr_info("rxe_dereg_user_mr: called\n");
+	if (atomic_read(&mr->num_mw)) {
+		pr_err("attempt to dereg MR with bound MWs\n");
+		return -EBUSY;
+	}
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ebe4157fbcdd..2fe8433d0801 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -344,6 +344,8 @@ struct rxe_mr {
 	u32			max_buf;
 	u32			num_map;
 
+	atomic_t		num_mw;
+
 	struct rxe_map		**map;
 };
 
@@ -353,11 +355,16 @@ enum rxe_mw_state {
 	RXE_MW_STATE_VALID,
 };
 
+enum rxe_send_flags {
+	/* flag indicaes bind call came through verbs API */
+	RXE_BIND_MW		= (1 << 0),
+};
+
 struct rxe_mw {
 	struct rxe_pool_entry	pelem;
 	struct ib_mw		ibmw;
+	struct rxe_mr		*mr;
 	struct rxe_qp		*qp;	/* type 2B only */
-	struct rxe_mem		*mr;
 	spinlock_t		lock;
 	enum rxe_mw_state	state;
 	u32			access;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index c1e84cd69c37..05fe8bef947d 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -102,6 +102,7 @@ struct rxe_send_wr {
 			__u32   pad2;
 			__u32	rkey;
 			__u32	access;
+			__u32	flags;
 		} umw;
 		/* below are only used by the kernel */
 		struct {
@@ -117,6 +118,7 @@ struct rxe_send_wr {
 			};
 			__u32	rkey;
 			__u32	access;
+			__u32	flags;
 		} kmw;
 		struct {
 			union {
-- 
2.25.1

