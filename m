Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44D27082E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRV0D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRV0D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:26:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509DC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:02 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x69so8703216oia.8
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jeq6vl/2Nk6jGHPCfuPEAO5ldW0OiC62R9PUZRzfMic=;
        b=RJBxS++HoYhi0/vRhl7dCaEAJsg17tWs6u7z1kPWcEYgV/DfCioXLlTInK6h9ezaIV
         m9TJk1P+I7zpC4j94uJ9F08yG+OEGRDymakVlfufspSIlEA2GiLqvMqEnpozVhiE4boG
         qanHOYIFwfUx1hAF9lH44GyFrSfJKC4r1X8MRN4pZZ3DJIgtJnjrihwvxarQsmHa6/Gw
         e3a1R+cuxd2Ss9yULvIMn+UZt/uwI+vEXBZ3dJoiYs769ckCfVKAMtNJ0n96ubaFDFWa
         2VhnIBAXFpFF4BxmrbT9S+pahpiCMV74VEQp31lLRIihHEo3Y0549jPHfrnh5Lc6hqH3
         LtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jeq6vl/2Nk6jGHPCfuPEAO5ldW0OiC62R9PUZRzfMic=;
        b=Kd4AClxVeD/R1h87Z32F4FPj+l0THpuO3dqhXCl9+NER+n6v6IZEKHwy6XS2Vdgk9F
         nmXBlGdxfhwkeetNL89G0Fmt/13ywoOK041HhUrBidOZDnFPPxqTX+LVNWsGdzPNBN6+
         DldP2r8bY0OBYUKJ5lKe1MhRG6OezOM8anrvRzalO2/qR4aJkH2/Ztok8eUVS3O0EICB
         wG5mCrBZiBlBv2uCEbuF/y28gnyEv+4jJxThgfr9JUlpN2f7KdKNs+B/KaoTeCQFLFjd
         N5lhnHq3vsfJnTxXn2EKvfb+0RJVHs5gCWW+NLjQIJae5tMHjeRv/0HoYvpBWu4yZcu6
         3b/g==
X-Gm-Message-State: AOAM530mvX6NpVbQLvih9GBK9zo3aHVcULEPL3YG/ZR+L4wNKm7GIDNx
        EaT8y4eW5d7CDn7uubpJZB4=
X-Google-Smtp-Source: ABdhPJwtYUFL2sY5i89DGxp7Ds+ZlEtDBnXEb8ZicS5axVLYY0H05fQTUVU150S++gpA8WQGXl54nw==
X-Received: by 2002:aca:aa85:: with SMTP id t127mr10090452oie.46.1600464362201;
        Fri, 18 Sep 2020 14:26:02 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id x15sm3869547oor.33.2020.09.18.14.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:26:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 3/4] rxe: add support for extended CQ operations
Date:   Fri, 18 Sep 2020 16:25:56 -0500
Message-Id: <20200918212557.5446-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918212557.5446-1-rpearson@hpe.com>
References: <20200918212557.5446-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implemented ibv_create_cq_ex verb.
Implemented operations in ibv_cq_ex struct.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 kernel-headers/rdma/rdma_user_rxe.h |  44 ++-
 providers/rxe/CMakeLists.txt        |   1 +
 providers/rxe/rxe-abi.h             |  10 +-
 providers/rxe/rxe.c                 | 215 +++++--------
 providers/rxe/rxe.h                 |  21 +-
 providers/rxe/rxe_cq.c              | 449 ++++++++++++++++++++++++++++
 providers/rxe/rxe_queue.h           |  42 ++-
 7 files changed, 617 insertions(+), 165 deletions(-)
 create mode 100644 providers/rxe/rxe_cq.c

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index d4912568..9de469d7 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -98,29 +98,27 @@ struct rxe_send_wr {
 			__aligned_u64	length;
 			union {
 				__u32		mr_index;
-				__aligned_u64	reserved1;
+				__aligned_u64   pad1;
 			};
 			union {
 				__u32		mw_index;
-				__aligned_u64	reserved2;
+				__aligned_u64   pad2;
 			};
 			__u32	rkey;
 			__u32	access;
 			__u32	flags;
 		} umw;
