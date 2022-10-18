Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCAA60235F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJREgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJREgf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:35 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A77A0265
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n83so14389821oif.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr6A3rEE+c3RZe1NR4tKdOx5mJcIGy59rKaiFSlw9bQ=;
        b=kFZzU5HGxVF4SJ255RlThKej+w6gEYO4mJ8ohsChuxyluCrdhrbyGVrl22jjvtJ/Wy
         AfA4Cy9IBW/IduftZmNnSq9WVwylWDaLdd6fIbgfxd0s4gX1Xt5nXxEF97evFlTYwdc+
         CFlTL+CMJrGJ2ER4J1FpPHvCrBAVjPhtVno84js5BoJ87DWt9vzTFzO1m1+skWmC8zhd
         yvzie5Ukn/khA+MZUhoHVJVRbsHk44atH+p8hT85aLAw9xT55Rp30ygNIeczHrAnaTGR
         UBXggapp6WKlttrebjrsVTMnUv67MWJJ0elmir/6J0XaBVV+TOfcMBtl8zRoj53ClIA6
         Xf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr6A3rEE+c3RZe1NR4tKdOx5mJcIGy59rKaiFSlw9bQ=;
        b=wDEzQwaMPkIO5LyfhDPECZcxDb+RUdMYMjaH11DRMWGU4mAK1ffF3mFV6h+zmm09FK
         dusd9xzUg+ZHioTSGzqDbeF4cOlXGuwZ0meqAuJpArijhiwIJjpbg9UXnjnR2C9Lj1Jg
         IYJUsV2waWXaDP2wQaqFhkmuKsZGpLH3M86Dh7K+pAdvI5ATGpRdTBM2pJAlhMGfFKj8
         lkDaosf0exU1k9qduT8nwO9ZudsKNhHmxYJFeaXG+5UACZ0COnUAQsibVmrDtkpP5oyM
         qH+ee3/C5XgRoFsNZwgrRgn6hJQnokX4/xHihSN59Rh6xjDg+E5EJeFzP35/AiZnXqL3
         bQ2g==
X-Gm-Message-State: ACrzQf1TuaMMZX4R7PkCGJxkELeGR1CdW/CXBC7BzOskhhM2Lp/3rzpu
        qh5novYNA4QLvZMms0+HPdzlTFOFENUD2g==
X-Google-Smtp-Source: AMsMyM5ff7oZTHUzC2Elu+pIsqiJhvxPXjYdZKzYPlt1pTToEpwRy3tmdgpvTk55l8Fm6S+E3eNvLQ==
X-Received: by 2002:aca:f1c5:0:b0:355:3d98:8c09 with SMTP id p188-20020acaf1c5000000b003553d988c09mr3154774oih.203.1666067792803;
        Mon, 17 Oct 2022 21:36:32 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 16/16] RDMA/rxe: Add parameters to control task type
Date:   Mon, 17 Oct 2022 23:33:47 -0500
Message-Id: <20221018043345.4033-17-rpearsonhpe@gmail.com>
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

Add modparams to control the task types for req, comp, and resp
tasks.

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
index ea33ea3bc0b1..350b033e6e59 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -10,6 +10,14 @@
 
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
index 4887ca566769..4c37b7c47a60 100644
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

