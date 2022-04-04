Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1D4F1F1F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiDDWaG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbiDDW2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FE517FF
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:30 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-de48295467so12391335fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvPpkHvA3BY4MWR0Waer4OHXDIziMbtQ5DYk5eeWse4=;
        b=Kn6WgMKhz/deDtMlaBuLmvC+y2vb4GGPG/ftF+/j9OWq2tG5lJGBxsNqoD4sUa5V3O
         oatXCb/HFSZA3oGr/GTCa6uWKhgceevcVmAes1mKSOLjUYjdBz55k8cRUOhjYNdP8BYk
         XKNLfgWhYW9Te8Oo53P+YmgQ/x6FPkWhco1jU0+AciwLOFWsLg0vDcYnkkpb3+1UVohl
         WDlRRaOeVkf1JBajuPDQLlQeKDaX0/PdZVPXK7OhQNuVfRYLBSAL00G52ZfWMd+rBnib
         R3cMY6qGzrc2YxAyPNZ+CWcv+aIOkBNhlyJEOsdEfR8vM12nAcfQgGqBaPRlTU8PrK/r
         Ithw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvPpkHvA3BY4MWR0Waer4OHXDIziMbtQ5DYk5eeWse4=;
        b=UzNFKj8dWxpg7lGaz7IhG7w0KIC1yplnRYCa1u+R5cELbCnQYMgUvknniruUbCWjIu
         IRpD0WkTCJg91ZwKSaGp/iDoLNzWhLky/tgLiYIhNKHtqVQIWrdU87D42oJ1uTimwcYk
         rVgTSpP3JirtaY/KEZmxqf/SbMbyGeuSytC91ry2DFoe5Ultwi7DyqRg8yACxh9yUfuh
         iG95OFhkT+Yh8Hisa1iw+9cpezJhv5fJgq2eV6ASh1kxDvSWD8Y3zrDTVBoGgtQLgt1V
         9DUP2/w4jnbNPXKuNsiuNBd1g9JgiS03tNwYXDkgxx6RhdmGJo9bptzY4jJ8YdtJdSxQ
         TrlQ==
X-Gm-Message-State: AOAM5319sBEEZscF31xji4M2Maf5Vl2L1hvj3zRC0jLyv/4hholQNY6M
        DNNDKAhWE1Ew6oJ8CW0WUR0=
X-Google-Smtp-Source: ABdhPJwOIqP/7LkWYE6XS3qie02rs6CiajoP9NZuNzhxeVuFTmRlpD9qAGna+xjagPGoAiHSBqWFIg==
X-Received: by 2002:a05:6870:d58c:b0:de:6900:6222 with SMTP id u12-20020a056870d58c00b000de69006222mr129571oao.179.1649109089525;
        Mon, 04 Apr 2022 14:51:29 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 07/10] RDMA/rxe: Enforce IBA C11-17
Date:   Mon,  4 Apr 2022 16:50:57 -0500
Message-Id: <20220404215059.39819-8-rpearsonhpe@gmail.com>
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

Add a counter to keep track of the number of WQs connected to
a CQ and return an error if destroy_cq is called while the
counter is non zero.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 10 ++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  6 ++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f5200777399c..18861b9edbfd 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -334,6 +334,9 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	qp->scq			= scq;
 	qp->srq			= srq;
 
+	atomic_inc(&rcq->num_wq);
+	atomic_inc(&scq->num_wq);
+
 	rxe_qp_init_misc(rxe, qp, init);
 
 	err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
@@ -353,6 +356,9 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	rxe_queue_cleanup(qp->sq.queue);
 	qp->sq.queue = NULL;
 err1:
+	atomic_dec(&rcq->num_wq);
+	atomic_dec(&scq->num_wq);
+
 	qp->pd = NULL;
 	qp->rcq = NULL;
 	qp->scq = NULL;
@@ -810,10 +816,14 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->rq.queue)
 		rxe_queue_cleanup(qp->rq.queue);
 
+	atomic_dec(&qp->scq->num_wq);
 	if (qp->scq)
 		rxe_put(qp->scq);
+
+	atomic_dec(&qp->rcq->num_wq);
 	if (qp->rcq)
 		rxe_put(qp->rcq);
+
 	if (qp->pd)
 		rxe_put(qp->pd);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 6738f1b4a543..4adcb93af9b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -801,6 +801,12 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
+	/* See IBA C11-17: The CI shall return an error if this Verb is
+	 * invoked while a Work Queue is still associated with the CQ.
+	 */
+	if (atomic_read(&cq->num_wq))
+		return -EINVAL;
+
 	rxe_cq_disable(cq);
 
 	rxe_put(cq);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e7eff1ca75e9..bb15a74f624e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -67,6 +67,7 @@ struct rxe_cq {
 	bool			is_dying;
 	bool			is_user;
 	struct tasklet_struct	comp_task;
+	atomic_t		num_wq;
 };
 
 enum wqe_state {
-- 
2.32.0

