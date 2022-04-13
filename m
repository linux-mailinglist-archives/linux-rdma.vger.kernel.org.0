Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA0E4FEE80
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 07:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiDMFdc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 01:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMFdb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 01:33:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC43054E
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 22:31:11 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso490848otd.6
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 22:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FQXI0KiK4zifZfoJwYoXl3/Kq1UjM0BRF1ihoft4d8=;
        b=GFTQmH+YQcLCXEzHxl3GmtSou249BY19Vi6TM9kiwP28QygE6aBfT53Si4It7Rdn3J
         /5ymqx5DWguX4VWSUWvcNEuJhIshxWnDo2Trdn5bvaz3tiIW1qazT/4KTZ/xU1u97fEy
         5QLsNAVeDtQnQWn8SOBZEBqYjr8d8itCrxIK/sQ7/SLLintzErHOJtloKT2NfZM1fvjR
         LydqpTBh/MWq3mVH5xJDUccnfPB8+YUMwGT/5a1H6KgmJp0JHnHga3kO0sKvddBU3nHF
         VmeBGFtUW9p2Uv9ZzHoKwLpLNHIWvg7yg0wmWdalNcEZrLl12ycNgLYuiMVGySeD6ERo
         qQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FQXI0KiK4zifZfoJwYoXl3/Kq1UjM0BRF1ihoft4d8=;
        b=WRr6roox8Gg/26TN9pfqs2HeK1v+Gqe1mXV8cECJ2yFQ4sTCvuxiNNUGdp1390Bf+1
         7S1lcHFtR4UACiqN+WrAsfT0QxRUJYs3em40Ar0P8QiZ6xYnBY36JbFywl/3FbMnQwTm
         L7X40MOTbapWTXYlpJzodawxxPRu8vRUbU/rpg+5h6rzRNrI3bwNaFnsB1BCriDWrROl
         3TE8JXvwWJODId+RJBdMQ2jybJSDjbRPGlCQc3d4ztyTSnlyaNNIIerpLsF0idjIN3we
         stGh0+mbL83tsaE4+jM9RJflK2aqvuIPT5xqriDqgTI9iGtGlDpGEvfBKz6bGmhT4+mg
         mJqQ==
X-Gm-Message-State: AOAM5314cxxBWj6wqwTbupztl6v4KMOFH8q03LhH4oslS8oA78jQw5Dl
        NQj9I7zinljfHAxLkNCcIqg=
X-Google-Smtp-Source: ABdhPJyxVcMAc/FbgPRq8huJL860oxK790uJUGktPhsDuNI5wHzMgmBIA0gWi2vSKG/o1lnDesQkbA==
X-Received: by 2002:a9d:758f:0:b0:5b2:6857:4a5b with SMTP id s15-20020a9d758f000000b005b268574a5bmr14130165otk.57.1649827870666;
        Tue, 12 Apr 2022 22:31:10 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ed3d-c1b2-6662-dcc7.res6.spectrum.com. [2603:8081:140c:1a00:ed3d:c1b2:6662:dcc7])
        by smtp.googlemail.com with ESMTPSA id f11-20020a05680814cb00b002f76803a208sm13846820oiw.47.2022.04.12.22.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:31:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Date:   Wed, 13 Apr 2022 00:29:38 -0500
Message-Id: <20220413052937.92713-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
while rxe_recv.c uses _bh spinlocks for the same lock. Adding
tracing shows that the code in rxe_mcast.c is all executed in_task()
context while the code in rxe_recv.c that refers to the lock
executes in softirq context. This causes a lockdep warning in code
that executes multicast I/O including blktests check srp.

Change the locking of rxe->mcg_lock in rxe_mcast.c to use
spin_(un)lock_bh().

With this change the following locks in rdma_rxe which are all _bh
show no lockdep warnings.

	atomic_ops_lock
	mw->lock
	port->port_lock
	qp->state_lock
	rxe->mcg_lock
	rxe->mmap_offset_lock
	rxe->pending_lock
	task->state_lock

The only other remaining lock is pool->xa.xa_lock which
must either be some combination of _bh and _irq types depending
on the object type (== ah or not) or plain spin_lock if
the read side operations are converted to use rcu_read_lock().

Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++----------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index ae8f11cb704a..7f50566b8d89 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	mcg = __rxe_lookup_mcg(rxe, mgid);
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 
 	return mcg;
 }
@@ -198,7 +197,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg, *tmp;
-	unsigned long flags;
 	int err;
 
 	if (rxe->attr.max_mcast_grp == 0)
@@ -214,7 +212,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	if (!mcg)
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just added it */
 	tmp = __rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
@@ -232,12 +230,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	if (err)
 		goto err_dec;
 out:
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return mcg;
 
 err_dec:
 	atomic_dec(&rxe->mcg_num);
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	kfree(mcg);
 	return ERR_PTR(err);
 }
@@ -280,11 +278,9 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
  */
 static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
+	spin_lock_bh(&mcg->rxe->mcg_lock);
 	__rxe_destroy_mcg(mcg);
-	spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
+	spin_unlock_bh(&mcg->rxe->mcg_lock);
 }
 
 /**
@@ -339,25 +335,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
-	unsigned long flags;
 	int err;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
 		}
 	}
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
 	if (!mca)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just attached qp */
 	list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
 		if (tmp->qp == qp) {
@@ -371,7 +366,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	if (err)
 		kfree(mca);
 out:
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
@@ -405,9 +400,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			__rxe_cleanup_mca(mca, mcg);
@@ -421,13 +415,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
 		}
 	}
 
 	/* we didn't find the qp on the list */
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return -EINVAL;
 }
 
-- 
2.32.0

