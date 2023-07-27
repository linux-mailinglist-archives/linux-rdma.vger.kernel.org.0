Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E8765CCB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjG0UCY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjG0UCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:23 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED4730F3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b055510c9dso980845fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488139; x=1691092939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hpwpc8oG7KJBxYHBS4inovsxR8KwRPSpA9l/aOKcvc=;
        b=jqio+igS0yqZskF4WhWuhtYT7ra4wN7NnqgbBLWl8pKUSU+ziN+6+lEX0tCIZVV3Ur
         PcBhw2bOyDgapp5IPL+ajDKMCRVOKsRU3Q/rTbfTESbzGPAhhVlxNs5fhcWX6UIGqRMr
         GWnu0iUgnhpuL2hBXB5zZrLJY0i9GfFdxFcnbxCJx9RyBixnFHo6GTIDGcQwPUkjP3kZ
         BqRSwW96M58LHgmCtTIADRs5mzk+4wFPCLu83uKDJckcNKHGnYzmylc11NcSmYXVwWS0
         Ad1cW8IMsI599uohYBmlVNlYxQW+o8ZxPpaXCpj2pHikJjGd3dsQ2iyVfAMCUi1IQD4s
         o4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488139; x=1691092939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hpwpc8oG7KJBxYHBS4inovsxR8KwRPSpA9l/aOKcvc=;
        b=FFKZtjOUVi01yh44jR/zDi5uD1I99E0NQT2DDSySEcRLCP/2vQUXcN2j9ff+vmYhZu
         JMulSW2TbPDg31VsZIxLDphUFJ9ZU3p6iDMfmZK94r/q48M/IEGBBvtiFtwb/c1wfasu
         Gx1YxD+a+QJcA+t6vfWXcdH69FgvX44C62NMlmgHvZeHO3k6pYqo08TbhXplbiCnIg7H
         x+/yzld/bSeXZ047VJFhtLliLPm2IAs+0VYfy6MHmE5GDKVzRA9luHqzvL+IwR+IS7Ic
         u8ohujR31NHhGhTWSKlgoTEbNuKg0wqf8LqSbwP+yanpNQts2XYlXOldZi44FZ3JHKlg
         hrrQ==
X-Gm-Message-State: ABy/qLb4sPWzlt/0+DrWgWPu9OY/6AU1fNlPopmX2K8Rt0vew1pVO2rL
        MoD52LABNuv0xCBw6j5TEdc=
X-Google-Smtp-Source: APBJJlG4ABfIb7pLuQCfZBIlERkm9TV3zDb6sd1mk/5zbg2aPR697aEFWsuxPa3v60V/Ud/ihYaGeQ==
X-Received: by 2002:a05:6870:41d0:b0:1bb:9c0f:2e58 with SMTP id z16-20020a05687041d000b001bb9c0f2e58mr511810oac.40.1690488139518;
        Thu, 27 Jul 2023 13:02:19 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 08/10] RDMA/rxe: Extend send/write_data_in() for frags
Date:   Thu, 27 Jul 2023 15:01:27 -0500
Message-Id: <20230727200128.65947-9-rpearsonhpe@gmail.com>
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

Extend send_data_in() and write_data_in() in rxe_resp.c to
support fragmented received skbs.

This is in preparation for using fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 102 +++++++++++++++++----------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index dc62e11dc448..c7153e376987 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -559,45 +559,88 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
+	op = skb_is_nonlinear(skb) ? RXE_FRAG_TO_MR : RXE_COPY_TO_MR;
+	/* offset to payload from skb->data (= &bth header) */
+	skb_offset = rxe_opcode[pkt->opcode].length;
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
+	u8 *data_addr = payload_addr(pkt);
 	int data_len = payload_size(pkt);
+	enum rxe_mr_copy_op op;
+	int skb_offset;
 	int err;
-	int skb_offset = 0;
 
+	op = skb_is_nonlinear(skb) ? RXE_FRAG_TO_MR : RXE_COPY_TO_MR;
+	skb_offset = rxe_opcode[pkt->opcode].length;
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
@@ -991,30 +1034,13 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
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
2.39.2

