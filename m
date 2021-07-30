Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FC3DBC2A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhG3PXS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbhG3PXS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 11:23:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0449FC0613C1
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n16so7050330oij.2
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZ6oTHwrbg9BPqBT7Am9q7gBWv8vputEAYRU5n9d16E=;
        b=V4j3qZk5IOa7oxCdSWsahF1JjjSdZlhFal4uDWE33L1jEwKii0kZq4dRzPw9/ohgnz
         a4CQFkhwV91vk/wd96x6Lct+kYWyvFXVbsHH0XUIwbToqKPxZBAsRq0Azj/hsCkdgojm
         WOEMxq+D/QZQikjskBrXxacr9CfOk6eECjRa1VpnzPG7OxPlL3j7spAivKYngzfI0EXs
         FhwWun8h5qvZz8reKbytFGLka5Pt/o+xviYvfCOMa9RFc+1FtNws8VBC7UttgT6Rb3iY
         z0QZ8tj1M7PuTreV/n+C2ZmdqKXFUc/aYXSo9y2TTx1c+ZxOGR+yAMRYI9k0LL0aHVg6
         0Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZ6oTHwrbg9BPqBT7Am9q7gBWv8vputEAYRU5n9d16E=;
        b=G+kHA3n4gMU2bp7uzsviuLVGHLXmwAJKsqZeXtGr7fCiQx0PJwNaOk4+5Rw6SP+x9o
         xZO/DsfigymxhCfzxgVG9cmX7NuV995n1uznKhG+5tI7xuSV89SbLUsBwxYI3stmRFyg
         MINRCAEOy5TxO2LOLwqZoR9e5L6Mqiy2Kq28r6q0XhAgoxhZTblkF06v5vRGV+8UNUtK
         KJbvMgTDTX2dCI8uCxME9SJWhPQd5809vOqjr7YFFs77XaKZtold5yDdgg7TyHf9uybi
         nFFAUzC85Kb/6etMwCawK9O9jANG5sQbFni/Vm4y/lwn4SAYlB2Y4N6+bnce7IJkMv/3
         cxAw==
X-Gm-Message-State: AOAM532mFQclWAIrKD/+BAxqglyD6GXP4ZVmdQbyyShmKQ343ZsRgf54
        mCYTjpz/Hlvvu8X4ciBejIM=
X-Google-Smtp-Source: ABdhPJw1Q/CJJgaQh+5/bwS3mXcD6Evf/yWYm3vQhA5oGUHexOj6wz4uGiRXXdNorpoKMmGaArcuVg==
X-Received: by 2002:aca:aacd:: with SMTP id t196mr2119233oie.12.1627658592388;
        Fri, 30 Jul 2021 08:23:12 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c18sm333742ots.81.2021.07.30.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:23:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 5/5] Providers/rxe: Support XRC traffic
