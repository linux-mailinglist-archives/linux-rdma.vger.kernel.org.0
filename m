Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809076100DA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiJ0S4j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiJ0S4c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:32 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A98501B3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:28 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i7so3404429oif.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaFNnE3LTQv6kJv+8drqhqVvuAL0z5lzANxUuMdNOXA=;
        b=LMoWzFJcY8PDOR+26C2wiCTtzduLLUmzCZv39k4tKqpk5FhQTH9/Xe9M8e3Oq4UXsc
         +PlMREU0NOm26UyJv09JNQ/FwHL82kZG5ps3/uy29ZBZeJ74U6Y2XNoM7BZpf7wlioAP
         iZVay5N7pQStN7wm2lAp9QIadfNPnkyEgv+6iEA9LLz2zMSQ0KibWR26B/VCz+wZ83X9
         1od3FMN5t/ly1fjxGp2p3dHCPF92EH2co7DZWMUCdm72AgXUHahiV65PKkDGReakWFEy
         q6lMF0WEcp74fZE0eQVi0ELn8+VwbaZvWEpDNg8O5RvpznrR5YPFSgqd+a5PKPYoqKG3
         CezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaFNnE3LTQv6kJv+8drqhqVvuAL0z5lzANxUuMdNOXA=;
        b=EoVp4uJGvTuVXXPWtcN94+PlYV/+tB0S8QxcMHTqAORsWTlpPD+THdGOzQKAkAGHB1
         w+kDmbFobvxJp3Kv5pPnAgLilZOKnGb4pYtkGdcFrRFCrZF4R/YX/g3v9CY7DVmI9izd
         xkXwxAsAS6nFobjSVbWkxmCYXTUYtsk/7dU8odVGSHcoEiabGYxynsWUCOZF+wMQSJIE
         MrOHA5Fdd16N0hfYyMSF0ozWNPPh10DB1BIKbMvZf9ABfkF1X4aNnF8KXdDlz9xn8vgS
         GSNHjgwUwRkG90x6yp6H+RTkfh3ccQc14G8+xx1a6tjjp5JU5i7JPjNPQR41OS56l9zA
         a3Gw==
X-Gm-Message-State: ACrzQf32c9jAkU9NIfDjgSXWrrgONMHKYP+qIsFtdjVxiLQAP1EurTxu
        qw/Fgw7PBiLjYqPqHsgORNPgkpAjrq4=
X-Google-Smtp-Source: AMsMyM7ATt1cQXY16Jxdn3e7kxS3z6ciJ7/3So+l3rUSncfiu/I/Y2x9QRvMlApScllGhkwtKEbyAg==
X-Received: by 2002:a05:6808:65a:b0:359:a964:4154 with SMTP id z26-20020a056808065a00b00359a9644154mr5521484oih.249.1666896988181;
        Thu, 27 Oct 2022 11:56:28 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 15/17] RDMA/rxe: Extend send/write_data_in() for frags
Date:   Thu, 27 Oct 2022 13:55:09 -0500
Message-Id: <20221027185510.33808-16-rpearsonhpe@gmail.com>
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

Extend send_data_in() and write_data_in() in rxe_resp.c to
support fragmented received skbs.

This is in preparation for using fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 103 +++++++++++++++++----------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 79dcd0f37140..cd50ae080eda 100644
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
@@ -882,30 +926,13 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
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

