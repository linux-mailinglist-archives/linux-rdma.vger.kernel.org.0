Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573C69FFA0
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjBVXfo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjBVXfl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:41 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D342BFA
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:36 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-172334d5c8aso8344410fac.8
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onon58wMMs++ie/KXs86gmnEZ/JO2RZglMfjvOd9j18=;
        b=a+oPSZYY0YyONI2w0J77wH4alOaFBHVPi4Gg1Lw1KesYs21PxBElJmUEofCtt5CRuD
         TLHdzFGnj+/DUFokuILwCSNP07+G7NpIoNn459xqH7FpNGZA24os2pui0waM4vGVmJNA
         EKFu/O5bMbHRQgIOMHuW0CJCoLBYaRiCTVH5vUZo152nBK2ymGNYOW8hhHWoWnhw4A1c
         pHXaDU+obx1BpS174VOD1x/wQO9EW3k2i7DbeSPNlWP/JRxaitrvU+8KEPiOINjj5yHl
         jlslzaefKYUKWr7dgQnct3W9gCcHZF6kswT1B0+hQs1kc7hMAaXPlL2cubKCC9K6SI5e
         S6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Onon58wMMs++ie/KXs86gmnEZ/JO2RZglMfjvOd9j18=;
        b=xo2gqlmTg7G886TtCXXXvagPIsxoKb46ey6uM8VhwDeRNiYmU8FebnlQ7Ikdxh2U1E
         KumJsWj7o1xuZlAp/gLMQ6v5EIkfpDyx4CmH1JdqIo20vKscTuG2B02K6NXCdYxTN6cP
         Je7LEuKQ2hUrG4CRha2legDVCidFNYoKThu/CIoNv4zatsLG5uMyBt0IOd28EEP+KDdJ
         UFog7sblf+51wrBHaZuxpd9MRGZnTAzAZUrC+ULE2TebBupmGemsqx5TnnsBiAT4eDfe
         QVctO5JMJE6QLMRSI9JMlFwjz8ZB+zG5FJAxtMP3wjvboJM9aKOeNI6jgcALfTWW07kj
         xERg==
X-Gm-Message-State: AO0yUKVa0w6wC03xgMZz8Lo5vOztF0uoW50EskmbFvadFlGsxZM2y7Bq
        vuFqN0pBYY5Tqpqb34j79cISJrzbZhc=
X-Google-Smtp-Source: AK7set9OqGtYaVCQncaaPLMYFhBkl9QID+7+mJNMdIDtFeSpqaBSNT6PA3SWOB3wFgFmHUjXSfErwA==
X-Received: by 2002:a05:6870:2389:b0:16d:c23a:a11b with SMTP id e9-20020a056870238900b0016dc23aa11bmr9132797oap.3.1677108935302;
        Wed, 22 Feb 2023 15:35:35 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:34 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/9] RDMA/rxe: Replace some __rxe_do_task by rxe_sched_task
Date:   Wed, 22 Feb 2023 17:32:35 -0600
Message-Id: <20230222233237.48940-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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

In rxe_qp.c there are several calls to __rxe_do_task if the
qp is not RC for the completion tasklet. This is not really
correct since elsewhere in the driver rxe_run_task and
rxe_sched_task are used for the completion tasklet which
prevents reentering the completion tasklet code while
__rxe_do_task does not. It can only be safely used when the
task machinery is stopped as in rxe_qp_reset and
rxe_qp_do_cleanup.

In the latter two cases there are if statements checking
to see of the qp has a send queue which is not required.

This patch replaces calls to __rxe_do_task by rxe_sched_task
except in the two mentioned cases and removes the conditional
code in those.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 37 ++++++++----------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c954dd9394ba..544a5aa59ff7 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -473,13 +473,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 {
 	/* stop tasks from running */
 	rxe_disable_task(&qp->resp.task);
-
-	/* stop request/comp */
-	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_disable_task(&qp->comp.task);
-		rxe_disable_task(&qp->req.task);
-	}
+	rxe_disable_task(&qp->comp.task);
+	rxe_disable_task(&qp->req.task);
 
 	/* move qp to the reset state */
 	qp->req.state = QP_STATE_RESET;
@@ -490,12 +485,11 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	 * etc.
 	 */
 	__rxe_do_task(&qp->resp.task);
+	__rxe_do_task(&qp->comp.task);
+	__rxe_do_task(&qp->req.task);
 
-	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
+	if (qp->sq.queue)
 		rxe_queue_reset(qp->sq.queue);
-	}
 
 	/* cleanup attributes */
 	atomic_set(&qp->ssn, 0);
@@ -533,10 +527,7 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (qp_type(qp) == IB_QPT_RC)
-				rxe_sched_task(&qp->comp.task);
-			else
-				__rxe_do_task(&qp->comp.task);
+			rxe_sched_task(&qp->comp.task);
 			rxe_sched_task(&qp->req.task);
 		}
 	}
@@ -552,11 +543,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 
 	/* drain work and packet queues */
 	rxe_sched_task(&qp->resp.task);
-
-	if (qp_type(qp) == IB_QPT_RC)
-		rxe_sched_task(&qp->comp.task);
-	else
-		__rxe_do_task(&qp->comp.task);
+	rxe_sched_task(&qp->comp.task);
 	rxe_sched_task(&qp->req.task);
 }
 
@@ -784,13 +771,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
-	if (qp->req.task.func)
-		__rxe_do_task(&qp->req.task);
-
-	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
-	}
+	__rxe_do_task(&qp->req.task);
+	__rxe_do_task(&qp->comp.task);
+	__rxe_do_task(&qp->req.task);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
-- 
2.37.2

