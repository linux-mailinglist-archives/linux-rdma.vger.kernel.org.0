Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9532AA0A1
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKFXCD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgKFXCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:02:02 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BCC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:02:02 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id a15so1110866otf.5
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44Fac/RJP6rk9Ekls8uFsZF85HF2HPf2YxJTb+6sWxA=;
        b=dqol/tcFWQeIhkQWnZsrP1JcC09fEqf2xyu3F4zku1C9Dj2hKpEXJSxa1h/TUzw6HO
         gpj1471I350LL3lyCePRU85LF19Swd5zsohBIaZB30zT+6Zq0vA+tCuNENsR3vJCxn8m
         I7BBku53FtpwyOK9EHJgpt0YIjxGb43Tc/gAAgM08sj9ucEww40x1ALK0q8IPY2SBrJ7
         m/4tKbugvbM1WHRdsaY9yaXRqGLVfvJTumXdF2KKMtgNO/ta5DfO+MZIP5znJAQ3i0iq
         tk6hU5URHCPj8REEIoOr/zKFwZBBhu3bZzMy1ToAfDvikIGhogEvXfKnfsSqG91frpcK
         qUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44Fac/RJP6rk9Ekls8uFsZF85HF2HPf2YxJTb+6sWxA=;
        b=bDHKPnxHudU+PxRkYD7gUy8yp8C7r6UyRCFUNbIpPsF8ecIELa+e12ArGI05pYI8Sa
         KCUsAij1tkc3uTgsmBuw95EGgHEVykZNkVLLd5++CnSVmP9xSjvbFEnb6t/o8Uy7Mpen
         2yPKsdG/bHu6zLtsJbyt8ATGsSZN0QUWdnfRLeU3S3dfHanFFk+YQRTexGO2m04JMuBe
         K0rguMv10UQRD/G3BQp7VDQQ8CcQ+BvQPuHFREjCJBM9Z6dS0EK/rITKEH232le3wF3b
         SpW91a65h9lAisXjMBRtCNTGiHZAkD5pObsleouS1baue59E0eayWrUkW8h4pRb4b1zT
         RCsw==
X-Gm-Message-State: AOAM532uUPWg52g8ooQc7pRGrFPppO5BGITB6zRawxB8y1kZvRfwrlpg
        H8cIAj4q0yzmzLfn5UGRvFI=
X-Google-Smtp-Source: ABdhPJy/w5lml/9SufjS+gLBfGcI6j8KQ1Qw2/4I84s4Mrltd8HZ0zhQDERBP8wI2Tr/uR2V6nTsLQ==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr2822348otc.4.1604703722026;
        Fri, 06 Nov 2020 15:02:02 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id z19sm633823otm.58.2020.11.06.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:02:01 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 3/4] Providers/rxe: Implement ibv_create_cq_ex verb
