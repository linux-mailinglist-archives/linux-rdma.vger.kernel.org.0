Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723785EFBAA
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiI2RJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiI2RJR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4A1CEDFF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-131b7bb5077so2567993fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2sQYsVirRP6MdY15qHzh8WxTTUEdGT3IBBGPdUTLpFI=;
        b=OqzuwCP/hQ6HIZPHMHXJuXlJ1PlrzyPHbJmG7qd9FW0a1bJKqiVliyMRe/5GGXdPav
         p1kMFJRVVuStZA3PUvgqrMl6uwo0cJMrBpAR0paf6G6/YWTc4Aa4olOhI2KGGWYzgUyb
         gZtQGRoUwmzTzKvyG0+AGZ9nbDs9e9kuMywqhbawPcPiWzdGC+w8Ts5HKjgkYiqcMGVt
         9RU6oW0wwcmbEBNExPURWSa68sN81QUiHZYeM14eBQdIjR0OYzXvwJKx5SzI83Lug3z5
         0esv5pFBJ76SEgFrA2Y87Uojodo/KuYH9y8ti0ql11WqIRwfG6UeSrGW747nE7ewMCrM
         2iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2sQYsVirRP6MdY15qHzh8WxTTUEdGT3IBBGPdUTLpFI=;
        b=jin/eejkuYue3TdFzRb1fiz0TPE64DDn6tRBhd4A8w3Egv8JDHUDuWPNC+JNSIGzCM
         Th7l+5jDGl8e6WfTzVw1n9cN1qYZBYpsv1vjmH3llcV3d7PowF9qadCBweWsdpBYHXps
         o6EaEYiWGOXP8zJnL1cu7Ql8laK6XMSay8yIFeo4n6K5asbhOmTT7wXh9HUCapJL69O6
         XoOs9KPmOULKfnbBoRop2BIL/t7ZkE3+GC4hmhK1zduD6YtxQAMOX89tMYWfSm10ELPV
         v2i0RodvLAf0w5NmJ7dKgjuQL84LeHDAreI5CrvMUihRmMMAjmqBKZeCEu7foWII5Mo9
         wcxQ==
X-Gm-Message-State: ACrzQf3+iEbIqP+rNsIutzPVF68cs6wGajcE1X9tIaSPL/eYGXepajx1
        qBTSgX9lQYqg9W9bA1zN4WU=
X-Google-Smtp-Source: AMsMyM5H23uQBW2NZCIjia2M5PItOvB3/nP8O7Wv43ZzeY+uJl22rzIzK1Gx3MLkSu/4Pi9/d4vvIw==
X-Received: by 2002:a05:6870:59d:b0:f3:627:e2b0 with SMTP id m29-20020a056870059d00b000f30627e2b0mr2446436oap.47.1664471355033;
        Thu, 29 Sep 2022 10:09:15 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 09/13] RDMA/rxe: Extend rxe_recv.c to support xrc
Date:   Thu, 29 Sep 2022 12:08:33 -0500
Message-Id: <20220929170836.17838-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

Extend rxe_recv.c to support xrc packets. Add checks for qp type
and check qp->xrcd matches srq->xrcd.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  5 +-
 drivers/infiniband/sw/rxe/rxe_recv.c | 79 +++++++++++++++++++++-------
 2 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e947bcf75209..fb9959d91b8d 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -14,7 +14,10 @@
 struct rxe_pkt_info {
 	struct rxe_dev		*rxe;		/* device that owns packet */
 	struct rxe_qp		*qp;		/* qp that owns packet */
-	struct rxe_send_wqe	*wqe;		/* send wqe */
+	union {
+		struct rxe_send_wqe	*wqe;	/* send wqe */
+		struct rxe_srq		*srq;	/* srq for recvd xrc packets */
+	};
 	u8			*hdr;		/* points to bth */
 	u32			mask;		/* useful info about pkt */
 	u32			psn;		/* bth psn of packet */
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f3ad7b6dbd97..4f35757d3c52 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -13,49 +13,51 @@
 static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 			    struct rxe_qp *qp)
 {
-	unsigned int pkt_type;
+	unsigned int pkt_type = pkt->opcode & IB_OPCODE_TYPE;
 
 	if (unlikely(!qp->valid))
-		goto err1;
+		goto err_out;
 
-	pkt_type = pkt->opcode & 0xe0;
 
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
-		if (unlikely(pkt_type != IB_OPCODE_RC)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_RC))
+			goto err_out;
 		break;
 	case IB_QPT_UC:
-		if (unlikely(pkt_type != IB_OPCODE_UC)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_UC))
+			goto err_out;
 		break;
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
-		if (unlikely(pkt_type != IB_OPCODE_UD)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_UD))
+			goto err_out;
+		break;
+	case IB_QPT_XRC_INI:
+		if (unlikely(pkt_type != IB_OPCODE_XRC))
+			goto err_out;
+		break;
+	case IB_QPT_XRC_TGT:
+		if (unlikely(pkt_type != IB_OPCODE_XRC))
+			goto err_out;
 		break;
 	default:
-		pr_warn_ratelimited("unsupported qp type\n");
-		goto err1;
+		goto err_out;
 	}
 
 	if (pkt->mask & RXE_REQ_MASK) {
 		if (unlikely(qp->resp.state != QP_STATE_READY))
-			goto err1;
+			goto err_out;
 	} else if (unlikely(qp->req.state < QP_STATE_READY ||
 				qp->req.state > QP_STATE_DRAINED)) {
-		goto err1;
+		goto err_out;
 	}
 
 	return 0;
 
-err1:
+err_out:
+	pr_debug("%s: failed qp#%d: opcode = 0x%02x\n", __func__,
+			qp->elem.index, pkt->opcode);
 	return -EINVAL;
 }
 
@@ -166,6 +168,37 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	return -EINVAL;
 }
 
+static int check_xrcd(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
+		      struct rxe_qp *qp)
+{
+	int err;
+
+	struct rxe_xrcd *xrcd = qp->xrcd;
+	u32 srqn = xrceth_srqn(pkt);
+	struct rxe_srq *srq;
+
+	srq = rxe_pool_get_index(&rxe->srq_pool, srqn);
+	if (unlikely(!srq)) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	if (unlikely(srq->xrcd != xrcd)) {
+		rxe_put(srq);
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	pkt->srq = srq;
+
+	return 0;
+
+err_out:
+	pr_debug("%s: qp#%d: failed err = %d\n", __func__,
+			qp->elem.index, err);
+	return err;
+}
+
 static int hdr_check(struct rxe_pkt_info *pkt)
 {
 	struct rxe_dev *rxe = pkt->rxe;
@@ -205,6 +238,12 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		err = check_keys(rxe, pkt, qpn, qp);
 		if (unlikely(err))
 			goto err2;
+
+		if (qp_type(qp) == IB_QPT_XRC_TGT) {
+			err = check_xrcd(rxe, pkt, qp);
+			if (unlikely(err))
+				goto err2;
+		}
 	} else {
 		if (unlikely((pkt->mask & RXE_GRH_MASK) == 0)) {
 			pr_warn_ratelimited("no grh for mcast qpn\n");
-- 
2.34.1

