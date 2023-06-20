Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32CB736E36
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjFTOCO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjFTOCL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 10:02:11 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E38E60
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 07:02:10 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39e8a7701f0so3019091b6e.3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687269729; x=1689861729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ6xu//YvILFSp2a61oN6DYECvJ4nMD040QqC2Jl6fU=;
        b=fsuM2aEX9GkrD51iVQ7+hSEenDGOpg5IHd+gN9/s4Ab3L7gKurM/IgiLi97sgUEL5o
         dhz+PG15wIYcC0U1iRFoViSOPquY1o+zCSjqd7DtDisHQz6JIdu2gCwGTkRiPomnIp7v
         PPdfkQvN+5GPVdvmu8TCYNMFgA++4veKcxM7cwvXYa0Vt6HZAjfQ552wWKWppyursdPY
         sjO/ihGJH9Ren2merosgsCXBs1MFdqkLQaRDh2tgcY4SWBe0RSkANvWDJeQFB/YXaEl6
         E6RP+61mS6JYSbwJkw/VSKLNYL3EySoe7d1IZszpOZkU9wGpN/HBqka2aOFjJGXUxp+c
         6/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687269729; x=1689861729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ6xu//YvILFSp2a61oN6DYECvJ4nMD040QqC2Jl6fU=;
        b=Khhaf5y3DcmjNxrhey7ucrAYKlepnFV8eEeDms/PFSpJzb6rZwQLh+TJAYKeCucEeG
         4XqB6/cBcCaZq26AryC4NRKYaJzO+5CR7cd5CAyyDjQU3xDUJbEtvca1n13npaQWjF1w
         pvOpWX2lv/tcMPB7q58FmchGpz8QEfi1mTs54Q19Wmu/uAJxPvqGWSwXjC3/e9VSOvD5
         dI22EjYhZKbUbuLABiBPPc4mQa/oicvDxK3Ogf/MDEfvnG6fYx2lFUNI1xgkVZJ2/Xto
         mugJVk/FdSfk8EcKoCdMlh5B20VHwYv/BJ3vLVX4QMsx0Ul6GgVS4gNOh1NmX+Z99wFn
         IXRQ==
X-Gm-Message-State: AC+VfDwpIRpfOuUnz/1KetNG7HaN1yQCWHIvCW6Xc1xvzR+5GYsh9NPm
        FwHHHGvpjAMEDZgA8QOJ2FhpaqpSVac=
X-Google-Smtp-Source: ACHHUZ5uOIPT5cDhWV6D3tMAGbH2ylKhk9PINlbVIB2JirhVazza7XdYZfXB2Fg3AyWvZvs7D+wWrg==
X-Received: by 2002:a05:6808:120c:b0:39e:bcdc:4bd7 with SMTP id a12-20020a056808120c00b0039ebcdc4bd7mr7782811oil.24.1687269729364;
        Tue, 20 Jun 2023 07:02:09 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ba53-355d-2a89-4598.res6.spectrum.com. [2603:8081:140c:1a00:ba53:355d:2a89:4598])
        by smtp.gmail.com with ESMTPSA id a8-20020a056808128800b0039ed142bf3asm1062550oiw.53.2023.06.20.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:02:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, lkp@intel.com
Subject: [PATCH for-next v2 3/3] RDMA/rxe: Fix rxe_modify_srq
Date:   Tue, 20 Jun 2023 09:01:43 -0500
Message-Id: <20230620140142.9452-1-rpearsonhpe@gmail.com>
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

This patch corrects an error in rxe_modify_srq where if the
caller changes the srq size the actual new value is not returned
to the caller since it may be larger than what is requested.
Additionally it open codes the subroutine rcv_wqe_size() which
adds very little value, and makes some whitespace changes.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2: Reverted an incorrect change in v1 which partially removed the
    variable q in rxe_srq_from_init(). Fixed a typo in the subject line.
Reported-by: lkp@intel.com
Link: https://lore.kernel.org/linux-rdma/202306201807.sCYZpuDH-lkp@intel.com/raw

 drivers/infiniband/sw/rxe/rxe_loc.h |  6 ---
 drivers/infiniband/sw/rxe/rxe_srq.c | 60 +++++++++++++++++------------
 2 files changed, 36 insertions(+), 30 deletions(-)

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
index 27ca82ec0826..3661cb627d28 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -45,40 +45,41 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_init_attr *init, struct ib_udata *udata,
 		      struct rxe_create_srq_resp __user *uresp)
 {
-	int err;
-	int srq_wqe_size;
 	struct rxe_queue *q;
-	enum queue_type type;
+	int wqe_size;
+	int err;
 
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
+	q = rxe_queue_init(rxe, &srq->rq.max_wr, wqe_size,
+			   QUEUE_TYPE_FROM_CLIENT);
 	if (!q) {
 		rxe_dbg_srq(srq, "Unable to allocate queue\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out;
 	}
 
-	srq->rq.queue = q;
-
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
-		vfree(q->buf);
-		kfree(q);
-		return err;
+		rxe_dbg_srq(srq, "Unable to init mmap info for caller\n");
+		goto err_free;
 	}
 
+	srq->rq.queue = q;
+	init->attr.max_wr = srq->rq.max_wr;
+
 	if (uresp) {
 		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
 				 sizeof(uresp->srq_num))) {
@@ -88,6 +89,12 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
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
@@ -145,9 +152,10 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata)
 {
-	int err;
 	struct rxe_queue *q = srq->rq.queue;
 	struct mminfo __user *mi = NULL;
+	int wqe_size;
+	int err;
 
 	if (mask & IB_SRQ_MAX_WR) {
 		/*
@@ -156,12 +164,16 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
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
@@ -169,7 +181,7 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 	return 0;
 
-err2:
+err_free:
 	rxe_queue_cleanup(q);
 	srq->rq.queue = NULL;
 	return err;
-- 
2.39.2

