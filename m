Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDF6CB113
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Mar 2023 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjC0V6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Mar 2023 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0V6b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Mar 2023 17:58:31 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2FD9
        for <linux-rdma@vger.kernel.org>; Mon, 27 Mar 2023 14:58:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id f17so7523483oiw.10
        for <linux-rdma@vger.kernel.org>; Mon, 27 Mar 2023 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679954310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJbC3amH2usvxUb+PHi8URcxDNrtoOELJGZQTyZ9fEs=;
        b=EuY3mIE2PnS8Wqdjg9Ks37K/mNoEwkkQ98nppGG8mWi4pqxzT6MkKwz5ubymztyjv4
         EnSCPP/gFYfzT2M66gnQ9SdGRQn62AO0lOp2fVi06UsEQssh/hY/GZ/Y2IH10kLZ3slN
         lD69Ao+3psD5XFvoY7SZ6oU6GHSgDhTA75ifQcWUCxvWZL+UbOe4up6vtTGDe598JN9F
         bT+PQEGVGq0/IGxO/QG4A6syh1dMgLMQz7Zf3kWTHsRhEcu+UA+pe1QlOTeY9naXlXy+
         nZUaI9x2padrGBETMcMqhnajKAAoimPN/5kKuFGwUHGPLC/5iVBipz+3rRQQClNKhjlG
         XvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679954310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJbC3amH2usvxUb+PHi8URcxDNrtoOELJGZQTyZ9fEs=;
        b=t855aLfxsV18Fk2ODUJ3s5NUg8dLStndDmoX48yAhRMCGlPXmbk0Lrjhax4d6Pp8E9
         kfhpkyUEWTTr+vysNBdLzDFOvnq1Wyl29tW/9j/bGyrThR0YiqM5fRS0UYa77CbL5Jnz
         soAFjPsxevY2VMtdM8t9uCSYXorNcJTaru8eP5buP+BuoQze6QTlZhpnhwSdgo0siv9J
         /8FeoCme7dtOr5vg7WpYLM+W5QimQh0yR/0YJH/9JCnZcP0AMgEVBRRC96sEoPZaUDxM
         jhhviNzgmEBMyN71wwsZ1oq+C6Uyw6Qhwgdo6uR2/4w6M4ZAmke8g+pt+4cELUEIhclL
         wHjw==
X-Gm-Message-State: AO0yUKWcHDXtWDm78RYZQJQd2OWij9IrBAZShrsNsiYuOKtpa3J3u1k6
        9nOzY4PQPURR+u3oRiHRFzFY32/oHX8=
X-Google-Smtp-Source: AK7set8LCsjbTF2tQrXTvYHaOlpUeAFeLYBeyn/kBCe8bZWpqNHntzfoiskmnPneHAN/PmEBmy58Zw==
X-Received: by 2002:a05:6808:347:b0:386:c879:d3ae with SMTP id j7-20020a056808034700b00386c879d3aemr9785959oie.10.1679954310026;
        Mon, 27 Mar 2023 14:58:30 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-2c78-b015-8039-f06c.res6.spectrum.com. [2603:8081:140c:1a00:2c78:b015:8039:f06c])
        by smtp.gmail.com with ESMTPSA id r138-20020acaa890000000b00387367989d7sm6411402oie.23.2023.03.27.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:58:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, BMT@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Remove tasklet call from rxe_cq.c
Date:   Mon, 27 Mar 2023 16:56:44 -0500
Message-Id: <20230327215643.10410-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the tasklet call in rxe_cq.c and also the is_dying in the
cq struct. There is no reason for the rxe driver to defer the call
to the cq completion handler by scheduling a tasklet. rxe_cq_post()
is not called in a hard irq context.

The rxe driver currently is incorrect because the tasklet call is
made without protecting the cq pointer with a reference from having
the underlying memory freed before the deferred routine is called.
Executing the comp_handler inline fixes this problem.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 32 +++------------------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 --
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 66a13c935d50..20ff0c0c4605 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -39,21 +39,6 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	return -EINVAL;
 }
 
-static void rxe_send_complete(struct tasklet_struct *t)
-{
-	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
-	unsigned long flags;
-
-	spin_lock_irqsave(&cq->cq_lock, flags);
-	if (cq->is_dying) {
-		spin_unlock_irqrestore(&cq->cq_lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-
-	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-}
-
 int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     int comp_vector, struct ib_udata *udata,
 		     struct rxe_create_cq_resp __user *uresp)
@@ -79,10 +64,6 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	cq->is_user = uresp;
 
-	cq->is_dying = false;
-
-	tasklet_setup(&cq->comp_task, rxe_send_complete);
-
 	spin_lock_init(&cq->cq_lock);
 	cq->ibcq.cqe = cqe;
 	return 0;
@@ -103,6 +84,7 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
 	return err;
 }
 
+/* caller holds reference to cq */
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
 	struct ib_event ev;
@@ -136,21 +118,13 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		tasklet_schedule(&cq->comp_task);
+
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 	}
 
 	return 0;
 }
 
-void rxe_cq_disable(struct rxe_cq *cq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cq->cq_lock, flags);
-	cq->is_dying = true;
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-}
-
 void rxe_cq_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_cq *cq = container_of(elem, typeof(*cq), elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 84b53c070fc5..090d5bfb1e18 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1178,8 +1178,6 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	rxe_cq_disable(cq);
-
 	err = rxe_cleanup(cq);
 	if (err)
 		rxe_err_cq(cq, "cleanup failed, err = %d", err);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 84994a474e9a..dab6fa305bf2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -63,9 +63,7 @@ struct rxe_cq {
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
 	u8			notify;
-	bool			is_dying;
 	bool			is_user;
-	struct tasklet_struct	comp_task;
 	atomic_t		num_wq;
 };
 
-- 
2.37.2

