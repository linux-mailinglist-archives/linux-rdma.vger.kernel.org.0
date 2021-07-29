Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6480F3DAF83
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhG2Wuq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhG2Wuq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:46 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FAEC0613C1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:41 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso7539034ota.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvwAVoH8sViCH5nkaOy6Sp68qjmHUkRSHwxuNtRjX/A=;
        b=Bd6cqaZOltpdHj1MhuGSRF/VyYrG5fGjB9hnB6wPGVhEjuPjNdpe6v7P+WdCI13Nxa
         5rZyRfCPX+uMT9kFfbdOAFoxw2YLILU5K+Ua60W7p9sEjrwJLL9jx2cqfKc976PsCFhm
         wFduc2vW+YbOxO7+DpBIowc5mudNcFRjsSo72SpuzoV15ceF+A7aKPNkMWKnJZUcOm0K
         fl913+ToLaLKpzcEzMib6fTKQrPvy2SoB8IHSHD4S8gHylZgytsXQ9gY7k8dZQBjh+XF
         SWAfd9KluXXTwgz8V+OiNx51Sm8iKgVd5Khi5DfnK3izAqTzqPBuAxvKedB7p2yOz7aX
         VguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvwAVoH8sViCH5nkaOy6Sp68qjmHUkRSHwxuNtRjX/A=;
        b=EKiFeM5eoP7+7TVpMwwmoKtAxIn7tm8eDLJ3J2mNG7gsTnhyTDvdNKC01tWP0vF9CH
         YcCx1bup7MqjRu61q17clj5wQ94pmVDgBNR+QX3FLMr1pROPu+D2O6TU+0DorZWE/DT6
         N04fT8uswDP4FlDhe2m78NXPu0/8cuhtO0PtW73h6mISqB3eZJKl2nIWH/Jg+0wGufcq
         +Z082DndpsP6rvAC47yd6BCfZqe93zQxRit+IreZrMABWdcpeMELBxPehwOD7xh9sN9T
         1JXr639nbAsYg5mmIYgdJXtu9NOoeiFLHNyMy2/O4a2angBO5a8rqNuYV5gDg3hB3ZNV
         +rXg==
X-Gm-Message-State: AOAM533CsSszU3vBOIoJNxRmC4nPdZiBoRdL13+OKSxlID0xcoZK1E5E
        fO/NAu0C7ZnyhyBGY9BQc3c=
X-Google-Smtp-Source: ABdhPJzhWj84/2WQtFUC0hoFapseiyZi7NQMDdttSaSY89HeVpQVACr49SGVXUYs9Jx3O6cIZxkghg==
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr4930255otq.86.1627599040749;
        Thu, 29 Jul 2021 15:50:40 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id n21sm699582ooj.22.2021.07.29.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/13] RDMA/rxe: Extend SRQs to support extensions
Date:   Thu, 29 Jul 2021 17:49:12 -0500
Message-Id: <20210729224915.38986-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend create_srq to support basic and xrc SRQs. Drop srq->pd in favor
of the PD referenced by rdma-core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  5 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   | 71 ++++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 22 ++++++++-
 4 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b4d45c592bd7..eac56e0c64ba 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -161,15 +161,12 @@ void retransmit_timer(struct timer_list *t);
 void rnr_nak_timer(struct timer_list *t);
 
 /* rxe_srq.c */
-#define IB_SRQ_INIT_MASK (~IB_SRQ_LIMIT)
-
+int rxe_srq_chk_init_attr(struct rxe_dev *rxe, struct ib_srq_init_attr *init);
 int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask);
-
 int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_init_attr *init, struct ib_udata *udata,
 		      struct rxe_create_srq_resp __user *uresp);
-
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index a9e7817e2732..edbfda0cc242 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -9,6 +9,32 @@
 #include "rxe_loc.h"
 #include "rxe_queue.h"
 
+int rxe_srq_chk_init_attr(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
+{
+	switch (init->srq_type) {
+	case IB_SRQT_BASIC:
+	case IB_SRQT_XRC:
+		break;
+	case IB_SRQT_TM:
+		pr_warn("Tag matching SRQ not supported\n");
+		return -EOPNOTSUPP;
+	default:
+		pr_warn("Unexpected SRQ type (%d)\n", init->srq_type);
+		return -EINVAL;
+	}
+
+	if (init->attr.max_sge > rxe->attr.max_srq_sge) {
+		pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
+			init->attr.max_sge, rxe->attr.max_srq_sge);
+		return -EINVAL;
+	}
+
+	if (init->attr.max_sge < RXE_MIN_SRQ_SGE)
+		init->attr.max_sge = RXE_MIN_SRQ_SGE;
+
+	return rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_MAX_WR);
+}
+
 int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
 {
@@ -48,23 +74,12 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 		if (srq && (attr->srq_limit > srq->rq.queue->buf->index_mask)) {
 			pr_warn("srq_limit (%d) > cur limit(%d)\n",
-				attr->srq_limit,
-				 srq->rq.queue->buf->index_mask);
+					attr->srq_limit,
+					srq->rq.queue->buf->index_mask);
 			goto err1;
 		}
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
-
 	return 0;
 
 err1:
