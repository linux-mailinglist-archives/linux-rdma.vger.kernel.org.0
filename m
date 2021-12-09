Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0146F3BE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 20:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhLITTN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhLITTM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 14:19:12 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14881C061746
        for <linux-rdma@vger.kernel.org>; Thu,  9 Dec 2021 11:15:39 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bj13so10091566oib.4
        for <linux-rdma@vger.kernel.org>; Thu, 09 Dec 2021 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDdExr3eMeEb1tazYUSHIAsXh6hcObg1zDJhekd64bE=;
        b=m0RZ3zz2w9uK2+AvGboD+Ft21piTmREcJRdwMsOc4tm8wHHfgjv6fiySVgrupAfyNv
         j2vQCSjH4sPqR2VeF7xpGtFsOZ5PL0v9bOlaKpUiqmrT4rDvoksvr+KrWvqCuo4Kqd7h
         ElHxFs3ftKSK+atzcAZGJqex+PgI3JS7wttSDL7sp8M54+7VWiQxH+wTfhXoJVA8NEcU
         nEsr5PLEhFZNkIX/Gyjktg34ODm1rE9nDUBil97HoUReLyvPWH6jUpWx4T+n4XEZSJ9J
         1l135ZdYZ6h6gZaIwjHWwZSgEpi4/sOZwNQ6ldBgz77qjL90ja4RY0+cdPaP5QeWr5mO
         9Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDdExr3eMeEb1tazYUSHIAsXh6hcObg1zDJhekd64bE=;
        b=ygsujc5XFGkQwDDnK+NMG77uBMUf/Or9N7pDKfOg2CMxEwhUUmJb9OVvdrEbaT6unl
         IzcJYtnWEyCGNBTrh+7OaObAYLrMOj3/ruzt2tY3ZX+MasZWM89LZXAeBQfbIfPlVpZP
         lzMs2QLlWSvkfVg+vV/VjGbjR1Xx2Q9cGDrFt+GOuj5/QJZw9WNZFSWbJ9H15t9YKfE/
         K2DGT+ccSsXEmsvfLBDldAxtQc+avDNA4WcOF6m+T+8/uZMnMw/NCkTBEKbdLNN8kjae
         /0r6a2fWB8QPjpEfmTx8qYHbD7DCOZfGXEkU51QXflFhG+YLF5aTw4IgKEP9V9R3P9w9
         NhQg==
X-Gm-Message-State: AOAM532GNNnO6AxRufcllNZJsmDMxk60FIRBtNNSqMYaCOK9WnJ5vy6O
        GunBychmJ1otzV21TIW1ELXDgEDPUco=
X-Google-Smtp-Source: ABdhPJwKOenYtNsLjyLwBnwQPVU8fK5+Z72aARvIIkJXzQ9o9Oil/yyAIC0tnP0SWIBN7XkzS2IsSw==
X-Received: by 2002:aca:b407:: with SMTP id d7mr7643618oif.116.1639077338365;
        Thu, 09 Dec 2021 11:15:38 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-9c23-089d-4ab2-4477.res6.spectrum.com. [2603:8081:140c:1a00:9c23:89d:4ab2:4477])
        by smtp.googlemail.com with ESMTPSA id h3sm117807oon.34.2021.12.09.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:15:38 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 2/8] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Thu,  9 Dec 2021 13:14:21 -0600
Message-Id: <20211209191426.15596-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211209191426.15596-1-rpearsonhpe@gmail.com>
References: <20211209191426.15596-1-rpearsonhpe@gmail.com>
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
index ff7ca2dbcb0a..d1981309aa23 100644
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
 
@@ -321,7 +319,7 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+	if (pool->flags & RXE_POOL_ALLOC) {
 		obj = elem->obj;
 		kfree(obj);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index fbef351783dc..514be1582bce 100644
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

