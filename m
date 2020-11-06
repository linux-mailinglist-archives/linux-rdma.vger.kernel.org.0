Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0B2A9EAA
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgKFUmk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgKFUmj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 15:42:39 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89990C0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 12:42:39 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i18so2506522ots.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFFjqvClbFddAmYhuH4/S/h6KxAzjNX/0qk9jeIllk8=;
        b=CqqfqbIgz9L4V3rUN7gPPww430dfNdOPcy3uQ893RWKrfbhgxGedMWbalIKHfmKSQG
         0shoovVoygb7zjdX5v5wU377zEXUT2ma3rGV/X2Jei6ce6z6MyGiymFnJUnSTiXo0Jyk
         40IGPazYzbJu2uTxn1A3bgzlyuFUVD3tEU/2dgIuPb6cf08ANap8do3Wd86q+Wxsz4DM
         abHo3e9T7gAQhFw5iiv+7skgoJ3sZzcZR12PtP1HC2oQpTSulqG76gZCdMXv4RtfRpjP
         WfFuKgLIpH0Ngrdzxj5yVSHBx9BUnX2EC0y17sPAI/OZtNkq9+8BNasoSZzl6BSYNqOf
         KWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFFjqvClbFddAmYhuH4/S/h6KxAzjNX/0qk9jeIllk8=;
        b=EjC9Yr7gJ1RDHSy5nDrtE1cdvFx1pYe1qQAFNXQWItdHlAGFHvMGxDHV/01/H7GDnx
         Sxy1qUhP0ChGbEN82eQ+bZ48O/+UKgqlbbvW2GYVdkt3vMVnlxP++zUEqjv9o9X+MR9t
         kLqwsevDMeyZSra2+UUWm7GhAbvudHjqit0vc4rCdcyJrbLbIr2NjMEgqZkVqr99s8pw
         /LX6SmONnCXtix28vaO0WwkrEBmvoc4HKEnGnJTggTmhRZhthJfxSiFff5FXkW7UnD+H
         yhPklFxZrVFr3vef92n1QGn0UCB5AK7T+6VmPJveHWnW9S6u8rzR1Hlvu9q/qnQCeW+1
         7xrQ==
X-Gm-Message-State: AOAM531RJIpqJFWrFOrhAFcsiy532s3hxW3LDIK1YLuXrtclzN+EfbW9
        kG2lP6m5rI3ZV8qnzLi2rww=
X-Google-Smtp-Source: ABdhPJxFKXOfsAflpufH3cHB27QbnotmrMTpZLSJnClt6+Dc1hPqKeE0e7vMmSaMACfMpPKZHoHncQ==
X-Received: by 2002:a9d:6311:: with SMTP id q17mr2274937otk.284.1604695358956;
        Fri, 06 Nov 2020 12:42:38 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id z126sm534888oiz.41.2020.11.06.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:42:38 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH] Provider/rxe: Cleanup style warnings
Date:   Fri,  6 Nov 2020 14:41:29 -0600
Message-Id: <20201106204128.5384-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleanup style warnings produced by checkpatch --no-tree -f.
Not all warnings were appropriate for user space code and
those were ignored.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 providers/rxe/rxe.c | 69 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3af58bfb..ca881304 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -69,11 +69,11 @@ static int rxe_query_device(struct ibv_context *context,
 {
 	struct ibv_query_device cmd;
 	uint64_t raw_fw_ver;
-	unsigned major, minor, sub_minor;
+	unsigned int major, minor, sub_minor;
 	int ret;
 
 	ret = ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof cmd);
+				   &cmd, sizeof(cmd));
 	if (ret)
 		return ret;
 
@@ -81,7 +81,7 @@ static int rxe_query_device(struct ibv_context *context,
 	minor = (raw_fw_ver >> 16) & 0xffff;
 	sub_minor = raw_fw_ver & 0xffff;
 
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
+	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
 		 "%d.%d.%d", major, minor, sub_minor);
 
 	return 0;
@@ -92,7 +92,7 @@ static int rxe_query_port(struct ibv_context *context, uint8_t port,
 {
 	struct ibv_query_port cmd;
 
-	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof cmd);
+	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof(cmd));
 }
 
 static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
@@ -101,11 +101,12 @@ static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
 	struct ib_uverbs_alloc_pd_resp resp;
 	struct ibv_pd *pd;
 
-	pd = malloc(sizeof *pd);
+	pd = malloc(sizeof(*pd));
 	if (!pd)
 		return NULL;
 
