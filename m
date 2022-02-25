Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8B4C4F31
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiBYT7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiBYT7J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:09 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E255E10E57D
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:36 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id l21-20020a056830239500b005afd2a7eaa2so1520005ots.9
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPI+pT0VrXX59T3FUnSonIkNyDPdmmbEoNHkIu8tCIs=;
        b=CXtqIF+SygkrCltSe9PXCGQz2oLTcJHD0P0XDErdM0c2gcUtZwXvvmphH+CU76uKNG
         PzxSZlhOriQdDvB8sUDtswCGXESa9DlXex6twEbW5QFsmjfeZoKr42uBwbH9jWkOe3kG
         heovRZfgL3yHvnnL0iEj98mD+ypHOAAnSQMO2W/2r1JLA6QBEhfs5XhU9ZcJPx2uqDB6
         /50bUfWMu62NeiyP7GInKqHIb7XGKwFOsQ/G1NcMGCBNhddCs+bKZav8p5zh7yVEVRvI
         hkdHPULbLsPY3lMrYhGWDQXr49J+80NOGHpXkdR0c+MBf/nWFXi7QduclenV4CbZCJSO
         RE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPI+pT0VrXX59T3FUnSonIkNyDPdmmbEoNHkIu8tCIs=;
        b=VdsxbY6AzuaCdCMW7WXh7a2VqLDZNSy66nRroSkqgBn93J+Vh/kH/W48yjvBht44ZP
         xzcZZJ9NhrcLLmkzwDIYkSwsIosu53hODUWuuSc/dpzs4BRVibCsb4HHj9gkMgB5bZsg
         rNEwm9cQrB4hjBavUezWt9slqysKtQDS6ZsbcT/uOu+at/NLbRg+y1w8nUzfswATU4sl
         uHWINvUtaEXMBF0LWsc36DjhtF8oh0Qfr6qxq5SjQImdfGNxmceP47rMoSe4RIX8BiNh
         BDcGF4i+uUZJs0A5V0ME5veLc6/rZuaSaEcc2teN83U8d+2vN8No9aam4DFFfMdFqBYc
         g/tg==
X-Gm-Message-State: AOAM533SgxVHuvkrDso5DCIf6CubhE9TfEf0GSiy0o7N1pt7wJmVfAyO
        6DwMwaWVEx4lB9Eoef/JaYAhl3mR7aQ=
X-Google-Smtp-Source: ABdhPJzXMg9wmRzorlzna2jX4OmQ8bRvlXrqvKYc+yVJmK/xBFNzzgSscqbY19Oglua+aNTiZSWC6g==
X-Received: by 2002:a05:6830:1518:b0:5af:5aa1:4dc1 with SMTP id k24-20020a056830151800b005af5aa14dc1mr3580792otp.284.1645819116262;
        Fri, 25 Feb 2022 11:58:36 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 10/11] RDMA/rxe: Move max_elem into rxe_type_info
Date:   Fri, 25 Feb 2022 13:57:50 -0600
Message-Id: <20220225195750.37802-11-rpearsonhpe@gmail.com>
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

Move the maximum number of elements from a parameter in rxe_pool_init
to a member of the rxe_type_info array.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      | 16 ++++++++--------
 drivers/infiniband/sw/rxe/rxe_pool.c | 13 +++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.h |  2 +-
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 29e2b93f6d7e..fab00a753af1 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -116,14 +116,14 @@ static void rxe_init_ports(struct rxe_dev *rxe)
 /* init pools of managed objects */
 static void rxe_init_pools(struct rxe_dev *rxe)
 {
-	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC, rxe->max_ucontext);
-	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD, rxe->attr.max_pd);
-	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH, rxe->attr.max_ah);
-	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ, rxe->attr.max_srq);
-	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP, rxe->attr.max_qp);
-	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ, rxe->attr.max_cq);
-	rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR, rxe->attr.max_mr);
-	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW, rxe->attr.max_mw);
+	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC);
+	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD);
+	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH);
+	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ);
+	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP);
+	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ);
+	rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR);
+	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW);
 }
 
 /* initialize rxe device state */
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 713df1ce2bbc..20b97a90b4c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -18,6 +18,7 @@ static const struct rxe_type_info {
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
+	u32 max_elem;
 } rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
@@ -25,6 +26,7 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
 		.min_index	= 1,
 		.max_index	= UINT_MAX,
+		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
@@ -32,6 +34,7 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_pd, elem),
 		.min_index	= 1,
 		.max_index	= UINT_MAX,
+		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
@@ -39,6 +42,7 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_ah, elem),
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
+		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
@@ -46,6 +50,7 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
+		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
 	},
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
@@ -54,6 +59,7 @@ static const struct rxe_type_info {
 		.cleanup	= rxe_qp_cleanup,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
+		.max_elem	= RXE_MAX_QP_INDEX - RXE_MIN_QP_INDEX + 1,
 	},
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
@@ -62,6 +68,7 @@ static const struct rxe_type_info {
 		.cleanup	= rxe_cq_cleanup,
 		.min_index	= 1,
 		.max_index	= UINT_MAX,
+		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
@@ -71,6 +78,7 @@ static const struct rxe_type_info {
 		.flags		= RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
+		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
@@ -78,11 +86,12 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
+		.max_elem	= RXE_MAX_MW_INDEX - RXE_MIN_MW_INDEX + 1,
 	},
 };
 
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		   enum rxe_elem_type type, unsigned int max_elem)
+		   enum rxe_elem_type type)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
 
@@ -91,7 +100,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 	pool->rxe		= rxe;
 	pool->name		= info->name;
 	pool->type		= type;
-	pool->max_elem		= max_elem;
+	pool->max_elem		= info->max_elem;
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
 	pool->flags		= info->flags;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index f98d2950bb9f..5450f62b01bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -56,7 +56,7 @@ struct rxe_pool {
  * pool elements will be allocated out of a slab cache
  */
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		  enum rxe_elem_type type, u32 max_elem);
+		  enum rxe_elem_type type);
 
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
-- 
2.32.0

