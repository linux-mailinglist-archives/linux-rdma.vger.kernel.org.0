Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75B607F75
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJUUC6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJUUCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:23 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA525E8A8
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:18 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso4897668fac.6
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moCS8bMrE9y/ygj3tPnfai4xVg2bxmPG46HvIHu3Rcc=;
        b=D3dz7SN8vxDv3ri4+4tFDTIDnVCa5mOOzEgccIEvIVABT9vSlL2Fr8ft+EvrqjnlzC
         Nhx156SKpVZZzWGg+6kwQitq+LgiaetsAL97/SSo1PLqmuRjrIk2s8kxG6bGeOho8XOM
         D3NsocGR3d4+myNDOa3bCd9uanJ6Daf6l9VWR1E+NzceRYC2DHrX1cGYXx/bGItwKI8f
         t5CVwurDIHX2wT28+sbiOorCJ1aiiYce7+eBN2vYhd5MJ3fT8EUfikAlbmVW5d+D5cSj
         eejA5NOrbv8kwe5i0eYF4xwVt+66knwKdN4+c99B+F8tLUasB5YOLCadax15fjancEF8
         gS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moCS8bMrE9y/ygj3tPnfai4xVg2bxmPG46HvIHu3Rcc=;
        b=QUAomo6t6vrHQvRGP5JffTjaKNZ2atf/m001e+qMt6EABN97rIwIL7McvZWCnynnHD
         pJjkyg+fjwGEkaE+wFzUMya51cs2A402UyT0QltJ1dS6nartv1DXlevlM3ZfrFUvjuKZ
         BNC8h+5fJNGUWf1pX1E9ykBMb/kr0Df5XbjU/84NTncFcSXijuXNTuOCyQz38q0hbP0R
         +mP3iW5r23xJitZe9DoxOeNp/rxWHpDNd+3dSuwjTtoQ8I2xwWpZD59rszNCtTKtGkIx
         Qlq/f7FfdXuxjd4f1KYt/LHxSY0mtSmWQ9gqBUU92eGbPCvQ9PLcjDFHMtzMDouy6DBI
         SKhA==
X-Gm-Message-State: ACrzQf3bqeEHOHo2BSqnWovj0xg+WOEBMBU5KnGZLNtqnh0gk0QpJGPc
        O1QaTcEGNVEC9SrNhJHwm+o=
X-Google-Smtp-Source: AMsMyM7w7Iv5uCcUmiJXwS9kifFFrU7+WFm4kVRGLAHQa/nWBQzhT/+wKf+/eFEJZ1WxJi9Do1onuw==
X-Received: by 2002:a05:6870:b027:b0:136:662d:7cf5 with SMTP id y39-20020a056870b02700b00136662d7cf5mr31199175oae.110.1666382537518;
        Fri, 21 Oct 2022 13:02:17 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 13/18] RDMA/rxe: Make tasks schedule each other
Date:   Fri, 21 Oct 2022 15:01:14 -0500
Message-Id: <20221021200118.2163-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

