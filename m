Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4A49ED9A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbiA0ViX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbiA0ViX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:23 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED138C06173B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:22 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x193so8661974oix.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTTT87wMC4v2jPPK4ulEKzEXnIs47mB9ujkCoKuWINg=;
        b=mudim/pERMGohkODQTe71eF9V0whlWq1K4ng2LvbHUYf+Z4eS7/loqk9PAJTOuGTg0
         netxdPdBhDDGReWFxEwh+uzQaCBTSvfw8mNJJFJrfJCaWAMbRolMEChnT8qbiK9atXIx
         fTrF+dgPnnY1AyxWhmaKCLyZdTxTqFAWdkvcuirS0WAAkQ6TgnS5rIaKXuI5vRDrWGcn
         gjunB8YVF1km+g/oh1J0MzqBiD6s+2cH5PHzw/XJ10e8MqeRGaXIkz/BFPjKugP0nZ7g
         jz9ux3rOtlTRffaCppbdCBr+buaPojcVZ0X8wtzl7AUXHX5FpJp01G0AGCghGcZpgbjo
         MmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTTT87wMC4v2jPPK4ulEKzEXnIs47mB9ujkCoKuWINg=;
        b=HbI1uzSoCIUumjEAGPD1VUtGCceAgGVgcuejpmWHVutocbxI5pFj7Y8vpsIXfoK968
         cewZ1Do9UMTCfVlFcXaNCRHFncIbcAL7WEXa/dXW0N69/CXzZeRqIJMzuDRd9TfV4NaZ
         6N/jaYj0hpa1j4hBLqx3hUQ6r23lbZoRoFBi88eXinDBeVw5+G/1J6JUtaK0xBAYypkS
         GMTEgS/57bGKQKpo80wkJg9bsKvkqzxGKkiAt7NZ6ZfKV+xjKUl8Ydr8EpC1Lo93H4tW
         3wBVLh/PyThxV+RlWpI6wCnJI34RCRJ71EJZ7UqO5GfLjNWyLVPJUzviO/vA1iajI8BD
         5c4A==
X-Gm-Message-State: AOAM531UujQqZRHhNJvvNyDOuKXFG7usgRj04xNA+AuI1UZHcFAb2tIH
        JZlgBvQ/EHu5JiJKzeU89l0=
X-Google-Smtp-Source: ABdhPJxmXDom2yQaGVZWtkX5XqK/qJzkpwoGS9GwKOV6/Q+Oh2JqtnA/Vr2vg0xKYIjol9iTZXBFeQ==
X-Received: by 2002:a05:6808:1645:: with SMTP id az5mr6708328oib.313.1643319502374;
        Thu, 27 Jan 2022 13:38:22 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:21 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 24/26] RDMA/rxe: Add wait_for_completion to pool objects
Date:   Thu, 27 Jan 2022 15:37:53 -0600
Message-Id: <20220127213755.31697-25-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reference counting for object deletion can cause an object to
wait for something else to happen before an object gets deleted.
The destroy verbs can then return to rdma-core with the object still
holding references. Adding wait_for_completion in this path
prevents this.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    |  3 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 79 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 ++++
 5 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 35628b8a00b4..6d1ce05bcf65 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -692,6 +692,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_ref(mr);
+	rxe_wait(mr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 7df36c40eec2..dd3d02db3d03 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -60,8 +60,9 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
 
-	rxe_drop_ref(mw);
 	rxe_drop_ref(pd);
+	rxe_drop_ref(mw);
+	rxe_wait(mw);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 18cdf5e0ad4e..5402dae01554 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -7,6 +7,7 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_TIMEOUT	(200)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -154,6 +155,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic_bh(&pool->xa, &elem->index, elem, pool->limit,
 			&pool->next, GFP_KERNEL);
@@ -185,6 +187,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic_bh(&pool->xa, &elem->index, elem, pool->limit,
 			&pool->next, GFP_KERNEL);
@@ -212,31 +215,22 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-static void rxe_obj_free_rcu(struct rcu_head *rcu)
-{
-	struct rxe_pool_elem *elem = container_of(rcu, typeof(*elem), rcu);
-
-	kfree(elem->obj);
-}
-
 static void __rxe_elem_release_rcu(struct kref *kref)
 	__releases(&pool->xa.xa_lock)
 {
-	struct rxe_pool_elem *elem = container_of(kref,
-					struct rxe_pool_elem, ref_cnt);
+	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 	struct rxe_pool *pool = elem->pool;
 
 	__xa_erase(&pool->xa, elem->index);
 
-	spin_unlock(&pool->xa.xa_lock);
+	spin_unlock_bh(&pool->xa.xa_lock);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	atomic_dec(&pool->num_elem);
 
-	if (pool->flags & RXE_POOL_ALLOC)
-		call_rcu(&elem->rcu, rxe_obj_free_rcu);
+	complete(&elem->complete);
 }
 
 int __rxe_add_ref(struct rxe_pool_elem *elem)
@@ -244,8 +238,67 @@ int __rxe_add_ref(struct rxe_pool_elem *elem)
 	return kref_get_unless_zero(&elem->ref_cnt);
 }
 
