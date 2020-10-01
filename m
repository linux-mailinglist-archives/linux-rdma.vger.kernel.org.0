Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E592805E0
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbgJARtL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733003AbgJARtH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:07 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2BC0613E6
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:07 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 185so6465077oie.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDhkTZQlDlaso3OBshhU5cB4uZ8LfUV5njrw8rLn0xo=;
        b=ZArVcGV57zYG54G8FREMW9ey3Tm8CA+uZ260dWzk3tcFZlNeOkOindXOkZ9zwLZ7eB
         F932fpIBUY+7rvhmwh8hrAG+8RfSnpOoETv/Jiz6tCUPtdcGcF9H3eyQDsR95tZHget4
         A/u1oP6tWqkocEH4Ycr7w6iL1obKdATVvGraJx1AHL63l1yuxLs1Kan0hAWnF2Av4De3
         aX+w4hTv2FTUGYFNPKbQ7ptzWLdHFopqUMdSCzI0t/c/Qe5mtgD4bdmTH/lWw2qHgxm8
         O0Gxtzz+yd7Hnwu/wTaswcPkje0PUI0cYOEhJWvquRJ86S61xPPL+3Ch8j/hfjblT2i0
         t1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDhkTZQlDlaso3OBshhU5cB4uZ8LfUV5njrw8rLn0xo=;
        b=TopyDaWgd4NYMNrgjPBAZifFFJ0hqxS8tS5OeJyim15rEMHn9jKYAk9oUAWPW4rmp/
         j/90RMWrlEJMpZvqukOAFNVcE52eTGxf6LZZt9vP7vPFP13Lczf8dPlW5d7jcyade3+R
         1KEubkW2EFhw3fSns7WCJHQUm5UyGmqUmdq2o0W+fknvuLUb1+CwwZBIeiNHUB3ITFUE
         gMNb3W8R2qkPKwTHYO1YgkwqNDAFBcncYPSJAox3GdeDG4/gKwBMe3U2DawLmxPBFr0G
         ccTXCSUIVLqVms+i/MB/OirCbMOEJNtVnsK95Nn88RWThUh6yJ+Oc1woVaS8LaDY0EFI
         4hAw==
X-Gm-Message-State: AOAM530abvqx8iRdk2FnnIw0HKgVIVxlrYZstQlmHD6dTuj9HGzDnSX6
        vAa8sKAmcBr2ZrHb+X+YJPg=
X-Google-Smtp-Source: ABdhPJzD9Wbejjav7fs788hyVk1mh84/+OMqMrHpXu+Pcffr8tY6xELaD78JcIUL5B/jXYhrBEWytw==
X-Received: by 2002:a54:4619:: with SMTP id p25mr739247oip.18.1601574546980;
        Thu, 01 Oct 2020 10:49:06 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id z5sm1364942otp.16.2020.10.01.10.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 15/19] rdma_rxe: handle ERR_PTR returns from pool
Date:   Thu,  1 Oct 2020 12:48:43 -0500
Message-Id: <20201001174847.4268-16-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v7:
  - rxe_pool.c has been extended to return errors from alloc, get_index
    and get_key using ERR_PTR. Add code to detect these as needed.
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 28 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    | 11 +++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.c  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 +++-
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  8 ++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 16 +++++++--------
 8 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 541cc68a8a94..0dd8abefc13f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -16,8 +16,8 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	struct rxe_mc_grp *grp;
 
 	grp = __alloc(&rxe->mc_grp_pool);
-	if (unlikely(!grp))
-		return NULL;
+	if (IS_ERR(grp))
+		return grp;
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
@@ -28,7 +28,7 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	if (unlikely(err)) {
 		drop_key(grp);
 		rxe_drop_ref(grp);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	return grp;
@@ -43,20 +43,30 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 	unsigned long flags;
 
-	if (unlikely(rxe->attr.max_mcast_qp_attach == 0))
-		return -EINVAL;
+	if (unlikely(rxe->attr.max_mcast_qp_attach == 0)) {
+		err = -EINVAL;
+		goto err;
+	}
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	grp = __get_key(pool, mgid);
+	if (IS_ERR(grp))
+		goto err_ptr;
 	if (grp)
 		goto done;
 
 	grp = create_grp(rxe, pool, mgid);
-	if (unlikely(!grp))
-		err = -ENOMEM;
+	if (IS_ERR(grp))
+		goto err_ptr;
 done:
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 	*grp_p = grp;
+	return 0;
+
+err_ptr:
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+	err = PTR_ERR(grp);
+err:
 	return err;
 }
 
