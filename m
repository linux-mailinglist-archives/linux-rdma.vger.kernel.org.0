Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62236249390
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHSDn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgHSDn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:43:28 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1263BC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:43:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so19888800oid.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juJfX/gqaYFk5ct/d6Vp6z9eCFpFK5TQej96UmJucQE=;
        b=hR037aZ/1BtXq/yD6F/EdH5NOJnVa5VHIkUesXgUdnSxWzp9LhHoU3oXzDlFwIfygy
         Egg4/Lw9TDHOQBpwwSnhjWukA+gQtcBNy+TESxhJ3IB4ZsQSwGyllnSXZeGTlha6fipc
         tYML6FLH0DP7Iw+jAAtsZKUPsGuiksXs86ICOzLTzIL+NzzlNeOYw0BrdThBv311SVzf
         MPF+NCb2gifQlG0JnsoGxvz6DhEBF3WwgYPRYCQlCTwpgga8eU7D8iRDT9xTpdvhAFrQ
         nSHplucoAUwin9Xezwl0s54T+BL+IPAd0hKejFzmLqvWrh2S+A83TTYG9D/7/47n8DIH
         bEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juJfX/gqaYFk5ct/d6Vp6z9eCFpFK5TQej96UmJucQE=;
        b=PpVlc7cbnW1YAd7ctSdQgyJVTLCzDfqEAIM4EmVb1JB0OnG7DV6pmFMpheXoBr+Gp4
         1Jf7TnMZE6ke9eGp7TMxp1JtBJq1wUhx03x2GlNVrtroZexSe4pMRq+kmXfaTwp5h97H
         GfM4OVL4pyJgQ+cg2kzzQxVNJzyboQLpNepnFo0MfzVgFHpzPSH8CxV1GkxIf25kKxSb
         oywnLGm0Xz1LTYjit+Wj0pa/6qoFmY100N7gUauchgbTGGbcjngYd/HxOR7bcxcIWlf0
         e3TjtyGitvmnRl9QpxqLS1rJDvIiYKkBYPstHlc1HYZ2QVB5S7ZooJHOy54Fu8IQjDLU
         YPpQ==
X-Gm-Message-State: AOAM533V80CMzK6+SMeGayclGu5ofqxcqkJqiPRrN3BX3kbCxddZMyvN
        IFrmz2hlK0SZPcRhsP8mx30=
X-Google-Smtp-Source: ABdhPJzdQAZ8wKxu/tQN2F9VTi5lWhKmq+EL4jGfVtGHNN3gOHnT41e7xa1H6bm59t1r8mtiDD3Aww==
X-Received: by 2002:aca:3ac3:: with SMTP id h186mr2058338oia.44.1597808607529;
        Tue, 18 Aug 2020 20:43:27 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id x9sm4447037ood.45.2020.08.18.20.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:43:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 10/16] rdma_rxe: Implemented functional alloc_mw and dealloc_mw APIs
Date:   Tue, 18 Aug 2020 22:40:06 -0500
Message-Id: <20200819034002.8835-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Created basic functional alloc_mw and dealloc_mw funnctions.
This change supports running user space test cases for these APIs.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c    | 55 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 +++
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index f5df5e0b714f..ea8510044fbe 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -8,15 +8,62 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* this temporary code to test ibv_alloc_mw, ibv_dealloc_mw */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata)
 {
-	pr_err_once("%s: not implemented\n", __func__);
-	return ERR_PTR(-EINVAL);
+	struct rxe_pd *pd = to_rpd(ibpd);
+	struct rxe_dev *rxe = to_rdev(ibpd->device);
+	struct rxe_mw *mw;
+	u32 rkey;
+
+	if (unlikely((type != IB_MW_TYPE_1) &&
+		     (type != IB_MW_TYPE_2)))
+		return ERR_PTR(-EINVAL);
+
+	rxe_add_ref(pd);
+
+	mw = rxe_alloc(&rxe->mw_pool);
+	if (unlikely(!mw)) {
+		rxe_drop_ref(pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* pick a random rkey for now */
+	get_random_bytes(&rkey, sizeof(rkey));
+
+	rxe_add_index(mw);
+	rxe_add_key(mw, &rkey);
+
+	spin_lock_init(&mw->lock);
+	mw->qp			= NULL;
+	mw->mr			= NULL;
+	mw->addr		= 0;
+	mw->length		= 0;
+	mw->ibmw.pd		= ibpd;
+	mw->ibmw.type		= type;
+	mw->ibmw.rkey		= rkey;
+	mw->state		= (type == IB_MW_TYPE_2) ?
+					RXE_MEM_STATE_FREE :
+					RXE_MEM_STATE_VALID;
+
+	return &mw->ibmw;
 }
 
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
-	pr_err_once("%s: not implemented\n", __func__);
-	return -EINVAL;
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+	mw->state = RXE_MEM_STATE_INVALID;
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(pd);
+	rxe_drop_index(mw);
+	rxe_drop_key(mw);
+	rxe_drop_ref(mw);
+
+	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f9f16e7ed0f7..5679714827ec 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -61,7 +61,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 	},
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a7686772a6fc..52db82c27cf9 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -445,6 +445,11 @@ static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
 	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
 }
 
+static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
+{
+	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-- 
2.25.1

