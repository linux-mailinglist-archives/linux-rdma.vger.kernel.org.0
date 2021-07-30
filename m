Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBE3DBC28
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbhG3PXR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbhG3PXR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 11:23:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C32C061765
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso9828207otb.10
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yit/3EHRkdMz+D/KMAb2VddpAXvNJf6/4weOPAT1KXg=;
        b=oro8vw/qhApY8zqsHFsdgADXVmyhTxmpuCwVmaGwGL6fnrbTiOv/8U3clspV80bcoW
         /AhSL0vuSiVC0BVG2S0V/WiHIz0nZ0rRC4bGwfsiaZgolHj5uA4IRGaHUug5gsTWnK4O
         YWyfVuO1N+QNPFbNeHmCBInlj5T2rtTQySBDffehAwYBuhJeUsd+tEEBz/bZXZmp3T9I
         PBzIeJnld68DZwln8J+tsS38AzBNwM+9XxKQZm4d7Pm8Aa5M1Syhh9lfsW3+SxMJPCSu
         BTfl/uE1L69GGwGpDhvXjOLmy9X4nsI52bH/9ggURnSTzGPxlW1nRNiDxur1DWcQfxoA
         baKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yit/3EHRkdMz+D/KMAb2VddpAXvNJf6/4weOPAT1KXg=;
        b=kSVs6SCkk3rhKSP+vLP7sHdfC1Pt6RjKtkT2G4ZZVM9Hf4y2RlCEd+WNVuoqctBC8k
         xYblflrFA7A0bGmMbK4U/2LZHqNuyFjNxW6NtDaH43M7El1CHcHVTBlaJKVZ3CeqlIfE
         YLBx5ohwi3AD5stYYEoJj6DjhezbuU6fUqzsaUC5E6+3Uy14vchpof5jku7drITAotAm
         CU/bMRpvi2fqXTVTmueS9Q+E4HNvQ5Kul/JvrA4+ET6Ckqda/MIDFfvHAxXCRA0Tycpe
         Y4JaxQUfle76FeRk/F3zBUGEnuvGnIi7wVaa815tZNI+BLR/kA+t/MYv/mRKVwcRr44G
         EADw==
X-Gm-Message-State: AOAM531gm6r8kJ21snoqgLR/4eaS7HLLk2qh5qu5yNHfqLLLViOfm7bz
        wS+1abEnR7iGLi07c+ri73U=
X-Google-Smtp-Source: ABdhPJwanZ/NkEmQZL/EKGmcC6qCPdw8i7N2rEXwSEnmEfTnq6WV7z/SaetAOBVV+uRNfnwR0bY2oQ==
X-Received: by 2002:a9d:4105:: with SMTP id o5mr2370154ote.20.1627658591058;
        Fri, 30 Jul 2021 08:23:11 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id i18sm339750oik.3.2021.07.30.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 3/5] Providers/rxe: Support extended create srq
Date:   Fri, 30 Jul 2021 10:21:56 -0500
Message-Id: <20210730152157.67592-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730152157.67592-1-rpearsonhpe@gmail.com>
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for the ibv_create_srq_ex verb.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 providers/rxe/rxe-abi.h |  2 ++
 providers/rxe/rxe.c     | 54 +++++++++++++++++++++++++++++++++++------
 providers/rxe/rxe.h     |  5 ++--
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index 020201a9..07e90d81 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -51,6 +51,8 @@ DECLARE_DRV_CMD(urxe_create_qp_ex, IB_USER_VERBS_EX_CMD_CREATE_QP,
 		empty, rxe_create_qp_resp);
 DECLARE_DRV_CMD(urxe_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 		empty, rxe_create_srq_resp);