@@ -82,8 +92,8 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	mce = rxe_alloc(&rxe->mc_elem_pool);
-	if (!mce) {
-		err = -ENOMEM;
+	if (IS_ERR(mce)) {
+		err = PTR_ERR(mce);
 		goto out;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c3ad89d85360..e3eb0f4bb2a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -386,7 +386,7 @@ static struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 lkey)
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 
 	mr = rxe_get_key(&rxe->mr_pool, &lkey);
-	if (!mr)
+	if (IS_ERR(mr) || !mr)
 		return NULL;
 
 	if (unlikely((mr->ibmr.lkey != lkey) || (mr->pd != pd) ||
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 22d3570ac184..d2d09502a28d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -217,6 +217,8 @@ static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	rkey = mw->ibmw.rkey;
 	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
 	duplicate_mw = rxe_get_key(&rxe->mw_pool, &new_rkey);
+	if (IS_ERR(duplicate_mw))
+		return PTR_ERR(duplicate_mw);
 	if (duplicate_mw) {
 		pr_err_once("new MW key is a duplicate, try another\n");
 		rxe_drop_ref(duplicate_mw);
@@ -260,14 +262,23 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	if (qp->is_user) {
 		mw = rxe_get_index(&rxe->mw_pool,
 				   wqe->wr.wr.umw.mw_index);
+		if (IS_ERR(mw)) {
+			ret = PTR_ERR(mw);
+			goto err1;
+		}
 		if (!mw) {
 			pr_err_once("mw with index = %d not found\n",
 			wqe->wr.wr.umw.mw_index);
 			ret = -EINVAL;
 			goto err1;
 		}
+
 		mr = rxe_get_index(&rxe->mr_pool,
 				   wqe->wr.wr.umw.mr_index);
+		if (IS_ERR(mr)) {
+			ret = PTR_ERR(mr);
+			goto err2;
+		}
 		if (!mr && wqe->wr.wr.umw.length) {
 			pr_err_once("mr with index = %d not found\n",
 			wqe->wr.wr.umw.mr_index);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 9d53b4d71230..76e6609dcf02 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -581,7 +581,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 			(pool->flags & RXE_POOL_ATOMIC) ?
 			GFP_ATOMIC : GFP_KERNEL);
 	if (!obj)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	elem = (struct rxe_pool_entry *)((u8 *)obj +
 			rxe_type_info[pool->type].elem_offset);
@@ -591,9 +591,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 	if (err) {
 		kfree(obj);
-		obj = NULL;
+		return ERR_PTR(err);
 	}
-out:
+
 	return obj;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index dbb623ec5eaa..213c979b6b46 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -186,6 +186,8 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		index = (qpn == 1) ? port->qp_gsi_index : qpn;
 
 		qp = rxe_get_index(&rxe->qp_pool, index);
+		if (IS_ERR(qp))
+			goto err1;
 		if (unlikely(!qp)) {
 			pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn);
 			goto err1;
@@ -245,7 +247,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	/* lookup mcast group corresponding to mgid, takes a ref */
 	mcg = rxe_get_key(&rxe->mc_grp_pool, &dgid);
-	if (!mcg)
+	if (IS_ERR(mcg) || !mcg)
 		goto err1;	/* mcast group not registered */
 
 	spin_lock_bh(&mcg->mcg_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0428965c664b..3e815158df55 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -565,7 +565,7 @@ static int invalidate_key(struct rxe_qp *qp, u32 key)
 
 	if (key & IS_MW) {
 		mw = rxe_get_key(&rxe->mw_pool, &key);
-		if (!mw) {
+		if (IS_ERR(mw) || !mw) {
 			pr_err("No mw for key %#x\n", key);
 			return -EINVAL;
 		}
@@ -573,7 +573,7 @@ static int invalidate_key(struct rxe_qp *qp, u32 key)
 		rxe_drop_ref(mw);
 	} else {
 		mr = rxe_get_key(&rxe->mr_pool, &key);
-		if (!mr) {
+		if (IS_ERR(mr) || !mr) {
 			pr_err("No mr for key %#x\n", key);
 			return -EINVAL;
 		}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 58d3783063bb..47d863c4dd48 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -442,7 +442,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	 */
 	if (rkey & IS_MW) {
 		mw = rxe_get_key(&rxe->mw_pool, &rkey);
-		if (!mw) {
+		if (IS_ERR(mw) || !mw) {
 			pr_err_once("no MW found with rkey = 0x%08x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
@@ -466,7 +466,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		rxe_drop_ref(mw);
 	} else {
 		mr = rxe_get_key(&rxe->mr_pool, &rkey);
-		if (!mr || (mr->rkey != rkey)) {
+		if (IS_ERR(mr) || !mr || (mr->rkey != rkey)) {
 			pr_err_once("no MR found with rkey = 0x%08x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
@@ -794,7 +794,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 
 	if (rkey & IS_MW) {
 		mw = rxe_get_key(&rxe->mw_pool, &rkey);
-		if (!mw) {
+		if (IS_ERR(mw) || !mw) {
 			pr_err("No mw for rkey %#x\n", rkey);
 			goto err;
 		}
@@ -802,7 +802,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 		rxe_drop_ref(mw);
 	} else {
 		mr = rxe_get_key(&rxe->mr_pool, &rkey);
-		if (!mr || mr->ibmr.rkey != rkey) {
+		if (IS_ERR(mr) || !mr || mr->ibmr.rkey != rkey) {
 			pr_err("No mr for rkey %#x\n", rkey);
 			goto err;
 		}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4de263e41b07..58a3b66e6283 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -397,8 +397,8 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 		goto err1;
 
 	qp = rxe_alloc(&rxe->qp_pool);
-	if (!qp) {
-		err = -ENOMEM;
+	if (IS_ERR(qp)) {
+		err = PTR_ERR(qp);
 		goto err1;
 	}
 
@@ -872,9 +872,9 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	rxe_add_ref(pd);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
+	if (IS_ERR(mr)) {
 		rxe_drop_ref(pd);
-		return ERR_PTR(-ENOMEM);
+		return (void *)mr;
 	}
 
 	rxe_mr_init_dma(pd, access, mr);
@@ -905,8 +905,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	rxe_add_ref(pd);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
+	if (IS_ERR(mr)) {
+		err = PTR_ERR(mr);
 		goto err2;
 	}
 
@@ -956,8 +956,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	rxe_add_ref(pd);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
+	if (IS_ERR(mr)) {
+		err = PTR_ERR(mr);
 		goto err1;
 	}
 
-- 
2.25.1

