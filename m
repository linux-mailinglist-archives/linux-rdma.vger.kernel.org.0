Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F5D360026
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDOCzc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOCzc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4052C061756
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h19-20020a9d64130000b02902875a567768so10326467otl.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vp6xriMH+7v1tA+VRuha1iuDW3PIDThhJEhCSAZ0Alw=;
        b=P6xTA8WBBYnQuPcz6rofcJaFbc8+T/gf+3lcrPgblZFUMi5EaeSEIuEZqEv3gRYJse
         crzP9uU7Jpq74Qd392Jwr4hUPLmgrPmjKlXUUhe+wWT7PYB/yEfXKvqk6pSaNsw4dYbz
         2YdzjP0z0+DdWYhDjeQbItilggRAqWBm3wTHXUWaUmx/LmEEsuhfYPzISVhoxhDMbs3z
         AG5qe6N5p5SsvTN8W69VAiAAEVzTrNav8BU93TcIk6BJrh9V0I8DuewX65BeVsOy+Oou
         dcFHuWE7RkaMv8JrR3JkdMOZabazBF3p3fswRDazQDcx2lB9CRBqBnZFcLFg083hh44J
         Mw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vp6xriMH+7v1tA+VRuha1iuDW3PIDThhJEhCSAZ0Alw=;
        b=F0DbpfARQK4SvK5wIBUw5Qe43/f//u16CPCMP+MRz6Ryj8L4ufoxmwtSxzcYV3hBF2
         joQzSVogg1gkI+2qO5++G6X2nO1lcATzg8geg6FQ3333xxvhVpw0WBJv2lvE4lJxWkS8
         PX+h1gksS/OoScXIO+yjhnm41BW82ANVUISQQ7jJ6IKDQeLeFP++6Wx2WV0r5LaEwDW1
         1UbpQqcQ4b/SqFsc0v2igiEC44cTlHlAN2SqET0HjeW7o7iAStAuJWYDUBZGVHvnhaf0
         8AoMMhS0aFJb8VRyp4xvqp27deAYBCNEndt2WnyJ7AkS7cvIrISjGXtznEUGfen09ZA7
         XeHQ==
X-Gm-Message-State: AOAM530nsZ7rSdO+inthoC5JaCnWex+mgUYBpdOL+VwR69pYFUfp8jZm
        WibkoGT/LmLHpo3hhKGwR5I=
X-Google-Smtp-Source: ABdhPJxl65es7Cpmu0RGSaTO6/vOmUhj0oTCVdZ2r8fB3qvHPT/NTOwfxiIfU4QHuGqu3Gwi9yXrLQ==
X-Received: by 2002:a05:6830:c5:: with SMTP id x5mr812119oto.317.1618455309386;
        Wed, 14 Apr 2021 19:55:09 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id o2sm356954oti.30.2021.04.14.19.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 4/9] RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
Date:   Wed, 14 Apr 2021 21:54:25 -0500
Message-Id: <20210415025429.11053-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210415025429.11053-1-rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
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

