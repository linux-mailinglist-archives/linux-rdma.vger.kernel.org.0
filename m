Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF974DD2A2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiCRB44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCRB44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:56 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800D2414D7
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q189so7503970oia.9
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XI+4+Dmeo+mKDgNgvWOH65/+Nxhaxdl8wKivdGzzlRU=;
        b=JArd+2eKKEB8oBvkXvt2QqkjrlC8WPc0mbHRWlZueW9zb3D7JTBcIhZkZAcg19dN63
         F+x+mxQKNdU5DW9PUXNME5wk0uA5Lh1lFHNBbixYtzWhFC0I+RAf4T9m67aQZmo64B3J
         kH+k27ICCfeefpaY7wKRoLucp1I1gAyscLTfbRj1S5paZsKvEc5MVHe6/gwFJWEW8W4u
         rjbk9fAazTh2+3j5Q3FnrYnbHUSubIt+Wk6r5kXGzfNegEJhM/bcutIP32FjoSTJIVqc
         IfZZ+OG+k2Ve1BUu2Xws2rjrDHUfWL0xoH2nXeANUZFQvnlNjbZXfvZ0HqElViKIT6jD
         mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XI+4+Dmeo+mKDgNgvWOH65/+Nxhaxdl8wKivdGzzlRU=;
        b=ndHBxEE52pvKfwks6hrDIWy5gzmCgKM358wNc0ft+MasyHbmNVLWAx/Tr9TIxFkSSu
         BRq7uP9IQL1wy6YzaJYLt/tiPdk92KVAXosygZysA0GuQzSvDzo6Y0D+QsTq+Cd3qS3Z
         HtApHF3VnCANmuhM8CFANyT6EfTnr7zx2MzgTx/Jt1BcBVRD4QoAzP66A5QnRYDuZHYM
         Wa1nthje6IR0M5X6HAPeLUdNrq6K/GV/7kxJymIKa/74efX6tsWtqmbXXErZ9tZJCS7C
         YN9jfrcVo0juhjNSWDbQRU7sxSvldkCi4Cv2XavB0hMa625aDL0mIFiizy57X0zBDn28
         SsyQ==
X-Gm-Message-State: AOAM533O2OgaeLztRXGh2tRzCUAXdyDHWnYHs4PzE4lP0IIMldbD7noD
        +yOUY5SqIbGB66zY+14EBwOtfINPwpM=
X-Google-Smtp-Source: ABdhPJxwy4tXxkr6i3sbZjzSc+6Rx13qutO3uq6DKVgYTPsjWNdTscXYgWhPYq65buCmrMsYdABl0A==
X-Received: by 2002:aca:bed7:0:b0:2ef:2225:6b6 with SMTP id o206-20020acabed7000000b002ef222506b6mr1457468oif.174.1647568530344;
        Thu, 17 Mar 2022 18:55:30 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 02/11] RDMA/rxe: Add rxe_srq_cleanup()
Date:   Thu, 17 Mar 2022 20:55:05 -0500
Message-Id: <20220318015514.231621-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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

Move cleanup code from rxe_destroy_srq() to rxe_srq_cleanup()
which is called after all references are dropped to allow
code depending on the srq object to complete.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  7 ++++---
 drivers/infiniband/sw/rxe/rxe_pool.c  |  1 +
 drivers/infiniband/sw/rxe/rxe_srq.c   | 11 +++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 27 +++++++++++----------------
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 9067d3b6f1ee..300c702f432a 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -37,7 +37,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 
 void rxe_cq_disable(struct rxe_cq *cq);
 
-void rxe_cq_cleanup(struct rxe_pool_elem *arg);
+void rxe_cq_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_mcast.c */
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
@@ -81,7 +81,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
-void rxe_mr_cleanup(struct rxe_pool_elem *arg);
+void rxe_mr_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
@@ -89,7 +89,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
-void rxe_mw_cleanup(struct rxe_pool_elem *arg);
+void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
@@ -167,6 +167,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum rxe_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
+void rxe_srq_cleanup(struct rxe_pool_elem *elem);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87066d04ed18..5963b1429ad8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -46,6 +46,7 @@ static const struct rxe_type_info {
 		.name		= "srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
+		.cleanup	= rxe_srq_cleanup,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 862aa749c93a..26e7ac35733e 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -154,3 +154,14 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 	srq->rq.queue = NULL;
 	return err;
 }
+
+void rxe_srq_cleanup(struct rxe_pool_elem *elem)
+{
+	struct rxe_srq *srq = container_of(elem, typeof(*srq), elem);
+
+	if (srq->pd)
+		rxe_put(srq->pd);
+
+	if (srq->rq.queue)
+		rxe_queue_cleanup(srq->rq.queue);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5609956d2bc3..89f4f30f7247 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -286,36 +286,35 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
 
-	if (init->srq_type != IB_SRQT_BASIC)
-		return -EOPNOTSUPP;
-
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
 		uresp = udata->outbuf;
 	}
 
+	if (init->srq_type != IB_SRQT_BASIC)
+		return -EOPNOTSUPP;
+
 	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, RXE_SRQ_INIT);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	rxe_get(pd);
 	srq->pd = pd;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
-		goto err2;
+		goto err_cleanup;
 
 	return 0;
 
-err2:
-	rxe_put(pd);
+err_cleanup:
 	rxe_put(srq);
-err1:
+err_out:
 	return err;
 }
 
@@ -340,15 +339,15 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 
 	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	err = rxe_srq_from_attr(rxe, srq, attr, mask, &ucmd, udata);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	return 0;
 
-err1:
+err_out:
 	return err;
 }
 
@@ -369,10 +368,6 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
-	if (srq->rq.queue)
-		rxe_queue_cleanup(srq->rq.queue);
-
-	rxe_put(srq->pd);
 	rxe_put(srq);
 	return 0;
 }
-- 
2.32.0

