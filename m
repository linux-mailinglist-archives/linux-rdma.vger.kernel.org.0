Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EB27082F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRV0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRV0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:26:04 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE0C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x14so8705804oic.9
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GD53LcHyiidivUrJ8x8bBuYUbtUFyfvtRMKD3f5ljok=;
        b=qgnbMf96E0ANVNiLRsYQcYWBMmK1O3pN/EmQs6+PjGBMEzKt9ahgf9OiQ/5nxdtlNQ
         pMzpXpQSYRZMxIXx8LAYGAArmDunzIashVykSFcC2fiBJUOGC08SKAZPsSrf7shyImRE
         JvvEze4UWAYGvknci6mahQVOMuU6ZSJtPjnvyNllHiN8A/cKN/cwz4TmjnunTkiBzPpZ
         mp3GEl/GxagebdyASx5HRjC/mhrTX1rmZu1Gl085Ndm36gbjF26TcODs9FoQW/teU3dH
         +doSrko8hGLZhQUDDJaTybEim7dXaCa6APztc9Xa94p8jRir3myGMK9GaEFSbDoasQ7i
         RrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GD53LcHyiidivUrJ8x8bBuYUbtUFyfvtRMKD3f5ljok=;
        b=pKvJ+vkjVK0p0XvCbk2NJMyW2GFDSJoxHcmtqiXERVKGZJ9rpXiKCW8DXRW5zwg0rk
         uqOPl0sbGzv6j6HnFS5ETtTEd5SP2T06SUEC4IjTaz37SSSoFAvIfc/WZ7nkovhM7Y6/
         x0mpK7otbOURB/7qJMy5YGUaB7d2j7ILMxBxcjX6UCasQTnzUrOB3cG6vIevuUyD0roM
         azGZ0y2xH98wFXiwY+/3fYfHDgbnHHy9cRRD3j/BwQTdycjBcF11AaAhuFF4xKmNgb2d
         S30DeF7nL/RvLzHjqZxa+kbxwuTHAFtWQ2Wud+ahxdEDz9LCeuvMusoHRNdevhORFN7y
         F4Uw==
X-Gm-Message-State: AOAM531kuN+U1LNuOiRArJugcsHBlM12yGx7lXQkBW4cy42Jf1SwEqD5
        nCAyUTC1lwQn+ABSuGADnPc=
X-Google-Smtp-Source: ABdhPJxfCVcYh5zk7y/eB0HCA8xj4fpwGyBeKkfzVtb1WLeLzaZSdE+cqz6L0GNM25AeYa76RBNBgQ==
X-Received: by 2002:aca:d549:: with SMTP id m70mr10799225oig.49.1600464363044;
        Fri, 18 Sep 2020 14:26:03 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id i7sm3862567ook.47.2020.09.18.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:26:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 4/4] rxe: add support for extended QP operations
Date:   Fri, 18 Sep 2020 16:25:57 -0500
Message-Id: <20200918212557.5446-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918212557.5446-1-rpearson@hpe.com>
References: <20200918212557.5446-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added ibv_create_qp_ex verb.
Added WQ operations in verbs_qp struct.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 providers/rxe/CMakeLists.txt |   1 +
 providers/rxe/rxe-abi.h      |   2 +
 providers/rxe/rxe.c          | 104 +----
 providers/rxe/rxe.h          |  21 +-
 providers/rxe/rxe_qp.c       | 810 +++++++++++++++++++++++++++++++++++
 5 files changed, 837 insertions(+), 101 deletions(-)
 create mode 100644 providers/rxe/rxe_qp.c