+static bool refcount_dec_and_lock_bh(refcount_t *r, spinlock_t *lock)
+	__acquires(lock) __releases(lock)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	spin_lock_bh(lock);
+	if (!refcount_dec_and_test(r)) {
+		spin_unlock_bh(lock);
+		return false;
+	}
+
+	return true;
+}
+
+static int kref_put_lock_bh(struct kref *kref,
+				void (*release)(struct kref *kref),
+				spinlock_t *lock)
+{
+	if (refcount_dec_and_lock_bh(&kref->refcount, lock)) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
+
 int __rxe_drop_ref(struct rxe_pool_elem *elem)
 {
-	return kref_put_lock(&elem->ref_cnt, __rxe_elem_release_rcu,
+	return kref_put_lock_bh(&elem->ref_cnt, __rxe_elem_release_rcu,
 			&elem->pool->xa.xa_lock);
 }
+
+static void rxe_obj_free_rcu(struct rcu_head *rcu)
+{
+	struct rxe_pool_elem *elem = container_of(rcu, typeof(*elem), rcu);
+
+	kfree(elem->obj);
+}
+
+int __rxe_wait(struct rxe_pool_elem *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	static int timeout = RXE_POOL_TIMEOUT;
+	static int timeout_failures;
+	int ret;
+
+	if (timeout) {
+		ret = wait_for_completion_timeout(&elem->complete, timeout);
+		if (!ret) {
+			if (timeout_failures++ == 5) {
+				timeout = 0;
+				pr_warn("Exceeded max completion timeouts. Disabling wait_for_completion\n");
+			} else {
+				pr_warn_ratelimited("Timed out waiting for %s#%d to complete\n",
+					pool->name + 4, elem->index);
+			}
+		}
+	}
+
+	if (pool->flags & RXE_POOL_ALLOC)
+		call_rcu(&elem->rcu, rxe_obj_free_rcu);
+
+	return ret;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 40026d746563..f085750c4c5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -29,6 +29,7 @@ struct rxe_pool_elem {
 	struct kref		ref_cnt;
 	struct list_head	list;
 	struct rcu_head		rcu;
+	struct completion	complete;
 	u32			index;
 };
 
@@ -67,4 +68,7 @@ int __rxe_add_ref(struct rxe_pool_elem *elem);
 int __rxe_drop_ref(struct rxe_pool_elem *elem);
 #define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
+int __rxe_wait(struct rxe_pool_elem *elem);
+#define rxe_wait(obj) __rxe_wait(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 3ca374f1cf9b..f2c1037696c5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -116,6 +116,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
 	rxe_drop_ref(uc);
+	rxe_wait(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -150,6 +151,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_pd *pd = to_rpd(ibpd);
 
 	rxe_drop_ref(pd);
+	rxe_wait(pd);
 	return 0;
 }
 
@@ -189,6 +191,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 					 sizeof(uresp->ah_num));
 		if (err) {
 			rxe_drop_ref(ah);
+			rxe_wait(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -229,6 +232,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_drop_ref(ah);
+	rxe_wait(ah);
 	return 0;
 }
 
@@ -315,6 +319,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 err2:
 	rxe_drop_ref(pd);
 	rxe_drop_ref(srq);
+	rxe_wait(srq);
 err1:
 	return err;
 }
@@ -373,6 +378,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	rxe_drop_ref(srq->pd);
 	rxe_drop_ref(srq);
+	rxe_wait(srq);
 	return 0;
 }
 
@@ -442,6 +448,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 
 qp_init:
 	rxe_drop_ref(qp);
+	rxe_wait(qp);
 	return err;
 }
 
@@ -496,6 +503,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	rxe_qp_destroy(qp);
 	rxe_drop_ref(qp);
+	rxe_wait(qp);
 	return 0;
 }
 
@@ -807,6 +815,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	rxe_cq_disable(cq);
 
 	rxe_drop_ref(cq);
+	rxe_wait(cq);
 	return 0;
 }
 
@@ -932,6 +941,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 err3:
 	rxe_drop_ref(pd);
 	rxe_drop_ref(mr);
+	rxe_wait(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -964,6 +974,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 err2:
 	rxe_drop_ref(pd);
 	rxe_drop_ref(mr);
+	rxe_wait(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.32.0

