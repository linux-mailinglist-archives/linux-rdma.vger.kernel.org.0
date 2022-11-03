Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3E6185DE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiKCRLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A032701
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:43 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso2096101fac.11
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2rx2fgKE99TDnv4C+vPp5pRsHBHSzQySfbxS6plKX0=;
        b=n6U4LAbSCsAiw16I8X/6YMbgfUjGvD3QS/PeKg6uAzL7EKzwbZbfBqZa1HP8cKkJ4J
         Ekoo5wz/ljlb/Z/syQXHwMDMD/q7xG36yoXA8c0Ei+X+Yvd/6xKlv5286qFM6Wm+EYZ9
         Gkzd3LKOzOeb4aWEMN53vcyiqtcn9xTaMgLNZgpHBzhUDwf7QuVhYub4dNbkpOGQVZEd
         9QeYrNcGGRhOU5N2YeXF0BYUVwKadSs30RAIm78o/W4Rxs8LSHAUVfV6OQrD6p/FHblu
         mfhja43NBXoiGycBjPSCAo2K/HQe3TCtM19uCY156mdoeH6WzIIG28Jh0Y4OIL8YbTmn
         Hevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2rx2fgKE99TDnv4C+vPp5pRsHBHSzQySfbxS6plKX0=;
        b=jqrwNTmf46gjYIKQKqs68aAOzy72o043a9ho6Mb2sg4JTBouubroh70Tr+hF/waLfK
         wfKHPsbkdQhcnPskJjYXMxTIJ6AcRqGZcBRwCzWKncfItdTgk0Nyj5lD1OszK9zdpyXl
         0CWqkZjYUeLYnMOjDo7PBabXkVvTfaRDEM2Jvr6ZeSZtwGTZ29sIoIMYnrGVXNrBsqbf
         km2eOkn10EfgwZvClB6kGaa9T84VRjJtQPI7wu37Yj6VnYMEoBb4cwRY0F7H+HxZx2GN
         aD9ozKHEtlEWU6bYTW/SyTSi+eSyDtCFW9tWyUziooXZjGmRCX9yoxkGVbvqA0FHwevQ
         SdGA==
X-Gm-Message-State: ACrzQf2LWodZ767a0Uwp4Yoe7IV5uwXsL6TEqyQsKsGzOKHUisbTvxOA
        x0yXFmSJtJc9FfZnof0WOso=
X-Google-Smtp-Source: AMsMyM5awgCnfE3bLiuNZsdJJmwQehy7DEUsFpNnN2aq/DW7A9ddeWdyHaf1s15cpyuGWKlM5p4XDw==
X-Received: by 2002:a05:6870:a18b:b0:131:a278:7db9 with SMTP id a11-20020a056870a18b00b00131a2787db9mr18610488oaf.201.1667495443292;
        Thu, 03 Nov 2022 10:10:43 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 09/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_resp.c
Date:   Thu,  3 Nov 2022 12:10:07 -0500
Message-Id: <20221103171013.20659-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_resp.c with rxe_dbg_xxx().

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

