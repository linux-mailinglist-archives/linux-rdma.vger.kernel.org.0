Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1046A98F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 22:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350414AbhLFVSQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 16:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350426AbhLFVRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 16:17:37 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20160C0698C3
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:14:07 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q25so23963806oiw.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgjlfZQtpHGy141Aj7rGecrRtBMeE90RbyA6xJVdHKU=;
        b=bvBS2b4M0MXSQbs1s6ycJoaT5FI4RhbpSPkMyhjwPuiaOO+nZnLLVXQ3bTilE2p+zC
         L01JXHBlJv/X1uQGYpvHfXXKQSn1j/XwWchtqvh6DfUdaRVrCT0TxaG6cl9pWtTjbrrQ
         79lUWWdZR3nl+5P16UhkCKk9MDFEjjkQny8YNuqkAHQhuwP1ymqHepRQIS8D/Y0Q2cM1
         Ub5hwQOULp+JFYPhutF6ZDSGsus7J9FNRIbHn9+QCOYAQLzyW/OM2pR1kuHOc2Ato4F7
         avrI336MuVs3VAeRWd9xmPS5UFPk1wwt432dyA71/1O67bGxftlqXUhTp2tmqua8eU/x
         GhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgjlfZQtpHGy141Aj7rGecrRtBMeE90RbyA6xJVdHKU=;
        b=lu6+w10eIc3fZpu8+MohFw8kCTo8eC0B3TyEBhYeIjhKtiCpFkn8Cf4ymMJPJoMqrx
         hobkkghm+W80sVngt5hxyq/QkVosMGBi3a9L4mE8bWFjNUkdSpbykZD+Z8uQLk+FYrha
         BLj6kpJWj2OCh9nrIyNhSrfUVHuH3cVatA9l6A9aiUTwQnw4tsh+6sq/OlqBHxVhhrkf
         GGVjKhvYdB5wR/KXmoicy0QavvrdLXEnFhBQmcO4gAmxorWoE1G9EmBN1xtrFoulkcPQ
         3n/N8UktZ+aZVxGnzSjGLqAe3mjKkVWCMn/GQZR0rtU0Y5+MDov84m5Jh3iy+ZOu0sLI
         TTvQ==
X-Gm-Message-State: AOAM533KFnXwtSmFdN5RLJ1qL7KZ+ug1Gw5WA8IVwvKamlsS2jna3i0o
        MdHrTIJYys1LvuHtvrizUTk=
X-Google-Smtp-Source: ABdhPJzNlSXLRelGlvRvDrrC1BZDOggbO4/9CJo1G0ZiQZEpHtCgEDfXCXCLB4P01o17mv0lHcqhwA==
X-Received: by 2002:a05:6808:198f:: with SMTP id bj15mr1148530oib.69.1638825246541;
        Mon, 06 Dec 2021 13:14:06 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-07ad-dbeb-c616-747c.res6.spectrum.com. [2603:8081:140c:1a00:7ad:dbeb:c616:747c])
        by smtp.googlemail.com with ESMTPSA id y28sm2819111oix.57.2021.12.06.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:14:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 2/8] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Mon,  6 Dec 2021 15:12:37 -0600
Message-Id: <20211206211242.15528-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206211242.15528-1-rpearsonhpe@gmail.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since most rxe objects are now allocated in rdma-core change the
sense of RXE_POOL_NO_ALLOC to RXE_POOL_ALLOC. This makes the code
easier to understand.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 18 ++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.h |  2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 8970115b11ef..599696883c44 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -23,19 +23,17 @@ static const struct rxe_type_info {
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
@@ -43,7 +41,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -52,7 +50,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -60,7 +58,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
-		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
@@ -68,7 +65,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 	},
@@ -77,7 +74,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
@@ -86,7 +83,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mc_grp),
 		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
 		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY,
+		.flags		= RXE_POOL_KEY | RXE_POOL_ALLOC,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
 		.key_size	= sizeof(union ib_gid),
 	},
@@ -94,6 +91,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
 		.elem_offset	= offsetof(struct rxe_mc_elem, elem),
+		.flags		= RXE_POOL_ALLOC,
 	},
 };
 
@@ -323,7 +321,7 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+	if (pool->flags & RXE_POOL_ALLOC) {
 		obj = elem->obj;
 		kfree(obj);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index e84de5f59af1..2731ede2310c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -10,7 +10,7 @@
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
-	RXE_POOL_NO_ALLOC	= BIT(4),
+	RXE_POOL_ALLOC		= BIT(4),
 };
 
 enum rxe_elem_type {
-- 
2.32.0

