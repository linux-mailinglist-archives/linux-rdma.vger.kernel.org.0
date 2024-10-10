Return-Path: <linux-rdma+bounces-5352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B3E998033
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E93281586
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC481BB6B5;
	Thu, 10 Oct 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="MAOtXbeJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from va-2-31.ptr.blmpb.com (va-2-31.ptr.blmpb.com [209.127.231.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F029A2
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548003; cv=none; b=d8lrFy+G/r1HSoDx3m6ZrYxReKA9wQZqWkDobWjKLclWLmqtYE1TBTEnftD7qx/EIzwv5eqc1XUS3Nsu3R6xZ2fujQVx9T2/MB3O1KbwcO5ElzDbiCtovDnnr4DP0/7BlUNpLNTOhEx7B4XXFLQxhM63Ge3gZ4L8qXbjLZV3WQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548003; c=relaxed/simple;
	bh=RsGnTCFU6dbUYzQfq7dL3LBi6JPLR54bTcqDBCdmX+8=;
	h=To:Mime-Version:Content-Type:Subject:Message-Id:Date:Cc:From; b=h4XRsq1dNA+kF54+maI0DjIe4mQ35oYH5iN4F/hmK4aNmuV7gdekMYC6a/83eZUlFi4JaQ4bpAnL5JRnNolf7ISdkDUOt6FJyS3lKa/9DyeT9zAUcUDs3OXlA2ksTFCZrNSMzxALKtm+dT2VWp0554zJrC8HIJP5h1CPfqAFiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=MAOtXbeJ; arc=none smtp.client-ip=209.127.231.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1728547859; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=snkrJfmPXWwKIW1ZuM5Efcz9w1DZL/Y/k4rNDTlugeE=;
 b=MAOtXbeJOlTWaVrm7vJCV4m9QRp2Mm19kNHQkllP/fudnMnu8tTi/VJDMQA6dCOCmcMsWz
 C7UN1a4tBuE6M872oOmr54CFT6QRpOq/bOPa0fb12uOo9Uazo2CsJ5qzOF8lNJF3gGkfkH
 t6qJs8vfRDxXPVXayfAagKO8lzPIBQBaxj4TT4gBPQA5i+8FMr2/we4aYB6szJGWs+8L2v
 iT7vznvCPFRlsmA5F2TRkg8sMAddasn6JFKF4iUYEP10I/0/6r8QOIVmEABH3Jle9CZN+d
 SN/O8HFrqnmXHSTm+XW3r7Pe581VF5FVdL+W0rmURs1uKBnyzUYEPIiD9I9qng==
To: <leonro@nvidia.com>, <jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 4/6] libxscale: Add support for qp management
Message-Id: <20241010081049.1448826-5-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267078c12+e3ffa8+vger.kernel.org+tianx@yunsilicon.com>
Date: Thu, 10 Oct 2024 16:10:47 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 10 Oct 2024 16:10:57 +0800
Content-Transfer-Encoding: 7bit
Cc: <linux-rdma@vger.kernel.org>, "Tian Xin" <tianx@yunsilicon.com>
From: "Tian Xin" <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1

This patch adds support for following qp management verbs:
1. create_qp
2. query_qp
3. modify_qp
4. destroy_qp

Signed-off-by: Tian Xin <tianx@yunsilicon.com>
Signed-off-by: Wei Honggang <weihg@yunsilicon.com>
Signed-off-by: Zhao Qianwei <zhaoqw@yunsilicon.com>
Signed-off-by: Li Qiang <liq@yunsilicon.com>
Signed-off-by: Yan Lei <jacky@yunsilicon.com>
---
 providers/xscale/CMakeLists.txt |   1 +
 providers/xscale/cq.c           |  71 +++-
 providers/xscale/qp.c           | 110 ++++++
 providers/xscale/verbs.c        | 576 ++++++++++++++++++++++++++++++++
 providers/xscale/xscale.c       |   5 +
 providers/xscale/xscale.h       |  76 +++++
 6 files changed, 829 insertions(+), 10 deletions(-)
 create mode 100644 providers/xscale/qp.c

diff --git a/providers/xscale/CMakeLists.txt b/providers/xscale/CMakeLists.txt
index f9f17493..63de71cf 100644
--- a/providers/xscale/CMakeLists.txt
+++ b/providers/xscale/CMakeLists.txt
@@ -2,6 +2,7 @@ rdma_provider(xscale
   xscale.c
   verbs.c
   cq.c
+  qp.c
   xsc_hsi.c
   buf.c
 )
diff --git a/providers/xscale/cq.c b/providers/xscale/cq.c
index 1aeb7d33..7c528425 100644
--- a/providers/xscale/cq.c
+++ b/providers/xscale/cq.c
@@ -79,16 +79,6 @@ static inline u8 xsc_get_cqe_opcode(struct xsc_context *ctx,
 	return xsc_msg_opcode[msg_opcode][type][with_immdt];
 }
 
