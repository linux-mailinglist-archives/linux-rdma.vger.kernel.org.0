Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DD24C7F5
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgHTWrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4AC061387
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:24 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z22so3357034oid.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHiGkSKhfArgexvpZW2N1CSSksUJE/G0SIzbfkNs6lM=;
        b=V5uKmMjz4B6FuOuAZfnrIyJYtslqI7ufQdQ+gHO6YYfJfH1GDUlYUWihxRNnVe6zW0
         TvB8/9kKcEZ5LDpFMORGIc9TvUNd92sNOXByvu1MmsElWUsm5fF3aDmPpWSUUKjB9jNN
         8H6eg2IV2znYfbUVvQu0Ka4PWf9qVW/u3CDXfX6KLGbOGJZbYOK1kHD20TCGJ0FAP5cU
         F8SahTcVYN5mVsQkKPAna5tXXt8a0DJwF/ExHDZ8/JBcVyzue2wEkm0N0JAQtZT6yPVw
         b5m+M0+0JiJfPsWNiP2mOBdYpq52qNuJv5oMPU+PScehBx1C2Ia/FdEuX1Lpi7P8wSEv
         w+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHiGkSKhfArgexvpZW2N1CSSksUJE/G0SIzbfkNs6lM=;
        b=QCe17UFiODf8gtAawEGqGyRjP1B1sK2z9se77AFWyvKCT8mhG3ipFqKaSN+QAgh/KN
         ElMDW2C/FVob1wC91dvOtmkWcgAgRkAbs4trDRSnIlIWZ41bjiGQt5rODhhlwt+66D1M
         8PO2XWDJXhvk4ZkPKTSzyRKpkF8u+jlkaxmJJfmBNO/CA2TrcCdZR4niMcMSrHOlak54
         dtos9ft5vrhDlPSldnUo2+BmFg9H0rIlWMsBkDYKy19PhwWymwutJaUy8EJ2ayY6VVFu
         E4noejivywV22UTaOL0yye+LtMDXP72eBa/rvjo5eEqAl8AicBdI8sPLrhIPz8TLOHVr
         nOVA==
X-Gm-Message-State: AOAM531+CbfZLPzDAGaZWLPXrddSOih/sYI3eVd0RHeFIo8fllvgU2EB
        V3ber6QUMyQ69yP4bKypUrjkIWsgD6aGgg==
X-Google-Smtp-Source: ABdhPJxRVdtVAFxm86CAPnDshnpvZV/NBKehVQ+efkx9i8YWtI1hIuCeCiX1BZr8VpgVQ4nAXtYmsw==
X-Received: by 2002:a05:6808:256:: with SMTP id m22mr15296oie.103.1597963643537;
        Thu, 20 Aug 2020 15:47:23 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id u20sm5686ots.0.2020.08.20.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 13/17] rdma_rxe: Give MR and MW objects indices and keys
Date:   Thu, 20 Aug 2020 17:46:34 -0500
Message-Id: <20200820224638.3212-14-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Give each MR and each MW an index and a key.
Added a random key generator for each type.
Added responses for ibv_reg_mr and ibv_alloc_mw with the
assigned indices so other verbs can refer to them by index.
Changed key lookups to rxe_pool_get_key instead of rxe_pool_get_index.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 80 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 49 ++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 32 ++++++-----
 drivers/infiniband/sw/rxe/rxe_pool.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  6 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 48 ++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +
 include/uapi/rdma/rdma_user_rxe.h     | 10 ++++
 10 files changed, 152 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 18ae0eb11fa8..b8ad96e4e005 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -116,6 +116,7 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 7b870873edca..cebf16b2ab15 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -9,21 +9,21 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/*
- * lfsr (linear feedback shift register) with period 255
+/* choose a unique non zero random number for lkey
+ * use high order bit to indicate MR vs MW
  */
