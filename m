Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281972805D6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbgJARtB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732962AbgJARtA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:00 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6EC0613E4
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so6291549ota.10
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVrthfqmmTxKfC664iHwanq0OmwqtLEiT1N3ENfO1s4=;
        b=uxEEHF44DuMO3/HU5S8ZeCzvwcG1dfApFesD0g8pu1kUtJ9w4QoXLKEB8EvhVRg/SU
         rukaHtzb1g59YU+yJkfqapXzL8HTXlGL4GeS6q9r2apFCgE/JO8ECe/KmxViovIVV8/D
         Jg/D/xSQWAyZvYQDtniTtOAcysTiDipqAueLfPcsziYCrMu/xdztNL/5qDd5NCsmsMV8
         KM4arzSCWgI29Avlq8XHK9tJFX6Cpj//O4gzLGe7pCd43U/Eax5QBRVxFc4oF0pU9PVD
         Uuf7lTmj/lRmx4JRP4HQgELJ8tQt5R3A3DOOLuYntFrtKC2+dGRKiKdb00l0qAoWHyQO
         ZXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVrthfqmmTxKfC664iHwanq0OmwqtLEiT1N3ENfO1s4=;
        b=bv7SKRh6wdz8x3N6VmDLBP5sfyqhTO2hfWSvlFaFIwn0udbxK1ZabJeFMjH664W8T1
         69mOebvu3OO0FbMT/WDt1Rr/iOhK1QR2d10Tfef8oBGfp2zYuL1b3xUKwYAbo0dQgKg9
         eLUuvrvq9L38C7Rv0xpf1nDJoQ9cvh2q387+jEBo2N5m3wwqj24BIsi0jvk9Drz9WFhs
         tlAOVeVkr5xT856PAKAL93xrQJqA1L1z5d17emHIStPjEKsg1gTFs13dzfIfUZpM1vLF
         c7wehhkw37eBZGw29WmoyFkreMM4AuRKwVTAgldFJCxl9xiApjkDZf917fTYuOaSmwT9
         /3Hg==
X-Gm-Message-State: AOAM5324xjwaxTYw3IDJ/7GaTcWrclfa+NePWLBPgex1Y0ka7wdLXJiU
        ekWrW17od3Nr0fMrSzQd+6U=
X-Google-Smtp-Source: ABdhPJzPlbMhWNIGMQIZPX93E21dW2wtMwMVg5jAvJBkPFkHzSaH6FOOWKKm/Jd3QwLrPy6Jipy+uA==
X-Received: by 2002:a9d:1726:: with SMTP id i38mr5352060ota.252.1601574539555;
        Thu, 01 Oct 2020 10:48:59 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id l136sm1191792oig.7.2020.10.01.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:48:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 06/19] rdma_rxe: add alloc_mw and dealloc_mw verbs
Date:   Thu,  1 Oct 2020 12:48:34 -0500
Message-Id: <20201001174847.4268-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v7:
 - Adjust for mw being allocated in core.
 - Made MW NO_ALLOC type in pool
 - Rearranged rxe_mw struct to make ibmw first
v6:
 - Add a new file focused on memory windows, rxe_mw.c.
 - Add alloc_mw and dealloc_mw verbs and added them to
   the list of supported user space verbs.
 - Added indices AND keys for MW and MR.
 - Add indices to user api response for MW and MR
 - Replaced lookup by index with lookup by key in rxe_req.c
   and rxe_resp.c
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/Makefile    |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  7 +++
 drivers/infiniband/sw/rxe/rxe_mr.c    | 80 +++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 85 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.c  | 50 ++++++++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 53 +++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 10 +++-
 include/uapi/rdma/rdma_user_rxe.h     | 10 ++++
 11 files changed, 219 insertions(+), 87 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 66af72dca759..1e24673e9318 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -15,6 +15,7 @@ rdma_rxe-y := \
 	rxe_qp.o \
 	rxe_cq.o \
 	rxe_mr.o \
+	rxe_mw.o \
 	rxe_opcode.o \
 	rxe_mmap.o \
 	rxe_icrc.o \
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 9ec6bff6863f..1502aa557621 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -109,6 +109,13 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
+/* rxe_mw.c */
+int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
+
+int rxe_dealloc_mw(struct ib_mw *ibmw);
+
+void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f40cf4df394f..af2d0d8877fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -7,21 +7,18 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/*
- * lfsr (linear feedback shift register) with period 255
+/* choose a unique non zero random number for lkey
+ * use high order bit to indicate MR vs MW
  */
