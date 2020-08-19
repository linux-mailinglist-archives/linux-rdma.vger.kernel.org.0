Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BBB249399
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHSDot (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHSDoq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:44:46 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30E9C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:44:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so19864741oij.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgWM8VLAyG7lbWaSCqO41ya07PSfJjyrCqonyep4h80=;
        b=LE71013zBhWt8n3LppL7a7IPXyNYK28Q+i03AI8Er4Mma0Kln5iOMrtek/E/W8qKJn
         9nPLL6TH7taOP1iC1fA+BQ9MCy08CKUVkPu6wkLDEIdEOc6nznWQnYVhjjGfYPLh/Nze
         kVPks9Ai+xBND0tPtk8zcYCFO1BYuRRQiZDxiulAcF9dvK3B+ZNkiqPgiea7Exsopp2H
         EGdIc9XTRAGmP3AGTmeX4vk3XrL9CRSMAm0A1DfIT45bBPqqMSurrnUe1hoI3c6hluHA
         uHhuyKPm9ew//+EPCP9eyoOqz9SaerbWKCIyvBUFtwHMQpMbVeRJCsiklW/9iTHZwNCr
         TZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgWM8VLAyG7lbWaSCqO41ya07PSfJjyrCqonyep4h80=;
        b=lL3V4TjS5TVeAGtWCpfsvRU/bwq/8xZID1bkPlYDi9zdj2cmxn12qJunYfdviCUuR8
         8xvQh+9yed9S8b896Vp99UCHjv27sksocCrpsySDARbibpdTyhxTkdf2ydSjSaWQK65b
         86UvDQ0AyRjJgCDLMWwHYFbgDSAj4irfWhCOdB5Gcs8YfTIm1/kbr+0zUCtfa28zIJrO
         0NPv4WnupVDJAYS14jK0tXfZ9APOB1JLhAFSP+uDaThyaNdeajrppJI36Be+1aaJfUCo
         wtw7h9foxuklSCNtPb0U+MHvSvTSNo4gsJSRKBVIydLW0OIOajsEkQcvOVjCHZaAQnH2
         mAjQ==
X-Gm-Message-State: AOAM533tRKVi/RY86WbSH78pTnXbcHuemQFGVERRL1DImlsC3pvLZ5//
        Tu2Oezi/rffD42bydJpTy2g=
X-Google-Smtp-Source: ABdhPJwqmv7ft4xgJmtpml56ZNCrswTEW3CnSpMvWpHHVXnDdWzLvRfiNfsmvndJrS7vTyGz28qV/Q==
X-Received: by 2002:aca:b884:: with SMTP id i126mr2135332oif.32.1597808685976;
        Tue, 18 Aug 2020 20:44:45 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id i7sm4257681ook.47.2020.08.18.20.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:44:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 15/16] rdma_rxe: Added functional bind and invalidate MW ops
Date:   Tue, 18 Aug 2020 22:40:16 -0500
Message-Id: <20200819034002.8835-16-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replaced bind MW and invalidate MW stubs with functional versions
Added rules checking for these operations based on the InfiniBand
architecture document.
Added an extra flags field in the rxe WQE to indicate whether the
bind operation came from the ibv_bind_verbs API or the
ibv_post_send API to enforce the rules on type 1 and 2 MWs.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    | 288 ++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   9 +-
 include/uapi/rdma/rdma_user_rxe.h     |  32 ++-
 4 files changed, 314 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index ddf4580a746f..660547522c7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -601,7 +601,8 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
 	int i;
 
-	ib_umem_release(mr->umem);
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->map) {
 		for (i = 0; i < mr->num_map; i++)
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c41b5160bdba..37496e06a477 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -25,7 +25,7 @@ static void rxe_set_mw_rkey(struct rxe_mw *mw)
 			   (rxe_add_key(mw, &rkey) == 0)))
 			return;
 	} while (tries++ < 10);
-	pr_err("unable to get random rkey for mw\n");
+	pr_err_once("unable to get random rkey for mw\n");
 }
 
 /* this temporary code to test ibv_alloc_mw, ibv_dealloc_mw */
@@ -38,7 +38,7 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	struct rxe_alloc_mw_resp __user *uresp = NULL;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
+		if (unlikely(udata->outlen < sizeof(*uresp)))
 			return ERR_PTR(-EINVAL);
 		uresp = udata->outbuf;
 	}
@@ -70,10 +70,9 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 					RXE_MEM_STATE_VALID;
 
 	if (uresp) {
-		if (copy_to_user(&uresp->index, &mw->pelem.index,
-				 sizeof(uresp->index))) {
+		if (unlikely(copy_to_user(&uresp->index, &mw->pelem.index,
+				 sizeof(uresp->index)))) {
 			rxe_drop_ref(mw);
-			rxe_drop_ref(pd);
 			return ERR_PTR(-EFAULT);
 		}
 	}
@@ -81,13 +80,31 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	return &mw->ibmw;
 }
 
