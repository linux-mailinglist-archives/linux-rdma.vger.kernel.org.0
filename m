Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245E84780AD
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhLPXeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 18:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhLPXeE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 18:34:04 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE4C06173E
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:04 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w64so1118183oif.10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouh7zjGbN+ZSOtaWaqJLRp0o3MFaoSAc5TutDyk3nFc=;
        b=mg869s7mmuqTOfP5THD03dzYLJ6eLTSG2bGpzJmnU+pa+D9/kpjqq8BuO2AQhbTUai
         G2lT0a7cPVPGN2xOY5xDbsEx1RtcR+YrqOKpnNqNxO998dUKXlVU3wF15RNwt79WaWzD
         f0MACvu+GEN7FHaOzxZzsIiJdXQqHki2bW8QLA5uIE2RT97BusSa4cv1eyZmfSB/GkKP
         BOE4U4FFMmOcSt1lxvjQKvtxbVZPa2Y6BwrQjwoxeeMapJIcwkibe9YMmt4LTws6OpyF
         TL+yPgwRQ8jwfWCWk7OO46oagL0dc+MxBFg6krs3aX/dcZxomb0Lbo8AE1BthcvIqH4X
         G/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouh7zjGbN+ZSOtaWaqJLRp0o3MFaoSAc5TutDyk3nFc=;
        b=7nS0+6x2AiI560IlZc3w9Yrz1n3QfK2bUY22c73kuCJeKpFhz2KlGCxt9WSkNq1gT7
         g2UX+hpM1k5ZcvwG2zMMYqX6GvAVs5TUme4WyWwDhBBUmUqHXO1GFjE7+mIcKqzY1B4l
         y5k0gdvH/mFLPuZMTwVVVpai3S8bjvTgMOKskWdxFC5bsi/zvA6FIjmXH5FhnhhiA2Oi
         r9Y+U/7O/tbnBZzGrcWi9R0x1ZHFewqby6tomPKyg7vRIaVBhheavUQl2mtui6DFU5ah
         RsQJERyF19YgaobRk3AqoRyst8k3SVoiUMe3MU5rA2lXYgL6j+xp/vPBAjHt/Hg465h7
         YW3A==
X-Gm-Message-State: AOAM530VPTMps9edYgyjUVHnZiGCXBWH2Aau4TJ5BojRu38Ek3sIWWAu
        LPUeu5wsHI20bNli7T6C45A=
X-Google-Smtp-Source: ABdhPJyWiRKCok9pMgy5jPGxFiOdLyoM1FNv53C9jfbbn4VNw3Hr/xamxcfmNxNU70Cej6gLP9ArjQ==
X-Received: by 2002:aca:603:: with SMTP id 3mr165723oig.98.1639697643703;
        Thu, 16 Dec 2021 15:34:03 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ec41-d089-dfdb-6fb5.res6.spectrum.com. [2603:8081:140c:1a00:ec41:d089:dfdb:6fb5])
        by smtp.googlemail.com with ESMTPSA id w19sm1253888oih.44.2021.12.16.15.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:34:03 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 7/8] RDMA/rxe: Replace rxe_alloc by kzalloc for rxe_mc_elem
Date:   Thu, 16 Dec 2021 17:32:01 -0600
Message-Id: <20211216233201.14893-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233201.14893-1-rpearsonhpe@gmail.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe_mc_elem structs are treated as rdma objects which is
unneeded. This patch replaces rxe_alloc and rxe_drop_ref by kzalloc and
kfree for these structs which hold associatons between multicast groups
and QPs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  3 ---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 22 ++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  6 ------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 --
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 09c73a0d8513..20a925aed29c 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -31,7 +31,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
 	rxe_pool_cleanup(&rxe->mc_grp_pool);
-	rxe_pool_cleanup(&rxe->mc_elem_pool);
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
@@ -128,8 +127,6 @@ static void rxe_init_pools(struct rxe_dev *rxe)
 	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW, rxe->attr.max_mw);
 	rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
 			    rxe->attr.max_mcast_grp);
-	rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
-			    rxe->attr.max_total_mcast_qp_attach);
 }
 
 /* initialize rxe device state */
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index e110c4d3fbf4..b935634f86cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -63,14 +63,15 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto out;
 	}
 
-	elem = rxe_alloc(&rxe->mc_elem_pool);
+	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
 	if (!elem) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	/* each qp holds a ref on the grp */
+	/* each elem holds a ref on the grp and the qp */
 	rxe_add_ref(grp);
+	rxe_add_ref(qp);
 
 	grp->num_qp++;
 	elem->qp = qp;
@@ -91,6 +92,7 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 {
 	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem, *tmp;
+	int ret = -EINVAL;
 
 	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
@@ -107,18 +109,21 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 			spin_unlock_bh(&grp->mcg_lock);
 			spin_unlock_bh(&qp->grp_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
-			return 0;
+			kfree(elem);
+			rxe_drop_ref(qp);	/* ref held by elem */
+			rxe_drop_ref(grp);	/* ref held by elem */
+			ret = 0;
+			goto out_drop_ref;
 		}
 	}
 
 	spin_unlock_bh(&grp->mcg_lock);
 	spin_unlock_bh(&qp->grp_lock);
+
+out_drop_ref:
 	rxe_drop_ref(grp);			/* ref from get_key */
 err1:
-	return -EINVAL;
+	return ret;
 }
 
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
@@ -142,8 +147,9 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 		list_del(&elem->qp_list);
 		grp->num_qp--;
 		spin_unlock_bh(&grp->mcg_lock);
+		rxe_drop_ref(qp);
 		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
+		kfree(elem);
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index dcfbc2b932af..0f785d14f646 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -89,12 +89,6 @@ static const struct rxe_type_info {
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
 		.key_size	= sizeof(union ib_gid),
 	},
-	[RXE_TYPE_MC_ELEM] = {
-		.name		= "rxe-mc_elem",
-		.size		= sizeof(struct rxe_mc_elem),
-		.elem_offset	= offsetof(struct rxe_mc_elem, elem),
-		.flags		= RXE_POOL_ALLOC,
-	},
 };
 
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index be3b962d1c78..ccb923b10276 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -23,7 +23,6 @@ enum rxe_elem_type {
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
 	RXE_TYPE_MC_GRP,
-	RXE_TYPE_MC_ELEM,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 022abba4fb6b..9f39b097a976 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -364,7 +364,6 @@ struct rxe_mc_grp {
 };
 
 struct rxe_mc_elem {
-	struct rxe_pool_elem	elem;
 	struct list_head	qp_list;
 	struct list_head	grp_list;
 	struct rxe_qp		*qp;
@@ -402,7 +401,6 @@ struct rxe_dev {
 	struct rxe_pool		mr_pool;
 	struct rxe_pool		mw_pool;
 	struct rxe_pool		mc_grp_pool;
-	struct rxe_pool		mc_elem_pool;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

