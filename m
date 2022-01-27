Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25649ED87
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbiA0ViR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbiA0ViQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:16 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88DC061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:16 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s127so8599048oig.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVK7u2P52N1G3b9h/Df3g4Qwbi3NOjtbe74Ha1KGhjk=;
        b=c982XjkxXuLVbFOws/IpjneWloOvHcrUEw+h+NxNK52jgsMQ2w/rrjkWCPRSM8kZ7/
         5EskT+CURzbsR1diW5yZfUla1XIc8bFTIzAAkBw+a2bCaca7SuvOUb7JWwlOnXcujb0W
         7q6LXoGEfqsY87CLyq8RTuyn/+v2HW8PUBk48nKctsvxl8s2ZvsTI/UZi+RFZ4Ov+7mC
         mewyDVl7aBPhRh1rh/UwHPCIda2D4csNQtRQSm62w8Fggj3FGo2SHsACftIdrIF6J1Yz
         LGVFWGMSIAL8SNDLlhKewdC1DN9c0ifSaHQxCSdwkWumw2mlQ+qD6sY+pJxu3Fy8RdsB
         vmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVK7u2P52N1G3b9h/Df3g4Qwbi3NOjtbe74Ha1KGhjk=;
        b=k+MXmrDQYCbVm79gnPztvP28sS2qodCh7sLq8r7y83J99GFbZaItwcpSG/EUv64sEZ
         lrrZR5SLIhXnwvsZOMC/sihQfqz3kf/OEC9OkU4Z2GHntRmdLhD5yMs+Rj5r45IYXBny
         kD8Tk3vL91d9CWWPoXgAbwQeZ6lB5z7tF9JzedefIgcscvSjtQfsaTdeN8d7NoopwPoA
         QA0Jv9lP1Nnuh2sy0S6vnUpYFqexUr/n/HJ3XgnanILlBzAL5/ZSUX5NdqnOnwqLPYxL
         GK5eS/EnZBvfkaCTk/CRx8AFl5wi5XVs1AziETAigvozqVpiFdHm4BarWgf5IxKOVq23
         3XWQ==
X-Gm-Message-State: AOAM5324UVVx6O0pkAvCozNLhHR+K6Lq8+9MSikj3BSXQQ9XWM1SJIKN
        blUnyqT8If3SXH/BEce/twM=
X-Google-Smtp-Source: ABdhPJzkWm/ir2kSUPJFpdUmH6R5fgFJECzwrpYgV28ATzdrsNnW9EPvcxbNXbNoPZCgJcxUf8Vlig==
X-Received: by 2002:a05:6808:2324:: with SMTP id bn36mr2374836oib.212.1643319495428;
        Thu, 27 Jan 2022 13:38:15 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:15 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 14/26] RDMA/rxe: Remove mcg from rxe pools
Date:   Thu, 27 Jan 2022 15:37:43 -0600
Message-Id: <20220127213755.31697-15-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 76 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  6 ---
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 -
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 7 files changed, 54 insertions(+), 45 deletions(-)

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
index d9faf3a1ee61..409efeecd581 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -43,7 +43,7 @@ void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
-void rxe_mc_cleanup(struct rxe_pool_elem *arg);
+void rxe_cleanup_mcg(struct kref *kref);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 4c3eb9c723b4..d01456052879 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -98,7 +98,7 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	}
 
 	if (node) {
-		rxe_add_ref(mcg);
+		kref_get(&mcg->ref_cnt);
 		return mcg;
 	}
 
@@ -139,7 +139,6 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 {
 	struct rxe_mcg *mcg, *tmp;
 	int ret;
-	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
 	if (rxe->attr.max_mcast_grp == 0)
 		return -EINVAL;
@@ -152,7 +151,7 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	}
 
 	/* speculative alloc of mcg without using GFP_ATOMIC */
-	mcg = rxe_alloc(pool);
+	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
 	if (!mcg)
 		return -ENOMEM;
 
