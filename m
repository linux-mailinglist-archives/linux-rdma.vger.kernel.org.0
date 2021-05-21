Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7911E38CECE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhEUUUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhEUUUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:39 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C4C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c196so12601977oib.9
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gvD+eDtxHWqWm0I2JlMrE06qVaL088iwj9Q2nGSlMA=;
        b=b5YcPZ1Egqyk6IRXWEL9eShNp1pkG/oflM3GCXGolgDzEVKQ5p8s4QHrOWZ5QmI/aA
         EpG5cytPzVrrA1lllwIQ0MBCBZZ1MKhyYJu0G7W9L+Wp2B11lq92/yXnUZSWRt06n9h2
         KkAHJrjZrh9l2Yun5YppS/Hl16zIabIzau3jNVJ0fJ2S/Wuo1kTUa6KufWX/TXQTKlxj
         aNbo8wGtmp5IegQJ5O4tLP9HSL5QAdksE8GxkClMa7MWkOy4GAN94Iy2qwrpuMJyup7Q
         Xp1RHwx577O+gsh1S4JYVO1TFsA0njg7oYT/iDCvYkDTNvYXEfexDdEIrBf5qYf6IG6+
         dhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gvD+eDtxHWqWm0I2JlMrE06qVaL088iwj9Q2nGSlMA=;
        b=diIr52VrrExcikqF0ZLqSMLzAV7ctDxcWo4BG1Bvb3hAvifSFyyjLhIpqwuHjkdrb8
         JaAi+d4JuYQcEPZ4mRWS7XKSX3o8uHcfKKXF4yUSViwa9Z33DOQQ5+sh9WW4eEiw2neJ
         DnpTuf4ERIAl7pmad5dXlmC6mXcR6xd8HOibO7o35GOVH3yhSy8enU60SskJXmNikC/P
         3OvUw7g+6CyMi6HJeIf7S85kgxT1PjVDqONxlqpgiCzDA59XLFdFOvHcXSeP9+0jjPvo
         lCb/2DyelcilzzQq/rQVKUrfj6JmOFyOfY90YoDvRKvS5qOYRiYg5qdL4g8kkXQ/vC2w
         MxVg==
X-Gm-Message-State: AOAM531lJs5DgOBBerIULpTEiFgFKY2LP9k1lehBxDL/Z31z2SsrxLcA
        sdvIiKSXl8ZZ+a9f48UevJo=
X-Google-Smtp-Source: ABdhPJzS7mENKiDOtaVExy4/RUSZ/baGbRxxspLLsPLv1YOfYX913XMlRzoe1NGXD2s+TD6CTbfqYw==
X-Received: by 2002:aca:dd86:: with SMTP id u128mr3494865oig.155.1621628355431;
        Fri, 21 May 2021 13:19:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id f2sm1450015otp.77.2021.05.21.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v7 04/10] RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
Date:   Fri, 21 May 2021 15:18:19 -0500
Message-Id: <20210521201824.659565-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
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

