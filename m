Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E5735E6E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFSUWp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSUWp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 16:22:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4953EA
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:22:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b46e54039eso985006a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206163; x=1689798163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN5WQtny+pe3n+EsBMsG+IqxPDZ3KXqWmazYGXqulT4=;
        b=nQ5eVQz3xygcZ3XVhE/eazVQ+ODuy+MEMBImoiTxf3GXQ1MxPXIAjbXkTp9WYsPrRa
         6xhpw1JRjPKyeRl9+ESXz0O4vUe8BMeUdjhjOoUhVatDuABheVg541c0OSfPjdhXXeOO
         nMz+XdHH6s/5L3m5/5BTQt6lIhNgTq7MYh0G7rOJQobNSZ4fNU6I30Ir9IzAIVq5p31l
         1coIY1ycNv3KGmxOPc0IrnwgaB3c9EtEjv/KC23g7L8AsqvQhRfpJsXBsdg4D4zoqBKj
         ArVPKeqpk+hPLME9nAiQpD00vXYqihHqFHwczDyYis5cetQqbOW/64vhQP2bP7RdNroe
         txuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206163; x=1689798163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN5WQtny+pe3n+EsBMsG+IqxPDZ3KXqWmazYGXqulT4=;
        b=IjX58SHvnKhBGQpRzDelDV62vHi9Uky0W6D33MHt5i188AbBYCEVE7t2csW3/kZurk
         /s98hoiihNREmDP69g4L8fv2Friwun2p28yXLE5DucvSHOIRXKLyDnhynnVNFWXJpMGw
         dxtCbRjeMay/07IkEWiSxKTFs5LsCr8CmuxrdWUUM9MXeQjnoIMCD0eqg4aT8rJcINiq
         ylzXLPOf9IBUYA+tCLM7dSFsbY6v9jGKuhsg4XeNqKnbwedI/8BTrFw1Ce+BPUtipDMa
         xRD5SeiXDA7RYJaXXBg1TZGIMWjeFdcddY1dbZyQsCN9l3eREXGlVCOfnxyVAz8qBLR1
         gBMw==
X-Gm-Message-State: AC+VfDy/I6WViHdl0Oq5jkEa43FTaJLREhwPWkm5RXykpjSh7R0uo58t
        00YsU4UO4/CC2SwVC9yYQrIA/YV/KeI=
X-Google-Smtp-Source: ACHHUZ5jU5E0gMOVn8j1m1RSK5MhOkAbpVKD6HxBLIh6q4QMh+3e6kLn77i/K5k+G1tGlJ1QXh6vgw==
X-Received: by 2002:a05:6870:7718:b0:17f:f665:bc07 with SMTP id dw24-20020a056870771800b0017ff665bc07mr4737535oab.52.1687206163033;
        Mon, 19 Jun 2023 13:22:43 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-773b-851f-3075-b82a.res6.spectrum.com. [2603:8081:140c:1a00:773b:851f:3075:b82a])
        by smtp.gmail.com with ESMTPSA id kw41-20020a056870ac2900b001a6a3f99691sm311368oab.27.2023.06.19.13.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:22:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/3] RDMA/rxe: Fix rxe_m-dify_srq
Date:   Mon, 19 Jun 2023 15:21:14 -0500
Message-Id: <20230619202110.45680-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619202110.45680-1-rpearsonhpe@gmail.com>
References: <20230619202110.45680-1-rpearsonhpe@gmail.com>
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

This patch corrects an error in rxe_modify_srq where if the
caller changes the srq size the actual new value is not returned
to the caller since it may be larger than what is requested.
Additionally it open codes the subroutine rcv_wqe_size() which
adds very little value. And makes some whitespace changes.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  6 ----
 drivers/infiniband/sw/rxe/rxe_srq.c | 55 ++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 666e06a82bc9..4d2a8ef52c85 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -136,12 +136,6 @@ static inline int qp_mtu(struct rxe_qp *qp)
 		return IB_MTU_4096;
 }
 