-struct xsc_qp *xsc_find_qp(struct xsc_context *ctx, u32 qpn)
-{
-	int tind = qpn >> XSC_QP_TABLE_SHIFT;
-
-	if (ctx->qp_table[tind].refcnt)
-		return ctx->qp_table[tind].table[qpn & XSC_QP_TABLE_MASK];
-	else
-		return NULL;
-}
-
 static inline int get_qp_ctx(struct xsc_context *xctx,
 			     struct xsc_resource **cur_rsc,
 			     u32 qpn) ALWAYS_INLINE;
@@ -520,3 +510,64 @@ void xsc_free_cq_buf(struct xsc_context *ctx, struct xsc_buf *buf)
 {
 	return xsc_free_buf(buf);
 }
+
+void __xsc_cq_clean(struct xsc_cq *cq, u32 qpn)
+{
+	u32 prod_index;
+	int nfreed = 0;
+	void *cqe, *dest;
+
+	if (!cq)
+		return;
+	xsc_dbg(to_xctx(cq->verbs_cq.cq_ex.context)->dbg_fp, XSC_DBG_CQ, "\n");
+
+	/*
+	 * First we need to find the current producer index, so we
+	 * know where to start cleaning from.  It doesn't matter if HW
+	 * adds new entries after this loop -- the QP we're worried
+	 * about is already in RESET, so the new entries won't come
+	 * from our QP and therefore don't need to be checked.
+	 */
+	for (prod_index = cq->cons_index; get_sw_cqe(cq, prod_index);
+	     ++prod_index)
+		if (prod_index == cq->cons_index + cq->verbs_cq.cq_ex.cqe)
+			break;
+
+	/*
+	 * Now sweep backwards through the CQ, removing CQ entries
+	 * that match our QP by copying older entries on top of them.
+	 */
+	while ((int)(--prod_index) - (int)cq->cons_index >= 0) {
+		u32 qp_id;
+
+		cqe = get_cqe(cq, prod_index & (cq->verbs_cq.cq_ex.cqe - 1));
+		qp_id = FIELD_GET(CQE_DATA0_QP_ID_MASK,
+				  le32toh(((struct xsc_cqe *)cqe)->data0));
+		if (qpn == qp_id) {
+			++nfreed;
+		} else if (nfreed) {
+			dest = get_cqe(cq,
+				       (prod_index + nfreed) &
+					       (cq->verbs_cq.cq_ex.cqe - 1));
+			memcpy(dest, cqe, cq->cqe_sz);
+		}
+	}
+
+	if (nfreed) {
+		cq->cons_index += nfreed;
+		/*
+		 * Make sure update of buffer contents is done before
+		 * updating consumer index.
+		 */
+		udma_to_device_barrier();
+		update_cons_index(cq);
+	}
+}
+
+void xsc_cq_clean(struct xsc_cq *cq, uint32_t qpn)
+{
+	xsc_spin_lock(&cq->lock);
+	__xsc_cq_clean(cq, qpn);
+	xsc_spin_unlock(&cq->lock);
+}
+
diff --git a/providers/xscale/qp.c b/providers/xscale/qp.c
new file mode 100644
index 00000000..7fa715c4
--- /dev/null
+++ b/providers/xscale/qp.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <config.h>
+
+#include <stdlib.h>
+#include <pthread.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+#include <util/compiler.h>
+
+#include "xscale.h"
+#include "xsc_hsi.h"
+
+struct xsc_qp *xsc_find_qp(struct xsc_context *ctx, uint32_t qpn)
+{
+	int tind = qpn >> XSC_QP_TABLE_SHIFT;
+
+	if (ctx->qp_table[tind].refcnt)
+		return ctx->qp_table[tind].table[qpn & XSC_QP_TABLE_MASK];
+	else
+		return NULL;
+}
+
+int xsc_store_qp(struct xsc_context *ctx, uint32_t qpn, struct xsc_qp *qp)
+{
+	int tind = qpn >> XSC_QP_TABLE_SHIFT;
+
+	if (!ctx->qp_table[tind].refcnt) {
+		ctx->qp_table[tind].table =
+			calloc(XSC_QP_TABLE_MASK + 1, sizeof(struct xsc_qp *));
+		if (!ctx->qp_table[tind].table)
+			return -1;
+	}
+
+	++ctx->qp_table[tind].refcnt;
+	ctx->qp_table[tind].table[qpn & XSC_QP_TABLE_MASK] = qp;
+	return 0;
+}
+
+void xsc_clear_qp(struct xsc_context *ctx, uint32_t qpn)
+{
+	int tind = qpn >> XSC_QP_TABLE_SHIFT;
+
+	if (!--ctx->qp_table[tind].refcnt)
+		free(ctx->qp_table[tind].table);
+	else
+		ctx->qp_table[tind].table[qpn & XSC_QP_TABLE_MASK] = NULL;
+}
+
+int xsc_err_state_qp(struct ibv_qp *qp, enum ibv_qp_state cur_state,
+		     enum ibv_qp_state state)
+{
+	struct xsc_err_state_qp_node *tmp, *err_rq_node, *err_sq_node;
+	struct xsc_qp *xqp = to_xqp(qp);
+	int ret = 0;
+
+	xsc_dbg(to_xctx(qp->context)->dbg_fp, XSC_DBG_QP,
+		"modify qp: qpid %d, cur_qp_state %d, qp_state %d\n",
+		xqp->rsc.rsn, cur_state, state);
+	if (cur_state == IBV_QPS_ERR && state != IBV_QPS_ERR) {
+		if (qp->recv_cq) {
+			list_for_each_safe(&to_xcq(qp->recv_cq)->err_state_qp_list,
+					   err_rq_node, tmp, entry) {
+				if (err_rq_node->qp_id == xqp->rsc.rsn) {
+					list_del(&err_rq_node->entry);
+					free(err_rq_node);
+				}
+			}
+		}
+
+		if (qp->send_cq) {
+			list_for_each_safe(&to_xcq(qp->send_cq)->err_state_qp_list,
+					   err_sq_node, tmp, entry) {
+				if (err_sq_node->qp_id == xqp->rsc.rsn) {
+					list_del(&err_sq_node->entry);
+					free(err_sq_node);
+				}
+			}
+		}
+		return ret;
+	}
+
+	if (cur_state != IBV_QPS_ERR && state == IBV_QPS_ERR) {
+		if (qp->recv_cq) {
+			err_rq_node = calloc(1, sizeof(*err_rq_node));
+			if (!err_rq_node)
+				return ENOMEM;
+			err_rq_node->qp_id = xqp->rsc.rsn;
+			err_rq_node->is_sq = false;
+			list_add_tail(&to_xcq(qp->recv_cq)->err_state_qp_list,
+				      &err_rq_node->entry);
+		}
+
+		if (qp->send_cq) {
+			err_sq_node = calloc(1, sizeof(*err_sq_node));
+			if (!err_sq_node)
+				return ENOMEM;
+			err_sq_node->qp_id = xqp->rsc.rsn;
+			err_sq_node->is_sq = true;
+			list_add_tail(&to_xcq(qp->send_cq)->err_state_qp_list,
+				      &err_sq_node->entry);
+		}
+	}
+	return ret;
+}
diff --git a/providers/xscale/verbs.c b/providers/xscale/verbs.c
index 29de7311..a72244db 100644
--- a/providers/xscale/verbs.c
+++ b/providers/xscale/verbs.c
@@ -441,3 +441,579 @@ int xsc_query_device_ex(struct ibv_context *context,
 
 	return 0;
 }
