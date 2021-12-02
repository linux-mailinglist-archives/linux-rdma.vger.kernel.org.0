Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A8466D9B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349038AbhLBXZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357281AbhLBXY6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:58 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D4C061757
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:36 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so458062ooe.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mg0PJK/6ic2BH6MRO8q6etj0st127gc87mFRN3GztSM=;
        b=MgWNnrnj81wL6gPPnuYNo7DTEnYtNK0iPICE8oMK6Riltt3NoticomjyutZLfmg5Wj
         5jGoZ59mv6s/Dgb4PpgwJJG9mRYpTciPv4S87wvK7f4d3SDr/kI88bxvCiRB9YMHnWab
         /TiexbHuUAxsEizq5ovizqoxRdZ9iJ4w3Y2YWtrSFtwykCseRyCBqrYEhTy+lBuByeuP
         rdUg0pNFQxla+KUO9JT78enhIqchLkjn/qG209X7+LNsHylY0AvNuGqL0lyqw16NaLc+
         neVoubPk+cbTX0M1eVbntXE4ARoe58gSqOvULk76qdUMhvnyh0mS0Ff6a771UUDlvj9J
         R8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mg0PJK/6ic2BH6MRO8q6etj0st127gc87mFRN3GztSM=;
        b=L1n3kET6QSu6CexUTMVKIXqzlMYQ0ItbVgI7m6+McHL9NE3cTW5kw6PImReSj3WYQ4
         xUJoczSxgl+TDfSAlvi1hjKwVzklroITYYHm6ELJkDU8QAe1vkNkcSNqJ8nUUCN8FxEO
         hE3g/PNGEisiAzAlz5/e6slIyHFShhuprPO7lcwS+ll6CrDgYkauEhjNDkdwAcdMjTvX
         a+LmYSuH+vTyKXIBK7DEAv0BrLGvP1AjolivHwF8nePIKqh56HEm+cuLVGs28Y+oRH50
         lKEVMqpSDQdTW1GuJHkAkkR/4NLQREHsMo3vWgJt09KDOUQ3BErWPwiphhxFb3RvQf4z
         HzFg==
X-Gm-Message-State: AOAM533EWlIk0nMHYXP1sw9QvTNb4C+fh0nlJZ529lvDAR2WUvTu/4jv
        4Y3yQIhwiM+9pzYgCmN0Q2LGoR/Gxl0=
X-Google-Smtp-Source: ABdhPJxKP4/CMx9exELkohA1z1Q4Nzi+jnhULrZCjtSIQQW9LkHfzbCxMUJbuWhRK5i5U/p8so7lmQ==
X-Received: by 2002:a4a:dc88:: with SMTP id g8mr10243580oou.3.1638487295435;
        Thu, 02 Dec 2021 15:21:35 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:35 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 8/8] RDMA/rxe: Add wait for completion to obj destruct
Date:   Thu,  2 Dec 2021 17:20:35 -0600
Message-Id: <20211202232035.62299-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202232035.62299-1-rpearsonhpe@gmail.com>
References: <20211202232035.62299-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds code to wait until pending activity on RDMA objects has
completed before freeing or returning to rdma-code where the object may
be freed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  4 ++
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +
 drivers/infiniband/sw/rxe/rxe_mw.c    | 14 +++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 24 +++++++-
 drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_req.c   | 11 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 84 ++++++++++++++++++++-------
 10 files changed, 118 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index f363fe3fa414..a2bb66f320fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -562,7 +562,9 @@ int rxe_completer(void *arg)
 	enum comp_state state;
 	int ret = 0;
 
-	rxe_add_ref(qp);
+	/* check qp pointer still valid */
+	if (!rxe_add_ref(qp))
+		return -EAGAIN;
 
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index b935634f86cd..70d48f5847b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -122,6 +122,8 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 out_drop_ref:
 	rxe_drop_ref(grp);			/* ref from get_key */
+	if (grp->elem.complete.done)
+		rxe_fini(grp);
 err1:
 	return ret;
 }
@@ -149,6 +151,8 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 		spin_unlock_bh(&grp->mcg_lock);
 		rxe_drop_ref(qp);
 		rxe_drop_ref(grp);
+		if (grp->elem.complete.done)
+			rxe_fini(grp);
 		kfree(elem);
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 3c4390adfb80..5f8c08da352d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -695,6 +695,8 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_ref(mr);
 
+	rxe_fini(mr);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 3ae981d77c25..9b3468911976 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -12,7 +12,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibmw->device);
 	int ret;
 