+/* cleanup mw in case someone is still holding a ref */
+static void do_dealloc_mw(struct rxe_mw *mw)
+{
+	if (mw->mr) {
+		rxe_drop_ref(mw->mr);
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
+	}
+
+	mw->qp = NULL;
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MEM_STATE_INVALID;
+}
+
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
 	unsigned long flags;
 
 	spin_lock_irqsave(&mw->lock, flags);
-	mw->state = RXE_MEM_STATE_INVALID;
+
+	do_dealloc_mw(mw);
+
 	spin_unlock_irqrestore(&mw->lock, flags);
 
 	rxe_drop_ref(mw);
@@ -95,18 +112,265 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	return 0;
 }
 
-/* stub for bind mw */
+/* Check the rules for bind MW oepration. */
+static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			 struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	/* check to see if bind operation came through
+	 * ibv_bind_mw verbs API.
+	 */
+	switch (mw->ibmw.type) {
+	case IB_MW_TYPE_1:
+		/* o10-37.2.34 */
+		if (unlikely(!(wqe->wr.wr.umw.flags & RXE_BIND_MW))) {
+			pr_err_once("attempt to bind type 1 MW with send WR\n");
+			return -EINVAL;
+		}
+		break;
+	case IB_MW_TYPE_2:
+		/* o10-37.2.35 */
+		if (unlikely(wqe->wr.wr.umw.flags & RXE_BIND_MW)) {
+			pr_err_once("attempt to bind type 2 MW with verbs API\n");
+			return -EINVAL;
+		}
+
+		/* C10-72 */
+		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
+			pr_err_once("attempt to bind type 2 MW with qp with different PD\n");
+			return -EINVAL;
+		}
+
+		/* o10-37.2.40 */
+		if (unlikely(wqe->wr.wr.umw.length == 0)) {
+			pr_err_once("attempt to invalidate type 2 MW by binding with zero length\n");
+			return -EINVAL;
+		}
+
+		if (unlikely(!mr)) {
+			pr_err_once("attempt to bind MW to a NULL mr\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) &&
+			(mw->state != RXE_MEM_STATE_VALID))) {
+		pr_err_once("attempt to bind a type 1 MW not in the valid state\n");
+		return -EINVAL;
+	}
+
+	/* o10-36.2.2 */
+	if (unlikely((mw->access & IB_ZERO_BASED) &&
+			(mw->ibmw.type == IB_MW_TYPE_1))) {
+		pr_err_once("attempt to bind a zero based type 1 MW\n");
+		return -EINVAL;
+	}
+
+	if (unlikely((wqe->wr.wr.umw.rkey & 0xff) == (mw->ibmw.rkey & 0xff))) {
+		pr_err_once("attempt to bind MW with same key\n");
+		return -EINVAL;
+	}
+
+	/* remaining checks only apply to a nonzero MR */
+	if (!mr)
+		return 0;
+
+	if (unlikely(mr->access & IB_ZERO_BASED)) {
+		pr_err_once("attempt to bind MW to zero based MR\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.30 */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) &&
+			(mw->state != RXE_MEM_STATE_FREE))) {
+		pr_err_once("attempt to bind a type 2 MW not in the free state\n");
+		return -EINVAL;
+	}
+
+	/* C10-73 */
+	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
+		pr_err_once("attempt to bind an MW to an MR without bind access\n");
+		return -EINVAL;
+	}
+
+	/* C10-74 */
+	if (unlikely((mw->access & (IB_ACCESS_REMOTE_WRITE |
+				    IB_ACCESS_REMOTE_ATOMIC)) &&
+	    !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
+		pr_err_once("attempt to bind an writeable MW to an MR without local write access\n");
+		return -EINVAL;
+	}
+
+	/* C10-75 */
+	if (mw->access & IB_ZERO_BASED) {
+		if (unlikely(wqe->wr.wr.umw.length > mr->length)) {
+			pr_err_once("attempt to bind a ZB MW outside of the MR\n");
+			return -EINVAL;
+		}
+	} else {
+		if (unlikely((wqe->wr.wr.umw.addr < mr->iova) ||
+		    ((wqe->wr.wr.umw.addr + wqe->wr.wr.umw.length) >
+		     (mr->iova + mr->length)))) {
+			pr_err_once("attempt to bind a VA MW outside of the MR\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			struct rxe_mw *mw, struct rxe_mr *mr)
+{
+	int ret;
+	u32 rkey;
+	u32 new_rkey;
+	struct rxe_mw *duplicate_mw;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+
+	/* key part of new rkey is provided by user for type 2
+	 * and ibv_bind_mw() for type 1 MWs
+	 * there is a very rare chance that the new rkey will
+	 * collide with an existing MW. Return an error if this
+	 * occurs
+	 */
+	rkey = mw->ibmw.rkey;
+	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
+	duplicate_mw = rxe_pool_get_key(&rxe->mw_pool, &new_rkey);
+	if (duplicate_mw) {
+		pr_err_once("new MW key is a duplicate, try another\n");
+		rxe_drop_ref(duplicate_mw);
+		return -EINVAL;
+	}
+
+	rxe_drop_key(mw);
+	ret = rxe_add_key(mw, &new_rkey);
+
+	mw->access = wqe->wr.wr.umw.access;
+	mw->state = RXE_MEM_STATE_VALID;
+	mw->addr = wqe->wr.wr.umw.addr;
+	mw->length = wqe->wr.wr.umw.length;
+
+	if (mw->mr) {
+		rxe_drop_ref(mw->mr);
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
+	}
+
+	if (mw->length) {
+		mw->mr = mr;
+		atomic_inc(&mr->num_mw);
+		rxe_add_ref(mr);
+	}
+
+	if (mw->ibmw.type == IB_MW_TYPE_2)
+		mw->qp = qp;
+
+	return 0;
+}
+
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
-	pr_err_once("%s: not implemented\n", __func__);
-	return -EINVAL;
+	int ret;
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned long flags;
+
+	if (qp->is_user) {
+		mw = rxe_pool_get_index(&rxe->mw_pool,
+					wqe->wr.wr.umw.mw_index);
+		if (!mw) {
+			pr_err_once("mw with index = %d not found\n",
+				wqe->wr.wr.umw.mw_index);
+			ret = -EINVAL;
+			goto err1;
+		}
+		mr = rxe_pool_get_index(&rxe->mr_pool,
+					wqe->wr.wr.umw.mr_index);
+		if (!mr && wqe->wr.wr.umw.length) {
+			pr_err_once("mr with index = %d not found\n",
+				wqe->wr.wr.umw.mr_index);
+			ret = -EINVAL;
+			goto err2;
+		}
+	} else {
+		mw = to_rmw(wqe->wr.wr.kmw.mw);
+		rxe_add_ref(mw);
+		if (wqe->wr.wr.kmw.mr) {
+			mr = to_rmr(wqe->wr.wr.kmw.mr);
+			rxe_add_ref(mr);
+		} else {
+			mr = NULL;
+		}
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = check_bind_mw(qp, wqe, mw, mr);
+	if (ret)
+		goto err3;
+
+	ret = do_bind_mw(qp, wqe, mw, mr);
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
+	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
+		pr_err_once("attempt to invalidate a MW that is not valid\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.26 */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
+		pr_err_once("attempt to invalidate a type 1 MW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void do_invalidate_mw(struct rxe_mw *mw)
+{
+	mw->qp = NULL;
+
+	rxe_drop_ref(mw->mr);
+	atomic_dec(&mw->mr->num_mw);
+	mw->mr = NULL;
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MEM_STATE_FREE;
 }
 
-/* stub for invalidate MW */
 int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 {
-	pr_err_once("%s: not implemented\n", __func__);
-	return -EINVAL;
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
 }
 
 void rxe_mw_cleanup(struct rxe_pool_entry *arg)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index cab3d93a5bf2..7b3f9dff3839 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -329,9 +329,16 @@ struct rxe_mr {
 	u32			max_buf;
 	u32			num_map;
 
+	atomic_t		num_mw;
+
 	struct rxe_map		**map;
 };
 
+enum rxe_send_flags {
+	/* flag indicaes bind call came through verbs API */
+	RXE_BIND_MW		= (1 << 0),
+};
+
 /* use high order bit to separate MW and MR rkeys */
 #define IS_MW  (1 << 31)
 
@@ -339,7 +346,7 @@ struct rxe_mw {
 	struct rxe_pool_entry	pelem;
 	struct ib_mw		ibmw;
 	struct rxe_qp		*qp;	/* type 2B only */
-	struct rxe_mem		*mr;
+	struct rxe_mr		*mr;
 	spinlock_t		lock;
 	enum rxe_mem_state	state;
 	u32			access;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index fdf6d13ed4b7..d49125682359 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -96,12 +96,36 @@ struct rxe_send_wr {
 		struct {
 			__aligned_u64	addr;
 			__aligned_u64	length;
-			__u32	mr_index;
-			__u32	mw_index;
+			union {
+				__u32		mr_index;
+				__aligned_u64	reserved1;
+			};
+			union {
+				__u32		mw_index;
+				__aligned_u64	reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} umw;
+		/* The following are only used by the kernel
+		 * and are not part of the uapi
+		 */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				struct ib_mr	*mr;
+				__aligned_u64	reserved1;
+			};
+			union {
+				struct ib_mw	*mw;
+				__aligned_u64	reserved2;
+			};
 			__u32	rkey;
 			__u32	access;
-		} bind_mw;
-		/* reg is only used by the kernel and is not part of the uapi */
+			__u32	flags;
+		} kmw;
 		struct {
 			union {
 				struct ib_mr *mr;
-- 
2.25.1

