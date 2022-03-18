Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4227A4DD29C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiCRB47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiCRB46 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:58 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A9C24223E
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so8641819oot.11
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxF2KUc6EO6kphwo4HlT4qqWAakQzhVgtzyDrqKl8JA=;
        b=jh8jCnZocMTq++PDjOrq3FhJSZroSMa8/vwqLJ7EcNyo+PQ++Ix5YuhQakpjlkmJQY
         UND2bhle9t2GGNYkX5Md6kNaGu+K8h3VpSC4UG2vng7uX8IkiUkVU8AJ6/LpYSvf9+zb
         8djWNtOnStUVSV51vznybanBUR1jX5Ir0cepdL2o+fDCGdgrieo+S220ihQF7BizwNpH
         3MDz7Qj2i5w0ocnnYZE5M5sipnocWFq+t4M7hGSwimVXqIUf1e3Mx8GQF8KR0P7Tv88Q
         hueSpeUp/Onio9j0OLAgcQhFyqIUuCMH1Z6uZDGSMIfqVvPY1a1+tLsWF+ssGtS05sYz
         /Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxF2KUc6EO6kphwo4HlT4qqWAakQzhVgtzyDrqKl8JA=;
        b=NxNXZSqeXak2wEDB91oOt8RsPNSK2rqtTQhT1I2NfYkYvrl2ZMU3Vf0fbZ64wjL2qp
         yrBRBik44FTMcQHCgiX3i1NPp2WCbEoWmCDq4pWLabK2UICdXb1ntXzwmyZ5jT6v8FKY
         yPdhKSqFLBBc4JWD1ZUEKS776a6rh30KuVVuop6QQPLbJ5HxLeGNVC5GgMXtch6U/4xC
         E2q1JCdaslo05KJ3y88F9Ay06jZevSc99ZSLw5NOap8Ix1umUfWzVnl8ACUFotEYCSHq
         3K4VnkkXFoLeQltkO5FVnrdKFRakEf3ZSnftEZPOG0Q4LFVveAAy4U67ccYdfHc3hfnc
         ySgQ==
X-Gm-Message-State: AOAM53288tclBQO6lxK5kdvzy7sLpSRA/jhmjIUfz5yiREFuDDvVYjIU
        0E3O8HmOxpIPtXQGPibQsxE=
X-Google-Smtp-Source: ABdhPJyTbcXT575WAelXOptxhAfWOn4mVJU9HiaTPTgtx/0Zx5r8yxYfEWnhILxXZKmW1lCyWVo1Lg==
X-Received: by 2002:a05:6870:231f:b0:da:c15:fd43 with SMTP id w31-20020a056870231f00b000da0c15fd43mr2695069oao.135.1647568534270;
        Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 07/11] RDMA/rxe: Enforce IBA C11-17
Date:   Thu, 17 Mar 2022 20:55:10 -0500
Message-Id: <20220318015514.231621-8-rpearsonhpe@gmail.com>
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
index 9a3c33dad979..4c082ac439c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -802,6 +802,12 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
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
index 34aa013c7801..5764aeed921a 100644
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

