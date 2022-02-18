Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9D4BAE9C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiBRAg6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:36:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBRAg5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:36:57 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A882C11F
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:42 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 4so1390789oil.11
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtZA+JkSi3WFhaVptCJyn0Ywy6jNakeNMbN8MYs1F0U=;
        b=GWC0UAgaF+6Epl/7G9JBJBb6DRUDYe9yBT0F3sFTg1H+QfRvqo9aTDoLjdTm7ZMCsA
         ZbGHxd9EusDYwj09cOtW8FJAxalaOrG5JUztwFxTV4ufcmZqoOxEN/WItCn02UhqdKW8
         vm9KQaqeLUoyykjmATUksfjjb2WfikoO81BIY2hbrLWNgmR5ec3vpi7gqEiJwViMi7Hb
         LiJd+hjX+2JK9q5ZlsY/qiEzXr1qeonj5pC0E2fcrvH6ue2lWv83VE4giTr9hoadbman
         GNWIboQVyma9vSauTr/hYlKjL1WSqySs1FKPfiq86z8s8rOHlKka52Op+kMDtXTisZoM
         MixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtZA+JkSi3WFhaVptCJyn0Ywy6jNakeNMbN8MYs1F0U=;
        b=eIL/F4yi6zF711J4r6bA8FTuYxK52+1+UP+gBfKeiVmCS/dhxZQfjg9tai/NUOYrTC
         ZSj0cC7a3S9YWhu5c+APbrk3ANroo8YMc2IwwBonWQckijQkJyGqMW5NCNQB8ZPQsvGP
         nvcOTU6NQZRiuEo5kovsEpZdCpVazGLqgoaEUSG6wJCXJo11y/h4HnhiYwdzkg+niDFy
         ZB4H0qa1v+eU1U8aNeB4pCNPxmLR3YarTu8QeCX8Ml8Qiok5SmcUD2vMaCjMbZO/bGHb
         utyk5TJafwiLUnF3YdXVf3XHcZg4tkMPtpRK62dMemqSDB0XvF7cq6HZ2ZceNzG7mupT
         WKJA==
X-Gm-Message-State: AOAM530BONVcus9fC+6GHnmTfgKotJoBSi3xHk6juofqzxJ5Tjfh/15D
        wV6Oo2wRn1QrT6LLdPzGitQ=
X-Google-Smtp-Source: ABdhPJzLwoXsXoJFYquz2K1PwqsIDOz9sQl7409tdfcTvNIKXZ2DhqrhYWZbEa3Uvef9+NS1J86Pdw==
X-Received: by 2002:a05:6808:1301:b0:2ce:6ee7:2cfb with SMTP id y1-20020a056808130100b002ce6ee72cfbmr3735541oiv.297.1645144602078;
        Thu, 17 Feb 2022 16:36:42 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:41 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 2/6] RDMA/rxe: Collect mca init code in a subroutine
Date:   Thu, 17 Feb 2022 18:35:40 -0600
Message-Id: <20220218003543.205799-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218003543.205799-1-rpearsonhpe@gmail.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
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

Collect initialization code for struct rxe_mca into a subroutine,
__rxe_init_mca(), to cleanup rxe_attach_mcg() in rxe_mcast.c. Check
limit on total number of attached qp's.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 58 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 447d78bea28b..53db0984a9a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -259,6 +259,46 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 	spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
 }
 
+/**
+ * __rxe_init_mca - initialize a new mca holding lock
+ * @qp: qp object
+ * @mcg: mcg object
+ * @mca: empty space for new mca
+ *
+ * Context: caller must hold references on qp and mcg, rxe->mcg_lock
+ * and pass memory for new mca
+ *
+ * Returns: 0 on success else an error
+ */
+static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
+			  struct rxe_mca *mca)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int n;
+
+	n = atomic_inc_return(&rxe->mcg_attach);
+	if (n > rxe->attr.max_total_mcast_qp_attach) {
+		atomic_dec(&rxe->mcg_attach);
+		return -ENOMEM;
+	}
+
+	n = atomic_inc_return(&mcg->qp_num);
+	if (n > rxe->attr.max_mcast_qp_attach) {
+		atomic_dec(&mcg->qp_num);
+		atomic_dec(&rxe->mcg_attach);
+		return -ENOMEM;
+	}
+
+	atomic_inc(&qp->mcg_num);
+
+	rxe_add_ref(qp);
+	mca->qp = qp;
+
+	list_add_tail(&mca->qp_list, &mcg->qp_list);
+
+	return 0;
+}
+
 static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 				  struct rxe_mcg *mcg)
 {
@@ -291,22 +331,9 @@ static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	/* check limits after checking if already attached */
-	if (atomic_inc_return(&mcg->qp_num) > rxe->attr.max_mcast_qp_attach) {
-		atomic_dec(&mcg->qp_num);
+	err = __rxe_init_mca(qp, mcg, mca);
+	if (err)
 		kfree(mca);
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* protect pointer to qp in mca */
-	rxe_add_ref(qp);
-	mca->qp = qp;
-
-	atomic_inc(&qp->mcg_num);
-	list_add(&mca->qp_list, &mcg->qp_list);
-
-	err = 0;
 out:
 	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
 	return err;
@@ -329,6 +356,7 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 		if (mca->qp == qp) {
 			list_del(&mca->qp_list);
 			atomic_dec(&qp->mcg_num);
+			atomic_dec(&rxe->mcg_attach);
 			rxe_drop_ref(qp);
 
 			/* if the number of qp's attached to the
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 20fe3ee6589d..6b15251ff67a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -401,6 +401,7 @@ struct rxe_dev {
 	spinlock_t		mcg_lock;
 	struct rb_root		mcg_tree;
 	atomic_t		mcg_num;
+	atomic_t		mcg_attach;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