+
+static int xsc_calc_sq_size(struct xsc_context *ctx,
+			    struct ibv_qp_init_attr_ex *attr, struct xsc_qp *qp)
+{
+	int wqe_size;
+	int wq_size;
+	int wq_size_min = 0;
+
+	if (!attr->cap.max_send_wr)
+		return 0;
+
+	wqe_size = 1 << (XSC_BASE_WQE_SHIFT + ctx->send_ds_shift);
+
+	wq_size = xsc_round_up_power_of_two(attr->cap.max_send_wr);
+
+	if (attr->qp_type != IBV_QPT_RAW_PACKET)
+		wq_size_min = XSC_SEND_WQE_RING_DEPTH_MIN;
+	if (wq_size < wq_size_min) {
+		xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+			"WQE size %u is not enough, set it as %u\n", wq_size,
+			wq_size_min);
+		wq_size = wq_size_min;
+	}
+
+	if (wq_size > ctx->max_send_wr) {
+		xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+			"WQE size %u exceeds WQE ring depth, set it as %u\n",
+			wq_size, ctx->max_send_wr);
+		wq_size = ctx->max_send_wr;
+	}
+
+	qp->max_inline_data = attr->cap.max_inline_data;
+	qp->sq.wqe_cnt = wq_size;
+	qp->sq.ds_cnt = wq_size << ctx->send_ds_shift;
+	qp->sq.seg_cnt = 1 << ctx->send_ds_shift;
+	qp->sq.wqe_shift = XSC_BASE_WQE_SHIFT + ctx->send_ds_shift;
+	qp->sq.max_gs = attr->cap.max_send_sge;
+	qp->sq.max_post = qp->sq.wqe_cnt;
+	if (attr->cap.max_inline_data >
+	    (qp->sq.seg_cnt - 2) * sizeof(struct xsc_wqe_data_seg))
+		return -EINVAL;
+
+	xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+		"Send WQE count:%u, max post:%u wqe shift:%u\n", qp->sq.wqe_cnt,
+		qp->sq.max_post, qp->sq.wqe_shift);
+
+	return wqe_size * qp->sq.wqe_cnt;
+}
+
+static int xsc_calc_rq_size(struct xsc_context *ctx,
+			    struct ibv_qp_init_attr_ex *attr, struct xsc_qp *qp)
+{
+	int wqe_size;
+	int wq_size;
+	int wq_size_min = 0;
+
+	if (!attr->cap.max_recv_wr)
+		return 0;
+
+	wqe_size = 1 << (XSC_BASE_WQE_SHIFT + ctx->recv_ds_shift);
+
+	wq_size = xsc_round_up_power_of_two(attr->cap.max_recv_wr);
+	/* due to hardware limit, rdma rq depth should be
+	 * one send wqe ds num at least
+	 */
+	if (attr->qp_type != IBV_QPT_RAW_PACKET)
+		wq_size_min = ctx->send_ds_num;
+	if (wq_size < wq_size_min) {
+		xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+			"WQE size %u is not enough, set it as %u\n", wq_size,
+			wq_size_min);
+		wq_size = wq_size_min;
+	}
+
+	if (wq_size > ctx->max_recv_wr) {
+		xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+			"WQE size %u exceeds WQE ring depth, set it as %u\n",
+			wq_size, ctx->max_recv_wr);
+		wq_size = ctx->max_recv_wr;
+	}
+
+	qp->rq.wqe_cnt = wq_size;
+	qp->rq.ds_cnt = qp->rq.wqe_cnt << ctx->recv_ds_shift;
+	qp->rq.seg_cnt = 1 << ctx->recv_ds_shift;
+	qp->rq.wqe_shift = XSC_BASE_WQE_SHIFT + ctx->recv_ds_shift;
+	qp->rq.max_post = qp->rq.wqe_cnt;
+	qp->rq.max_gs = attr->cap.max_recv_sge;
+
+	xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+		"Recv WQE count:%u, max post:%u wqe shift:%u\n", qp->rq.wqe_cnt,
+		qp->rq.max_post, qp->rq.wqe_shift);
+	return wqe_size * qp->rq.wqe_cnt;
+}
+
+static int xsc_calc_wq_size(struct xsc_context *ctx,
+			    struct ibv_qp_init_attr_ex *attr, struct xsc_qp *qp)
+{
+	int ret;
+	int result;
+
+	ret = xsc_calc_sq_size(ctx, attr, qp);
+	if (ret < 0)
+		return ret;
+
+	result = ret;
+
+	ret = xsc_calc_rq_size(ctx, attr, qp);
+	if (ret < 0)
+		return ret;
+
+	result += ret;
+
+	qp->sq.offset = ret;
+	qp->rq.offset = 0;
+
+	return result;
+}
+
+static int xsc_alloc_qp_buf(struct ibv_context *context,
+			    struct ibv_qp_init_attr_ex *attr, struct xsc_qp *qp,
+			    int size)
+{
+	int err;
+
+	if (qp->sq.wqe_cnt) {
+		qp->sq.wrid = malloc(qp->sq.wqe_cnt * sizeof(*qp->sq.wrid));
+		if (!qp->sq.wrid) {
+			errno = ENOMEM;
+			err = -1;
+			return err;
+		}
+
+		qp->sq.wqe_head =
+			malloc(qp->sq.wqe_cnt * sizeof(*qp->sq.wqe_head));
+		if (!qp->sq.wqe_head) {
+			errno = ENOMEM;
+			err = -1;
+			goto ex_wrid;
+		}
+
+		qp->sq.need_flush =
+			malloc(qp->sq.wqe_cnt * sizeof(*qp->sq.need_flush));
+		if (!qp->sq.need_flush) {
+			errno = ENOMEM;
+			err = -1;
+			goto ex_wrid;
+		}
+		memset(qp->sq.need_flush, 0, qp->sq.wqe_cnt);
+
+		qp->sq.wr_opcode =
+			malloc(qp->sq.wqe_cnt * sizeof(*qp->sq.wr_opcode));
+		if (!qp->sq.wr_opcode) {
+			errno = ENOMEM;
+			err = -1;
+			goto ex_wrid;
+		}
+	}
+
+	if (qp->rq.wqe_cnt) {
+		qp->rq.wrid = malloc(qp->rq.wqe_cnt * sizeof(uint64_t));
+		if (!qp->rq.wrid) {
+			errno = ENOMEM;
+			err = -1;
+			goto ex_wrid;
+		}
+	}
+
+	err = xsc_alloc_buf(&qp->buf,
+			    align(qp->buf_size,
+				  to_xdev(context->device)->page_size),
+			    to_xdev(context->device)->page_size);
+	if (err) {
+		err = -ENOMEM;
+		goto ex_wrid;
+	}
+
+	memset(qp->buf.buf, 0, qp->buf_size);
+
+	if (attr->qp_type == IBV_QPT_RAW_PACKET) {
+		size_t aligned_sq_buf_size = align(qp->sq_buf_size,
+						   to_xdev(context->device)->page_size);
+		/* For Raw Packet QP, allocate a separate buffer for the SQ */
+		err = xsc_alloc_buf(&qp->sq_buf,
+				    aligned_sq_buf_size,
+				    to_xdev(context->device)->page_size);
+		if (err) {
+			err = -ENOMEM;
+			goto rq_buf;
+		}
+
+		memset(qp->sq_buf.buf, 0, aligned_sq_buf_size);
+	}
+
+	return 0;
+rq_buf:
+	xsc_free_buf(&qp->buf);
+ex_wrid:
+	if (qp->rq.wrid)
+		free(qp->rq.wrid);
+
+	if (qp->sq.wqe_head)
+		free(qp->sq.wqe_head);
+
+	if (qp->sq.wrid)
+		free(qp->sq.wrid);
+
+	if (qp->sq.need_flush)
+		free(qp->sq.need_flush);
+
+	if (qp->sq.wr_opcode)
+		free(qp->sq.wr_opcode);
+
+	return err;
+}
+
+static void xsc_free_qp_buf(struct xsc_context *ctx, struct xsc_qp *qp)
+{
+	xsc_free_buf(&qp->buf);
+
+	if (qp->sq_buf.buf)
+		xsc_free_buf(&qp->sq_buf);
+
+	if (qp->rq.wrid)
+		free(qp->rq.wrid);
+
+	if (qp->sq.wqe_head)
+		free(qp->sq.wqe_head);
+
+	if (qp->sq.wrid)
+		free(qp->sq.wrid);
+
+	if (qp->sq.need_flush)
+		free(qp->sq.need_flush);
+
+	if (qp->sq.wr_opcode)
+		free(qp->sq.wr_opcode);
+}
+
+enum { XSC_CREATE_QP_SUP_COMP_MASK =
+	       (IBV_QP_INIT_ATTR_PD | IBV_QP_INIT_ATTR_CREATE_FLAGS),
+};
+
+void xsc_init_qp_indices(struct xsc_qp *qp)
+{
+	qp->sq.head = 0;
+	qp->sq.tail = 0;
+	qp->rq.head = 0;
+	qp->rq.tail = 0;
+	qp->sq.cur_post = 0;
+}
+
+static struct ibv_qp *create_qp(struct ibv_context *context,
+				struct ibv_qp_init_attr_ex *attr)
+{
+	struct xsc_create_qp cmd;
+	struct xsc_create_qp_resp resp;
+	struct xsc_create_qp_ex_resp resp_ex;
+	struct xsc_qp *qp;
+	int ret;
+	struct xsc_context *ctx = to_xctx(context);
+	struct ibv_qp *ibqp;
+	struct xsc_device *xdev = to_xdev(context->device);
+
+	xsc_dbg(ctx->dbg_fp, XSC_DBG_QP, "comp_mask=0x%x.\n", attr->comp_mask);
+
+	if (attr->comp_mask & ~XSC_CREATE_QP_SUP_COMP_MASK) {
+		xsc_err("Not supported comp_mask:0x%x\n", attr->comp_mask);
+		return NULL;
+	}
+
+	/*check qp_type*/
+	if (attr->qp_type != IBV_QPT_RC &&
+	    attr->qp_type != IBV_QPT_RAW_PACKET) {
+		xsc_err("Not supported qp_type:0x%x\n", attr->qp_type);
+		return NULL;
+	}
+
+	qp = calloc(1, sizeof(*qp));
+	if (!qp) {
+		xsc_err("QP calloc failed\n");
+		return NULL;
+	}
+
+	ibqp = &qp->verbs_qp.qp;
+	qp->ibv_qp = ibqp;
+
+	memset(&cmd, 0, sizeof(cmd));
+	memset(&resp, 0, sizeof(resp));
+	memset(&resp_ex, 0, sizeof(resp_ex));
+
+	ret = xsc_calc_wq_size(ctx, attr, qp);
+	if (ret < 0) {
+		xsc_err("Calculate WQ size failed\n");
+		errno = EINVAL;
+		goto err;
+	}
+
+	qp->buf_size = ret;
+	qp->sq_buf_size = 0;
+
+	if (xsc_alloc_qp_buf(context, attr, qp, ret)) {
+		xsc_err("Alloc QP buffer failed\n");
+		errno = ENOMEM;
+		goto err;
+	}
+
+	qp->sq_start = qp->buf.buf + qp->sq.offset;
+	qp->rq_start = qp->buf.buf + qp->rq.offset;
+	qp->sq.qend = qp->buf.buf + qp->sq.offset +
+		      (qp->sq.wqe_cnt << qp->sq.wqe_shift);
+
+	xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+		"sq start:%p, sq qend:%p, buffer size:%u\n", qp->sq_start,
+		qp->sq.qend, qp->buf_size);
+
+	xsc_init_qp_indices(qp);
+
+	if (xsc_spinlock_init(&qp->sq.lock) ||
+	    xsc_spinlock_init(&qp->rq.lock))
+		goto err_free_qp_buf;
+
+	cmd.buf_addr = (uintptr_t)qp->buf.buf;
+	cmd.sq_wqe_count = qp->sq.ds_cnt;
+	cmd.rq_wqe_count = qp->rq.ds_cnt;
+	cmd.rq_wqe_shift = qp->rq.wqe_shift;
+
+	if (attr->qp_type == IBV_QPT_RAW_PACKET) {
+		if (attr->comp_mask & IBV_QP_INIT_ATTR_CREATE_FLAGS) {
+			if (attr->create_flags & XSC_QP_CREATE_RAWPACKET_TSO) {
+				cmd.flags |= XSC_QP_FLAG_RAWPACKET_TSO;
+				xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+					"revert create_flags(0x%x) to cmd_flags(0x%x)\n",
+					attr->create_flags, cmd.flags);
+			}
+
+			if (attr->create_flags & XSC_QP_CREATE_RAWPACKET_TX) {
+				cmd.flags |= XSC_QP_FLAG_RAWPACKET_TX;
+				xsc_dbg(ctx->dbg_fp, XSC_DBG_QP,
+					"revert create_flags(0x%x) to cmd_flags(0x%x)\n",
+					attr->create_flags, cmd.flags);
+			}
+			attr->comp_mask &= ~IBV_QP_INIT_ATTR_CREATE_FLAGS;
+		}
+	}
+
+	pthread_mutex_lock(&ctx->qp_table_mutex);
+
+	ret = ibv_cmd_create_qp_ex(context, &qp->verbs_qp, attr, &cmd.ibv_cmd,
+				   sizeof(cmd), &resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		xsc_err("ibv_cmd_create_qp_ex failed,ret %d\n", ret);
+		errno = ret;
+		goto err_free_qp_buf;
+	}
+
+	if (qp->sq.wqe_cnt || qp->rq.wqe_cnt) {
+		ret = xsc_store_qp(ctx, ibqp->qp_num, qp);
+		if (ret) {
+			xsc_err("xsc_store_qp failed,ret %d\n", ret);
+			errno = EINVAL;
+			goto err_destroy;
+		}
+	}
+
+	pthread_mutex_unlock(&ctx->qp_table_mutex);
+
+	qp->rq.max_post = qp->rq.wqe_cnt;
+
+	if (attr->sq_sig_all)
+		qp->sq_signal_bits = 1;
+	else
+		qp->sq_signal_bits = 0;
+
+	attr->cap.max_send_wr = qp->sq.max_post;
+	attr->cap.max_recv_wr = qp->rq.max_post;
+	attr->cap.max_recv_sge = qp->rq.max_gs;
+
+	qp->rsc.rsn = ibqp->qp_num;
+
+	qp->rqn = ibqp->qp_num;
+	qp->sqn = ibqp->qp_num;
+
+	xsc_dbg(ctx->dbg_fp, XSC_DBG_QP, "qp rqn:%u, sqn:%u\n", qp->rqn,
+		qp->sqn);
+	qp->sq.db = ctx->sqm_reg_va + (ctx->qpm_tx_db & (xdev->page_size - 1));
+	qp->rq.db = ctx->rqm_reg_va + (ctx->qpm_rx_db & (xdev->page_size - 1));
+
+	if (attr->comp_mask & IBV_QP_INIT_ATTR_SEND_OPS_FLAGS)
+		qp->verbs_qp.comp_mask |= VERBS_QP_EX;
+
+	return ibqp;
+
+err_destroy:
+	ibv_cmd_destroy_qp(ibqp);
+
+err_free_qp_buf:
+	pthread_mutex_unlock(&to_xctx(context)->qp_table_mutex);
+	xsc_free_qp_buf(ctx, qp);
+
+err:
+	free(qp);
+
+	return NULL;
+}
+
+struct ibv_qp *xsc_create_qp(struct ibv_pd *pd, struct ibv_qp_init_attr *attr)
+{
+	struct ibv_qp *qp;
+	struct ibv_qp_init_attr_ex attrx;
+
+	memset(&attrx, 0, sizeof(attrx));
+	memcpy(&attrx, attr, sizeof(*attr));
+	attrx.comp_mask = IBV_QP_INIT_ATTR_PD;
+	attrx.pd = pd;
+	qp = create_qp(pd->context, &attrx);
+	if (qp)
+		memcpy(attr, &attrx, sizeof(*attr));
+
+	return qp;
+}
+
+static void xsc_lock_cqs(struct ibv_qp *qp)
+{
+	struct xsc_cq *send_cq = to_xcq(qp->send_cq);
+	struct xsc_cq *recv_cq = to_xcq(qp->recv_cq);
+
+	if (send_cq && recv_cq) {
+		if (send_cq == recv_cq) {
+			xsc_spin_lock(&send_cq->lock);
+		} else if (send_cq->cqn < recv_cq->cqn) {
+			xsc_spin_lock(&send_cq->lock);
+			xsc_spin_lock(&recv_cq->lock);
+		} else {
+			xsc_spin_lock(&recv_cq->lock);
+			xsc_spin_lock(&send_cq->lock);
+		}
+	} else if (send_cq) {
+		xsc_spin_lock(&send_cq->lock);
+	} else if (recv_cq) {
+		xsc_spin_lock(&recv_cq->lock);
+	}
+}
+
+static void xsc_unlock_cqs(struct ibv_qp *qp)
+{
+	struct xsc_cq *send_cq = to_xcq(qp->send_cq);
+	struct xsc_cq *recv_cq = to_xcq(qp->recv_cq);
+
+	if (send_cq && recv_cq) {
+		if (send_cq == recv_cq) {
+			xsc_spin_unlock(&send_cq->lock);
+		} else if (send_cq->cqn < recv_cq->cqn) {
+			xsc_spin_unlock(&recv_cq->lock);
+			xsc_spin_unlock(&send_cq->lock);
+		} else {
+			xsc_spin_unlock(&send_cq->lock);
+			xsc_spin_unlock(&recv_cq->lock);
+		}
+	} else if (send_cq) {
+		xsc_spin_unlock(&send_cq->lock);
+	} else if (recv_cq) {
+		xsc_spin_unlock(&recv_cq->lock);
+	}
+}
+
+int xsc_destroy_qp(struct ibv_qp *ibqp)
+{
+	struct xsc_qp *qp = to_xqp(ibqp);
+	struct xsc_context *ctx = to_xctx(ibqp->context);
+	int ret;
+	struct xsc_err_state_qp_node *tmp, *err_rq_node, *err_sq_node;
+
+	xsc_dbg(ctx->dbg_fp, XSC_DBG_QP, "\n");
+
+	pthread_mutex_lock(&ctx->qp_table_mutex);
+
+	ret = ibv_cmd_destroy_qp(ibqp);
+	if (ret) {
+		pthread_mutex_unlock(&ctx->qp_table_mutex);
+		return ret;
+	}
+
+	xsc_lock_cqs(ibqp);
+
+	list_for_each_safe(&to_xcq(ibqp->recv_cq)->err_state_qp_list,
+			   err_rq_node, tmp, entry) {
+		if (err_rq_node->qp_id == qp->rsc.rsn) {
+			list_del(&err_rq_node->entry);
+			free(err_rq_node);
+		}
+	}
+
+	list_for_each_safe(&to_xcq(ibqp->send_cq)->err_state_qp_list,
+			   err_sq_node, tmp, entry) {
+		if (err_sq_node->qp_id == qp->rsc.rsn) {
+			list_del(&err_sq_node->entry);
+			free(err_sq_node);
+		}
+	}
+
+	__xsc_cq_clean(to_xcq(ibqp->recv_cq), qp->rsc.rsn);
+	if (ibqp->send_cq != ibqp->recv_cq)
+		__xsc_cq_clean(to_xcq(ibqp->send_cq), qp->rsc.rsn);
+
+	if (qp->sq.wqe_cnt || qp->rq.wqe_cnt)
+		xsc_clear_qp(ctx, ibqp->qp_num);
+
+	xsc_unlock_cqs(ibqp);
+	pthread_mutex_unlock(&ctx->qp_table_mutex);
+
+	xsc_free_qp_buf(ctx, qp);
+
+	free(qp);
+
+	return 0;
+}
+
+int xsc_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask,
+		 struct ibv_qp_init_attr *init_attr)
+{
+	struct ibv_query_qp cmd;
+	struct xsc_qp *qp = to_xqp(ibqp);
+	int ret;
+
+	xsc_dbg(to_xctx(ibqp->context)->dbg_fp, XSC_DBG_QP, "\n");
+
+	if (qp->rss_qp)
+		return EOPNOTSUPP;
+
+	ret = ibv_cmd_query_qp(ibqp, attr, attr_mask, init_attr, &cmd,
+			       sizeof(cmd));
+	if (ret)
+		return ret;
+
+	init_attr->cap.max_send_wr = qp->sq.max_post;
+	init_attr->cap.max_send_sge = qp->sq.max_gs;
+	init_attr->cap.max_inline_data = qp->max_inline_data;
+
+	attr->cap = init_attr->cap;
+	attr->qp_state = qp->ibv_qp->state;
+
+	return 0;
+}
+
+enum { XSC_MODIFY_QP_EX_ATTR_MASK = IBV_QP_RATE_LIMIT,
+};
+
+int xsc_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr, int attr_mask)
+{
+	struct ibv_modify_qp cmd = {};
+	struct xsc_qp *xqp = to_xqp(qp);
+	int ret;
+
+	xsc_dbg(to_xctx(qp->context)->dbg_fp, XSC_DBG_QP, "\n");
+	ret = ibv_cmd_modify_qp(qp, attr, attr_mask, &cmd, sizeof(cmd));
+
+	if (!ret && (attr_mask & IBV_QP_STATE) &&
+	    attr->qp_state == IBV_QPS_RESET) {
+		if (qp->recv_cq)
+			xsc_cq_clean(to_xcq(qp->recv_cq), xqp->rsc.rsn);
+
+		if (qp->send_cq != qp->recv_cq && qp->send_cq)
+			xsc_cq_clean(to_xcq(qp->send_cq), to_xqp(qp)->rsc.rsn);
+
+		xsc_init_qp_indices(xqp);
+	}
+
+	if (!ret && (attr_mask & IBV_QP_STATE))
+		qp->state = attr->qp_state;
+
+	/*workaround: generate flush err cqe if qp status turns to ERR*/
+	if (!ret && (attr_mask & IBV_QP_STATE))
+		ret = xsc_err_state_qp(qp, attr->cur_qp_state, attr->qp_state);
+
+	return ret;
+}
diff --git a/providers/xscale/xscale.c b/providers/xscale/xscale.c
index 7b439f78..4d048629 100644
--- a/providers/xscale/xscale.c
+++ b/providers/xscale/xscale.c
@@ -47,6 +47,11 @@ static const struct verbs_context_ops xsc_ctx_common_ops = {
 	.req_notify_cq = xsc_arm_cq,
 	.resize_cq = xsc_resize_cq,
 	.destroy_cq = xsc_destroy_cq,
+
+	.create_qp = xsc_create_qp,
+	.query_qp = xsc_query_qp,
+	.modify_qp = xsc_modify_qp,
+	.destroy_qp = xsc_destroy_qp,
 };
 
 static void open_debug_file(struct xsc_context *ctx)
