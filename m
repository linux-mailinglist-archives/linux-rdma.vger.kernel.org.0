Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12EE531EA3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 00:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiEWWfW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEWWfV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 18:35:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40372954A2
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 15:35:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v66so19512413oib.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5x4pHT7m+qaQCCx95mkxnheKs4eCyrj769T/wznOqXU=;
        b=WirMUMWVwo2U+Tuofdoirfd0uvG2Kwg76nqpSAQlxfQBI0H9p3Qf0ArDKq8VklrOVa
         4SXjo0W4Pu3wa9/IeKe3LGeQf7K3e5gnluuPBbdVKKfH02lqTSg8Mxe5jeP/BE0YENy4
         iVIQCDr4EsqERkZ0yJhGL7jAvT9QU4RA7cwKpW8AefRdi9lq8Qr29oxgBxDGlUfZ+IkX
         MfZMkZcqkTFeDg5yzbHcauqFdTXXLRMlmtrArZEWLaIWl2I1NMXZ4B5BYQRQmnVq7SB7
         hkJp5mcuxYU72k5flPNdTcbnGxGzwSeNDS3iUiivqZnc/pA7DatyPlcrkR/yj1W2gBh0
         5NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5x4pHT7m+qaQCCx95mkxnheKs4eCyrj769T/wznOqXU=;
        b=jj1U1ZOvIuNy/xooQjXFwKU7D6mnITjRA0FyV2XB4hYsowSO7MRkI/YC5uSww0Luk/
         0uFXP/hLRcsSAoD0bitv1l+10qZE28PdcN8jcWe2AzWcrYZo1u5pGpnTP6iJeEIoFSVg
         uqUxn/bcWcpGTyL2nxieN6c50devpQjOD0mRIOmXHcFyROgE7LhHkViObkFXWc2ny5Mu
         H/TKVwbl8LDBgDLPRc0gqYEI4T82qsstJH/jA6tMME7K5T0PBcV9mywumfYfzcUGCyTx
         zffxsjCVJIAjy0aZgT80pABBQBtEBCDsK6NfwwuiootI/p45rJfedG0PZO7nT/lYGyDl
         Wwhg==
X-Gm-Message-State: AOAM5326nQvIlWBIGTgFQFAXB1agaFkceZG/jNAkGOznwxJm+bX+esx0
        2SSOtGAtU2zP6q5glKpg1HLUDFcw3vU=
X-Google-Smtp-Source: ABdhPJy+8Pe2eWXVZRA4sS3WOIUfmec5ZMs2FIwAVFD5kRUKkBdSQcFdKQSu1ofVAGjRO915MhDgxQ==
X-Received: by 2002:a05:6808:2025:b0:32b:7da5:a598 with SMTP id q37-20020a056808202500b0032b7da5a598mr524988oiw.63.1653345319549;
        Mon, 23 May 2022 15:35:19 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id b19-20020a9d4793000000b00606b1f72fcbsm4388456otf.31.2022.05.23.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 15:35:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        frank.zago@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix deadlock in rxe_do_local_ops()
Date:   Mon, 23 May 2022 17:32:52 -0500
Message-Id: <20220523223251.15350-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When a local operation (invalidate mr, reg mr, bind mw) is finished
there will be no ack packet coming from a responder to cause the
wqe to be completed. This may happen anyway if a subsequent wqe
performs IO. Currently if the wqe is signalled the completer
tasklet is scheduled immediately but not otherwise.

This leads to a deadlock if the next wqe has the fence bit set in
send flags and the operation is not signalled. This patch removes
the condition that the wqe must be signalled in order to schedule
the completer tasklet which is the simplest fix for this deadlock
and is fairly low cost. This is the analog for local operations of
always setting the ackreq bit in all last or only request packets
even if the operation is not signalled.

Reported-by: Jenny Hack <jhack@hpe.com>
Fixes: c1a411268a4b1 ("RDMA/rxe: Move local ops to subroutine")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..ca0b60dd365d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -586,9 +586,11 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	wqe->status = IB_WC_SUCCESS;
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 
-	if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
-	    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
-		rxe_run_task(&qp->comp.task, 1);
+	/* There is no ack coming for local work requests
+	 * which can lead to a deadlock. So go ahead and complete
+	 * it now.
+	 */
+	rxe_run_task(&qp->comp.task, 1);
 
 	return 0;
 }

base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.34.1