-	rxe_add_ref(pd);
+	if (!rxe_add_ref(pd))
+		return -EINVAL;
 
 	ret = rxe_add_to_pool(&rxe->mw_pool, mw);
 	if (ret) {
@@ -60,8 +61,9 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
 
-	rxe_drop_ref(mw);
 	rxe_drop_ref(pd);
+	rxe_drop_ref(mw);
+	rxe_fini(mw);
 
 	return 0;
 }
@@ -178,11 +180,11 @@ static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	if (mw->length) {
 		mw->mr = mr;
 		atomic_inc(&mr->num_mw);
-		rxe_add_ref(mr);
+		rxe_add_ref(mr);	/* safe */
 	}
 
 	if (mw->ibmw.type == IB_MW_TYPE_2) {
-		rxe_add_ref(qp);
+		rxe_add_ref(qp);	/* safe */
 		mw->qp = qp;
 	}
 }
@@ -199,7 +201,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	mw = rxe_pool_get_index(&rxe->mw_pool, mw_rkey >> 8);
 	if (unlikely(!mw)) {
 		ret = -EINVAL;
-		goto err;
+		goto err_out;
 	}
 
 	if (unlikely(mw->rkey != mw_rkey)) {
@@ -236,7 +238,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		rxe_drop_ref(mr);
 err_drop_mw:
 	rxe_drop_ref(mw);
-err:
+err_out:
 	return ret;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 2c241ffc0c8b..155de10245f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -150,6 +150,7 @@ static void *__rxe_alloc(struct rxe_pool *pool, gfp_t flags)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	if (pool->init) {
 		err = pool->init(elem);
@@ -189,6 +190,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	if (pool->init) {
 		err = pool->init(elem);
@@ -372,8 +374,26 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (pool->flags & RXE_POOL_ALLOC)
-		kfree(elem->obj);
+	complete_all(&elem->complete);
 
 	atomic_dec(&pool->num_elem);
 }
+
+/**
+ * rxe_elem_free() - free memory holding pool element
+ * @elem: the pool elem
+ */
+void __rxe_fini(struct rxe_pool_elem *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	int ret;
+
+	ret = wait_for_completion_timeout(&elem->complete, 10);
+
+	if (!ret)
+		pr_info("Timed out waiting for %s#%d\n", pool->name,
+				elem->index);
+
+	if (elem->pool->flags & RXE_POOL_ALLOC)
+		kfree(elem->obj);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index db2caff6f408..a72640f9a440 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -30,6 +30,7 @@ struct rxe_pool_elem {
 	struct rxe_pool		*pool;
 	void			*obj;
 	struct kref		ref_cnt;
+	struct completion	complete;
 	struct list_head	list;
 
 	/* only used if keyed */
@@ -105,4 +106,7 @@ static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
 }
 #define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
+void __rxe_fini(struct rxe_pool_elem *elem);
+#define rxe_fini(obj) __rxe_fini(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 6a6cc1fa90e4..4c7077aec9a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -288,11 +288,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 			cpkt = SKB_TO_PKT(cskb);
 			cpkt->qp = qp;
-			rxe_add_ref(qp);
+			rxe_add_ref(qp);	/* safe */
 			rxe_rcv_pkt(cpkt, cskb);
 		} else {
 			pkt->qp = qp;
-			rxe_add_ref(qp);
+			rxe_add_ref(qp);	/* safe */
 			rxe_rcv_pkt(pkt, skb);
 			skb = NULL;	/* mark consumed */
 		}
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 7bc1ec8a5aa6..9b75515cd0f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -614,9 +614,10 @@ int rxe_requester(void *arg)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	rxe_add_ref(qp);
+	/* check qp pointer still valid */
+	if (!rxe_add_ref(qp))
+		return -EAGAIN;
 
-next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
 		goto exit;
 
@@ -644,7 +645,7 @@ int rxe_requester(void *arg)
 		if (unlikely(ret))
 			goto err;
 		else
-			goto next_wqe;
+			goto done;
 	}
 
 	if (unlikely(qp_type(qp) == IB_QPT_RC &&
@@ -760,7 +761,9 @@ int rxe_requester(void *arg)
 
 	update_state(qp, wqe, &pkt, payload);
 
-	goto next_wqe;
+done:
+	rxe_drop_ref(qp);
+	return 0;
 
 err_drop_ah:
 	if (ah)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c776289842e5..5aaf4573c0ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -463,8 +463,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		if (mw->access & IB_ZERO_BASED)
 			qp->resp.offset = mw->addr;
 
+		rxe_add_ref(mr);	/* safe */
 		rxe_drop_ref(mw);
-		rxe_add_ref(mr);
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
@@ -1247,7 +1247,9 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_add_ref(qp);
+	/* check qp pointer still valid */
+	if (!rxe_add_ref(qp))
+		return -EAGAIN;
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e3f64eae088c..06b508ba4e2d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -116,6 +116,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
 	rxe_drop_ref(uc);
+	rxe_fini(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -150,6 +151,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_pd *pd = to_rpd(ibpd);
 
 	rxe_drop_ref(pd);
+	rxe_fini(pd);
 	return 0;
 }
 
@@ -189,6 +191,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 					 sizeof(uresp->ah_num));
 		if (err) {
 			rxe_drop_ref(ah);
+			rxe_fini(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -229,6 +232,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_drop_ref(ah);
+	rxe_fini(ah);
 	return 0;
 }
 
@@ -297,25 +301,29 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
-		goto err1;
+		goto err_out;
+
+	if (!rxe_add_ref(pd))
+		goto err_drop_srq;
 
-	rxe_add_ref(pd);
 	srq->pd = pd;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
-		goto err2;
+		goto err_drop_pd;
 
 	return 0;
 
-err2:
+err_drop_pd:
 	rxe_drop_ref(pd);
+err_drop_srq:
 	rxe_drop_ref(srq);
-err1:
+	rxe_fini(srq);
+err_out:
 	return err;
 }
 
@@ -373,6 +381,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	rxe_drop_ref(srq->pd);
 	rxe_drop_ref(srq);
+	rxe_fini(srq);
 	return 0;
 }
 
@@ -442,6 +451,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 
 qp_init:
 	rxe_drop_ref(qp);
+	rxe_fini(qp);
 	return err;
 }
 
