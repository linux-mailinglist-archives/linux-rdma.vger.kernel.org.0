Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F97F4A521D
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiAaWKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiAaWKQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:16 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE5C061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:16 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id e81so29570043oia.6
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIc5VDJc+DCdBKA/jf3bVYVvCkoKJbmsqCkrUFi/7bM=;
        b=TonqHlriJKe4oDZJHsmnCtpydvo/cA86EHlA0vhbWzuKxiyFxH8/IpgKf8UTqFnqjm
         Q3bnSi0HZp0mGdP+pfc0WctZeSVMbpF01PaCDjxFGHtny5jGE9p/VYA8mMyOLhFu79tp
         nEOeCnx3W5b+3ktrQdh/wng/q93gceKTIcUUJE58cxG/uTxu0TbO6z8FyK+CJk5qk0QD
         eAwA/eKZkzNGA3LsBtZT3saqBO8KVGnACAlO/3jIlsN7NmrUiNhHJpYtIceJ1imSLpLp
         XdfUna9oBX0sm4WLbFieARggcQKMXmjWhuinV3NLCRwMbcwj5TOfO6iP7dEzMgT15cKg
         PYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIc5VDJc+DCdBKA/jf3bVYVvCkoKJbmsqCkrUFi/7bM=;
        b=PWq2gUYRs0Nt6jKBdYNcjkI/IBVPoYpR39zIHX0tLoeK3yaHyCE5b2qXNRbBTTiXuy
         rHyOCevMiHXu8FIqLRL8IAkEOZEBhhmzYqgTeZqmDLcmwUzBR0j3CoQ1MWCmPzC2ttSu
         Lz4vFRkfcb/KUv+OxuehDUorS0JKfwNnnnR/NFOzK5K76DGO9VkmqyAq9a9wy0sAow2J
         TLibL1va8xRNKTKTDUWfiBtWGTjvWYWRbpmMcfF2ebcBwNqLz/qGVGLEDTphNiGlbLMc
         785j0R0+4elxRtFpfWErcR7LhO9Bt7OjQQNfYWcWDiOfId3a5FkM3w0h6RMgkEG4PzV5
         508g==
X-Gm-Message-State: AOAM5313vI49li1tpn1tHzjfEEpXZGtjgSF3wUIhQJWPFOgkR3Bgv2ZN
        ZbtuVbxnouFwO6aebpiOqqs=
X-Google-Smtp-Source: ABdhPJwXAIQIHwU/RFm4yFLS260blc/ErQeQQUxTAEk0GMLPofylpM5hJr1BuguRLCbU8kUfOPaQnw==
X-Received: by 2002:a05:6808:189d:: with SMTP id bi29mr18752800oib.68.1643667015383;
        Mon, 31 Jan 2022 14:10:15 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:15 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 14/17] RDMA/rxe: Remove mcg from rxe pools
Date:   Mon, 31 Jan 2022 16:08:47 -0600
Message-Id: <20220131220849.10170-15-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Finish removing mcg from rxe pools. Replace rxe pools ref counting by
kref's. Replace rxe_alloc by kzalloc.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  8 ---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mcast.c | 91 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  5 --
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 -
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  4 +-
 7 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 310e184ae9e8..c560d467a972 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -28,7 +28,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->cq_pool);
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
-	rxe_pool_cleanup(&rxe->mc_grp_pool);
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
@@ -157,15 +156,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
 	if (err)
 		goto err8;
 
-	err = rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
-			    rxe->attr.max_mcast_grp);
-	if (err)
-		goto err9;
-
 	return 0;
 
-err9:
-	rxe_pool_cleanup(&rxe->mw_pool);
 err8:
 	rxe_pool_cleanup(&rxe->mr_pool);
 err7:
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bd701af7758c..409efeecd581 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -43,6 +43,7 @@ void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
+void rxe_cleanup_mcg(struct kref *kref);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 82669d14d8a9..ed23d0a270fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -98,7 +98,7 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	}
 
 	if (node) {
-		rxe_add_ref(mcg);
+		kref_get(&mcg->ref_cnt);
 		return mcg;
 	}
 
@@ -141,11 +141,13 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (unlikely(err))
 		return err;
 
+	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
+	mcg->index = rxe->mcg_next++;
 
-	rxe_add_ref(mcg);
+	kref_get(&mcg->ref_cnt);
 	__rxe_insert_mcg(mcg);
 
 
@@ -163,7 +165,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 		       struct rxe_mcg **mcgp)
 {
-	struct rxe_pool *pool = &rxe->mc_grp_pool;
 	struct rxe_mcg *mcg, *tmp;
 	int err;
 
@@ -178,7 +179,7 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	}
 
 	/* speculative alloc of mcg */
