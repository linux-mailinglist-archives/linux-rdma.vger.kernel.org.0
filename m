Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C1613F05
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJaU3D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJaU2v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:51 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D313EB5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:49 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13be3ef361dso14696898fac.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQXANIXnZWN6FLQ8unl+4sta4NHs4OlNjlowzxlQAEM=;
        b=ZWVzrNMbA26oe1P6lLXIKbVg2I6jh6nodyHpRjVvVF1Bh68RLkBLHEGlTz8RA0Tg+U
         vZf8M5vJOq2EogZT0oBqCCuCCT3P33bsy15Zvfr21bGt6h0xCopE2nPwTa8PGqcPVwhx
         dGnxyQA6KgeE0ntzA+qnKtIaDO3x0Bb1x6l16Tylgu3/sK9qdjnuBhKkk9d9CT7RDthw
         uFCEDmFMXQfYJ8qI+iUxcgqtjHgrxlMh1oqdVnVjMGYNMIBZjbomqehUmZ27ynXIlrSg
         +mk0dt/lZ8sfrAGRQ1pVU3qM2ONZxkrAu3b5TRl7Q3N3NWzHLngW7c2aA2NLJ807O18V
         /57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQXANIXnZWN6FLQ8unl+4sta4NHs4OlNjlowzxlQAEM=;
        b=ralvpf75X3UfPtmMZ0MEL3c6mTUoFAOFzQxWIPxXnpZOeETHhv6kf3WgwQk79+wpIH
         uqtTCU3XEo3tY+nwAOzJOCMSeo8sQGG1WYod4P1eaGGeyXhCcj+nOC0F5wshXRShww4T
         yWq02Dsh1SqGVP5Rv4VLgLarp9J9mgUujpy0qIGmzfwdhQBxqQV78u70I0aV7PxQxr9F
         ZXfuo6Vq45pPzmsXCt3yH2E7nBN1uBvxDXpY0PWFfLH6yKePdmDhMkISH0mpYAAOPcx+
         gq99fUk7N701wa4q7G96dWbXkF6Mrdycu0jeniAvgrzsN6Yyn9y0vKz3yXn8kH/SLZpy
         orKA==
X-Gm-Message-State: ACrzQf3MR7W8e8r3qT2Vh2/5iQfpavK2Xu62DfGdnDNlUW9MErX79i1P
        4YKcsSxIodHEU6NtaQ919nU=
X-Google-Smtp-Source: AMsMyM7/6VG7CBs2h2aWBL75o05lzkP/zE/B1ROrxwM61mGckO9YhyxOoOECSL9tWrBvoW1rD5riYg==
X-Received: by 2002:a05:6870:a91b:b0:131:f14a:30c2 with SMTP id eq27-20020a056870a91b00b00131f14a30c2mr8078991oab.286.1667248128964;
        Mon, 31 Oct 2022 13:28:48 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 16/18] RDMA/rxe: Extend send/write_data_in() for frags
Date:   Mon, 31 Oct 2022 15:28:05 -0500
Message-Id: <20221031202805.19138-16-rpearsonhpe@gmail.com>
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

Extend send_data_in() and write_data_in() in rxe_resp.c to
support fragmented received skbs.

This is in preparation for using fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 103 +++++++++++++++++----------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 905e19ee9ca5..419e8af235aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -518,45 +518,89 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	return state;
 }
 
-static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
-				     int data_len)
+/**
+ * rxe_send_data_in() - Copy payload data into receive buffer
+ * @qp: The queue pair
+ * @pkt: Request packet info
+ *
+ * Copy the packet payload into the receive buffer at the current offset.
+ * If a UD message also copy the IP header into the receive buffer.
+ *
+ * Returns: 0 if successful else an error resp_states value.
+ */
+static enum resp_states rxe_send_data_in(struct rxe_qp *qp,
+					 struct rxe_pkt_info *pkt)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb = PKT_TO_SKB(pkt);
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	u8 *data_addr = payload_addr(pkt);
+	int data_len = payload_size(pkt);
+	union rdma_network_hdr hdr;
+	enum rxe_mr_copy_op op;
 	int skb_offset = 0;
 	int err;
 
