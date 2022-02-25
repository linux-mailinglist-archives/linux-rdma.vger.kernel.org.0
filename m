Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C14C4F2B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiBYT7G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiBYT7F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:05 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D9118618
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:33 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so7786035ooq.6
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7z1CrrPDFelCiVuCs4oGuxcUzTg1Tz3vD006N0oE1c=;
        b=gfZnJxVBgKeJzMCmyAtxwxpaNub02WgUEjR3PuUjV+IoR1HByFfQnV/1hivEwRLZFw
         lh+FyGC8O4pe9CG9jlnJGGM4XkolmjtVbIZxFIsw3eloCSvq3Gu+u/fa3lScoCeiMPRp
         ZJZ5Y3GhRlat35ZatL0ZD5H/BinJDbBGxqAD8/VB2advuY5PwcS9usGJYZ6ITJawOTvX
         sNg1N0uLtc4PC0iMlh41DeMH5LIU31A31opWZPK4Afsmg715zYO3JvnXe/LBzF05HBcU
         ggCQniHb9qlJ+UYtaewPuNSMvzIG4V0t35oS8zseLYCes2/Bwp8pm6Y3S4RfEj89cfix
         cdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7z1CrrPDFelCiVuCs4oGuxcUzTg1Tz3vD006N0oE1c=;
        b=jOvvay2YGqXxXbhtVUaB1id0scIomT6nLigs6nL2Qmrz5hImJ5QLuUMyo/XOWlmAeQ
         pu11KQ8iJUkUPsNvqaoAd/jpLwCwAaOQqdpMrF4e7wDQwUwo3lngqkqUD2Y/uJXxsRHq
         ktA+S41ABi0L/NSfgUEAg9/1Gyny1ge3kH5ImZmxnFvs+WAohI6RK6WzZAPN/rhnMpty
         1Cg6zMqJEdG9OoXZG3HnbIE448WWEhFnugTpWiU72PKzLINLEEqVcmoTVzuLnyICcfBj
         gZF/tKoqo1accuce/xe2cyi2ABbg2kL954e+fGD87hHBWlJxDLyg84xtMUYwgXCKbdVv
         YWZg==
X-Gm-Message-State: AOAM5339+iw1N+MHTy3eUwEuDfGbGn6M3a+QQyolBAJgUQ2kn+/4AmFi
        sguQ69GqV68/OACohK3HbZGJUfsGAeA=
X-Google-Smtp-Source: ABdhPJxW8FFXD+iNUHl1pGZgu9XLf8+YfkdEsthY6X2RKqiwm1u/61Dh0X7mC9L11EHKiPx0BHCHkg==
X-Received: by 2002:a4a:d62b:0:b0:2e6:de0c:c737 with SMTP id n11-20020a4ad62b000000b002e6de0cc737mr3455503oon.39.1645819112443;
        Fri, 25 Feb 2022 11:58:32 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:32 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 05/11] RDMA/rxe: Stop lookup of partially built objects
Date:   Fri, 25 Feb 2022 13:57:45 -0600
Message-Id: <20220225195750.37802-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver has a security weakness due to adding
objects which are partially initialized to indices allowing external
actors to gain access to them by sending packets which refer to
their index (e.g. qpn, rkey, etc).

This patch adds a member to the pool element struct indicating whether
the object should/or should not allow looking up from its index. This
variable is set only after the object is completely created and unset
as soon as possible when the object is destroyed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    |  3 +++
 drivers/infiniband/sw/rxe/rxe_pool.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_pool.h  |  5 +++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 22 +++++++++++++++++++++-
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 35628b8a00b4..157cfb710a7e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -689,6 +689,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 	}
 
+	rxe_disable(mr);
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_ref(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 7df36c40eec2..e4d207f24eba 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -25,6 +25,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
 	spin_lock_init(&mw->lock);
 
+	rxe_enable(mw);
+
 	return 0;
 }
 
@@ -56,6 +58,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	struct rxe_mw *mw = to_rmw(ibmw);
 	struct rxe_pd *pd = to_rpd(ibmw->pd);
 
+	rxe_disable(mw);
 	spin_lock_bh(&mw->lock);
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index c298467337b8..19d8fb77b166 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -203,7 +203,7 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 	spin_lock_irqsave(&pool->xa.xa_lock, flags);
 	elem = xa_load(&pool->xa, index);
-	if (elem && kref_get_unless_zero(&elem->ref_cnt))
+	if (elem && elem->enabled && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 422987c90cb9..b963c300d636 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -29,6 +29,7 @@ struct rxe_pool_elem {
 	struct kref		ref_cnt;
 	struct list_head	list;
 	u32			index;
+	bool			enabled;
 };
 
 struct rxe_pool {
@@ -81,4 +82,8 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem);
 
 #define rxe_read_ref(obj) kref_read(&(obj)->elem.ref_cnt)
 
+#define rxe_enable(obj) ((obj)->elem.enabled = true)
+
+#define rxe_disable(obj) ((obj)->elem.enabled = false)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f0c5715ac500..077be3eb9763 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -150,6 +150,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_pd *pd = to_rpd(ibpd);
 
 	rxe_drop_ref(pd);
+
 	return 0;
 }
 
@@ -197,6 +198,9 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	}
 
 	rxe_init_av(init_attr->ah_attr, &ah->av);
+
+	rxe_enable(ah);
+
 	return 0;
 }
 
@@ -228,6 +232,8 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
+	rxe_disable(ah);
+
 	rxe_drop_ref(ah);
 	return 0;
 }
@@ -310,6 +316,8 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err2;
 
+	rxe_enable(srq);
+
 	return 0;
 
 err2:
@@ -368,6 +376,8 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
+	rxe_disable(srq);
+
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
@@ -439,6 +449,8 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		goto qp_init;
 
+	rxe_enable(qp);
+
 	return 0;
 
 qp_init:
@@ -495,6 +507,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
+	rxe_disable(qp);
 	rxe_qp_destroy(qp);
 	rxe_drop_ref(qp);
 	return 0;
@@ -807,9 +820,10 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
-	rxe_cq_disable(cq);
 
+	rxe_cq_disable(cq);
 	rxe_drop_ref(cq);
+
 	return 0;
 }
 
@@ -905,6 +919,8 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
+	rxe_enable(mr);
+
 	return &mr->ibmr;
 }
 
@@ -932,6 +948,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	if (err)
 		goto err3;
 
+	rxe_enable(mr);
+
 	return &mr->ibmr;
 
 err3:
@@ -964,6 +982,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (err)
 		goto err2;
 
+	rxe_enable(mr);
+
 	return &mr->ibmr;
 
 err2:
-- 
2.32.0

