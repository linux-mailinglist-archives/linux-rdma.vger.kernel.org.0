Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A012A4DD29A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiCRB44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiCRB44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:56 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D1232D15
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id b188so7493266oia.13
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rExX1OJrPQYVE2X/63iWoaDZ4BIl+puEpR+q6gPwOx4=;
        b=c52FCH3FLsa+HooJvsurW1KFbxq0KhotlknyFUQjs2fjlEEy99epwqOFD/5JePf5Oz
         2GCucTjkht9EbaM0wdS2X9AB/zcF5lbwDQIGLVPfeDQy0lnCWc52xDo6P1Dnd75BOV/g
         UWA+VqmtSL6eMJ/b2Ul29XsVz/5te2A5YBpertfaT9vlKA839EHGFRLyYcxr7SYjFl8Q
         YiiKgJm2bcaBzE18176+fTUx0KLGgFNI28QhNesUBsVP2UOFFWdHbp97IggyP4CPQYRL
         hqqzzEXHUckugWx0aq4vQtE57CtmJPCA+u5knyZqO7MwzJpiZ2amRdmbLdEf1J4tos4Q
         KbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rExX1OJrPQYVE2X/63iWoaDZ4BIl+puEpR+q6gPwOx4=;
        b=1+D0cN6wRSqF4R6DHtCaT7FkAiXPzIK5Wt+R34Q1VkFug+fcQGPpuVlqiCOAzZYHTR
         CQoJpq6tv7P/Jkq9eXPkas4pnAoUKfdC2nmG/XEw4xbCYJsw0hG72kLpM/pGn20S8Zm+
         GWmNJ9/kki/voscgpmnmQ35hoUfChAULm8DtEuhF5YSDhm/x7E77nFRYfvubTeUmIGY+
         ash+TkCz0kxwcqw01uQ8Tmr96pBBZ9V8OysMMl9VObe+jlOkKyCfjSLgSXW8sY2/vaWU
         sOP+hYtDY5rzEVIAwiZAMnCgaphbiNBMtkkqdza7I2++bqKMqUx+18KTiBN4zB9RzKO7
         nt8g==
X-Gm-Message-State: AOAM530T9c4rjolRFnRrvx5q1JLygZEae8sYLfgi/WCUxSJ0+JqfvpCI
        e3L8e8it/e47KO20cTP8/SKjVfQfyZQ=
X-Google-Smtp-Source: ABdhPJx80n5I/SiSEHTGp1B2OzZTNWWlZ66oN4cpQaeR08TTxwiflj1gmMm+TceL5l4/8BgRLzQEnA==
X-Received: by 2002:aca:180c:0:b0:2ec:94a4:f0a2 with SMTP id h12-20020aca180c000000b002ec94a4f0a2mr7317506oih.211.1647568529717;
        Thu, 17 Mar 2022 18:55:29 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 01/11] RDMA/rxe: Replace #define by enum
Date:   Thu, 17 Mar 2022 20:55:04 -0500
Message-Id: <20220318015514.231621-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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

This commit replaces the #define with an enum which extends
enum ib_srq_attr_mask and makes related changes to prototypes
to clean up type warnings. The parameter is given a rxe specific
name.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  8 ++------
 drivers/infiniband/sw/rxe/rxe_srq.c   | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  7 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 ++++++
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 2ffbe3390668..9067d3b6f1ee 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -159,17 +159,13 @@ void retransmit_timer(struct timer_list *t);
 void rnr_nak_timer(struct timer_list *t);
 
 /* rxe_srq.c */
-#define IB_SRQ_INIT_MASK (~IB_SRQ_LIMIT)
-
 int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
-		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask);
-
+		     struct ib_srq_attr *attr, enum rxe_srq_attr_mask mask);
 int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_init_attr *init, struct ib_udata *udata,
 		      struct rxe_create_srq_resp __user *uresp);
-
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
-		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
+		      struct ib_srq_attr *attr, enum rxe_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
 
 void rxe_dealloc(struct ib_device *ib_dev);
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 0c0721f04357..862aa749c93a 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -10,14 +10,14 @@
 #include "rxe_queue.h"
 
 int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
-		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
+		     struct ib_srq_attr *attr, enum rxe_srq_attr_mask mask)
 {
 	if (srq && srq->error) {
 		pr_warn("srq in error state\n");
 		goto err1;
 	}
 
-	if (mask & IB_SRQ_MAX_WR) {
+	if (mask & RXE_SRQ_MAX_WR) {
 		if (attr->max_wr > rxe->attr.max_srq_wr) {
 			pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
 				attr->max_wr, rxe->attr.max_srq_wr);
@@ -39,7 +39,7 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 			attr->max_wr = RXE_MIN_SRQ_WR;
 	}
 
-	if (mask & IB_SRQ_LIMIT) {
+	if (mask & RXE_SRQ_LIMIT) {
 		if (attr->srq_limit > rxe->attr.max_srq_wr) {
 			pr_warn("srq_limit(%d) > max_srq_wr(%d)\n",
 				attr->srq_limit, rxe->attr.max_srq_wr);
@@ -54,7 +54,7 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		}
 	}
 
-	if (mask == IB_SRQ_INIT_MASK) {
+	if (mask == RXE_SRQ_INIT) {
 		if (attr->max_sge > rxe->attr.max_srq_sge) {
 			pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
 				attr->max_sge, rxe->attr.max_srq_sge);
@@ -122,7 +122,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 }
 
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
-		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
+		      struct ib_srq_attr *attr, enum rxe_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 67184b0281a0..5609956d2bc3 100644
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
+	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, RXE_SRQ_INIT);
 	if (err)
 		goto err1;
 
@@ -320,13 +320,14 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 }
 
 static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
-			  enum ib_srq_attr_mask mask,
+			  enum ib_srq_attr_mask ibmask,
 			  struct ib_udata *udata)
 {
 	int err;
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
 	struct rxe_modify_srq_cmd ucmd = {};
+	enum rxe_srq_attr_mask mask = (enum rxe_srq_attr_mask)ibmask;
 
 	if (udata) {
 		if (udata->inlen < sizeof(ucmd))
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e7eff1ca75e9..34aa013c7801 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -93,6 +93,12 @@ struct rxe_rq {
 	struct rxe_queue	*queue;
 };
 
+enum rxe_srq_attr_mask {
+	RXE_SRQ_MAX_WR		= IB_SRQ_MAX_WR,
+	RXE_SRQ_LIMIT		= IB_SRQ_LIMIT,
+	RXE_SRQ_INIT		= BIT(2),
+};
+
 struct rxe_srq {
 	struct ib_srq		ibsrq;
 	struct rxe_pool_elem	elem;
-- 
2.32.0