+DECLARE_DRV_CMD(urxe_create_srq_ex, IB_USER_VERBS_CMD_CREATE_XSRQ,
+		empty, rxe_create_srq_resp);
 DECLARE_DRV_CMD(urxe_modify_srq, IB_USER_VERBS_CMD_MODIFY_SRQ,
 		rxe_modify_srq_cmd, empty);
 DECLARE_DRV_CMD(urxe_resize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3bb9f01c..9cdddb8c 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -636,7 +636,7 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	if (srq == NULL)
 		return NULL;
 
-	ret = ibv_cmd_create_srq(pd, &srq->ibv_srq, attr, &cmd, sizeof(cmd),
+	ret = ibv_cmd_create_srq(pd, &srq->vsrq.srq, attr, &cmd, sizeof(cmd),
 				 &resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(srq);
@@ -647,7 +647,7 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 			     PROT_READ | PROT_WRITE, MAP_SHARED,
 			     pd->context->cmd_fd, resp.mi.offset);
 	if ((void *)srq->rq.queue == MAP_FAILED) {
-		ibv_cmd_destroy_srq(&srq->ibv_srq);
+		ibv_cmd_destroy_srq(&srq->vsrq.srq);
 		free(srq);
 		return NULL;
 	}
@@ -656,7 +656,44 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	srq->rq.max_sge = attr->attr.max_sge;
 	pthread_spin_init(&srq->rq.lock, PTHREAD_PROCESS_PRIVATE);
 
-	return &srq->ibv_srq;
+	return &srq->vsrq.srq;
+}
+
+static struct ibv_srq *rxe_create_srq_ex(struct ibv_context *context,
+				struct ibv_srq_init_attr_ex *attr_ex)
+{
+	struct rxe_srq *srq;
+	struct ibv_create_xsrq cmd = {};
+	size_t cmd_size = sizeof(cmd);
+	struct urxe_create_srq_ex_resp resp = {};
+	size_t resp_size = sizeof(resp);
+	int ret;
+
+	srq = calloc(1, sizeof(*srq));
+	if (!srq)
+		return NULL;
+
+	ret = ibv_cmd_create_srq_ex(context, &srq->vsrq, attr_ex,
+			  &cmd, cmd_size, &resp.ibv_resp, resp_size);
+	if (ret) {
+		free(srq);
+		return NULL;
+	}
+
+	srq->rq.queue = mmap(NULL, resp.mi.size,
+			     PROT_READ | PROT_WRITE, MAP_SHARED,
+			     context->cmd_fd, resp.mi.offset);
+	if ((void *)srq->rq.queue == MAP_FAILED) {
+		ibv_cmd_destroy_srq(&srq->vsrq.srq);
+		free(srq);
+		return NULL;
+	}
+
+	srq->mmap_info = resp.mi;
+	srq->rq.max_sge = attr_ex->attr.max_sge;
+	pthread_spin_init(&srq->rq.lock, PTHREAD_PROCESS_PRIVATE);
+
+	return &srq->vsrq.srq;
 }
 
 static int rxe_modify_srq(struct ibv_srq *ibsrq,
@@ -708,13 +745,13 @@ static int rxe_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *attr)
 	return ibv_cmd_query_srq(srq, attr, &cmd, sizeof(cmd));
 }
 
-static int rxe_destroy_srq(struct ibv_srq *ibvsrq)
+static int rxe_destroy_srq(struct ibv_srq *ibsrq)
 {
 	int ret;
-	struct rxe_srq *srq = to_rsrq(ibvsrq);
+	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_queue_buf *q = srq->rq.queue;
 
-	ret = ibv_cmd_destroy_srq(ibvsrq);
+	ret = ibv_cmd_destroy_srq(ibsrq);
 	if (!ret) {
 		if (srq->mmap_info.size)
 			munmap(q, srq->mmap_info.size);
@@ -765,11 +802,11 @@ out:
 	return rc;
 }
 
-static int rxe_post_srq_recv(struct ibv_srq *ibvsrq,
+static int rxe_post_srq_recv(struct ibv_srq *ibsrq,
 			     struct ibv_recv_wr *recv_wr,
 			     struct ibv_recv_wr **bad_recv_wr)
 {
-	struct rxe_srq *srq = to_rsrq(ibvsrq);
+	struct rxe_srq *srq = to_rsrq(ibsrq);
 	int rc = 0;
 
 	pthread_spin_lock(&srq->rq.lock);
@@ -1794,6 +1831,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.resize_cq = rxe_resize_cq,
 	.destroy_cq = rxe_destroy_cq,
 	.create_srq = rxe_create_srq,
+	.create_srq_ex = rxe_create_srq_ex,
 	.modify_srq = rxe_modify_srq,
 	.query_srq = rxe_query_srq,
 	.destroy_srq = rxe_destroy_srq,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 6882d9c7..f3215f2e 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -91,10 +91,9 @@ struct rxe_qp {
 };
 
 struct rxe_srq {
-	struct ibv_srq		ibv_srq;
+	struct verbs_srq	vsrq;
 	struct mminfo		mmap_info;
 	struct rxe_wq		rq;
-	uint32_t		srq_num;
 };
 
 #define to_rxxx(xxx, type) container_of(ib##xxx, struct rxe_##type, ibv_##xxx)
@@ -121,7 +120,7 @@ static inline struct rxe_qp *to_rqp(struct ibv_qp *ibqp)
 
 static inline struct rxe_srq *to_rsrq(struct ibv_srq *ibsrq)
 {
-	return to_rxxx(srq, srq);
+	return container_of(ibsrq, struct rxe_srq, vsrq.srq);
 }
 
 static inline struct rxe_ah *to_rah(struct ibv_ah *ibah)
-- 
2.30.2

