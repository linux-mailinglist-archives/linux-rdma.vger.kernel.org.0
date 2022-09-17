Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F085BB5CC
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIQDLw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIQDLV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:21 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05B9DB6C
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:16 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-12b542cb1d3so44955109fac.13
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2sQYsVirRP6MdY15qHzh8WxTTUEdGT3IBBGPdUTLpFI=;
        b=MQju2xXVMj3zhesztM+J4UOUYJdNCuNrtPQm8KZmR4UWEmd0m/EtNlX0TMiDnE4gOX
         o7HNTa8VXePLuz6EfdYrUdGSeDc7I2KHtOj3WyU43IsJFoQCrfXbeV+ZZPsnLYBzUWQR
         HcrC6alQtrmQ9IMos2x+BCJMsJaAqNSD7KPq0/VJU+QPNI1lbIgmlU6igQhNRYiCrkxS
         dWtKQNN7Mv3xJw1QrzZTXAR/vxeuDGqYXCENjLFJna/brcCfXMCAK8CxUnH07hWbT/lu
         +601qcqSqyi+wJqbebJbYf33yoQYNylDkWe5jRUVNbYpOcwvV5ei3yihHTcUt3f+UGZ8
         3Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2sQYsVirRP6MdY15qHzh8WxTTUEdGT3IBBGPdUTLpFI=;
        b=TTL76awRRgiXoKCy7bWE9lcMXuS0NATeB8zV0ry76BTduFW3aXhTsMX7k0GaeoyuEl
         Z0sBWKCvmj1LUpLgVOaX/ZdckKKd9qI+IAFwPC9W/5JuxZeM1qtNUbjmX5dBIdMqEBSX
         1Nb/jfEviewRsdqgw2Cqyaa0VbYqNBCrFmA+u3xz5SQcRTqPQpkOJGD8lZzyAOHR1YOb
         SAfSBSNxTrylfKQc/4sVuiW1E0BPfM37jGdi2JA7oG1vnqEp10TUFl1PMLUs64mluicy
         OeVGqqlVIOkRM560N5R/uyu6/Da/F7jWdkTZngEt6wbw36H9d79w7hOJTp/NOCmQAZ/c
         Uzhw==
X-Gm-Message-State: ACgBeo26apCR42aiBWO1bs8lsAdQLrXwulnt5PsWktT7AqZoXPNyMleZ
        aHMP7cSLYdzlq9BRZf5op7U=
X-Google-Smtp-Source: AA6agR5EqS42wR4GOmLz5/XB3LRs53V53NycHalSumUrWZ7WdV5LuOi+RpgBF9uLyvzfEpAkQ24Vsg==
X-Received: by 2002:a05:6871:29a:b0:127:6381:9bbc with SMTP id i26-20020a056871029a00b0012763819bbcmr10590878oae.77.1663384276233;
        Fri, 16 Sep 2022 20:11:16 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/13] RDMA/rxe: Extend rxe_recv.c to support xrc
Date:   Fri, 16 Sep 2022 22:11:00 -0500
Message-Id: <20220917031104.21222-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

