Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9214B765C20
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjG0T3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjG0T3d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:33 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DF30DE
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:28 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5636425bf98so783829eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486167; x=1691090967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkhXia8nk+h5EHW4veENIj/UEu81qfF17hc+BGHHcpE=;
        b=imVTSu6Y+4KnL0vp2R1KdQKcwF94pl0/a/6xUUWrsMe4lIHhahzi/Wr7jFWzy4NF7M
         FvQp5gVdLtGNORqmLkXAq9P+0ETJd5X6V2WTy48s+o1XGElKFQEorxCMr+N/ZUjYzaK8
         hMfCFelMY1f0oqEzy8N0mUYrlXT6YnPZrEy9d/0e4YfzBQ9cYun2gSDhoyUWoJGCSq+E
         P3RM1Yh+JFtpLX+UjNcsLHNTnNFWGBnZq5vEqpgYP3GVw30DvixUWh7sJbc+k7l0kXQh
         e0VFO83NLUW6Oc7kaIiLicwMtqYy+0XedL+0u843lMJ86g16KFfVIgU15xEFGUMwSQ2Q
         NAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486167; x=1691090967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkhXia8nk+h5EHW4veENIj/UEu81qfF17hc+BGHHcpE=;
        b=UBydVdTtqsgEa7gBtL79U8UWKc+aIpPU0vGh/8+NjhRMdcYHeIkIil12QWdpYwHbLI
         /pRFNjyL4yL/J9r++OccXt8gde4wLxrrXDbCEyD6fjsUf/bj1l/uEKnrVB53dS1lGaC0
         HxCqO3QUQ4rfVDbqe8C92c8qnnQGUUqSS+OInnNQq0gimNcMSovhUwt2g5EJJTOAM6z0
         mx7QXDtQW2jGhEjk2zwAf1/PRSHvQf3SyS2+H5l08IkSosKov2yLKlxTj42+T/jQM8lS
         00EsJbcH0UyzCLsuta5vjZAqTaokVFrWyHxVOL9w3EzR+jPvBYI+NEED7yPsoiqcFcF5
         PnNg==
X-Gm-Message-State: ABy/qLbg9isRW/ana8ZoO0MQBq9a9XlLl/OU9M8tJ2IAwdToy38w3E1m
        oMrIO/zKnuWZUee62SFSn6I=
X-Google-Smtp-Source: APBJJlG9k4v66VSVXJ4sypw8Rli8LoiUK43NCLcnLa3I3I2r1tbUPvFQ8i+p28hWaz/8uzvwjx6wXg==
X-Received: by 2002:a4a:351e:0:b0:566:fbfb:6278 with SMTP id l30-20020a4a351e000000b00566fbfb6278mr506727ooa.4.1690486167292;
        Thu, 27 Jul 2023 12:29:27 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 6/8] RDMA/rxe: Put fake udp send code in a subroutine
Date:   Thu, 27 Jul 2023 14:28:30 -0500
Message-Id: <20230727192831.65495-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
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

Isolate the code that handles the case of an overlong to a
subroutine named fake_udp_send().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 37 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 27be1a946d62..8423d259f26a 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -707,6 +707,24 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return 0;
 }
 
+/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
+ * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
+ * shall not emit any packets for this message. Further, the CI shall not
+ * generate an error due to this condition.
+ */
+static void fake_udp_send(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	wqe->first_psn = qp->req.psn;
+	wqe->last_psn = qp->req.psn;
+	qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
+	qp->req.opcode = IB_OPCODE_UD_SEND_ONLY;
+	qp->req.wqe_index = queue_next_index(qp->sq.queue,
+				       qp->req.wqe_index);
+	wqe->state = wqe_state_done;
+	wqe->status = IB_WC_SUCCESS;
+	rxe_run_task(&qp->comp.task);
+}
+
 int rxe_requester(struct rxe_qp *qp)
 {
 	struct rxe_pkt_info pkt;
@@ -810,23 +828,8 @@ int rxe_requester(struct rxe_qp *qp)
 	payload = (mask & (RXE_WRITE_OR_SEND_MASK | RXE_ATOMIC_WRITE_MASK)) ?
 			wqe->dma.resid : 0;
 	if (payload > mtu) {
-		if (qp_type(qp) == IB_QPT_UD) {
-			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
-			 * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
-			 * shall not emit any packets for this message. Further, the CI shall not
-			 * generate an error due to this condition.
-			 */
-
-			/* fake a successful UD send */
-			wqe->first_psn = qp->req.psn;
-			wqe->last_psn = qp->req.psn;
-			qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
-			qp->req.opcode = IB_OPCODE_UD_SEND_ONLY;
-			qp->req.wqe_index = queue_next_index(qp->sq.queue,
-						       qp->req.wqe_index);
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
-			rxe_sched_task(&qp->comp.task);
+		if (unlikely(qp_type(qp) == IB_QPT_UD)) {
+			fake_udp_send(qp, wqe);
 			goto done;
 		}
 		payload = mtu;
-- 
2.39.2

