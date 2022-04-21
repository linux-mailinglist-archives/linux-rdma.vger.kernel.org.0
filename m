Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD675094BA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383669AbiDUBoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383672AbiDUBoC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:02 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B37E167FF
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so3932918fac.7
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ep+FVja65jOWLxclpsoAIGJYSijfov9x4ggHf6vS6U=;
        b=Leg9aHpRhx0p0n1R/OGpl442MOtNNnchI5ZkCs8fA9ChXMfdL31tBYLTtzKrtnNmha
         NWZ5SZCySEKNkLq1+GNPT92ISZhuB+TQrwGyxiQpHwBhMDgbevOWaey/kXHnTSjuvFb9
         mxDrZSuRTp2ZCFeir97x8P2pJQajl2xATyUCvWn9G7PdypdPLzNXy/euzTovueCbSznn
         S+O2uuzC4n+bVmjP21CNi8lmjV+Qy1MQrsDx7K+Zzltb/4wEC8XAiGfXvWVxDVgHK38U
         wQ2q4hYnBfBUQ2xKAwahfiYS8XcIlh27tQmN4VWnb8YA5P4JumZ3sCCFdjeboW23KbYH
         sG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ep+FVja65jOWLxclpsoAIGJYSijfov9x4ggHf6vS6U=;
        b=G9xc2mCpS4jX2hT94fCpaJNcK4JIraecUQ9Hd3bU/3YX4xZaS+A2ZvgstV15eN+xEX
         uSZDrlySv8BukEDN1oGvx/rgFYC9B3EjHTTShCIch5yEA/k9cHdPIrshBqzcKJmI7p/K
         LuUgcSyYKyq2Q7gc8kzG77if1zf/ZHiNmNany8yzowV8NFvi1YPMRWbif/uruY7capwp
         zcNWX6+Ag46jhCeatSgyNLfKOqC4hOC5Z6Dk9165k4qfoRx1dRmdVH7HiIEoRWDaHWVF
         VfrIjmiFAcnUQL96BuUzRT7lf9l4dBO5JhmSwOvK6kEn2P9J8B/gsUTFUQpgcKBMFinP
         xfkg==
X-Gm-Message-State: AOAM533oN+BjpMBvSSE0ivZApGVRuSYEMnHQ07TwIxTLhZcqAZHu4db4
        dNiiUWhpYa4JTa7p0JP6Vcg=
X-Google-Smtp-Source: ABdhPJw2FEvsBA0Zu6FRYF5RGh0zqtEhIjXN7E19woVQGl6UQ+ddhBROWrMhzYNHdJRiU/hu9RU5fQ==
X-Received: by 2002:a05:6870:478d:b0:d4:6806:953 with SMTP id c13-20020a056870478d00b000d468060953mr2985721oaq.80.1650505273588;
        Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 07/10] RDMA/rxe: Enforce IBA C11-17
Date:   Wed, 20 Apr 2022 20:40:40 -0500
Message-Id: <20220421014042.26985-8-rpearsonhpe@gmail.com>
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
index a8011757784e..22e9b85344c3 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -322,6 +322,9 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	qp->scq			= scq;
 	qp->srq			= srq;
 
+	atomic_inc(&rcq->num_wq);
+	atomic_inc(&scq->num_wq);
+
 	rxe_qp_init_misc(rxe, qp, init);
 
 	err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
@@ -341,6 +344,9 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	rxe_queue_cleanup(qp->sq.queue);
 	qp->sq.queue = NULL;
 err1:
+	atomic_dec(&rcq->num_wq);
+	atomic_dec(&scq->num_wq);
+
 	qp->pd = NULL;
 	qp->rcq = NULL;
 	qp->scq = NULL;
@@ -798,10 +804,14 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
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
index 8585b1096538..7357794b951a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -800,6 +800,12 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
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
index 86068d70cd95..ac464e68c923 100644
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

