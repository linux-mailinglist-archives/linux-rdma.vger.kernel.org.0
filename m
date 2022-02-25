Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8784C4F2D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiBYT7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiBYT7G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:06 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B6E11D7A6
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:33 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so7816657ooi.7
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+aEYZ8tR+k/FZB6FK0BaYMvs9vQRT0yfhI7a+ZnKvlE=;
        b=nMHEQLpmLJmmXAx6dN83Akxv9HCnS4HZHm6Nyo0XwRon5MTHNd9CNkLdqYbCyi/7yO
         nrnWruITz7SP+V8ref/H6k/LRlT2DnrqBhBitiF951MtpbRe5uPp7eCaOhvvsWKHYqgD
         cVdFubrz3sL4WlWYyw9lhJ4voGYIDZbwe11yKS6A8/7sW8xQXhq9AnohQQrBCwdjgs1x
         spbEJFdbBA6ZatqP3HoO7+Hf87p3wik+57gskjBzpvpZ+/2Z5tcEWp1nOREBNK3Lghb2
         FlAQ9slGWHNtSL3w7cuzBru4Ccoz0MnP2xn8IZfbFU2gchpFqqdluMSrEKZAbOd/ltdn
         W/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aEYZ8tR+k/FZB6FK0BaYMvs9vQRT0yfhI7a+ZnKvlE=;
        b=x6cPSrQUMLNJm8/uQ3iMvGyDadCoOPowLQ4wSVtdl1Fn+opEp+fxkqocNilqB/L8O7
         hR1OHWsxT26Uuzz1oVJ1BJ+0jvTeaAmX1S3DHMruekLI91whjg1qtwLcvYG7tdOdljCV
         76PxDm/yaOxDwLpw5+GScaAI5tzlAcX7XA+0WKjP91vFsFKqHEn6GyRM7pgSVIaYe2vx
         GUglTAYQtB8LtKmwCXcdG/rhoKsttzRGE3oSpM861ns5l/uJ4ocWbLTEcIBMyxrFWeao
         9FT2QNYo8YPH+aU2u+lWjw10WavWgmtJox1vq6r/HL1EVx+FlGenydWFJBPQ9NZgErVx
         YKkQ==
X-Gm-Message-State: AOAM530qrsgnzke6uK77yxa5gVF487qsT1CNn3r/BMwhHaKssmNqZ/V1
        8/WInWKl/eDlFXERCJBOpSiA36tGcqg=
X-Google-Smtp-Source: ABdhPJwZrvrUbbyTxefxAB92AgS6vi8qQd80jXm1JRtzBNcWtTqAS9qSZm4AjQCAvgZCTUHttkxg8g==
X-Received: by 2002:a4a:9781:0:b0:318:79a4:d0db with SMTP id w1-20020a4a9781000000b0031879a4d0dbmr3467574ooi.3.1645819113143;
        Fri, 25 Feb 2022 11:58:33 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:32 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 06/11] RDMA/rxe: Add wait_for_completion to pool objects
Date:   Fri, 25 Feb 2022 13:57:46 -0600
Message-Id: <20220225195750.37802-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 49 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  6 ++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 23 +++++++------
 5 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 157cfb710a7e..245785def608 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -692,7 +692,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	rxe_disable(mr);
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_ref(mr);
+	rxe_drop_wait(mr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index e4d207f24eba..c45d832d7427 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -63,8 +63,8 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
 
-	rxe_drop_ref(mw);
 	rxe_drop_ref(pd);
+	rxe_drop_wait(mw);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 19d8fb77b166..1d1e10290991 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_TIMEOUT	(200)
+#define RXE_MAX_POOL_TIMEOUTS	(3)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -123,7 +125,7 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	} while (elem);
 
 	if (elem_count || obj_count)
-		pr_warn("Freed %d indices & %d objects from pool %s\n",
+		pr_warn("Freed %d indices and %d objects from pool %s\n",
 			elem_count, obj_count, pool->name + 4);
 }
 
@@ -151,6 +153,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic_bh(&pool->xa, &elem->index, elem, pool->limit,
 			&pool->next, GFP_KERNEL);
@@ -182,6 +185,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic_bh(&pool->xa, &elem->index, elem, pool->limit,
 			&pool->next, GFP_KERNEL);
@@ -218,20 +222,12 @@ static void rxe_elem_release(struct kref *kref, unsigned long flags)
 	struct rxe_pool_elem *elem =
 		container_of(kref, struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	void *obj;
 
 	__xa_erase(&pool->xa, elem->index);
 
 	spin_unlock_irqrestore(&pool->xa.xa_lock, flags);
-	if (pool->cleanup)
-		pool->cleanup(elem);
-
-	if (pool->flags & RXE_POOL_ALLOC) {
-		obj = elem->obj;
-		kfree(obj);
-	}
 
-	atomic_dec(&pool->num_elem);
+	complete(&elem->complete);
 }
 
 int __rxe_add_ref(struct rxe_pool_elem *elem)
@@ -262,3 +258,36 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem)
 	return kref_put_lock_irqsave(&elem->ref_cnt, rxe_elem_release,
 			&pool->xa.xa_lock);
 }
