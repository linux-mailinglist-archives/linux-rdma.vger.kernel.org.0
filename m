Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECD607F78
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJUUDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJUUC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:28 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC6262DC7
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r8-20020a056830120800b00661a0a236efso2469479otp.4
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEGocqs8ZhTGDBgstqxV42UMAnOhyyzVCvP5BXHM/pk=;
        b=LqIHF4yjUeEOaLT12gPTdzP0ZmFnlOMZTj6weoUmBcrba4SoNoQyOnLJ44XL0Qpmw0
         nsr0BE7GFPd1/v9y6gx/SZfMhjUt4l3L2Nb1rnAha+gajQvHEBEovLqZM3FATRLrojIj
         FyemMMTQkV6lFfuhyZvCOpO78kDBDi22ud+OHTn9hjaJlvcQ/kL9hdJ1XbF3D1z757Ze
         VFyc8j6+hbSQe8V4G3Q6LDw+yNGxFnOttRWqvH9waWPIVYDcmhRqLUBZYwHvwBpdROaz
         iv3oroflAjaBBzo4fPtd0T3iWFHQ7l0Dkm+TZaHEfRdkYnfNG4R4M75oWBAevfldHYlj
         siTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEGocqs8ZhTGDBgstqxV42UMAnOhyyzVCvP5BXHM/pk=;
        b=NWPkDWByT2jfPzPqyf73vX274aNW9Fc5YwHF9mLBc2d/3n0XtQqOAK+40s36xu/KDz
         gepoftvx/liq58JN/7MlzAPz7NZG13xBytCAvduIIgdss1hN5m2j9Afc+kgtNt96jZLy
         aQhfQ3qbqZLgq0kIbjdr38BwEPG+WvXr1Z+S34b2N5Ar+Aw47td/K+S9P0Ahkn/6CmU0
         NKOjLsC+IgUkxGFeL/x2BOfTQu1wOcAwiLfnIbXycklfSCD6dLAMKCM8PPFQYjkpBERr
         l+U+/d2Unx8gH0RhU8FEd5Ui86iHH+kwsjairLKIVINpV0kuoqDk6IbZm7jimhniXKR/
         FYfQ==
X-Gm-Message-State: ACrzQf1gF6IusqeZdowY8sH7kslcc9vJTHuZA6J4XCBNoigy1tkcFFkO
        EAGicqgJNJiIpdPI0Cb14ouSmsrHNXc=
X-Google-Smtp-Source: AMsMyM6shc3K0jWIYMGLMZWKIgTM6cSFB5MKCBmCaIURG0E63fhD9BPNiZ/pts0lCltGUR13KU6N4w==
X-Received: by 2002:a05:6830:6307:b0:660:be1d:a753 with SMTP id cg7-20020a056830630700b00660be1da753mr10885243otb.54.1666382543845;
        Fri, 21 Oct 2022 13:02:23 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control task type
Date:   Fri, 21 Oct 2022 15:01:19 -0500
Message-Id: <20221021200118.2163-19-rpearsonhpe@gmail.com>
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

Add modparams to control the task types for req, comp, and resp
tasks.

It is expected that the work queue version will take the place of
the tasklet version once this patch series is accepted and moved
upstream. However, for now it is convenient to keep the option of
easily switching between the versions to help benchmarking and
debugging.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
 drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++++
 drivers/infiniband/sw/rxe/rxe_task.h | 4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 50f6b8b8ad9d..673d52271062 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -238,9 +238,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(&qp->req.task, qp, rxe_requester, RXE_TASK_TYPE_TASKLET);
+	rxe_init_task(&qp->req.task, qp, rxe_requester, rxe_req_task_type);
 	rxe_init_task(&qp->comp.task, qp, rxe_completer,
-			(qp_type(qp) == IB_QPT_RC) ? RXE_TASK_TYPE_TASKLET :
+			(qp_type(qp) == IB_QPT_RC) ? rxe_comp_task_type :
 						     RXE_TASK_TYPE_INLINE);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
@@ -288,7 +288,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(&qp->resp.task, qp, rxe_responder, RXE_TASK_TYPE_TASKLET);
+	rxe_init_task(&qp->resp.task, qp, rxe_responder, rxe_resp_task_type);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 9b8c9d28ee46..4568c4a05e85 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,6 +6,14 @@
 
 #include "rxe.h"
 
+int rxe_req_task_type = RXE_TASK_TYPE_TASKLET;
+int rxe_comp_task_type = RXE_TASK_TYPE_TASKLET;
+int rxe_resp_task_type = RXE_TASK_TYPE_TASKLET;
+
+module_param_named(req_task_type, rxe_req_task_type, int, 0664);
+module_param_named(comp_task_type, rxe_comp_task_type, int, 0664);
+module_param_named(resp_task_type, rxe_resp_task_type, int, 0664);
+
 static struct workqueue_struct *rxe_wq;
 
 int rxe_alloc_wq(void)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index d1156b935635..5a2ac7ada05b 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -7,6 +7,10 @@
 #ifndef RXE_TASK_H
 #define RXE_TASK_H
 
+extern int rxe_req_task_type;
+extern int rxe_comp_task_type;
+extern int rxe_resp_task_type;
+
 struct rxe_task;
 
 struct rxe_task_ops {
-- 
2.34.1

