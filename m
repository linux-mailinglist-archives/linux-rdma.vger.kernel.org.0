Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF54F1F22
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiDDW3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbiDDW2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:20 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F14517F8
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:28 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so12359776fac.7
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Q2DwsD75zgPlVackU2NQ86VaRD6/QwV/bfYs0ib26w=;
        b=FrG2KRFrA1IkGGf4GshUEzIbHG8rH53qslXKHeKlzSnC+7ZN8iiIdmOAHjcY/IECz6
         FhsZ6ya6+SXDzYZErcP69jwRgwPM8FXa5FrQB3Qf0T6p0urFiv0rdbRgIbRzfkfRZs4L
         jTFYniiG6C/FHldSusJVAKrHF+4awIDDakHyEfFbM24AWRQXwGfb8LevO05ChYFvnJmu
         L1nlGu6exsctIJQ8839up4uZ14HewAhWwWQjaA1wtjbsm+5cWadWIXfr8+7RdkpnyMz2
         0dTcusZwOmw0aJRHgmxCS1VJfwwy5nuX2VmUOB++8TbRAYJwlVk4CZzgI5yqtnbI4q4n
         g/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Q2DwsD75zgPlVackU2NQ86VaRD6/QwV/bfYs0ib26w=;
        b=27D9gKklxHqCmqWf9pqZne2nxE9P4KcA5uyri8EOxoTiswR2iI5F6TcBaU4+gopT7p
         8Yb6+ZMcftqR+gRBKD/A7W5bJvwtgKeqYi9dUYhkphXJFIDPxqwQZA7twcxQZAMq5BM7
         uVIujs35bTCCjVq3WWs+gN5pMvkMFUGDkZJXf0xlFG+2SMDgMrb3VzEemsrfE1+cZLUP
         QsLzptJxVMesRhKOi/dGT7NKkxRa/02KopWmWyLxlXSLyuLg+PoggRo3dRpPmR/3CkrS
         sePhchHYJSzZM9b08WWWRuxzNoDbvdxXLMzJAp345oV10UvqrKK+LiMPac6GKKTFkByh
         m1qQ==
X-Gm-Message-State: AOAM530TGpeVqNENV4o/6n8i2e9lEbpPP88j8KtKsW2IOPTeWRukf/ot
        yp3UI1Y4rw3fBae8Exef0TDNH/ol0TA=
X-Google-Smtp-Source: ABdhPJxKCDT9BQPF8sJVpm5snOETIuE9oDnyrnCAimO0YryQs2lTqTd92zMEsQa593XTqGp6tPJjkA==
X-Received: by 2002:a05:6870:e2d4:b0:e1:f404:8a8f with SMTP id w20-20020a056870e2d400b000e1f4048a8fmr150885oad.124.1649109087384;
        Mon, 04 Apr 2022 14:51:27 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 04/10] RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
Date:   Mon,  4 Apr 2022 16:50:54 -0500
Message-Id: <20220404215059.39819-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
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

Move the code from rxe_qp_destroy() to rxe_qp_do_cleanup().
This allows flows holding references to qp to complete before
the qp object is torn down.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 -
 drivers/infiniband/sw/rxe/rxe_qp.c    | 12 ++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 18f3c5dac381..0e022ae1b8a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -114,7 +114,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr,
 int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask);
 void rxe_qp_error(struct rxe_qp *qp);
 int rxe_qp_chk_destroy(struct rxe_qp *qp);
-void rxe_qp_destroy(struct rxe_qp *qp);
 void rxe_qp_cleanup(struct rxe_pool_elem *elem);
 
 static inline int qp_num(struct rxe_qp *qp)
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 62acf890af6c..f5200777399c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -777,9 +777,11 @@ int rxe_qp_chk_destroy(struct rxe_qp *qp)
 	return 0;
 }
 
-/* called by the destroy qp verb */
-void rxe_qp_destroy(struct rxe_qp *qp)
+/* called when the last reference to the qp is dropped */
+static void rxe_qp_do_cleanup(struct work_struct *work)
 {
+	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
+
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
@@ -798,12 +800,6 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 		__rxe_do_task(&qp->comp.task);
 		__rxe_do_task(&qp->req.task);
 	}
-}
-
-/* called when the last reference to the qp is dropped */
-static void rxe_qp_do_cleanup(struct work_struct *work)
-{
-	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 83271bea83b1..6738f1b4a543 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -490,7 +490,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	rxe_qp_destroy(qp);
 	rxe_put(qp);
 	return 0;
 }
-- 
2.32.0

