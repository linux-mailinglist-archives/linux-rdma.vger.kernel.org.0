Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007224DD2A1
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiCRB5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B02C243717
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso8681992ooi.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GyaG10dq4dfmLl1n9Jf2FobwfXCkgPf5ysdqlf0L0Q=;
        b=pMU4jz0RimiBXL+VgOXCMFXP8Y/V7dYSQAV82fitrR16PBPgKcrjqGK2yKKsZ3HboR
         W5o/DW/rgMca7JSBxVTRfkXnkr9kj66GOAMZKAs/EKddf0MoBDz9Scm7611/4KazHyKe
         EHrwbzELebyFs0hx35GMsUR9GA2Rzfj/mY5HSS/oRf+icPDbzcyUWibdQT30OItuHYaP
         zW0KjZiXtxermNZjOMdGKWhJ1PWIXOo6JJhTqbRdu/lD0JS7IlUkCzPKH4AKHbBC7act
         j8bN1dN51U/ufFQMkD7IbiEC1pvUXiJdNpz2xiYnKa22J4VYFu5rmssxZuktklSHqQ6T
         AdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GyaG10dq4dfmLl1n9Jf2FobwfXCkgPf5ysdqlf0L0Q=;
        b=kFmSO6oMZt7PnfM35YUyQy2XnNstD3AdRfREdfcpfmax37ydcqYa5fn9dd+rUMBGXo
         RuAhbl9VMbc3FCazzk1nWsJh0O8wiv+MGloi+Bd1dTcTx7zwWDMjYWO36ULv3/YWAi+w
         w4TA3Gjaq8dgKv/qWY/2ppQHc8x7QSuf6qdLDUVEH3VkXKbw0ONpkui5AmEWoE3BqPRR
         rHkMxddCpFhmwfdsIC13mW9ZVN4s8RTXUPW+c36HLPN8KbTGUQvYVFZLmPpWtQBaOmnY
         wBEFFKTDaJjQ5Lv3usxVTRxJaIJXuDSXkoyVLtW/XSTkbKeSNbRVANHF7WvxllLOfobC
         vnoQ==
X-Gm-Message-State: AOAM530cH9lE2pGYtLIWWtcjt0VVS5Y9hzyRWopkIpMYXECwBhoKg/eD
        rvRz2CAr7szCfrxAzbJ3hcbrZSudB5Y=
X-Google-Smtp-Source: ABdhPJyrq5PX0d4fHLaoN4eNr1vb7KkKEKxE5WOqiUGNKNtsd12z8tIjuKj3A68xSkOYde7Sy/zFLg==
X-Received: by 2002:a05:6870:d10b:b0:dd:b6ec:2c90 with SMTP id e11-20020a056870d10b00b000ddb6ec2c90mr2806872oac.261.1647568535642;
        Thu, 17 Mar 2022 18:55:35 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 09/11] RDMA/rxe: Add wait_for_completion to pool objects
Date:   Thu, 17 Mar 2022 20:55:12 -0500
Message-Id: <20220318015514.231621-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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

Add wait for completion to destroy/dealloc verbs to assure that
all references have been dropped before returning to rdma_core.
Implement a new rxe_pool API rxe_cleanup() which drops a reference
to the object and then waits for all other references to be dropped.
After that it cleans up the object and if locally allocated frees
the memory.

Combined with deferring cleanup code to type specific cleanup
routines this allows all pending activity referring to objects to
complete before returning to rdma_core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 29 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.h  |  5 +++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 24 +++++++++++-----------
 5 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 8059f31882ae..94416e76c5d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -688,7 +688,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 
 	rxe_disable_lookup(mr);
-	rxe_put(mr);
+	rxe_cleanup(mr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 2464952a04d4..f439548c8945 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -35,7 +35,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	struct rxe_mw *mw = to_rmw(ibmw);
 
 	rxe_disable_lookup(mw);
-	rxe_put(mw);
+	rxe_cleanup(mw);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87b89d263f80..6f39f74233d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_TIMEOUT	(200)
+#define RXE_POOL_MAX_TIMEOUTS	(3)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -139,6 +141,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	/* allocate index in array but leave pointer as NULL so it
 	 * can't be looked up until rxe_finalize() is called */
@@ -169,6 +172,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
@@ -211,6 +215,29 @@ static void rxe_elem_release(struct kref *kref)
 	__xa_erase(&pool->xa, elem->index);
 	xa_unlock_irqrestore(xa, flags);
 
+	complete(&elem->complete);
+}
+
+int __rxe_cleanup(struct rxe_pool_elem *elem)
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
 
@@ -218,6 +245,8 @@ static void rxe_elem_release(struct kref *kref)
 		kfree(elem->obj);
 
 	atomic_dec(&pool->num_elem);
+
+	return err;
 }
 
 int __rxe_get(struct rxe_pool_elem *elem)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index aa66d0eea13b..3b2c80d5345a 100644
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
@@ -74,6 +76,9 @@ int __rxe_get(struct rxe_pool_elem *elem);
 int __rxe_put(struct rxe_pool_elem *elem);
 #define rxe_put(obj) __rxe_put(&(obj)->elem)
 
+int __rxe_cleanup(struct rxe_pool_elem *elem);
+#define rxe_cleanup(obj) __rxe_cleanup(&(obj)->elem)
+
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
 void __rxe_finalize(struct rxe_pool_elem *elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 6a83b4a630f5..a08d7b0c6221 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -115,7 +115,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_put(uc);
+	rxe_cleanup(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -149,7 +149,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_put(pd);
+	rxe_cleanup(pd);
 	return 0;
 }
 
@@ -188,7 +188,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_put(ah);
+			rxe_cleanup(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -231,7 +231,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_disable_lookup(ah);
-	rxe_put(ah);
+	rxe_cleanup(ah);
 	return 0;
 }
 
@@ -316,7 +316,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err_cleanup:
-	rxe_put(srq);
+	rxe_cleanup(srq);
 err_out:
 	return err;
 }
@@ -371,7 +371,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
-	rxe_put(srq);
+	rxe_cleanup(srq);
 	return 0;
 }
 
@@ -442,7 +442,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_put(qp);
+	rxe_cleanup(qp);
 	return err;
 }
 
@@ -491,12 +491,12 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 	int ret;
 
-	rxe_disable_lookup(qp);
 	ret = rxe_qp_chk_destroy(qp);
 	if (ret)
 		return ret;
 
-	rxe_put(qp);
+	rxe_disable_lookup(qp);
+	rxe_cleanup(qp);
 	return 0;
 }
 
@@ -815,7 +815,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	rxe_cq_disable(cq);
 
-	rxe_put(cq);
+	rxe_cleanup(cq);
 	return 0;
 }
 
@@ -945,7 +945,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_put(pd);
-	rxe_put(mr);
+	rxe_cleanup(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -979,7 +979,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_put(pd);
-	rxe_put(mr);
+	rxe_cleanup(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.32.0

