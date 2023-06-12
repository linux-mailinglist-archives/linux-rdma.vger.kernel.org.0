Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D172CB6B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjFLQYW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 12:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFLQYU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 12:24:20 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EC18C
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 09:24:19 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-558cf3e9963so2928212eaf.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686587058; x=1689179058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pV6UmTjMdgcknCi/9Crfiddvf78+7HWbLwo82bviUrM=;
        b=N/+aUTna4wacxmIdMlkcV44Om19Of3lTl2v7jv1OOR4vuc1OV6j/YU+DNZimtnsEwG
         oiFEoZBzc8REnJfckmzY5Sk6hNieLkKUBrlKP/NajlkaQvvFSnpiFdFIq9xWR8tq1Zmn
         Efmf4GpVXVp+9gMyedbx5NXa0gfThmCsg4GQ3SFxa1cVxigDzmAV9de6jSt9pplgq9Np
         P7pQmVxDEkwS60t7/o464jPr/QFWDxAbpJcq6NEowjNPBbhEAh62LDaZs+tPeFMkkqhJ
         Wy811V7Afz012wF3x71hSs3bwSeIqvEP4K7nV0MdnDjiPLVYYDzKq+zsMbbiw6jBRNo9
         axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587058; x=1689179058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pV6UmTjMdgcknCi/9Crfiddvf78+7HWbLwo82bviUrM=;
        b=dso4Kk/qyflG1yxyb2+IxSjEgE0NLdNVQ29PqjH2/VPile1zcbvpaNfhmEqK80repl
         Y2brPQDfri8IldcObqOZRTjJ3Qmg1C42JN6unfpJABMHZVBzvlbxMqvW8/05XaUuoxKq
         LQdT0cr2atHd8iBKxRIHcL1dTHzJeRElzjdHt41qRwCXj4MQ+TJ0SyWkJfwLcthLUTvf
         WByfYfSI07uugaqp9Mqaws75lOGtdMBGMiGTbVBc4ITJqtR0aT/409DcKX6SCACIGn0T
         xB2qqsgIHLdhskomc4/6FbYPNbidMwN+GtKjy/KZF2yCDqQ9RWgbuML+Nu2Eio7aiWOB
         YuRQ==
X-Gm-Message-State: AC+VfDxJUhsgN4SPb9tCwCYkXlOaCPNeg7MGHMEEMiCNYsoIGNc/cZGU
        3AJvR+ne0j+KiqXTWLra9EE=
X-Google-Smtp-Source: ACHHUZ7De+Au/UQ+d6MrHB6CKmS+8zoDY3i6f5r8PFv/FUWLhJHXnKZz+4xkZTr1rnyjm2Bx0GLIxw==
X-Received: by 2002:a4a:d9d5:0:b0:55b:2f80:39e4 with SMTP id l21-20020a4ad9d5000000b0055b2f8039e4mr5466801oou.4.1686587058342;
        Mon, 12 Jun 2023 09:24:18 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a8bb-e9da-af00-e223.res6.spectrum.com. [2603:8081:140c:1a00:a8bb:e9da:af00:e223])
        by smtp.gmail.com with ESMTPSA id z8-20020a4ade48000000b0055975f57993sm3316638oot.42.2023.06.12.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:24:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Simplify cq->notify code
Date:   Mon, 12 Jun 2023 11:22:45 -0500
Message-Id: <20230612162244.20038-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The flags parameter to the request notify verb is a bitmask. But,
rxe driver treats cq->notify as an int. If someone ever set both
the IB_CQ_SOLICITED and the IB_CQ_NEXT_COMP bits rxe_cq_post
could fail to generate a completion event. This patch treats
the notify flags as a bit mask consistently and can handle the
above case correctly.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 5 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 6ca2a05b6a2a..d5486cbb3f10 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -113,10 +113,9 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	if ((cq->notify == IB_CQ_NEXT_COMP) ||
-	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
+	if ((cq->notify & IB_CQ_NEXT_COMP) ||
+	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f6396333bcef..c7c673637dea 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1181,14 +1181,11 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&cq->cq_lock, irq_flags);
-	if (cq->notify != IB_CQ_NEXT_COMP)
-		cq->notify = flags & IB_CQ_SOLICITED_MASK;
-
+	cq->notify |= flags & IB_CQ_SOLICITED_MASK;
 	empty = queue_empty(cq->queue, QUEUE_TYPE_TO_ULP);
 
 	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
 		ret = 1;
-
 	spin_unlock_irqrestore(&cq->cq_lock, irq_flags);
 
 	return ret;
-- 
2.39.2

