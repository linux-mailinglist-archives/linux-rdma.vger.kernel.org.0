Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA8607F6A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJUUCr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJUUCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:14 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055526206D
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1321a1e94b3so4942982fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfHzARTUOwlxk5UNCo6aVjcUHyvPDj/ohKpbqfaDQFY=;
        b=f3ZpvGDLIi4SdSSRQ7TUp3F9tXc8P5ppdQlx/UvIiMmQ2VYWFYa+xPdd6lR/Dmj0Ba
         J1AtTgwSJ1z2hbPHfkzUoj4X2i4gm8kRG7JaXn0eeB1var/QKAw2edlWh+ZS91ii3Y2c
         HNN9MxQX4GB/PU7gEIzS7X9SBe6aUFeWMt+tDeYZTPE3hHOUYEGVRnIdUoCBeiNDrWus
         pmr/B0vuHWqvWD/slMnsZL9/dxG1Yvc/5bfEYOhlnu+OhIG+/mEznjNyj4c4gZOh/3rw
         9H7vWa/piZ3thGXxR4LUUCNRgee8TiYSJrPtxqS+rWDkIyv6/dhFGyNieIKlwC9d6X1W
         EyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfHzARTUOwlxk5UNCo6aVjcUHyvPDj/ohKpbqfaDQFY=;
        b=A9QW40Mu8DUg9jgvbZSEOv9c81y8I7lcJVsg3GVdz5praMI5bQl5jOToPpQ/vQ1B35
         Se3maV/C+dItpSmAhKID8831USh5Y03dH6VTMPEuPerb9sxWjbVHnG5bir/6gYf6oxv8
         uTBj8PEdhvLgaVvxFvtizmQxSCiQ15Fa6C63v9+nfyBVXg70TmOEkWIEWF0PB4k230DL
         iFdKI6u51+r3PJ/rZSA7tkCm4SpaWZFLnoHu2Okz8sR523RLr8alh50FspdwIITaNEbx
         U1ExnSai3AAfhYvyrneDd7LbD9wCz2StyZVNVkdMBlk027tac8OavziS2ULBNiSRbwoD
         Hkpg==
X-Gm-Message-State: ACrzQf1BQFmGh38dOmmO5nYwrF52VhoVC2yXs/RHOwKrekK+NMc9aUcf
        PAtxtwx+d+ch6v22Q+eoimM=
X-Google-Smtp-Source: AMsMyM7cOuikro8415Tfh2beIGx7L0/qRjWZl/dE1yCrimMy/bT7QWWOWMT2Oqh/mOJumm03XotdGQ==
X-Received: by 2002:a05:6871:8a3:b0:13b:18ef:e8df with SMTP id r35-20020a05687108a300b0013b18efe8dfmr4529044oaq.181.1666382524365;
        Fri, 21 Oct 2022 13:02:04 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 03/18] RDMA/rxe: Removed unused name from rxe_task struct
Date:   Fri, 21 Oct 2022 15:01:04 -0500
Message-Id: <20221021200118.2163-4-rpearsonhpe@gmail.com>
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

The name field in struct rxe_task is never used. This patch removes it.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 9 +++------
 drivers/infiniband/sw/rxe/rxe_task.c | 4 +---
 drivers/infiniband/sw/rxe/rxe_task.h | 4 +---
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 57c3f05ad15b..03bd9f3e9956 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -238,10 +238,8 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(&qp->req.task, qp,
-		      rxe_requester, "req");
-	rxe_init_task(&qp->comp.task, qp,
-		      rxe_completer, "comp");
+	rxe_init_task(&qp->req.task, qp, rxe_requester);
+	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -288,8 +286,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(&qp->resp.task, qp,
-		      rxe_responder, "resp");
+	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 3fbaba9eec39..0cbba455fefd 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -90,12 +90,10 @@ void rxe_do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name)
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 {
 	task->arg	= arg;
 	task->func	= func;
-	snprintf(task->name, sizeof(task->name), "%s", name);
 	task->destroyed	= false;
 
 	tasklet_setup(&task->tasklet, rxe_do_task);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 7f612a1c68a7..b3dfd970d1dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -25,7 +25,6 @@ struct rxe_task {
 	void			*arg;
 	int			(*func)(void *arg);
 	int			ret;
-	char			name[16];
 	bool			destroyed;
 };
 
@@ -34,8 +33,7 @@ struct rxe_task {
  *	arg  => parameter to pass to fcn
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name);
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
-- 
2.34.1

