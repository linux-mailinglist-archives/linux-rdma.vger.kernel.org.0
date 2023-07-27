Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26501765CC8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjG0UCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjG0UCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557B30E4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:18 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9b52724ccso1148106a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488137; x=1691092937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu2AzmnhmIAxsIEl63itDqucf1tROo4Hpkt+Wu5kh0k=;
        b=OY/QVg+2iR66q77HxDKF0PLVggff7dpPKcks1j3EGmZn2b29u8B/MD+rWetzlMtV9G
         NSVRYxOkaEHjsbCtAcUZHWSTEsdzNhdgmnmQhiHbHHr4DYLgmKd7k88qe8i5a/NF1qRe
         lRZ8od8uuOMIhfPnCJbnZ2SqvRbuOFyShhHmLWXbUNaHza6KS/ilYvLM/ktctSX9vfDQ
         TB73NZEJgtxkURtYPLB59DgVlZS4ZsP7de81fgZylrghxML7LbDSFJSDeDTPYhnIsgJx
         PcitG4B/WjrgmKpK7P3VWUY8+DTBWMxWRwU0GpT61X5whTG7VoxS9cvFnThYK5Mxo57w
         SwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488137; x=1691092937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu2AzmnhmIAxsIEl63itDqucf1tROo4Hpkt+Wu5kh0k=;
        b=jXbI/Abbvo9CBlO/3jVvwqJGzx4imIEhgI2lAK1ERu1Uz/Tw7aZDNVu8NNVqDrWdaq
         ccvNJVdbHI3FZCYidUErvbBbpVi7dnEbRFbmBTYsTuxtsnNgusB5peM+5Renund/RHsw
         A/BZKgoD340nlMrYgy6bdp8usGqQI0RdU56Y6EIxrDrFF8PTN6cN7vJDXLe+2tVBD1yZ
         wHKlk/RSlo7AAAgCVQN1m/MC/399z7zKAQK4VbfSrYsIvW2A1ZRsJ+m7+PMP+Xpv6VsG
         YnjYwzuNNdo7qdDx9hOEFSsyVFeaAlXAbw1c31xZITITXkDuJsynLE4b2E7HmU5x63AB
         yBMg==
X-Gm-Message-State: ABy/qLYm2bLgLyZSDdkUwubVRQsai1AK7lEznMzXnw4Oa2vecqr4BWf/
        HxUNjdsXq0nk53nY8Yi2isc=
X-Google-Smtp-Source: APBJJlEvnwGW2/IL8E1JptvRWvALAUMc2LivVN0T/8+KsNYqpWGJ3UqbuIIQxkGeWzZJi+hJz2ozaA==
X-Received: by 2002:a05:6830:1e0b:b0:6b7:539f:d1b0 with SMTP id s11-20020a0568301e0b00b006b7539fd1b0mr174975otr.31.1690488137575;
        Thu, 27 Jul 2023 13:02:17 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 06/10] RDMA/rxe: Extend rxe_init_req_packet() for frags
Date:   Thu, 27 Jul 2023 15:01:25 -0500
Message-Id: <20230727200128.65947-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
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

Add code to rxe_build_req_packet() to allocate space for the
pad and icrc if the skb is fragmented.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h    |  5 ++
 drivers/infiniband/sw/rxe/rxe_mr.c     |  5 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c |  2 +
 drivers/infiniband/sw/rxe/rxe_req.c    | 83 ++++++++++++++++++++++----
 4 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 96b1fb79610a..40624de62288 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -177,7 +177,12 @@ void rxe_srq_cleanup(struct rxe_pool_elem *elem);
 void rxe_dealloc(struct ib_device *ib_dev);
 
 int rxe_completer(struct rxe_qp *qp);
+
+/* rxe_req.c */
+int rxe_prepare_pad_icrc(struct rxe_pkt_info *pkt, struct sk_buff *skb,
+			 int payload, bool frag);
 int rxe_requester(struct rxe_qp *qp);