diff --git a/providers/rxe/CMakeLists.txt b/providers/rxe/CMakeLists.txt
index 0e62aae7..9d357320 100644
--- a/providers/rxe/CMakeLists.txt
+++ b/providers/rxe/CMakeLists.txt
@@ -1,6 +1,7 @@
 rdma_provider(rxe
   rxe.c
   rxe_dev.c
+  rxe_qp.c
   rxe_cq.c
   rxe_sq.c
   rxe_mw.c
diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index 14d0c038..c9dec140 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -41,6 +41,8 @@
 
 DECLARE_DRV_CMD(urxe_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
 		empty, rxe_create_qp_resp);
+DECLARE_DRV_CMD(urxe_create_qp_ex, IB_USER_VERBS_EX_CMD_CREATE_QP,
+		empty, rxe_create_qp_resp);
 DECLARE_DRV_CMD(urxe_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		empty, rxe_create_cq_resp);
 DECLARE_DRV_CMD(urxe_create_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 308d7a78..ba5db6cb 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -277,100 +277,6 @@ static int rxe_post_srq_recv(struct ibv_srq *ibvsrq,
 	return rc;
 }
 
-static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
-				    struct ibv_qp_init_attr *attr)
-{
-	struct ibv_create_qp cmd;
-	struct urxe_create_qp_resp resp;
-	struct rxe_qp *qp;
-	int ret;
-
-	qp = malloc(sizeof(*qp));
-	if (!qp)
-		return NULL;
-
-	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd, sizeof(cmd),
-				&resp.ibv_resp, sizeof(resp));
-	if (ret) {
-		free(qp);
-		return NULL;
-	}
-
-	if (attr->srq) {
-		qp->rq.max_sge = 0;
-		qp->rq.queue = NULL;
-		qp->rq_mmap_info.size = 0;
-	} else {
-		qp->rq.max_sge = attr->cap.max_recv_sge;
-		qp->rq.queue = mmap(NULL, resp.rq_mi.size, PROT_READ | PROT_WRITE,
-				    MAP_SHARED,
-				    pd->context->cmd_fd, resp.rq_mi.offset);
-		if ((void *)qp->rq.queue == MAP_FAILED) {
-			ibv_cmd_destroy_qp(&qp->ibv_qp);
-			free(qp);
-			return NULL;
-		}
-
-		qp->rq_mmap_info = resp.rq_mi;
-		pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE);
-	}
-
-	qp->sq.max_sge = attr->cap.max_send_sge;
-	qp->sq.max_inline = attr->cap.max_inline_data;
-	qp->sq.queue = mmap(NULL, resp.sq_mi.size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED,
-			    pd->context->cmd_fd, resp.sq_mi.offset);
-	if ((void *)qp->sq.queue == MAP_FAILED) {
-		if (qp->rq_mmap_info.size)
-			munmap(qp->rq.queue, qp->rq_mmap_info.size);
-		ibv_cmd_destroy_qp(&qp->ibv_qp);
-		free(qp);
-		return NULL;
-	}
-
-	qp->sq_mmap_info = resp.sq_mi;
-	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
-
-	return &qp->ibv_qp;
-}
-
-static int rxe_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
-			int attr_mask,
-			struct ibv_qp_init_attr *init_attr)
-{
-	struct ibv_query_qp cmd;
-
-	return ibv_cmd_query_qp(qp, attr, attr_mask, init_attr,
-				&cmd, sizeof(cmd));
-}
-
-static int rxe_modify_qp(struct ibv_qp *ibvqp,
-			 struct ibv_qp_attr *attr,
-			 int attr_mask)
-{
-	struct ibv_modify_qp cmd = {};
-
-	return ibv_cmd_modify_qp(ibvqp, attr, attr_mask, &cmd, sizeof(cmd));
-}
-
-static int rxe_destroy_qp(struct ibv_qp *ibv_qp)
-{
-	int ret;
-	struct rxe_qp *qp = to_rqp(ibv_qp);
-
-	ret = ibv_cmd_destroy_qp(ibv_qp);
-	if (!ret) {
-		if (qp->rq_mmap_info.size)
-			munmap(qp->rq.queue, qp->rq_mmap_info.size);
-		if (qp->sq_mmap_info.size)
-			munmap(qp->sq.queue, qp->sq_mmap_info.size);
-
-		free(qp);
-	}
-
-	return ret;
-}
-
 static int rxe_post_recv(struct ibv_qp *ibqp,
 			 struct ibv_recv_wr *recv_wr,
 			 struct ibv_recv_wr **bad_wr)
