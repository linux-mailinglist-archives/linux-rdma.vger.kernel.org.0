Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC89613EF6
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJaU2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJaU2S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:18 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41512ADA
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:17 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13bd19c3b68so14703262fac.7
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTx3ZwrPzjrPtYAsIakHh9HEYCDZ3bW/H1ENJ8+eUII=;
        b=AmIH4Z2l1l+4ucjKPYESN+19BiuwOQ5ogqWZW3m4t25wJrdZs6SRnhnhqB3rrOutKD
         jES5gsRoFEtcO/1shmJg/WS1Ms76ot6NABLhSlNEHjZdJQR95CsLpHn/zA2NX3d3XVkz
         jNIZ0dDwpyrXKQzKDfMT8Jop+4BxmZ8RbDmxcXSpOcQkjqhN8KvviDqO77dAOVl4Kg3z
         XVtl3Cx/v2Ft2P9Gcufpn19bx5eQRqVI+piR/yp+rrvMiikkkyP9VCxTenE0j4Zw2WU7
         CvDKLsBMWGD1sqsJpyRHhRavmzHCB/zK7D8K2Xjvo2l3smu6XW7sireM7/B870r6Py/e
         gTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTx3ZwrPzjrPtYAsIakHh9HEYCDZ3bW/H1ENJ8+eUII=;
        b=NdkqrSUQGeYYgRpAJ/CPg4cFE4IjDqQ0eJ0JlKpuFqpM4kR7r2oyQKfl7RHEyNCBTV
         XtNYFMv2zrAV2gVDVjQ+qoYbYb1dA8+odBKtI+RSSf1t03IvxOF4nblwFieuaCRozekO
         u8IRBbiqtU/nNUhZKm8jPXWm2Gyyex+vh3JFy2Z5UO5tKxNsNkeEoDcezfsKfdxvJodi
         SJ1Y/EPDkzMCrH793GYMzz6NpSIjl3gbHGRl/KyPD2B+FTzssxGh+rJftkfceR5E0TAw
         Bp/bl6iDR26jdxs2CG64vWQPbZJ4mL6KXoyFiRaDZbQpAJx7trt0Nh50FpV0xEp5qHf+
         Xf5A==
X-Gm-Message-State: ACrzQf2+GjnfQSbiSl/MTVByGfTTLT7cTt9vb17CImiEBqCHRRJ4hoM7
        lhCh/CxJ9Vkp+cb+vE54aQk=
X-Google-Smtp-Source: AMsMyM616kc9/ongQIm9XaO/5OghHxKRlrBCZBn3deusKCvq/ykWKeNt2VfTjkURAQNsqtMahpojFQ==
X-Received: by 2002:a05:6870:b392:b0:136:71ed:c874 with SMTP id w18-20020a056870b39200b0013671edc874mr18223975oap.66.1667248096413;
        Mon, 31 Oct 2022 13:28:16 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 01/18] RDMA/rxe: Isolate code to fill request roce headers
Date:   Mon, 31 Oct 2022 15:27:49 -0500
Message-Id: <20221031202805.19138-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Isolate the code to fill in roce headers in a request packet into
a subroutine named init_roce_headers.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 106 +++++++++++++++-------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..bcfbc78c0b53 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -377,79 +377,87 @@ static inline int get_mtu(struct rxe_qp *qp)
 	return rxe->port.mtu_cap;
 }
 
