Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7205E5094B4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383664AbiDUBn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383663AbiDUBn6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:43:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1629FDC
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:10 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso2316658otk.10
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3eHwjVF2WmuZXC2bINTmdjwmODvB9Qwj+pNzvuWajM=;
        b=fV06bXm9w3XjIKGYUGGKPKZ9e9oRA+yBSkBQ2ObeBFwK9vN6Gobss8/C9axI7UhIra
         nYF4UXb6Pdad8fMq38TupXu19HBlrDqMQDj4njOH3zBphT20PXIdf/yeN2N7DQshvV1O
         MoB6XtcReTOJZfbPST5nyYkEDaNmi8h+ioitc+wUmgSJWhmIoVpAO2IOPJj41Dh8Rlh1
         NLmTjjJPgCMT2aSBB1rTwuVfYqMiboZlhIgccuBl5vRCUkP/TW2rurkNzDGYwgNr//du
         tWlANcxEsrPXMKPckuVi/CsgRrWYdmMhVzl4nPgDTAi6zuZ/eefXZTbIMAysIaGnwDDs
         yK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3eHwjVF2WmuZXC2bINTmdjwmODvB9Qwj+pNzvuWajM=;
        b=dR7pT64Wfv1e/CJuqwaFBnesOXQI8LibfA/PxBp5Qf65Fp0yigd6LUr79zXklJ3Nfx
         WYUfteyJbs6i7LDdvP9FFLtZYWKNdaLMy6vUI37HqRhxXsqeE7Yi3qmAjkid5m2M09GC
         56V3rkaNCJwAwydz9oy2Pnc1/8N9DlK2ZSKgfl+jzgHieQMzR/1svwUFV0vBFc5DG4UE
         MCNsofc8TaPgsCZgS38jcv5oysq+81rp70qw/hfrTOaFFnJmqZ1E9RSP+KMFtyJHcakg
         sto+mwvejCm/L/C7nUP1KuvmOMLYXwj8mPgRjM9JqprO/AR4k0TpIdboEgnbvrnvEmzQ
         tJ7w==
X-Gm-Message-State: AOAM5319V7EqnM+yek2+oX7rTa8Q0MmeMsD7dVEySMsRR3WH0KtZWgTV
        HPibzbWJSm6emsM1oEB7bsI=
X-Google-Smtp-Source: ABdhPJwe8QRSLykIVWzcA7HvR0FOrA4Lx23cORKNCUHv9a7uzRt9SG+LD4+AAR7IGneihdulQYF2Ig==
X-Received: by 2002:a05:6830:34a6:b0:605:73ba:ab39 with SMTP id c38-20020a05683034a600b0060573baab39mr530079otu.181.1650505269602;
        Wed, 20 Apr 2022 18:41:09 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 01/10] RDMA/rxe: Remove IB_SRQ_INIT_MASK
Date:   Wed, 20 Apr 2022 20:40:34 -0500
Message-Id: <20220421014042.26985-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
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

Currently the #define IB_SRQ_INIT_MASK is used to distinguish
the rxe_create_srq verb from the rxe_modify_srq verb so that some code
can be shared between these two subroutines.

This commit splits rxe_srq_chk_attr into two subroutines: rxe_srq_chk_init
and rxe_srq_chk_attr which handle the create_srq and modify_srq verbs
separately.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   9 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   | 118 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |   4 +-
 3 files changed, 74 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 2ffbe3390668..ff6cae2c2949 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -159,15 +159,12 @@ void retransmit_timer(struct timer_list *t);
 void rnr_nak_timer(struct timer_list *t);
 
 /* rxe_srq.c */
-#define IB_SRQ_INIT_MASK (~IB_SRQ_LIMIT)
-
-int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
-		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask);
-
+int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init);
 int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_init_attr *init, struct ib_udata *udata,
 		      struct rxe_create_srq_resp __user *uresp);
-
+int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
+		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask);
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 0c0721f04357..e2dcfc5d97e3 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -6,64 +6,34 @@
 
 #include <linux/vmalloc.h>
 #include "rxe.h"
-#include "rxe_loc.h"
 #include "rxe_queue.h"
 
