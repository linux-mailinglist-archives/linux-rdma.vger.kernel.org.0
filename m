Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815FE674267
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 20:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjASTL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 14:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjASTLc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 14:11:32 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB749966E8
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 11:10:52 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-15085b8a2f7so3719429fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rw0UJkixLISTyu8+QmOwxhr5K3k6rrBAkfySh9F21wI=;
        b=AaK2foRY2QtLR7iYdOI1leAKako2wjeB8JfODFqkqcSfCvChvDelmcFEoR8pEHwJik
         DlMBdwbnCLXRAGzqYehAA14YrycyDZ1RwrLR9OGdxAyc73UfixRiFyiWVs+yIBcAUda/
         08+58Tf7okP6FcMCSCGFxyCRTJy0iYV0OybO6QwKyC4FbmqrIjp+x6hF+oq8UQzyn3vC
         dRGtokCTHx7rOxEWFvXDFlwUifcEsI+M70MT/bxXvnPgPDeJ5k6Vt3Pc/29MuE2YfWRW
         jEszhuIrPXmPODkriXeKrs+Qbn/g/7QzWEweK+s+G+JLSLCYFtJoyd2Z4oJSLSwv/sWE
         xVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw0UJkixLISTyu8+QmOwxhr5K3k6rrBAkfySh9F21wI=;
        b=KZtiDYR5LkykWNDZzPU1MEfUylM7yPT6jKP0wVgR9lLl2FbmobOiqD9YZLsSjfQHwA
         v8+M8Wl4rPngWveHJKDJYICHIMHGRtrR78/GrPYR96BzkbIE3ijKeb6pq/tDCF3iKnjd
         cVp7EWgnC194oIyskcR7AVswGR0NEL2CVBl9Qq5XcIQhkDvWrnGLIrM8Pitgk7q6aAMu
         9wS0GNrTPRfyQspeOkaBrIeMosSVBVSdB07rhVHx07jAVaEZo+0YTHxbc7WqTaQNjXq4
         wpxLKjFhlQvAlOgZHELKxQdbwMSJ9pmZxnmh+1VnW7r19MuIAXZm6FYRy3s17uTAFO+4
         842A==
X-Gm-Message-State: AFqh2kpFNwcnNm9yKohvesx+J327MbWdOyl7m/CkW55sNC1pZDljNekZ
        TB+hf2a5egOUvdXFy4vMkbA=
X-Google-Smtp-Source: AMrXdXvBMjxGYsq/GXfWfxDQb4ZBj7ThZoPkoj4JkDiPwZq0HrVV80nf9hxVSdzdDMNNB0RT4OeapQ==
X-Received: by 2002:a05:6870:82a2:b0:144:1ba:3c67 with SMTP id q34-20020a05687082a200b0014401ba3c67mr7839802oae.51.1674155383153;
        Thu, 19 Jan 2023 11:09:43 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id x63-20020acae042000000b0035418324b78sm18353636oig.11.2023.01.19.11.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:09:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Handle zero length cases correctly
Date:   Thu, 19 Jan 2023 13:06:54 -0600
Message-Id: <20230119190653.6363-1-rpearsonhpe@gmail.com>
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

Currently the rxe driver, in rare situations, can respond incorrectly
to zero length operations which are retried. The client does not
have to provide an rkey for zero length RDMA operations so the rkey
may be invalid. The driver saves this rkey in the responder resources
to replay the rdma operation if a retry is required so the second pass
will use this (potentially) invalid rkey which may result in memory
faults.

This patch corrects the driver to ignore the provided rkey if the
reth length is zero and make sure to set the mr to NULL. In read_reply()
if the length is zero the MR is set to NULL. Warnings are added in
the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c   |  9 +++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 36 +++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 072eac4b65d2..134a74f315c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -267,6 +267,9 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	int m, n;
 	void *addr;
 
+	if (WARN_ON(!mr))
+		return NULL;
+
 	if (mr->state != RXE_MR_STATE_VALID) {
 		rxe_dbg_mr(mr, "Not in valid state\n");
 		addr = NULL;
@@ -305,6 +308,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
 	if (length == 0)
 		return 0;
 
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
 	if (mr->ibmr.type == IB_MR_TYPE_DMA)
 		return -EFAULT;
 
@@ -349,6 +355,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (length == 0)
 		return 0;
 
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c74972244f08..a528dc25d389 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -457,13 +457,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
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
@@ -512,8 +522,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 	/* A zero-byte op is not required to set an addr or rkey. See C9-88 */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
-	    (pkt->mask & RXE_RETH_MASK) &&
-	    reth_len(pkt) == 0) {
+	    (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
+		qp->resp.mr = NULL;
 		return RESPST_EXECUTE;
 	}
 
@@ -592,6 +602,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	return RESPST_EXECUTE;
 
 err:
+	qp->resp.mr = NULL;
 	if (mr)
 		rxe_put(mr);
 	if (mw)
@@ -966,7 +977,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	if (res->state == rdatm_res_state_new) {
-		if (!res->replay) {
+		if (qp->resp.length == 0) {
+			mr = NULL;
+			qp->resp.mr = NULL;
+		} else if (!res->replay) {
 			mr = qp->resp.mr;
 			qp->resp.mr = NULL;
 		} else {
@@ -980,9 +994,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		else
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
-		mr = rxe_recheck_mr(qp, res->read.rkey);
-		if (!mr)
-			return RESPST_ERR_RKEY_VIOLATION;
+		if (qp->resp.length == 0) {
+			mr = NULL;
+		} else {
+			mr = rxe_recheck_mr(qp, res->read.rkey);
+			if (!mr)
+				return RESPST_ERR_RKEY_VIOLATION;
+		}
 
 		if (res->read.resid > mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
-- 
2.37.2

