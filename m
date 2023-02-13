Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C267695448
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 00:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBMXAL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 18:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMXAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 18:00:11 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66ECBDCD
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 15:00:09 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16df32f2ffdso6319163fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoCr9JTtVEW6K/46OOIa543PKuNUerL1zGJwiWuO490=;
        b=T7REzfNhBjAgqmY9SKJlp+MOAdCQ9eEjO0yB7i9ighNMrZwTXTYPuPJ+eWq16by/rB
         3pLjoc0SCC+EVKqBhvTXt/TZz3ESfjwynYrEU3ew3cbWiQObl6ud9yrrx+oej/WdPO4p
         w9q0ieUM2Xklk5kmxBVGZKyFwPEgCFuX6ka4lAziD406x4CgH3026gqxOfVpTTSZQWMn
         u05ZSxrvrcfXBTodRY3Il4Q9yLS9zdwXe7BNDSK29KC9jeq01hVrQJxJW2EI9vuyM/0Y
         39DP03zlxC/70P/bCf7nmLYZWSavn6DzqYkEUgnNjOmFIeXxZICrvDYcNC53b7BhoN1o
         gw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoCr9JTtVEW6K/46OOIa543PKuNUerL1zGJwiWuO490=;
        b=oPc9P4rdOJyXcOQEmzSjYqOWYFoetBzGwWwLsEbm9aDAn/SmeUY5hFVqL0LTpEo8gg
         U+yTsTDGxFpJKUjBOvz5lVZEuhpq2bFcf9LpAUXmn+yUyOPfA3QAml+TTQ0KEUfb61GH
         tv/zV9DYGDy5+QbPi8YuBQxpYo1nR6p/oo9SaEx3NfHjJmzGFw7fdK3m3WGctMMjlJcs
         IooKlAR4kOjCDYTkufagkggU+Sta4oTM7T1Jzn8Odzt1QkvMNbn0rP9u67j42t2YqL4L
         qXtKNSrwv4l0468D6GnIvdPFJviyIxD0HR9Lh/OIRLdRlgQ5BT56mG9Jbou24+Pxv8vc
         rsGw==
X-Gm-Message-State: AO0yUKWqwK5pXoouetYQmSgf2WR6PAexGPXWNGEY5SmZ1QJvbh7RWe45
        YUJlN4T1izTTsIfwGHo2SBE=
X-Google-Smtp-Source: AK7set+HRCvYCyumyPcyyWDXr/BONiDYLBM/0ZkNvEVb1fT4R4Ngt8C3gqHPu/mHtI4XDfn37E25zA==
X-Received: by 2002:a05:6870:6587:b0:16d:ec6a:71e2 with SMTP id fp7-20020a056870658700b0016dec6a71e2mr4552424oab.24.1676329209177;
        Mon, 13 Feb 2023 15:00:09 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id b19-20020a4ae213000000b0051a2a5c8ac6sm5309896oot.36.2023.02.13.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 15:00:08 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, rpearson@hpe.com
Subject: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
Date:   Mon, 13 Feb 2023 16:55:52 -0600
Message-Id: <20230213225551.12437-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently all the object types in the rxe driver are allocated in
rdma-core except for MRs. By moving tha kzalloc() call outside of
the pool code the rxe_alloc() subroutine can be eliminated and code
checking for MR as a special case can be removed.

This patch moves the kzalloc() and kfree_rcu() calls into the mr
registration and destruction verbs. It removes that code from
rxe_pool.c including the rxe_alloc() subroutine which is no longer
used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 46 --------------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  3 --
 drivers/infiniband/sw/rxe/rxe_verbs.c | 61 +++++++++++++++++++--------
 4 files changed, 45 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c80458634962..c79a4161a6ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -724,7 +724,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 
 	rxe_cleanup(mr);
-
+	kfree_rcu(mr);
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f50620f5a0a1..3f6bd672cc2d 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -116,55 +116,12 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	WARN_ON(!xa_empty(&pool->xa));
 }
 
-void *rxe_alloc(struct rxe_pool *pool)
-{
-	struct rxe_pool_elem *elem;
-	void *obj;
-	int err;
-
-	if (WARN_ON(!(pool->type == RXE_TYPE_MR)))
-		return NULL;
-
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto err_cnt;
-
-	obj = kzalloc(pool->elem_size, GFP_KERNEL);
-	if (!obj)
-		goto err_cnt;
-
-	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
-
-	elem->pool = pool;
-	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
-	init_completion(&elem->complete);
-
-	/* allocate index in array but leave pointer as NULL so it
-	 * can't be looked up until rxe_finalize() is called
-	 */
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
-			      &pool->next, GFP_KERNEL);
-	if (err < 0)
-		goto err_free;
-
-	return obj;
-
-err_free:
-	kfree(obj);
-err_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
-}
-
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 				bool sleepable)
 {
 	int err;
 	gfp_t gfp_flags;
 
-	if (WARN_ON(pool->type == RXE_TYPE_MR))
-		return -EINVAL;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto err_cnt;
 
@@ -275,9 +232,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (pool->type == RXE_TYPE_MR)
-		kfree_rcu(elem->obj);
-
 	atomic_dec(&pool->num_elem);
 
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 9d83cb32092f..b42e26427a70 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -54,9 +54,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
-void *rxe_alloc(struct rxe_pool *pool);
-
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 				bool sleepable);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7a902e0a0607..268be6983c1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -869,10 +869,17 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
-	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
@@ -880,8 +887,12 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_mr_init_dma(access, mr);
 	rxe_finalize(mr);
-
 	return &mr->ibmr;
+
+err_free:
+	kfree(mr);
+err_out:
+	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
@@ -895,9 +906,15 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
 
-	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
@@ -905,14 +922,16 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
 	if (err)
-		goto err1;
+		goto err_cleanup;
 
 	rxe_finalize(mr);
-
 	return &mr->ibmr;
 
-err1:
+err_cleanup:
 	rxe_cleanup(mr);
+err_free:
+	kfree(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -927,24 +946,32 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (mr_type != IB_MR_TYPE_MEM_REG)
 		return ERR_PTR(-EINVAL);
 
-	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->mr_pool, mr);
+	if (err)
+		goto err_free;
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
 	err = rxe_mr_init_fast(max_num_sg, mr);
-	if (err)
-		goto err1;
+	if (err)
+		goto err_cleanup;
 
 	rxe_finalize(mr);
-
 	return &mr->ibmr;
 
-err1:
+err_cleanup:
 	rxe_cleanup(mr);
+err_free:
+	kfree(mr);
+err_out:
 	return ERR_PTR(err);
 }
 

base-commit: 9cd9842c46996ef62173c36619c746f57416bcb0
-- 
2.37.2

