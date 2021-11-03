Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56908443C55
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhKCFGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhKCFGQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89357C06120A
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:40 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id bo10so2103823oib.5
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQur05zaEpFEq7VAvU0JBIWZOuMyCU7IZ3DSI9pMe3c=;
        b=IwoZdS5q0d91pX4ofqTZV42H5732jXq/6dblLOO8Teo8ne1cey5KP5hRE1yMO7Y331
         ptKLtIq3V5y0lC9xU6+tTaS0sEoputd/04VkZAMVTZqja5++aVok3ODwpMykUb2KIJd3
         B+yc4VIjPrIjdGjJ3QUoMxcZOia++5HZggIrc9JeRe2LXbUCeZ8ds/9O2IAVSn/s531M
         E1GpdpxffQvEz92hklwulyOsSNamL+zdlMOYYPYVh96ttHc8abxf0/i0NBkNxiVeV8Ux
         5/aL8KWyk7aS8tF6cSuYZ/GP/vzEwp5BYs0NtsgwwsZ3HnyLZQxCecJKwparsMsdpvJH
         h+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQur05zaEpFEq7VAvU0JBIWZOuMyCU7IZ3DSI9pMe3c=;
        b=G3dJDRgybFIgMTZEhLCR/X3tLFaLG5MpNg8PuzGlKOHr2BtwzPmfHowB/jvsr1PAW3
         ZG22h8/j9378Y2bMM4RmCRLr4IHN6NnXiOSeWTK/ONNdxdAlPZRaCGhxH04k0f/bQUA1
         x7CS27cEPZh5y1i0DTCTV9VhULyrPXLsBUDnje3Hql3oJ9OIAaM4+4bLW6IwxRG/j15i
         T7v+DW6a2gBncyoKhne59niq71u49F0NGbjdg1U8xHP7ZrPiklrVlB39o2Fmozw18eMQ
         pSlisfniU1xF8bKfI+Q3Nzg8xnQt943T11gQm5IlMVLHa9mjxO+9eXOliJNLz+ZyNc9J
         vI2g==
X-Gm-Message-State: AOAM530V6n0W80WSJXicUmcasIhicsbQ+vDGTXQ0dXZ0hYWCGwWpZKG7
        i7bVjYKUUjYZ84nx3wsdecwHyI5m8Tg=
X-Google-Smtp-Source: ABdhPJzqX9b/O/kgnZFJ400ATw75UllJAlOZgzbkk8tPhW1ujHIwTLqNigVx0k5fiJA62QPHj5Wx5A==
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr8841099oiv.160.1635915819995;
        Tue, 02 Nov 2021 22:03:39 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v4 for-next 08/13] RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
Date:   Wed,  3 Nov 2021 00:02:37 -0500
Message-Id: <20211103050241.61293-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
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
index 05d56becc457..6fa524efb6af 100644
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
 
@@ -322,7 +320,7 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+	if (pool->flags & RXE_POOL_ALLOC) {
 		obj = elem->obj;
 		kfree(obj);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 64e514189ee0..7299426190c8 100644
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
2.30.2

