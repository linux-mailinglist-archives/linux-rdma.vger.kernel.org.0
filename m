Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA52530692
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiEVWgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 May 2022 18:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbiEVWgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 May 2022 18:36:16 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6310D13D16
        for <linux-rdma@vger.kernel.org>; Sun, 22 May 2022 15:36:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so16326424fac.11
        for <linux-rdma@vger.kernel.org>; Sun, 22 May 2022 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2Oo2lVZagsxhF87eeWO2gCYR0KMVIpAlrOXxxg61OM=;
        b=TND23Llr4tZbFMmyX2Zabumw8saLOPX7JQ22i2d+gTvBDp4dFyAFfL23hodM2h8Nfb
         T3cXviG8fyFDhIfCHmtWzQ3g+jy9JHsa/4VvSYD9L/jA7OtY8XzejD27+XC+MYWisNiE
         IvzR9jlh2xYirVk1j/kjc2xwKioUPGD9LXwuW1D7AnKQZilZvyks7nA7No55JkuMgqcU
         H6EfI9Vl1JfaVXpWOn0guhA41kW/u4yD3FOrB0q74ZYnY1DIUfQMo1cgx59iCgMGPley
         wC2gVYvkAyn8LPaKAw47XZskGxBSsK4GXUv7aoalccdM+IJkkGHos/Ovf82DSl3yKqVj
         Pdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2Oo2lVZagsxhF87eeWO2gCYR0KMVIpAlrOXxxg61OM=;
        b=DZnx7fR88A+It6X0YDOOyOWT9yUlzIjcXq9yeHGkxJNyAVpsgLw1f3hU4C5FR94ua0
         BAmA4qNCJozfCpxbp7F2FkY6Rl8ic+AOhyUWRIe/4RSKnB4cAm/Pu6gPhUTo/EyGwqTt
         ktALtvN2uIHMGRqotj9r9jkj3rz8nSZG3I1Fwj5CerGHBASJ1IFeV9eslC5v3iQS6hMH
         86wV4oJkmOAz/aQWDddOE9sEAD7k7XF4/pD15UuFQEL/wDpFvA7BJBScquhRPGIBbg8l
         ztvQOvBipbhjNb3e5mngeIga+IkPb3iukeQhs39ScX7uDIQ20rhErwYxATJHqDqPSAZn
         IXZA==
X-Gm-Message-State: AOAM532Ny+ny3NRmoiCzt0tnBa5i5+TsggfWZqxR1a13Y01CZZD+Cjrd
        o41qRmnThOlO7Zm1XPv/NmA=
X-Google-Smtp-Source: ABdhPJzS0xR1X+MelLyaLL+ratr+qD6gLwz6mpFTFvV1y+B9JQWZQOmulJ20IM/MPCiE6oK//bG/VA==
X-Received: by 2002:a05:6870:831a:b0:f2:2076:2a64 with SMTP id p26-20020a056870831a00b000f220762a64mr5198604oae.131.1653258973930;
        Sun, 22 May 2022 15:36:13 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id 37-20020a9d0628000000b006060322125bsm3437385otn.43.2022.05.22.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 15:36:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        frank.zago@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix incorrect fencing
Date:   Sun, 22 May 2022 17:33:46 -0500
Message-Id: <20220522223345.9889-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently the rxe driver checks if any previous operation
is not complete to determine if a fence wait is required.
This is not correct. For a regular fence only previous
read or atomic operations must be complete while for a local
invalidate fence all previous operations must be complete.
This patch corrects this behavior.

Fixes: 8700e3e7c4857 ("Soft RoCE (RXE) - The software RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 42 ++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..f36263855a45 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -163,16 +163,41 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		     (wqe->state != wqe_state_processing)))
 		return NULL;
 
-	if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
-						     (index != cons))) {
-		qp->req.wait_fence = 1;
-		return NULL;
-	}
-
 	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
 	return wqe;
 }
 
+/**
+ * rxe_wqe_is_fenced - check if next wqe is fenced
+ * @qp: the queue pair
+ * @wqe: the next wqe
+ *
+ * Returns: 1 if wqe is fenced (needs to wait)
+ *	    0 if wqe is good to go
+ */
+static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	unsigned int cons;
+
+	if (!(wqe->wr.send_flags & IB_SEND_FENCE))
+		return 0;
+
+	cons = queue_get_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
+
+	/* Local invalidate fence (LIF) see IBA 10.6.5.1
+	 * Requires ALL previous operations on the send queue
+	 * are complete.
+	 */
+	if (wqe->wr.opcode == IB_WR_LOCAL_INV)
+		return qp->req.wqe_index != cons;
+
+	/* Fence see IBA 10.8.3.3
+	 * Requires that all previous read and atomic operations
+	 * are complete.
+	 */
+	return atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
+}
+
 static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 {
 	switch (opcode) {
@@ -636,6 +661,11 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
+	if (rxe_wqe_is_fenced(qp, wqe)) {
+		qp->req.wait_fence = 1;
+		goto exit;
+	}
+
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
 		ret = rxe_do_local_ops(qp, wqe);
 		if (unlikely(ret))

base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.34.1

