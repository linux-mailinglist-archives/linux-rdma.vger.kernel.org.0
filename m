Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822005BB5E0
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIQDQd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIQDQ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:16:29 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D37BD151
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:16:25 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127d10b4f19so54640833fac.9
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ENDeJH9jgDJQV6yemy/xBQ78YE5OOfC7ZKZ+EZtKk3g=;
        b=NDKhWciQIOW1wk2LKiV8rfi3B3fyFBfAc4rfUErb/H951aLlJPcOeN9HJ1m8ChFla2
         C4AbIZN1XrLYgPqWciMDtEQ7U1XTO6EsNUjuV78qvWk1/QuwenP/CWUeyXEuIJ5gYHCh
         YeGkhX6KivNf+Dk1IjVJ1WE86CY/UUlQ/yzZpOqc5Ot5EqFRX0BeZKRjMasqd7cu2Vtp
         LznV7vN8z9wuTHoqthugvow7R7gdLvvyKFByd7lFc3hrjbygKgcUfLaF3JQ126wKAx2R
         YMZBrL5oKWJpZ2rOyEl58dF74J4FMpDTUlCvX8TwUK22rF6gtkv3mCreor2xb/yykSRd
         slBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ENDeJH9jgDJQV6yemy/xBQ78YE5OOfC7ZKZ+EZtKk3g=;
        b=yk6hrbGfQef9vhXaFVP3M9PJPL98JLKp8wBWzLN6QZAS4i48GJPEwM5mptGcuJxYLu
         Y+EwXIvmFd+tuag4ZnOYf+3Gz7K3qxkbUkd3KW8VUv/oeUsyqpiZou2FJTWxp6kmdS6A
         0JP9DUCfmZ6kB4KtJYgB6Oo4kQDax2CeGudZPRMDKxWqwLf9d4C6/bErofMKK3MRQFqC
         FtbQQ/aJkwNHZAovaTouTVqJ515GLQ0R7wVanHskWuU6WNdoC86F5tm0nFKNavdpP6Fa
         wso78sKI50Wlev4SYHNsUQ1okHlMimva0GE1PmfAQCLY3yGdwDAVcWEEzEZrWnzOmFg/
         wwdQ==
X-Gm-Message-State: ACgBeo3zK3kSyIebApPGOPCoWgNlRWUXBPYQ/dLpQlvJ/8kLyrb1DeWu
        1P900aR0gPe1S5ukmHMwwOf1vP2d9Dw=
X-Google-Smtp-Source: AA6agR5ps+VrhynklECvE7VYz9rlOOAh+65/SaIxCMQKMndICno7EIRmHaIJtbc+Pv//JoyoC4kkKw==
X-Received: by 2002:a05:6870:b019:b0:11f:2f8d:ee12 with SMTP id y25-20020a056870b01900b0011f2f8dee12mr9963728oae.252.1663384584970;
        Fri, 16 Sep 2022 20:16:24 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056870428400b0010d5d5c3fc3sm4240314oah.8.2022.09.16.20.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:16:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/2] providers/rxe: Implement the xrc transport protocol
Date:   Fri, 16 Sep 2022 22:15:37 -0500
Message-Id: <20220917031536.21354-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031536.21354-1-rpearsonhpe@gmail.com>
References: <20220917031536.21354-1-rpearsonhpe@gmail.com>
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

Make changes to implement the xrc transport protocol.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 providers/rxe/rxe-abi.h |   2 +
 providers/rxe/rxe.c     | 387 ++++++++++++++++++++++++++++------------
 providers/rxe/rxe.h     |  21 ++-
 3 files changed, 290 insertions(+), 120 deletions(-)

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
index 0e8f5605..4acd7140 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -574,10 +574,52 @@ static int rxe_poll_cq(struct ibv_cq *ibcq, int ne, struct ibv_wc *wc)
 	return npolled;
 }
 
