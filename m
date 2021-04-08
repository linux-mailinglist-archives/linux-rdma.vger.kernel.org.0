Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE68358F5B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhDHVlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHVlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B1C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so3762051otq.8
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMSKB62kjFCwbjvoRuLqyvFvCpv3NqLvMaUYcdnk1LQ=;
        b=eft6QqpMw7+frIkCdLKNqYUDNGeeLYOMJ7t8NP6mk7UIXd8EQ3lFvt3fNu6iEJZfyv
         hHknQaCTpBiIRQpMktaus8kb3sYYGA7rq1bh7anG/rnEbyOEZuChR5TKMEFDzsvIRo6g
         a1VC+07YqWQCnsNY7avxQbt6kg4GMW/iApMeMvmYLFnX5Z1v2+0nGAu1NUUm4jle0mHf
         J70N3MgbEdXmMRDU6CNo54G4DQqge6RYqtyxd/hZe/tCkxYvYPaPy54jF3RjgnVvKa6z
         lSiyDnZr8v2H0pnajlDHF/xlUA4MFUvF/M1NK3W7TiuQt9KYtZ5S3Z2tOmLpE0YdA+g/
         bVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMSKB62kjFCwbjvoRuLqyvFvCpv3NqLvMaUYcdnk1LQ=;
        b=D7Jv3BJhPyZtMq3VCimZI1BQ1Bnwc1FW+cloEb3Hjw1rW4b6x37LQb2ZF+gyxaNULK
         511rq/o8pwapx2wtSh/HIv79Y4rT32FoeAYGI0PsJhad/yCCGH7j5Ge27mxTVKda2E8D
         PA3pelzCCEVNLX7qEs8bjXAXteS3X8ILzNp64EYnGdCbuTXbabHh9nK0ZnFPQdr8AN+K
         rKNh0KKWK/GXQlQCdR7Gcnmqhn3byiMl3w+e0Daf7RI+E+SuaRCspaoqWXyfH1UQAf5T
         p+yW1uy971uI4KFiVWHWXWH+Y8+hRBI3FU0ux6b0QfZFsQpZMpIX4ynU2EQxgwmrcnQj
         8lLA==
X-Gm-Message-State: AOAM530Sv9Qob26WTwEi810NdTkQVWNVu9c3HRboHVFWeb/kY7PZW82r
        BLVpyhHleo5kFVCZfKvzcUg=
X-Google-Smtp-Source: ABdhPJy8fD+MCx9vgvTeTN+ZyqKdsNnRM3fWkLr7vHmVQ5Ic4nmiOPR6B3Yq7F4eOEndiKT0AZAmXg==
X-Received: by 2002:a9d:202c:: with SMTP id n41mr9385867ota.289.1617918065814;
        Thu, 08 Apr 2021 14:41:05 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id 7sm138758ois.20.2021.04.08.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:05 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 4/9] RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
Date:   Thu,  8 Apr 2021 16:40:36 -0500
Message-Id: <20210408214040.2956-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ib_alloc_mw and ib_dealloc_mw verbs APIs.

Added new file rxe_mw.c focused on MWs.
Changed the 8 bit random key generator.
Added a cleanup routine for MWs.
Added verbs routines to ib_device_ops.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/Makefile    |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++
 drivers/infiniband/sw/rxe/rxe_mr.c    | 20 +++++-----
 drivers/infiniband/sw/rxe/rxe_mw.c    | 53 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.c  |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  3 ++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
 7 files changed, 75 insertions(+), 11 deletions(-)

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
index ef8061d2fbe0..edf575930a98 100644
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
index 9f63947bab12..7f2cfc1ce659 100644
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
index 2b795e2fc4b3..5b3277e8c35d 100644
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
index aeb5e232c195..fff81bf78a86 100644
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
@@ -1106,6 +1108,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
 	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
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
2.27.0

