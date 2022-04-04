Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C64F1F21
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiDDW3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349052AbiDDW2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308AB51E4A
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:26 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j83so11482409oih.6
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMTJkZUkxzghcGkX7qTl0dUr6s4CrUAG6aLSaXEopZU=;
        b=VGMdLorGYsKuB0lVLcujD7zBzopZ5/fIAEOdF8+qCu+mWO0wzEIr5Oa13bl7RJKwIC
         +ySwJVT+cZUw24O7m3M0+H8+jB2INd2n+KDTzXNUo5T13PNTbIFy6cK41qzeqLNw1h0X
         UxJ68vsZbYXGeWFX8qbMcluGQWzZO+a8Ijv8KkssSAlUs7tkomRjji0A4yYK1ADRFvkL
         D2hsSSLgM0QGpUckJOdLoVX+walxV71a0Qt+AfNmj00gMVqVhEunQj8OhDTj6sEb4h0x
         3xojF4SFJAO27pQjtAvFJNRLGUouG4DuBrb+R8fCQmy3LwfDY5sUD1D6t+rLUamgrjsn
         8XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMTJkZUkxzghcGkX7qTl0dUr6s4CrUAG6aLSaXEopZU=;
        b=jgwdHESy/hk1IAAB7uBHq+4OlDTFv6aWeUg056NM2+YAGTB9IRd1gZYp5voTBDUBgG
         tZn3OHLuq4uZfPB4MfHJQTezkk/dBkzU/nFhCILy99/3kGtgXoJSAa2TKW4VerVoNSll
         3QGkhVLVxH6LDGEF0Da13jLP7v7ghf604OJ1M5ggTdxq3llFImQxWLCum1NBlFw5D5Ys
         hqRYuoazmel8R9gka82yUROK90sQiA3lO28H+nAYf7nsNv180cYN9R9tCjG/UZFfV+G3
         /HdzMFh3a3NUtnHqO4X/pARP06GQ/t0vDemZGMAzf/6gENiteGP2eN+YLRyQfTgjV0rb
         8n+w==
X-Gm-Message-State: AOAM531TAVWIgvdPGtFEWzau1hUbR8FTmdG9GkCIF8axuixPYwrGOrzT
        3l/y9lJjdl04YWYOSPS1+gc=
X-Google-Smtp-Source: ABdhPJzNN491bsoj5yIW+izZijBMV8VTcs2I6tltlOXByy5NVxbLRP5I8aVwh9iaFlHJNDRuNh827g==
X-Received: by 2002:a54:470f:0:b0:2ef:8a55:b94f with SMTP id k15-20020a54470f000000b002ef8a55b94fmr113428oik.243.1649109085395;
        Mon, 04 Apr 2022 14:51:25 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 01/10] RDMA/rxe: Remove IB_SRQ_INIT_MASK
Date:   Mon,  4 Apr 2022 16:50:51 -0500
Message-Id: <20220404215059.39819-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
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
index 67184b0281a0..c1d543e24281 100644
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