@@ -486,6 +496,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	rxe_qp_destroy(qp);
 	rxe_drop_ref(qp);
+	rxe_fini(qp);
 	return 0;
 }
 
@@ -797,6 +808,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	rxe_cq_disable(cq);
 
 	rxe_drop_ref(cq);
+	rxe_fini(cq);
 	return 0;
 }
 
@@ -882,15 +894,28 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	if (!rxe_add_ref(pd)) {
+		err = -EINVAL;
+		goto err_drop_mr;
+	}
 
-	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
+
+err_drop_mr:
+	rxe_drop_ref(mr);
+	rxe_fini(mr);
+err_out:
+	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
@@ -899,30 +924,35 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 				     u64 iova,
 				     int access, struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
 		err = -ENOMEM;
-		goto err2;
+		goto err_out;
 	}
 
 
-	rxe_add_ref(pd);
+	if (!rxe_add_ref(pd)) {
+		err = -EINVAL;
+		goto err_drop_mr;
+	}
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
-		goto err3;
+		goto err_drop_pd;
 
 	return &mr->ibmr;
 
-err3:
+err_drop_pd:
 	rxe_drop_ref(pd);
+err_drop_mr:
 	rxe_drop_ref(mr);
-err2:
+	rxe_fini(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -934,27 +964,34 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	struct rxe_mr *mr;
 	int err;
 
-	if (mr_type != IB_MR_TYPE_MEM_REG)
-		return ERR_PTR(-EINVAL);
+	if (mr_type != IB_MR_TYPE_MEM_REG) {
+		err = -EINVAL;
+		goto err_out;
+	}
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
 		err = -ENOMEM;
-		goto err1;
+		goto err_out;
 	}
 
-	rxe_add_ref(pd);
+	if (!rxe_add_ref(pd)) {
+		err = -EINVAL;
+		goto err_drop_mr;
+	}
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
-		goto err2;
+		goto err_drop_pd;
 
 	return &mr->ibmr;
 
-err2:
+err_drop_pd:
 	rxe_drop_ref(pd);
+err_drop_mr:
 	rxe_drop_ref(mr);
-err1:
+	rxe_fini(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -994,8 +1031,10 @@ static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (err)
 		return err;
 
+	/* adds a ref on grp if successful */
 	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
+	/* drops the ref from ..get_grp() */
 	rxe_drop_ref(grp);
 	return err;
 }
@@ -1005,6 +1044,7 @@ static int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 
+	/* drops a ref on grp if successful */
 	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
 }
 
-- 
2.32.0

