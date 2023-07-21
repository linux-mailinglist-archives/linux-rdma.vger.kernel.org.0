Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89975D5F7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGUUvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGUUvJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:09 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE2730E2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:08 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5636426c1b3so1502260eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972667; x=1690577467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2d0ewW30mk8n21Bpio/h6Obd9GorFFkBE725pzkhJz4=;
        b=dgAnlFAnmhKFDDirHHb5N5O8gKE6uqKNnKH4NVkt8AF7ldqUC83lnW79OlOkbIr/M4
         TwiEIZv3FbDuKJ+kVAKLSp6wVkD1+a73UwUmmgQCrhlB1+AwRz6moCoudMlydwH0+20R
         XlvyRPeis4qsye4Bm5rRbmyuG5t0L2jH2/7dyy5QLgcilcacIf02P0iBGEUjYDVhaFx3
         eyw+nE5b48mkN874KxaqMut9gilf5050yP50xUh3dGjXYfUhNiKqUzfR1tpK/zRSMCwC
         K3ID4fThACVkVdJWt9Q5l1wMFvzH0w1BDBsFbEBiGSNpCthoEBgD8Pn45J7Iynix/2SR
         4KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972667; x=1690577467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2d0ewW30mk8n21Bpio/h6Obd9GorFFkBE725pzkhJz4=;
        b=Lcs4Uj932rbBryZAnVn8JLCakwVfcz3TM/c94XWD7Gy8aI5atP9lM7RlFMhpEWwiL4
         zR1b5kUqVQW+TOJILASIHinCqHvFtxcH70NZCT3KjmkI5ky+CfYebc2jmyS/TcfVv3oj
         2oXKfNikGpPaDZAMVYHiNXgA/TEJ0fqTv1FoqPyY+q9FSCnSpbbglGjK/Ji1v1KEVnjl
         t5XEPPnuWeHEyOuVd5IyndwxZtYnUa55GOkZg8ns/XW+8ZVvVjzEhIbciyq++wrRxjZR
         af3/rucngcCdpt37CZ0anNjt85MC1Aby5vVsOw465jovTomsvnGqU0XXJ6DbbZ0XSoZF
         iBig==
X-Gm-Message-State: ABy/qLYn4rcfWNHNjl0hZ6aufZyKlj04U9M9FPnC6b8F6UwQNtu9pqjw
        UQnBPozjP7ZWaVnB/7svr3mpwfwNQXs=
X-Google-Smtp-Source: APBJJlEdFS/vyyjyLGLN1SdYiLzYowT9yfcbb21NAe6hQYiwS4o+mcjeGNESVsnYew8tTU1QWyoGZg==
X-Received: by 2002:a54:4883:0:b0:3a3:47c5:1de3 with SMTP id r3-20020a544883000000b003a347c51de3mr3110708oic.49.1689972667510;
        Fri, 21 Jul 2023 13:51:07 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/9] RDMA/rxe: Fix xarray locking in rxe_pool.c
Date:   Fri, 21 Jul 2023 15:50:15 -0500
Message-Id: <20230721205021.5394-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
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

The kernel rdma verbs API calls are not documented to require that
the caller be in process context and it is well known that the
address handle calls sometimes are in interrupt context while the
other ones are in process context. If we replace the xarray spin_lock
in the rxe_pool APIs by irqsave spin_locks we make most of the
verbs API calls safe in any context.

This patch replaces the xa locks with xa_lock_irqsave.

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index de0043b6d3f3..b88492f5f300 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -119,8 +119,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 				bool sleepable)
 {
-	int err;
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 	gfp_t gfp_flags;
+	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto err_cnt;
@@ -138,8 +140,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 
 	if (sleepable)
 		might_sleep();
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
+	xa_lock_irqsave(xa, flags);
+	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
 			      &pool->next, gfp_flags);
+	xa_unlock_irqrestore(xa, flags);
 	if (err < 0)
 		goto err_cnt;
 
@@ -179,6 +183,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
 	static int timeout = RXE_POOL_TIMEOUT;
+	unsigned long flags;
 	int ret, err = 0;
 	void *xa_ret;
 
@@ -188,7 +193,9 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	/* erase xarray entry to prevent looking up
 	 * the pool elem from its index
 	 */
-	xa_ret = xa_erase(xa, elem->index);
+	xa_lock_irqsave(xa, flags);
+	xa_ret = __xa_erase(xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
 	WARN_ON(xa_err(xa_ret));
 
 	/* if this is the last call to rxe_put complete the
@@ -249,9 +256,13 @@ int __rxe_put(struct rxe_pool_elem *elem)
 
 void __rxe_finalize(struct rxe_pool_elem *elem, bool sleepable)
 {
-	void *xa_ret;
 	gfp_t gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
+	struct xarray *xa = &elem->pool->xa;
+	unsigned long flags;
+	void *xa_ret;
 
-	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, gfp_flags);
+	xa_lock_irqsave(xa, flags);
+	xa_ret = __xa_store(xa, elem->index, elem, gfp_flags);
+	xa_unlock_irqrestore(xa, flags);
 	WARN_ON(xa_err(xa_ret));
 }
-- 
2.39.2

