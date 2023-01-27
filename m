Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7F67F020
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 22:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjA0VJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 16:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjA0VJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 16:09:44 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2C88CCC
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 13:09:42 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15ff0a1f735so8160958fac.5
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 13:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfzPov0IOMaXRm7fK+JrphQk4qNL7fhkGwIRLQDy6xM=;
        b=N3ypDSM24KmzfNdZnqW/T/PN52sTOSgeNVYH2a+szh6xf0b6MO2MaFjrs8jOlTmcbz
         eG6auyAO4jcD9x2v3bCPla432c0JaDtZOpd2fvh6Wdu/D9yvom4nZbCxmRmIsq+1tlXD
         Fu83lgb4cTo14AEZseKGU81BhJeIw8f7/j4kmQyMZfSG1QasPjMmkpOOO67y1c2+iRZu
         lR+G+xcz8qAu+W7dbyr6FLLLTabjWW4SS/sPBPjHVKkhEOLHTaqycrGDaZhygrwBDZE6
         obXoIDv7ZkqakSa1SnLJ0v3zv0eekUGK9kHZUiR+HyTTYYI5AljjdyQ9Tf65p+KCcEQD
         3FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfzPov0IOMaXRm7fK+JrphQk4qNL7fhkGwIRLQDy6xM=;
        b=0ifPnhSwqN0dCIbK6DX5ulgecRZv52RYYlubt7b3yFzbxDU9BNefBB/G3BDFbWoTTg
         84UGaw+TNuzX4qLqny1mYwai2f8sk4GAodObQf8wN/U0zzvjpzf+wmxhZ/XbyCrisyJi
         lpkr34AUjpDhQZHc0s4Crvrh97wT68FZ2LAG03Hr52sHX/zyNKmJU4JxJUS5L1FqHLuc
         p42EM2YDaqAxrqZvCFxi437YoxSA3JzyyJfLVDIYUkCiUMFxWloNtieopuOW+jWBrNFj
         vIZmwXjHtdcan7xJDboT86X1howP4G6tNm8OuOxYVMKpi8TRgKGg9Ri5ob4lWYrrob0K
         o8Xw==
X-Gm-Message-State: AO0yUKWmVxNvKhDXxC1MDoepWbd5utKh2NjgOSlSsvGGybQyAdPUY7ct
        4d3klgc9EYgJwxbPz5dIKuM=
X-Google-Smtp-Source: AK7set9JZ1OY43ahvIx09xT2BaR1k14memFEHhPvLa976w00Q2jZ1wEJEeodzwXcwaIIf/b/hDnTOw==
X-Received: by 2002:a05:6870:e304:b0:163:3bae:2436 with SMTP id z4-20020a056870e30400b001633bae2436mr6851915oad.33.1674853782242;
        Fri, 27 Jan 2023 13:09:42 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id gq11-20020a056870d90b00b001435fe636f2sm2358336oab.53.2023.01.27.13.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:09:41 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijia@fujitsu.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3] Subject: RDMA/rxe: Handle zero length rdma
Date:   Fri, 27 Jan 2023 15:09:38 -0600
Message-Id: <20230127210938.30051-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Currently the rxe driver does not handle all cases of zero length
rdma operations correctly. The client does not have to provide an
rkey for zero length RDMA operations so the rkey provided may be
invalid and should not be used to lookup an mr.

This patch corrects the driver to ignore the provided rkey if the
reth length is zero and make sure to set the mr to NULL. In read_reply()
if length is zero rxe_recheck_mr() is not called. Warnings are added in
the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3:
  Fixed my fat finger typing on v2. Mangled the patch.

v2:
  Rebased to current for-next.
  Cleaned up description to be a little more accurate.
---
 drivers/infiniband/sw/rxe/rxe_mr.c   |  6 +++
 drivers/infiniband/sw/rxe/rxe_resp.c | 55 +++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c80458634962..5b7ede1d2b08 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -314,6 +314,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	if (length == 0)
 		return 0;
 
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		rxe_mr_copy_dma(mr, iova, addr, length, dir);
 		return 0;
