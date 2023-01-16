Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708166D37C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjAPX7M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjAPX6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:58:46 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC52C66F
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:52 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i5so6418246oih.11
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q6oRI/jJlGEjhfTY3sZkztExTr0+SXp9sacBMOPdxI=;
        b=B53nm+/XasQHc308O0v5VgoiNrKPH11idFA9llRXxrUnv75aRn74rLhdQN42AbdepV
         VU7LGM+iB1Zl+wgpLp9x6VN+iZcUv+0n1C3NyIegv2vYVRoAvVIyg/lFojh1wwMUWWcD
         Q889qauTKq2RjSIkymBnW6mSROw7uJM2aLp9r4CZrus2/3f33eCKyntx1JfpV2D9Yzm2
         3TScCHIfnS4Tu37cM4BlsPfoOudaYMfoxsYJ4kT++dUD4js1EcZbN9WzEwbrW+TIELkP
         2CcoeOUWJeTs9yOJNwpJ9wMHHQ09y4myvNJMnV8B0nqCC3Jyn4ppoKGylRpfDPi4oFgT
         VZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q6oRI/jJlGEjhfTY3sZkztExTr0+SXp9sacBMOPdxI=;
        b=eNfFl0VN9kOrY8YGA2fwvXYUS+lGd3h8Dijcg7mgUsEBwU9vehItkWPosWu0nEM5bh
         +i1zKG6bV1zvk9m5yMVsENJGi0EgS6oDqV9LZ3nS3BAEohkXAofg9qL9Y3SXa9Ul0vV1
         nnfm63Z2EjhqIiGLtVsQEh1KGIXx+ODHU1SP9L12fFrWT3L/dFVcuIsBHBE/RdPtXXda
         o0oqNHQxSKJkzk1Xk+Jv71helxngEM76OfFQLKdDfPHEybJGV6Jq8gESD3LiiMHSrwDG
         MDF4sgIg4SG6yoOXnOsgTuMGH6lV6SNG3ZbpaMkSKD1dMhZFCliLM02MtsQodJa1bb4b
         cTPA==
X-Gm-Message-State: AFqh2koFzydvVuYDS3Rg1Z/LnAvf+umIBSIiEX7xJvRRMxFtUbWxYZdU
        PtBPrcwWT/tbBDsd0lTuJY81yEtb4xAKbw==
X-Google-Smtp-Source: AMrXdXvBtUhZaZoOAUfWgRxQ3basqBm5EncktPUsdSfsN8G0XEJTHfFLJzCa1dearfwNhPKLfzREhg==
X-Received: by 2002:a05:6808:1708:b0:363:ac4d:810a with SMTP id bc8-20020a056808170800b00363ac4d810amr635713oib.15.1673913412092;
        Mon, 16 Jan 2023 15:56:52 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b00684e55f4541sm3540546otl.70.2023.01.16.15.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 15:56:51 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
Date:   Mon, 16 Jan 2023 17:56:01 -0600
Message-Id: <20230116235602.22899-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116235602.22899-1-rpearsonhpe@gmail.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
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

Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
Check length for atomic write operation.
Make iova_to_vaddr() static.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c   | 34 ++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 69 ++++++++++++----------------
 3 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bcb1bbcf50df..b1dda0cf891b 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 15a8d44daa35..10484f671977 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -565,6 +565,40 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	return 0;
 }
 
+/* only implemented for 64 bit architectures */
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+#if defined CONFIG_64BIT
+	u64 *va;
+
+	/* See IBA oA19-28 */
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not in valid state");
+		return -EINVAL;
+	}
+
+	va = iova_to_vaddr(mr, iova, sizeof(value));
+	if (unlikely(!va)) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return -ERANGE;
+	}
+
+	/* See IBA A19.4.2 */
+	if (unlikely((uintptr_t)va & 0x7 || iova & 0x7)) {
+		rxe_dbg_mr(mr, "misaligned address");
+		return -RXE_ERR_NOT_ALIGNED;
+	}
+
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(va, value);
+
+	return 0;
+#else
+	WARN_ON(1);
+	return -EINVAL;
+#endif
+}
+
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 1e38e5da1f4c..49298ff88d25 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -764,30 +764,40 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	return RESPST_ACKNOWLEDGE;
 }
 
-#ifdef CONFIG_64BIT
-static enum resp_states do_atomic_write(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
+static enum resp_states atomic_write_reply(struct rxe_qp *qp,
+					   struct rxe_pkt_info *pkt)
 {
-	struct rxe_mr *mr = qp->resp.mr;
-	int payload = payload_size(pkt);
-	u64 src, *dst;
-
-	if (mr->state != RXE_MR_STATE_VALID)
-		return RESPST_ERR_RKEY_VIOLATION;
+	struct resp_res *res = qp->resp.res;
+	struct rxe_mr *mr;
+	u64 value;
+	u64 iova;
+	int err;
 
-	memcpy(&src, payload_addr(pkt), payload);
+	if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
+		qp->resp.res = res;
+	}
 
-	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
-	/* check vaddr is 8 bytes aligned. */
-	if (!dst || (uintptr_t)dst & 7)
-		return RESPST_ERR_MISALIGNED_ATOMIC;
+	if (res->replay)
+		return RESPST_ACKNOWLEDGE;
 
-	/* Do atomic write after all prior operations have completed */
-	smp_store_release(dst, src);
+	mr = qp->resp.mr;
+	value = *(u64 *)payload_addr(pkt);
+	iova = qp->resp.va + qp->resp.offset;
 
-	/* decrease resp.resid to zero */
-	qp->resp.resid -= sizeof(payload);
+#if defined CONFIG_64BIT
+	err = rxe_mr_do_atomic_write(mr, iova, value);
+	if (unlikely(err)) {
+		if (err == -RXE_ERR_NOT_ALIGNED)
+			return RESPST_ERR_MISALIGNED_ATOMIC;
+		else
+			return RESPST_ERR_RKEY_VIOLATION;
+	}
+#else
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+#endif
 
+	qp->resp.resid = 0;
 	qp->resp.msn++;
 
 	/* next expected psn, read handles this separately */
@@ -796,29 +806,8 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
 
 	qp->resp.opcode = pkt->opcode;
 	qp->resp.status = IB_WC_SUCCESS;
-	return RESPST_ACKNOWLEDGE;
-}
-#else
-static enum resp_states do_atomic_write(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
-{
-	return RESPST_ERR_UNSUPPORTED_OPCODE;
-}
-#endif /* CONFIG_64BIT */
 
-static enum resp_states atomic_write_reply(struct rxe_qp *qp,
-					   struct rxe_pkt_info *pkt)
-{
-	struct resp_res *res = qp->resp.res;
-
-	if (!res) {
-		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
-		qp->resp.res = res;
-	}
-
-	if (res->replay)
-		return RESPST_ACKNOWLEDGE;
-	return do_atomic_write(qp, pkt);
+	return RESPST_ACKNOWLEDGE;
 }
 
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
-- 
2.37.2