+
 int rxe_responder(struct rxe_qp *qp);
 
 /* rxe_icrc.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0ac71238599a..5178775f2d4e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -263,7 +263,10 @@ int rxe_add_frag(struct sk_buff *skb, struct rxe_mr *mr, struct page *page,
 	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
 
 	if (nr_frags >= MAX_SKB_FRAGS) {
-		rxe_dbg_mr(mr, "ran out of frags");
+		if (mr)
+			rxe_dbg_mr(mr, "ran out of frags");
+		else
+			rxe_dbg("ran out of frags");
 		return -EINVAL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index f358b732a751..a72e5fd4f571 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -399,6 +399,8 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 			[RXE_BTH]	= 0,
 			[RXE_FETH]	= RXE_BTH_BYTES,
 			[RXE_RETH]	= RXE_BTH_BYTES + RXE_FETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES + RXE_FETH_BYTES +
+					  RXE_RETH_BYTES,
 		}
 	},
 	[IB_OPCODE_RC_ATOMIC_WRITE]                        = {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 491360fef346..cf34d1a58f85 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -316,26 +316,83 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			    struct rxe_pkt_info *pkt, u32 payload,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb, bool frag)
 {
+	int len = skb_tailroom(skb);
+	int tot_len = payload + pkt->pad + RXE_ICRC_SIZE;
+	int access = 0;
 	int skb_offset = 0;
+	int op;
+	void *addr;
 	void *data;
 	int err = 0;
 
 	if (wqe->wr.send_flags & IB_SEND_INLINE) {
+		if (WARN_ON(frag)) {
+			rxe_err_qp(qp, "inline data for fragmented skb not supported");
+			return -EINVAL;
+		}
+		if (len < tot_len) {
+			rxe_err_qp(qp, "skb too small");
+			return -EINVAL;
+		}
 		data = &wqe->dma.inline_data[wqe->dma.sge_offset];
 		memcpy(payload_addr(pkt), data, payload);
 		wqe->dma.resid -= payload;
 		wqe->dma.sge_offset += payload;
 	} else {
-		err = rxe_copy_dma_data(skb, qp->pd, 0, &wqe->dma,
-					payload_addr(pkt), skb_offset,
-					payload, RXE_COPY_FROM_MR);
+		op = frag ? RXE_FRAG_FROM_MR : RXE_COPY_FROM_MR;
+		addr = frag ? NULL : payload_addr(pkt);
+		err = rxe_copy_dma_data(skb, qp->pd, access, &wqe->dma,
+					addr, skb_offset, payload, op);
 	}
 
 	return err;
 }
 
+/**
+ * rxe_prepare_pad_icrc() - Alloc space if fragmented and init pad and icrc
+ * @pkt: packet info
+ * @skb: packet buffer
+ * @payload: roce payload
+ * @frag: true if skb is fragmented
+ *
+ * Returns: 0 on success else an error
+ */
+int rxe_prepare_pad_icrc(struct rxe_pkt_info *pkt, struct sk_buff *skb,
+			 int payload, bool frag)
+{
+	unsigned int length = RXE_ICRC_SIZE + pkt->pad;
+	unsigned int offset;
+	struct page *page;
+	u64 iova;
+	u8 *addr;
+
+	if (frag) {
+		addr = skb_end_pointer(skb) - length;
+		iova = (uintptr_t)addr;
+		page = virt_to_page(iova);
+		offset = iova & (PAGE_SIZE - 1);
+
+		/* make sure we have enough room and frag
+		 * doesn't cross page boundary should never
+		 * happen
+		 */
+		if (WARN_ON(((skb->end - skb->tail) <= length) ||
+			((offset + length) > PAGE_SIZE)))
+			return -ENOMEM;
+
+		memset(addr, 0, length);
+
+		return rxe_add_frag(skb, NULL, page, length, offset);
+	}
+
+	addr = payload_addr(pkt) + payload;
+	memset(addr, 0, length);
+
+	return 0;
+}
+
 static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 					   struct rxe_send_wqe *wqe,
 					   int opcode, u32 payload,
@@ -345,7 +402,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	struct sk_buff *skb = NULL;
 	struct rxe_av *av;
 	struct rxe_ah *ah = NULL;
-	u8 *pad_addr;
+	bool frag = false;
 	int err;
 
 	pkt->rxe = rxe;
@@ -380,9 +437,13 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 
 	/* init payload if any */
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		err = rxe_init_payload(qp, wqe, pkt, payload, skb);
-		if (unlikely(err))
+		err = rxe_init_payload(qp, wqe, pkt, payload,
+				       skb, frag);
+		if (unlikely(err)) {
+			rxe_dbg_qp(qp, "rxe_init_payload failed, err = %d",
+				   err);
 			goto err_out;
+		}
 	} else if (pkt->mask & RXE_FLUSH_MASK) {
 		/* oA19-2: shall have no payload. */
 		wqe->dma.resid = 0;
@@ -394,9 +455,11 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	}
 
 	/* init pad and icrc */
-	if (pkt->pad) {
-		pad_addr = payload_addr(pkt) + payload;
-		memset(pad_addr, 0, pkt->pad);
+	err = rxe_prepare_pad_icrc(pkt, skb, payload, frag);
+	if (unlikely(err)) {
+		rxe_dbg_qp(qp, "rxe_prepare_pad_icrc failed, err = %d",
+			   err);
+		goto err_out;
 	}
 
 	/* init IP and UDP network headers */
-- 
2.39.2

