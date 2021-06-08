Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896F639EDB6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFHEbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:31:19 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:47016 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHEbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:31:19 -0400
Received: by mail-ot1-f43.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso19022025otl.13
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1Di6QySiCRFb4rVC46ApJqosbo0fA2fiy+5pFqUxyI=;
        b=jHmtY5kAR9vXchHZgGSw2qI1ZGl9mxV/kCD+S7GZFA6sdPiimnCqaliBKnSuJRui5+
         yluD/cdYmXcJHR8Of36tJrWws/VmruVVJVwWE3NiMA+uBtQsehsJiDzbg8by+hG9Yq18
         41rIyyEKq3IIN5Tlv6VSHiB55HwQ7p/5xvaUd2xvCXmNYRPuv0kox8Ozb20FppBWhHkB
         mKTHmTVEfJmB8TxBe6Ag/bHclelrU8WmKsNPQ1/QPHSxr04Yqm0WJHo9ZBQ75DuuzdZG
         UgAkBEnMWoNHNhZf1GQJTFdiqUIw8yeMGtIzMiq21TlHCDeKzf3WuxpRy44WpN7p3T4Y
         UzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1Di6QySiCRFb4rVC46ApJqosbo0fA2fiy+5pFqUxyI=;
        b=bS97Lq2aFXPKRCTueG5gzactplvADYqd9/CSuEgVfi31Nc570T/O9yjE/ChFCCkgVs
         fIYvGi+3PZd7hmeVbXlaazb7oZpQjkjxwR1uj9U4VpuWinLffpVEGqQj8xH9K//xRc7K
         C+MD788se0z9bjwvXZOAfYrJClD8kJg0IaZLuDX/Gzau78lahTaE8neAWSDiiMaZ+Tfv
         E1LOWXREsk4IltlnzCooHddcFoUP9KqT+g/nFwrj8rM+0HdQValWQVjl7G58I11IirhE
         RmpsceDXbys9P9nD69FPpcW7AaHJYBqsVTdOyNH0hBeZVEM+6MAaoEXl4lfJWt71kqNK
         xkAg==
X-Gm-Message-State: AOAM532e31ChBKyUbPtsNcEJI3NPJ1k05jeNA0CwnLCQAwF4Eb2ZHvGR
        RRG86M5uHB5MaerGyfXuLZLY6ENsY28=
X-Google-Smtp-Source: ABdhPJw2By5j+l87z9t+caaBXllbjvW9bk1K1kY/pjPOhUI5pnZUTNPDpxmhgxGKDIfMxWvk2QBpfQ==
X-Received: by 2002:a9d:5c08:: with SMTP id o8mr16760622otk.261.1623126495843;
        Mon, 07 Jun 2021 21:28:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id q4sm2620198ooo.33.2021.06.07.21.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:28:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 2/2] Providers/rxe: Implement memory windows
Date:   Mon,  7 Jun 2021 23:28:03 -0500
Message-Id: <20210608042802.33419-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042802.33419-1-rpearsonhpe@gmail.com>
References: <20210608042802.33419-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch makes the required changes to the rxe provider to support the
kernel memory windows patches to the rxe driver.

The following changes are made:
  - Add ibv_alloc_mw verb
  - Add ibv_dealloc_mw verb
  - Add ibv_bind_mw verb for type 1 MWs
  - Add support for bind MW send work requests through the traditional
    QP API and the extended QP API.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Added support for extended QP bind MW work requests.
---
 providers/rxe/rxe.c | 157 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index a68656ae..bb39ef04 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -128,6 +128,95 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
 	return ret;
 }
 