@@ -435,6 +438,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 	if (length == 0)
 		return 0;
 
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
 	if (mr->ibmr.type == IB_MR_TYPE_DMA)
 		return -EFAULT;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index cd2d88de287c..b13ae98400c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -420,13 +420,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 	return RESPST_CHK_RKEY;
 }
 
+/* if the reth length field is zero we can assume nothing
+ * about the rkey value and should not validate or use it.
+ * Instead set qp->resp.rkey to 0 which is an invalid rkey
+ * value since the minimum index part is 1.
+ */
 static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
+	unsigned int length = reth_len(pkt);
+
 	qp->resp.va = reth_va(pkt);
 	qp->resp.offset = 0;
-	qp->resp.rkey = reth_rkey(pkt);
-	qp->resp.resid = reth_len(pkt);
-	qp->resp.length = reth_len(pkt);
+	qp->resp.resid = length;
+	qp->resp.length = length;
+	if (length)
+		qp->resp.rkey = reth_rkey(pkt);
+	else
+		qp->resp.rkey = 0;
 }
 
 static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
@@ -437,6 +447,10 @@ static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 	qp->resp.resid = sizeof(u64);
 }
 
+/* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
+ * if an invalid rkey is received or the rdma length is zero. For middle
+ * or last packets use the stored value of mr.
+ */
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -475,8 +489,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 	/* A zero-byte op is not required to set an addr or rkey. See C9-88 */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
-	    (pkt->mask & RXE_RETH_MASK) &&
-	    reth_len(pkt) == 0) {
+	    (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
+		qp->resp.mr = NULL;
 		return RESPST_EXECUTE;
 	}
 
@@ -555,6 +569,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	return RESPST_EXECUTE;
 
 err:
+	qp->resp.mr = NULL;
 	if (mr)
 		rxe_put(mr);
 	if (mw)
@@ -885,7 +900,11 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	if (res->state == rdatm_res_state_new) {
-		if (!res->replay) {
+		if (!res->replay || qp->resp.length == 0) {
+			/* if length == 0 mr will be NULL (is ok)
+			 * otherwise qp->resp.mr holds a ref on mr
+			 * which we transfer to mr and drop below.
+			 */
 			mr = qp->resp.mr;
 			qp->resp.mr = NULL;
 		} else {
@@ -899,6 +918,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		else
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
+		/* re-lookup mr from rkey on all later packets.
+		 * length will be non-zero. This can fail if someone
+		 * modifies or destroys the mr since the first packet.
+		 */
 		mr = rxe_recheck_mr(qp, res->read.rkey);
 		if (!mr)
 			return RESPST_ERR_RKEY_VIOLATION;
@@ -916,18 +939,16 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
 	if (!skb) {
-		if (mr)
-			rxe_put(mr);
-		return RESPST_ERR_RNR;
+		state = RESPST_ERR_RNR;
+		goto err_out;
 	}
 
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
-	if (mr)
-		rxe_put(mr);
 	if (err) {
 		kfree_skb(skb);
-		return RESPST_ERR_RKEY_VIOLATION;
+		state = RESPST_ERR_RKEY_VIOLATION;
+		goto err_out;
 	}
 
 	if (bth_pad(&ack_pkt)) {
@@ -936,9 +957,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		memset(pad, 0, bth_pad(&ack_pkt));
 	}
 
+	/* rxe_xmit_packet always consumes the skb */
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err)
-		return RESPST_ERR_RNR;
+	if (err) {
+		state = RESPST_ERR_RNR;
+		goto err_out;
+	}
 
 	res->read.va += payload;
 	res->read.resid -= payload;
@@ -955,6 +979,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		state = RESPST_CLEANUP;
 	}
 
+err_out:
+	if (mr)
+		rxe_put(mr);
 	return state;
 }
 
-- 
2.37.2