-static u8 get_key(void)
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
+again:
+	get_random_bytes(&lkey, sizeof(lkey));
+	lkey &= ~IS_MW;
+	if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
+		return;
+	goto again;
 }
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
@@ -49,36 +46,18 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | get_key();
-	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
+	rxe_add_index(mr);
+	rxe_set_mr_lkey(mr);
+	if (access & IB_ACCESS_REMOTE)
+		mr->ibmr.rkey = mr->ibmr.lkey;
 
-	if (mr->pelem.pool->type == RXE_TYPE_MR) {
-		mr->ibmr.lkey		= lkey;
-		mr->ibmr.rkey		= rkey;
-	}
-
-	mr->lkey		= lkey;
-	mr->rkey		= rkey;
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
@@ -531,20 +510,13 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mr corresponding to lkey/rkey
- *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mr pd
- * (3) verify that the mr can support the requested access
- * (4) verify that mr state is valid
- */
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			   enum lookup_type type)
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
-	int index = key >> 8;
 
-	mr = rxe_get_index(&rxe->mr_pool, index);
+	mr = rxe_get_key(&rxe->mr_pool, &key);
 	if (!mr)
 		return NULL;
 
@@ -559,3 +531,21 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	return mr;
 }
+
+void rxe_mr_cleanup(struct rxe_pool_entry *elem)
+{
+	struct rxe_mr *mr = container_of(elem, typeof(*mr), pelem);
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
new file mode 100644
index 000000000000..c10e8762243f
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ */
+
+#include "rxe.h"
+#include "rxe_loc.h"
+
+/* choose a unique non zero random number for rkey
+ * use high order bit to indicate MR vs MW
+ */
+static void rxe_set_mw_rkey(struct rxe_mw *mw)
+{
+	u32 rkey;
+again:
+	get_random_bytes(&rkey, sizeof(rkey));
+	rkey |= IS_MW;
+	if (likely((rkey & ~IS_MW) &&
+	   (rxe_add_key(mw, &rkey) == 0)))
+		return;
+	goto again;
+}
+
+int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
+{
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	struct rxe_dev *rxe = to_rdev(ibmw->device);
+	struct rxe_alloc_mw_resp __user *uresp = NULL;
+	int ret;
+
+	if (udata) {
+		if (udata->outlen < sizeof(*uresp))
+			return -EINVAL;
+		uresp = udata->outbuf;
+	}
+
+	ret = rxe_add_to_pool(&rxe->mw_pool, mw);    /* takes a ref on mw */
+	if (ret)
+		return ret;
+
+	rxe_add_ref(pd);
+	rxe_add_index(mw);
+	rxe_set_mw_rkey(mw);	/* sets mw->ibmw.rkey */
+
+	spin_lock_init(&mw->lock);
+	mw->state		= (mw->ibmw.type == IB_MW_TYPE_2) ?
+					RXE_MEM_STATE_FREE :
+					RXE_MEM_STATE_VALID;
+
+	if (uresp) {
+		if (copy_to_user(&uresp->index, &mw->pelem.index,
+				 sizeof(uresp->index))) {
+			rxe_drop_ref(mw);
+			rxe_drop_ref(pd);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+int rxe_dealloc_mw(struct ib_mw *ibmw)
+{
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+	mw->state = RXE_MEM_STATE_INVALID;
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(mw);
+	rxe_drop_ref(pd);
+
+	return 0;
+}
+
+void rxe_mw_cleanup(struct rxe_pool_entry *elem)
+{
+	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
+
+	rxe_drop_index(mw);
+	rxe_drop_key(mw);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index e40a64616d79..43b4f91d86be 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -14,7 +14,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, pelem),
-		.flags          = RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
@@ -26,13 +26,14 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, pelem),
-		.flags		= RXE_POOL_ATOMIC | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, pelem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -41,7 +42,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, pelem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_ATOMIC
+				| RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -49,7 +51,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, pelem),
-		.flags          = RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
@@ -57,25 +59,37 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, pelem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_ATOMIC
+				| RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
+		.key_offset	= offsetof(struct rxe_mr, ibmr.lkey)
+				  - offsetof(struct rxe_mr, pelem),
+		.key_size	= sizeof(u32),
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, pelem),
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_NO_ALLOC
+				| RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
+		.key_offset	= offsetof(struct rxe_mw, ibmw.rkey)
+				  - offsetof(struct rxe_mw, pelem),
+		.key_size	= sizeof(u32),
 	},
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
 		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
 		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY,