-static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
+static struct ibv_xrcd *rxe_open_xrcd(struct ibv_context *ibcontext,
+				      struct ibv_xrcd_init_attr *attr)
+{
+	struct ibv_open_xrcd cmd;
+	struct ib_uverbs_open_xrcd_resp resp;
+	struct rxe_xrcd *xrcd;
+	struct verbs_xrcd *vxrcd;
+	int err;
+
+	xrcd = calloc(1, sizeof *xrcd);
+	if (!xrcd)
+		return NULL;
+
+	vxrcd = &xrcd->vxrcd;
+
+	err = ibv_cmd_open_xrcd(ibcontext, vxrcd, sizeof(*vxrcd), attr,
+				&cmd, sizeof cmd, &resp, sizeof resp);
+	if (err)
+		goto err_out;
+
+	return &vxrcd->xrcd;
+
+err_out:
+	errno = err;
+	free(xrcd);
+	return NULL;
+}
+
+static int rxe_close_xrcd(struct ibv_xrcd *ibxrcd)
+{
+	struct rxe_xrcd *xrcd = to_rxrcd(ibxrcd);
+	int err;
+
+	err = ibv_cmd_close_xrcd(&xrcd->vxrcd);
+	if (err)
+		return err;
+
+	free(xrcd);
+	return 0;
+}
+
+static struct ibv_srq *rxe_create_srq(struct ibv_pd *ibpd,
 				      struct ibv_srq_init_attr *attr)
 {
 	struct rxe_srq *srq;
+	struct ibv_srq *ibsrq;
 	struct ibv_create_srq cmd;
 	struct urxe_create_srq_resp resp;
 	int ret;
@@ -586,7 +628,9 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	if (srq == NULL)
 		return NULL;
 
-	ret = ibv_cmd_create_srq(pd, &srq->ibv_srq, attr, &cmd, sizeof(cmd),
+	ibsrq = &srq->vsrq.srq;
+
+	ret = ibv_cmd_create_srq(ibpd, ibsrq, attr, &cmd, sizeof(cmd),
 				 &resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(srq);
@@ -595,9 +639,9 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 
 	srq->rq.queue = mmap(NULL, resp.mi.size,
 			     PROT_READ | PROT_WRITE, MAP_SHARED,
-			     pd->context->cmd_fd, resp.mi.offset);
+			     ibpd->context->cmd_fd, resp.mi.offset);
 	if ((void *)srq->rq.queue == MAP_FAILED) {
-		ibv_cmd_destroy_srq(&srq->ibv_srq);
+		ibv_cmd_destroy_srq(ibsrq);
 		free(srq);
 		return NULL;
 	}
@@ -606,16 +650,55 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	srq->rq.max_sge = attr->attr.max_sge;
 	pthread_spin_init(&srq->rq.lock, PTHREAD_PROCESS_PRIVATE);
 
-	return &srq->ibv_srq;
+	return ibsrq;
+}
+
+static struct ibv_srq *rxe_create_srq_ex(
+		struct ibv_context *ibcontext,
+		struct ibv_srq_init_attr_ex *attr_ex)
+{
+	struct rxe_srq *srq;
+	struct ibv_srq *ibsrq;
+	struct ibv_create_xsrq cmd;
+	struct urxe_create_srq_ex_resp resp;
+	int ret;
+
+	srq = calloc(1, sizeof(*srq));
+	if (srq == NULL)
+		return NULL;
+
+	ibsrq = &srq->vsrq.srq;
+
+	ret = ibv_cmd_create_srq_ex(ibcontext, &srq->vsrq, attr_ex,
+			  &cmd, sizeof(cmd), &resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		free(srq);
+		return NULL;
+	}
+
+	srq->rq.queue = mmap(NULL, resp.mi.size,
+			     PROT_READ | PROT_WRITE, MAP_SHARED,
+			     ibcontext->cmd_fd, resp.mi.offset);
+	if ((void *)srq->rq.queue == MAP_FAILED) {
+		ibv_cmd_destroy_srq(ibsrq);
+		free(srq);
+		return NULL;
+	}
+
+	srq->mmap_info = resp.mi;
+	srq->rq.max_sge = attr_ex->attr.max_sge;
+	pthread_spin_init(&srq->rq.lock, PTHREAD_PROCESS_PRIVATE);
+
+	return ibsrq;
 }
 
-static int rxe_modify_srq(struct ibv_srq *ibsrq,
-		   struct ibv_srq_attr *attr, int attr_mask)
+static int rxe_modify_srq(struct ibv_srq *ibsrq, struct ibv_srq_attr *attr,
+			  int attr_mask)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct urxe_modify_srq cmd;
-	int rc = 0;
 	struct mminfo mi;
+	int err;
 
 	mi.offset = 0;
 	mi.size = 0;
@@ -624,9 +707,9 @@ static int rxe_modify_srq(struct ibv_srq *ibsrq,
 		pthread_spin_lock(&srq->rq.lock);
 
 	cmd.mmap_info_addr = (__u64)(uintptr_t) &mi;
-	rc = ibv_cmd_modify_srq(ibsrq, attr, attr_mask,
-				&cmd.ibv_cmd, sizeof(cmd));
-	if (rc)
+	err = ibv_cmd_modify_srq(ibsrq, attr, attr_mask,
+				 &cmd.ibv_cmd, sizeof(cmd));
+	if (err)
 		goto out;
 
 	if (attr_mask & IBV_SRQ_MAX_WR) {
@@ -636,7 +719,7 @@ static int rxe_modify_srq(struct ibv_srq *ibsrq,
 				     ibsrq->context->cmd_fd, mi.offset);
 
 		if ((void *)srq->rq.queue == MAP_FAILED) {
-			rc = errno;
+			err = errno;
 			srq->rq.queue = NULL;
 			srq->mmap_info.size = 0;
 			goto out;
@@ -648,30 +731,43 @@ static int rxe_modify_srq(struct ibv_srq *ibsrq,
 out:
 	if (attr_mask & IBV_SRQ_MAX_WR)
 		pthread_spin_unlock(&srq->rq.lock);
-	return rc;
+
+	return err;
+}
+
+static int rxe_get_srq_num(struct ibv_srq *ibsrq, uint32_t *srq_num)
+{
+	struct rxe_srq *srq = to_rsrq(ibsrq);
+
+	if (!srq->vsrq.xrcd)
+		return EOPNOTSUPP;
+
+	*srq_num = srq->vsrq.srq_num;
+
+	return 0;
 }
 
-static int rxe_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *attr)
+static int rxe_query_srq(struct ibv_srq *ibsrq, struct ibv_srq_attr *attr)
 {
 	struct ibv_query_srq cmd;
 
-	return ibv_cmd_query_srq(srq, attr, &cmd, sizeof(cmd));
+	return ibv_cmd_query_srq(ibsrq, attr, &cmd, sizeof(cmd));
 }
 
 static int rxe_destroy_srq(struct ibv_srq *ibvsrq)
 {
-	int ret;
+	int err;
 	struct rxe_srq *srq = to_rsrq(ibvsrq);
 	struct rxe_queue_buf *q = srq->rq.queue;
 
-	ret = ibv_cmd_destroy_srq(ibvsrq);
-	if (!ret) {
+	err = ibv_cmd_destroy_srq(ibvsrq);
+	if (!err) {
 		if (srq->mmap_info.size)
 			munmap(q, srq->mmap_info.size);
 		free(srq);
 	}
 
-	return ret;
+	return err;
 }
 
 static int rxe_post_one_recv(struct rxe_wq *rq, struct ibv_recv_wr *recv_wr)
@@ -715,11 +811,11 @@ out:
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
@@ -979,6 +1075,18 @@ static void wr_set_ud_addr(struct ibv_qp_ex *ibqp, struct ibv_ah *ibah,
 		memcpy(&wqe->wr.wr.ud.av, &ah->av, sizeof(ah->av));
 }
 
+static void wr_set_xrc_srqn(struct ibv_qp_ex *ibqp, uint32_t remote_srqn)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	wqe->wr.srq_num = remote_srqn;
+}
+
 static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
 			       size_t length)
 {
@@ -1118,36 +1226,54 @@ static int map_queue_pair(int cmd_fd, struct rxe_qp *qp,
 			  struct ibv_qp_init_attr *attr,
 			  struct rxe_create_qp_resp *resp)
 {
-	if (attr->srq) {
-		qp->rq.max_sge = 0;
-		qp->rq.queue = NULL;
-		qp->rq_mmap_info.size = 0;
-	} else {
-		qp->rq.max_sge = attr->cap.max_recv_sge;
-		qp->rq.queue = mmap(NULL, resp->rq_mi.size, PROT_READ | PROT_WRITE,
-				    MAP_SHARED,
-				    cmd_fd, resp->rq_mi.offset);
-		if ((void *)qp->rq.queue == MAP_FAILED)
+	switch (attr->qp_type) {
+	case IBV_QPT_RC:
+	case IBV_QPT_UC:
+	case IBV_QPT_UD:
+		if (attr->srq) {
+			qp->rq.max_sge = 0;
+			qp->rq.queue = NULL;
+			qp->rq_mmap_info.size = 0;
+		} else {
+			qp->rq.max_sge = attr->cap.max_recv_sge;
+			qp->rq.queue = mmap(NULL, resp->rq_mi.size,
+					    PROT_READ | PROT_WRITE,
+					    MAP_SHARED, cmd_fd,
+					    resp->rq_mi.offset);
+			if ((void *)qp->rq.queue == MAP_FAILED)
+				return errno;
+
+			qp->rq_mmap_info = resp->rq_mi;
+			pthread_spin_init(&qp->rq.lock,
+					  PTHREAD_PROCESS_PRIVATE);
+		}
+		/* fall through */
+	case IBV_QPT_XRC_SEND:
+		qp->sq.max_sge = attr->cap.max_send_sge;
+		qp->sq.max_inline = attr->cap.max_inline_data;
+		qp->sq.queue = mmap(NULL, resp->sq_mi.size,
+				    PROT_READ | PROT_WRITE,
+				    MAP_SHARED, cmd_fd,
+				    resp->sq_mi.offset);
+		if ((void *)qp->sq.queue == MAP_FAILED) {
+			if (qp->rq_mmap_info.size)
+				munmap(qp->rq.queue, qp->rq_mmap_info.size);
 			return errno;
+		}
 
-		qp->rq_mmap_info = resp->rq_mi;
-		pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE);
-	}
-
-	qp->sq.max_sge = attr->cap.max_send_sge;
-	qp->sq.max_inline = attr->cap.max_inline_data;
-	qp->sq.queue = mmap(NULL, resp->sq_mi.size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED,
-			    cmd_fd, resp->sq_mi.offset);
-	if ((void *)qp->sq.queue == MAP_FAILED) {
-		if (qp->rq_mmap_info.size)
-			munmap(qp->rq.queue, qp->rq_mmap_info.size);
-		return errno;
+		qp->sq_mmap_info = resp->sq_mi;
+		pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
+		break;
+	case IBV_QPT_XRC_RECV:
+		break;
+	case IBV_QPT_RAW_PACKET:
+	case IBV_QPT_DRIVER:
+		/* not reached */
+		return EOPNOTSUPP;
+	default:
+		return EINVAL;
 	}
 
-	qp->sq_mmap_info = resp->sq_mi;
-	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
-
 	return 0;
 }
 
@@ -1189,7 +1315,7 @@ err:
 enum {
 	RXE_QP_CREATE_FLAGS_SUP = 0,
 
-	RXE_QP_COMP_MASK_SUP = IBV_QP_INIT_ATTR_PD |
+	RXE_QP_COMP_MASK_SUP = IBV_QP_INIT_ATTR_PD | IBV_QP_INIT_ATTR_XRCD |
 		IBV_QP_INIT_ATTR_CREATE_FLAGS | IBV_QP_INIT_ATTR_SEND_OPS_FLAGS,
 
 	RXE_SUP_RC_QP_SEND_OPS_FLAGS =
@@ -1206,6 +1332,13 @@ enum {
 
 	RXE_SUP_UD_QP_SEND_OPS_FLAGS =
 		IBV_QP_EX_WITH_SEND | IBV_QP_EX_WITH_SEND_WITH_IMM,
+
+	RXE_SUP_XRC_QP_SEND_OPS_FLAGS =
+		IBV_QP_EX_WITH_RDMA_WRITE | IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM |
+		IBV_QP_EX_WITH_SEND | IBV_QP_EX_WITH_SEND_WITH_IMM |
+		IBV_QP_EX_WITH_RDMA_READ | IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP |
+		IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD | IBV_QP_EX_WITH_LOCAL_INV |
+		IBV_QP_EX_WITH_BIND_MW | IBV_QP_EX_WITH_SEND_WITH_INV,
 };
 
 static int check_qp_init_attr(struct ibv_qp_init_attr_ex *attr)
@@ -1220,17 +1353,28 @@ static int check_qp_init_attr(struct ibv_qp_init_attr_ex *attr)
 	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS) {
 		switch (attr->qp_type) {
 		case IBV_QPT_RC:
-			if (attr->send_ops_flags & ~RXE_SUP_RC_QP_SEND_OPS_FLAGS)
+			if (attr->send_ops_flags &
+					~RXE_SUP_RC_QP_SEND_OPS_FLAGS)
 				goto err;
 			break;
 		case IBV_QPT_UC:
-			if (attr->send_ops_flags & ~RXE_SUP_UC_QP_SEND_OPS_FLAGS)
+			if (attr->send_ops_flags &
+					~RXE_SUP_UC_QP_SEND_OPS_FLAGS)
 				goto err;
 			break;
 		case IBV_QPT_UD:
-			if (attr->send_ops_flags & ~RXE_SUP_UD_QP_SEND_OPS_FLAGS)
+			if (attr->send_ops_flags &
+					~RXE_SUP_UD_QP_SEND_OPS_FLAGS)
+				goto err;
+			break;
+		case IBV_QPT_XRC_SEND:
+			if (attr->send_ops_flags &
+					~RXE_SUP_XRC_QP_SEND_OPS_FLAGS)
 				goto err;
 			break;
+		case IBV_QPT_XRC_RECV:
+			goto err;
+			break;
 		default:
 			goto err;
 		}
@@ -1275,6 +1419,7 @@ static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
 		qp->vqp.qp_ex.wr_send_inv = wr_send_inv;
 
 	qp->vqp.qp_ex.wr_set_ud_addr = wr_set_ud_addr;
+	qp->vqp.qp_ex.wr_set_xrc_srqn = wr_set_xrc_srqn;
 	qp->vqp.qp_ex.wr_set_inline_data = wr_set_inline_data;
 	qp->vqp.qp_ex.wr_set_inline_data_list = wr_set_inline_data_list;
 	qp->vqp.qp_ex.wr_set_sge = wr_set_sge;
@@ -1286,38 +1431,38 @@ static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
 }
 
 static struct ibv_qp *rxe_create_qp_ex(struct ibv_context *context,
-				struct ibv_qp_init_attr_ex *attr)
+				       struct ibv_qp_init_attr_ex *attr)
 {
-	int ret;
+	int err;
 	struct rxe_qp *qp;
 	struct ibv_create_qp_ex cmd = {};
 	struct urxe_create_qp_ex_resp resp = {};
 	size_t cmd_size = sizeof(cmd);
 	size_t resp_size = sizeof(resp);
 
-	ret = check_qp_init_attr(attr);
-	if (ret)
-		goto err;
+	err = check_qp_init_attr(attr);
+	if (err)
+		goto err_out;
 
 	qp = calloc(1, sizeof(*qp));
 	if (!qp)
-		goto err;
+		goto err_out;
 
 	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS)
 		set_qp_send_ops(qp, attr->send_ops_flags);
 
-	ret = ibv_cmd_create_qp_ex2(context, &qp->vqp, attr,
+	err = ibv_cmd_create_qp_ex2(context, &qp->vqp, attr,
 				    &cmd, cmd_size,
 				    &resp.ibv_resp, resp_size);
-	if (ret)
+	if (err)
 		goto err_free;
 
 	qp->vqp.comp_mask |= VERBS_QP_EX;
 
-	ret = map_queue_pair(context->cmd_fd, qp,
-			     (struct ibv_qp_init_attr *)attr,
-			     &resp.drv_payload);
-	if (ret)
+	err = map_queue_pair(context->cmd_fd, qp,
+		     (struct ibv_qp_init_attr *)attr,
+		     &resp.drv_payload);
+	if (err)
 		goto err_destroy;
 
 	return &qp->vqp.qp;
@@ -1326,7 +1471,8 @@ err_destroy:
 	ibv_cmd_destroy_qp(&qp->vqp.qp);
 err_free:
 	free(qp);
-err:
+err_out:
+	errno = err;
 	return NULL;
 }
 
@@ -1397,56 +1543,57 @@ static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
 	return 0;
 }
 
-static void convert_send_wr(struct rxe_qp *qp, struct rxe_send_wr *kwr,
-					struct ibv_send_wr *uwr)
+static void convert_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
+					struct ibv_send_wr *ibwr)
 {
 	struct ibv_mw *ibmw;
 	struct ibv_mr *ibmr;
 
-	memset(kwr, 0, sizeof(*kwr));
+	memset(wr, 0, sizeof(*wr));
 
-	kwr->wr_id		= uwr->wr_id;
-	kwr->opcode		= uwr->opcode;
-	kwr->send_flags		= uwr->send_flags;
-	kwr->ex.imm_data	= uwr->imm_data;
+	wr->wr_id		= ibwr->wr_id;
+	wr->srq_num		= ibwr->qp_type.xrc.remote_srqn;
+	wr->opcode		= ibwr->opcode;
+	wr->send_flags		= ibwr->send_flags;
+	wr->ex.imm_data		= ibwr->imm_data;
 
-	switch (uwr->opcode) {
+	switch (ibwr->opcode) {
 	case IBV_WR_RDMA_WRITE:
 	case IBV_WR_RDMA_WRITE_WITH_IMM:
 	case IBV_WR_RDMA_READ:
-		kwr->wr.rdma.remote_addr	= uwr->wr.rdma.remote_addr;
-		kwr->wr.rdma.rkey		= uwr->wr.rdma.rkey;
+		wr->wr.rdma.remote_addr		= ibwr->wr.rdma.remote_addr;
+		wr->wr.rdma.rkey		= ibwr->wr.rdma.rkey;
 		break;
 
 	case IBV_WR_SEND:
 	case IBV_WR_SEND_WITH_IMM:
 		if (qp_type(qp) == IBV_QPT_UD) {
-			struct rxe_ah *ah = to_rah(uwr->wr.ud.ah);
+			struct rxe_ah *ah = to_rah(ibwr->wr.ud.ah);
 
-			kwr->wr.ud.remote_qpn	= uwr->wr.ud.remote_qpn;
-			kwr->wr.ud.remote_qkey	= uwr->wr.ud.remote_qkey;
-			kwr->wr.ud.ah_num	= ah->ah_num;
+			wr->wr.ud.remote_qpn	= ibwr->wr.ud.remote_qpn;
+			wr->wr.ud.remote_qkey	= ibwr->wr.ud.remote_qkey;
+			wr->wr.ud.ah_num	= ah->ah_num;
 		}
 		break;
 
 	case IBV_WR_ATOMIC_CMP_AND_SWP:
 	case IBV_WR_ATOMIC_FETCH_AND_ADD:
-		kwr->wr.atomic.remote_addr	= uwr->wr.atomic.remote_addr;
-		kwr->wr.atomic.compare_add	= uwr->wr.atomic.compare_add;
-		kwr->wr.atomic.swap		= uwr->wr.atomic.swap;
-		kwr->wr.atomic.rkey		= uwr->wr.atomic.rkey;
+		wr->wr.atomic.remote_addr	= ibwr->wr.atomic.remote_addr;
+		wr->wr.atomic.compare_add	= ibwr->wr.atomic.compare_add;
+		wr->wr.atomic.swap		= ibwr->wr.atomic.swap;
+		wr->wr.atomic.rkey		= ibwr->wr.atomic.rkey;
 		break;
 
 	case IBV_WR_BIND_MW:
-		ibmr = uwr->bind_mw.bind_info.mr;
-		ibmw = uwr->bind_mw.mw;
-
-		kwr->wr.mw.addr = uwr->bind_mw.bind_info.addr;
-		kwr->wr.mw.length = uwr->bind_mw.bind_info.length;
-		kwr->wr.mw.mr_lkey = ibmr->lkey;
-		kwr->wr.mw.mw_rkey = ibmw->rkey;
-		kwr->wr.mw.rkey = uwr->bind_mw.rkey;
-		kwr->wr.mw.access = uwr->bind_mw.bind_info.mw_access_flags;
+		ibmr = ibwr->bind_mw.bind_info.mr;
+		ibmw = ibwr->bind_mw.mw;
+
+		wr->wr.mw.addr = ibwr->bind_mw.bind_info.addr;
+		wr->wr.mw.length = ibwr->bind_mw.bind_info.length;
+		wr->wr.mw.mr_lkey = ibmr->lkey;
+		wr->wr.mw.mw_rkey = ibmw->rkey;
+		wr->wr.mw.rkey = ibwr->bind_mw.rkey;
+		wr->wr.mw.access = ibwr->bind_mw.bind_info.mw_access_flags;
 		break;
 
 	default:
@@ -1539,6 +1686,7 @@ static int post_send_db(struct ibv_qp *ibqp)
 {
 	struct ibv_post_send cmd;
 	struct ib_uverbs_post_send_resp resp;
+	ssize_t ret;
 
 	cmd.hdr.command	= IB_USER_VERBS_CMD_POST_SEND;
 	cmd.hdr.in_words = sizeof(cmd) / 4;
@@ -1549,7 +1697,8 @@ static int post_send_db(struct ibv_qp *ibqp)
 	cmd.sge_count	= 0;
 	cmd.wqe_size	= sizeof(struct ibv_send_wr);
 
-	if (write(ibqp->context->cmd_fd, &cmd, sizeof(cmd)) != sizeof(cmd))
+	ret = write(ibqp->context->cmd_fd, &cmd, sizeof(cmd));
+	if (ret != sizeof(cmd))
 		return errno;
 
 	return 0;
@@ -1729,38 +1878,42 @@ static int rxe_destroy_ah(struct ibv_ah *ibah)
 }
 
 static const struct verbs_context_ops rxe_ctx_ops = {
-	.query_device_ex = rxe_query_device,
-	.query_port = rxe_query_port,
-	.alloc_pd = rxe_alloc_pd,
-	.dealloc_pd = rxe_dealloc_pd,
-	.reg_mr = rxe_reg_mr,
-	.dereg_mr = rxe_dereg_mr,
 	.alloc_mw = rxe_alloc_mw,
-	.dealloc_mw = rxe_dealloc_mw,
+	.alloc_pd = rxe_alloc_pd,
+	.attach_mcast = ibv_cmd_attach_mcast,
 	.bind_mw = rxe_bind_mw,
-	.create_cq = rxe_create_cq,
+	.close_xrcd = rxe_close_xrcd,
+	.create_ah = rxe_create_ah,
 	.create_cq_ex = rxe_create_cq_ex,
-	.poll_cq = rxe_poll_cq,
-	.req_notify_cq = ibv_cmd_req_notify_cq,
-	.resize_cq = rxe_resize_cq,
-	.destroy_cq = rxe_destroy_cq,
-	.create_srq = rxe_create_srq,
-	.modify_srq = rxe_modify_srq,
-	.query_srq = rxe_query_srq,
-	.destroy_srq = rxe_destroy_srq,
-	.post_srq_recv = rxe_post_srq_recv,
-	.create_qp = rxe_create_qp,
+	.create_cq = rxe_create_cq,
 	.create_qp_ex = rxe_create_qp_ex,
-	.query_qp = rxe_query_qp,
-	.modify_qp = rxe_modify_qp,
-	.destroy_qp = rxe_destroy_qp,
-	.post_send = rxe_post_send,
-	.post_recv = rxe_post_recv,
-	.create_ah = rxe_create_ah,
+	.create_qp = rxe_create_qp,
+	.create_srq = rxe_create_srq,
+	.create_srq_ex = rxe_create_srq_ex,
+	.dealloc_mw = rxe_dealloc_mw,
+	.dealloc_pd = rxe_dealloc_pd,
+	.dereg_mr = rxe_dereg_mr,
 	.destroy_ah = rxe_destroy_ah,
-	.attach_mcast = ibv_cmd_attach_mcast,
+	.destroy_cq = rxe_destroy_cq,
+	.destroy_qp = rxe_destroy_qp,
+	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = ibv_cmd_detach_mcast,
 	.free_context = rxe_free_context,
+	.get_srq_num = rxe_get_srq_num,
+	.modify_qp = rxe_modify_qp,
+	.modify_srq = rxe_modify_srq,
+	.open_xrcd = rxe_open_xrcd,
+	.poll_cq = rxe_poll_cq,
+	.post_recv = rxe_post_recv,
+	.post_send = rxe_post_send,
+	.post_srq_recv = rxe_post_srq_recv,
+	.query_device_ex = rxe_query_device,
+	.query_port = rxe_query_port,
+	.query_qp = rxe_query_qp,
+	.query_srq = rxe_query_srq,
+	.reg_mr = rxe_reg_mr,
+	.req_notify_cq = ibv_cmd_req_notify_cq,
+	.resize_cq = rxe_resize_cq,
 };
 
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 6882d9c7..2023ecae 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -40,6 +40,8 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <rdma/rdma_user_rxe.h>
+#include <unistd.h>
+
 #include "rxe-abi.h"
 
 struct rxe_device {
@@ -90,13 +92,21 @@ struct rxe_qp {
 	int			err;
 };
 
+struct rxe_xrcd {
+	struct verbs_xrcd	vxrcd;
+};
+
 struct rxe_srq {
-	struct ibv_srq		ibv_srq;
+	struct verbs_srq	vsrq;
 	struct mminfo		mmap_info;
 	struct rxe_wq		rq;
-	uint32_t		srq_num;
 };
 
+static inline unsigned int srq_num(struct rxe_srq *srq)
+{
+	return srq->vsrq.srq_num;
+}
+
 #define to_rxxx(xxx, type) container_of(ib##xxx, struct rxe_##type, ibv_##xxx)
 
 static inline struct rxe_context *to_rctx(struct ibv_context *ibctx)
@@ -119,9 +129,14 @@ static inline struct rxe_qp *to_rqp(struct ibv_qp *ibqp)
 	return container_of(ibqp, struct rxe_qp, vqp.qp);
 }
 
+static inline struct rxe_xrcd *to_rxrcd(struct ibv_xrcd *ibxrcd)
+{
+	return container_of(ibxrcd, struct rxe_xrcd, vxrcd.xrcd);
+}
+
 static inline struct rxe_srq *to_rsrq(struct ibv_srq *ibsrq)
 {
-	return to_rxxx(srq, srq);
+	return container_of(ibsrq, struct rxe_srq, vsrq.srq);
 }
 
 static inline struct rxe_ah *to_rah(struct ibv_ah *ibah)
-- 
2.34.1

