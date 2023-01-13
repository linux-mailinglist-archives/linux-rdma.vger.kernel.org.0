Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118A5668857
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjAMAWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbjAMAWC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:22:02 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1295E0A3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:01 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id c133so16612981oif.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cMYBl2bdj14CeKwrqesCZHwPq5LHtvDyw+b1CHA+zo=;
        b=GYkvaKDwjxKMieN85UvGuJDcx34Q+/jsGhil3uFcuM1cOeoQVNp+t9mYLFtldJMgzm
         wXeqhu9C9C7Z+xvxRHyWqWKrhyv4ZwLC8D3FZubHM6B2HmbEnPytRyjZDys3QvlVkAnm
         OIez0Dx2K0WqJTshGR9iawxM4yJMnACnq0QsNDM7s2vt82Vy+HWRLiAnOhcLPiP0wdLZ
         Soss408jhLO7jALRkb+e5DTCxZq4+aduRdwz0jjfZP/sr6aUE6Yz4GHBua/kCW3j9DOO
         M/eY5Dd7dkQvSKjuLeW4t7ZlDMK7/UCWxx+NKUfAQsHEWz+AuVdFXINW4zR1CgpAsvCY
         zRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cMYBl2bdj14CeKwrqesCZHwPq5LHtvDyw+b1CHA+zo=;
        b=wxoOMvAwKjQbI38NbuGG3yv2tzRP6TyTH0KVy/DKFYZ7oAh1IcmfW6l1NMqQG5VbeJ
         9uhi2Mhsx9bzUzYPXvAz+5JXMTvwYUHIx0Vez3X6N3ssCVwlEqp2YEhM5dIm5r/lTqdi
         FIencGAI1ZqwGbFsuDTQhWVY8AkE6+tzvdrUXFSAnYrpeJE1pxypszX4EFvtZxcz/11V
         XNIr2CTS+vaxFZZEurP5sC6rT1tBjFY1oNuqTyZprRQkOcol6pWAGQZGW5DDXzxiXuhW
         xqEsrcixOOHZMORNDWkZQNGRpvz95zqvz4hk0Jyy21JXmLDyh8vVS65LZyVgMUTAHdYn
         imNw==
X-Gm-Message-State: AFqh2koPT/qt7pTpmM0r7lsj1T5DZO68xdVfnQrTaIeQR4ZGEgyo3SPj
        +bXykP8UMkapLqQm6Qi+n38=
X-Google-Smtp-Source: AMrXdXtVddxlyw0yCGJY+o9KMHn2w/QCEQIpsfuhZLG54vlX+KRnQuW8OrcckD+LLQ21ka7oPEFsXw==
X-Received: by 2002:a05:6808:4289:b0:35e:d5f9:62c6 with SMTP id dq9-20020a056808428900b0035ed5f962c6mr37101948oib.58.1673569320702;
        Thu, 12 Jan 2023 16:22:00 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:22:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
Date:   Thu, 12 Jan 2023 18:21:14 -0600
Message-Id: <20230113002116.457324-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113002116.457324-1-rpearsonhpe@gmail.com>
References: <20230113002116.457324-1-rpearsonhpe@gmail.com>
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
v2:
  Fixed missing if() after else in atomic_write_reply().

 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c   | 39 +++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 56 +++++++++++-----------------
 3 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bcb1bbcf50df..fd70c71a9e4e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 791731be6067..d11b38117e58 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -568,6 +568,45 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
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
index 02301e3f343c..b60404fd33b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -762,26 +762,33 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	return RESPST_ACKNOWLEDGE;
 }
 
-#ifdef CONFIG_64BIT
-static enum resp_states do_atomic_write(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
+static enum resp_states atomic_write_reply(struct rxe_qp *qp,
+					   struct rxe_pkt_info *pkt)
 {
+	u64 iova = qp->resp.va + qp->resp.offset;
+	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr = qp->resp.mr;
+	void *addr = payload_addr(pkt);
 	int payload = payload_size(pkt);
-	u64 src, *dst;
+	int err;
 
-	if (mr->state != RXE_MR_STATE_VALID)
-		return RESPST_ERR_RKEY_VIOLATION;
+	if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
+		qp->resp.res = res;
+	}
 
-	memcpy(&src, payload_addr(pkt), payload);
+	if (res->replay)
+		return RESPST_ACKNOWLEDGE;
 
-	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
-	/* check vaddr is 8 bytes aligned. */
-	if (!dst || (uintptr_t)dst & 7)
-		return RESPST_ERR_MISALIGNED_ATOMIC;
+#if !defined(CONFIG_64BIT)
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+#endif
 
-	/* Do atomic write after all prior operations have completed */
-	smp_store_release(dst, src);
+	err = rxe_mr_do_atomic_write(mr, iova, addr);
+	if (err == -1)
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+	else if (err)
+		return RESPST_ERR_RKEY_VIOLATION;
 
 	/* decrease resp.resid to zero */
 	qp->resp.resid -= sizeof(payload);
@@ -794,29 +801,8 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
 
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
-
-static enum resp_states atomic_write_reply(struct rxe_qp *qp,
-					   struct rxe_pkt_info *pkt)
-{
-	struct resp_res *res = qp->resp.res;
 
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