Date:   Fri,  6 Nov 2020 17:01:21 -0600
Message-Id: <20201106230122.17411-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106230122.17411-1-rpearson@hpe.com>
References: <20201106230122.17411-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Together with the matching commit for the rxe driver
implement the ibv_create_cq_ex verb.
Also implement the operations in ibv_cq_ex struct.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 kernel-headers/rdma/rdma_user_rxe.h |  30 ++++
 providers/rxe/rxe-abi.h             |   4 +-
 providers/rxe/rxe.c                 | 267 +++++++++++++++++++++++++++-
 providers/rxe/rxe.h                 |  12 +-
 providers/rxe/rxe_queue.h           |  59 +++++-
 5 files changed, 357 insertions(+), 15 deletions(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index a31465e2..e8bde1b6 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -158,6 +158,32 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_uverbs_wc {
+	/* keep these the same as ib_uverbs_wc */
+	__aligned_u64		wr_id;
+	__u32			status;
+	__u32			opcode;
+	__u32			vendor_err;
+	__u32			byte_len;
+	union {
+		__be32		imm_data;
+		__u32		invalidate_rkey;
+	} ex;
+	__u32			qp_num;
+	__u32			src_qp;
+	__u32			wc_flags;
+	__u16			pkey_index;
+	__u16			slid;
+	__u8			sl;
+	__u8			dlid_path_bits;
+	__u8			port_num;
+	__u8			reserved;
+
+	/* any extras go here */
+	__aligned_u64		timestamp;
+	__aligned_u64		realtime;
+};
+
 enum rxe_capabilities {
 	RXE_CAP_NONE		= 0,
 	RXE_CAP_CMD_EX		= 1ULL << 0,
@@ -171,6 +197,10 @@ struct rxe_alloc_context_resp {
 	__aligned_u64		driver_cap;
 };
 
+struct rxe_create_cq_cmd {
+	__aligned_u64 is_ex;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index 0b0b4b38..08bdb546 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -42,7 +42,9 @@
 DECLARE_DRV_CMD(urxe_alloc_context, IB_USER_VERBS_CMD_GET_CONTEXT,
 		rxe_alloc_context_cmd, rxe_alloc_context_resp);
 DECLARE_DRV_CMD(urxe_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
-		empty, rxe_create_cq_resp);
+		rxe_create_cq_cmd, rxe_create_cq_resp);
+DECLARE_DRV_CMD(urxe_create_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
+		rxe_create_cq_cmd, rxe_create_cq_resp);
 DECLARE_DRV_CMD(urxe_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
 		empty, rxe_create_qp_resp);
 DECLARE_DRV_CMD(urxe_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index b1fa2f42..57f0c500 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -187,20 +186,163 @@ static int rxe_dereg_mr(struct verbs_mr *vmr)
 	return 0;
 }
 
+static int cq_start_poll(struct ibv_cq_ex *current,
+			 struct ibv_poll_cq_attr *attr)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	pthread_spin_lock(&cq->lock);
+
+	atomic_thread_fence(memory_order_acquire);
+	cq->cur_index = load_consumer_index(cq->queue);
+
+	if (check_cq_queue_empty(cq)) {
+		pthread_spin_unlock(&cq->lock);
+		errno = ENOENT;
+		return errno;
+	}
+
+	cq->wc = addr_from_index(cq->queue, cq->cur_index);
+	cq->vcq.cq_ex.status = cq->wc->status;
+	cq->vcq.cq_ex.wr_id = cq->wc->wr_id;
+
+	return 0;
+}
+
+static int cq_next_poll(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	advance_cq_cur_index(cq);
+
+	if (check_cq_queue_empty(cq)) {
+		store_consumer_index(cq->queue, cq->cur_index);
+		pthread_spin_unlock(&cq->lock);
+		errno = ENOENT;
+		return errno;
+	}
+
+	cq->wc = addr_from_index(cq->queue, cq->cur_index);
+	cq->vcq.cq_ex.status = cq->wc->status;
+	cq->vcq.cq_ex.wr_id = cq->wc->wr_id;
+
+	return 0;
+}
+
+static void cq_end_poll(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	advance_cq_cur_index(cq);
+	store_consumer_index(cq->queue, cq->cur_index);
+	pthread_spin_unlock(&cq->lock);
+
+	return;
+}
+
+static enum ibv_wc_opcode cq_read_opcode(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->opcode;
+}
+
+static uint32_t cq_read_vendor_err(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->vendor_err;
+}
+
+static uint32_t cq_read_byte_len(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->byte_len;
+}
+
+static __be32 cq_read_imm_data(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->ex.imm_data;
+}
+
+static uint32_t cq_read_qp_num(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->qp_num;
+}
+
+static uint32_t cq_read_src_qp(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->src_qp;
+}
+
+static unsigned int cq_read_wc_flags(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->wc_flags;
+}
+
+static uint32_t cq_read_slid(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->slid;
+}
+
+static uint8_t cq_read_sl(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->sl;
+}
+
+static uint8_t cq_read_dlid_path_bits(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->dlid_path_bits;
+}
+
+static uint64_t cq_read_completion_ts(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->timestamp;
+}
+
+static uint64_t cq_read_completion_wallclock_ns(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->realtime;
+}
+
+static int rxe_destroy_cq(struct ibv_cq *ibcq);
+
 static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
 				    struct ibv_comp_channel *channel,
 				    int comp_vector)
 {
 	struct rxe_cq *cq;
-	struct urxe_create_cq_resp resp;
+	struct urxe_create_cq cmd = {};
+	struct urxe_create_cq_resp resp = {};
 	int ret;
 
 	cq = malloc(sizeof(*cq));
 	if (!cq)
 		return NULL;
 
+	cmd.is_ex = 0;
+
 	ret = ibv_cmd_create_cq(context, cqe, channel, comp_vector,
-				&cq->ibv_cq, NULL, 0,
+				&cq->vcq.cq, &cmd.ibv_cmd, sizeof(cmd),
 				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(cq);
@@ -210,15 +352,129 @@ static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
 	cq->queue = mmap(NULL, resp.mi.size, PROT_READ | PROT_WRITE, MAP_SHARED,
 			 context->cmd_fd, resp.mi.offset);
 	if ((void *)cq->queue == MAP_FAILED) {
-		ibv_cmd_destroy_cq(&cq->ibv_cq);
+		ibv_cmd_destroy_cq(&cq->vcq.cq);
+		free(cq);
+		return NULL;
+	}
+
+	cq->wc_size = 1ULL << cq->queue->log2_elem_size;
+
+	if (cq->wc_size < sizeof(struct ib_uverbs_wc)) {
+		fprintf(stderr, "cq wc size too small %ld need %ld\n",
+			cq->wc_size, sizeof(struct ib_uverbs_wc));
+		rxe_destroy_cq(&cq->vcq.cq);
+		return NULL;
+	}
+
+	cq->mmap_info = resp.mi;
+	pthread_spin_init(&cq->lock, PTHREAD_PROCESS_PRIVATE);
+
+	return &cq->vcq.cq;
+}
+
+enum rxe_sup_wc_flags {
+	RXE_SUP_WC_FLAGS = IBV_WC_EX_WITH_BYTE_LEN
+			 | IBV_WC_EX_WITH_IMM
+			 | IBV_WC_EX_WITH_QP_NUM
+			 | IBV_WC_EX_WITH_SRC_QP
+			 | IBV_WC_EX_WITH_SLID
+			 | IBV_WC_EX_WITH_SL
+			 | IBV_WC_EX_WITH_DLID_PATH_BITS
+			 | IBV_WC_EX_WITH_COMPLETION_TIMESTAMP
+			 | IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK,
+};
+
+static struct ibv_cq_ex *rxe_create_cq_ex(struct ibv_context *context,
+					  struct ibv_cq_init_attr_ex *attr)
+{
+	int ret;
+	struct rxe_cq *cq;
+	struct urxe_create_cq_ex cmd = {};
+	struct urxe_create_cq_ex_resp resp = {};
+
+	if (attr->wc_flags & ~RXE_SUP_WC_FLAGS) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	cq = calloc(1, sizeof(*cq));
+	if (!cq)
+		return NULL;
+
+	cmd.is_ex = 1;
+
+	ret = ibv_cmd_create_cq_ex(context, attr, &cq->vcq,
+				   &cmd.ibv_cmd, sizeof(cmd),
+				   &resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		free(cq);
+		return NULL;
+	}
+
+	cq->queue = mmap(NULL, resp.mi.size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			 context->cmd_fd, resp.mi.offset);
+	if ((void *)cq->queue == MAP_FAILED) {
+		ibv_cmd_destroy_cq(&cq->vcq.cq);
 		free(cq);
 		return NULL;
 	}
 
+	cq->wc_size = 1ULL << cq->queue->log2_elem_size;
+
+	if (cq->wc_size < sizeof(struct rxe_uverbs_wc)) {
+		fprintf(stderr, "cq wc size too small %ld need %ld\n",
+			cq->wc_size, sizeof(struct rxe_uverbs_wc));
+		rxe_destroy_cq(&cq->vcq.cq);
+		return NULL;
+	}
+
 	cq->mmap_info = resp.mi;
 	pthread_spin_init(&cq->lock, PTHREAD_PROCESS_PRIVATE);
 
-	return &cq->ibv_cq;
+	cq->vcq.cq_ex.start_poll	= cq_start_poll;
+	cq->vcq.cq_ex.next_poll		= cq_next_poll;
+	cq->vcq.cq_ex.end_poll		= cq_end_poll;
+	cq->vcq.cq_ex.read_opcode	= cq_read_opcode;
+	cq->vcq.cq_ex.read_vendor_err	= cq_read_vendor_err;
+	cq->vcq.cq_ex.read_wc_flags	= cq_read_wc_flags;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_BYTE_LEN)
+		cq->vcq.cq_ex.read_byte_len
+			= cq_read_byte_len;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_IMM)
+		cq->vcq.cq_ex.read_imm_data
+			= cq_read_imm_data;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_QP_NUM)
+		cq->vcq.cq_ex.read_qp_num
+			= cq_read_qp_num;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_SRC_QP)
+		cq->vcq.cq_ex.read_src_qp
+			= cq_read_src_qp;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_SLID)
+		cq->vcq.cq_ex.read_slid
+			= cq_read_slid;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_SL)
+		cq->vcq.cq_ex.read_sl
+			= cq_read_sl;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_DLID_PATH_BITS)
+		cq->vcq.cq_ex.read_dlid_path_bits
+			= cq_read_dlid_path_bits;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_COMPLETION_TIMESTAMP)
+		cq->vcq.cq_ex.read_completion_ts
+			= cq_read_completion_ts;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK)
+		cq->vcq.cq_ex.read_completion_wallclock_ns
+			= cq_read_completion_wallclock_ns;
+
+	return &cq->vcq.cq_ex;
 }
 
 static int rxe_resize_cq(struct ibv_cq *ibcq, int cqe)
