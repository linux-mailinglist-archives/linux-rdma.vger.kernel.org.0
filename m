Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9500562297
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiF3TFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiF3TFJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:09 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73EF37034
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:08 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-101b4f9e825so505319fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1aodIcPkHUv4RoA42hxgdLDPNogfGmfi8vqfC5gmTM=;
        b=cMP0tGo4ocax7yvPbl8X9J1N4o2MDQyRurLnPS5NE++saHeFvO0vyVpNhh78Ca0vaU
         xKsS72TG25EEjDzB3O9p62eKTsgzS4MPUZgmjbUMhITcatMSPmemjXurHPvmn1cjjf1R
         xxT3rp6a5zjuGsn/CsoSBTZjCgdwoIP9lmT6oA/hNSRBJLI24h0A/O91QyCp5SEY1QEL
         zU/ys+k0ui6t693gvV6Kf8Gj6cPQWzvGLbOT7AtDV6wY/25w0HlLqROcwj4+yVUFM7u5
         cgc/bx+A2Nq7WDQkKX8qA4WuTBJiwpU7TK3W+tdq2xFX3nH96l+EaGegqc+kAWpbcGr9
         aaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1aodIcPkHUv4RoA42hxgdLDPNogfGmfi8vqfC5gmTM=;
        b=3h1vZlkjY+L2pd33nXwqpOGzaG0+3lLvyAXS5xygF0CaZU2iYdzQZ4T/bo26nVGPED
         7y/20Xn+/5XthWbJBuTKvTG/aW1Pa+wK5e5ftuf+srgaMPXd9yxAuK9w18bUyiFLct0e
         vI/hYnw0ffbJs++o5yIygNe8IGlfGfqg6Muj99GFTfgpG3YAs39jgo3jGnvNJ1PNmSDE
         Rje62cj3iUrx4f1zQiXq7fgDk8RDnW+mYGlOmvaTkTUi3ZqmN6w73KOE0x9Jq4N1aF9S
         ZrNqiNikYwnef1hii34toEX3pBjiqiBPeTb3/Oy4lymwC8hV3yPNf5CtUQYUxJ6isjDS
         4DSw==
X-Gm-Message-State: AJIora9lymaNYRRz2+sLzZJy0bW4pwVCQ9RrVm9QUcnf0bfY0G9BSCy5
        CWT8oG0sX8P0GmGi1rRGqY7tG0Jz88+/Yw==
X-Google-Smtp-Source: AGRyM1tAu6tuqTgaNepZRPATEpKnplieihid/lv4UDbsOQ07kzeDy3j5kbnDDWFsFTckCbNas7Tunw==
X-Received: by 2002:a05:6870:5819:b0:101:f651:99a2 with SMTP id r25-20020a056870581900b00101f65199a2mr6100840oap.167.1656615908048;
        Thu, 30 Jun 2022 12:05:08 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/9] RDMA/rxe: Add rxe_is_fenced() subroutine
Date:   Thu, 30 Jun 2022 14:04:18 -0500
Message-Id: <20220630190425.2251-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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

The code thc that decides whether to defer execution of a wqe in
rxe_requester.c is isolated into a subroutine rxe_is_fenced()
and removed from the call to req_next_wqe(). The condition whether
a wqe should be fenced is changed to comply with the IBA. Currently
an operation is fenced if the fence bit is set in the wqe flags and
the last wqe has not completed. For normal operations the IBA
actually only requires that the last read or atomic operation is
complete. 

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2 replaces "RDMA/rxe: Fix incorrect fencing"

 drivers/infiniband/sw/rxe/rxe_req.c | 37 ++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 9d98237389cf..e8a1664a40eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -161,16 +161,36 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
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
+ * Returns: 1 if wqe needs to wait
+ *	    0 if wqe is ready to go
+ */
+static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	/* Local invalidate fence (LIF) see IBA 10.6.5.1
+	 * Requires ALL previous operations on the send queue
+	 * are complete. Make mandatory for the rxe driver.
+	 */
+	if (wqe->wr.opcode == IB_WR_LOCAL_INV)
+		return qp->req.wqe_index != queue_get_consumer(qp->sq.queue,
+						QUEUE_TYPE_FROM_CLIENT);
+
+	/* Fence see IBA 10.8.3.3
+	 * Requires that all previous read and atomic operations
+	 * are complete.
+	 */
+	return (wqe->wr.send_flags & IB_SEND_FENCE) &&
+		atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
+}
+
 static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 {
 	switch (opcode) {
@@ -632,6 +652,11 @@ int rxe_requester(void *arg)
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
-- 
2.34.1

