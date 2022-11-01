Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2E61532D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKAUYB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKAUX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:58 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA41E739
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13d604e207aso663861fac.11
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVe9ZfLRPNYHOfmtzWp4JC0kPR3TnPVQz8nZ+/weqCs=;
        b=Y6pD2RXG7X8DZ411ySdi1ETNdSY4f6mVIGPbc9TaCT07vVrlNodBCXfEngElHUthYC
         bNaqQpT+XBs985PfpqbjDq1FV45c4u9D4DNmVmbmnwB48Rtep0WygQ6ASf8HjykD/Pu+
         +ZDem07VQ95gWLnh5Ed6XH+Sj2zZ4l1aSnFhvRE9cV0GcPtl8Ehz1b0hIe07paNEGiiK
         xbUqPk2mKi7zrT+ti6TPkuhSXtpMZQDjdmGXOEEJmfj/luH79m5F6VQymP5Icw4OCEJX
         Fnym9mkEmd1HO9ZHWiTGPROY+jFOt79OwNfMvNF2PluXwrEyPn79VbCmShR7DvBHS3Wq
         d0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVe9ZfLRPNYHOfmtzWp4JC0kPR3TnPVQz8nZ+/weqCs=;
        b=bgQIZxC7rF0+/MNT9cedcF+YEoHZ7C/lofN3VHC8KZMoE76M3X4qGwDhfjPhXMbWHz
         aZoo/T5+jTutwo/nJpKT7+2wSAKbCWsjgZ1Ws4TqJrVnbszZzZ8Dsy3QohJNDpH4zqZC
         8P0SxsnDDKsCR2kiu1Q7tVzUw19e+XwcyfYjbuxHR5rXY/4VnALucaOZOWf/trkJ6x6y
         xYN1jZjvjrzyDnT0dskmkcJzaODHsFh9ersrjWpRCmtfolrRinSlPW29+2jARrF+ORri
         6q8MT+5lxsSY+NigPx920xpsF6hwW/2quAGXOtAYp8evcCFvLrD6knlY+1tkkmpuRvvL
         lM+Q==
X-Gm-Message-State: ACrzQf1F/wJytDa//VTBDfg+eBN4ZkDdn/o/S7S7ILmONAvuFXGLKLL+
        6JwDDVPfO3sB3QtAfBBjNWg7F0hoVXs=
X-Google-Smtp-Source: AMsMyM43CRLSUO1WWGLSdCBkXrmCXf5nea1iLVujd60Jfcudcmeu/IaUyhPYmjF4wnd9tDR3IECwIQ==
X-Received: by 2002:a05:6870:a997:b0:11c:5a86:e11a with SMTP id ep23-20020a056870a99700b0011c5a86e11amr11907877oab.270.1667334236866;
        Tue, 01 Nov 2022 13:23:56 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:56 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_resp.c
Date:   Tue,  1 Nov 2022 15:22:34 -0500
Message-Id: <20221101202238.32836-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace calls to rxe_err/warn() in rxe_resp.c with rxe_dbg_qp().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c32bc12cc82f..61f03ff3c696 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -317,7 +317,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	/* don't trust user space data */
 	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
 		spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
-		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
+		rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
 		return RESPST_ERR_MALFORMED_WQE;
 	}
 	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
@@ -453,15 +453,14 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	if (rkey_is_mw(rkey)) {
 		mw = rxe_lookup_mw(qp, access, rkey);
 		if (!mw) {
-			pr_debug("%s: no MW matches rkey %#x\n",
-					__func__, rkey);
+			rxe_dbg_qp(qp, "no MW matches rkey %#x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
 
 		mr = mw->mr;
 		if (!mr) {
-			pr_err("%s: MW doesn't have an MR\n", __func__);
+			rxe_dbg_qp(qp, "MW doesn't have an MR\n");
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -474,8 +473,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
-			pr_debug("%s: no MR matches rkey %#x\n",
-					__func__, rkey);
+			rxe_dbg_qp(qp, "no MR matches rkey %#x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -1044,7 +1042,7 @@ static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending %s\n", msg);
+		rxe_dbg_qp(qp, "Failed sending %s\n", msg);
 
 	return err;
 }
@@ -1290,8 +1288,7 @@ int rxe_responder(void *arg)
 	}
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", qp_num(qp),
-			 resp_state_name[state]);
+		rxe_dbg_qp(qp, "state = %s\n", resp_state_name[state]);
 		switch (state) {
 		case RESPST_GET_REQ:
 			state = get_req(qp, &pkt);
@@ -1448,7 +1445,7 @@ int rxe_responder(void *arg)
 
 		case RESPST_ERROR:
 			qp->resp.goto_error = 0;
-			pr_debug("qp#%d moved to error state\n", qp_num(qp));
+			rxe_dbg_qp(qp, "moved to error state\n");
 			rxe_qp_error(qp);
 			goto exit;
 
-- 
2.34.1

