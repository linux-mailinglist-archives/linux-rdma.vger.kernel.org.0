Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679246AABAD
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCDRqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCDRqw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:52 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7981BAFD
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:50 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso3191963otk.3
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+2eRgZ8KYhml2H2Y6U9wDqhJyraTfw9SmXx0o4tRZc=;
        b=hfwZ0juf51smDu4eVU0GGPEAcVj584BMIDp+IoO9JHotguPFh65msXsl3VmwIhKok5
         8tEKwxAJBFI6YQMoVhP5uIEpcXVpGgNwC50aQYPUqDHN9ZbCYSWF75Nqbv8CljXyDNxu
         huEis8javDhkTerMrBP6ThpsRUtSLaHBbQoh74N5i2GhOAaxy8BUymt4dgF+6+HPuisQ
         LoUpaa8RmGR9PBrG7+DoMK/iPDdQ3nESdfUUFTbphCYt1Ukd/WQ9ivY0ES/qrdmbFMk+
         3JuhbDYc8ySFoDRb9t5KKczKCLlRBWS4wQq943/tsd/sG7n6VkVFCYhzqbtxui5fpu70
         sBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+2eRgZ8KYhml2H2Y6U9wDqhJyraTfw9SmXx0o4tRZc=;
        b=YRLiENxF33S7zTRVNEuMTbwm7QfhwyZhc2cXNAhGhK89xbSl0mWLGDM8X4yqeuf0x1
         dEFTmCwRGQUomJCnBnq9vSUMCwLVA4++8ZSZJMp+P/kHkzfyUJWfp9djO7CM+yWVmZmH
         UErfxEwGcaPLIFFWD3lc2htpU2drk8soXo9F+Y2O8oQxoj3UhGVN9Nx9vuKitA3Vk3nX
         wWarNRxQ74fEBIBdIhXHZ6QN9YqGBRXusnUlp06Rpw9Zv8f0KoBUYaylYJbamNqI+Brc
         fBAoHB3w+WG+z76c1dmeyb1pMZ5LxLNR/m7qTGPm01bSiT5SaPmY31QTViz0kANiOVmF
         8/uw==
X-Gm-Message-State: AO0yUKXm2esUJCma8cmGF2QWFelgqbchQVjZZc1yPaVH6Aik49vJ6pp3
        FhqWxclRl9mArDr2/ZKKDtM=
X-Google-Smtp-Source: AK7set/axC767nh6yUC2hpzS6Bz/SXKwQyG2hQrQFjHKo9fCtmHSf3S20HlxzOSL5ZjtnQqXdYOdOQ==
X-Received: by 2002:a05:6830:4ac:b0:693:c3bb:8392 with SMTP id l12-20020a05683004ac00b00693c3bb8392mr5315262otd.7.1677952009932;
        Sat, 04 Mar 2023 09:46:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 7/8] RDMA/rxe: Make tasks schedule each other
Date:   Sat,  4 Mar 2023 11:45:33 -0600
Message-Id: <20230304174533.11296-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
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
index 7aa8e90bdfe4..2c70cdcd55dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -322,7 +322,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task);
+						rxe_sched_task(&qp->req.task);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -473,7 +473,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task);
+		rxe_sched_task(&qp->req.task);
 	}
 }
 
@@ -487,7 +487,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task);
+			rxe_sched_task(&qp->req.task);
 		}
 	}
 
@@ -767,7 +767,7 @@ int rxe_completer(struct rxe_qp *qp)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_run_task(&qp->req.task);
+					rxe_sched_task(&qp->req.task);
 				}
 				goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index abc65c54bfd6..745731140a54 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -753,7 +753,7 @@ int rxe_requester(struct rxe_qp *qp)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_run_task(&qp->comp.task);
+			rxe_sched_task(&qp->comp.task);
 			goto done;
 		}
 		payload = mtu;
@@ -837,7 +837,7 @@ int rxe_requester(struct rxe_qp *qp)
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	qp->req.state = QP_STATE_ERROR;
-	rxe_run_task(&qp->comp.task);
+	rxe_sched_task(&qp->comp.task);
 exit:
 	ret = -EAGAIN;
 out:
-- 
2.37.2

