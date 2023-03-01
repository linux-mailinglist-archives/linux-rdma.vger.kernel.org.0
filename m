Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72146A6724
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCAEwx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAEwt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:49 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252738675
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:47 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q15so9837303oiw.11
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLNCxQadQe+fNDbT4AeNfKvUvjOLXJjOENPXWYS6D1s=;
        b=D+LzAKnVypVumqSSu4gRlhJzKy2vceGCcAHqzuvb//G5WxllsfeSarY9mGJgQIdH7e
         bNhOJdqdQd6PCqFDKCRiO31YdQ/NWblidd6+5XEJkcjlakmlwtbiYF3ay+GkFQQdox6/
         HZ5jBViHrHMrrmOefFie4W+7p/Foeio71Zv2EGUHRvja3UesivR0KwdvJa/CPc/ZbdVY
         +iwb4JMvnjnLRcV6VsmS92imUMlE1jL4zJK6TFtJxDp7n6l/ptAqKEsQXcjn6bWMP96h
         0Ab+bBXuNn7uSdFw5gXYaQv3H2we0e3470Pg10CJccti1qyOTooyQlRxryJLxNtHllsg
         Ag7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLNCxQadQe+fNDbT4AeNfKvUvjOLXJjOENPXWYS6D1s=;
        b=bNopleA/oUVqf0KkKSGiu01XAV+Ku3jf232wi7w8/WuSlm+eCahdxL19MYJIBKwOv/
         mZ9aSdh5p5ATUv8HfTj4AUKy5O9NIpUtlJ35lbMgVjYJdLPEM7RyenkOsN0uZ+yvtVua
         3bf9zDEctuy35Yh+WxhDIVQmitOlPErfagFVf8eBsI6RUHpMJ7xRsMMO+2LZNYV9ZI5Z
         xMM5QUY/Jw9mO/Kb0DIQKcLm3S+w9pvBCAfmvW9xrB27Q+d+ssifqldMO61gtVclS3WD
         IQIVSE798vHkm92gwrgwaOXUBHYBgqFZxQvSpk6NGYwlR8Ra37ZpyIF5ypBwHXb/ARU4
         CDXw==
X-Gm-Message-State: AO0yUKW1Sk0OCkQtFHjfLO+94HB/36WtSo/2yuW7GDCKDlzmBuaoMsAT
        RVNN+oolf95dj+Mp+dQwhFE=
X-Google-Smtp-Source: AK7set/0aXZguKCZzVTFEG1LAu1EMYZy2Jl3ZYrQTMJfRVdmEwyESNtLtKQfdBgTWwPD50uBOkzvIw==
X-Received: by 2002:a05:6808:310:b0:384:3429:aa8d with SMTP id i16-20020a056808031000b003843429aa8dmr2571802oie.31.1677646367023;
        Tue, 28 Feb 2023 20:52:47 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:46 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v2 7/8] RDMA/rxe: Make tasks schedule each other
Date:   Tue, 28 Feb 2023 22:51:54 -0600
Message-Id: <20230301045154.23733-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301045154.23733-1-rpearsonhpe@gmail.com>
References: <20230301045154.23733-1-rpearsonhpe@gmail.com>
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
index fa864c6704ac..6371ab140ad9 100644
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