-		/* The following are only used by the kernel
-		 * and are not part of the uapi
-		 */
+		/* below are only used by the kernel */
 		struct {
 			__aligned_u64	addr;
 			__aligned_u64	length;
 			union {
 				struct ib_mr	*mr;
-				__aligned_u64	reserved1;
+				__aligned_u64   reserved1;
 			};
 			union {
 				struct ib_mw	*mw;
-				__aligned_u64	reserved2;
+				__aligned_u64   reserved2;
 			};
 			__u32	rkey;
 			__u32	access;
@@ -131,8 +129,8 @@ struct rxe_send_wr {
 				struct ib_mr *mr;
 				__aligned_u64 reserved;
 			};
-			__u32	     key;
-			__u32	     access;
+			__u32        key;
+			__u32        access;
 		} reg;
 	} wr;
 };
@@ -144,7 +142,7 @@ struct rxe_sge {
 };
 
 struct mminfo {
-	__aligned_u64		offset;
+	__aligned_u64  		offset;
 	__u32			size;
 	__u32			pad;
 };
@@ -184,6 +182,32 @@ struct rxe_recv_wqe {
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
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
diff --git a/providers/rxe/CMakeLists.txt b/providers/rxe/CMakeLists.txt
index 96052555..0e62aae7 100644
--- a/providers/rxe/CMakeLists.txt
+++ b/providers/rxe/CMakeLists.txt
@@ -1,6 +1,7 @@
 rdma_provider(rxe
   rxe.c
   rxe_dev.c
+  rxe_cq.c
   rxe_sq.c
   rxe_mw.c
   )
diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index 2fc09483..14d0c038 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -39,16 +39,18 @@
 #include <rdma/rdma_user_rxe.h>
 #include <kernel-abi/rdma_user_rxe.h>
 
-DECLARE_DRV_CMD(urxe_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
-		empty, rxe_create_cq_resp);
 DECLARE_DRV_CMD(urxe_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
 		empty, rxe_create_qp_resp);
+DECLARE_DRV_CMD(urxe_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
+		empty, rxe_create_cq_resp);
+DECLARE_DRV_CMD(urxe_create_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
+		empty, rxe_create_cq_resp);
+DECLARE_DRV_CMD(urxe_resize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
+		empty, rxe_resize_cq_resp);
 DECLARE_DRV_CMD(urxe_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 		empty, rxe_create_srq_resp);
 DECLARE_DRV_CMD(urxe_modify_srq, IB_USER_VERBS_CMD_MODIFY_SRQ,
 		rxe_modify_srq_cmd, empty);
-DECLARE_DRV_CMD(urxe_resize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
-		empty, rxe_resize_cq_resp);
 DECLARE_DRV_CMD(urxe_reg_mr, IB_USER_VERBS_CMD_REG_MR,
 		empty, rxe_reg_mr_resp);
 DECLARE_DRV_CMD(urxe_alloc_mw, IB_USER_VERBS_CMD_ALLOC_MW,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 79863985..308d7a78 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -102,116 +102,6 @@ static int rxe_dereg_mr(struct verbs_mr *vmr)
 	return 0;
 }
 
-static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
-				    struct ibv_comp_channel *channel,
-				    int comp_vector)
-{
-	struct rxe_cq *cq;
-	struct urxe_create_cq_resp resp;
-	int ret;
-
-	cq = malloc(sizeof(*cq));
-	if (!cq)
-		return NULL;
-
-	ret = ibv_cmd_create_cq(context, cqe, channel, comp_vector,
-				&cq->ibv_cq, NULL, 0,
-				&resp.ibv_resp, sizeof(resp));
-	if (ret) {
-		free(cq);
-		return NULL;
-	}
-
-	cq->queue = mmap(NULL, resp.mi.size, PROT_READ | PROT_WRITE, MAP_SHARED,
-			 context->cmd_fd, resp.mi.offset);
-	if ((void *)cq->queue == MAP_FAILED) {
-		ibv_cmd_destroy_cq(&cq->ibv_cq);
-		free(cq);
-		return NULL;
-	}
-
-	cq->mmap_info = resp.mi;
-	pthread_spin_init(&cq->lock, PTHREAD_PROCESS_PRIVATE);
-
-	return &cq->ibv_cq;
-}
-
-static int rxe_resize_cq(struct ibv_cq *ibcq, int cqe)
-{
-	struct rxe_cq *cq = to_rcq(ibcq);
-	struct ibv_resize_cq cmd;
-	struct urxe_resize_cq_resp resp;
-	int ret;
-
-	pthread_spin_lock(&cq->lock);
-
-	ret = ibv_cmd_resize_cq(ibcq, cqe, &cmd, sizeof(cmd),
-				&resp.ibv_resp, sizeof(resp));
-	if (ret) {
-		pthread_spin_unlock(&cq->lock);
-		return ret;
-	}
-
-	munmap(cq->queue, cq->mmap_info.size);
-
-	cq->queue = mmap(NULL, resp.mi.size,
-			 PROT_READ | PROT_WRITE, MAP_SHARED,
-			 ibcq->context->cmd_fd, resp.mi.offset);
-
-	ret = errno;
-	pthread_spin_unlock(&cq->lock);
-
-	if ((void *)cq->queue == MAP_FAILED) {
-		cq->queue = NULL;
-		cq->mmap_info.size = 0;
-		return ret;
-	}
-
-	cq->mmap_info = resp.mi;
-
-	return 0;
-}
-
-static int rxe_destroy_cq(struct ibv_cq *ibcq)
-{
-	struct rxe_cq *cq = to_rcq(ibcq);
-	int ret;
-
-	ret = ibv_cmd_destroy_cq(ibcq);
-	if (ret)
-		return ret;
-
-	if (cq->mmap_info.size)
-		munmap(cq->queue, cq->mmap_info.size);
-	free(cq);
-
-	return 0;
-}
-
-static int rxe_poll_cq(struct ibv_cq *ibcq, int ne, struct ibv_wc *wc)
-{
-	struct rxe_cq *cq = to_rcq(ibcq);
-	struct rxe_queue *q;
-	int npolled;
-	uint8_t *src;
-
-	pthread_spin_lock(&cq->lock);
-	q = cq->queue;
-
-	for (npolled = 0; npolled < ne; ++npolled, ++wc) {
-		if (queue_empty(q))
-			break;
-
-		atomic_thread_fence(memory_order_acquire);
-		src = consumer_addr(q);
-		memcpy(wc, src, sizeof(*wc));
-		advance_consumer(q);
-	}
-
-	pthread_spin_unlock(&cq->lock);
-	return npolled;
-}
-
 static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 				      struct ibv_srq_init_attr *attr)
 {
@@ -590,38 +480,79 @@ static int rxe_destroy_ah(struct ibv_ah *ibah)
 }
 
 static const struct verbs_context_ops rxe_ctx_ops = {
-	.query_device = rxe_query_device,
-	.query_device_ex = rxe_query_device_ex,
-	.query_port = rxe_query_port,
-	.alloc_pd = rxe_alloc_pd,
-	.dealloc_pd = rxe_dealloc_pd,
-	.reg_mr = rxe_reg_mr,
-	.dereg_mr = rxe_dereg_mr,
-	.create_cq = rxe_create_cq,
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
-	.query_qp = rxe_query_qp,
-	.modify_qp = rxe_modify_qp,
-	.destroy_qp = rxe_destroy_qp,
-	.post_send = rxe_post_send,
-	.post_recv = rxe_post_recv,
-	.create_ah = rxe_create_ah,
-	.destroy_ah = rxe_destroy_ah,
-	.attach_mcast = ibv_cmd_attach_mcast,
-	.detach_mcast = ibv_cmd_detach_mcast,
-	.free_context = rxe_free_context,
-	.alloc_mw = rxe_alloc_mw,
-	.bind_mw = rxe_bind_mw,
-	.dealloc_mw = rxe_dealloc_mw,
-	.get_srq_num = rxe_get_srq_num,
+	.advise_mr		= NULL,
+	.alloc_dm		= NULL,
+	.alloc_mw		= rxe_alloc_mw,
+	.alloc_null_mr		= NULL,
+	.alloc_parent_domain	= NULL,
+	.alloc_pd		= rxe_alloc_pd,
+	.alloc_td		= NULL,
+	.async_event		= NULL,
+	.attach_counters_point_flow	= NULL,
+	.attach_mcast		= ibv_cmd_attach_mcast,
+	.bind_mw		= rxe_bind_mw,
+	.close_xrcd		= NULL,
+	.cq_event		= NULL,
+	.create_ah		= rxe_create_ah,
+	.create_counters	= NULL,
+	.create_cq_ex		= rxe_create_cq_ex,
+	.create_cq		= rxe_create_cq,
+	.create_flow_action_esp	= NULL,
+	.create_flow		= NULL,
+	.create_qp_ex		= NULL,
+	.create_qp		= rxe_create_qp,
+	.create_rwq_ind_table	= NULL,
+	.create_srq_ex		= NULL,
+	.create_srq		= rxe_create_srq,
+	.create_wq		= NULL,
+	.dealloc_mw		= rxe_dealloc_mw,
+	.dealloc_pd		= rxe_dealloc_pd,
+	.dealloc_td		= NULL,
+	.dereg_mr		= rxe_dereg_mr,
+	.destroy_ah		= rxe_destroy_ah,
+	.destroy_counters	= NULL,
+	.destroy_cq		= rxe_destroy_cq,
+	.destroy_flow_action	= NULL,
+	.destroy_flow		= NULL,
+	.destroy_qp		= rxe_destroy_qp,
+	.destroy_rwq_ind_table	= NULL,
+	.destroy_srq		= rxe_destroy_srq,
+	.destroy_wq		= NULL,
+	.detach_mcast		= ibv_cmd_detach_mcast,
+	.free_context		= rxe_free_context,
+	.free_dm		= NULL,
+	.get_srq_num		= rxe_get_srq_num,
+	.import_mr		= NULL,
+	.import_pd		= NULL,
+	.modify_cq		= NULL,
+	.modify_flow_action_esp	= NULL,
+	.modify_qp_rate_limit	= NULL,
+	.modify_qp		= rxe_modify_qp,
+	.modify_srq		= rxe_modify_srq,
+	.modify_wq		= NULL,
+	.open_qp		= NULL,
+	.open_xrcd		= NULL,
+	.poll_cq		= rxe_poll_cq,
+	.post_recv		= rxe_post_recv,
+	.post_send		= rxe_post_send,
+	.post_srq_ops		= NULL,
+	.post_srq_recv		= rxe_post_srq_recv,
+	.query_device_ex	= rxe_query_device_ex,
+	.query_device		= rxe_query_device,
+	.query_ece		= NULL,
+	.query_port		= rxe_query_port,
+	.query_qp		= rxe_query_qp,
+	.query_rt_values	= NULL,
+	.query_srq		= rxe_query_srq,
+	.read_counters		= NULL,
+	.reg_dm_mr		= NULL,
+	.reg_mr			= rxe_reg_mr,
+	.req_notify_cq		= ibv_cmd_req_notify_cq,
+	.rereg_mr		= NULL,
+	.resize_cq		= rxe_resize_cq,
+	.set_ece		= NULL,
+	.unimport_mr		= NULL,
+	.unimport_pd		= NULL,
 };
 
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 11f337ee..69ddba55 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -57,11 +57,16 @@ struct rxe_context {
 	struct verbs_context	ibv_ctx;
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
+	uint32_t		cur_index;
 };
 
 struct rxe_ah {
@@ -127,7 +132,7 @@ static inline struct rxe_device *to_rdev(struct ibv_device *ibdev)
 
 static inline struct rxe_cq *to_rcq(struct ibv_cq *ibcq)
 {
-	return to_rxxx(cq, cq);
+	return container_of(ibcq, struct rxe_cq, vcq.cq);
 }
 
 static inline struct rxe_qp *to_rqp(struct ibv_qp *ibqp)
@@ -167,6 +172,16 @@ int rxe_query_port(struct ibv_context *context, uint8_t port,
 struct ibv_pd *rxe_alloc_pd(struct ibv_context *context);
 int rxe_dealloc_pd(struct ibv_pd *pd);
 
+/* rxe_cq.c */
+struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
+			     struct ibv_comp_channel *channel,
+			     int comp_vector);
+struct ibv_cq_ex *rxe_create_cq_ex(struct ibv_context *context,
+				   struct ibv_cq_init_attr_ex *attr);
+int rxe_resize_cq(struct ibv_cq *ibcq, int cqe);
+int rxe_destroy_cq(struct ibv_cq *ibcq);
+int rxe_poll_cq(struct ibv_cq *ibcq, int ne, struct ibv_wc *wc);
+
 /* rxe_mw.c */
 struct ibv_mw *rxe_alloc_mw(struct ibv_pd *pd, enum ibv_mw_type type);
 int rxe_dealloc_mw(struct ibv_mw *mw);
diff --git a/providers/rxe/rxe_cq.c b/providers/rxe/rxe_cq.c
new file mode 100644
index 00000000..3debb1e8
--- /dev/null
+++ b/providers/rxe/rxe_cq.c
@@ -0,0 +1,449 @@
+/*
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ * Copyright (c) 2009 Mellanox Technologies Ltd. All rights reserved.
+ * Copyright (c) 2009 System Fabric Works, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *	- Redistributions of source code must retain the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer.
+ *
+ *	- Redistributions in binary form must reproduce the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer in the documentation and/or other materials
+ *	  provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <config.h>
+
+#include <endian.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <errno.h>
+
+#include <endian.h>
+#include <pthread.h>
+#include <stddef.h>
+
+#include "rxe.h"
+#include "rxe_queue.h"
+#include <rdma/rdma_user_rxe.h>
+#include "rxe-abi.h"
+
+static void advance_cur_index(struct rxe_cq *cq)
+{
+	struct rxe_queue *q = cq->queue;
+
+	cq->cur_index = (cq->cur_index + 1) & q->index_mask;
+}
+
+static int check_queue_empty(struct rxe_cq *cq)
+{
+	struct rxe_queue *q = cq->queue;
+	uint32_t producer_index = atomic_load(&q->producer_index);
+
+	return (cq->cur_index == producer_index);
+}
+
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
+	if (check_queue_empty(cq)) {
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
+	advance_cur_index(cq);
+
+	if (check_queue_empty(cq)) {
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
+	advance_cur_index(cq);
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
+/* will always be zero for RoCE */
+static uint32_t cq_read_slid(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->slid;
+}
+
+/* will always be zero for RoCE */
+static uint8_t cq_read_sl(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->sl;
+}
+
+/* will always be zero for RoCE */
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
+static uint16_t cq_read_cvlan(struct ibv_cq_ex *current)
+{
+	//struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	fprintf(stderr, "%s: TODO\n", __func__);
+
+	return 0;
+}
+
+static uint32_t cq_read_flow_tag(struct ibv_cq_ex *current)
+{
+	//struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	fprintf(stderr, "%s: TODO\n", __func__);
+
+	return 0;
+}
+
+static void cq_read_tm_info(struct ibv_cq_ex *current,
+			    struct ibv_wc_tm_info *tm_info)
+{
+	//struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+	fprintf(stderr, "%s: TODO\n", __func__);
+}
+
+static uint64_t cq_read_completion_wallclock_ns(struct ibv_cq_ex *current)
+{
+	struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
+
+	return cq->wc->realtime;
+}
+
+struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
+			     struct ibv_comp_channel *channel,
+			     int comp_vector)
+{
+	struct rxe_cq *cq;
+	struct urxe_create_cq_resp resp;
+	int ret;
+
+	cq = malloc(sizeof(*cq));
+	if (!cq)
+		return NULL;
+
+	ret = ibv_cmd_create_cq(context, cqe, channel, comp_vector,
+				&cq->vcq.cq, NULL, 0,
+				&resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		free(cq);
+		return NULL;
+	}
+
+	cq->queue = mmap(NULL, resp.mi.size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			 context->cmd_fd, resp.mi.offset);
+	if ((void *)cq->queue == MAP_FAILED) {
+		ibv_cmd_destroy_cq(&cq->vcq.cq);
+		free(cq);
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
+struct ibv_cq_ex *rxe_create_cq_ex(struct ibv_context *context,
+				   struct ibv_cq_init_attr_ex *attr)
+{
+	int ret;
+	struct rxe_cq *cq;
+	struct urxe_create_cq_ex_resp resp;
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
+	ret = ibv_cmd_create_cq_ex(context, attr, &cq->vcq, NULL, 0,
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
+		free(cq);
+		return NULL;
+	}
+
+	cq->mmap_info = resp.mi;
+	pthread_spin_init(&cq->lock, PTHREAD_PROCESS_PRIVATE);
+
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
+	if (attr->wc_flags & IBV_WC_EX_WITH_CVLAN)
+		cq->vcq.cq_ex.read_cvlan
+			= cq_read_cvlan;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_FLOW_TAG)
+		cq->vcq.cq_ex.read_flow_tag
+			= cq_read_flow_tag;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_TM_INFO)
+		cq->vcq.cq_ex.read_tm_info
+			= cq_read_tm_info;
+
+	if (attr->wc_flags & IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK)
+		cq->vcq.cq_ex.read_completion_wallclock_ns
+			= cq_read_completion_wallclock_ns;
+
+	return &cq->vcq.cq_ex;
+}
+
+int rxe_resize_cq(struct ibv_cq *ibcq, int cqe)
+{
+	struct rxe_cq *cq = to_rcq(ibcq);
+	struct ibv_resize_cq cmd;
+	struct urxe_resize_cq_resp resp;
+	int ret;
+
+	pthread_spin_lock(&cq->lock);
+
+	ret = ibv_cmd_resize_cq(ibcq, cqe, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		pthread_spin_unlock(&cq->lock);
+		return ret;
+	}
+
+	munmap(cq->queue, cq->mmap_info.size);
+
+	cq->queue = mmap(NULL, resp.mi.size,
+			 PROT_READ | PROT_WRITE, MAP_SHARED,
+			 ibcq->context->cmd_fd, resp.mi.offset);
+
+	ret = errno;
+	pthread_spin_unlock(&cq->lock);
+
+	if ((void *)cq->queue == MAP_FAILED) {
+		cq->queue = NULL;
+		cq->mmap_info.size = 0;
+		return ret;
+	}
+
+	cq->mmap_info = resp.mi;
+
+	return 0;
+}
+
+int rxe_destroy_cq(struct ibv_cq *ibcq)
+{
+	struct rxe_cq *cq = to_rcq(ibcq);
+	int ret;
+
+	ret = ibv_cmd_destroy_cq(ibcq);
+	if (ret)
+		return ret;
+
+	if (cq->mmap_info.size)
+		munmap(cq->queue, cq->mmap_info.size);
+	free(cq);
+
+	return 0;
+}
+
+int rxe_poll_cq(struct ibv_cq *ibcq, int ne, struct ibv_wc *wc)
+{
+	struct rxe_cq *cq = to_rcq(ibcq);
+	struct rxe_queue *q;
+	int npolled;
+	uint8_t *src;
+
+	pthread_spin_lock(&cq->lock);
+	q = cq->queue;
+
+	for (npolled = 0; npolled < ne; ++npolled, ++wc) {
+		if (queue_empty(q))
+			break;
+
+		atomic_thread_fence(memory_order_acquire);
+		src = consumer_addr(q);
+		memcpy(wc, src, sizeof(*wc));
+		advance_consumer(q);
+	}
+
+	pthread_spin_unlock(&cq->lock);
+	return npolled;
+}
diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
index 5c57b3e3..5ba04a7e 100644
--- a/providers/rxe/rxe_queue.h
+++ b/providers/rxe/rxe_queue.h
@@ -57,27 +57,27 @@ static inline int next_index(struct rxe_queue *q, int index)
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
@@ -86,9 +86,9 @@ static inline void advance_producer(struct rxe_queue *q)
 		q->index_mask);
 }
 
+/* Must hold consumer_index lock */
 static inline void advance_consumer(struct rxe_queue *q)
 {
-	/* Must hold consumer_index lock */
 	atomic_store(
 	    &q->consumer_index,
 	    (atomic_load_explicit(&q->consumer_index, memory_order_relaxed) +
@@ -96,18 +96,48 @@ static inline void advance_consumer(struct rxe_queue *q)
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
-- 
2.25.1