@@ -78,24 +93,22 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	int err;
 	int srq_wqe_size;
 	struct rxe_queue *q;
-	enum queue_type type;
 
-	srq->ibsrq.event_handler	= init->event_handler;
-	srq->ibsrq.srq_context		= init->srq_context;
-	srq->limit		= init->attr.srq_limit;
-	srq->srq_num		= srq->pelem.index;
-	srq->rq.max_wr		= init->attr.max_wr;
-	srq->rq.max_sge		= init->attr.max_sge;
-	srq->rq.is_user		= srq->is_user;
+	srq->limit = init->attr.srq_limit;
+	srq->rq.max_wr = init->attr.max_wr;
+	srq->rq.max_sge = init->attr.max_sge;
+	srq->rq.is_user = srq->is_user;
 
-	srq_wqe_size		= rcv_wqe_size(srq->rq.max_sge);
+	if (init->srq_type == IB_SRQT_XRC)
+		srq->ibsrq.ext.xrc.srq_num = srq->pelem.index;
+
+	srq_wqe_size = rcv_wqe_size(srq->rq.max_sge);
 
 	spin_lock_init(&srq->rq.producer_lock);
 	spin_lock_init(&srq->rq.consumer_lock);
 
-	type = QUEUE_TYPE_FROM_CLIENT;
-	q = rxe_queue_init(rxe, &srq->rq.max_wr,
-			srq_wqe_size, type);
+	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size,
+			   QUEUE_TYPE_FROM_CLIENT);
 	if (!q) {
 		pr_warn("unable to allocate queue for srq\n");
 		return -ENOMEM;
@@ -111,14 +124,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		return err;
 	}
 
-	if (uresp) {
-		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
-				 sizeof(uresp->srq_num))) {
-			rxe_queue_cleanup(q);
-			return -EFAULT;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b4b993f1ce92..fbd1e2d70682 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -307,9 +307,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
 
-	if (init->srq_type != IB_SRQT_BASIC)
-		return -EOPNOTSUPP;
-
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
@@ -319,7 +316,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 		srq->is_user = false;
 	}
 
-	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
+	err = rxe_srq_chk_init_attr(rxe, init);
 	if (err)
 		goto err_out;
 
@@ -327,6 +324,8 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err_out;
 
+	rxe_add_index(srq);
+
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
 		goto err_drop_srq_ref;
@@ -334,6 +333,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err_drop_srq_ref:
+	rxe_drop_index(srq);
 	rxe_drop_ref(srq);
 err_out:
 	return err;
@@ -391,7 +391,9 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
+	rxe_drop_index(srq);
 	rxe_drop_ref(srq);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5b75de74a992..52599f398ddd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -104,7 +104,6 @@ struct rxe_srq {
 	struct ib_srq		ibsrq;
 	struct rxe_pool_entry	pelem;
 	struct rxe_rq		rq;
-	u32			srq_num;
 	bool			is_user;
 
 	int			limit;
@@ -542,11 +541,32 @@ static inline enum ib_qp_type rxe_qp_type(struct rxe_qp *qp)
 	return qp->ibqp.qp_type;
 }
 
+/* SRQ extractors */
+static inline struct rxe_cq *rxe_srq_cq(struct rxe_srq *srq)
+{
+	return to_rcq(srq->ibsrq.ext.cq);
+}
+
+static inline int rxe_srq_num(struct rxe_srq *srq)
+{
+	return srq->ibsrq.ext.xrc.srq_num;
+}
+
 static inline struct rxe_pd *rxe_srq_pd(struct rxe_srq *srq)
 {
 	return to_rpd(srq->ibsrq.pd);
 }
 
+static inline enum ib_srq_type rxe_srq_type(struct rxe_srq *srq)
+{
+	return srq->ibsrq.srq_type;
+}
+
+static inline struct rxe_xrcd *rxe_srq_xrcd(struct rxe_srq *srq)
+{
+	return to_rxrcd(srq->ibsrq.ext.xrc.xrcd);
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-- 
2.30.2