+static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_type type)
+{
+	int ret;
+	struct ibv_mw *ibmw;
+	struct ibv_alloc_mw cmd = {};
+	struct ib_uverbs_alloc_mw_resp resp = {};
+
+	ibmw = calloc(1, sizeof(*ibmw));
+	if (!ibmw)
+		return NULL;
+
+	ret = ibv_cmd_alloc_mw(ibpd, type, ibmw, &cmd, sizeof(cmd),
+						&resp, sizeof(resp));
+	if (ret) {
+		free(ibmw);
+		return NULL;
+	}
+
+	return ibmw;
+}
+
+static int rxe_dealloc_mw(struct ibv_mw *ibmw)
+{
+	int ret;
+
+	ret = ibv_cmd_dealloc_mw(ibmw);
+	if (ret)
+		return ret;
+
+	free(ibmw);
+	return 0;
+}
+
+static int next_rkey(int rkey)
+{
+	return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
+}
+
+static int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_list,
+			 struct ibv_send_wr **bad_wr);
+
+static int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
+			struct ibv_mw_bind *mw_bind)
+{
+	int ret;
+	struct ibv_mw_bind_info	*bind_info = &mw_bind->bind_info;
+	struct ibv_send_wr ibwr;
+	struct ibv_send_wr *bad_wr;
+
+	if (!bind_info->mr && (bind_info->addr || bind_info->length)) {
+		ret = EINVAL;
+		goto err;
+	}
+
+	if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
+		ret = EINVAL;
+		goto err;
+	}
+
+	if (bind_info->mr) {
+		if (ibmw->pd != bind_info->mr->pd) {
+			ret = EPERM;
+			goto err;
+		}
+	}
+
+	memset(&ibwr, 0, sizeof(ibwr));
+
+	ibwr.opcode		= IBV_WR_BIND_MW;
+	ibwr.next		= NULL;
+	ibwr.wr_id		= mw_bind->wr_id;
+	ibwr.send_flags		= mw_bind->send_flags;
+	ibwr.bind_mw.bind_info	= mw_bind->bind_info;
+	ibwr.bind_mw.mw		= ibmw;
+	ibwr.bind_mw.rkey	= next_rkey(ibmw->rkey);
+
+	ret = rxe_post_send(ibqp, &ibwr, &bad_wr);
+	if (ret)
+		goto err;
+
+	/* user has to undo this if he gets an error wc */
+	ibmw->rkey = ibwr.bind_mw.rkey;
+
+	return 0;
+err:
+	errno = ret;
+	return errno;
+}
+
 static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 				 uint64_t hca_va, int access)
 {
@@ -715,6 +804,31 @@ static void wr_atomic_fetch_add(struct ibv_qp_ex *ibqp, uint32_t rkey,
 	advance_qp_cur_index(qp);
 }
 
+static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
+		       uint32_t rkey, const struct ibv_mw_bind_info *info)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_qp_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.opcode = IBV_WR_BIND_MW;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.mw.addr = info->addr;
+	wqe->wr.wr.mw.length = info->length;
+	wqe->wr.wr.mw.mr_lkey = info->mr->lkey;
+	wqe->wr.wr.mw.mw_rkey = ibmw->rkey;
+	wqe->wr.wr.mw.rkey = rkey;
+	wqe->wr.wr.mw.access = info->mw_access_flags;
+	wqe->ssn = qp->ssn++;
+
+	advance_qp_cur_index(qp);
+}
+
 static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
 {
 	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
@@ -1106,6 +1220,7 @@ enum {
 		| IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
 		| IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
 		| IBV_QP_EX_WITH_LOCAL_INV
+		| IBV_QP_EX_WITH_BIND_MW
 		| IBV_QP_EX_WITH_SEND_WITH_INV,
 
 	RXE_SUP_UC_QP_SEND_OPS_FLAGS =
@@ -1113,6 +1228,7 @@ enum {
 		| IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
 		| IBV_QP_EX_WITH_SEND
 		| IBV_QP_EX_WITH_SEND_WITH_IMM
+		| IBV_QP_EX_WITH_BIND_MW
 		| IBV_QP_EX_WITH_SEND_WITH_INV,
 
 	RXE_SUP_UD_QP_SEND_OPS_FLAGS =
@@ -1162,6 +1278,9 @@ static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
 	if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
 		qp->vqp.qp_ex.wr_atomic_fetch_add = wr_atomic_fetch_add;
 
+	if (flags & IBV_QP_EX_WITH_BIND_MW)
+		qp->vqp.qp_ex.wr_bind_mw = wr_bind_mw;
+
 	if (flags & IBV_QP_EX_WITH_LOCAL_INV)
 		qp->vqp.qp_ex.wr_local_inv = wr_local_inv;
 
@@ -1275,9 +1394,10 @@ static int rxe_destroy_qp(struct ibv_qp *ibqp)
 }
 
 /* basic sanity checks for send work request */
-static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
+static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
 			    unsigned int length)
 {
+	struct rxe_wq *sq = &qp->sq;
 	enum ibv_wr_opcode opcode = ibwr->opcode;
 
 	if (ibwr->num_sge > sq->max_sge)
@@ -1291,11 +1411,26 @@ static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
 	if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->max_inline))
 		return -EINVAL;
 
