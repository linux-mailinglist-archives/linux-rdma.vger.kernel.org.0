Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D647149ED94
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbiA0ViW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbiA0ViT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:19 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60BC061748
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:19 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x193so8661669oix.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWWfpsAW3PURcAs6cTHYlX1JonKPfT0wiVd2NrLN1/4=;
        b=JJcHZo+EbNiqtIWbl3moYZI82l/Jx3QtLxVi0GCsR1ybvVEdlcfAr2k3QHRv9zPPJR
         MZNr2FM7ibHtSWNN1bkDLdUTp865eiN/GHT1sTkp3qOUKYQx4YoN4UiSTe5By4F4RmId
         wyySZF0DsUDmw/hiNtvPXyH0V9B8ardXALHs8LjUKzkSm9Yn3xUxdc6Tfd9SZc0uODbP
         PVuQc5gk4enXEsenS8Z5LyZW7A24ugPRzQUOwkM3SUeHftUAnYBXo2+q4BwBZMgq+ZlR
         fieacwtk7dQfHDrU8QetvTM7kAZoJAeqr1wHMSDABliUhLg7pPdZE9rK5RI/BiGMMFR4
         xJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWWfpsAW3PURcAs6cTHYlX1JonKPfT0wiVd2NrLN1/4=;
        b=JxktGuXlJ0/Ba8rtVgCYxqpnZ/Rry3hq3IVFeKfx/YG0Cb/kBppeXsd92IPgBFVzQJ
         iMUphDYtCivZyLYuCfPMVUQPp+hM0vddYaTspgwtHXKIqtD/MI0m9tLbuh6ocsWp19PX
         7DyWnFnXOUj+7A7Go3GmlseKykZFglDlqVM5vu0OG69lgQgGxEOdZt4yKf1bTyVZiJMq
         ni2lV+bagGscoqJDEKoHlizKSWEEPo+OIkNki+Z4MwwAFpBXBCnL5PyRn3u/KbM7dTJ7
         1NTz+0UhnSbXRbdZWTtwD7AnsJv9D9zYWvGODUTSOzVABFwyV9biFT4Ka99hnCEUAP2d
         j8sQ==
X-Gm-Message-State: AOAM531hcr6A+7jra4/1H06GIB+3EK395XWiydZgO5TOlVpUlaIx97J5
        cI/Y7SNfUYc+/I4DJahkvwAHJFIMa+Q=
X-Google-Smtp-Source: ABdhPJyMU/d2I2ug/Ixzp6u21Wkf86MK0lGHhQHM9fWX8BQyzfxzPZ3Fq6KWhTT0rWudyrNvlZ04Gg==
X-Received: by 2002:a05:6808:1598:: with SMTP id t24mr7977777oiw.50.1643319498889;
        Thu, 27 Jan 2022 13:38:18 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:18 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 19/26] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Thu, 27 Jan 2022 15:37:48 -0600
Message-Id: <20220127213755.31697-20-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b6fe7c93aaab..8fc3f0026f69 100644
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
@@ -262,6 +259,12 @@ void *rxe_alloc(struct rxe_pool *pool)
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
 
@@ -284,6 +287,12 @@ void *rxe_alloc(struct rxe_pool *pool)
 
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
 
@@ -308,7 +317,7 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+	if (pool->flags & RXE_POOL_ALLOC) {
 		obj = elem->obj;
 		kfree(obj);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 99b1eb04b405..ca7e5c4c44cf 100644
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

