Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5C611FA1
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJ2DKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E32A959
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so4014515otu.7
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLMAqDdDT7iDgI/SIqz57S3USSjHBvktEV3soMVXD0U=;
        b=LHOaSQwBUdnerTMbM0+P9aP7rp9JMFBFmUxgtQYLdBHupmT/j8fq2rpI/8RX8io5Fb
         fqy8URakPS2YQPAxyBdG0rJ/lVa8zElyv2QllLLVIdXQfhUOhLUwPvHlQiFIPkMSiMWl
         ybzdXBP51y7uO9VZNfrzY/04NuljHmjAfpO4SzZgH0cAh6isYJkHxIB1Qrc3jhOJ2GKe
         UB58lhCvqvpyuFX4nx7/uPhsNnPXpbBL7Nk2JseMBoOfycls205ufovm1uTIdQWf6jYQ
         ikohhoVAviDG1R4SFy2gI3Zs7X/w9MEWgrPhewicRwSOz+NxtOg9tt7Umz8aazXYSvJB
         IGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLMAqDdDT7iDgI/SIqz57S3USSjHBvktEV3soMVXD0U=;
        b=HZpZsOOjw/sNtmz+k0ShKlmcJQlBvQEnCMlAtfQjxAj6404zmgrOtUcR3TcC/3hKEA
         yWAxe8DQGGVsGWHue27oz6eZRAq2UTx9XabJr3GPhT+CAs6cATFLsGwk+gT3d/ImFjkL
         5GbK2ZsRj7Uxnej4vD9o/2peHtleUj6PLxKt0opWuHYL+ahaGGrK/3syEwV8FQFhlpN3
         PrAmHGWx9Be1vYw1ufpu5pvtYL7OTnMFrnbrTnpB9hhCsNmOJnA5eu6CgWbxC5QE23wh
         oROj2gqriywOBjrPQVYjTja0nVAB+lo4q98yhd25t0q4rhJWuaCMTnMp/0dtrYsffhqQ
         pMlg==
X-Gm-Message-State: ACrzQf2XYeOjx6mHyq4N239v67Qt60mpW8pJacNQFsy3YHo+IJzqoN5G
        Os6Snto38rXQSVINR66Ar4c=
X-Google-Smtp-Source: AMsMyM7xOftsJn6dfS6U0EG2TLnEIwzs29MoROezgPA81Hh/YjHfWCXIP29Jo2aKTPpOxi4KYX1NYA==
X-Received: by 2002:a05:6830:2e3:b0:661:9db6:223e with SMTP id r3-20020a05683002e300b006619db6223emr1235308ote.338.1667013030351;
        Fri, 28 Oct 2022 20:10:30 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 12/13] RDMA/rxe: Make WORKQUEUE default for RC tasks
Date:   Fri, 28 Oct 2022 22:10:09 -0500
Message-Id: <20221029031009.64467-13-rpearsonhpe@gmail.com>
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

Change RXE_TASK_TYPE_TASKLET to RXE_TASK_TYPE_WORKQUEUE in rxe_qp.c.
This makes work queues the default for tasks except for UD completion
tasks.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 50f6b8b8ad9d..ca467d8991a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -238,9 +238,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(&qp->req.task, qp, rxe_requester, RXE_TASK_TYPE_TASKLET);
+	rxe_init_task(&qp->req.task, qp, rxe_requester,
+			RXE_TASK_TYPE_WORKQUEUE);
 	rxe_init_task(&qp->comp.task, qp, rxe_completer,
-			(qp_type(qp) == IB_QPT_RC) ? RXE_TASK_TYPE_TASKLET :
+			(qp_type(qp) == IB_QPT_RC) ? RXE_TASK_TYPE_WORKQUEUE :
 						     RXE_TASK_TYPE_INLINE);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
@@ -288,7 +289,8 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(&qp->resp.task, qp, rxe_responder, RXE_TASK_TYPE_TASKLET);
+	rxe_init_task(&qp->resp.task, qp, rxe_responder,
+			RXE_TASK_TYPE_WORKQUEUE);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
-- 
2.34.1

