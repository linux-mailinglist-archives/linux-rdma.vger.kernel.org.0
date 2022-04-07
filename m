Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8374F8780
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiDGS6Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiDGS6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 14:58:02 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13B1C7EBA
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 11:55:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e1e5e8d9faso7374749fac.4
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9XBkNRdr+UGHjgUp/Eujxp2uY1Txt2siyuWWUmIvn4=;
        b=Akz0w6ue+czzE8DAWCFQirEt7kl3t9taWOVC3rqFltsLnjdhr5Q/LSMgay93LjVVDn
         eXBJMj/o1C4LtoBQdHO/gg5FfoSwv9Lsan8P8ju5hy0xuazqzr7JFM47WTZx8cZuB3Zl
         r7HEKuiVipZtLs/kItBxkGf22fcAdgAcISIjcetlW5gEd0qUeOa8MA3I+98Fjl6eZA47
         dkGsbV0wSVv6paDWoFG/FtriSGbN6A1BlKhTufHHGqHh8ZVtCNg1ABL7sj3amzWWAUCw
         PeKZQl1C82keKMoYMLxmdTQ9duNKhFmMuP+5WyPKGAigpdVwJIs6hqc/2hg0NLQlbxae
         9phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9XBkNRdr+UGHjgUp/Eujxp2uY1Txt2siyuWWUmIvn4=;
        b=LuCfKvwtxm2X/xB8rtOTsnT7PdmfTFws93arnKkTZTlluW3cCWHl+DOy9nPfIu5o2o
         oGZkcVQW4zaJbdPHzXYJ1zXfNrah7NkksQTSWpJ8w8b/Bolpvdx4LhaP95pa1+JglAHf
         ZP1Q9d8xkeFaziARFC2uf3EO/bq7j8wI+OdosUW9YBg9dVDHW6FbLJL12Sgo5EaGVJOP
         lLwsrJrrYTjjRiahs9i3nNkUNyYRD5AmdPw92WXhUayxQfc4iOXudbMbyzrlavNfaZnR
         iNxArzWncOCSPcMgGckEqleKY522HAGPWyJre0yqz1qnITwu0dZic9oBoNt9UGH+lbgk
         YHCA==
X-Gm-Message-State: AOAM533DSXaNUCkIqLlKaHsDP79sLHZXhIm9HtE5Dxq1k5xcLnmzTApd
        QWkF/Fobqcv80R1pxTesO18=
X-Google-Smtp-Source: ABdhPJwsgPsBdQACM2LCRsHlBQHdnv7fCcKnAo8Qb2wg0wHusT+7G67s183wU12t45LTjH2x41H2ZA==
X-Received: by 2002:a05:6870:e305:b0:e1:eda5:2fd0 with SMTP id z5-20020a056870e30500b000e1eda52fd0mr6953640oad.30.1649357758514;
        Thu, 07 Apr 2022 11:55:58 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-417c-5508-fb92-9ab4.res6.spectrum.com. [2603:8081:140c:1a00:417c:5508:fb92:9ab4])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm8719322oaf.10.2022.04.07.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:55:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove support for SMI QPs from rdma_rxe
Date:   Thu,  7 Apr 2022 13:54:17 -0500
Message-Id: <20220407185416.16372-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Currently the rdma_rxe driver supports SMI type QPs in a few places
which is incorrect. RoCE devices never should support SMI QPs.
This commit removes SMI QP support from the driver.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c |  2 --
 drivers/infiniband/sw/rxe/rxe_qp.c     | 14 +-------------
 drivers/infiniband/sw/rxe/rxe_recv.c   |  1 -
 drivers/infiniband/sw/rxe/rxe_req.c    |  1 -
 drivers/infiniband/sw/rxe/rxe_resp.c   |  2 --
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  1 -
 7 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index df596ba7527d..d4ba4d506f17 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -29,7 +29,6 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_SEND]					= {
 		.name	= "IB_WR_SEND",
 		.mask	= {
-			[IB_QPT_SMI]	= WR_INLINE_MASK | WR_SEND_MASK,
 			[IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
 			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
 			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
@@ -39,7 +38,6 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_SEND_WITH_IMM]				= {
 		.name	= "IB_WR_SEND_WITH_IMM",
 		.mask	= {
-			[IB_QPT_SMI]	= WR_INLINE_MASK | WR_SEND_MASK,
 			[IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
 			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
 			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 62acf890af6c..ff58f76347c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -63,7 +63,6 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	int port_num = init->port_num;
 
 	switch (init->qp_type) {
-	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	case IB_QPT_RC:
 	case IB_QPT_UC:
@@ -81,7 +80,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	if (rxe_qp_chk_cap(rxe, cap, !!init->srq))
 		goto err1;
 
-	if (init->qp_type == IB_QPT_SMI || init->qp_type == IB_QPT_GSI) {
+	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
 			pr_warn("invalid port = %d\n", port_num);
 			goto err1;
@@ -89,11 +88,6 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 
 		port = &rxe->port;
 
-		if (init->qp_type == IB_QPT_SMI && port->qp_smi_index) {
-			pr_warn("SMI QP exists for port %d\n", port_num);
-			goto err1;
-		}
-
 		if (init->qp_type == IB_QPT_GSI && port->qp_gsi_index) {
 			pr_warn("GSI QP exists for port %d\n", port_num);
 			goto err1;
@@ -167,12 +161,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	port			= &rxe->port;
 
 	switch (init->qp_type) {
-	case IB_QPT_SMI:
-		qp->ibqp.qp_num		= 0;
-		port->qp_smi_index	= qpn;
-		qp->attr.port_num	= init->port_num;
-		break;
-
 	case IB_QPT_GSI:
 		qp->ibqp.qp_num		= 1;
 		port->qp_gsi_index	= qpn;
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index d09a8b68c962..f3ad7b6dbd97 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -34,7 +34,6 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		}
 		break;
 	case IB_QPT_UD:
-	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 		if (unlikely(pkt_type != IB_OPCODE_UD)) {
 			pr_warn_ratelimited("bad qp type\n");
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..52c1d8ff6e5b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -308,7 +308,6 @@ static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	case IB_QPT_UC:
 		return next_opcode_uc(qp, opcode, fits);
 
-	case IB_QPT_SMI:
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		switch (opcode) {
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 16fc7ea1298d..9dc38f7c990b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -277,7 +277,6 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 		break;
 
 	case IB_QPT_UD:
-	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 		break;
 
@@ -819,7 +818,6 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 
 	if (pkt->mask & RXE_SEND_MASK) {
 		if (qp_type(qp) == IB_QPT_UD ||
-		    qp_type(qp) == IB_QPT_SMI ||
 		    qp_type(qp) == IB_QPT_GSI) {
 			if (skb->protocol == htons(ETH_P_IP)) {
 				memset(&hdr.reserved, 0,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 67184b0281a0..58e4412b1d16 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -536,7 +536,6 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	wr->send_flags = ibwr->send_flags;
 
 	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI) {
 		struct ib_ah *ibah = ud_wr(ibwr)->ah;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index adae01458606..86068d70cd95 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -373,7 +373,6 @@ struct rxe_port {
 	spinlock_t		port_lock; /* guard port */
 	unsigned int		mtu_cap;
 	/* special QPs */
-	u32			qp_smi_index;
 	u32			qp_gsi_index;
 };
 
-- 
2.32.0