+	/* Per IBA for UD packets copy the IP header into the receive buffer */
+	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) {
+		if (skb->protocol == htons(ETH_P_IP)) {
+			memset(&hdr.reserved, 0, sizeof(hdr.reserved));
+			memcpy(&hdr.roce4grh, ip_hdr(skb), sizeof(hdr.roce4grh));
+		} else {
+			memcpy(&hdr.ibgrh, ipv6_hdr(skb), sizeof(hdr));
+		}
+		err = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
+					&qp->resp.wqe->dma, &hdr, skb_offset,
+					sizeof(hdr), RXE_COPY_TO_MR);
+		if (err)
+			goto err_out;
+	}
+
+	op = nr_frags ? RXE_FRAG_TO_MR : RXE_COPY_TO_MR;
+	skb_offset = data_addr - skb_transport_header(skb);
 	err = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
 				&qp->resp.wqe->dma, data_addr,
-				skb_offset, data_len, RXE_COPY_TO_MR);
-	if (unlikely(err))
-		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
-					: RESPST_ERR_MALFORMED_WQE;
+				skb_offset, data_len, op);
+	if (err)
+		goto err_out;
 
 	return RESPST_NONE;
+
+err_out:
+	return (err == -ENOSPC) ? RESPST_ERR_LENGTH
+				: RESPST_ERR_MALFORMED_WQE;
 }
 
-static enum resp_states write_data_in(struct rxe_qp *qp,
-				      struct rxe_pkt_info *pkt)
+/**
+ * rxe_write_data_in() - Copy payload data to iova
+ * @qp: The queue pair
+ * @pkt: Request packet info
+ *
+ * Copy the packet payload to current iova and update iova.
+ *
+ * Returns: 0 if successful else an error resp_states value.
+ */
+static enum resp_states rxe_write_data_in(struct rxe_qp *qp,
+					  struct rxe_pkt_info *pkt)
 {
 	struct sk_buff *skb = PKT_TO_SKB(pkt);
-	enum resp_states rc = RESPST_NONE;
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	u8 *data_addr = payload_addr(pkt);
 	int data_len = payload_size(pkt);
+	enum rxe_mr_copy_op op;
+	int skb_offset;
 	int err;
-	int skb_offset = 0;
 
+	op = nr_frags ? RXE_FRAG_TO_MR : RXE_COPY_TO_MR;
+	skb_offset = data_addr - skb_transport_header(skb);
 	err = rxe_copy_mr_data(skb, qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), skb_offset, data_len,
-			  RXE_COPY_TO_MR);
-	if (err) {
-		rc = RESPST_ERR_RKEY_VIOLATION;
-		goto out;
-	}
+			  data_addr, skb_offset, data_len, op);
+	if (err)
+		return RESPST_ERR_RKEY_VIOLATION;
 
 	qp->resp.va += data_len;
 	qp->resp.resid -= data_len;
 
-out:
-	return rc;
+	return RESPST_NONE;
 }
 
 static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
@@ -884,30 +928,13 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	enum resp_states err;
-	struct sk_buff *skb = PKT_TO_SKB(pkt);
-	union rdma_network_hdr hdr;
 
 	if (pkt->mask & RXE_SEND_MASK) {
-		if (qp_type(qp) == IB_QPT_UD ||
-		    qp_type(qp) == IB_QPT_GSI) {
-			if (skb->protocol == htons(ETH_P_IP)) {
-				memset(&hdr.reserved, 0,
-						sizeof(hdr.reserved));
-				memcpy(&hdr.roce4grh, ip_hdr(skb),
-						sizeof(hdr.roce4grh));
-				err = send_data_in(qp, &hdr, sizeof(hdr));
-			} else {
-				err = send_data_in(qp, ipv6_hdr(skb),
-						sizeof(hdr));
-			}
-			if (err)
-				return err;
-		}
-		err = send_data_in(qp, payload_addr(pkt), payload_size(pkt));
+		err = rxe_send_data_in(qp, pkt);
 		if (err)
 			return err;
 	} else if (pkt->mask & RXE_WRITE_MASK) {
-		err = write_data_in(qp, pkt);
+		err = rxe_write_data_in(qp, pkt);
 		if (err)
 			return err;
 	} else if (pkt->mask & RXE_READ_MASK) {
-- 
2.34.1

