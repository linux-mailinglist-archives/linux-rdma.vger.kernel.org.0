Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA44245364
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgHOWA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgHOVvd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:33 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D78C0612A5
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o21so9985683oie.12
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHoZbA1tC1xepQAj2KQqj/5mC7x+Sm/ybnYQAjWhwzc=;
        b=RrK7fBzOw7k0JLH6TKSKXov550rKzh/2y+xULwZjkjWYuA51PJXukE6zZ/+LBkYcLO
         UR+qmMgtvbHxDSjXPZZvK8iuiXZw2KmLYTBuexfvKAG3H1HLb3ZOmnY9Lpa+gj8Ymhad
         4z2EJrYg6x3I7/Tem27gVvUXE+OY6kmeJcN0evE6oKuYKpIzs6KFPqLvSIBnXd2TW7ir
         4d2PW2WEdzg8c5WHCs8dQ5/6GuYT2pT2OPUfQDOqYv6qez2ZKfRoDD8hiLejCMbFo3Km
         sC1mQC9BGhAu8YKsgnmqfhEGd1I6eKekb28ZOEEGJSH1Avrw+MOFTf930vorGGLA1MwE
         7kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHoZbA1tC1xepQAj2KQqj/5mC7x+Sm/ybnYQAjWhwzc=;
        b=OXu26F8ZyDjyhN9J6q2XRaqoEd0FOOZ4mWJwJG9Yt0EerKREQCBIbIIUsxlIkN+oL7
         SiA4AIhw8OhvAgcPEIAGHUdAtOZHy8rYSnps31pNYEdbKOrBQoDWkWocESUdLIrnjeWH
         u3J4d7YOOuZI26IfY7MSHFlAM3MIcSxW7Fj6LBzqFgkl9xJae9bXyL/jnMU7EbbKGr8n
         Ixu00yT8lImcZqbfWKfXA1RjxLAAbyn402ivFL9kYLEawgj3WTCZMI1M1KtPVEIgFG4b
         WrPVxvCK368V5b6BiAjL1jaeAW59FXHRF38eYnwrST89F6zc/Y+tDh60EtCY3Iul6odK
         XQ/g==
X-Gm-Message-State: AOAM531FdMgVjesLbYlzrtdRP3oo4Qr4D7AV+/MSxQKpJD8WF02fGrvM
        LcmyWLdHiSlrGsAoPWjrECq5R6r6f7FPew==
X-Google-Smtp-Source: ABdhPJyYy5p/9KCqIM1Rd0LNw4Q5J8FJe1uDIhU/514wtjm83kewXjCu9mROKihnNrZhgahni8UFFQ==
X-Received: by 2002:aca:eb84:: with SMTP id j126mr3564707oih.30.1597467597653;
        Fri, 14 Aug 2020 21:59:57 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id l128sm2194872oib.4.2020.08.14.21.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:57 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 07/20] Implemented functional alloc_mw and dealloc_mw APIs
Date:   Fri, 14 Aug 2020 23:58:31 -0500
Message-Id: <20200815045912.8626-8-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Created basic functional alloc_mw and dealloc_mw funnctions and
changed the parameters in rxe_param.h so that MWs can actually
be created. This change supported running user space test cases
for these APIs.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    | 57 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_param.h | 10 +++--
 drivers/infiniband/sw/rxe/rxe_pool.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  4 ++
 5 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 907203afbd99..25bd25371f8e 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -79,6 +79,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_cq			= RXE_MAX_CQ;
 	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
 	rxe->attr.max_mr			= RXE_MAX_MR;
+	rxe->attr.max_mw			= RXE_MAX_MW;
 	rxe->attr.max_pd			= RXE_MAX_PD;
 	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 6139dc9d8dd8..50cd451751b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -35,15 +35,64 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* place holder alloc and dealloc routines
+ * need to add cross references between qp and mr with mw
+ * and cleanup when one side is deleted. Enough to make
+ * verbs function correctly for now */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata)
 {
-	pr_err_once("rxe_alloc_mw: not implemented\n");
-	return ERR_PTR(-ENOSYS);
+	struct rxe_pd *pd = to_rpd(ibpd);
+	struct rxe_dev *rxe = to_rdev(ibpd->device);
+	struct rxe_mw *mw;
+	u32 rkey;
+	u8 key;
+
+	if (unlikely((type != IB_MW_TYPE_1) &&
+		     (type != IB_MW_TYPE_2)))
+		return ERR_PTR(-EINVAL);
+
+	rxe_add_ref(pd);
+
+	mw = rxe_alloc(&rxe->mw_pool);
+	if (!mw) {
+		rxe_drop_ref(pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* pick a random key part as a starting point */
+	rxe_add_index(mw);
+	get_random_bytes(&key, sizeof(key));
+	rkey = mw->pelem.index << 8 | key;
+
+	spin_lock_init(&mw->lock);
+	mw->qp			= NULL;
+	mw->mr			= NULL;
+	mw->addr		= 0;
+	mw->length		= 0;
+        mw->ibmw.pd		= ibpd;
+        mw->ibmw.type		= type;
+        mw->ibmw.rkey		= rkey;
+	mw->state		= (type == IB_MW_TYPE_2) ?
+					RXE_MW_STATE_FREE :
+					RXE_MW_STATE_VALID;
+
+	return &mw->ibmw;
 }
 
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
-	pr_err_once("rxe_dealloc_mw: not implemented\n");
-	return -ENOSYS;
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+	mw->state = RXE_MW_STATE_INVALID;
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(pd);
+	rxe_drop_index(mw);
+	rxe_drop_ref(mw);
+
+	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 2f381aeafcb5..7f914dde98a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -85,7 +85,8 @@ enum rxe_device_param {
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
-	RXE_MAX_MR			= 256 * 1024,
+	RXE_MAX_MR			= 0x40000,
+	RXE_MAX_MW			= 0x40000,
 	RXE_MAX_PD			= 0x7ffc,
 	RXE_MAX_QP_RD_ATOM		= 128,
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
@@ -114,9 +115,10 @@ enum rxe_device_param {
 	RXE_MAX_SRQ_INDEX		= 0x00040000,
 
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00040000,
-	RXE_MIN_MW_INDEX		= 0x00040001,
-	RXE_MAX_MW_INDEX		= 0x00060000,
+	RXE_MAX_MR_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR - 1,
+	RXE_MIN_MW_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR,
+	RXE_MAX_MW_INDEX		= RXE_MIN_MW_INDEX + RXE_MAX_MW - 1,
+
 	RXE_MAX_PKT_PER_ACK		= 64,
 
 	RXE_MAX_UNACKED_PSNS		= 128,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ba002fed8051..32b86a9979e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -85,7 +85,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
-		.size		= sizeof(struct rxe_mr),
+		.size		= sizeof(struct rxe_mw),
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6a4486893b86..ebe4157fbcdd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -358,7 +358,11 @@ struct rxe_mw {
 	struct ib_mw		ibmw;
 	struct rxe_qp		*qp;	/* type 2B only */
 	struct rxe_mem		*mr;
+	spinlock_t		lock;
 	enum rxe_mw_state	state;
+	u32			access;
+	u64			addr;
+	u64			length;
 };
 
 struct rxe_mc_grp {
-- 
2.25.1

