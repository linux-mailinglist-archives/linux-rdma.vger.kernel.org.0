Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E684780A8
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhLPXeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 18:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLPXeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 18:34:00 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB59C061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u74so1132074oie.8
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDdExr3eMeEb1tazYUSHIAsXh6hcObg1zDJhekd64bE=;
        b=PgSQA3JN4jJ4mfnWnrtgMj6lQ+epEzsxXclUUoXwwjNZ3S5rdn6WKJrRuzokfX5jyP
         foTF+Au4qkMuLQQLWVK72EDTIepdFuouNsPXXEtnVXLFe9/tjBb4ehoWbyatJi2441xb
         UN5vkZsW5SgbZUWs4uCPEuEgoe7/GWPqZYup3SQjH5huizZ/6yaGFNiG8bwRm42HXV7e
         MA17BOB5xL4YGHdoNP4KxmHyyFkdyoWdFInlZBYNYIrflIKsYgIp/XzKe2eKULBcLOzE
         G9jMBu9GHrInvGXr4XksTgyJVo0pJpG1vd4ZMZf4uvrsXeF+5mVceITvOr5Ik6R23L7t
         UApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDdExr3eMeEb1tazYUSHIAsXh6hcObg1zDJhekd64bE=;
        b=mW7EpRtXGFyM3lY518kXLYdHPRGfsDTjK+SlRqEb3XIRiNgrfiOet1g+5gjZ5iZMXs
         oYQF+4NdCvZo9xiYP14t2cgzyCjBg0YaMH+kJK4MgDlDGdRTjm6NfkiKrnSnRRmqn6Tc
         E7qzUCErNeF8ABCiycMASDqvyOIMO8hxZbY7ksSq6kTdH0PKFFN94HzDCCKE4whixgGO
         ssnmsKEZOiS4lbQff0Zz32sH1HNYsL0kNQsNZYxFnZGg0hZBHRn9wHHzaxQsEH9WdqT6
         xi6m49pFo3ZEG0BR9vFg8gBSjoAcUJF8FjfeosRNkTxXYICvQfuTB2tnHaJrOl2NfTCr
         B6VA==
X-Gm-Message-State: AOAM533dAydoTlBLxUXxm0vrXMLagMkhclttDtMHF1uDbPUJQRSsE/hU
        7ZXdsthkZ7U4zUul2dQmmXw=
X-Google-Smtp-Source: ABdhPJyClAOFYvXbE2+/BZt+JZke8ACa3LvbcdPcYbh0b1kCMjEVp8xPz1MeSkvc56P0EMP6EuX2kA==
X-Received: by 2002:a54:4494:: with SMTP id v20mr6150987oiv.95.1639697640115;
        Thu, 16 Dec 2021 15:34:00 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ec41-d089-dfdb-6fb5.res6.spectrum.com. [2603:8081:140c:1a00:ec41:d089:dfdb:6fb5])
        by smtp.googlemail.com with ESMTPSA id w19sm1253888oih.44.2021.12.16.15.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:33:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 2/8] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Thu, 16 Dec 2021 17:31:56 -0600
Message-Id: <20211216233201.14893-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233201.14893-1-rpearsonhpe@gmail.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
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

