Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB164CCA91
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiCDAJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCDAJg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:36 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0798A527CA
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:50 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so7628102oot.11
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ut0ka3TO8okN+zyJNCmSW3zwRoLh6o5Ud/1r0Pmr6/o=;
        b=eiAML+NjCavJ9utbcttWLgMkSnyG9BmNCM9IbSu1ost1TMZc+hzQ7EV1iVN/znUxhI
         rYduwrbkG3KakE2+D1O0p/zFr3bYRwjd/OT8BjtCCFfmRo32aE4njSAruWYnYx1bdj/8
         ffFtTjAN1XcUcd734uO6xWCwSisdyjcoTBSDK9pR6al58Dqnk0yihhOi6FejG4ZNYV0R
         Re3T7T+5H1maFtinIMQW002E8W/v5PrOOREz3nvgefkLVKVaNSi9e2sUDsSqsZzPyfoc
         V/Dp1zsTv75Gbcvm5PIod9VlZGxtH8ooxs4I2Czd6X5VXYBdcyB6ob3q1kXjknC3ahbW
         imTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ut0ka3TO8okN+zyJNCmSW3zwRoLh6o5Ud/1r0Pmr6/o=;
        b=qbOW898mHJXjudkwIE2gu8ie/CNlLqgyZqnoJWESvP4+3d+pOb5QWcFq64NQc5CYvw
         rVoS0qhwtAIm2cXY4RV8Qe449ksrPJ7+pf8loHkRvqF4QGCR+zdePMtbjFx9CXeeNd+b
         6D+QMoOF2tUjS+OG2hflnNljo10KSUQYAxoJDuQe7IVBADCdU0UCwXPfrB0dyHhSqYhv
         414D8MD55Q1uB25M20JQrT0B4wWXL4iKpD2PRCPJRMCIhPFh6kBXUWNH0Q+zis5PkgI6
         wd1sJfD+y1sNjV1YmZlO95X5TTAORvVvREklJS7AhTogdCOIVWQ6sBQFAyU3Kn5i2NfG
         dOMw==
X-Gm-Message-State: AOAM532N+YxkE/YZW2J0mRvbT0nvov6Pkf7GyWaw/DYOAjmSxItgdKA3
        BZa3lgNYgP9pxstBdrryFAw=
X-Google-Smtp-Source: ABdhPJxZmJYC9mkAY71KWEch6hERH6W6iw6HJKWQCoSDnQ3CTfNAW070m1lMoJZZCIH0UBnLI3X+6w==
X-Received: by 2002:a05:6870:14cf:b0:d9:a9ce:92a9 with SMTP id l15-20020a05687014cf00b000d9a9ce92a9mr6105728oab.64.1646352529362;
        Thu, 03 Mar 2022 16:08:49 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 11/13] RDMA/rxe: Add wait_for_completion to pool objects
Date:   Thu,  3 Mar 2022 18:08:07 -0600
Message-Id: <20220304000808.225811-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_pool.c  | 29 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.h  |  5 +++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 22 ++++++++++----------
 5 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index e4ad2cc12584..83e370ae9df6 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -693,7 +693,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_put(mr_pd(mr));
-	rxe_put(mr);
+	rxe_wait(mr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 4edbed1410e9..157b3f968522 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -64,8 +64,8 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
 
-	rxe_put(mw);
 	rxe_put(pd);
+	rxe_wait(mw);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index c0b70687a83e..4fb6c7dd32ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_TIMEOUT	(200)
+#define RXE_POOL_MAX_TIMEOUTS	(3)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -158,6 +160,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
@@ -186,6 +189,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
@@ -228,6 +232,29 @@ static void rxe_elem_release(struct kref *kref)
 	__xa_erase(&pool->xa, elem->index);
 	xa_unlock_irqrestore(xa, flags);
 
+	complete(&elem->complete);
+}
+
+int __rxe_wait(struct rxe_pool_elem *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	static int timeout = RXE_POOL_TIMEOUT;
+	int ret, err = 0;
+
+	__rxe_put(elem);
+
+	if (timeout) {
+		ret = wait_for_completion_timeout(&elem->complete, timeout);
+		if (!ret) {
+			pr_warn("Timed out waiting for %s#%d to complete\n",
+				pool->name, elem->index);
+			if (++pool->timeouts >= RXE_POOL_MAX_TIMEOUTS)
+				timeout = 0;
+
+			err = -EINVAL;
+		}
+	}
+
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
@@ -235,6 +262,8 @@ static void rxe_elem_release(struct kref *kref)
 		kfree(elem->obj);
 
 	atomic_dec(&pool->num_elem);
+
+	return err;
 }
 
 int __rxe_get(struct rxe_pool_elem *elem)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index c48d8f6f95f3..1863fa165450 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -28,6 +28,7 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
+	struct completion	complete;
 	u32			index;
 };
 
@@ -37,6 +38,7 @@ struct rxe_pool {
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
+	unsigned int		timeouts;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
@@ -77,6 +79,9 @@ int __rxe_put(struct rxe_pool_elem *elem);
 
 #define rxe_put(obj) __rxe_put(&(obj)->elem)
 
+int __rxe_wait(struct rxe_pool_elem *elem);
+#define rxe_wait(obj) __rxe_wait(&(obj)->elem)
+
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
 int __rxe_show(struct rxe_pool_elem *elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e010e8860492..0529ad8e819b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -115,7 +115,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_put(uc);
+	rxe_wait(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -149,7 +149,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_put(pd);
+	rxe_wait(pd);
 	return 0;
 }
 
@@ -188,7 +188,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_put(ah);
+			rxe_wait(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -231,7 +231,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_hide(ah);
-	rxe_put(ah);
+	rxe_wait(ah);
 	return 0;
 }
 
@@ -318,7 +318,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 err2:
 	rxe_put(pd);
-	rxe_put(srq);
+	rxe_wait(srq);
 err1:
 	return err;
 }
@@ -377,7 +377,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 		rxe_queue_cleanup(srq->rq.queue);
 
 	rxe_put(srq->pd);
-	rxe_put(srq);
+	rxe_wait(srq);
 	return 0;
 }
 
@@ -448,7 +448,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_put(qp);
+	rxe_wait(qp);
 	return err;
 }
 
@@ -503,7 +503,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		return ret;
 
 	rxe_qp_destroy(qp);
-	rxe_put(qp);
+	rxe_wait(qp);
 	return 0;
 }
 
@@ -816,7 +816,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	rxe_cq_disable(cq);
 
-	rxe_put(cq);
+	rxe_wait(cq);
 	return 0;
 }
 
@@ -946,7 +946,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_put(pd);
-	rxe_put(mr);
+	rxe_wait(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -980,7 +980,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_put(pd);
-	rxe_put(mr);
+	rxe_wait(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.32.0