@@ -161,19 +160,22 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	tmp = __rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
 		spin_unlock_bh(&rxe->mcg_lock);
-		rxe_drop_ref(mcg);
+		kfree(mcg);
 		mcg = tmp;
 		goto out;
 	}
 
-	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp)
+	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
+		ret = -ENOMEM;
 		goto err_dec;
+	}
 
 	ret = rxe_mcast_add(rxe, mgid);
 	if (ret)
-		goto err_out;
+		goto err_dec;
 
-	rxe_add_ref(mcg);
+	kref_init(&mcg->ref_cnt);
+	kref_get(&mcg->ref_cnt);
 	mcg->rxe = rxe;
 	memcpy(&mcg->mgid, mgid, sizeof(*mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
@@ -186,13 +188,47 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 
 err_dec:
 	atomic_dec(&rxe->mcg_num);
-	ret = -ENOMEM;
-err_out:
 	spin_unlock_bh(&rxe->mcg_lock);
-	rxe_drop_ref(mcg);
+	kfree(mcg);
 	return ret;
 }
 
+/**
+ * __rxe_cleanup_mcg - cleanup mcg object holding lock
+ * @kref: kref embedded in mcg object
+ *
+ * Context: caller has put all references to mcg
+ * caller should hold rxe->mcg_lock
+ */
+static void __rxe_cleanup_mcg(struct kref *kref)
+{
+	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
+	struct rxe_dev *rxe = mcg->rxe;
+
+	__rxe_remove_mcg(mcg);
+	rxe_mcast_delete(rxe, &mcg->mgid);
+	atomic_dec(&rxe->mcg_num);
+
+	kfree(mcg);
+}
+
+/**
+ * rxe_cleanup_mcg - cleanup mcg object
+ * @kref: kref embedded in mcg object
+ *
+ * Context: caller has put all references to mcg and no one should be
+ * able to get another one
+ */
+void rxe_cleanup_mcg(struct kref *kref)
+{
+	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
+	struct rxe_dev *rxe = mcg->rxe;
+
+	spin_lock_bh(&rxe->mcg_lock);
+	__rxe_cleanup_mcg(kref);
+	spin_unlock_bh(&rxe->mcg_lock);
+}
+
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mcg *mcg)
 {
@@ -259,34 +295,22 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			list_del(&mca->qp_list);
 			n = atomic_dec_return(&mcg->qp_num);
 			if (n <= 0)
-				rxe_drop_ref(mcg);
+				kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
 			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&rxe->mcg_lock);
-			rxe_drop_ref(mcg);
+			kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
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
 
-void rxe_mc_cleanup(struct rxe_pool_elem *elem)
-{
-	struct rxe_mcg *mcg = container_of(elem, typeof(*mcg), elem);
-	struct rxe_dev *rxe = mcg->rxe;
-
-	spin_lock_bh(&rxe->mcg_lock);
-	__rxe_remove_mcg(mcg);
-	spin_unlock_bh(&rxe->mcg_lock);
-
-	rxe_mcast_delete(rxe, &mcg->mgid);
-}
-
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	int err;
@@ -301,7 +325,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
 
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 	return err;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 673b29f1f12c..b6fe7c93aaab 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -79,12 +79,6 @@ static const struct rxe_type_info {
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
-	[RXE_TYPE_MC_GRP] = {
-		.name		= "rxe-mc_grp",
-		.size		= sizeof(struct rxe_mcg),
-		.elem_offset	= offsetof(struct rxe_mcg, elem),
-		.cleanup	= rxe_mc_cleanup,
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
index f1ca83e09160..357a6cea1484 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -274,6 +274,8 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
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
index ea2d9ff29744..dea24ebdb3d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -352,8 +352,8 @@ struct rxe_mw {
 };
 
 struct rxe_mcg {
-	struct rxe_pool_elem	elem;
 	struct rb_node		node;
+	struct kref		ref_cnt;
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	atomic_t		qp_num;
-- 
2.32.0

