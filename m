Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25166477A6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLHVGY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLHVGW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:06:22 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6E57B67
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:06:19 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1443a16b71cso3269093fac.13
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1pUMytqhtBY/jTwSRDI2weK0gGjSheYgKwOWiZQ8C0=;
        b=hKX12Oa58Uiu84ehj0BDVP3a1PUeplg8+AHei66OCD+AA/xLfwH/9vC0NP/3+0umDS
         edru6Gkfqx9hEg2k3SmTizURxYVvD5lxCOKSQ9qvUn2PbsuFJ4JHg/R9/3zzzYtkq3Qt
         iDog42n4swZqYKeBPhkY5kke0S/EhOThRoICctT5XvdnUGuCtQE6xoewyjtZLnrdMdXN
         FmL7G8oK4Tk38V1dB0b7GPJ6MUdPnXXvPWLx2S5LIjr5MOnYBH4eMTmRWAKqPQhWb4nY
         oUxiJNqQlPwFdFDJA1Fo52D8vCNCsGl/7tUNz2K7ek0XR3tr5DZtSCwhsVHMgttmnaSI
         WmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1pUMytqhtBY/jTwSRDI2weK0gGjSheYgKwOWiZQ8C0=;
        b=Bajdlp7z5pdyE1KRnX4KQhPVUcB80H3i/UbT+ba1Djspm0YVC1MiI/HzJFQ67DGiZ3
         sDOjtldhHf6M7PMCNXxwRo8UQ5aI596Um8viFNGZkANDye9yqIKhkdXi8Wd0mIU+DrOm
         4dwZQqipuYOwc2tSOS4diSmBnn4tKAXQCagXoLXdIw6ZiJYc0pTj2or/grpZ2Btnz2hl
         zvGfjuh5BeiIUB6CgFeflr11Tv7gZI0evtxn6uVjwtyBpulWpOT70gCI8ockzuLJDZIC
         sMRzdm72457OUW8vfRmksI2KAX9uM71l8PWtsJIjKSsd87Srj2EhOeN4H5L11jpo49ug
         iZnQ==
X-Gm-Message-State: ANoB5pkirN+cW2NAYp8Mg8wJUZQ73BeEbWExxyZ1qnQOEXMyU0ZUZ+6E
        q246xBYI1CkjvJNBlozXu/LZ64iRDfs=
X-Google-Smtp-Source: AA0mqf7rceE4BviQJ775hYbJtY0JKg3IyB3qNOvYWJh0X3p7KwOx6XoGX9934UEozqsZ3l01KbQHQA==
X-Received: by 2002:a05:6870:1ece:b0:144:7a86:ae39 with SMTP id pc14-20020a0568701ece00b001447a86ae39mr1930789oab.7.1670533579401;
        Thu, 08 Dec 2022 13:06:19 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id t11-20020a056870e74b00b0012763819bcasm5739250oak.50.2022.12.08.13.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:18 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
Date:   Thu,  8 Dec 2022 15:05:46 -0600
Message-Id: <20221208210547.28562-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208210547.28562-1-rpearsonhpe@gmail.com>
References: <20221208210547.28562-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c   | 41 +++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c | 25 ++++++-----------
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b14607bb54b1..e1bb977cdbc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -73,6 +73,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index ec3c8e6e8318..c6aa86d28b89 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -495,7 +495,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	/* needs to match rxe_resp.c */
 	if (mr->state != RXE_MR_STATE_VALID || !vaddr)
 		return -EFAULT;
-	if (vaddr & 7)
+	if ((uintptr_t)vaddr & 7)
 		return -EINVAL;
 
 	spin_lock_bh(&atomic_ops_lock);
@@ -514,6 +514,45 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	return 0;
 }
 
+/*
+ * Returns:
+ *	 0 on success
+ *	-1 for misaligned address
+ *	-2 for access errors
+ */
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
+{
+	u64 *vaddr;
+	u64 value;
+	unsigned int length = 8;
+
+	/* See IBA oA19-28 */
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not valid");
+		return -2;
+	}
+
+	/* See IBA A19.4.2 */
+	if (unlikely((uintptr_t)vaddr & 0x7 || iova & 0x7)) {
+		rxe_dbg_mr(mr, "misaligned address");
+		return -1;
+	}
+
+	vaddr = iova_to_vaddr(mr, iova, length);
+	if (unlikely(!vaddr)) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return -2;
+	}
+
+	/* this makes no sense. What of payload is not 8? */
+	memcpy(&value, addr, length);
+
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(vaddr, value);
+
+	return 0;
+}
+
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 17192e768a2d..abe9cfd935c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -654,12 +654,12 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 }
 
 static enum resp_states atomic_write_reply(struct rxe_qp *qp,
-						struct rxe_pkt_info *pkt)
+					   struct rxe_pkt_info *pkt)
 {
-	u64 src, *dst;
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr = qp->resp.mr;
-	int payload = payload_size(pkt);
+	void *addr = payload_addr(pkt);
+	int err;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
@@ -668,22 +668,15 @@ static enum resp_states atomic_write_reply(struct rxe_qp *qp,
 
 	if (!res->replay) {
 #ifdef CONFIG_64BIT
-		if (mr->state != RXE_MR_STATE_VALID)
-			return RESPST_ERR_RKEY_VIOLATION;
-
-		memcpy(&src, payload_addr(pkt), payload);
+		u64 iova = qp->resp.va + qp->resp.offset;
 
-		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
-		/* check vaddr is 8 bytes aligned. */
-		if (!dst || (uintptr_t)dst & 7)
+		err = rxe_mr_do_atomic_write(mr, iova, addr);
+		if (err == -1)
 			return RESPST_ERR_MISALIGNED_ATOMIC;
+		else
+			return RESPST_ERR_RKEY_VIOLATION;
 
-		/* Do atomic write after all prior operations have completed */
-		smp_store_release(dst, src);
-
-		/* decrease resp.resid to zero */
-		qp->resp.resid -= sizeof(payload);
-
+		qp->resp.resid -= 8;
 		qp->resp.msn++;
 
 		/* next expected psn, read handles this separately */
-- 
2.37.2

