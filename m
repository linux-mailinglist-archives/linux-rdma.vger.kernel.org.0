Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8735B7D15
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Sep 2022 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIMWb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIMWbU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 18:31:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE761119
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:31:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1278a61bd57so36101849fac.7
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2RHp9JX9JRKmHW11AcriMY0FnL/jJyQCUF1ljHas1x4=;
        b=J6mFijn1Cq+JxTASpi+c/UQ0rH3jKS1vLRu5SaQCdbozq+xNYbGOyZ7NPkYU3sSuxL
         CRQ401essDxJ/Mk61bdoGTQP1CL99qjzTkNlMirq/HFBz19VTKQxr6gykN69mzzPJatp
         97ZiHOwQEuoOsVPp6pdrnCA8jC0JOU3JZ0vNnzP1IfuzvJp1zTR+n7watt+7EjJlEgxy
         zd8JOZO9hC6rKOp0C5YOVUmuHciBm4VFxT1mIut2+JUaOMC6GVSqjii3aHen7IMbMapd
         /deQHiLOJRgynmpnNHvaY/Cu4lgvdt/jR312/miUWyTPJatQOn40bXoPNy3FDq+X/RIj
         JzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2RHp9JX9JRKmHW11AcriMY0FnL/jJyQCUF1ljHas1x4=;
        b=7azSxD8QRV9dsbRtD4R/9ta1Hy0Rx4sCXgcNhxX65wxA/pQiZteX89lrcteYDSvFCU
         m4DqtID2dMW80kX1EKluOzII7zU2mvxkKOQjS8pKXngQRRp8m2GwgzC3PxsyHBhIaGNz
         KKtFgkZmdabuk3T5W9gr25jEF9193NcmP/Ld1XtAqsIfQOY5zS6t1nPbdHNgSVdumf/U
         NtvlXZZBOTmfIYGfd3V+qLtiK2Z9emMgJZDYxlbxPDVhNDgobyReo63jIbLdU/bktTgV
         c4oGDJjAhHZ8urlh/UrdIHhL3qGWDr3tf3TJf0T3SMiVcIVCUHgiokki+cIq+BTPsKsT
         LkxA==
X-Gm-Message-State: ACgBeo0LuGQK+2fwN+pnxLr6yfjLyRhe/0evSTr+S9de4q5UE0o/F0ay
        Aq4WpG6MN0Ic3kl5b9WPyDaoK4q6lpo=
X-Google-Smtp-Source: AA6agR4ImeTqaa8JqHULsam35xEBxDolqkgJaccsli18PwCmSpTae6iWn4+O8dBkjt7lNIhn9phBHg==
X-Received: by 2002:a05:6870:1702:b0:127:cf3f:37b4 with SMTP id h2-20020a056870170200b00127cf3f37b4mr764265oae.254.1663108278833;
        Tue, 13 Sep 2022 15:31:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-d098-9475-e37c-b40b.res6.spectrum.com. [2603:8081:140c:1a00:d098:9475:e37c:b40b])
        by smtp.googlemail.com with ESMTPSA id v17-20020a05683018d100b0063696cbb6bdsm6537131ote.62.2022.09.13.15.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:31:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/2] providers/rxe: Remove redundant num_sge fields
Date:   Tue, 13 Sep 2022 17:30:51 -0500
Message-Id: <20220913223050.18416-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913223050.18416-1-rpearsonhpe@gmail.com>
References: <20220913223050.18416-1-rpearsonhpe@gmail.com>
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

This patch is a matching patch to a kernel patch
"RDMA/rxe: Remove redundant num_sge fields" which
performs the same function for the kernel rxe driver.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 providers/rxe/rxe.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 9a900e4d..0e8f5605 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -679,6 +679,7 @@ static int rxe_post_one_recv(struct rxe_wq *rq, struct ibv_recv_wr *recv_wr)
 	int i;
 	struct rxe_recv_wqe *wqe;
 	struct rxe_queue_buf *q = rq->queue;
+	int num_sge = recv_wr->num_sge;
 	int length = 0;
 	int rc = 0;
 
@@ -687,7 +688,7 @@ static int rxe_post_one_recv(struct rxe_wq *rq, struct ibv_recv_wr *recv_wr)
 		goto out;
 	}
 
-	if (recv_wr->num_sge > rq->max_sge) {
+	if (num_sge > rq->max_sge) {
 		rc = EINVAL;
 		goto out;
 	}
@@ -695,18 +696,17 @@ static int rxe_post_one_recv(struct rxe_wq *rq, struct ibv_recv_wr *recv_wr)
 	wqe = (struct rxe_recv_wqe *)producer_addr(q);
 
 	wqe->wr_id = recv_wr->wr_id;
-	wqe->num_sge = recv_wr->num_sge;
 
 	memcpy(wqe->dma.sge, recv_wr->sg_list,
-	       wqe->num_sge*sizeof(*wqe->dma.sge));
+	       num_sge*sizeof(*wqe->dma.sge));
 
-	for (i = 0; i < wqe->num_sge; i++)
+	for (i = 0; i < num_sge; i++)
 		length += wqe->dma.sge[i].length;
 
 	wqe->dma.length = length;
 	wqe->dma.resid = length;
 	wqe->dma.cur_sge = 0;
-	wqe->dma.num_sge = wqe->num_sge;
+	wqe->dma.num_sge = num_sge;
 	wqe->dma.sge_offset = 0;
 
 	advance_producer(q);
@@ -1406,7 +1406,6 @@ static void convert_send_wr(struct rxe_qp *qp, struct rxe_send_wr *kwr,
 	memset(kwr, 0, sizeof(*kwr));
 
 	kwr->wr_id		= uwr->wr_id;
-	kwr->num_sge		= uwr->num_sge;
 	kwr->opcode		= uwr->opcode;
 	kwr->send_flags		= uwr->send_flags;
 	kwr->ex.imm_data	= uwr->imm_data;
-- 
2.34.1

