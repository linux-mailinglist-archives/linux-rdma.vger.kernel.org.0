Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B87562295
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiF3TFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiF3TFP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F237034
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:14 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2a4c51c45so479840fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv7fZnS0RrFaJh9bc0HOC2R7xKFbMSNqXsVuNFHrE64=;
        b=GZVQ2umwV/OdhejQewnw1s3+U2mNlbyxN8wwk0Bma8FDRWTf3lQSPoHVpn35850mKh
         fp8Ve9epZwLendTgh0NsOwfH/0S20hNOJGVy/GeFnVx/YpcXta9RRgs7USdksYOYycny
         ZL3RfkLp+0RCrbaO11AZsO+8ga32zKB1y6lBZbteHzM0cpGby/70+ID2OW0xxOwGRav8
         n7kCefH4rxeLUEsDq13o/13h5qUb9bnAtLKZrN7Kde4t+/VSM297aGl5PpFXqm24IOOC
         ndqwoTmcXxtA5V6BzMGkghTPzsfYPgPclVzn2REBLHTi4Za779NG15XJHwz8QVCw3BMU
         OTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv7fZnS0RrFaJh9bc0HOC2R7xKFbMSNqXsVuNFHrE64=;
        b=ijjXNsIPB4RqXbg2L9tHCwZP6BCsV1KnneL5/y3N5v16/blR4Kn9ihOrAWY0UBQkHX
         pPsmLDtwjgJyHX1tOwTgiqCtgzSh7MhMOc3370OT3+9dkrlC3P9aTMrzSxTaki5ygq/m
         hMMU2nIsPc9IrYaAHNeuZinA4SYSl7x1agD7q2/0dZXXgxnUdF7kZ8nGVDTVj+ok2yf+
         17fAzWrP4HO8rMA5e53D28rXxqsbJdfwQpk18i+fizcPsj9l8lo2AaIctC9SI+UpVAEX
         10qlyIpCNwq4izZZ89XUrgf/PFpKHzUhtjpAu9BBtdNPps72qX62xmsZBpC//dp1rnKd
         M9uA==
X-Gm-Message-State: AJIora9bdkTSZgdHJ87vfrIG+rjmkOlUMpJWXAikHn1CPk/xoNr7Vwv/
        fzJcxQy2X384IuYolPI7k0o=
X-Google-Smtp-Source: AGRyM1v8xB/PSf1VGFSepX0s7ljyLRserDD607fVVrV7Vv5KtnITbR5JI2tKSSt+emsxm9X0+jtVPw==
X-Received: by 2002:a05:6870:8914:b0:106:9d06:fe63 with SMTP id i20-20020a056870891400b001069d06fe63mr6839475oao.103.1656615914081;
        Thu, 30 Jun 2022 12:05:14 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, Jenny Hack <jhack@hpe.com>
Subject: [PATCH for-next v2 6/9] RDMA/rxe: Fix deadlock in rxe_do_local_ops()
Date:   Thu, 30 Jun 2022 14:04:23 -0500
Message-Id: <20220630190425.2251-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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
index 4d92f929d269..81eca57b04b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -605,9 +605,11 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
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
-- 
2.34.1

