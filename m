Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3B611FA4
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ2DKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494142A964
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:25 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13bef14ea06so8364180fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUSQl+n9eOMiYHJBVEgK0D6CPdr/mZLR3WgDvJg/GxE=;
        b=Kp1HlXbePzZw3g4IicJDCVeMZQvKaAPKo7VZhX9Lpj3Npjbgo9KkFJHBiNKK+KuTgq
         EkMu4vMrwRln9zhh/SmyD9l3/sEc0lx14vPtu6OQm1uIC2eOc8i7db22DA2qn2yaZYLA
         TQYxkMS5H0hJO9hn+CTwszqPXlTJYV7nDGS4zQFfWPjJKX1umHDdYrAVGfIH3UPX5VKK
         V27hQ3ezrAWziZCqna5F1n468aAv8AKIfNQCLJW+59/JIPox5/AGMqbaAGJeKeHaC5qD
         8gB3AMlJjKR8j9rmcbKmFpqsn7itm9LpBwBJCGCTF+CqlqqTA4TJippbVorCAS4/UD5g
         7EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUSQl+n9eOMiYHJBVEgK0D6CPdr/mZLR3WgDvJg/GxE=;
        b=ReTQYXtmGiC09kLwmK9ygn/dnCjDa/EvGm11mqCsaje/0JTankgZrbTDFNjo2JV5xa
         3FMLu2/zc4+XGJ7LWRcwN3sWSak/F7XEktf6nkLh5wO2KtQ/jeXBn67xtI+LzDCcbVS/
         dW2jYDtipq0wR7LmU3PtBTv1TOXwSFxWWAWJKyuJ0+Zqax+wrVN5mdVXktVhbWOqYf2m
         K/4vk/ZWeZQ6RfxPPTgJqvb4wTxdcLb8GYmQgJ1a1ojrjrBnnHtmjfpsN3B1AQFLae84
         jjQnNyRqFHvRdPOk6gJbIzC06IAx1qZDjQd/iEPfp+8FP24pLWXSP8WTVggaHbKX9b7Y
         mygg==
X-Gm-Message-State: ACrzQf2EVUmyrcLw/XLe0QoGvGcErdZBaQuG7zm0S9jPXCHdgKNqVJ4H
        ZRhcISy/5R8mnsN+wUiVQLg=
X-Google-Smtp-Source: AMsMyM40ZA4wCI0Rm6XDR5AcD16LrQ0Pew7qlYdVDeuckjln5UQFQzpxob5wOTjMCr+Qn2sQvsPpGw==
X-Received: by 2002:a05:6870:e88a:b0:13b:6e13:a9a5 with SMTP id q10-20020a056870e88a00b0013b6e13a9a5mr1324180oan.264.1667013025060;
        Fri, 28 Oct 2022 20:10:25 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 07/13] RDMA/rxe: Make tasks schedule each other
Date:   Fri, 28 Oct 2022 22:10:04 -0500
Message-Id: <20221029031009.64467-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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
index 76dc0a4702fd..f2256f67edbf 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -316,7 +316,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task);
+						rxe_sched_task(&qp->req.task);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -463,7 +463,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task);
+		rxe_sched_task(&qp->req.task);
 	}
 }
 
@@ -477,7 +477,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task);
+			rxe_sched_task(&qp->req.task);
 		}
 	}
 
@@ -731,7 +731,7 @@ int rxe_completer(void *arg)
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

