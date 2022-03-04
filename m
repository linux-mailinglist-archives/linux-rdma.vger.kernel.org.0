Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDE4CCA8B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiCDAJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiCDAJd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:33 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF847AFE
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:46 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso7652023ooi.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDpFc1qZcSRZoOmrwG1SOSqoCxkUsGIPo8B+4/9TPGs=;
        b=DJZ1sVOU519vGjHWougb2UE50ba/LWTIYJ99QAPxdvtGTkEeJAMIt0Vxg7gaAtpa2b
         Xm3yIRGLVI6W0SawLTuoDgGNTq55unbD2IEYJBSUx/fvM4bhWh+KDDSBBGUkJ2+Ymyzh
         rnjxQjhOfxWcNJvkOGg/5dtGzgawouBbp6s2efCIYRSKZgaSWzzelgH6KDSc+DoVyGtI
         MDULHiVpYmkVLQGViXrmi5zjnzdMMDhSxGOo2pBTzaQQkNSITp3zqAJQ0D6FJgagnjRg
         ENB1ylg0ybw5N5jsgLtRKlMyo9P+cDQPhSqRxKrREf0hBeVI8nxbMYZg7cs7JyeFcZCA
         JwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDpFc1qZcSRZoOmrwG1SOSqoCxkUsGIPo8B+4/9TPGs=;
        b=MYlTT8zbwnwfV/EthGoaE8zO98YQP4bxCtdJLUBeTRiLOsl82z00GX8R6/2RVtNGB/
         cpsZ7geUfoG59E/cpZGIUkTCEG6/H+Q52aXTQseFO9ZXINgpULgIkvGG1e1lfU+w8XXr
         qxgqgRKqPRZriESwPqw+zH+ZRdUHtnD27m2voOAfDX3wTdfQRoJoh4q9T0Yo0ywsZfNY
         w42SiczHPWZp79Mr0zt/1fQr4oy9odZQltawWImR6X6mBK48Ou5OLytDBSBuPjgIZxTX
         NDFKyrRn7UEUJsinSWhc78ZpheKpQNLxJ0UE2jdfSk1H0KVR0p+/c+Dv+Rd3mBi9GiwU
         tbnw==
X-Gm-Message-State: AOAM532jN2MCV39RqjvoDZ2d7JcLOgymkL03W5PmnHy4JXGmuVg3JwsD
        KK0LsCi9hafLw18ZKM5xFhk5E0HIJUE=
X-Google-Smtp-Source: ABdhPJwGdM0xI6svZ3y7Kb318caQOMv4SCKHJvIATeJFowc/0Us8O4Grbr2F0OLOHEsgD5p/SDKdEQ==
X-Received: by 2002:a05:6870:4151:b0:d7:f5f:fd52 with SMTP id r17-20020a056870415100b000d70f5ffd52mr6087457oad.2.1646352525906;
        Thu, 03 Mar 2022 16:08:45 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 06/13] RDMA/rxe: Move max_elem into rxe_type_info
Date:   Thu,  3 Mar 2022 18:08:02 -0600
Message-Id: <20220304000808.225811-7-rpearsonhpe@gmail.com>
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

Move the maximum number of elements from a parameter in rxe_pool_init
to a member of the rxe_type_info array.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      | 24 ++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.c | 14 +++++++++++---
 drivers/infiniband/sw/rxe/rxe_pool.h |  2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index fce3994d8f7a..dc1f9dd70966 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -118,43 +118,35 @@ static int rxe_init_pools(struct rxe_dev *rxe)
 {
 	int err;
 
-	err = rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC,
-			    rxe->max_ucontext);
+	err = rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC);
 	if (err)
 		goto err1;
 
-	err = rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD,
-			    rxe->attr.max_pd);
+	err = rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD);
 	if (err)
 		goto err2;
 
-	err = rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH,
-			    rxe->attr.max_ah);
+	err = rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH);
 	if (err)
 		goto err3;
 
-	err = rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ,
-			    rxe->attr.max_srq);
+	err = rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ);
 	if (err)
 		goto err4;
 
-	err = rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP,
-			    rxe->attr.max_qp);
+	err = rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP);
 	if (err)
 		goto err5;
 
-	err = rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ,
-			    rxe->attr.max_cq);
+	err = rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ);
 	if (err)
 		goto err6;
 
-	err = rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR,
-			    rxe->attr.max_mr);
+	err = rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR);
 	if (err)
 		goto err7;
 
-	err = rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW,
-			    rxe->attr.max_mw);
+	err = rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW);
 	if (err)
 		goto err8;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 3b50fd3d9d70..bc3ae64adba8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -16,16 +16,19 @@ static const struct rxe_type_info {
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
+	u32 max_elem;
 } rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
+		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
+		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
@@ -34,6 +37,7 @@ static const struct rxe_type_info {
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
+		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
@@ -42,6 +46,7 @@ static const struct rxe_type_info {
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
+		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
 	},
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
@@ -51,12 +56,14 @@ static const struct rxe_type_info {
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
+		.max_elem	= RXE_MAX_QP_INDEX - RXE_MIN_QP_INDEX + 1,
 	},
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
+		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
@@ -66,6 +73,7 @@ static const struct rxe_type_info {
 		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
+		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
@@ -75,6 +83,7 @@ static const struct rxe_type_info {
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
+		.max_elem	= RXE_MAX_MW_INDEX - RXE_MIN_MW_INDEX + 1,
 	},
 };
 
@@ -104,8 +113,7 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 int rxe_pool_init(
 	struct rxe_dev		*rxe,
 	struct rxe_pool		*pool,
-	enum rxe_elem_type	type,
-	unsigned int		max_elem)
+	enum rxe_elem_type	type)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
 	int			err = 0;
@@ -115,7 +123,7 @@ int rxe_pool_init(
 	pool->rxe		= rxe;
 	pool->name		= info->name;
 	pool->type		= type;
-	pool->max_elem		= max_elem;
+	pool->max_elem		= info->max_elem;
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
 	pool->flags		= info->flags;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index a8582ad85b1e..5f34d232d7f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -63,7 +63,7 @@ struct rxe_pool {
  * pool elements will be allocated out of a slab cache
  */
 int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		  enum rxe_elem_type type, u32 max_elem);
+		  enum rxe_elem_type type);
 
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
-- 
2.32.0

