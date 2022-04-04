Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0B4F1F26
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiDDW3W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbiDDW2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:20 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617651E4E
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:26 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-de3ca1efbaso12352741fac.9
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ED6RrmQzjFRdJerMCPzNkokvIx5w9e0RDTgAlYIxE4g=;
        b=YyCYje1B9w6Z7d3HIT2B6OhZL591UhbY39xrMse7F+fz5wqQymNFJYYJqAWCIsIIc2
         fmSUg2vmQRQxyIWMeS0/BSk6hn/mSlkXAM9+dySS7xWMEflVSkDBEG5dh92P6o26b9JD
         i4FvZsspPVFbQUfCRMlFMY9ujhGKsQcUi6ta0qQZQbVBtrZUUiq+JikisbI/tfpn0slA
         CDosKzHjLXjCMF/Y3TZmHgcqul5D+5O/00m2CsnZp4GOb4KQf+gddIZBFMXp9EebQkTc
         8X3CgtQXUcpQ2yITu8Drp91Ycdo4GPobd3L8XF+UqWrzbv0ht3DFko0DQh2gYI5siWPd
         9BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ED6RrmQzjFRdJerMCPzNkokvIx5w9e0RDTgAlYIxE4g=;
        b=iokg2dJwlc4wTdDQci5XVphyL5ziNtGqMoukV9CIDsXqQM3eJfZoAKICYhWxiQw++2
         8rEOdytNOJHw3uU3cgAeNjRk+6QWmD7JnQhYo8anmQ6HpkOwfDis1txRw2s6q+vohHqR
         SH6YlQIDva2trhJ4/94/Y0QVCUzRbpyOYyFeqY1NXriwgfdWTuV9Mh1JXRTGlMUgT21m
         +PULGuT5zM2QINStPIJBmtihU/RBDhl3gc64vQi5Ymr73/IyBh32AuX/LXMjCZ5QVeUY
         KdmswWkmXZIx47TKp/e2aRgZFNmEaL/zvIuUMTsfqQBWzhrcIgPwWdIGruhBNQV0SRv3
         AV2w==
X-Gm-Message-State: AOAM531n1xkC5O/rmM2IEPvQC14MFKtwIqKcMIIXKNc/kEjb/qu5iT0Q
        G6KCPZh9ZyLhBoqvsm726bE=
X-Google-Smtp-Source: ABdhPJzzBlFWH/4k7z1tAwGlwbhFWPl/kIgnFzDcxEOktMhvy2fgSU5VpbZV7qmaPbC4ZOFqnAlVZg==
X-Received: by 2002:a05:6870:4345:b0:de:f347:e2cd with SMTP id x5-20020a056870434500b000def347e2cdmr134137oah.113.1649109086169;
        Mon, 04 Apr 2022 14:51:26 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 02/10] RDMA/rxe: Add rxe_srq_cleanup()
Date:   Mon,  4 Apr 2022 16:50:52 -0500
Message-Id: <20220404215059.39819-3-rpearsonhpe@gmail.com>
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
index c1d543e24281..83271bea83b1 100644
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

