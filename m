Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E38466D9C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357881AbhLBXZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356945AbhLBXY6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:58 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE21C06175E
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:35 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so442551oog.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=leZbB0bzpOOLT5UrRva0lXXhk8ytVs2k2Tobc+6Axnk=;
        b=J2OZFHpWfOwwNM+MDcHbRDPPDB3fop1V/bvt/GSO6jLJUUGsQeJHKySMQub/1tkel/
         5NI/Oc43+4F7EP5/8w8bRMA9RXKCfSwYcTjRpA/y7o/+MMI4uoduHp0I5LGr42wVx2KT
         Yi1155YRyE+RD78Y0TtmWKKkButpd71BZn6djfQQTqzZN4XtBfxXQD6mmOPwnt3Z52TO
         6mIt9tJ4VFBqTjDVRF0tvzu/0ARgGYVx4UfTVYkfCV8kAbG3vXrbOlGcBCjiNOuFkcPP
         xgZIMk+wyvu8EdmXpHLP1AD1FO7p4rdX5xYNKDmUhJeFsWvlnpYnId5fZLvWYUQqkKcI
         u5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=leZbB0bzpOOLT5UrRva0lXXhk8ytVs2k2Tobc+6Axnk=;
        b=LpyAMJqNWZNSlVdbWvyEEXqyOUWYWgtMHnWI0FnnlJhvroxA411nE51J2DUodjfc9v
         zBeM1TD5bOGFdXHhj5J0vY6mCYX4bI+Enxe0pIk3lyjytqtoutas3rKVHlpVST5RjyxQ
         KdvfQuEOHp+TZ4PPakl98C7dF6RBlFc5CP5YB/+vge/xn5Ns1JLn2jli3iearpgBHtnL
         WBFht5WVrAJxE6Lu/UiPkun3BATBBYic1suQEKdPsofKwEjEGLLy3/EycgV623zqiHEN
         Cv3GlPkzRIHB6sbNX2E0NZSW60/wj3jZTAZrxGhd7bM5qLiqkvKoU06fOE2ZFrGmgo86
         x6gQ==
X-Gm-Message-State: AOAM533gCQtXBEdLl269vXkFXZ5ICmcKoIN8MwRm3ZRsYFYf5pENR9Ht
        fd94pFS0IqhBwjPsHVhT4SA=
X-Google-Smtp-Source: ABdhPJyxrC2SaQEgMR46QCCAzFppN4ZJQyy23dpcTV6wxLij4R+69tsKI1gSPHM2jO+7/K+2yx5jfg==
X-Received: by 2002:a4a:9568:: with SMTP id n37mr10198558ooi.73.1638487294850;
        Thu, 02 Dec 2021 15:21:34 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:34 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 7/8] RDMA/rxe: Replace rxe_alloc by kzalloc for rxe_mc_elem
Date:   Thu,  2 Dec 2021 17:20:34 -0600
Message-Id: <20211202232035.62299-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202232035.62299-1-rpearsonhpe@gmail.com>
References: <20211202232035.62299-1-rpearsonhpe@gmail.com>
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
index c00eef344f98..2c241ffc0c8b 100644
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