-		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
+		.flags		= RXE_POOL_ATOMIC
+				| RXE_POOL_KEY,
+		.key_offset	= offsetof(struct rxe_mc_grp, mgid)
+				  - offsetof(struct rxe_mc_grp, pelem),
 		.key_size	= sizeof(union ib_gid),
 	},
 	[RXE_TYPE_MC_ELEM] = {
@@ -233,7 +247,7 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
@@ -249,7 +263,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
-			goto out;
+			return -EAGAIN;
 		}
 
 		if (cmp > 0)
@@ -260,19 +274,22 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 	rb_link_node(&new->key_node, parent, link);
 	rb_insert_color(&new->key_node, &pool->key.tree);
-out:
-	return;
+
+	return 0;
 }
 
-void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
+	int ret;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	insert_key(pool, elem);
+	ret = insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
 }
 
 void __rxe_drop_key(struct rxe_pool_entry *elem)
@@ -354,8 +371,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
 	unsigned long flags;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
-
 	read_lock_irqsave(&pool->pool_lock, flags);
 	if (pool->state != RXE_POOL_STATE_VALID) {
 		read_unlock_irqrestore(&pool->pool_lock, flags);
@@ -469,7 +484,6 @@ void *rxe_get_key(struct rxe_pool *pool, void *key)
 		obj = (u8 *)elem - info->elem_offset;
 	}
 
-
 out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 	return obj;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2f9be92ef6f9..e0e75faca96a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -121,7 +121,7 @@ void __rxe_drop_index(struct rxe_pool_entry *elem);
 
 #define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
 
-void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ea08464e461d..fe3fcc70411d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -599,8 +599,8 @@ int rxe_requester(void *arg)
 			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 			struct rxe_mr *rmr;
 
-			rmr = rxe_get_index(&rxe->mr_pool,
-						 wqe->wr.ex.invalidate_rkey >> 8);
+			rmr = rxe_get_key(&rxe->mr_pool,
+					    &wqe->wr.ex.invalidate_rkey);
 			if (!rmr) {
 				pr_err("No mr for key %#x\n",
 				       wqe->wr.ex.invalidate_rkey);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9f96b4b706c3..cc8a0bb7530b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -888,8 +888,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
 
-				rmr = rxe_get_index(&rxe->mr_pool,
-							 wc->ex.invalidate_rkey >> 8);
+				rmr = rxe_get_key(&rxe->mr_pool,
+						  &wc->ex.invalidate_rkey);
 				if (unlikely(!rmr)) {
 					pr_err("Bad rkey %#x invalidation\n",
 					       wc->ex.invalidate_rkey);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index db1d7f5ca2a7..f9425daad924 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -869,12 +869,14 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
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
@@ -890,6 +892,17 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
@@ -897,22 +910,25 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
 
@@ -922,7 +938,6 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 	return 0;
 }
@@ -938,16 +953,14 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
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
@@ -955,10 +968,9 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
+	rxe_drop_ref(pd);
 	return ERR_PTR(err);
 }
 
@@ -1105,9 +1117,12 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
+	.alloc_mw = rxe_alloc_mw,
+	.dealloc_mw = rxe_dealloc_mw,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
 	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
@@ -1166,6 +1181,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
+	    | BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW)
+	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
 	    ;
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index dbc649c9c43f..3253508a3b74 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -319,9 +319,12 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+/* use high order bit to separate MW and MR rkeys */
+#define IS_MW  (1 << 31)
+
 struct rxe_mw {
-	struct rxe_pool_entry	pelem;
 	struct ib_mw		ibmw;
+	struct rxe_pool_entry	pelem;
 	struct rxe_qp		*qp;	/* type 2B only */
 	struct rxe_mr		*mr;
 	spinlock_t		lock;
@@ -441,6 +444,11 @@ static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
 	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
 }
 
+static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
+{
+	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index d8f2e0e46dab..4ad0fa0b2ab9 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -175,4 +175,14 @@ struct rxe_modify_srq_cmd {
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

