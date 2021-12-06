Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD31A46A986
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 22:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbhLFVR4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 16:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350325AbhLFVRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 16:17:39 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76693C061746
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:14:10 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t19so23882673oij.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yWDAYHk7XwtaPh1Uib0FM+NkuPZMXc2Lq6U55hxWuw=;
        b=Blx+b7DsApgdRpO1qa5DeW+FukeWl2B45j4x3P1xX+lfFHn4u0Eaj/JTIyPNWjeDRU
         urGJuPIxf0nP/GnvhoeuRKsP35pBqNA1U5OfxLXvDzmzuMCWL6HuwNMdzrybPmXQA5Qh
         4yBzMtYfOLYvwgaFOpl74HvcXRwcgADRzJ/0qCe01OrczPc/C5hneSNtUkG3ntfVHZx/
         apXuETxxHkHJ0q5BieJobWn+XVxCn3m/zGW+s3RZrenxtKvFt5MDnH5aBv0y7jN/sKdV
         YdEtDa/lOox+CcRNPmX8tprK2519dh6E1HcNSJ7V+BeX2VKF1nai4Yx2nh01dxdddwqm
         ipcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yWDAYHk7XwtaPh1Uib0FM+NkuPZMXc2Lq6U55hxWuw=;
        b=BaM7L8UwOwoIxN/TFUrZpWVdYHkq+ZShbqk5mNtoaINyPnBhLPwGQBAQpNOQ5YQ2S/
         EFaXAF1jsxDFS1tD62rRll87SgyPm0YENzC3cj7dIfqbc8Ei/mvOBFJyL1irrUC1agX9
         yF2S4Kv1TQCau0rG+H/u6dA8TQ5Xayrg4iuFSElHLxPgzQifBuCXwHbN4RoBWDQITdjE
         WOctKcqgUpOetz37myVEVPBhyzcMEBiBaNx/F2DioQIt6sca+xD8bePvXNVrZVlOxtQe
         KOdNvyWHgDnC0VCNXT5lXvwJyNFaXUvESW0xSr6exCqm346Jlp2CoTMyKb5hitReNlOX
         s2vw==
X-Gm-Message-State: AOAM5312W2fKTUv64P83QWISZ0txufFqDYw5rlLdd0FnaiShHy3WHt3X
        Y325g7VTgfYi4UPMlynw/nSd/eb/7TU=
X-Google-Smtp-Source: ABdhPJzx2p5WKNioeNlFnCFsc1A4fEmzKUfq5RFWqpztbldrL7trlHRnArtRokuJW4pvrBNG0iuzuA==
X-Received: by 2002:a05:6808:1485:: with SMTP id e5mr1199808oiw.156.1638825249867;
        Mon, 06 Dec 2021 13:14:09 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-07ad-dbeb-c616-747c.res6.spectrum.com. [2603:8081:140c:1a00:7ad:dbeb:c616:747c])
        by smtp.googlemail.com with ESMTPSA id y28sm2819111oix.57.2021.12.06.13.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:14:09 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 7/8] RDMA/rxe: Replace rxe_alloc by kzalloc for rxe_mc_elem
Date:   Mon,  6 Dec 2021 15:12:42 -0600
Message-Id: <20211206211242.15528-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206211242.15528-1-rpearsonhpe@gmail.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
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
index ab48b4dec9cf..ff03d1f9d92e 100644
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
index 62e9e439c99c..db2caff6f408 100644
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

