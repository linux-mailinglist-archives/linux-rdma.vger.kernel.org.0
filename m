Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024635094B5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383663AbiDUBoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383654AbiDUBn6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:43:58 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E09765E
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r8so4100896oib.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzuLb3XlUruYZ9Vu/tQaCE9Qho4LlE1+7yyaL8/rqGE=;
        b=UZ7WmRiHV+eJDuv7EuDd48bFRkEFzfKKRLsRlHD9fMGIcv8vbFBv9zmcYKS5HO2ttn
         zz5SpxOALXiZDKbonzwIm+bMN5DuSu67OAn93ctdYIKfE8//3L+QwV40wohc73B4OWUQ
         cLvE/JnGB8y9CwwV1yBkZW5BY71EOCjMMPgJqoo9eE6Ct3lsnUit3xt/I0GYoo5lklsZ
         +6av6vZzK4ZQWyvBtSCx5Y+XnuFZeVS3RPvw57txywStu7QmJpumwBqxjM6wN06btQKq
         8Ixu0FOB2YIUtNORAePJBybd0YiyX8AWny+i6g0CRecddyfyIVGMuOtWM9K9l+mu8bNn
         UoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzuLb3XlUruYZ9Vu/tQaCE9Qho4LlE1+7yyaL8/rqGE=;
        b=ytp6wpiA6q/x1KZ0IoGJyz48rU/Grmi0JTC8DFCbQhfWumOAKa536TASbwtYlS8rAR
         wppDbkBsgeruW4+m9XEqACt2D7aJyBmLjWnXkszO1eYZ0VFYNcUU1PICG717cFzbwGRt
         suJeOIVeWaHzaJYzUCTUEkU0z0o8TE/7jcHQzRtug+k3gJbTmo/YeuQ50A8GcMnJma0A
         5rRIq1W9PHa/GsQr7HKobNtQYVc6RhDxtZWWfT80HceYbYKxaB8mtIQ2f6q0kz8e/4rj
         SuD6QilpUZIQQDGDAlb5zHzo9gBtS9NJR0psyU2hwpNMpk5lUO+ADsuFwUztxOZRFj7H
         OntA==
X-Gm-Message-State: AOAM5328MvySirubvP7gjnMkJG4xjQXNiKEpFI2Wo1AC/QD0IjxHy6Xw
        yBpK6qniFfs74NUTb+CSAXQ=
X-Google-Smtp-Source: ABdhPJyNtmG7kUIoW+ymZ/+R8tA7gSExyPmRf4cpkHilUBm2FS1JCm2+U/zUdlMPCGu8BNVtjSRXMQ==
X-Received: by 2002:a05:6808:1449:b0:322:ed6c:1f2a with SMTP id x9-20020a056808144900b00322ed6c1f2amr2360719oiv.289.1650505270342;
        Wed, 20 Apr 2022 18:41:10 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 02/10] RDMA/rxe: Add rxe_srq_cleanup()
Date:   Wed, 20 Apr 2022 20:40:35 -0500
Message-Id: <20220421014042.26985-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index ff6cae2c2949..18f3c5dac381 100644
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
@@ -168,6 +168,7 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
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
index e2dcfc5d97e3..02b39498c370 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -174,3 +174,14 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
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
index 2ddfd99dd020..30491b976d39 100644
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
 	err = rxe_srq_chk_init(rxe, init);
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
 
@@ -339,15 +338,15 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 
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
 
@@ -368,10 +367,6 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
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