-static inline int rcv_wqe_size(int max_sge)
-{
-	return sizeof(struct rxe_recv_wqe) +
-		max_sge * sizeof(struct ib_sge);
-}
-
 void free_rd_atomic_resource(struct resp_res *res);
 
 static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 27ca82ec0826..9fd37936ee5b 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -46,27 +46,28 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct rxe_create_srq_resp __user *uresp)
 {
 	int err;
-	int srq_wqe_size;
+	int wqe_size;
 	struct rxe_queue *q;
-	enum queue_type type;
 
-	srq->ibsrq.event_handler	= init->event_handler;
-	srq->ibsrq.srq_context		= init->srq_context;
-	srq->limit		= init->attr.srq_limit;
-	srq->srq_num		= srq->elem.index;
-	srq->rq.max_wr		= init->attr.max_wr;
-	srq->rq.max_sge		= init->attr.max_sge;
+	srq->ibsrq.event_handler = init->event_handler;
+	srq->ibsrq.srq_context = init->srq_context;
+	srq->limit = init->attr.srq_limit;
+	srq->srq_num = srq->elem.index;
+	srq->rq.max_wr = init->attr.max_wr;
+	srq->rq.max_sge = init->attr.max_sge;
 
-	srq_wqe_size		= rcv_wqe_size(srq->rq.max_sge);
+	wqe_size = sizeof(struct rxe_recv_wqe) +
+			srq->rq.max_sge*sizeof(struct ib_sge);
 
 	spin_lock_init(&srq->rq.producer_lock);
 	spin_lock_init(&srq->rq.consumer_lock);
 
-	type = QUEUE_TYPE_FROM_CLIENT;
-	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size, type);
-	if (!q) {
+	srq->rq.queue = rxe_queue_init(rxe, &srq->rq.max_wr, wqe_size,
+				       QUEUE_TYPE_FROM_CLIENT);
+	if (!srq->rq.queue) {
 		rxe_dbg_srq(srq, "Unable to allocate queue\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out;
 	}
 
 	srq->rq.queue = q;
@@ -74,11 +75,12 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
-		vfree(q->buf);
-		kfree(q);
-		return err;
+		rxe_dbg_srq(srq, "Unable to init mmap info for caller\n");
+		goto err_free;
 	}
 
+	init->attr.max_wr = srq->rq.max_wr;
+
 	if (uresp) {
 		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
 				 sizeof(uresp->srq_num))) {
@@ -88,6 +90,12 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	}
 
 	return 0;
+
+err_free:
+	vfree(q->buf);
+	kfree(q);
+err_out:
+	return err;
 }
 
 int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
@@ -148,6 +156,7 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 	int err;
 	struct rxe_queue *q = srq->rq.queue;
 	struct mminfo __user *mi = NULL;
+	int wqe_size;
 
 	if (mask & IB_SRQ_MAX_WR) {
 		/*
@@ -156,12 +165,16 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		 */
 		mi = u64_to_user_ptr(ucmd->mmap_info_addr);
 
-		err = rxe_queue_resize(q, &attr->max_wr,
-				       rcv_wqe_size(srq->rq.max_sge), udata, mi,
-				       &srq->rq.producer_lock,
+		wqe_size = sizeof(struct rxe_recv_wqe) +
+				srq->rq.max_sge*sizeof(struct ib_sge);
+
+		err = rxe_queue_resize(q, &attr->max_wr, wqe_size,
+				       udata, mi, &srq->rq.producer_lock,
 				       &srq->rq.consumer_lock);
 		if (err)
-			goto err2;
+			goto err_free;
+
+		srq->rq.max_wr = attr->max_wr;
 	}
 
 	if (mask & IB_SRQ_LIMIT)
@@ -169,7 +182,7 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 	return 0;
 
-err2:
+err_free:
 	rxe_queue_cleanup(q);
 	srq->rq.queue = NULL;
 	return err;
-- 
2.39.2