+	if (ibwr->opcode == IBV_WR_BIND_MW) {
+		if (length)
+			return -EINVAL;
+		if (ibwr->num_sge)
+			return -EINVAL;
+		if (ibwr->imm_data)
+			return -EINVAL;
+		if ((qp_type(qp) != IBV_QPT_RC) &&
+		    (qp_type(qp) != IBV_QPT_UC))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
 static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
 {
+	struct ibv_mw *ibmw;
+	struct ibv_mr *ibmr;
+
 	memset(kwr, 0, sizeof(*kwr));
 
 	kwr->wr_id		= uwr->wr_id;
@@ -1326,6 +1461,18 @@ static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
 		kwr->wr.atomic.rkey		= uwr->wr.atomic.rkey;
 		break;
 
+	case IBV_WR_BIND_MW:
+		ibmr = uwr->bind_mw.bind_info.mr;
+		ibmw = uwr->bind_mw.mw;
+
+		kwr->wr.mw.addr = uwr->bind_mw.bind_info.addr;
+		kwr->wr.mw.length = uwr->bind_mw.bind_info.length;
+		kwr->wr.mw.mr_lkey = ibmr->lkey;
+		kwr->wr.mw.mw_rkey = ibmw->rkey;
+		kwr->wr.mw.rkey = uwr->bind_mw.rkey;
+		kwr->wr.mw.access = uwr->bind_mw.bind_info.mw_access_flags;
+		break;
+
 	default:
 		break;
 	}
@@ -1348,6 +1495,8 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 	if (ibwr->send_flags & IBV_SEND_INLINE) {
 		uint8_t *inline_data = wqe->dma.inline_data;
 
+		wqe->dma.resid = 0;
+
 		for (i = 0; i < num_sge; i++) {
 			memcpy(inline_data,
 			       (uint8_t *)(long)ibwr->sg_list[i].addr,
@@ -1363,6 +1512,7 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 		wqe->iova	= ibwr->wr.atomic.remote_addr;
 	else
 		wqe->iova	= ibwr->wr.rdma.remote_addr;
+
 	wqe->dma.length		= length;
 	wqe->dma.resid		= length;
 	wqe->dma.num_sge	= num_sge;
@@ -1385,7 +1535,7 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
 	for (i = 0; i < ibwr->num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	err = validate_send_wr(sq, ibwr, length);
+	err = validate_send_wr(qp, ibwr, length);
 	if (err) {
 		printf("validate send failed\n");
 		return err;
@@ -1579,6 +1729,9 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.dealloc_pd = rxe_dealloc_pd,
 	.reg_mr = rxe_reg_mr,
 	.dereg_mr = rxe_dereg_mr,
+	.alloc_mw = rxe_alloc_mw,
+	.dealloc_mw = rxe_dealloc_mw,
+	.bind_mw = rxe_bind_mw,
 	.create_cq = rxe_create_cq,
 	.create_cq_ex = rxe_create_cq_ex,
 	.poll_cq = rxe_poll_cq,
-- 
2.30.2