Date:   Fri, 30 Jul 2021 10:21:58 -0500
Message-Id: <20210730152157.67592-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730152157.67592-1-rpearsonhpe@gmail.com>
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extended create_qp and create_qp_ex verbs to support XRC QP types.
Extended WRs to support XRC operations.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 providers/rxe/rxe.c | 132 ++++++++++++++++++++++++++++++++------------
 1 file changed, 96 insertions(+), 36 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index d4538713..4fbdb689 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -875,9 +875,10 @@ static void wr_atomic_fetch_add(struct ibv_qp_ex *ibqp, uint32_t rkey,
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_ATOMIC_FETCH_AND_ADD;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.wr.atomic.remote_addr = remote_addr;
 	wqe->wr.wr.atomic.compare_add = add;
 	wqe->wr.wr.atomic.rkey = rkey;
@@ -899,8 +900,9 @@ static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
 	memset(wqe, 0, sizeof(*wqe));
 
 	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_BIND_MW;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.wr.mw.addr = info->addr;
 	wqe->wr.wr.mw.length = info->length;
 	wqe->wr.wr.mw.mr_lkey = info->mr->lkey;
@@ -922,9 +924,10 @@ static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_LOCAL_INV;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.ex.invalidate_rkey = invalidate_rkey;
 	wqe->ssn = qp->ssn++;
 
@@ -942,9 +945,10 @@ static void wr_rdma_read(struct ibv_qp_ex *ibqp, uint32_t rkey,
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_RDMA_READ;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.wr.rdma.remote_addr = remote_addr;
 	wqe->wr.wr.rdma.rkey = rkey;
 	wqe->iova = remote_addr;
@@ -964,9 +968,10 @@ static void wr_rdma_write(struct ibv_qp_ex *ibqp, uint32_t rkey,
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_RDMA_WRITE;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.wr.rdma.remote_addr = remote_addr;
 	wqe->wr.wr.rdma.rkey = rkey;
 	wqe->iova = remote_addr;
@@ -986,9 +991,10 @@ static void wr_rdma_write_imm(struct ibv_qp_ex *ibqp, uint32_t rkey,
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_RDMA_WRITE_WITH_IMM;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.wr.rdma.remote_addr = remote_addr;
 	wqe->wr.wr.rdma.rkey = rkey;
 	wqe->wr.ex.imm_data = imm_data;
@@ -1008,9 +1014,10 @@ static void wr_send(struct ibv_qp_ex *ibqp)
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_SEND;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->ssn = qp->ssn++;
 
 	advance_qp_cur_index(qp);
@@ -1026,9 +1033,10 @@ static void wr_send_imm(struct ibv_qp_ex *ibqp, __be32 imm_data)
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_SEND_WITH_IMM;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.ex.imm_data = imm_data;
 	wqe->ssn = qp->ssn++;
 
@@ -1045,9 +1053,10 @@ static void wr_send_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
 
 	memset(wqe, 0, sizeof(*wqe));
 
-	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
 	wqe->wr.opcode = IBV_WR_SEND_WITH_INV;
-	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+
 	wqe->wr.ex.invalidate_rkey = invalidate_rkey;
 	wqe->ssn = qp->ssn++;
 
@@ -1074,6 +1083,18 @@ static void wr_set_ud_addr(struct ibv_qp_ex *ibqp, struct ibv_ah *ibah,
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
+	wqe->wr.wr.xrc.srq_num = remote_srqn;
+}
+
 static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
 			       size_t length)
 {
@@ -1212,7 +1233,8 @@ static int map_queue_pair(int cmd_fd, struct rxe_qp *qp,
 			  struct ibv_qp_init_attr *attr,
 			  struct rxe_create_qp_resp *resp)
 {
-	if (attr->srq) {
+	if (attr->srq || qp_type(qp) == IBV_QPT_XRC_RECV ||
+	    qp_type(qp) == IBV_QPT_XRC_SEND) {
 		qp->rq.max_sge = 0;
 		qp->rq.queue = NULL;
 		qp->rq_mmap_info.size = 0;
@@ -1228,23 +1250,44 @@ static int map_queue_pair(int cmd_fd, struct rxe_qp *qp,
 		pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE);
 	}
 
-	qp->sq.max_sge = attr->cap.max_send_sge;
-	qp->sq.max_inline = attr->cap.max_inline_data;
-	qp->sq.queue = mmap(NULL, resp->sq_mi.size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED,
-			    cmd_fd, resp->sq_mi.offset);
-	if ((void *)qp->sq.queue == MAP_FAILED) {
-		if (qp->rq_mmap_info.size)
-			munmap(qp->rq.queue, qp->rq_mmap_info.size);
-		return errno;
-	}
+	if (qp_type(qp) != IBV_QPT_XRC_RECV) {
+		qp->sq.max_sge = attr->cap.max_send_sge;
+		qp->sq.max_inline = attr->cap.max_inline_data;
+		qp->sq.queue = mmap(NULL, resp->sq_mi.size, PROT_READ | PROT_WRITE,
+				    MAP_SHARED,
+				    cmd_fd, resp->sq_mi.offset);
+		if ((void *)qp->sq.queue == MAP_FAILED) {
+			if (qp->rq_mmap_info.size)
+				munmap(qp->rq.queue, qp->rq_mmap_info.size);
+			return errno;
+		}
 
-	qp->sq_mmap_info = resp->sq_mi;
-	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
+		qp->sq_mmap_info = resp->sq_mi;
+		pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
+	}
 
 	return 0;
 }
 
+static int map_queue_pair_ex(int cmd_fd, struct rxe_qp *qp,
+			     struct ibv_qp_init_attr_ex *attr,
+			     struct rxe_create_qp_resp *resp)
+{
+	switch (attr->qp_type) {
+	case IBV_QPT_RC:
+	case IBV_QPT_UC:
+	case IBV_QPT_UD:
+	case IBV_QPT_XRC_SEND:
+		return map_queue_pair(cmd_fd, qp,
+				(struct ibv_qp_init_attr *)attr, resp);
+	case IBV_QPT_XRC_RECV:
+		return 0;
+	default:
+		errno = EINVAL;
+		return errno;
+	}
+}
+
 static struct ibv_qp *rxe_create_qp(struct ibv_pd *ibpd,
 				    struct ibv_qp_init_attr *attr)
 {
@@ -1283,7 +1326,7 @@ err:
 enum {
 	RXE_QP_CREATE_FLAGS_SUP = 0,
 
-	RXE_QP_COMP_MASK_SUP = IBV_QP_INIT_ATTR_PD |
+	RXE_QP_COMP_MASK_SUP = IBV_QP_INIT_ATTR_PD | IBV_QP_INIT_ATTR_XRCD |
 		IBV_QP_INIT_ATTR_CREATE_FLAGS | IBV_QP_INIT_ATTR_SEND_OPS_FLAGS,
 
 	RXE_SUP_RC_QP_SEND_OPS_FLAGS =
@@ -1300,6 +1343,13 @@ enum {
 
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
@@ -1325,6 +1375,10 @@ static int check_qp_init_attr(struct ibv_qp_init_attr_ex *attr)
 			if (attr->send_ops_flags & ~RXE_SUP_UD_QP_SEND_OPS_FLAGS)
 				goto err;
 			break;
+		case IBV_QPT_XRC_SEND:
+			if (attr->send_ops_flags & ~RXE_SUP_XRC_QP_SEND_OPS_FLAGS)
+				goto err;
+			break;
 		default:
 			goto err;
 		}
@@ -1369,6 +1423,7 @@ static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
 		qp->vqp.qp_ex.wr_send_inv = wr_send_inv;
 
 	qp->vqp.qp_ex.wr_set_ud_addr = wr_set_ud_addr;
+	qp->vqp.qp_ex.wr_set_xrc_srqn = wr_set_xrc_srqn;
 	qp->vqp.qp_ex.wr_set_inline_data = wr_set_inline_data;
 	qp->vqp.qp_ex.wr_set_inline_data_list = wr_set_inline_data_list;
 	qp->vqp.qp_ex.wr_set_sge = wr_set_sge;
@@ -1390,8 +1445,9 @@ static struct ibv_qp *rxe_create_qp_ex(struct ibv_context *context,
 	size_t resp_size = sizeof(resp);
 
 	ret = check_qp_init_attr(attr);
-	if (ret)
+	if (ret) {
 		goto err;
+	}
 
 	qp = calloc(1, sizeof(*qp));
 	if (!qp)
@@ -1408,9 +1464,8 @@ static struct ibv_qp *rxe_create_qp_ex(struct ibv_context *context,
 
 	qp->vqp.comp_mask |= VERBS_QP_EX;
 
-	ret = map_queue_pair(context->cmd_fd, qp,
-			     (struct ibv_qp_init_attr *)attr,
-			     &resp.drv_payload);
+	ret = map_queue_pair_ex(context->cmd_fd, qp, attr,
+				&resp.drv_payload);
 	if (ret)
 		goto err_destroy;
 
@@ -1484,7 +1539,9 @@ static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
 			return -EINVAL;
 		if (ibwr->imm_data)
 			return -EINVAL;
-		if ((qp_type(qp) != IBV_QPT_RC) && (qp_type(qp) != IBV_QPT_UC))
+		if ((qp_type(qp) != IBV_QPT_RC) &&
+		    (qp_type(qp) != IBV_QPT_UC) &&
+		    (qp_type(qp) != IBV_QPT_XRC_SEND))
 			return -EINVAL;
 	}
 
@@ -1547,6 +1604,9 @@ static void convert_send_wr(struct rxe_qp *qp, struct rxe_send_wr *kwr,
 	default:
 		break;
 	}
+
+	if (qp_type(qp) == IBV_QPT_XRC_SEND)
+		kwr->wr.xrc.srq_num = uwr->qp_type.xrc.remote_srqn;
 }
 
 static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
-- 
2.30.2

