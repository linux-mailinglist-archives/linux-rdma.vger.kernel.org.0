Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6B6CF333
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjC2Tdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC2Tdw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:33:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F7469C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:33:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r14so6783961oiw.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680118430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihkcFGYS+VaXUWTugYJxnj1XHAb5OlSfEtCm1pluzgs=;
        b=dytiRyRnmwsKrPmKBEL4iCewx19X+fmdf1n3Q9IBQfJ6hP3LyLCJSWpRbHXiE2EjjB
         aMe20+62lDcopz4DzJKWNtOZgmLiEg47QZ1Qhv9PJi2NMbMl+65wwn03HOiSwwSXKciV
         yEl6OvE4hmcdmmDNcMt6QAC0D/wU7A631c3uOI84LhC/M/x8ujyy4FYW1qarIJqSTK4T
         uCWTOYrseP3Ry72v3dOm7IeY03RbWFbDscO/IQlCcrmJ/KmbL0DmMMAqkTCb9ooS6Bk5
         mKzXoXV9cs/M/F1iLTKg6ePrytIbKXRDVCW7Zqb8c80PQiVxO8ybH4tsyIDbrjazxe3P
         UsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihkcFGYS+VaXUWTugYJxnj1XHAb5OlSfEtCm1pluzgs=;
        b=0yEkfnhY9Hmp2uaDeNqJOQWO4rQV8MtBtCKFMZyYJoOoGtwbVFwUTPHSqn0+L2awNi
         SBZHgIDc/Lz2znYlugpp30vAtlymJyahrqjyjkkUF3LE9SwPrDqdBra6wznUH27OrH75
         eieW/PFw+KDzjCeM4+ZCuvsokCpZbq66/b4GR4RKXHYrYHIhfiv1m1AfW6NBKovATuPX
         DhzGcZV5zLM/foou+9vdmKYibtXWpnFlWay3sR3LSMEnzUivFLMUZfnbepteE0/Qyi6F
         kU5IL9pRnOQWaXKmEcY68V8P1u/FUROBw1F8v0uJwxs73ldCXZcFaiq+1730qHp8bYo7
         Npng==
X-Gm-Message-State: AAQBX9fRXgefToELWL7689WfP1QlFeloR0koGzcjQnXSzyw+6E3Wdx2G
        FldJFBBDovpifv9aE3oFCS8=
X-Google-Smtp-Source: AKy350YbwBOmDGKGq/FilgzUEYlkCeqlX0MezFHIk8AWGJ4tWQXNYWKcGf0qFZWxN2nHZ6yH4aAk4A==
X-Received: by 2002:a05:6808:aae:b0:389:4c8c:d069 with SMTP id r14-20020a0568080aae00b003894c8cd069mr3959134oij.57.1680118428694;
        Wed, 29 Mar 2023 12:33:48 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id p204-20020acaf1d5000000b003845f4991c7sm13994114oih.11.2023.03.29.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:33:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     error27@gmail.com, leon@kernel.org, jgg@nvidia.com,
        zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix error in rxe_task.c
Date:   Wed, 29 Mar 2023 14:33:09 -0500
Message-Id: <20230329193308.7489-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In a previous patch TASKLET_STATE_SCHED was used as a bit but it
is a bit position instead. This patch corrects that error.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/linux-rdma/8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain/
Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index fea9a517c8d9..fb9a6bc8e620 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 {
 	WARN_ON(rxe_read(task->qp) <= 0);
 
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE) {
@@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
  */
 static bool __is_done(struct rxe_task *task)
 {
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE ||
-- 
2.37.2

