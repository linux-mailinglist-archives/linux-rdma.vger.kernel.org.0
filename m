Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF61613F03
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJaU2x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiJaU2t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263FA13E36
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:47 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 16-20020a9d0490000000b0066938311495so7395650otm.4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFN8jQE/48Dw0iUXJPRfQ4xJofloB8GyBk/xzS0kbsM=;
        b=guPPbmh4HEDcQoXBg2JBFb7GntMcnQkU/ijjyXyYL+yS4ScKbbJhsfpvU7ulsNTDcx
         vhrVyRRYs+cnBAbSy6qv1wYG/cjjcPHV5WGzANel6hfcEQfsFbItfeMEDLjOWGPMH0YE
         aCVg9rQ/0FfTjecTV4tYeWu93KARMeaEjiJC9xLeqJVT6EM98GxiD19v+O2ORmFQb6rB
         dmtihBA9kuiTcPQ0VFAbpDY2WoY/DlHLYqF+MIZNvOcUi8OULKt3z7VMg0BWFaBqa/pb
         njSRMg5jjAt+8fw+g2XoFUzXMUYVl6VUHZsEfHDeNLJkqL8Itl9eECE9RBOC2dcZwGJ7
         ccyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFN8jQE/48Dw0iUXJPRfQ4xJofloB8GyBk/xzS0kbsM=;
        b=L6JyzDRpjHAdUr+P2GHTnam9O9NwLkPxbBYn+1AWCfdcRbSW08fmCpaNrWneLvV4kD
         9XbgozreCROSe7g7gkrKqeaFf1XJTCJKcV9Rzi3kGLxY1XAn17Bwyz3za9e+zjot/PIh
         WwS5QD6Uy7sTS8AfwukssJ0EcCU7uFgocjG4wtbrB1ZIveQlZKBRSQekgxO1oLwuj/fe
         82L9mJyzKc8uWGSLU3BWk3DHCINIDRLo7/W18taazQMh9ArlgmzlbvsEDlXY3/e6GYJe
         +Nb5ag+7TvutU3ZWU5eCYogZW6H6oIPv1ZdlCLH2WYxlVFEDBqQ4bGCp9nrhSAhb9fuw
         izBA==
X-Gm-Message-State: ACrzQf2YYJeANnnZuRVMrgF7iaK4nz2vNfwrvKe83+b8LDTZoRngX1O2
        drdsIJjmPyj3HsJqTMYMQXw=
X-Google-Smtp-Source: AMsMyM4H2jYht/1iZUBY9VYIVo+CZwjMTefeXC+PkPyapJKTZz9cq6acN1A5UX1BRU7b4NMolkzZxA==
X-Received: by 2002:a05:6830:1f34:b0:66c:4a42:9ca5 with SMTP id e20-20020a0568301f3400b0066c4a429ca5mr4481171oth.175.1667248126466;
        Mon, 31 Oct 2022 13:28:46 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 14/18] RDMA/rxe: Extend rxe_init_req_packet() for frags
Date:   Mon, 31 Oct 2022 15:28:03 -0500
Message-Id: <20221031202805.19138-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
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

Add code to rxe_build_req_packet() to allocate space for the
pad and icrc if the skb is fragmented.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  9 +++-
 drivers/infiniband/sw/rxe/rxe_req.c | 74 ++++++++++++++++++++++++-----
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 12fd5811cd79..cab6acad7a83 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -179,8 +179,15 @@ void rxe_srq_cleanup(struct rxe_pool_elem *elem);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
-int rxe_completer(void *arg);
+/* rxe_req.c */
+int rxe_prepare_pad_icrc(struct rxe_pkt_info *pkt, struct sk_buff *skb,
+			  int payload, bool frag);
 int rxe_requester(void *arg);
+
+/* rxe_comp.c */
+int rxe_completer(void *arg);
+
+/* rxe_resp.c */
 int rxe_responder(void *arg);
 
 /* rxe_icrc.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 71a65f2a5d6d..984e3e957aef 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -438,27 +438,79 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 }
 
 static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-			    struct rxe_pkt_info *pkt, u32 payload,
-			    struct sk_buff *skb)
+			    struct rxe_pkt_info *pkt, int pad, u32 payload,
+			    struct sk_buff *skb, bool frag)
 {
+	int len = skb_tailroom(skb);
+	int tot_len = payload + pad + RXE_ICRC_SIZE;
+	int access = 0;
 	int skb_offset = 0;
+	int op;
+	void *addr;
 	void *data;
 	int err = 0;
 
 	if (wqe->wr.send_flags & IB_SEND_INLINE) {
+		if (WARN_ON(frag))
+			return -EINVAL;
+		if (len < tot_len)
+			return -EINVAL;
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
+	struct rxe_phys_buf dmabuf;
+	size_t offset;
+	u64 iova;
+	u8 *addr;
+	int err = 0;
+	int pad = (-payload) & 0x3;
+
+	if (frag) {
+		/* allocate bytes at the end of the skb linear buffer
+		 * and build a frag pointing at it
+		 */
+		WARN_ON((skb->end - skb->tail) < 8);
+		addr = skb_end_pointer(skb) - RXE_ICRC_SIZE - pad;
+		iova = (uintptr_t)addr;
+		dmabuf.addr = iova & PAGE_MASK;
+		offset = iova & ~PAGE_MASK;
+		err = rxe_add_frag(skb, &dmabuf, pad + RXE_ICRC_SIZE, offset);
+		if (err)
+			goto err;
+	} else {
+		addr = payload_addr(pkt) + payload;
+	}
+
+	/* init pad and icrc to zero */
+	memset(addr, 0, pad + RXE_ICRC_SIZE);
+
+err:
+	return err;
+}
+
 static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 					   struct rxe_send_wqe *wqe,
 					   int opcode, u32 payload,
@@ -468,9 +520,9 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	struct sk_buff *skb = NULL;
 	struct rxe_av *av;
 	struct rxe_ah *ah = NULL;
-	void *padp;
 	int pad;
 	int err = -EINVAL;
+	bool frag = false;
 
 	pkt->rxe = rxe;
 	pkt->opcode = opcode;
@@ -498,15 +550,15 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	rxe_init_roce_hdrs(qp, wqe, pkt, pad);
 
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		err = rxe_init_payload(qp, wqe, pkt, payload, skb);
+		err = rxe_init_payload(qp, wqe, pkt, pad, payload, skb, frag);
 		if (err)
 			goto err_out;
 	}
 
-	if (pad) {
-		padp = payload_addr(pkt) + payload;
-		memset(padp, 0, pad);
-	}
+	/* handle pad and icrc */
+	err = rxe_prepare_pad_icrc(pkt, skb, payload, frag);
+	if (err)
+		goto err_out;
 
 	/* IP and UDP network headers */
 	err = rxe_prepare(av, pkt, skb);
-- 
2.34.1