-	if (ibv_cmd_alloc_pd(context, pd, &cmd, sizeof cmd, &resp, sizeof resp)) {
+	if (ibv_cmd_alloc_pd(context, pd, &cmd, sizeof(cmd),
+					&resp, sizeof(resp))) {
 		free(pd);
 		return NULL;
 	}
@@ -166,14 +167,13 @@ static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
 	struct urxe_create_cq_resp resp;
 	int ret;
 
-	cq = malloc(sizeof *cq);
-	if (!cq) {
+	cq = malloc(sizeof(*cq));
+	if (!cq)
 		return NULL;
-	}
 
 	ret = ibv_cmd_create_cq(context, cqe, channel, comp_vector,
 				&cq->ibv_cq, NULL, 0,
-				&resp.ibv_resp, sizeof resp);
+				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(cq);
 		return NULL;
@@ -202,8 +202,8 @@ static int rxe_resize_cq(struct ibv_cq *ibcq, int cqe)
 
 	pthread_spin_lock(&cq->lock);
 
-	ret = ibv_cmd_resize_cq(ibcq, cqe, &cmd, sizeof cmd,
-				&resp.ibv_resp, sizeof resp);
+	ret = ibv_cmd_resize_cq(ibcq, cqe, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		pthread_spin_unlock(&cq->lock);
 		return ret;
@@ -277,13 +277,12 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	struct urxe_create_srq_resp resp;
 	int ret;
 
-	srq = malloc(sizeof *srq);
-	if (srq == NULL) {
+	srq = malloc(sizeof(*srq));
+	if (srq == NULL)
 		return NULL;
-	}
 
-	ret = ibv_cmd_create_srq(pd, &srq->ibv_srq, attr, &cmd, sizeof cmd,
-				 &resp.ibv_resp, sizeof resp);
+	ret = ibv_cmd_create_srq(pd, &srq->ibv_srq, attr, &cmd, sizeof(cmd),
+				 &resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(srq);
 		return NULL;
@@ -319,9 +318,9 @@ static int rxe_modify_srq(struct ibv_srq *ibsrq,
 	if (attr_mask & IBV_SRQ_MAX_WR)
 		pthread_spin_lock(&srq->rq.lock);
 
-	cmd.mmap_info_addr = (__u64)(uintptr_t) & mi;
+	cmd.mmap_info_addr = (__u64)(uintptr_t) &mi;
 	rc = ibv_cmd_modify_srq(ibsrq, attr, attr_mask,
-				&cmd.ibv_cmd, sizeof cmd);
+				&cmd.ibv_cmd, sizeof(cmd));
 	if (rc)
 		goto out;
 
@@ -351,7 +350,7 @@ static int rxe_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *attr)
 {
 	struct ibv_query_srq cmd;
 
-	return ibv_cmd_query_srq(srq, attr, &cmd, sizeof cmd);
+	return ibv_cmd_query_srq(srq, attr, &cmd, sizeof(cmd));
 }
 
 static int rxe_destroy_srq(struct ibv_srq *ibvsrq)
@@ -396,9 +395,8 @@ static int rxe_post_one_recv(struct rxe_wq *rq, struct ibv_recv_wr *recv_wr)
 	memcpy(wqe->dma.sge, recv_wr->sg_list,
 	       wqe->num_sge*sizeof(*wqe->dma.sge));
 
-	for (i = 0; i < wqe->num_sge; i++) {
+	for (i = 0; i < wqe->num_sge; i++)
 		length += wqe->dma.sge[i].length;
-	}
 
 	wqe->dma.length = length;
 	wqe->dma.resid = length;
@@ -444,13 +442,12 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
 	struct rxe_qp *qp;
 	int ret;
 
-	qp = malloc(sizeof *qp);
-	if (!qp) {
+	qp = malloc(sizeof(*qp));
+	if (!qp)
 		return NULL;
-	}
 
-	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd, sizeof cmd,
-				&resp.ibv_resp, sizeof resp);
+	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(qp);
 		return NULL;
@@ -501,7 +498,7 @@ static int rxe_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 	struct ibv_query_qp cmd;
 
 	return ibv_cmd_query_qp(qp, attr, attr_mask, init_attr,
-				&cmd, sizeof cmd);
+				&cmd, sizeof(cmd));
 }
 
 static int rxe_modify_qp(struct ibv_qp *ibvqp,
@@ -510,7 +507,7 @@ static int rxe_modify_qp(struct ibv_qp *ibvqp,
 {
 	struct ibv_modify_qp cmd = {};
 
-	return ibv_cmd_modify_qp(ibvqp, attr, attr_mask, &cmd, sizeof cmd);
+	return ibv_cmd_modify_qp(ibvqp, attr, attr_mask, &cmd, sizeof(cmd));
 }
 
 static int rxe_destroy_qp(struct ibv_qp *ibv_qp)
@@ -561,7 +558,7 @@ static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
 	kwr->send_flags		= uwr->send_flags;
 	kwr->ex.imm_data	= uwr->imm_data;
 
-	switch(uwr->opcode) {
+	switch (uwr->opcode) {
 	case IBV_WR_RDMA_WRITE:
 	case IBV_WR_RDMA_WRITE_WITH_IMM:
 	case IBV_WR_RDMA_READ:
@@ -688,7 +685,8 @@ static int post_send_db(struct ibv_qp *ibqp)
 }
 
 /* this API does not make a distinction between
-   restartable and non-restartable errors */
+ * restartable and non-restartable errors
+ */
 static int rxe_post_send(struct ibv_qp *ibqp,
 			 struct ibv_send_wr *wr_list,
 			 struct ibv_send_wr **bad_wr)
@@ -704,7 +702,7 @@ static int rxe_post_send(struct ibv_qp *ibqp,
 	*bad_wr = NULL;
 
 	if (!sq || !wr_list || !sq->queue)
-	 	return EINVAL;
+		return EINVAL;
 
 	pthread_spin_lock(&sq->lock);
 
@@ -792,7 +790,7 @@ static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
 		return NULL;
 	}
 
-	ah = malloc(sizeof *ah);
+	ah = malloc(sizeof(*ah));
 	if (ah == NULL)
 		return NULL;
 
@@ -875,8 +873,8 @@ static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
 	if (!context)
 		return NULL;
 
-	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd,
-				sizeof cmd, &resp, sizeof resp))
+	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd, sizeof(cmd),
+				&resp, sizeof(resp)))
 		goto out;
 
 	verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops);
@@ -907,6 +905,7 @@ static void rxe_uninit_device(struct verbs_device *verbs_device)
 static struct verbs_device *rxe_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 {
 	struct rxe_device *dev;
+
 	dev = calloc(1, sizeof(*dev));
 	if (!dev)
 		return NULL;
-- 
2.27.0