-static u8 rxe_get_key(void)
+static void rxe_set_mr_lkey(struct rxe_mr *mr)
 {
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
+	u32 lkey;
+	int tries = 0;
+
+	do {
+		get_random_bytes(&lkey, sizeof(lkey));
+		lkey &= ~IS_MW;
+		if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
+			return;
+	} while (tries++ < 10);
+	pr_err("unable to get random lkey for mr\n");
 }
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
@@ -51,36 +51,19 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
-	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
-
-	if (mr->pelem.pool->type == RXE_TYPE_MR) {
-		mr->ibmr.lkey		= lkey;
-		mr->ibmr.rkey		= rkey;
-	}
-
-	mr->lkey		= lkey;
-	mr->rkey		= rkey;
+	rxe_add_index(mr);
+	rxe_set_mr_lkey(mr);
+	if (access & IB_ACCESS_REMOTE)
+		mr->ibmr.rkey = mr->ibmr.lkey;
+
+	/* TODO should not have two copies of lkey and rkey in mr */
+	mr->lkey		= mr->ibmr.lkey;
+	mr->rkey		= mr->ibmr.rkey;
 	mr->state		= RXE_MEM_STATE_INVALID;
 	mr->type		= RXE_MR_TYPE_NONE;
 	mr->map_shift		= ilog2(RXE_BUF_PER_MAP);
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
@@ -543,9 +526,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
-	int index = key >> 8;
 
-	mr = rxe_pool_get_index(&rxe->mr_pool, index);
+	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
 	if (!mr)
 		return NULL;
 
@@ -560,3 +542,21 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	return mr;
 }
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
+
+	rxe_drop_index(mr);
+	rxe_drop_key(mr);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index b461aed98c0c..c4ba85c507a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -8,6 +8,24 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* choose a unique non zero random number for rkey
+ * use high order bit to indicate MR vs MW
+ */
+static void rxe_set_mw_rkey(struct rxe_mw *mw)
+{
+	u32 rkey;
+	int tries = 0;
+
+	do {
+		get_random_bytes(&rkey, sizeof(rkey));
+		rkey |= IS_MW;
+		if (likely((rkey & ~IS_MW) &&
+			   (rxe_add_key(mw, &rkey) == 0)))
+			return;
+	} while (tries++ < 10);
+	pr_err("unable to get random rkey for mw\n");
+}
+
 /* this temporary code to test ibv_alloc_mw, ibv_dealloc_mw */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata)
@@ -16,6 +34,13 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_mw *mw;
 	u32 rkey;
+	struct rxe_alloc_mw_resp __user *uresp = NULL;
+
+	if (udata) {
+		if (udata->outlen < sizeof(*uresp))
+			return ERR_PTR(-EINVAL);
+		uresp = udata->outbuf;
+	}
 
 	if (unlikely((type != IB_MW_TYPE_1) &&
 		     (type != IB_MW_TYPE_2)))
@@ -29,11 +54,8 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* pick a random rkey for now */
-	get_random_bytes(&rkey, sizeof(rkey));
-
 	rxe_add_index(mw);
-	rxe_add_key(mw, &rkey);
+	rxe_set_mw_rkey(mw);
 
 	spin_lock_init(&mw->lock);
 	mw->qp			= NULL;
@@ -47,6 +69,15 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 					RXE_MEM_STATE_FREE :
 					RXE_MEM_STATE_VALID;
 
+	if (uresp) {
+		if (copy_to_user(&uresp->index, &mw->pelem.index,
+				 sizeof(uresp->index))) {
+			rxe_drop_ref(mw);
+			rxe_drop_ref(pd);
+			return ERR_PTR(-EFAULT);
+		}
+	}
+
 	return &mw->ibmw;
 }
 
@@ -61,8 +92,6 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	spin_unlock_irqrestore(&mw->lock, flags);
 
 	rxe_drop_ref(pd);
-	rxe_drop_index(mw);
-	rxe_drop_key(mw);
 	rxe_drop_ref(mw);
 
 	return 0;
@@ -73,3 +102,11 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	pr_err_once("%s: not implemented\n", __func__);
 	return -EINVAL;
 }
+
+void rxe_mw_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
+
+	rxe_drop_index(mw);
+	rxe_drop_key(mw);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 374e56689d30..2e9451605aac 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -9,15 +9,12 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* info about object pools
- * note that mr and mw share a single index space
- * so that one can map an lkey to the correct type of object
- */
+/* info about object pools */
 struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
-		.flags          = RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
@@ -50,24 +47,30 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
-		.flags          = RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mr),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
+		.key_offset	= offsetof(struct rxe_mr, ibmr.lkey),
+		.key_size	= sizeof(u32),
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
+		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX
 				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
+		.key_offset	= offsetof(struct rxe_mw, ibmw.rkey),
+		.key_size	= sizeof(u32),
 	},
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
@@ -298,7 +301,7 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
@@ -314,7 +317,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
-			goto out;
+			return -EAGAIN;
 		}
 
 		if (cmp > 0)
@@ -325,20 +328,23 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 	rb_link_node(&new->key_node, parent, link);
 	rb_insert_color(&new->key_node, &pool->key.tree);