@@ -440,8 +346,9 @@ static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
 	}
 
 	ah = malloc(sizeof(*ah));
-	if (ah == NULL)
+	if (ah == NULL) {
 		return NULL;
+	}
 
 	av = &ah->av;
 	av->port_num = attr->port_num;
@@ -472,8 +379,9 @@ static int rxe_destroy_ah(struct ibv_ah *ibah)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	ret = ibv_cmd_destroy_ah(&ah->ibv_ah);
-	if (ret)
+	if (ret) {
 		return ret;
+	}
 
 	free(ah);
 	return 0;
@@ -499,7 +407,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.create_cq		= rxe_create_cq,
 	.create_flow_action_esp	= NULL,
 	.create_flow		= NULL,
-	.create_qp_ex		= NULL,
+	.create_qp_ex		= rxe_create_qp_ex,
 	.create_qp		= rxe_create_qp,
 	.create_rwq_ind_table	= NULL,
 	.create_srq_ex		= NULL,
@@ -537,7 +445,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.post_send		= rxe_post_send,
 	.post_srq_ops		= NULL,
 	.post_srq_recv		= rxe_post_srq_recv,
-	.query_device_ex	= rxe_query_device_ex,
+	.query_device_ex	= NULL,
 	.query_device		= rxe_query_device,
 	.query_ece		= NULL,
 	.query_port		= rxe_query_port,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 69ddba55..632edf5b 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -82,15 +82,19 @@ struct rxe_wq {
 };
 
 struct rxe_qp {
-	struct ibv_qp		ibv_qp;
+	struct verbs_qp		vqp;
 	struct mminfo		rq_mmap_info;
 	struct rxe_wq		rq;
 	struct mminfo		sq_mmap_info;
 	struct rxe_wq		sq;
 	unsigned int		ssn;
+
+	/* new API support */
+	uint32_t		cur_index;
+	int			err;
 };
 
-#define qp_type(qp)		((qp)->ibv_qp.qp_type)
+#define qp_type(qp)		((qp)->vqp.qp.qp_type)
 
 struct rxe_srq {
 	struct ibv_srq		ibv_srq;
@@ -137,7 +141,7 @@ static inline struct rxe_cq *to_rcq(struct ibv_cq *ibcq)
 
 static inline struct rxe_qp *to_rqp(struct ibv_qp *ibqp)
 {
-	return to_rxxx(qp, qp);
+	return container_of(ibqp, struct rxe_qp, vqp.qp);
 }
 
 static inline struct rxe_srq *to_rsrq(struct ibv_srq *ibsrq)
@@ -172,6 +176,17 @@ int rxe_query_port(struct ibv_context *context, uint8_t port,
 struct ibv_pd *rxe_alloc_pd(struct ibv_context *context);
 int rxe_dealloc_pd(struct ibv_pd *pd);
 
+/* rxe_qp.c */
+struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
+			     struct ibv_qp_init_attr *attr);
+struct ibv_qp *rxe_create_qp_ex(struct ibv_context *context,
+				struct ibv_qp_init_attr_ex *attr);
+int rxe_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
+		 int attr_mask, struct ibv_qp_init_attr *init_attr);
+int rxe_modify_qp(struct ibv_qp *ibvqp, struct ibv_qp_attr *attr,
+		  int attr_mask);
+int rxe_destroy_qp(struct ibv_qp *ibv_qp);
+
 /* rxe_cq.c */
 struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
 			     struct ibv_comp_channel *channel,
