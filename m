Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06954C1F5B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiBWXIO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244715AbiBWXIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:12 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA9488AB
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:43 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso858728oon.5
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwKnRdPP1nh11oYPUh6+89DP77zh2e3vOPp3MASHCak=;
        b=iDt+8yyg0C3DnSqFiCrWG3wu1JVSC9LR21zgVoWv8lGoHqGd8/OSQSJqGaS4Tg6pgl
         UxXRWyMRT9hIlpxxTRdkWVl1oM/O0smSU0zJDf2gxL9Ysuk1Sssus/bG64cz1WIAiwtb
         UhPXFXBI0TRG/Z0lkTZA8TsFh4ceTcwsrhmgpFY750sNr1rXrtYqnSWn3Reyy0yyiAVp
         ZnuaErPwdWjWAjvzMc9+Z24V99r3kbkQuclUMdUPdx3Ss9xfoiwSftbJKIqXwDLn85GE
         lBBX6YWJHBAYI1TCucKe9e3kizKyaFKAY3LpY8t0qXnX4X5JhxuVUs/rs3TkuwCh7rN9
         LPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwKnRdPP1nh11oYPUh6+89DP77zh2e3vOPp3MASHCak=;
        b=02RIUThpma1d8CnP6LcG4gWeEm6n3hHhu34DrtYhexNMPvnNzQL7VNm2WUk0q+SWdc
         6Z8tdjW9fvrw1iGkPEirhh8my7nPF3H28pjV0VBfzRHuMawwQdOTWGECxcikAp3SGcdY
         1J+jXEjQg708Zllo4t4yww7pBSz7pFhlzjD5bowFY0B8XTWqH+ebOlBOTJVlVo0fnoH6
         bgWh2QrKUjvGcqO3Ya7MmqQJSjmAUaXb/0sX1TJp/Jbe+ZJPSuwyNopcAaVMcgApnMaT
         OKbF0s5qMUSJHWgdvpMFNIdPxniRmBTWe8lMvqj40J6tpmOdxxKVJ4hiXVCNTdF3T1G2
         IxqQ==
X-Gm-Message-State: AOAM530nwP72p8RvWlxKEQV2cmm/4qtaW7Goj3pghys4yJgx3vvC4Brg
        dVbQAUZPgxXvvv9OvcB3hQA=
X-Google-Smtp-Source: ABdhPJwopykpci8sigAyxiRIDjB3suP3aMpdft97LYuuxzHZBloulr5XAxCXmXePbknqEKrwqmguDA==
X-Received: by 2002:a05:6870:e304:b0:ce:c0c9:69b with SMTP id z4-20020a056870e30400b000cec0c9069bmr5062749oad.237.1645657663310;
        Wed, 23 Feb 2022 15:07:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v13 for-next 2/6] RDMA/rxe: Collect mca init code in a subroutine
Date:   Wed, 23 Feb 2022 17:07:04 -0600
Message-Id: <20220223230706.50332-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
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
index 4935fe5c5868..a0a7f8720f95 100644
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

