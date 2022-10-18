Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D9260235B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJREgk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJREga (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:30 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09CA0270
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:28 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w196so14384233oiw.8
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moCS8bMrE9y/ygj3tPnfai4xVg2bxmPG46HvIHu3Rcc=;
        b=I5jXWSMDLgl+WNPTDFSY4uizQA+6CzjOFBqrPrr8VgwdQGIa+H/Zm+eNFZ1j5tb3cD
         G4b3BCJ8JAOOkfSB4MGvf3v4/ko1XKxddqIac2mjqyXcMA4iWjzjg/ZzJ2O+ON/fsYMN
         jF1xe0fsDQjGEJEsWsaceFo40FyzdPseoYZ5CpdWL4OAkoVuR2qvWw04lq0uyDMS69wH
         byynAPYPHsXBhWrcHDy7NWiSCz3X5T/F0kOG4ZWzsagwU1xL8S89KYojfCAM4I32j40x
         810yUvt1E3wGZlpnK47iu+5856xk+hn2pUyYzP4csDs3eNzJe5239oW0sKHvos/WuteP
         /mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moCS8bMrE9y/ygj3tPnfai4xVg2bxmPG46HvIHu3Rcc=;
        b=b+w5Ei8sXl2lTAgsVBA4blbbydHuZu3W3tPGAltUfmFGhXEDyjQQLtKa9JdIRIipfA
         Ee2aS/qMb1vqY1YCbmMVKaWDvzKH3ulSIci3SrZtg0PG/BGpz87YpDH4RCgVTiQK8LQp
         73gmdcAFDdhEvbzppbMHYh2So7Q+VP7VldqVvsPw+ciQHXIOLv0R6GmxH9m0Vu+k2f72
         StmkgFLqn7LGSQukfXIY/wEPqvNqCA1WiYAQ1u6Ccf9m4gCihLWvV7nu4PwgMW8bT3qL
         MGVAICAjO4r/WPYR6farTXecB/UVhXDBHq5jBUTJ9gRCHSboa81AXHnqarAtqlZQFQeQ
         ucjA==
X-Gm-Message-State: ACrzQf3B1ANFQc/CYjN02Ud5YXwZwBDIEqu4jkGPhYjKhLPqpCM21wL2
        skzj9IFh3TD2C1iuNMZzwVo=
X-Google-Smtp-Source: AMsMyM4yH2VC5/4+gB49TYIYz1XoncbT3t6bHTTv8KITRQBACSTSkPHvjBJjbl6+wTA6+ZHdDH3Ytw==
X-Received: by 2002:a05:6808:3085:b0:355:956:6fe4 with SMTP id bl5-20020a056808308500b0035509566fe4mr10925737oib.43.1666067788026;
        Mon, 17 Oct 2022 21:36:28 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 12/16] RDMA/rxe: Make tasks schedule each other
Date:   Mon, 17 Oct 2022 23:33:43 -0500
Message-Id: <20221018043345.4033-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
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

Replace rxe_run_task() by rxe_sched_task() when tasks call each other.
These are not performance critical and mainly involve error paths but
they run the risk of causing deadlocks.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 8 ++++----
 drivers/infiniband/sw/rxe/rxe_req.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 5d434cce2b69..6c15c9307660 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -308,7 +308,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task);
+						rxe_sched_task(&qp->req.task);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -455,7 +455,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task);
+		rxe_sched_task(&qp->req.task);
 	}
 }
 
@@ -469,7 +469,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task);
+			rxe_sched_task(&qp->req.task);
 		}
 	}
 
@@ -723,7 +723,7 @@ int rxe_completer(void *arg)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_run_task(&qp->req.task);
+					rxe_sched_task(&qp->req.task);
 				}
 				goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 41f1d84f0acb..fba7572e1d0c 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -733,7 +733,7 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_run_task(&qp->comp.task);
+			rxe_sched_task(&qp->comp.task);
 			goto done;
 		}
 		payload = mtu;
@@ -817,7 +817,7 @@ int rxe_requester(void *arg)
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	qp->req.state = QP_STATE_ERROR;
-	rxe_run_task(&qp->comp.task);
+	rxe_sched_task(&qp->comp.task);
 exit:
 	ret = -EAGAIN;
 out:
-- 
2.34.1