-int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
-		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
+int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 {
-	if (srq && srq->error) {
-		pr_warn("srq in error state\n");
+	struct ib_srq_attr *attr = &init->attr;
+
+	if (attr->max_wr > rxe->attr.max_srq_wr) {
+		pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
+			attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
-	if (mask & IB_SRQ_MAX_WR) {
-		if (attr->max_wr > rxe->attr.max_srq_wr) {
-			pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
-				attr->max_wr, rxe->attr.max_srq_wr);
-			goto err1;
-		}
-
-		if (attr->max_wr <= 0) {
-			pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
-			goto err1;
-		}
-
-		if (srq && srq->limit && (attr->max_wr < srq->limit)) {
-			pr_warn("max_wr (%d) < srq->limit (%d)\n",
-				attr->max_wr, srq->limit);
-			goto err1;
-		}
-
-		if (attr->max_wr < RXE_MIN_SRQ_WR)
-			attr->max_wr = RXE_MIN_SRQ_WR;
+	if (attr->max_wr <= 0) {
+		pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
+		goto err1;
 	}
 
-	if (mask & IB_SRQ_LIMIT) {
-		if (attr->srq_limit > rxe->attr.max_srq_wr) {
-			pr_warn("srq_limit(%d) > max_srq_wr(%d)\n",
-				attr->srq_limit, rxe->attr.max_srq_wr);
-			goto err1;
-		}
+	if (attr->max_wr < RXE_MIN_SRQ_WR)
+		attr->max_wr = RXE_MIN_SRQ_WR;
 
-		if (srq && (attr->srq_limit > srq->rq.queue->buf->index_mask)) {
-			pr_warn("srq_limit (%d) > cur limit(%d)\n",
-				attr->srq_limit,
-				 srq->rq.queue->buf->index_mask);
-			goto err1;
-		}
+	if (attr->max_sge > rxe->attr.max_srq_sge) {
+		pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
+			attr->max_sge, rxe->attr.max_srq_sge);
+		goto err1;
 	}
 
-	if (mask == IB_SRQ_INIT_MASK) {
-		if (attr->max_sge > rxe->attr.max_srq_sge) {
-			pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
-				attr->max_sge, rxe->attr.max_srq_sge);
-			goto err1;
-		}
-
-		if (attr->max_sge < RXE_MIN_SRQ_SGE)
-			attr->max_sge = RXE_MIN_SRQ_SGE;
-	}
+	if (attr->max_sge < RXE_MIN_SRQ_SGE)
+		attr->max_sge = RXE_MIN_SRQ_SGE;
 
 	return 0;
 
@@ -93,8 +63,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	spin_lock_init(&srq->rq.consumer_lock);
 
 	type = QUEUE_TYPE_FROM_CLIENT;
-	q = rxe_queue_init(rxe, &srq->rq.max_wr,
-			srq_wqe_size, type);
+	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size, type);
 	if (!q) {
 		pr_warn("unable to allocate queue for srq\n");
 		return -ENOMEM;
@@ -121,6 +90,57 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	return 0;
 }
 
+int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
+		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
+{
+	if (srq->error) {
+		pr_warn("srq in error state\n");
+		goto err1;
+	}
+
+	if (mask & IB_SRQ_MAX_WR) {
+		if (attr->max_wr > rxe->attr.max_srq_wr) {
+			pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
+				attr->max_wr, rxe->attr.max_srq_wr);
+			goto err1;
+		}
+
+		if (attr->max_wr <= 0) {
+			pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
+			goto err1;
+		}
+
+		if (srq->limit && (attr->max_wr < srq->limit)) {
+			pr_warn("max_wr (%d) < srq->limit (%d)\n",
+				attr->max_wr, srq->limit);
+			goto err1;
+		}
+
+		if (attr->max_wr < RXE_MIN_SRQ_WR)
+			attr->max_wr = RXE_MIN_SRQ_WR;
+	}
+
+	if (mask & IB_SRQ_LIMIT) {
+		if (attr->srq_limit > rxe->attr.max_srq_wr) {
+			pr_warn("srq_limit(%d) > max_srq_wr(%d)\n",
+				attr->srq_limit, rxe->attr.max_srq_wr);
+			goto err1;
+		}
+
+		if (attr->srq_limit > srq->rq.queue->buf->index_mask) {
+			pr_warn("srq_limit (%d) > cur limit(%d)\n",
+				attr->srq_limit,
+				srq->rq.queue->buf->index_mask);
+			goto err1;
+		}
+	}
+
+	return 0;
+
+err1:
+	return -EINVAL;
+}
+
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 58e4412b1d16..2ddfd99dd020 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -7,8 +7,8 @@
 #include <linux/dma-mapping.h>
 #include <net/addrconf.h>
 #include <rdma/uverbs_ioctl.h>
+
 #include "rxe.h"
-#include "rxe_loc.h"
 #include "rxe_queue.h"
 #include "rxe_hw_counters.h"
 
@@ -295,7 +295,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 		uresp = udata->outbuf;
 	}
 
-	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
+	err = rxe_srq_chk_init(rxe, init);
 	if (err)
 		goto err1;
 
-- 
2.32.0