-static struct sk_buff *init_req_packet(struct rxe_qp *qp,
-				       struct rxe_av *av,
-				       struct rxe_send_wqe *wqe,
-				       int opcode, u32 payload,
-				       struct rxe_pkt_info *pkt)
+static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			       struct rxe_pkt_info *pkt, int pad)
 {
-	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
-	struct sk_buff		*skb;
-	struct rxe_send_wr	*ibwr = &wqe->wr;
-	int			pad = (-payload) & 0x3;
-	int			paylen;
-	int			solicited;
-	u32			qp_num;
-	int			ack_req;
-
-	/* length from start of bth to end of icrc */
-	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
-	pkt->paylen = paylen;
-
-	/* init skb */
-	skb = rxe_init_packet(rxe, av, paylen, pkt);
-	if (unlikely(!skb))
-		return NULL;
+	struct rxe_send_wr *wr = &wqe->wr;
+	int is_send;
+	int is_write_imm;
+	int is_end;
+	int solicited;
+	u32 dst_qpn;
+	u32 qkey;
+	int ack_req;
 
 	/* init bth */
-	solicited = (ibwr->send_flags & IB_SEND_SOLICITED) &&
-			(pkt->mask & RXE_END_MASK) &&
-			((pkt->mask & (RXE_SEND_MASK)) ||
-			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
-			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
-
-	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
-					 qp->attr.dest_qp_num;
-
-	ack_req = ((pkt->mask & RXE_END_MASK) ||
-		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+	is_send = pkt->mask & RXE_SEND_MASK;
+	is_write_imm = (pkt->mask & RXE_WRITE_MASK) &&
+		       (pkt->mask & RXE_IMMDT_MASK);
+	is_end = pkt->mask & RXE_END_MASK;
+	solicited = (wr->send_flags & IB_SEND_SOLICITED) && is_end &&
+		    (is_send || is_write_imm);
+	dst_qpn = (pkt->mask & RXE_DETH_MASK) ? wr->wr.ud.remote_qpn :
+					       qp->attr.dest_qp_num;
+	ack_req = is_end || (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK);
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
-	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL, qp_num,
-		 ack_req, pkt->psn);
+	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL,
+		 dst_qpn, ack_req, pkt->psn);
 
-	/* init optional headers */
+	/* init extended headers */
 	if (pkt->mask & RXE_RETH_MASK) {
-		reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
+		reth_set_rkey(pkt, wr->wr.rdma.rkey);
 		reth_set_va(pkt, wqe->iova);
 		reth_set_len(pkt, wqe->dma.resid);
 	}
 
 	if (pkt->mask & RXE_IMMDT_MASK)
-		immdt_set_imm(pkt, ibwr->ex.imm_data);
+		immdt_set_imm(pkt, wr->ex.imm_data);
 
 	if (pkt->mask & RXE_IETH_MASK)
-		ieth_set_rkey(pkt, ibwr->ex.invalidate_rkey);
+		ieth_set_rkey(pkt, wr->ex.invalidate_rkey);
 
 	if (pkt->mask & RXE_ATMETH_MASK) {
 		atmeth_set_va(pkt, wqe->iova);
-		if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
-			atmeth_set_swap_add(pkt, ibwr->wr.atomic.swap);
-			atmeth_set_comp(pkt, ibwr->wr.atomic.compare_add);
+		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+			atmeth_set_swap_add(pkt, wr->wr.atomic.swap);
+			atmeth_set_comp(pkt, wr->wr.atomic.compare_add);
 		} else {
-			atmeth_set_swap_add(pkt, ibwr->wr.atomic.compare_add);
+			atmeth_set_swap_add(pkt, wr->wr.atomic.compare_add);
 		}
-		atmeth_set_rkey(pkt, ibwr->wr.atomic.rkey);
+		atmeth_set_rkey(pkt, wr->wr.atomic.rkey);
 	}
 
 	if (pkt->mask & RXE_DETH_MASK) {
-		if (qp->ibqp.qp_num == 1)
-			deth_set_qkey(pkt, GSI_QKEY);
-		else
-			deth_set_qkey(pkt, ibwr->wr.ud.remote_qkey);
-		deth_set_sqp(pkt, qp->ibqp.qp_num);
+		qkey = (qp->ibqp.qp_num == 1) ? GSI_QKEY :
+						wr->wr.ud.remote_qkey;
+		deth_set_qkey(pkt, qkey);
+		deth_set_sqp(pkt, qp_num(qp));
 	}
+}
+
+static struct sk_buff *init_req_packet(struct rxe_qp *qp,
+				       struct rxe_av *av,
+				       struct rxe_send_wqe *wqe,
+				       int opcode, u32 payload,
+				       struct rxe_pkt_info *pkt)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct sk_buff *skb;
+	int pad = (-payload) & 0x3;
+	int paylen;
+
+	/* length from start of bth to end of icrc */
+	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
+	pkt->paylen = paylen;
+
+	/* init skb */
+	skb = rxe_init_packet(rxe, av, paylen, pkt);
+	if (unlikely(!skb))
+		return NULL;
+
+	rxe_init_roce_hdrs(qp, wqe, pkt, pad);
 
 	return skb;
 }
-- 
2.34.1

