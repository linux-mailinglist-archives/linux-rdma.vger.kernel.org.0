Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6016185DB
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiKCRLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE782AC3
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12c8312131fso2897372fac.4
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ROUOVTZBEJrJHlNFnElaU9wZ0yFZWb0G3OwfC77BEs=;
        b=hZ0EGycq+vYtfzClqqG2DP2sBaWtFH5q8VcGj7543Fd521xpI84/NQF9enT+cDnhVf
         N4ACINH1R2lo9kZXmPjHPDXdZJNN162KU3C1lPVThRW9qW6lnU6CCLrPjv948h67P4gn
         ehAtu+Njf2XGTbgTTTuTQzSd9ZtvgFPb+9urHQLt5zgmdkr8Pz4K9xQa/ZzqLRs8gSPz
         pKOePvrWEEmmTbvhRwiviUYuX+x+tfaw8p6s2E6kFp3OFQqAEz7i6AWqBjfpiphMPi34
         bT3Kt5lxMy2CGOzAMZSdUSfebgB69kSmHzP9CuVcIsfJv+IT5jhCIUwSI73oY4tsliu2
         fXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ROUOVTZBEJrJHlNFnElaU9wZ0yFZWb0G3OwfC77BEs=;
        b=aIgNCXv9k9UWJaeO550tEXDZ1nRxiT+/BbYWePgnsxKlugQ/UVSVDJMS/YWwu6C17k
         lvYbjeC7lTio4ZitDC3ZixQW0vxojKyJ3KsuiD1vloZ/GRMPu20bzrjbMbJduLejUS8R
         kYRxpjGq5B899fbPpaaZU7OgHTD3R8oQFwU57xCtVfGOSn9BslOS8xxnLQ2akOofbE5w
         7ds8g2DsI7YSBlKdHjdD9CT/gNy0YdTfPoWJvnYW2lhjSm09jDz8mrcw1iZIHX552zWA
         MUBRKpiSEUkDhh2Jql7Hp4IMjkCK24ZTj4wKNZM5P8unF8FJgLDUr6SQROtpyeyQc8lH
         w2rA==
X-Gm-Message-State: ACrzQf3xoiMZmjP6wHenE8Fext2DQ94mv5Lp3Vz+3NDz6FH+hM9LLQww
        rl01uwliQs+EWKBlE1P573Kpcdt06MI=
X-Google-Smtp-Source: AMsMyM4eWFsAVbK0Ok+pbtxI3368NJUJNi2srhvk/7F7kqJzTyuBfBsf/3J1MaAfPURaY5zt5z/tjQ==
X-Received: by 2002:a05:6870:6717:b0:13d:8222:329e with SMTP id gb23-20020a056870671700b0013d8222329emr3930256oab.128.1667495444422;
        Thu, 03 Nov 2022 10:10:44 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 10/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_srq.c
Date:   Thu,  3 Nov 2022 12:10:08 -0500
Message-Id: <20221103171013.20659-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_srq.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 02b39498c370..82e37a41ced4 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -13,13 +13,13 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 	struct ib_srq_attr *attr = &init->attr;
 
 	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
+		rxe_dbg(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
 			attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
 	if (attr->max_wr <= 0) {
-		pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
+		rxe_dbg(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
 		goto err1;
 	}
 
@@ -27,7 +27,7 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
 	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
+		rxe_dbg(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
 			attr->max_sge, rxe->attr.max_srq_sge);
 		goto err1;
 	}
@@ -65,7 +65,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	type = QUEUE_TYPE_FROM_CLIENT;
 	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size, type);
 	if (!q) {
-		pr_warn("unable to allocate queue for srq\n");
+		rxe_dbg_srq(srq, "Unable to allocate queue\n");
 		return -ENOMEM;
 	}
 
@@ -94,24 +94,24 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
 {
 	if (srq->error) {
-		pr_warn("srq in error state\n");
+		rxe_dbg_srq(srq, "in error state\n");
 		goto err1;
 	}
 
 	if (mask & IB_SRQ_MAX_WR) {
 		if (attr->max_wr > rxe->attr.max_srq_wr) {
-			pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
+			rxe_dbg_srq(srq, "max_wr(%d) > max_srq_wr(%d)\n",
 				attr->max_wr, rxe->attr.max_srq_wr);
 			goto err1;
 		}
 
 		if (attr->max_wr <= 0) {
-			pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
+			rxe_dbg_srq(srq, "max_wr(%d) <= 0\n", attr->max_wr);
 			goto err1;
 		}
 
 		if (srq->limit && (attr->max_wr < srq->limit)) {
-			pr_warn("max_wr (%d) < srq->limit (%d)\n",
+			rxe_dbg_srq(srq, "max_wr (%d) < srq->limit (%d)\n",
 				attr->max_wr, srq->limit);
 			goto err1;
 		}
@@ -122,13 +122,13 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 	if (mask & IB_SRQ_LIMIT) {
 		if (attr->srq_limit > rxe->attr.max_srq_wr) {
-			pr_warn("srq_limit(%d) > max_srq_wr(%d)\n",
+			rxe_dbg_srq(srq, "srq_limit(%d) > max_srq_wr(%d)\n",
 				attr->srq_limit, rxe->attr.max_srq_wr);
 			goto err1;
 		}
 
 		if (attr->srq_limit > srq->rq.queue->buf->index_mask) {
-			pr_warn("srq_limit (%d) > cur limit(%d)\n",
+			rxe_dbg_srq(srq, "srq_limit (%d) > cur limit(%d)\n",
 				attr->srq_limit,
 				srq->rq.queue->buf->index_mask);
 			goto err1;
-- 
2.34.1