-out:
-	return;
+
+	return 0;
 }
 
-void rxe_add_key(void *arg, void *key)
+int rxe_add_key(void *arg, void *key)
 {
+	int ret;
 	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	insert_key(pool, elem);
+	ret = insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
 }
 
 void rxe_drop_key(void *arg)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index fc5b584a8137..c848a375f66a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -135,7 +135,7 @@ void rxe_drop_index(void *elem);
 /* assign a key to a keyed object and insert object into
  *  pool's rb tree
  */
-void rxe_add_key(void *elem, void *key);
+int rxe_add_key(void *elem, void *key);
 
 /* remove elem from rb tree */
 void rxe_drop_key(void *elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 46550a6fd6f8..be1871a34380 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -601,13 +601,13 @@ int rxe_requester(void *arg)
 	if (wqe->mask & WR_LOCAL_MASK) {
 		switch (wqe->wr.opcode) {
 		case IB_WR_LOCAL_INV:
-			mr = rxe_pool_get_index(&rxe->mr_pool,
-					wqe->wr.ex.invalidate_rkey >> 8);
+			mr = rxe_pool_get_key(&rxe->mr_pool,
+					&wqe->wr.ex.invalidate_rkey);
 			if (!mr) {
 				pr_err("No mr for key %#x\n",
 				       wqe->wr.ex.invalidate_rkey);
 				wqe->state = wqe_state_error;
-				wqe->status = IB_WC_MW_BIND_ERR;
+				wqe->status = IB_WC_LOC_QP_OP_ERR;
 				/* TODO this should be goto err */
 				goto exit;
 			}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 6748cdde4e78..96ab9f62a8fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -890,8 +890,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
 
-				rmr = rxe_pool_get_index(&rxe->mr_pool,
-							 wc->ex.invalidate_rkey >> 8);
+				rmr = rxe_pool_get_key(&rxe->mr_pool,
+						 &wc->ex.invalidate_rkey);
 				if (unlikely(!rmr)) {
 					pr_err("Bad rkey %#x invalidation\n",
 					       wc->ex.invalidate_rkey);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d1630a2134da..1ae3fbc3c93e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -870,12 +870,14 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
 
+	rxe_add_ref(pd);
+
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
+	if (!mr) {
+		rxe_drop_ref(pd);
 		return ERR_PTR(-ENOMEM);
+	}
 
-	rxe_add_index(mr);
-	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
@@ -891,6 +893,17 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	struct rxe_reg_mr_resp __user *uresp = NULL;
+
+	if (udata) {
+		if (udata->outlen < sizeof(*uresp)) {
+			err = -EINVAL;
+			goto err1;
+		}
+		uresp = udata->outbuf;
+	}
+
+	rxe_add_ref(pd);
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
@@ -898,22 +911,25 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
-
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_user(pd, start, length, iova,
-				access, udata, mr);
+			       access, udata, mr);
 	if (err)
 		goto err3;
 
-	return &mr->ibmr;
+	if (uresp) {
+		if (copy_to_user(&uresp->index, &mr->pelem.index,
+				 sizeof(uresp->index))) {
+			err = -EFAULT;
+			goto err3;
+		}
+	}
 
+	return &mr->ibmr;
 err3:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
+	rxe_drop_ref(pd);
+err1:
 	return ERR_PTR(err);
 }
 
@@ -923,7 +939,6 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 	return 0;
 }
@@ -939,16 +954,14 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (mr_type != IB_MR_TYPE_MEM_REG)
 		return ERR_PTR(-EINVAL);
 
+	rxe_add_ref(pd);
+
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
 		err = -ENOMEM;
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
 		goto err2;
@@ -956,10 +969,9 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
+	rxe_drop_ref(pd);
 	return ERR_PTR(err);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 922fab9df6f1..a042fa47aa40 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -322,6 +322,9 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+/* use high order bit to separate MW and MR rkeys */
+#define IS_MW  (1 << 31)
+
 struct rxe_mw {
 	struct rxe_pool_entry	pelem;
 	struct ib_mw		ibmw;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index dc01e5f3e31a..fdf6d13ed4b7 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -183,4 +183,14 @@ struct rxe_modify_srq_cmd {
 	__aligned_u64 mmap_info_addr;
 };
 
+struct rxe_reg_mr_resp {
+	__u32 index;
+	__u32 reserved;
+};
+
+struct rxe_alloc_mw_resp {
+	__u32 index;
+	__u32 reserved;
+};
+
 #endif /* RDMA_USER_RXE_H */
-- 
2.25.1

