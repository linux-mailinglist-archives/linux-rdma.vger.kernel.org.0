Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88805BB5C5
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIQDLA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIQDKy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:10:54 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354552E70
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t62so8305318oie.10
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2sQYsVirRP6MdY15qHzh8WxTTUEdGT3IBBGPdUTLpFI=;
        b=LyrpYRwhC4gx/ormiSSy3LfQYEnnFAMyj38EwJYhpg6frrLzVcsuWQhXXLL+ILv14N
         H2zao+iV8nm0L0zUu56g0gzY7mlSL/JSX6sqyGEsB97luQ4erK1icv5UXrhyn4YyqeXz
         KOhFeoPuFfttONrtwsU7oyft2zVy9j1E3cfkXkk2FQsDwBaZFfwe4iEQ3SzzEUZgEwbw
         KKcznJaXKk2bc6xi1shpue3JLV2CzzBj+8FFsiUQh7/ysucml81wdwvjscBNKfP+kR/1
         LFkEORq2osxizllIeeKu+DRZUgB7D7PEP3kc/SpYtamOqChpPG/MQqciVIZzFOl4/Qh5
         TQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2sQYsVirRP6MdY15qHzh8WxTTUEdGT3IBBGPdUTLpFI=;
        b=hqIARYccrKOnZ3YCaM+w/bOOc/ujBOPIIXNmZ0etURoemXW1nJNBi4HppVZfVSJZ5y
         3Tv2JowDNVlggoO5s25Kt1r+OQYfc51TWkJtpGsdqSTCFEDlQDs42gMdIkYialKiKOsT
         3skwx0VbprMJbnC/psqQwI76VkXxFD5W4SwMlZyLFc6MqTMPtl3IHz4hykrP5kLXsURG
         63iYNryDpHk2XPefLWu+3OEApWH8IIaUQvt85/l/d1LiW1we/0IHdNWb6I2PlIRbJ/qh
         GyY4+AF9uaV4Zq8Iew5s49RMfbiUnwn7pS6Y40KsUKReofzEfA1tTSXP9eF44QmRc6FB
         hQ1Q==
X-Gm-Message-State: ACrzQf0gBvsYZ7+2YH9KYHQaQN6fv7eauN4QyHUL8N78esj0gPqtEviT
        +/taWsNL9BofAc/7tvL0e6c=
X-Google-Smtp-Source: AMsMyM5BUxyoF9c796wZE2qGuUvi3NIKghnNm/2pOMHRrG6HiN2n2gEzgT2jnlUmcdZ0v2olulOUaQ==
X-Received: by 2002:a05:6808:1704:b0:34f:66a3:31c3 with SMTP id bc4-20020a056808170400b0034f66a331c3mr3830808oib.224.1663384252092;
        Fri, 16 Sep 2022 20:10:52 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm4464800oab.3.2022.09.16.20.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:10:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/13] RDMA/rxe: Extend rxe_recv.c to support xrc
Date:   Fri, 16 Sep 2022 22:10:28 -0500
Message-Id: <20220917031028.21187-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031028.21187-1-rpearsonhpe@gmail.com>
References: <20220917031028.21187-1-rpearsonhpe@gmail.com>
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

Extend rxe_recv.c to support xrc packets. Add checks for qp type
and check qp->xrcd matches srq->xrcd.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  5 +-
 drivers/infiniband/sw/rxe/rxe_recv.c | 79 +++++++++++++++++++++-------
 2 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e947bcf75209..fb9959d91b8d 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -14,7 +14,10 @@
 struct rxe_pkt_info {
 	struct rxe_dev		*rxe;		/* device that owns packet */
 	struct rxe_qp		*qp;		/* qp that owns packet */
-	struct rxe_send_wqe	*wqe;		/* send wqe */
+	union {
+		struct rxe_send_wqe	*wqe;	/* send wqe */
+		struct rxe_srq		*srq;	/* srq for recvd xrc packets */
+	};
 	u8			*hdr;		/* points to bth */
 	u32			mask;		/* useful info about pkt */
 	u32			psn;		/* bth psn of packet */
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f3ad7b6dbd97..4f35757d3c52 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -13,49 +13,51 @@
 static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 			    struct rxe_qp *qp)
 {
-	unsigned int pkt_type;
+	unsigned int pkt_type = pkt->opcode & IB_OPCODE_TYPE;
 
 	if (unlikely(!qp->valid))
-		goto err1;
+		goto err_out;
 
-	pkt_type = pkt->opcode & 0xe0;
 
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
-		if (unlikely(pkt_type != IB_OPCODE_RC)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_RC))
+			goto err_out;
 		break;
 	case IB_QPT_UC:
-		if (unlikely(pkt_type != IB_OPCODE_UC)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_UC))
+			goto err_out;
 		break;
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
-		if (unlikely(pkt_type != IB_OPCODE_UD)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_UD))
+			goto err_out;
+		break;
+	case IB_QPT_XRC_INI:
+		if (unlikely(pkt_type != IB_OPCODE_XRC))
+			goto err_out;
+		break;
+	case IB_QPT_XRC_TGT:
+		if (unlikely(pkt_type != IB_OPCODE_XRC))
+			goto err_out;
 		break;
 	default:
-		pr_warn_ratelimited("unsupported qp type\n");
-		goto err1;
+		goto err_out;
 	}
 
 	if (pkt->mask & RXE_REQ_MASK) {
 		if (unlikely(qp->resp.state != QP_STATE_READY))
-			goto err1;
+			goto err_out;
 	} else if (unlikely(qp->req.state < QP_STATE_READY ||
 				qp->req.state > QP_STATE_DRAINED)) {
-		goto err1;
+		goto err_out;
 	}
 
 	return 0;
 
-err1:
+err_out:
+	pr_debug("%s: failed qp#%d: opcode = 0x%02x\n", __func__,
+			qp->elem.index, pkt->opcode);
 	return -EINVAL;
 }
 
@@ -166,6 +168,37 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	return -EINVAL;
 }
 
+static int check_xrcd(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
+		      struct rxe_qp *qp)
+{
+	int err;
+
+	struct rxe_xrcd *xrcd = qp->xrcd;
+	u32 srqn = xrceth_srqn(pkt);
+	struct rxe_srq *srq;
+
+	srq = rxe_pool_get_index(&rxe->srq_pool, srqn);
+	if (unlikely(!srq)) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	if (unlikely(srq->xrcd != xrcd)) {
+		rxe_put(srq);
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	pkt->srq = srq;
+
+	return 0;
+
+err_out:
+	pr_debug("%s: qp#%d: failed err = %d\n", __func__,
+			qp->elem.index, err);
+	return err;
+}
+
 static int hdr_check(struct rxe_pkt_info *pkt)
 {
 	struct rxe_dev *rxe = pkt->rxe;
@@ -205,6 +238,12 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		err = check_keys(rxe, pkt, qpn, qp);
 		if (unlikely(err))
 			goto err2;
+
+		if (qp_type(qp) == IB_QPT_XRC_TGT) {
+			err = check_xrcd(rxe, pkt, qp);
+			if (unlikely(err))
+				goto err2;
+		}
 	} else {
 		if (unlikely((pkt->mask & RXE_GRH_MASK) == 0)) {
 			pr_warn_ratelimited("no grh for mcast qpn\n");
-- 
2.34.1

