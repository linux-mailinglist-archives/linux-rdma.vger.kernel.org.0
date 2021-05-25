Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C91390BA1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhEYVkE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhEYVkE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:04 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04016C06175F
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:33 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so7521391ooa.5
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gvD+eDtxHWqWm0I2JlMrE06qVaL088iwj9Q2nGSlMA=;
        b=UCk6XucpzXNnjmNpmHsSYHN3S4pK6Fjf9zijZXZ09l/k5qqWYLaTCZGwLBHT6X9pvf
         oO9KHQVqIMZjrkQIlx+9L+uqjihCQOVTj+DlWivLy0meDqc0LcCE7q/MaZSff9QzBjZq
         bzeCeQ43DSPf+LIxu2D1GsaOovxpFL7bE3KI/mnP1UJdcAEB5OU0ImSld/xyivo1DGKH
         VgJbtEKENrtfZKEFKyFzVsH8Pq63MXTFyuzRSFm8h+J0CfWQPFFYQDU7e2KyKcY2BCpi
         wr/OFuWSYzmMugf4Ex2A7ypNVz2iMQqElOUJJ4jwx+wVtvv9Qam+xIFWm0wG5sMdjx0a
         ts5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gvD+eDtxHWqWm0I2JlMrE06qVaL088iwj9Q2nGSlMA=;
        b=GQ1EZ1A5aiTbJl9VMHh3n/89RNeZMlaQd8TD7HVjGE/MMuPYzLNwnrNhagGvIK+21W
         wueEgvZu5sUeeTRME14WWvLKrKJoH/wWGeHXXBNIyeBToKIfgv4DVhT9/G58RkEAp6x4
         CrWvx48gCBgAHLDoaWf2Jztnjs+7J55AHb9FMqGkeHnVvU3lxdTSLcCXRtaSrF19jScG
         EWYyKcnFbS7b9xLsCvUWGWTQfpPPb73jIgQ9+bdIq/uIDerFgyPA5sS5fxIWTwcRZrg/
         YOzPDkhErmEsiSClW19PpvtJlp2qGsXsdeSqA01fFoa0cRHY2+z0f7z665orHWDOz7RV
         ce/Q==
X-Gm-Message-State: AOAM531xWy7B8JXfhsx4DYwVqoM9xulvDK/GDJLYMIw8UjG8FrCS8Pum
        BLxyjpaax5iJdwwNvcmwdwoWdnJz4qqDEQ==
X-Google-Smtp-Source: ABdhPJxC4jkyC7DRSFn/Yw1VZ16USLSCq0yZatu7rZ1iLqDc5Euki30eLcQBdFdAZDqsJDDghUvYKA==
X-Received: by 2002:a4a:952b:: with SMTP id m40mr23869729ooi.69.1621978712382;
        Tue, 25 May 2021 14:38:32 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id j20sm3610105oot.29.2021.05.25.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v8 04/10] RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
Date:   Tue, 25 May 2021 16:37:46 -0500
Message-Id: <20210525213751.629017-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ib_alloc_mw and ib_dealloc_mw verbs APIs.

Added new file rxe_mw.c focused on MWs. Changed the 8 bit random key
generator. Added a cleanup routine for MWs. Added verbs routines to
ib_device_ops.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v7:
  Removed duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
  This was already added in patch 03/10.
Reported-by: Jason Gunthorp <jgg@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/infiniband/sw/rxe/Makefile    |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++
 drivers/infiniband/sw/rxe/rxe_mr.c    | 20 +++++-----
 drivers/infiniband/sw/rxe/rxe_mw.c    | 53 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.c  |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
 7 files changed, 74 insertions(+), 11 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 66af72dca759..1e24673e9318 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -15,6 +15,7 @@ rdma_rxe-y := \
 	rxe_qp.o \
 	rxe_cq.o \
 	rxe_mr.o \
+	rxe_mw.o \
 	rxe_opcode.o \
 	rxe_mmap.o \
 	rxe_icrc.o \
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b21038cb370f..422b9481d5f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -76,6 +76,7 @@ enum copy_direction {
 	from_mr_obj,
 };
 
+u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
 
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
@@ -106,6 +107,11 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
+/* rxe_mw.c */
+int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
+int rxe_dealloc_mw(struct ib_mw *ibmw);
+void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 373b46aab043..cfd35a442c10 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -7,19 +7,17 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/*
- * lfsr (linear feedback shift register) with period 255
+/* Return a random 8 bit key value that is
+ * different than the last_key. Set last_key to -1
+ * if this is the first key for an MR or MW
  */
-static u8 rxe_get_key(void)
+u8 rxe_get_next_key(u32 last_key)
 {
-	static u32 key = 1;
-
-	key = key << 1;
-
-	key |= (0 != (key & 0x100)) ^ (0 != (key & 0x10))
-		^ (0 != (key & 0x80)) ^ (0 != (key & 0x40));
+	u8 key;
 
-	key &= 0xff;
+	do {
+		get_random_bytes(&key, 1);
+	} while (key == last_key);
 
 	return key;
 }
@@ -47,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
+	u32 lkey = mr->pelem.index << 8 | rxe_get_next_key(-1);
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
 	mr->ibmr.lkey = lkey;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
new file mode 100644
index 000000000000..69128e298d44
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ */
+
+#include "rxe.h"
+
+int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
+{
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	struct rxe_dev *rxe = to_rdev(ibmw->device);
+	int ret;
+
+	rxe_add_ref(pd);
+
+	ret = rxe_add_to_pool(&rxe->mw_pool, mw);
+	if (ret) {
+		rxe_drop_ref(pd);
+		return ret;
+	}
+
+	rxe_add_index(mw);
+	ibmw->rkey = (mw->pelem.index << 8) | rxe_get_next_key(-1);
+	mw->state = (mw->ibmw.type == IB_MW_TYPE_2) ?
+			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
+	spin_lock_init(&mw->lock);
+
+	return 0;
+}
+
+int rxe_dealloc_mw(struct ib_mw *ibmw)
+{
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+	mw->state = RXE_MW_STATE_INVALID;
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(mw);
+	rxe_drop_ref(pd);
+
+	return 0;
+}
+
+void rxe_mw_cleanup(struct rxe_pool_entry *elem)
+{
+	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
+
+	rxe_drop_index(mw);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index df0bec719341..0b8e7c6255a2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -65,6 +65,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, pelem),
+		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 86a0965a88f6..552a1ea9c8b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1060,6 +1060,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 
 	.alloc_hw_stats = rxe_ib_alloc_hw_stats,
 	.alloc_mr = rxe_alloc_mr,
+	.alloc_mw = rxe_alloc_mw,
 	.alloc_pd = rxe_alloc_pd,
 	.alloc_ucontext = rxe_alloc_ucontext,
 	.attach_mcast = rxe_attach_mcast,
@@ -1069,6 +1070,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.create_srq = rxe_create_srq,
 	.create_user_ah = rxe_create_ah,
 	.dealloc_driver = rxe_dealloc,
+	.dealloc_mw = rxe_dealloc_mw,
 	.dealloc_pd = rxe_dealloc_pd,
 	.dealloc_ucontext = rxe_dealloc_ucontext,
 	.dereg_mr = rxe_dereg_mr,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 8d32e3f50813..c8597ae8c833 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -323,6 +323,8 @@ enum rxe_mw_state {
 struct rxe_mw {
 	struct ib_mw ibmw;
 	struct rxe_pool_entry pelem;
+	spinlock_t lock;
+	enum rxe_mw_state state;
 };
 
 struct rxe_mc_grp {
-- 
2.30.2