diff --git a/providers/xscale/xscale.h b/providers/xscale/xscale.h
index 1955f98d..7088e5f4 100644
--- a/providers/xscale/xscale.h
+++ b/providers/xscale/xscale.h
@@ -27,6 +27,16 @@ typedef uint16_t  u16;
 typedef uint32_t  u32;
 typedef uint64_t  u64;
 
+enum {
+	XSC_QP_FLAG_RAWPACKET_TSO = 1 << 9,
+	XSC_QP_FLAG_RAWPACKET_TX = 1 << 10,
+};
+
+enum xsc_qp_create_flags {
+	XSC_QP_CREATE_RAWPACKET_TSO = 1 << 0,
+	XSC_QP_CREATE_RAWPACKET_TX = 1 << 1,
+};
+
 enum {
 	XSC_DBG_QP = 1 << 0,
 	XSC_DBG_CQ = 1 << 1,
@@ -169,11 +179,56 @@ struct xsc_cq {
 	struct list_head err_state_qp_list;
 };
 
+struct xsc_wq {
+	u64 *wrid;
+	unsigned int *wqe_head;
+	struct xsc_spinlock lock;
+	unsigned int wqe_cnt;
+	unsigned int max_post;
+	unsigned int head;
+	unsigned int tail;
+	unsigned int cur_post;
+	int max_gs;
+	int wqe_shift;
+	int offset;
+	void *qend;
+	__le32 *db;
+	unsigned int ds_cnt;
+	unsigned int seg_cnt;
+	unsigned int *wr_opcode;
+	unsigned int *need_flush;
+	unsigned int flush_wqe_cnt;
+};
+
 struct xsc_mr {
 	struct verbs_mr vmr;
 	u32 alloc_flags;
 };
 
+struct xsc_qp {
+	struct xsc_resource rsc; /* This struct must be first */
+	struct verbs_qp verbs_qp;
+	struct ibv_qp *ibv_qp;
+	struct xsc_buf buf;
+	void *sq_start;
+	void *rq_start;
+	int max_inline_data;
+	int buf_size;
+	/* For Raw Packet QP, use different buffers for the SQ and RQ */
+	struct xsc_buf sq_buf;
+	int sq_buf_size;
+
+	u8 sq_signal_bits;
+	struct xsc_wq sq;
+	struct xsc_wq rq;
+	u32 max_tso;
+	u16 max_tso_header;
+	int rss_qp;
+	u32 flags; /* Use enum xsc_qp_flags */
+	u32 rqn;
+	u32 sqn;
+};
+
 union xsc_ib_fw_ver {
 	u64 data;
 	struct {
@@ -220,6 +275,13 @@ static inline struct xsc_cq *to_xcq(struct ibv_cq *ibcq)
 			    verbs_cq.cq_ex);
 }
 
+static inline struct xsc_qp *to_xqp(struct ibv_qp *ibqp)
+{
+	struct verbs_qp *vqp = (struct verbs_qp *)ibqp;
+
+	return container_of(vqp, struct xsc_qp, verbs_qp);
+}
+
 static inline struct xsc_mr *to_xmr(struct ibv_mr *ibmr)
 {
 	return container_of(ibmr, struct xsc_mr, vmr.ibv_mr);
@@ -259,6 +321,20 @@ int xsc_poll_cq(struct ibv_cq *cq, int ne, struct ibv_wc *wc);
 int xsc_arm_cq(struct ibv_cq *cq, int solicited);
 void __xsc_cq_clean(struct xsc_cq *cq, u32 qpn);
 void xsc_cq_clean(struct xsc_cq *cq, u32 qpn);
+
+struct ibv_qp *xsc_create_qp_ex(struct ibv_context *context,
+				struct ibv_qp_init_attr_ex *attr);
+struct ibv_qp *xsc_create_qp(struct ibv_pd *pd, struct ibv_qp_init_attr *attr);
+int xsc_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr, int attr_mask,
+		 struct ibv_qp_init_attr *init_attr);
+int xsc_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr, int attr_mask);
+int xsc_destroy_qp(struct ibv_qp *qp);
+void xsc_init_qp_indices(struct xsc_qp *qp);
+struct xsc_qp *xsc_find_qp(struct xsc_context *ctx, u32 qpn);
+int xsc_store_qp(struct xsc_context *ctx, u32 qpn, struct xsc_qp *qp);
+void xsc_clear_qp(struct xsc_context *ctx, u32 qpn);
+int xsc_err_state_qp(struct ibv_qp *qp, enum ibv_qp_state cur_state,
+		     enum ibv_qp_state state);
 int xsc_round_up_power_of_two(long long sz);
 void *xsc_get_send_wqe(struct xsc_qp *qp, int n);
 
-- 
2.25.1

