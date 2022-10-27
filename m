Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A866100D8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiJ0S4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiJ0S42 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:28 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE805247A
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:26 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322d768ba7so3404281fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s9xzALqle7XzdyodUJimyArDl2cVxLW3LvkXiOQyB8=;
        b=AJFfetP9aH8mVobrCP1dP1XFL5HElDjchW/TOLA+v0jZ9XsF8npxH5tHUFrIa/US5y
         p+F5QW3L8sCC2hB+5/laEV5TBlcJuP9Pnv3NgTL6UCsdSgnpShT7cGU+XcTfs+lSHmto
         pvcTXZ03LcAMz6GhJ6EzCy3WF3BEfWRe8Tiu7ZjdsM89S0lb0Re8twJhjLtpQ9f9oNsx
         kgor6adTNpdamqYBNeFGQAOba0I8VdaXWCiFzJSSnsdZ180vl23QjJi6/9B9/EbZ+eaI
         e5UaJd8+3FMrotOhXUhKNz5bhVksFvqy2Rdqru7mIy8tX8BkZNExOWH7Y5H+iUqXqGMR
         ibmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s9xzALqle7XzdyodUJimyArDl2cVxLW3LvkXiOQyB8=;
        b=aB+0rxJLFe5s1ebMnBa8s/ZA7m6rnWmW3AwwpXGhV2D5JwNGFnX/ymCFvZxJ9d0jmT
         cCKPotOCM5Vcy6WKT3K+R/2ydZnga1x5o+jxFoaBdF3BCUXVSr8CePEQuEIUnHPZAnwG
         5MdjJRFBpNiU+CxDqYuaisvBHOKLC94uzdniPQP13knHjN8+fOlusWsMTY0kc8KhxnI4
         3qQ0+Qn2pkZd11OuJEMG/eGW7eiueoQGHm3WphbNQ0YTF1rSQx+QGPdgwJFV/iNwpy+7
         V9GK6mVkohMf8913MhKS8riBd/vw2f5zndU4RO5j+q3Y0l7fnt7QBP8aJZ5BPJfZZcgx
         m0GA==
X-Gm-Message-State: ACrzQf0V6E5/4LI69BQ8wvNsMDDJlQVJPlnPqC0uw0FONi1qPGkt5maJ
        QAWwARvJzwig+pekCj0bayY=
X-Google-Smtp-Source: AMsMyM4TrGxzVIK13plKU0hlDjWBz8yU4D2uARFZsmXOk/7tTVZ6lwGh8dTMueD6h7HOPwVafmd49Q==
X-Received: by 2002:a05:6870:40d3:b0:13a:e746:75a7 with SMTP id l19-20020a05687040d300b0013ae74675a7mr6291691oal.5.1666896986098;
        Thu, 27 Oct 2022 11:56:26 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 13/17] RDMA/rxe: Extend rxe_init_req_packet() for frags
Date:   Thu, 27 Oct 2022 13:55:07 -0500
Message-Id: <20221027185510.33808-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
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
index b4bbccc3c008..ea9ab63a2dc1 100644
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
 	struct sk_buff *skb;
 	struct rxe_av *av;
 	struct rxe_ah *ah;
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

