Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7716A4C4F28
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiBYT7D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiBYT7C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:02 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D7C4283
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:30 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so7884971ooi.0
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d80SqjlPq7aDOk4+IA5y29FbnTZ92KXomxfds+6iK14=;
        b=ngHdrDgWBaWOegWYuKg/6ikxtmz5ix+Bf7zf0fcrgRuMl4ZeXBNRSsaN1t6OYjs50a
         an1L15yxoAI/4r84VwIjcNlZq28WjjC/rwk3lmlIBKg1KEjEBnjDFqpmopN3MfUatKrN
         ogtJvUpE4O/w3e0JeDJXfMmCB7FsloC+EmF5DC084OaMCwlVhNon8tuaTXPBPMEcN3k5
         szjD/QhWxaAFu74/pqT5irO4vDgkjU+4VX3PBwNctt6hIknt6htNrWuYw1T2tlf1iWut
         ANQOT9PUu1zGG1uvmHCLsC/q8kITO0yN9LTAODv1iaY28pfdJqWUjnJlFTPp3BaZF/7+
         tiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d80SqjlPq7aDOk4+IA5y29FbnTZ92KXomxfds+6iK14=;
        b=ne3daSyfFpM0xkYacRt0IN7I/aySi7crbDNpzmEzjduymknGIgrTus2RF3qKmCkUG3
         thOo86J6yIYCLRHyhrhVkSqtmtLrYRuLO3zFmvwkYYtxSk6W6KrcJFL+rlcaa8mTuGXD
         pbWwLZ2xh5sF+BuziIvRoZOTsX2YkLis+qNI+vbv7Lia/9Scc0B4+N78EoCnlfjIg0b/
         Mwl9v7COu2A3DFE9J0X+EZ4H3lUviN/g58vF7JtTJt8ktRfWt+CTGdqWZt1HSlsL/lFj
         5hFQE028hKEgpXD4UFBqOrZlpaKIwN8/NzvqiiSAz7TOiI0MPf6hg0Yb4O4Pzy0HztQ2
         FIIQ==
X-Gm-Message-State: AOAM532jUB7oi29T3Mn1PVXDoUL3PpU9dTF2fT8eA1YqeeC1vMASL8gL
        H9p79U6wraIeOmzN73t7R5o=
X-Google-Smtp-Source: ABdhPJxt1sW8K8nQ/RIM/D41ZdUP01S9AokYllKfC9XCYp5eaaRYmmx/rIu3X5vdDV6qYYFpkOaIfg==
X-Received: by 2002:a4a:c98d:0:b0:31b:e25d:d98d with SMTP id u13-20020a4ac98d000000b0031be25dd98dmr3494669ooq.86.1645819109502;
        Fri, 25 Feb 2022 11:58:29 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:29 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 01/11] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Fri, 25 Feb 2022 13:57:41 -0600
Message-Id: <20220225195750.37802-2-rpearsonhpe@gmail.com>
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

There is only one remaining object type that allocates its own memory,
that is MR. So the sense of RXE_POOL_NO_ALLOC is changed to
RXE_POOL_ALLOC. Add checks to rxe_alloc() and rxe_add_to_pool() to
make sure the correct call is used for the setting of this flag.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 27 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.h |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 16056b918ace..63681a8398b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -21,19 +21,17 @@ static const struct rxe_type_info {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
-		.flags          = RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
-		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -41,7 +39,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -50,7 +48,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -58,7 +56,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
-		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
@@ -66,7 +63,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 	},
@@ -75,7 +72,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
@@ -264,6 +261,12 @@ void *rxe_alloc(struct rxe_pool *pool)
 	struct rxe_pool_elem *elem;
 	void *obj;
 
+	if (!(pool->flags & RXE_POOL_ALLOC)) {
+		pr_warn_once("%s: Pool %s must call rxe_add_to_pool\n",
+				__func__, pool->name);
+		return NULL;
+	}
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -286,6 +289,12 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
+	if (pool->flags & RXE_POOL_ALLOC) {
+		pr_warn_once("%s: Pool %s must call rxe_alloc\n",
+				__func__, pool->name);
+		return -EINVAL;
+	}
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -310,7 +319,7 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+	if (pool->flags & RXE_POOL_ALLOC) {
 		obj = elem->obj;
 		kfree(obj);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 8fc95c6b7b9b..44b944c8c360 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -9,7 +9,7 @@
 
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
-	RXE_POOL_NO_ALLOC	= BIT(4),
+	RXE_POOL_ALLOC		= BIT(2),
 };
 
 enum rxe_elem_type {
-- 
2.32.0

