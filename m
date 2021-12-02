Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96BE466D97
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349117AbhLBXYz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbhLBXYy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:54 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E454C061757
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:32 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so1734097otj.7
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+fZ6EJFzNxA8PFd2Ngv0kr8xDkNtL22mZ4IGNyWjJs=;
        b=jmt0TQwzRrjfG9a+SnLQ2nMCkbPM6WY00IgqPdaNiCynrgwH3YXpfnEYknco5wdTg3
         D+AKRzFVDj59GHCliteoXPZA/bv2OXAMdVSr2XZX+XevgYm6EigT65MbyaDKQLvLsrFI
         1XoYB5PJgCbKC4bS2VSr3q49f5Y+U4AyeqeLE3cwUl2nP4xhB4r0zpTQqI30XHXYxax1
         0dxaQfY+5KXTx53A9IMXeX1TnwNek0xTjr5edSR80h9aggjsOnMlkmCRnD2Ajygm6id1
         3nuSTCam7NoVE5YqzMAXcw4NNgJb9NrRvHDjcM9xUNhJITaQKH5teCjXmPBC1PsNzeTD
         H4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+fZ6EJFzNxA8PFd2Ngv0kr8xDkNtL22mZ4IGNyWjJs=;
        b=VyFoZ3ElHJF7C+rYjY7SeDLJDeduu1/URO6f+XSULQeGAlIrd1C7FE7wz34fjBBYKO
         jvrAM32JY2GmGzEEkYyOUFF5zcDvaFovIt1bSu7ArCR4A34eRq+AeIEiupSpIvhXWv3S
         8OM8ZFl/i2QdLPwJm2ihBOEqzM3nSu9FgU2+a+mK6baot0Lkd7IXqkA4xzxzzJ13jugV
         Pvq1vQcqniUDYfG/0ZuHaLKj/KeWHEBoi+ygF8/nRqoRmWalQOke5fojEoGjX4lM+RwC
         tlJEqs+aqux3tlPxdmXs4E01NaYfg5m/5TVVg3ByPKWjZ5Bcs9qalJQCaOCu0PPYPxeM
         wzfA==
X-Gm-Message-State: AOAM532tabodxuNRznk19Q7aO36jqbKQi3/4XKRhoBitIwT7cPDRCpUk
        oGvqDc/X5dg2LhAZYaYOhHnIi+vDaRY=
X-Google-Smtp-Source: ABdhPJzCJOGMzqjH5kqh0I3iYl70t2KOii5dM60GudJh11yhBGwDQ0zb4IR2sxBUBPKGDUGl2vIoNw==
X-Received: by 2002:a9d:d08:: with SMTP id 8mr13905268oti.334.1638487291526;
        Thu, 02 Dec 2021 15:21:31 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:31 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 2/8] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Thu,  2 Dec 2021 17:20:29 -0600
Message-Id: <20211202232035.62299-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202232035.62299-1-rpearsonhpe@gmail.com>
References: <20211202232035.62299-1-rpearsonhpe@gmail.com>
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
index 0c09ab8aa6d4..7d70a493a4b0 100644
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