+
+
+int __rxe_drop_wait(struct rxe_pool_elem *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	static int timeout = RXE_POOL_TIMEOUT;
+	int ret;
+
+	__rxe_drop_ref(elem);
+
+	if (timeout) {
+		ret = wait_for_completion_timeout(&elem->complete, timeout);
+		if (!ret) {
+			pr_warn("Timed out waiting for %s#%d\n",
+				pool->name + 4, elem->index);
+			if (++pool->timeouts == RXE_MAX_POOL_TIMEOUTS) {
+				timeout = 0;
+				pr_warn("Reached max %s timeouts.\n",
+					pool->name + 4);
+			}
+		}
+	}
+
+	if (pool->cleanup)
+		pool->cleanup(elem);
+
+	if (pool->flags & RXE_POOL_ALLOC)
+		kfree(elem->obj);
+
+	atomic_dec(&pool->num_elem);
+
+	return ret;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b963c300d636..f98d2950bb9f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -28,6 +28,7 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
+	struct completion	complete;
 	u32			index;
 	bool			enabled;
 };
@@ -38,6 +39,7 @@ struct rxe_pool {
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
+	unsigned int		timeouts;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
@@ -86,4 +88,8 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem);
 
 #define rxe_disable(obj) ((obj)->elem.enabled = false)
 
+int __rxe_drop_wait(struct rxe_pool_elem *elem);
+
+#define rxe_drop_wait(obj) __rxe_drop_wait(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 077be3eb9763..ced6972396c4 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -115,7 +115,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_drop_ref(uc);
+	rxe_drop_wait(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -149,7 +149,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_drop_ref(pd);
+	rxe_drop_wait(pd);
 
 	return 0;
 }
@@ -189,7 +189,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_drop_ref(ah);
+			rxe_drop_wait(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -233,8 +233,8 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_disable(ah);
+	rxe_drop_wait(ah);
 
-	rxe_drop_ref(ah);
 	return 0;
 }
 
@@ -322,7 +322,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_ref(srq);
+	rxe_drop_wait(srq);
 err1:
 	return err;
 }
@@ -382,7 +382,8 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 		rxe_queue_cleanup(srq->rq.queue);
 
 	rxe_drop_ref(srq->pd);
-	rxe_drop_ref(srq);
+	rxe_drop_wait(srq);
+
 	return 0;
 }
 
@@ -454,7 +455,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_drop_ref(qp);
+	rxe_drop_wait(qp);
 	return err;
 }
 
@@ -509,7 +510,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	rxe_disable(qp);
 	rxe_qp_destroy(qp);
-	rxe_drop_ref(qp);
+	rxe_drop_wait(qp);
 	return 0;
 }
 
@@ -822,7 +823,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 
 	rxe_cq_disable(cq);
-	rxe_drop_ref(cq);
+	rxe_drop_wait(cq);
 
 	return 0;
 }
@@ -954,7 +955,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
+	rxe_drop_wait(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -988,7 +989,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
+	rxe_drop_wait(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.32.0

