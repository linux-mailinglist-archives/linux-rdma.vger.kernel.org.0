Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43A75D5FE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGUUvR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGUUvQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC26359C
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a4062577c0so2216571b6e.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972672; x=1690577472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPT+HSty6dekpK34u9m2eE59lcPueQMgpbY9nuwDHAg=;
        b=AOlJlS5oKvPecN8vV3Gwx1KcZyEw6ITeQp1xXOHbnJRrMt7/NLmL0a6g80lbdgKOin
         k8XRuPB2CDGmJMkplsFOKKr3TQSiq1XKwOjZ4YgBzA9Q6rMgWHSQoFj2flOJChA6+aQH
         jecuVbz7hbVE/fXXnjYp1SX+LHniNKEyA41ET2yc5PJYOhWYCKYDMHXS24/7tQsHK31j
         BP4BcZ+zUJpnn2EpvrFQoJt7eho5Job27wHQGE6XNpSyJpBbCgykQq2pInM6YjKnydUP
         nvCyFVy7BZopGs3ycGTMqL3o5EiUrbdo2nPlkpey8NyRLiN5OpNdsWuRgKwjs4dQdDC3
         xJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972672; x=1690577472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPT+HSty6dekpK34u9m2eE59lcPueQMgpbY9nuwDHAg=;
        b=QmytG/uArTaQfkFSttrDWwfJcOmIjNazS987/mTdZPivjabZbXr3zC7BG7hk/Aqor1
         CE2AOZ3GF2y3YrL/lTvgemnk7gr3CwWldI2CkXF9V0tIUKNetMoI7o1HOyY6AQu9BZ3E
         epOjtwMq6wIyETZOJ3/tIqfFVHEiBwBPBj5qI1dSijxLcHYC+aW7DJRmljcPVFr031B2
         IpMaEppihnYCqCjufzLsrbJeaWznVZnYQ1yUsFnFFv8uSUt6LlYzo0d9qYlzIefPA3XQ
         7Ax9SVsuiamZKHat8vePZQ7XS51cHGNd+2Yq7oYoMvQQjiNI3XGlU7ZBtIKtz9L7bR+j
         pnXg==
X-Gm-Message-State: ABy/qLaPYTxbqsu6G3wEy7LAyxKsz/tKW/R+cecRtXYb4UgIiEXz3mrL
        zBlB23TapYYcsXXlFNgX7CQ=
X-Google-Smtp-Source: APBJJlF5jb/1d3s87DTirjoagRUJkAvucNF3bZ8TKQmGQCtOBt7CXjXH3a2A1lp6OFnQO37/bJz1Pg==
X-Received: by 2002:a05:6808:2025:b0:3a3:9b4a:3959 with SMTP id q37-20020a056808202500b003a39b4a3959mr3448339oiw.17.1689972672377;
        Fri, 21 Jul 2023 13:51:12 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 7/9] RDMA/rxe: Add elem->valid field
Date:   Fri, 21 Jul 2023 15:50:20 -0500
Message-Id: <20230721205021.5394-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver stores NULL in the pool xarray to
indicate that the pool element should not be looked up from its
index. This prevents looping over pool elements during driver
cleanup. This patch adds a new valid field to struct rxe_pool_elem
as an alternative way to accomplish the same thing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 32 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 9877a798258a..cb812bd969c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -141,7 +141,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 	if (sleepable)
 		might_sleep();
 	xa_lock_irqsave(xa, flags);
-	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
+	err = __xa_alloc_cyclic(xa, &elem->index, elem, pool->limit,
 			      &pool->next, gfp_flags);
 	xa_unlock_irqrestore(xa, flags);
 	if (err < 0)
@@ -158,11 +158,14 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	struct xarray *xa = &pool->xa;
+	int valid;
 	void *obj;
 
 	rcu_read_lock();
 	elem = xa_load(xa, index);
-	if (elem && kref_get_unless_zero(&elem->ref_cnt))
+	/* get current value of elem->valid */
+	valid = elem ? smp_load_acquire(&elem->valid) : 0;
+	if (valid && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
@@ -191,13 +194,8 @@ void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	if (sleepable)
 		might_sleep();
 
-	/* erase xarray entry to prevent looking up
-	 * the pool elem from its index
-	 */
-	xa_lock_irqsave(xa, flags);
-	xa_ret = __xa_erase(xa, elem->index);
-	xa_unlock_irqrestore(xa, flags);
-	WARN_ON(xa_err(xa_ret));
+	/* prevent looking up element from index */
+	smp_store_release(&elem->valid, 0);
 
 	/* if this is the last call to rxe_put complete the
 	 * object. It is safe to touch obj->elem after this since
@@ -231,6 +229,11 @@ void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 		}
 	}
 
+	xa_lock_irqsave(xa, flags);
+	xa_ret = __xa_erase(xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
+	WARN_ON(xa_err(xa_ret));
+
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
@@ -249,13 +252,6 @@ int __rxe_put(struct rxe_pool_elem *elem)
 
 void __rxe_finalize(struct rxe_pool_elem *elem, bool sleepable)
 {
-	gfp_t gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
-	struct xarray *xa = &elem->pool->xa;
-	unsigned long flags;
-	void *xa_ret;
-
-	xa_lock_irqsave(xa, flags);
-	xa_ret = __xa_store(xa, elem->index, elem, gfp_flags);
-	xa_unlock_irqrestore(xa, flags);
-	WARN_ON(xa_err(xa_ret));
+	/* allow looking up element from index */
+	smp_store_release(&elem->valid, 1);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index daef1ed72722..5cca33c5cfb5 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -26,6 +26,7 @@ struct rxe_pool_elem {
 	struct completion	complete;
 	struct rcu_head		rcu;
 	u32			index;
+	int			valid;
 };
 
 struct rxe_pool {
-- 
2.39.2

