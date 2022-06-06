Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D753EBB8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiFFOSW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbiFFOSQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:18:16 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D830F63
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:18:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y69so6046048oia.7
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoX8fuwWZl5l5RGJsgRct1AN2I9He2uGC1+jd1u+Vzw=;
        b=mKVWSLsaRpNYC9Aztxqf1Ov/OX5ubaqIHEeW1GPLvptNNkO1A8z6KKGZ7omOfiJ0Fw
         kUrr134hU9cV3PjRIF9vvHV9aVZzA3zCDKwbwNJ+fhN1AG1js4KEQWVDEn30c8zIb2hn
         U1aEy3oEAjpKTH9myazbMyVvDcd/Kpn8EjIC5mY9s5u3LF2kxE6CF189ZYr6wmX4W0KJ
         WwA2154Dhx3g0WOFJDwexB5z1sz9VhJGPdh69nUrpnxkNH4Z5FIdRbt7d6HnJAoXl4S+
         7Gi9y+8tqSzlk2gZ6k0LHl5Z3mjuRJeRaS+/svgnETIwl+e+0bbLk+bIRc2obvYUl3b+
         LKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoX8fuwWZl5l5RGJsgRct1AN2I9He2uGC1+jd1u+Vzw=;
        b=RnvIpfVbFFsOPC0m3MmB7nf2sBxt59cKdzmRyS0zxnOjT0V3SSLN15HhCl5URjKIqy
         JxS27c1twg42HVzhkIc6wTfV/OywHWuDR+5iQtieALQdZlpwWzih+Y+48BDXUQ+uBN9r
         QlPKwKT9dqS9uFtCQhqhZuzgLAMWApl7R62z3MtiqdLPQKk7ABFiuVvr8F6vWeR08tHB
         Y/tU08uVDBUytsK+GPhAN/nG8ak6zIePA3WrPG3pcFWwLHwR579MWRs+4VZrSEarSkTW
         rzRBA6hKb6HtDreN6Ey+m5IesDWZwzQPq6C9UzgomhYZeWN/N6MIqPV+bs9j75uUDysT
         iMTQ==
X-Gm-Message-State: AOAM533Nv5WUZ2DqWyvwyAKY1gpFbkSRrOAsaRd1b1o6C9ZIEkv4bmEo
        RVFEvZk+zHhMSz/Q+DwLd1k=
X-Google-Smtp-Source: ABdhPJzU80K+UzxmDT4ZIyCWO0uZK+KLDrNaDfkoTrMm1bZZTZNTe3ZC8QAzn6FVUoP2lGrZhJDbDQ==
X-Received: by 2002:a05:6808:1828:b0:326:d7fc:bb56 with SMTP id bh40-20020a056808182800b00326d7fcbb56mr13262382oib.19.1654525092156;
        Mon, 06 Jun 2022 07:18:12 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id gz9-20020a056870280900b000e686d1386dsm6710097oab.7.2022.06.06.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:18:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v15 2/2] RDMA/rxe: Convert read side locking to rcu
Date:   Mon,  6 Jun 2022 09:18:04 -0500
Message-Id: <20220606141804.4040-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606141804.4040-1-rpearsonhpe@gmail.com>
References: <20220606141804.4040-1-rpearsonhpe@gmail.com>
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

Use rcu_read_lock() for protecting read side operations in rxe_pool.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7a5685f0713e..103bf0c03441 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -195,16 +195,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	struct xarray *xa = &pool->xa;
-	unsigned long flags;
 	void *obj;
 
-	xa_lock_irqsave(xa, flags);
+	rcu_read_lock();
 	elem = xa_load(xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
-	xa_unlock_irqrestore(xa, flags);
+	rcu_read_unlock();
 
 	return obj;
 }
@@ -221,16 +220,15 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
 	static int timeout = RXE_POOL_TIMEOUT;
-	unsigned long flags;
 	int ret, err = 0;
 	void *xa_ret;
 
+	WARN_ON(!in_task());
+
 	/* erase xarray entry to prevent looking up
 	 * the pool elem from its index
 	 */
-	xa_lock_irqsave(xa, flags);
-	xa_ret = __xa_erase(xa, elem->index);
-	xa_unlock_irqrestore(xa, flags);
+	xa_ret = xa_erase(xa, elem->index);
 	WARN_ON(xa_err(xa_ret));
 
 	/* if this is the last call to rxe_put complete the
@@ -275,7 +273,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 		pool->cleanup(elem);
 
 	if (pool->type == RXE_TYPE_MR)
-		kfree(elem->obj);
+		kfree_rcu(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
@@ -294,12 +292,8 @@ int __rxe_put(struct rxe_pool_elem *elem)
 
 void __rxe_finalize(struct rxe_pool_elem *elem)
 {
-	struct xarray *xa = &elem->pool->xa;
-	unsigned long flags;
-	void *ret;
-
-	xa_lock_irqsave(xa, flags);
-	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
-	xa_unlock_irqrestore(xa, flags);
-	WARN_ON(xa_err(ret));
+	void *xa_ret;
+
+	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	WARN_ON(xa_err(xa_ret));
 }
-- 
2.34.1