@@ -890,6 +1146,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 
 static const struct verbs_context_ops rxe_ctx_ops_cmd_ex = {
 	.query_device_ex = rxe_query_device_ex,
+	.create_cq_ex = rxe_create_cq_ex,
 };
 
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index f9cae315..e89a781f 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -62,11 +62,17 @@ struct rxe_context {
 	uint64_t		capabilities;
 };
 
+/* common between cq and cq_ex */
 struct rxe_cq {
-	struct ibv_cq		ibv_cq;
+	struct verbs_cq		vcq;
 	struct mminfo		mmap_info;
-	struct rxe_queue		*queue;
+	struct rxe_queue	*queue;
 	pthread_spinlock_t	lock;
+
+	/* new API support */
+	struct rxe_uverbs_wc	*wc;
+	size_t			wc_size;
+	uint32_t		cur_index;
 };
 
 struct rxe_ah {
@@ -113,7 +119,7 @@ static inline struct rxe_device *to_rdev(struct ibv_device *ibdev)
 
 static inline struct rxe_cq *to_rcq(struct ibv_cq *ibcq)
 {
-	return to_rxxx(cq, cq);
+	return container_of(ibcq, struct rxe_cq, vcq.cq);
 }
 
 static inline struct rxe_qp *to_rqp(struct ibv_qp *ibqp)
diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
index 5c57b3e3..1c3c3d5c 100644
--- a/providers/rxe/rxe_queue.h
+++ b/providers/rxe/rxe_queue.h
@@ -40,6 +40,8 @@
 #include <stdint.h>
 #include <stdatomic.h>
 
+#include "rxe.h"
+
 /* MUST MATCH kernel struct rxe_pqc in rxe_queue.h */
 struct rxe_queue {
 	uint32_t		log2_elem_size;
@@ -57,27 +59,27 @@ static inline int next_index(struct rxe_queue *q, int index)
 	return (index + 1) & q->index_mask;
 }
 
+/* Must hold consumer_index lock */
 static inline int queue_empty(struct rxe_queue *q)
 {
-	/* Must hold consumer_index lock */
 	return ((atomic_load(&q->producer_index) -
 		 atomic_load_explicit(&q->consumer_index,
 				      memory_order_relaxed)) &
 		q->index_mask) == 0;
 }
 
+/* Must hold producer_index lock */
 static inline int queue_full(struct rxe_queue *q)
 {
-	/* Must hold producer_index lock */
 	return ((atomic_load_explicit(&q->producer_index,
 				      memory_order_relaxed) +
 		 1 - atomic_load(&q->consumer_index)) &
 		q->index_mask) == 0;
 }
 
+/* Must hold producer_index lock */
 static inline void advance_producer(struct rxe_queue *q)
 {
-	/* Must hold producer_index lock */
 	atomic_thread_fence(memory_order_release);
 	atomic_store(
 	    &q->producer_index,
@@ -86,9 +88,9 @@ static inline void advance_producer(struct rxe_queue *q)
 		q->index_mask);
 }
 
+/* Must hold consumer_index lock */
 static inline void advance_consumer(struct rxe_queue *q)
 {
-	/* Must hold consumer_index lock */
 	atomic_store(
 	    &q->consumer_index,
 	    (atomic_load_explicit(&q->consumer_index, memory_order_relaxed) +
@@ -96,18 +98,48 @@ static inline void advance_consumer(struct rxe_queue *q)
 		q->index_mask);
 }
 
+/* Must hold producer_index lock */
+static inline uint32_t load_producer_index(struct rxe_queue *q)
+{
+	return atomic_load_explicit(&q->producer_index,
+				    memory_order_relaxed);
+}
+
+/* Must hold producer_index lock */
+static inline void store_producer_index(struct rxe_queue *q, uint32_t index)
+{
+	/* flush writes to work queue before moving index */
+	atomic_thread_fence(memory_order_release);
+	atomic_store(&q->producer_index, index);
+}
+
+/* Must hold consumer_index lock */
+static inline uint32_t load_consumer_index(struct rxe_queue *q)
+{
+	return atomic_load_explicit(&q->consumer_index,
+				    memory_order_relaxed);
+}
+
+/* Must hold consumer_index lock */
+static inline void store_consumer_index(struct rxe_queue *q, uint32_t index)
+{
+	/* flush writes to work queue before moving index */
+	atomic_thread_fence(memory_order_release);
+	atomic_store(&q->consumer_index, index);
+}
+
+/* Must hold producer_index lock */
 static inline void *producer_addr(struct rxe_queue *q)
 {
-	/* Must hold producer_index lock */
 	return q->data + ((atomic_load_explicit(&q->producer_index,
 						memory_order_relaxed) &
 			   q->index_mask)
 			  << q->log2_elem_size);
 }
 
+/* Must hold consumer_index lock */
 static inline void *consumer_addr(struct rxe_queue *q)
 {
-	/* Must hold consumer_index lock */
 	return q->data + ((atomic_load_explicit(&q->consumer_index,
 						memory_order_relaxed) &
 			   q->index_mask)
@@ -125,4 +157,19 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q, const void
 	return (((uint8_t *)addr - q->data) >> q->log2_elem_size) & q->index_mask;
 }
 
+static inline void advance_cq_cur_index(struct rxe_cq *cq)
+{
+	struct rxe_queue *q = cq->queue;
+
+	cq->cur_index = (cq->cur_index + 1) & q->index_mask;
+}
+
+static inline int check_cq_queue_empty(struct rxe_cq *cq)
+{
+	struct rxe_queue *q = cq->queue;
+	uint32_t producer_index = atomic_load(&q->producer_index);
+
+	return (cq->cur_index == producer_index);
+}
+
 #endif /* H_RXE_PCQ */
-- 
2.27.0

