Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430F4CCA8D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiCDAJf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiCDAJf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A6140E56
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:44 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id x193so6406217oix.0
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwD6U6B4WJb3lynL5l5wUSLzlnC+ucGLHdFjTDXzY1Y=;
        b=hGTn7F4Mlcz+qjTv9Eihndl84LhFQJJgvhLIkPY4fpTOi+x7A7vSOrLJx75b1VG0ER
         NwRFs3/0Oo1pAyvduyQy/hw6Ul+x2R7s5+Vyz4oYHr7qM/mm+dlBXzcB96whQz4LLvE0
         C82Bhm555PURtOlNZc98QBGGnUKJ+u4IRKDQtI+FvxRcrOR2VRRX3F8HnkqCeMGAm/eA
         lgngHNon+8XedztosRSC5ujtSiVDSm1zb4T8XiLGjhgtBygAu4ND4g249ch4crjs5Tjp
         efFUlx5NAFtYfwU6yw3sEQfcLdciPm0Ef8/e8kxBV8p5wKOf11ML6OAD55qt6NxTduhO
         Uliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwD6U6B4WJb3lynL5l5wUSLzlnC+ucGLHdFjTDXzY1Y=;
        b=V5gWkrDNuTBNm6TLYfOlVCZ4tKbi6cJTCwyvc5/yUbgCAI6zj7dC7fG+eJh2/dm+7l
         kp5j3lMC3hqC7cGHld8ypmKeZTKcLNipXkDgKKQGbzHsO9TBYg5rNkchrQyr1a2cpeRj
         YXqtmi6Vj5NwxJprMj80SQK4Kn0hgRZxvxgzy36vPCc5FcYpfV+tV1ay6IATLeqHQXKe
         mJZ1FSbKqvajmmJgay8DLkOKeWyQJmg2ngK/cWtGstGdMypgyzDmzZDZO1KD78f7pUDC
         wYOvGGYWiRT+uPgQBSdoCMZaR2rDzUwrR2ri1jPdKJN//F2nRTpcpddWA8Jh4LYc1Ezu
         3jzw==
X-Gm-Message-State: AOAM533SzFtUR0BQd3MFfMTU49JeVbablhHNCU1HMXezYKJZlzK7y0Ee
        L+X9SO57yk5PbO/tcOukucM=
X-Google-Smtp-Source: ABdhPJzeMnr7Nd3LSUMpu+WeBUgKpz3ozEW9ejDOBZIUIpar8nUZLb++qyOJkylPvjgcFij74OrU9w==
X-Received: by 2002:a05:6808:2026:b0:2d5:409e:1dc2 with SMTP id q38-20020a056808202600b002d5409e1dc2mr6816486oiw.130.1646352523755;
        Thu, 03 Mar 2022 16:08:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 03/13] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Thu,  3 Mar 2022 18:07:59 -0600
Message-Id: <20220304000808.225811-4-rpearsonhpe@gmail.com>
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

There is only one remaining object type that allocates its own memory,
that is mr. So the sense of RXE_POOL_NO_ALLOC is changed to
RXE_POOL_ALLOC. Add checks to rxe_alloc() and rxe_add_to_pool() to
make sure the correct call is used for the setting of this flag.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.h |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 16056b918ace..239c24544ff2 100644
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
@@ -264,6 +261,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 	struct rxe_pool_elem *elem;
 	void *obj;
 
+	if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
+		return NULL;
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -286,6 +286,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
+	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
+		return -EINVAL;
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -310,7 +313,7 @@ void rxe_elem_release(struct kref *kref)
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