-	mcg = rxe_alloc(pool);
+	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
 	if (!mcg)
 		return -ENOMEM;
 
@@ -186,7 +187,7 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	/* re-check to see if someone else just added it */
 	tmp = __rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
-		rxe_drop_ref(mcg);
+		kfree(mcg);
 		mcg = tmp;
 		goto out;
 	}
@@ -206,10 +207,53 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 err_dec:
 	atomic_dec(&rxe->mcg_num);
 	spin_unlock_bh(&rxe->mcg_lock);
-	rxe_drop_ref(mcg);
+	kfree(mcg);
 	return err;
 }
 
+/**
+ * rxe_cleanup_mcg - cleanup mcg for kref_put
+ * @kref:
+ *
+ * caller may or may not hold rxe->mcg_lock
+ */
+void rxe_cleanup_mcg(struct kref *kref)
+{
+	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
+
+	kfree(mcg);
+}
+
+/**
+ * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
+ * @mcg: the mcg object
+ *
+ * Context: caller is holding rxe->mcg_lock, no qp's are attached to mcg
+ */
+void __rxe_destroy_mcg(struct rxe_mcg *mcg)
+{
+	struct rxe_dev *rxe = mcg->rxe;
+
+	__rxe_remove_mcg(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
+	rxe_mcast_delete(rxe, &mcg->mgid);
+	atomic_dec(&rxe->mcg_num);
+}
+
+/**
+ * rxe_destroy_mcg - destroy mcg object
+ * @mcg: the mcg object
+ *
+ * Context: no qp's are attached to mcg
+ */
+static void rxe_destroy_mcg(struct rxe_mcg *mcg)
+{
+	spin_lock_bh(&mcg->rxe->mcg_lock);
+	__rxe_destroy_mcg(mcg);
+	spin_unlock_bh(&mcg->rxe->mcg_lock);
+}
+
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mcg *mcg)
 {
@@ -259,35 +303,6 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
-/**
- * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
- * @mcg: the mcg object
- *
- * Context: caller is holding rxe->mcg_lock, all refs to mcg are dropped
- * no qp's are attached to mcg
- */
-void __rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	__rxe_remove_mcg(mcg);
-
-	rxe_drop_ref(mcg);
-
-	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
-}
-
-/**
- * rxe_destroy_mcg - destroy mcg object
- * @mcg: the mcg object
- *
- * Context: all refs to mcg are dropped, no qp's are attached to mcg
- */
-static void rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	spin_lock_bh(&mcg->rxe->mcg_lock);
-	__rxe_destroy_mcg(mcg);
-	spin_unlock_bh(&mcg->rxe->mcg_lock);
-}
-
 static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
@@ -308,14 +323,14 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&rxe->mcg_lock);
-			rxe_drop_ref(mcg);
+			kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 			kfree(mca);
 			return 0;
 		}
 	}
 
 	spin_unlock_bh(&rxe->mcg_lock);
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 err1:
 	return -EINVAL;
 }
@@ -336,7 +351,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (atomic_read(&mcg->qp_num) == 0)
 		rxe_destroy_mcg(mcg);
 
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 	return err;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index fe0fcca47d8d..b6fe7c93aaab 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -79,11 +79,6 @@ static const struct rxe_type_info {
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
-	[RXE_TYPE_MC_GRP] = {
-		.name		= "rxe-mcg",
-		.size		= sizeof(struct rxe_mcg),
-		.elem_offset	= offsetof(struct rxe_mcg, elem),
-	},
 };
 
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b6de415e10d2..99b1eb04b405 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -21,7 +21,6 @@ enum rxe_elem_type {
 	RXE_TYPE_CQ,
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
-	RXE_TYPE_MC_GRP,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 9a92e5a486ee..04fe0cd36d6c 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -275,6 +275,8 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 			break;
 	}
 	spin_unlock_bh(&rxe->mcg_lock);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
 	nmax = n;
 
 	/* this is unreliable datagram service so we let
@@ -320,8 +322,6 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 
 	kfree(qp_array);
 
-	rxe_drop_ref(mcg);
-
 	if (likely(!skb))
 		return;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ea2d9ff29744..97d3a59e5c6f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -352,12 +352,13 @@ struct rxe_mw {
 };
 
 struct rxe_mcg {
-	struct rxe_pool_elem	elem;
 	struct rb_node		node;
+	struct kref		ref_cnt;
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	atomic_t		qp_num;
 	union ib_gid		mgid;
+	unsigned int		index;
 	u32			qkey;
 	u16			pkey;
 };
@@ -400,6 +401,7 @@ struct rxe_dev {
 	spinlock_t		mcg_lock; /* guard multicast groups */
 	struct rb_root		mcg_tree;
 	atomic_t		mcg_num;
+	unsigned int		mcg_next;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