diff --git a/providers/rxe/rxe_qp.c b/providers/rxe/rxe_qp.c
new file mode 100644
index 00000000..6f0fec65
--- /dev/null
+++ b/providers/rxe/rxe_qp.c
@@ -0,0 +1,810 @@
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
+static void advance_cur_index(struct rxe_qp *qp)
+{
+	struct rxe_queue *q = qp->sq.queue;
+
+	qp->cur_index = (qp->cur_index + 1) & q->index_mask;
+}
+
+static int check_queue_full(struct rxe_qp *qp)
+{
+	struct rxe_queue *q = qp->sq.queue;
+	uint32_t consumer_index = atomic_load(&q->consumer_index);
+
+	if (qp->err)
+		goto err;
+
+	if ((qp->cur_index + 1 - consumer_index) % q->index_mask == 0)
+		qp->err = ENOSPC;
+err:
+	return qp->err;
+}
+
+/*
+ * builders always consume one send queue slot
+ * setters (below) reach back and adjust previous build
+ */
+static void wr_atomic_cmp_swp(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			      uint64_t remote_addr, uint64_t compare,
+			      uint64_t swap)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = ibqp->wr_id;
+	wqe->wr.send_flags = ibqp->wr_flags;
+	wqe->wr.opcode = IBV_WR_ATOMIC_CMP_AND_SWP;
+
+	wqe->wr.wr.atomic.remote_addr = remote_addr;
+	wqe->wr.wr.atomic.compare_add = compare;
+	wqe->wr.wr.atomic.swap = swap;
+	wqe->wr.wr.atomic.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_atomic_fetch_add(struct ibv_qp_ex *ibqp, uint32_t rkey,
+				uint64_t remote_addr, uint64_t add)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_ATOMIC_FETCH_AND_ADD;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.atomic.remote_addr = remote_addr;
+	wqe->wr.wr.atomic.compare_add = add;
+	wqe->wr.wr.atomic.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
+		       uint32_t rkey,
+		       const struct ibv_mw_bind_info *bind_info)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_mr *mr = to_rmr(bind_info->mr);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_BIND_MW;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.umw.addr = bind_info->addr;
+	wqe->wr.wr.umw.length = bind_info->length;
+	wqe->wr.wr.umw.mr_index = mr->index;
+	wqe->wr.wr.umw.mw_index = mw->index;
+	wqe->wr.wr.umw.rkey = rkey;
+	wqe->wr.wr.umw.access = bind_info->mw_access_flags;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_LOCAL_INV;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.ex.invalidate_rkey = invalidate_rkey;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_rdma_read(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			 uint64_t remote_addr)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_RDMA_READ;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.rdma.remote_addr = remote_addr;
+	wqe->wr.wr.rdma.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_rdma_write(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			  uint64_t remote_addr)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_RDMA_WRITE;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.rdma.remote_addr = remote_addr;
+	wqe->wr.wr.rdma.rkey = rkey;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_rdma_write_imm(struct ibv_qp_ex *ibqp, uint32_t rkey,
+			      uint64_t remote_addr, __be32 imm_data)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_RDMA_WRITE_WITH_IMM;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.wr.rdma.remote_addr = remote_addr;
+	wqe->wr.wr.rdma.rkey = rkey;
+	wqe->wr.ex.imm_data = (uint32_t)imm_data;
+	wqe->iova = remote_addr;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_send(struct ibv_qp_ex *ibqp)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_SEND;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_send_imm(struct ibv_qp_ex *ibqp, __be32 imm_data)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_SEND_WITH_IMM;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.ex.imm_data = (uint32_t)imm_data;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_send_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_rkey)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_SEND_WITH_INV;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->wr.ex.invalidate_rkey = invalidate_rkey;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_send_tso(struct ibv_qp_ex *ibqp, void *hdr, uint16_t hdr_sz,
+			uint16_t mss)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue, qp->cur_index);
+
+	if (check_queue_full(qp))
+		return;
+
+	memset(wqe, 0, sizeof(*wqe));
+
+	wqe->wr.wr_id = qp->vqp.qp_ex.wr_id;
+	wqe->wr.opcode = IBV_WR_TSO;
+	wqe->wr.send_flags = qp->vqp.qp_ex.wr_flags;
+	wqe->ssn = qp->ssn++;;
+
+	advance_cur_index(qp);
+
+	return;
+}
+
+static void wr_set_ud_addr(struct ibv_qp_ex *ibqp, struct ibv_ah *ibah,
+			   uint32_t remote_qpn, uint32_t remote_qkey)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_ah *ah = container_of(ibah, struct rxe_ah, ibv_ah);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	memcpy(&wqe->av, &ah->av, sizeof(ah->av));
+	wqe->wr.wr.ud.remote_qpn = remote_qpn;
+	wqe->wr.wr.ud.remote_qkey = remote_qkey;
+
+	return;
+}
+
+static void wr_set_xrc_srqn(struct ibv_qp_ex *ibqp, uint32_t remote_srqn)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	if (qp->err)
+		return;
+
+	/* TODO when we add xrc */
+
+	return;
+}
+
+
+static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
+			       size_t length)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	if (length > qp->sq.max_inline) {
+		qp->err = ENOSPC;
+		return;
+	}
+
+	memcpy(wqe->dma.inline_data, addr, length);
+	wqe->dma.length = length;
+	wqe->dma.resid = 0;
+
+	return;
+}
+
+static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
+				    const struct ibv_data_buf *buf_list)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+	uint8_t *data = wqe->dma.inline_data;
+	size_t length;
+	size_t tot_length = 0;
+
+	if (qp->err)
+		return;
+
+	while(num_buf--) {
+		length = buf_list->length;
+
+		if (tot_length + length > qp->sq.max_inline) {
+			qp->err = ENOSPC;
+			return;
+		}
+
+		memcpy(data, buf_list->addr, length);
+
+		buf_list++;
+		data += length;
+	}
+
+	wqe->dma.length = tot_length;
+
+	return;
+}
+
+static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
+		       uint32_t length)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+
+	if (qp->err)
+		return;
+
+	if (length) {
+		wqe->dma.length = length;
+		wqe->dma.resid = length;
+		wqe->dma.num_sge = 1;
+
+		wqe->dma.sge[0].addr = addr;
+		wqe->dma.sge[0].length = length;
+		wqe->dma.sge[0].lkey = lkey;
+	}
+
+	return;
+}
+
+static void wr_set_sge_list(struct ibv_qp_ex *ibqp, size_t num_sge,
+			    const struct ibv_sge *sg_list)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
+						   qp->cur_index - 1);
+	size_t tot_length = 0;
+
+	if (qp->err)
+		return;
+
+	if (num_sge > qp->sq.max_sge) {
+		qp->err = ENOSPC;
+		return;
+	}
+
+	wqe->dma.num_sge = num_sge;
+	memcpy(wqe->dma.sge, sg_list, num_sge*sizeof(*sg_list));
+
+	while(num_sge--)
+		tot_length += sg_list->length;
+
+	wqe->dma.length = tot_length;
+	wqe->dma.resid = tot_length;
+
+	return;
+}
+
+
+static void wr_start(struct ibv_qp_ex *ibqp)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	pthread_spin_lock(&qp->sq.lock);
+
+	qp->err = 0;
+	qp->cur_index = load_producer_index(qp->sq.queue);
+
+	return;
+}
+
+
+static int wr_complete(struct ibv_qp_ex *ibqp)
+{
+	int ret;
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	if (qp->err) {
+		pthread_spin_unlock(&qp->sq.lock);
+		return qp->err;
+	}
+
+	store_producer_index(qp->sq.queue, qp->cur_index);
+	ret = rxe_post_send_db(&qp->vqp.qp);
+
+	pthread_spin_unlock(&qp->sq.lock);
+	return ret;
+}
+
+static void wr_abort(struct ibv_qp_ex *ibqp)
+{
+	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
+
+	pthread_spin_unlock(&qp->sq.lock);
+	return;
+}
+
+struct ibv_qp *rxe_create_qp(struct ibv_pd *ibpd,
+			     struct ibv_qp_init_attr *attr)
+{
+	struct ibv_create_qp cmd;
+	struct urxe_create_qp_resp resp;
+	struct rxe_qp *qp;
+	int ret;
+
+	qp = malloc(sizeof(*qp));
+	if (!qp)
+		return NULL;
+
+	ret = ibv_cmd_create_qp(ibpd, &qp->vqp.qp, attr, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		free(qp);
+		return NULL;
+	}
+
+	if (attr->srq) {
+		qp->rq.max_sge = 0;
+		qp->rq.queue = NULL;
+		qp->rq_mmap_info.size = 0;
+	} else {
+		qp->rq.max_sge = attr->cap.max_recv_sge;
+		qp->rq.queue = mmap(NULL, resp.rq_mi.size, PROT_READ | PROT_WRITE,
+				    MAP_SHARED,
+				    ibpd->context->cmd_fd, resp.rq_mi.offset);
+		if ((void *)qp->rq.queue == MAP_FAILED) {
+			ibv_cmd_destroy_qp(&qp->vqp.qp);
+			free(qp);
+			return NULL;
+		}
+
+		qp->rq_mmap_info = resp.rq_mi;
+		pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE);
+	}
+
+	qp->sq.max_sge = attr->cap.max_send_sge;
+	qp->sq.max_inline = attr->cap.max_inline_data;
+	qp->sq.queue = mmap(NULL, resp.sq_mi.size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED,
+			    ibpd->context->cmd_fd, resp.sq_mi.offset);
+	if ((void *)qp->sq.queue == MAP_FAILED) {
+		if (qp->rq_mmap_info.size)
+			munmap(qp->rq.queue, qp->rq_mmap_info.size);
+		ibv_cmd_destroy_qp(&qp->vqp.qp);
+		free(qp);
+		return NULL;
+	}
+
+	qp->sq_mmap_info = resp.sq_mi;
+	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
+
+	return &qp->vqp.qp;
+}
+
+enum {
+	RXE_QP_CREATE_FLAGS_SUP = 0
+	//	| IBV_QP_CREATE_BLOCK_SELF_MCAST_LB
+	//	| IBV_QP_CREATE_SCATTER_FCS
+	//	| IBV_QP_CREATE_CVLAN_STRIPPING
+	//	| IBV_QP_CREATE_SOURCE_QPN
+	//	| IBV_QP_CREATE_PCI_WRITE_END_PADDING
+		,
+
+	RXE_QP_COMP_MASK_SUP =
+		  IBV_QP_INIT_ATTR_PD
+		| IBV_QP_INIT_ATTR_XRCD
+		| IBV_QP_INIT_ATTR_CREATE_FLAGS
+	//	| IBV_QP_INIT_ATTR_MAX_TSO_HEADER
+	//	| IBV_QP_INIT_ATTR_IND_TABLE
+	//	| IBV_QP_INIT_ATTR_RX_HASH
+		| IBV_QP_INIT_ATTR_SEND_OPS_FLAGS,
+
+	RXE_SUP_RC_QP_SEND_OPS_FLAGS =
+		  IBV_QP_EX_WITH_RDMA_WRITE
+		| IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
+		| IBV_QP_EX_WITH_SEND
+		| IBV_QP_EX_WITH_SEND_WITH_IMM
+		| IBV_QP_EX_WITH_RDMA_READ
+		| IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
+		| IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
+		| IBV_QP_EX_WITH_LOCAL_INV
+		| IBV_QP_EX_WITH_BIND_MW
+		| IBV_QP_EX_WITH_SEND_WITH_INV,
+
+	RXE_SUP_UC_QP_SEND_OPS_FLAGS =
+		  IBV_QP_EX_WITH_RDMA_WRITE
+		| IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
+		| IBV_QP_EX_WITH_SEND
+		| IBV_QP_EX_WITH_SEND_WITH_IMM
+		| IBV_QP_EX_WITH_BIND_MW
+		| IBV_QP_EX_WITH_SEND_WITH_INV,
+
+	RXE_SUP_UD_QP_SEND_OPS_FLAGS =
+		  IBV_QP_EX_WITH_SEND
+		| IBV_QP_EX_WITH_SEND_WITH_IMM,
+
+	RXE_SUP_XRC_QP_SEND_OPS_FLAGS =
+		RXE_SUP_RC_QP_SEND_OPS_FLAGS,
+};
+
+static int check_qp_init_attr(struct ibv_context *context,
+			      struct ibv_qp_init_attr_ex *attr)
+{
+	if (attr->comp_mask & ~RXE_QP_COMP_MASK_SUP)
+		return EOPNOTSUPP;
+
+	if ((attr->comp_mask & IBV_QP_INIT_ATTR_CREATE_FLAGS) &&
+	    (attr->create_flags & ~RXE_QP_CREATE_FLAGS_SUP))
+		return EOPNOTSUPP;
+
+	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS) {
+		switch(attr->qp_type) {
+		case IBV_QPT_RC:
+			if (attr->send_ops_flags & ~RXE_SUP_RC_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_UC:
+			if (attr->send_ops_flags & ~RXE_SUP_UC_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_UD:
+			if (attr->send_ops_flags & ~RXE_SUP_UD_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_RAW_PACKET:
+			return EOPNOTSUPP;
+		case IBV_QPT_XRC_SEND:
+			if (attr->send_ops_flags & ~RXE_SUP_XRC_QP_SEND_OPS_FLAGS)
+				return EOPNOTSUPP;
+			break;
+		case IBV_QPT_XRC_RECV:
+			return EOPNOTSUPP;
+		case IBV_QPT_DRIVER:
+			return EOPNOTSUPP;
+		default:
+			return EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static void set_qp_send_ops(struct rxe_qp *qp, uint64_t flags)
+{
+	if (flags & IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP)
+		qp->vqp.qp_ex.wr_atomic_cmp_swp = wr_atomic_cmp_swp;
+
+	if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
+		qp->vqp.qp_ex.wr_atomic_fetch_add = wr_atomic_fetch_add;
+
+	if (flags & IBV_QP_EX_WITH_BIND_MW)
+		qp->vqp.qp_ex.wr_bind_mw = wr_bind_mw;
+
+	if (flags & IBV_QP_EX_WITH_LOCAL_INV)
+		qp->vqp.qp_ex.wr_local_inv = wr_local_inv;
+
+	if (flags & IBV_QP_EX_WITH_RDMA_READ)
+		qp->vqp.qp_ex.wr_rdma_read = wr_rdma_read;
+
+	if (flags & IBV_QP_EX_WITH_RDMA_WRITE)
+		qp->vqp.qp_ex.wr_rdma_write = wr_rdma_write;
+
+	if (flags & IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM)
+		qp->vqp.qp_ex.wr_rdma_write_imm = wr_rdma_write_imm;
+
+	if (flags & IBV_QP_EX_WITH_SEND)
+		qp->vqp.qp_ex.wr_send = wr_send;
+
+	if (flags & IBV_QP_EX_WITH_SEND_WITH_IMM)
+		qp->vqp.qp_ex.wr_send_imm = wr_send_imm;
+
+	if (flags & IBV_QP_EX_WITH_SEND_WITH_INV)
+		qp->vqp.qp_ex.wr_send_inv = wr_send_inv;
+
+	if (flags & IBV_QP_EX_WITH_TSO)
+		qp->vqp.qp_ex.wr_send_tso = wr_send_tso;
+
+	qp->vqp.qp_ex.wr_set_ud_addr = wr_set_ud_addr;
+	qp->vqp.qp_ex.wr_set_xrc_srqn = wr_set_xrc_srqn;
+	qp->vqp.qp_ex.wr_set_inline_data = wr_set_inline_data;
+	qp->vqp.qp_ex.wr_set_inline_data_list = wr_set_inline_data_list;
+	qp->vqp.qp_ex.wr_set_sge = wr_set_sge;
+	qp->vqp.qp_ex.wr_set_sge_list = wr_set_sge_list;
+
+	qp->vqp.qp_ex.wr_start = wr_start;
+	qp->vqp.qp_ex.wr_complete = wr_complete;
+	qp->vqp.qp_ex.wr_abort = wr_abort;
+}
+
+struct ibv_qp *rxe_create_qp_ex(struct ibv_context *context,
+				struct ibv_qp_init_attr_ex *attr)
+{
+	int ret;
+	struct rxe_qp *qp;
+	struct ibv_create_qp_ex cmd = {};
+	struct urxe_create_qp_ex_resp resp = {};
+	size_t cmd_size = sizeof(cmd);
+	size_t resp_size = sizeof(resp);
+
+	ret = check_qp_init_attr(context, attr);
+	if (ret) {
+		errno = ret;
+		return NULL;
+	}
+
+	qp = calloc(1, sizeof(*qp));
+	if (!qp)
+		return NULL;
+
+	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS)
+		set_qp_send_ops(qp, attr->send_ops_flags);
+
+	ret = ibv_cmd_create_qp_ex2(context, &qp->vqp, attr,
+				    &cmd, cmd_size,
+				    &resp.ibv_resp, resp_size);
+	if (ret) {
+		free(qp);
+		return NULL;
+	}
+
+	qp->vqp.comp_mask |= VERBS_QP_EX;
+
+	if (attr->srq) {
+		qp->rq.max_sge = 0;
+		qp->rq.queue = NULL;
+		qp->rq_mmap_info.size = 0;
+	} else {
+		qp->rq.max_sge = attr->cap.max_recv_sge;
+		qp->rq.queue = mmap(NULL, resp.rq_mi.size, PROT_READ | PROT_WRITE,
+				    MAP_SHARED, context->cmd_fd, resp.rq_mi.offset);
+		if ((void *)qp->rq.queue == MAP_FAILED) {
+			ibv_cmd_destroy_qp(&qp->vqp.qp);
+			free(qp);
+			return NULL;
+		}
+
+		qp->rq_mmap_info = resp.rq_mi;
+		pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE);
+	}
+
+	qp->sq.max_sge = attr->cap.max_send_sge;
+	qp->sq.max_inline = attr->cap.max_inline_data;
+	qp->sq.queue = mmap(NULL, resp.sq_mi.size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, context->cmd_fd, resp.sq_mi.offset);
+	if ((void *)qp->sq.queue == MAP_FAILED) {
+		if (qp->rq_mmap_info.size)
+			munmap(qp->rq.queue, qp->rq_mmap_info.size);
+		ibv_cmd_destroy_qp(&qp->vqp.qp);
+		free(qp);
+		return NULL;
+	}
+
+	qp->sq_mmap_info = resp.sq_mi;
+	pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE);
+
+	return &qp->vqp.qp;
+}
+
+int rxe_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask,
+		 struct ibv_qp_init_attr *init_attr)
+{
+	struct ibv_query_qp cmd;
+
+	return ibv_cmd_query_qp(ibqp, attr, attr_mask, init_attr,
+				&cmd, sizeof(cmd));
+}
+
+int rxe_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
+		  int attr_mask)
+{
+	struct ibv_modify_qp cmd = {};
+
+	return ibv_cmd_modify_qp(ibqp, attr, attr_mask, &cmd, sizeof(cmd));
+}
+
+int rxe_destroy_qp(struct ibv_qp *ibqp)
+{
+	int ret;
+	struct rxe_qp *qp = to_rqp(ibqp);
+
+	ret = ibv_cmd_destroy_qp(ibqp);
+	if (!ret) {
+		if (qp->rq_mmap_info.size)
+			munmap(qp->rq.queue, qp->rq_mmap_info.size);
+		if (qp->sq_mmap_info.size)
+			munmap(qp->sq.queue, qp->sq_mmap_info.size);
+
+		free(qp);
+	}
+
+	return ret;
+}
-- 
2.25.1

