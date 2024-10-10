Return-Path: <linux-rdma+bounces-5354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE7998066
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147BC1C255BF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88EC1CDA39;
	Thu, 10 Oct 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="PdUdSWiA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from lf-1-16.ptr.blmpb.com (lf-1-16.ptr.blmpb.com [103.149.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084D1CDA2D
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548615; cv=none; b=Wg3J+QQokzPG/KysDuOjVpBICsookHLZFDGovpzxWJ9G8Sv5GpBLtKsJbHtwaZfZJxf221CHKWXz3M3EdBHO3slK/UX/91rUVnhCfniSmgWfKIIJr/QuqypwPAE5DeIlG/C3cNxP/QlqWOz6uYyYn9lvxtu3EBLh6Hb89+NJTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548615; c=relaxed/simple;
	bh=TINE+Vq+SYDET2zahDnuQvMwp22sBEn4Zr7rz0uNHB0=;
	h=Subject:Message-Id:Date:To:From:Cc:Mime-Version:Content-Type; b=Yz+uiH6WOgDu6pbii0y+NSfxTIYFUeSyADt0dY6IMK4s2ZO2Otesv5qHg1xSzBBRMM4KD+B6Gdlb96w4uE2HYCC48IKVjOMOWw0RupY1TqlP3qS3h5kKngoewNn9QiD+GyF1jTqUdfQ7e2ezh/REWrvw19UziQH7X2vmTzEjeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=PdUdSWiA; arc=none smtp.client-ip=103.149.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1728547857; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+G/xUd2rzd9gOJbMSfGfZUlmJc6qiLTfGruPgFaPHl4=;
 b=PdUdSWiAudVWSroeZmE6d21Mxvj6YBHUxT71ETN5Bq4he+OCBX1myJNAWtKM2Ecqce5oj5
 Y1/aOFojFVMd4/dgKNFGGaWqwG1+lHBnndtEBk9oepDfzPgtxBGgsYf8Vdj50GA6SmLr6D
 xG45/C1uJ74Btp9Ko1Ykf2mAsXdwjNdf1hr96dtQUo4sdfoyoqMm2eRSjG/pgFQfKc7RB5
 7wVT6b4oiKBsLeVbVBUG8h6r2ztBVdB3dtRhmMF5CMMuVSL6sppSLaTFxH5Ygl9XQtExvF
 LxpaZQiKiw6j+eYOAVwXzgjK1iFh2fRz+/XoNDTI+0Ea55nxT1rA58Rj4Bf1Fg==
Subject: [PATCH 3/6] libxscale: Add support for cq related verbs
Message-Id: <20241010081049.1448826-4-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267078c10+a441a4+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Oct 2024 16:10:46 +0800
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 10 Oct 2024 16:10:55 +0800
X-Mailer: git-send-email 2.25.1
To: <leonro@nvidia.com>, <jgg@nvidia.com>
From: "Tian Xin" <tianx@yunsilicon.com>
Cc: <linux-rdma@vger.kernel.org>, "Tian Xin" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

This patch adds support for the following cq verbs:
1. create_cq
2. poll_cq
3. req_notify_cq
4. resize_cq
5. destroy_cq

Signed-off-by: Tian Xin <tianx@yunsilicon.com>
Signed-off-by: Wei Honggang <weihg@yunsilicon.com>
Signed-off-by: Zhao Qianwei <zhaoqw@yunsilicon.com>
Signed-off-by: Li Qiang <liq@yunsilicon.com>
Signed-off-by: Yan Lei <jacky@yunsilicon.com>
---
 providers/xscale/CMakeLists.txt |   3 +
 providers/xscale/buf.c          |  42 +++
 providers/xscale/cq.c           | 522 ++++++++++++++++++++++++++++++++
 providers/xscale/verbs.c        | 283 +++++++++++++++++
 providers/xscale/xsc_hsi.c      |  96 ++++++
 providers/xscale/xsc_hsi.h      | 178 +++++++++++
 providers/xscale/xscale.c       |  13 +-
 providers/xscale/xscale.h       |  92 ++++++
 8 files changed, 1227 insertions(+), 2 deletions(-)
 create mode 100644 providers/xscale/buf.c
 create mode 100644 providers/xscale/cq.c
 create mode 100644 providers/xscale/xsc_hsi.c
 create mode 100644 providers/xscale/xsc_hsi.h

diff --git a/providers/xscale/CMakeLists.txt b/providers/xscale/CMakeLists.txt
index cfd05b49..f9f17493 100644
--- a/providers/xscale/CMakeLists.txt
+++ b/providers/xscale/CMakeLists.txt
@@ -1,4 +1,7 @@
 rdma_provider(xscale
   xscale.c
   verbs.c
+  cq.c
+  xsc_hsi.c
+  buf.c
 )
diff --git a/providers/xscale/buf.c b/providers/xscale/buf.c
new file mode 100644
index 00000000..2096cef6
--- /dev/null
+++ b/providers/xscale/buf.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <config.h>
+
+#include <signal.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "util/util.h"
+#include "xscale.h"
+
+int xsc_alloc_buf(struct xsc_buf *buf, size_t size, int page_size)
+{
+	int ret;
+	int al_size;
+
+	al_size = align(size, page_size);
+	ret = posix_memalign(&buf->buf, page_size, al_size);
+	if (ret)
+		return ret;
+
+	ret = ibv_dontfork_range(buf->buf, al_size);
+	if (ret)
+		free(buf->buf);
+
+	buf->length = al_size;
+
+	return ret;
+}
+
+void xsc_free_buf(struct xsc_buf *buf)
+{
+	ibv_dofork_range(buf->buf, buf->length);
+	free(buf->buf);
+}
diff --git a/providers/xscale/cq.c b/providers/xscale/cq.c
new file mode 100644
index 00000000..1aeb7d33
--- /dev/null
+++ b/providers/xscale/cq.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <config.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <pthread.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <util/compiler.h>
+#include <infiniband/opcode.h>
+
+#include "xscale.h"
+#include "xsc_hsi.h"
+
+enum { CQ_OK = 0, CQ_EMPTY = -1, CQ_POLL_ERR = -2 };
+
+static const u32 xsc_msg_opcode[][2][2] = {
+	[XSC_MSG_OPCODE_SEND][XSC_REQ][XSC_WITHOUT_IMMDT] =
+		XSC_OPCODE_RDMA_REQ_SEND,
+	[XSC_MSG_OPCODE_SEND][XSC_REQ][XSC_WITH_IMMDT] =
+		XSC_OPCODE_RDMA_REQ_SEND_IMMDT,
+	[XSC_MSG_OPCODE_SEND][XSC_RSP][XSC_WITHOUT_IMMDT] =
+		XSC_OPCODE_RDMA_RSP_RECV,
+	[XSC_MSG_OPCODE_SEND][XSC_RSP][XSC_WITH_IMMDT] =
+		XSC_OPCODE_RDMA_RSP_RECV_IMMDT,
+	[XSC_MSG_OPCODE_RDMA_WRITE][XSC_REQ][XSC_WITHOUT_IMMDT] =
+		XSC_OPCODE_RDMA_REQ_WRITE,
+	[XSC_MSG_OPCODE_RDMA_WRITE][XSC_REQ][XSC_WITH_IMMDT] =
+		XSC_OPCODE_RDMA_REQ_WRITE_IMMDT,
+	[XSC_MSG_OPCODE_RDMA_WRITE][XSC_RSP][XSC_WITHOUT_IMMDT] =
+		XSC_OPCODE_RDMA_CQE_ERROR,
+	[XSC_MSG_OPCODE_RDMA_WRITE][XSC_RSP][XSC_WITH_IMMDT] =
+		XSC_OPCODE_RDMA_RSP_WRITE_IMMDT,
+	[XSC_MSG_OPCODE_RDMA_READ][XSC_REQ][XSC_WITHOUT_IMMDT] =
+		XSC_OPCODE_RDMA_REQ_READ,
+	[XSC_MSG_OPCODE_RDMA_READ][XSC_REQ][XSC_WITH_IMMDT] =
+		XSC_OPCODE_RDMA_CQE_ERROR,
+	[XSC_MSG_OPCODE_RDMA_READ][XSC_RSP][XSC_WITHOUT_IMMDT] =
+		XSC_OPCODE_RDMA_CQE_ERROR,
+	[XSC_MSG_OPCODE_RDMA_READ][XSC_RSP][XSC_WITH_IMMDT] =
+		XSC_OPCODE_RDMA_CQE_ERROR,
+};
+
+static const u32 xsc_cqe_opcode[] = {
+	[XSC_OPCODE_RDMA_REQ_SEND] = IBV_WC_SEND,
+	[XSC_OPCODE_RDMA_REQ_SEND_IMMDT] = IBV_WC_SEND,
+	[XSC_OPCODE_RDMA_RSP_RECV] = IBV_WC_RECV,
+	[XSC_OPCODE_RDMA_RSP_RECV_IMMDT] = IBV_WC_RECV,
+	[XSC_OPCODE_RDMA_REQ_WRITE] = IBV_WC_RDMA_WRITE,
+	[XSC_OPCODE_RDMA_REQ_WRITE_IMMDT] = IBV_WC_RDMA_WRITE,
+	[XSC_OPCODE_RDMA_RSP_WRITE_IMMDT] = IBV_WC_RECV_RDMA_WITH_IMM,
+	[XSC_OPCODE_RDMA_REQ_READ] = IBV_WC_RDMA_READ,
+};
+
+static inline u8 xsc_get_cqe_opcode(struct xsc_context *ctx,
+				    struct xsc_cqe *cqe) ALWAYS_INLINE;
+static inline u8 xsc_get_cqe_opcode(struct xsc_context *ctx,
+				    struct xsc_cqe *cqe)
+{
+	u8 msg_opcode = ctx->hw_ops->get_cqe_msg_opcode(cqe);
+	u8 type = FIELD_GET(CQE_DATA0_TYPE_MASK, le32toh(cqe->data0));
+	u8 with_immdt = FIELD_GET(CQE_DATA0_WITH_IMMDT_MASK,
+				  le32toh(cqe->data0));
+
+	if (ctx->hw_ops->is_err_cqe(cqe))
+		return type ? XSC_OPCODE_RDMA_RSP_ERROR :
+				   XSC_OPCODE_RDMA_REQ_ERROR;
+	if (msg_opcode > XSC_MSG_OPCODE_RDMA_READ) {
+		printf("rdma cqe msg code should be send/write/read\n");
+		return XSC_OPCODE_RDMA_CQE_ERROR;
+	}
+	return xsc_msg_opcode[msg_opcode][type][with_immdt];
+}
+
+struct xsc_qp *xsc_find_qp(struct xsc_context *ctx, u32 qpn)
+{
+	int tind = qpn >> XSC_QP_TABLE_SHIFT;
+
+	if (ctx->qp_table[tind].refcnt)
+		return ctx->qp_table[tind].table[qpn & XSC_QP_TABLE_MASK];
+	else
+		return NULL;
+}
+
+static inline int get_qp_ctx(struct xsc_context *xctx,
+			     struct xsc_resource **cur_rsc,
+			     u32 qpn) ALWAYS_INLINE;
+static inline int get_qp_ctx(struct xsc_context *xctx,
+			     struct xsc_resource **cur_rsc, u32 qpn)
+{
+	if (!*cur_rsc || (qpn != (*cur_rsc)->rsn)) {
+		/*
+		 * We do not have to take the QP table lock here,
+		 * because CQs will be locked while QPs are removed
+		 * from the table.
+		 */
+		*cur_rsc = (struct xsc_resource *)xsc_find_qp(xctx, qpn);
+		if (unlikely(!*cur_rsc))
+			return CQ_POLL_ERR;
+	}
+
+	return CQ_OK;
+}
+
+static void *get_cqe(struct xsc_cq *cq, int n)
+{
+	return cq->active_buf->buf + n * cq->cqe_sz;
+}
+
+static void *get_sw_cqe(struct xsc_cq *cq, int n)
+{
+	int cid = n & (cq->verbs_cq.cq_ex.cqe - 1);
+	struct xsc_cqe *cqe = get_cqe(cq, cid);
+
+	if (likely(xsc_get_cqe_sw_own(cqe, n, cq->log2_cq_ring_sz)))
+		return cqe;
+	else
+		return NULL;
+}
+
+void *xsc_get_send_wqe(struct xsc_qp *qp, int n)
+{
+	return qp->sq_start + (n << qp->sq.wqe_shift);
+}
+
+static void update_cons_index(struct xsc_cq *cq)
+{
+	struct xsc_context *ctx =
+		to_xctx(ibv_cq_ex_to_cq(&cq->verbs_cq.cq_ex)->context);
+
+	ctx->hw_ops->set_cq_ci(cq->db, cq->cqn, cq->cons_index);
+}
+
+static void dump_cqe(void *buf)
+{
+	__le32 *p = buf;
+	int i;
+
+	for (i = 0; i < 8; i += 4)
+		printf("0x%08x 0x%08x 0x%08x 0x%08x\n", p[i], p[i + 1],
+		       p[i + 2], p[i + 3]);
+}
+
+static enum ibv_wc_status xsc_cqe_error_code(u8 error_code)
+{
+	switch (error_code) {
+	case XSC_ERR_CODE_NAK_RETRY:
+		return IBV_WC_RETRY_EXC_ERR;
+	case XSC_ERR_CODE_NAK_OPCODE:
+		return IBV_WC_REM_INV_REQ_ERR;
+	case XSC_ERR_CODE_NAK_MR:
+		return IBV_WC_REM_ACCESS_ERR;
+	case XSC_ERR_CODE_NAK_OPERATION:
+		return IBV_WC_REM_OP_ERR;
+	case XSC_ERR_CODE_NAK_RNR:
+		return IBV_WC_RNR_RETRY_EXC_ERR;
+	case XSC_ERR_CODE_LOCAL_MR:
+		return IBV_WC_LOC_PROT_ERR;
+	case XSC_ERR_CODE_LOCAL_LEN:
+		return IBV_WC_LOC_LEN_ERR;
+	case XSC_ERR_CODE_LEN_GEN_CQE:
+		return IBV_WC_LOC_LEN_ERR;
+	case XSC_ERR_CODE_OPERATION:
+		return IBV_WC_LOC_ACCESS_ERR;
+	case XSC_ERR_CODE_FLUSH:
+		return IBV_WC_WR_FLUSH_ERR;
+	case XSC_ERR_CODE_MALF_WQE_HOST:
+	case XSC_ERR_CODE_STRG_ACC_GEN_CQE:
+	case XSC_ERR_CODE_STRG_ACC:
+		return IBV_WC_FATAL_ERR;
+	case XSC_ERR_CODE_MR_GEN_CQE:
+		return IBV_WC_LOC_PROT_ERR;
+	case XSC_ERR_CODE_OPCODE_GEN_CQE:
+	case XSC_ERR_CODE_LOCAL_OPCODE:
+	default:
+		return IBV_WC_GENERAL_ERR;
+	}
+}
+
+static inline void handle_good_req(struct ibv_wc *wc, struct xsc_cqe *cqe,
+				   struct xsc_qp *qp, struct xsc_wq *wq,
+				   u8 opcode)
+{
+	int idx;
+	struct xsc_send_wqe_ctrl_seg *ctrl;
+
+	wc->opcode = xsc_cqe_opcode[opcode];
+	wc->status = IBV_WC_SUCCESS;
+	idx = FIELD_GET(CQE_DATA1_WQE_ID_MASK, le64toh(cqe->data1));
+	idx >>= (qp->sq.wqe_shift - XSC_BASE_WQE_SHIFT);
+	idx &= (wq->wqe_cnt - 1);
+	wc->wr_id = wq->wrid[idx];
+	wq->tail = wq->wqe_head[idx] + 1;
+	if (opcode == XSC_OPCODE_RDMA_REQ_READ) {
+		ctrl = xsc_get_send_wqe(qp, idx);
+		wc->byte_len = le32toh(ctrl->msg_len);
+	}
+	wq->flush_wqe_cnt--;
+
+	xsc_dbg(to_xctx(qp->ibv_qp->context)->dbg_fp, XSC_DBG_CQ_CQE,
+		"wqeid:%u, wq tail:%u\n", idx, wq->tail);
+}
+
+static inline void handle_good_responder(struct ibv_wc *wc, struct xsc_cqe *cqe,
+					 struct xsc_wq *wq, u8 opcode)
+{
+	u16 idx;
+	struct xsc_qp *qp = container_of(wq, struct xsc_qp, rq);
+
+	wc->byte_len = le32toh(cqe->msg_len);
+	wc->opcode = xsc_cqe_opcode[opcode];
+	wc->status = IBV_WC_SUCCESS;
+
+	idx = wq->tail & (wq->wqe_cnt - 1);
+	wc->wr_id = wq->wrid[idx];
+	++wq->tail;
+	wq->flush_wqe_cnt--;
+
+	xsc_dbg(to_xctx(qp->ibv_qp->context)->dbg_fp, XSC_DBG_CQ_CQE,
+		"recv cqe idx:%u, len:%u\n", idx, wc->byte_len);
+}
+
+static inline void handle_bad_req(struct xsc_context *xctx, struct ibv_wc *wc,
+				  struct xsc_cqe *cqe, struct xsc_qp *qp,
+				  struct xsc_wq *wq)
+{
+	int idx;
+	u8 error_code = xctx->hw_ops->get_cqe_error_code(cqe);
+
+	wc->status = xsc_cqe_error_code(error_code);
+	wc->vendor_err = error_code;
+	idx = FIELD_GET(CQE_DATA1_WQE_ID_MASK, le64toh(cqe->data1));
+	idx >>= (qp->sq.wqe_shift - XSC_BASE_WQE_SHIFT);
+	idx &= (wq->wqe_cnt - 1);
+	wq->tail = wq->wqe_head[idx] + 1;
+	wc->wr_id = wq->wrid[idx];
+	wq->flush_wqe_cnt--;
+	if (error_code != XSC_ERR_CODE_FLUSH) {
+		printf("%s: got completion with error:\n", xctx->hostname);
+		dump_cqe(cqe);
+	}
+	qp->ibv_qp->state = IBV_QPS_ERR;
+}
+
+static inline void handle_bad_responder(struct xsc_context *xctx,
+					struct ibv_wc *wc, struct xsc_cqe *cqe,
+					struct xsc_qp *qp, struct xsc_wq *wq)
+{
+	u8 error_code = xctx->hw_ops->get_cqe_error_code(cqe);
+
+	wc->status = xsc_cqe_error_code(error_code);
+	wc->vendor_err = error_code;
+
+	++wq->tail;
+	wq->flush_wqe_cnt--;
+	if (error_code != XSC_ERR_CODE_FLUSH) {
+		printf("%s: got completion with error:\n", xctx->hostname);
+		dump_cqe(cqe);
+	}
+	qp->ibv_qp->state = IBV_QPS_ERR;
+}
+
+static inline int xsc_parse_cqe(struct xsc_cq *cq, struct xsc_cqe *cqe,
+				struct xsc_resource **cur_rsc,
+				struct ibv_wc *wc, int lazy)
+{
+	struct xsc_wq *wq;
+	u32 qp_id;
+	u8 opcode;
+	int err = 0;
+	struct xsc_qp *xqp = NULL;
+	struct xsc_context *xctx;
+
+	xctx = to_xctx(ibv_cq_ex_to_cq(&cq->verbs_cq.cq_ex)->context);
+	qp_id = FIELD_GET(CQE_DATA0_QP_ID_MASK, le32toh(cqe->data0));
+	wc->wc_flags = 0;
+	wc->qp_num = qp_id;
+	opcode = xsc_get_cqe_opcode(xctx, cqe);
+
+	xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ_CQE, "opcode:0x%x qp_num:%u\n", opcode,
+		qp_id);
+	switch (opcode) {
+	case XSC_OPCODE_RDMA_REQ_SEND_IMMDT:
+	case XSC_OPCODE_RDMA_REQ_WRITE_IMMDT:
+		wc->wc_flags |= IBV_WC_WITH_IMM;
+		SWITCH_FALLTHROUGH;
+	case XSC_OPCODE_RDMA_REQ_SEND:
+	case XSC_OPCODE_RDMA_REQ_WRITE:
+	case XSC_OPCODE_RDMA_REQ_READ:
+		err = get_qp_ctx(xctx, cur_rsc, qp_id);
+		if (unlikely(err))
+			return CQ_EMPTY;
+		xqp = rsc_to_xqp(*cur_rsc);
+		wq = &xqp->sq;
+		handle_good_req(wc, cqe, xqp, wq, opcode);
+		break;
+	case XSC_OPCODE_RDMA_RSP_RECV_IMMDT:
+	case XSC_OPCODE_RDMA_RSP_WRITE_IMMDT:
+		wc->wc_flags |= IBV_WC_WITH_IMM;
+		wc->imm_data = htobe32(le32toh(cqe->imm_data));
+		SWITCH_FALLTHROUGH;
+	case XSC_OPCODE_RDMA_RSP_RECV:
+		err = get_qp_ctx(xctx, cur_rsc, qp_id);
+		if (unlikely(err))
+			return CQ_EMPTY;
+		xqp = rsc_to_xqp(*cur_rsc);
+		wq = &xqp->rq;
+		handle_good_responder(wc, cqe, wq, opcode);
+		break;
+	case XSC_OPCODE_RDMA_REQ_ERROR:
+		err = get_qp_ctx(xctx, cur_rsc, qp_id);
+		if (unlikely(err))
+			return CQ_POLL_ERR;
+		xqp = rsc_to_xqp(*cur_rsc);
+		wq = &xqp->sq;
+		handle_bad_req(xctx, wc, cqe, xqp, wq);
+		break;
+	case XSC_OPCODE_RDMA_RSP_ERROR:
+		err = get_qp_ctx(xctx, cur_rsc, qp_id);
+		if (unlikely(err))
+			return CQ_POLL_ERR;
+		xqp = rsc_to_xqp(*cur_rsc);
+		wq = &xqp->rq;
+		handle_bad_responder(xctx, wc, cqe, xqp, wq);
+		break;
+	case XSC_OPCODE_RDMA_CQE_ERROR:
+		printf("%s: got completion with cqe format error:\n",
+		       xctx->hostname);
+		dump_cqe(cqe);
+		SWITCH_FALLTHROUGH;
+	default:
+		return CQ_POLL_ERR;
+	}
+	return CQ_OK;
+}
+
+static inline int xsc_poll_one(struct xsc_cq *cq, struct xsc_resource **cur_rsc,
+			       struct ibv_wc *wc) ALWAYS_INLINE;
+static inline int xsc_poll_one(struct xsc_cq *cq, struct xsc_resource **cur_rsc,
+			       struct ibv_wc *wc)
+{
+	struct xsc_cqe *cqe = get_sw_cqe(cq, cq->cons_index);
+
+	if (!cqe)
+		return CQ_EMPTY;
+
+	memset(wc, 0, sizeof(*wc));
+
+	++cq->cons_index;
+
+	/*
+	 * Make sure we read CQ entry contents after we've checked the
+	 * ownership bit.
+	 */
+	udma_from_device_barrier();
+	return xsc_parse_cqe(cq, cqe, cur_rsc, wc, 0);
+}
+
+static inline void gen_flush_err_cqe(struct xsc_err_state_qp_node *err_node,
+				     u32 qp_id, struct xsc_wq *wq,
+				     u32 idx, struct ibv_wc *wc)
+{
+	memset(wc, 0, sizeof(*wc));
+	if (err_node->is_sq) {
+		switch (wq->wr_opcode[idx]) {
+		case IBV_WR_SEND:
+		case IBV_WR_SEND_WITH_IMM:
+		case IBV_WR_SEND_WITH_INV:
+			wc->opcode = IBV_WC_SEND;
+			break;
+		case IBV_WR_RDMA_WRITE:
+		case IBV_WR_RDMA_WRITE_WITH_IMM:
+			wc->opcode = IBV_WC_RDMA_WRITE;
+			break;
+		case IBV_WR_RDMA_READ:
+			wc->opcode = IBV_WC_RDMA_READ;
+		}
+	} else {
+		wc->opcode = IBV_WC_RECV;
+	}
+
+	wc->qp_num = qp_id;
+	wc->status = IBV_WC_WR_FLUSH_ERR;
+	wc->vendor_err = XSC_ERR_CODE_FLUSH;
+	wc->wr_id = wq->wrid[idx];
+	wq->tail++;
+	wq->flush_wqe_cnt--;
+}
+
+static inline int xsc_generate_flush_err_cqe(struct ibv_cq *ibcq, int ne,
+					     int *npolled, struct ibv_wc *wc)
+{
+	u32 qp_id = 0;
+	u32 flush_wqe_cnt = 0;
+	int sw_npolled = 0;
+	int ret = 0;
+	u32 idx = 0;
+	struct xsc_err_state_qp_node *err_qp_node, *tmp;
+	struct xsc_resource *res = NULL;
+	struct xsc_context *xctx = to_xctx(ibcq->context);
+	struct xsc_cq *cq = to_xcq(ibcq);
+	struct xsc_wq *wq;
+
+	list_for_each_safe(&cq->err_state_qp_list, err_qp_node, tmp, entry) {
+		if (!err_qp_node)
+			break;
+
+		sw_npolled = 0;
+		qp_id = err_qp_node->qp_id;
+		ret = get_qp_ctx(xctx, &res, qp_id);
+		if (unlikely(ret))
+			continue;
+		wq = err_qp_node->is_sq ? &(rsc_to_xqp(res)->sq) :
+					  &(rsc_to_xqp(res)->rq);
+		flush_wqe_cnt = wq->flush_wqe_cnt;
+		xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ_CQE,
+			"is_sq %d, flush_wq_cnt %d, ne %d, npolled %d, qp_id %d\n",
+			err_qp_node->is_sq, wq->flush_wqe_cnt, ne, *npolled,
+			qp_id);
+
+		if (flush_wqe_cnt <= (ne - *npolled)) {
+			while (sw_npolled < flush_wqe_cnt) {
+				idx = wq->tail & (wq->wqe_cnt - 1);
+				if (err_qp_node->is_sq &&
+				    !wq->need_flush[idx]) {
+					wq->tail++;
+					continue;
+				} else {
+					gen_flush_err_cqe(err_qp_node,
+							  err_qp_node->qp_id,
+							  wq, idx,
+							  wc + *npolled + sw_npolled);
+					++sw_npolled;
+				}
+			}
+			list_del(&err_qp_node->entry);
+			free(err_qp_node);
+			*npolled += sw_npolled;
+		} else {
+			while (sw_npolled < (ne - *npolled)) {
+				idx = wq->tail & (wq->wqe_cnt - 1);
+				if (err_qp_node->is_sq &&
+				    !wq->need_flush[idx]) {
+					wq->tail++;
+					continue;
+				} else {
+					gen_flush_err_cqe(err_qp_node,
+							  err_qp_node->qp_id,
+							  wq, idx,
+							  wc + *npolled + sw_npolled);
+					++sw_npolled;
+				}
+			}
+			*npolled = ne;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static inline int poll_cq(struct ibv_cq *ibcq, int ne,
+			  struct ibv_wc *wc) ALWAYS_INLINE;
+static inline int poll_cq(struct ibv_cq *ibcq, int ne, struct ibv_wc *wc)
+{
+	struct xsc_cq *cq = to_xcq(ibcq);
+	struct xsc_resource *rsc = NULL;
+	int npolled = 0;
+	int err = CQ_OK;
+	u32 next_cid = cq->cons_index;
+
+	xsc_spin_lock(&cq->lock);
+	for (npolled = 0; npolled < ne; ++npolled) {
+		err = xsc_poll_one(cq, &rsc, wc + npolled);
+		if (err != CQ_OK)
+			break;
+	}
+
+	if (err == CQ_EMPTY) {
+		if (npolled < ne && !(list_empty(&cq->err_state_qp_list)))
+			xsc_generate_flush_err_cqe(ibcq, ne, &npolled, wc);
+	}
+
+	udma_to_device_barrier();
+	if (next_cid != cq->cons_index)
+		update_cons_index(cq);
+	xsc_spin_unlock(&cq->lock);
+
+	return err == CQ_POLL_ERR ? err : npolled;
+}
+
+int xsc_poll_cq(struct ibv_cq *ibcq, int ne, struct ibv_wc *wc)
+{
+	return poll_cq(ibcq, ne, wc);
+}
+
+int xsc_alloc_cq_buf(struct xsc_context *xctx, struct xsc_cq *cq,
+		     struct xsc_buf *buf, int nent, int cqe_sz)
+{
+	struct xsc_device *xdev = to_xdev(xctx->ibv_ctx.context.device);
+	int ret;
+
+	ret = xsc_alloc_buf(buf, align(nent * cqe_sz, xdev->page_size),
+			    xdev->page_size);
+	if (ret)
+		return -1;
+
+	memset(buf->buf, 0, nent * cqe_sz);
+	return 0;
+}
+
+void xsc_free_cq_buf(struct xsc_context *ctx, struct xsc_buf *buf)
+{
+	return xsc_free_buf(buf);
+}
diff --git a/providers/xscale/verbs.c b/providers/xscale/verbs.c
index ed265d6e..29de7311 100644
--- a/providers/xscale/verbs.c
+++ b/providers/xscale/verbs.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <inttypes.h>
 #include <sys/mman.h>
 #include <ccan/array_size.h>
 
@@ -27,6 +28,7 @@
 
 #include "xscale.h"
 #include "xsc-abi.h"
+#include "xsc_hsi.h"
 
 int xsc_query_port(struct ibv_context *context, u8 port,
 		   struct ibv_port_attr *attr)
@@ -121,6 +123,287 @@ free:
 	return 0;
 }
 
+int xsc_round_up_power_of_two(long long sz)
+{
+	long long ret;
+
+	for (ret = 1; ret < sz; ret <<= 1)
+		; /* nothing */
+
+	if (ret > INT_MAX) {
+		fprintf(stderr, "%s: roundup overflow\n", __func__);
+		return -ENOMEM;
+	}
+
+	return (int)ret;
+}
+
+static int align_queue_size(long long req)
+{
+	return xsc_round_up_power_of_two(req);
+}
+
+enum { CREATE_CQ_SUPPORTED_WC_FLAGS =
+	       IBV_WC_STANDARD_FLAGS | IBV_WC_EX_WITH_COMPLETION_TIMESTAMP |
+	       IBV_WC_EX_WITH_CVLAN | IBV_WC_EX_WITH_FLOW_TAG |
+	       IBV_WC_EX_WITH_TM_INFO |
+	       IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK };
+
+enum { CREATE_CQ_SUPPORTED_COMP_MASK = IBV_CQ_INIT_ATTR_MASK_FLAGS };
+
+enum { CREATE_CQ_SUPPORTED_FLAGS = IBV_CREATE_CQ_ATTR_SINGLE_THREADED |
+				   IBV_CREATE_CQ_ATTR_IGNORE_OVERRUN };
+
+static int xsc_cqe_depth_check(void)
+{
+	char *e;
+
+	e = getenv("XSC_CQE_DEPTH_CHECK");
+	if (e && !strcmp(e, "n"))
+		return 0;
+
+	return 1;
+}
+
+static struct ibv_cq_ex *create_cq(struct ibv_context *context,
+				   const struct ibv_cq_init_attr_ex *cq_attr,
+				   int cq_alloc_flags)
+{
+	struct xsc_create_cq cmd = {};
+	struct xsc_create_cq_resp resp = {};
+	struct xsc_create_cq_ex cmd_ex = {};
+	struct xsc_create_cq_ex_resp resp_ex = {};
+	struct xsc_ib_create_cq *cmd_drv;
+	struct xsc_ib_create_cq_resp *resp_drv;
+	struct xsc_cq *cq;
+	int cqe_sz;
+	int ret;
+	int ncqe;
+	struct xsc_context *xctx = to_xctx(context);
+	bool use_ex = false;
+	char *env;
+	int i;
+
+	if (!cq_attr->cqe) {
+		xsc_err("CQE invalid\n");
+		errno = EINVAL;
+		return NULL;
+	}
+
+	xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ, "CQE number:%u\n", cq_attr->cqe);
+
+	if (cq_attr->comp_mask & ~CREATE_CQ_SUPPORTED_COMP_MASK) {
+		xsc_err("Unsupported comp_mask for create cq\n");
+		errno = EINVAL;
+		return NULL;
+	}
+
+	if (cq_attr->comp_mask & IBV_CQ_INIT_ATTR_MASK_FLAGS &&
+	    cq_attr->flags & ~CREATE_CQ_SUPPORTED_FLAGS) {
+		xsc_err("Unsupported creation flags requested for create cq\n");
+		errno = EINVAL;
+		return NULL;
+	}
+
+	if (cq_attr->wc_flags & ~CREATE_CQ_SUPPORTED_WC_FLAGS) {
+		xsc_err("unsupported flags:0x%" PRIx64 "\n", cq_attr->wc_flags);
+		errno = ENOTSUP;
+		return NULL;
+	}
+
+	cq = calloc(1, sizeof(*cq));
+	if (!cq) {
+		xsc_err("Alloc CQ failed\n");
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	if (cq_attr->comp_mask & IBV_CQ_INIT_ATTR_MASK_FLAGS) {
+		if (cq_attr->flags & IBV_CREATE_CQ_ATTR_IGNORE_OVERRUN)
+			use_ex = true;
+	}
+
+	xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ, "use_ex:%u\n", use_ex);
+
+	cmd_drv = use_ex ? &cmd_ex.drv_payload : &cmd.drv_payload;
+	resp_drv = use_ex ? &resp_ex.drv_payload : &resp.drv_payload;
+
+	cq->cons_index = 0;
+
+	if (xsc_spinlock_init(&cq->lock))
+		goto err;
+
+	ncqe = align_queue_size(cq_attr->cqe);
+	if (ncqe < XSC_CQE_RING_DEPTH_MIN) {
+		xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ,
+			"CQE ring size %u is not enough, set it as %u\n", ncqe,
+			XSC_CQE_RING_DEPTH_MIN);
+		ncqe = XSC_CQE_RING_DEPTH_MIN;
+	}
+
+	if (ncqe > xctx->max_cqe) {
+		if (xsc_cqe_depth_check()) {
+			xsc_err("CQE ring size %u exceeds CQE ring depth %u, abort!\n",
+				ncqe, xctx->max_cqe);
+			errno = EINVAL;
+			goto err_spl;
+		} else {
+			xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ,
+				"CQE ring size %u exceeds the MAX ring szie, set it as %u\n",
+				ncqe, xctx->max_cqe);
+			ncqe = xctx->max_cqe;
+		}
+	}
+
+	cqe_sz = XSC_CQE_SIZE;
+	xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ, "CQE number:%u, size:%u\n", ncqe,
+		cqe_sz);
+
+	if (xsc_alloc_cq_buf(to_xctx(context), cq, &cq->buf, ncqe, cqe_sz)) {
+		xsc_err("Alloc cq buffer failed.\n");
+		errno = ENOMEM;
+		goto err_spl;
+	}
+
+	cq->cqe_sz = cqe_sz;
+	cq->flags = cq_alloc_flags;
+
+	cmd_drv->buf_addr = (uintptr_t)cq->buf.buf;
+	cmd_drv->cqe_size = cqe_sz;
+
+	xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ, "buf_addr:%p\n", cq->buf.buf);
+
+	if (use_ex) {
+		struct ibv_cq_init_attr_ex cq_attr_ex = *cq_attr;
+
+		cq_attr_ex.cqe = ncqe;
+		ret = ibv_cmd_create_cq_ex(context, &cq_attr_ex, &cq->verbs_cq,
+					   &cmd_ex.ibv_cmd, sizeof(cmd_ex),
+					   &resp_ex.ibv_resp, sizeof(resp_ex),
+					   0);
+	} else {
+		ret = ibv_cmd_create_cq(context, ncqe, cq_attr->channel,
+					cq_attr->comp_vector,
+					ibv_cq_ex_to_cq(&cq->verbs_cq.cq_ex),
+					&cmd.ibv_cmd, sizeof(cmd),
+					&resp.ibv_resp, sizeof(resp));
+	}
+
+	if (ret) {
+		xsc_err("ibv_cmd_create_cq failed,ret %d\n", ret);
+		goto err_buf;
+	}
+
+	cq->active_buf = &cq->buf;
+	cq->resize_buf = NULL;
+	cq->cqn = resp_drv->cqn;
+
+	cq->db = xctx->cqm_reg_va +
+		 (xctx->cqm_next_cid_reg & (xctx->page_size - 1));
+	cq->armdb =
+		xctx->cqm_armdb_va + (xctx->cqm_armdb & (xctx->page_size - 1));
+	cq->cqe_cnt = ncqe;
+	cq->log2_cq_ring_sz = xsc_ilog2(ncqe);
+
+	for (i = 0; i < ncqe; i++) {
+		struct xsc_cqe *cqe = (struct xsc_cqe *)(cq->active_buf->buf +
+							 i * cq->cqe_sz);
+		u32 owner_data = 0;
+
+		owner_data |= FIELD_PREP(CQE_DATA2_OWNER_MASK, 1);
+		cqe->data2 = htole32(owner_data);
+	}
+
+	env = getenv("XSC_DISABLE_FLUSH_ERROR");
+	cq->disable_flush_error_cqe = env ? true : false;
+	xsc_dbg(xctx->dbg_fp, XSC_DBG_CQ, "cqe count:%u cqn:%u\n", cq->cqe_cnt,
+		cq->cqn);
+	list_head_init(&cq->err_state_qp_list);
+	return &cq->verbs_cq.cq_ex;
+
+err_buf:
+	xsc_free_cq_buf(to_xctx(context), &cq->buf);
+
+err_spl:
+	xsc_spinlock_destroy(&cq->lock);
+
+err:
+	free(cq);
+
+	return NULL;
+}
+
+struct ibv_cq *xsc_create_cq(struct ibv_context *context, int cqe,
+			     struct ibv_comp_channel *channel, int comp_vector)
+{
+	struct ibv_cq_ex *cq;
+	struct ibv_cq_init_attr_ex cq_attr = { .cqe = cqe,
+					       .channel = channel,
+					       .comp_vector = comp_vector,
+					       .wc_flags =
+						       IBV_WC_STANDARD_FLAGS };
+
+	if (cqe <= 0) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	cq = create_cq(context, &cq_attr, 0);
+	return cq ? ibv_cq_ex_to_cq(cq) : NULL;
+}
+
+int xsc_arm_cq(struct ibv_cq *ibvcq, int solicited)
+{
+	struct xsc_cq *cq = to_xcq(ibvcq);
+	struct xsc_context *ctx = to_xctx(ibvcq->context);
+
+	ctx->hw_ops->update_cq_db(cq->armdb, cq->cqn, cq->cons_index,
+				  solicited);
+
+	return 0;
+}
+
+int xsc_resize_cq(struct ibv_cq *ibcq, int cqe)
+{
+	struct xsc_cq *cq = to_xcq(ibcq);
+
+	if (cqe < 0) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	xsc_spin_lock(&cq->lock);
+	cq->active_cqes = cq->verbs_cq.cq_ex.cqe;
+	/* currently we don't change cqe size */
+	cq->resize_cqe_sz = cq->cqe_sz;
+	cq->resize_cqes = cq->verbs_cq.cq_ex.cqe;
+	xsc_spin_unlock(&cq->lock);
+	cq->resize_buf = NULL;
+	return 0;
+}
+
+int xsc_destroy_cq(struct ibv_cq *cq)
+{
+	int ret;
+	struct xsc_err_state_qp_node *tmp, *err_qp_node;
+
+	xsc_dbg(to_xctx(cq->context)->dbg_fp, XSC_DBG_CQ, "\n");
+	ret = ibv_cmd_destroy_cq(cq);
+	if (ret)
+		return ret;
+
+	list_for_each_safe(&to_xcq(cq)->err_state_qp_list, err_qp_node, tmp,
+			   entry) {
+		list_del(&err_qp_node->entry);
+		free(err_qp_node);
+	}
+
+	xsc_free_cq_buf(to_xctx(cq->context), to_xcq(cq)->active_buf);
+	free(to_xcq(cq));
+
+	return 0;
+}
+
 static void xsc_set_fw_version(struct ibv_device_attr *attr,
 			       union xsc_ib_fw_ver *fw_ver)
 {
diff --git a/providers/xscale/xsc_hsi.c b/providers/xscale/xsc_hsi.c
new file mode 100644
index 00000000..d84fb52e
--- /dev/null
+++ b/providers/xscale/xsc_hsi.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <util/mmio.h>
+
+#include "xscale.h"
+#include "xsc_hsi.h"
+
+static void andes_ring_tx_doorbell(void *db_addr, u32 sqn,
+				   u32 next_pid)
+{
+	u32 tx_db = 0;
+
+	tx_db = FIELD_PREP(ANDES_SEND_DB_NEXT_PID_MASK, next_pid) |
+		FIELD_PREP(ANDES_SEND_DB_QP_ID_MASK, sqn);
+
+	udma_to_device_barrier();
+	mmio_write32_le(db_addr, htole32(tx_db));
+}
+
+static void andes_ring_rx_doorbell(void *db_addr, u32 rqn,
+				   u32 next_pid)
+{
+	u32 rx_db = 0;
+
+	rx_db = FIELD_PREP(ANDES_RECV_DB_NEXT_PID_MASK, next_pid) |
+		FIELD_PREP(ANDES_RECV_DB_QP_ID_MASK, rqn);
+
+	udma_to_device_barrier();
+	mmio_write32_le(db_addr, htole32(rx_db));
+}
+
+static void andes_update_cq_db(void *db_addr, u32 cqn, u32 next_cid,
+			       u8 solicited)
+{
+	u32 cq_db;
+
+	cq_db = FIELD_PREP(ANDES_CQ_DB_NEXT_CID_MASK, next_cid) |
+		FIELD_PREP(ANDES_CQ_DB_CQ_ID_MASK, cqn) |
+		FIELD_PREP(ANDES_CQ_DB_ARM_MASK, solicited);
+
+	udma_to_device_barrier();
+	mmio_wc_start();
+	mmio_write32_le(db_addr, htole32(cq_db));
+	mmio_flush_writes();
+}
+
+static void andes_set_cq_ci(void *db_addr, u32 cqn, u32 next_cid)
+{
+	u32 cq_db;
+
+	cq_db = FIELD_PREP(ANDES_CQ_DB_NEXT_CID_MASK, next_cid) |
+		FIELD_PREP(ANDES_CQ_DB_CQ_ID_MASK, cqn) |
+		FIELD_PREP(ANDES_CQ_DB_ARM_MASK, 0);
+
+	udma_to_device_barrier();
+	mmio_write32_le(db_addr, htole32(cq_db));
+}
+
+static bool andes_is_err_cqe(struct xsc_cqe *cqe)
+{
+	return FIELD_GET(CQE_DATA0_IS_ERR_MASK, le32toh(cqe->data0));
+}
+
+static u8 andes_get_cqe_error_code(struct xsc_cqe *cqe)
+{
+	return FIELD_GET(CQE_DATA0_ERROR_CODE_ANDES_MASK,
+			 le32toh(cqe->data0));
+}
+
+static u8 andes_get_msg_opcode(struct xsc_cqe *cqe)
+{
+	return FIELD_GET(CQE_DATA0_MSG_OPCODE_ANDES_MASK,
+			 le32toh(cqe->data0));
+}
+
+static struct xsc_hw_ops andes_ops = {
+	.ring_tx_doorbell = andes_ring_tx_doorbell,
+	.ring_rx_doorbell = andes_ring_rx_doorbell,
+	.update_cq_db = andes_update_cq_db,
+	.set_cq_ci = andes_set_cq_ci,
+	.is_err_cqe = andes_is_err_cqe,
+	.get_cqe_error_code = andes_get_cqe_error_code,
+	.get_cqe_msg_opcode = andes_get_msg_opcode,
+};
+
+void xsc_init_hw_ops(struct xsc_context *ctx)
+{
+	ctx->hw_ops = &andes_ops;
+}
diff --git a/providers/xscale/xsc_hsi.h b/providers/xscale/xsc_hsi.h
new file mode 100644
index 00000000..230d7101
--- /dev/null
+++ b/providers/xscale/xsc_hsi.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_HSI_H__
+#define __XSC_HSI_H__
+
+#include <linux/types.h>
+#include <endian.h>
+
+#include "util/util.h"
+#include "xscale.h"
+
+/* message opcode */
+enum {
+	XSC_MSG_OPCODE_SEND = 0,
+	XSC_MSG_OPCODE_RDMA_WRITE = 1,
+	XSC_MSG_OPCODE_RDMA_READ = 2,
+	XSC_MSG_OPCODE_MAD = 3,
+	XSC_MSG_OPCODE_RDMA_ACK = 4,
+	XSC_MSG_OPCODE_RDMA_ACK_READ = 5,
+	XSC_MSG_OPCODE_RDMA_CNP = 6,
+	XSC_MSG_OPCODE_RAW = 7,
+	XSC_MSG_OPCODE_VIRTIO_NET = 8,
+	XSC_MSG_OPCODE_VIRTIO_BLK = 9,
+	XSC_MSG_OPCODE_RAW_TPE = 10,
+	XSC_MSG_OPCODE_INIT_QP_REQ = 11,
+	XSC_MSG_OPCODE_INIT_QP_RSP = 12,
+	XSC_MSG_OPCODE_INIT_PATH_REQ = 13,
+	XSC_MSG_OPCODE_INIT_PATH_RSP = 14,
+};
+
+enum {
+	XSC_REQ = 0,
+	XSC_RSP = 1,
+};
+
+enum {
+	XSC_WITHOUT_IMMDT = 0,
+	XSC_WITH_IMMDT = 1,
+};
+
+enum {
+	XSC_ERR_CODE_NAK_RETRY = 0x40,
+	XSC_ERR_CODE_NAK_OPCODE = 0x41,
+	XSC_ERR_CODE_NAK_MR = 0x42,
+	XSC_ERR_CODE_NAK_OPERATION = 0x43,
+	XSC_ERR_CODE_NAK_RNR = 0x44,
+	XSC_ERR_CODE_LOCAL_MR = 0x45,
+	XSC_ERR_CODE_LOCAL_LEN = 0x46,
+	XSC_ERR_CODE_LOCAL_OPCODE = 0x47,
+	XSC_ERR_CODE_CQ_OVER_FLOW = 0x48,
+	XSC_ERR_CODE_STRG_ACC_GEN_CQE = 0x4b,
+	XSC_ERR_CODE_STRG_ACC = 0x4c,
+	XSC_ERR_CODE_CQE_ACC = 0x4d,
+	XSC_ERR_CODE_FLUSH = 0x4e,
+	XSC_ERR_CODE_MALF_WQE_HOST = 0x50,
+	XSC_ERR_CODE_MALF_WQE_INFO = 0x51,
+	XSC_ERR_CODE_MR_NON_NAK = 0x52,
+	XSC_ERR_CODE_OPCODE_GEN_CQE = 0x61,
+	XSC_ERR_CODE_MANY_READ = 0x62,
+	XSC_ERR_CODE_LEN_GEN_CQE = 0x63,
+	XSC_ERR_CODE_MR = 0x65,
+	XSC_ERR_CODE_MR_GEN_CQE = 0x66,
+	XSC_ERR_CODE_OPERATION = 0x67,
+	XSC_ERR_CODE_MALF_WQE_INFO_GEN_NAK = 0x68,
+};
+
+enum {
+	XSC_OPCODE_RDMA_REQ_SEND = 0,
+	XSC_OPCODE_RDMA_REQ_SEND_IMMDT = 1,
+	XSC_OPCODE_RDMA_RSP_RECV = 2,
+	XSC_OPCODE_RDMA_RSP_RECV_IMMDT = 3,
+	XSC_OPCODE_RDMA_REQ_WRITE = 4,
+	XSC_OPCODE_RDMA_REQ_WRITE_IMMDT = 5,
+	XSC_OPCODE_RDMA_RSP_WRITE_IMMDT = 6,
+	XSC_OPCODE_RDMA_REQ_READ = 7,
+	XSC_OPCODE_RDMA_REQ_ERROR = 8,
+	XSC_OPCODE_RDMA_RSP_ERROR = 9,
+	XSC_OPCODE_RDMA_CQE_ERROR = 10,
+};
+
+enum {
+	XSC_BASE_WQE_SHIFT = 4,
+};
+
+/*
+ * Descriptors that are allocated by SW and accessed by HW, 32-byte aligned
+ */
+#define CTRL_SEG_WQE_HDR_MSG_OPCODE_MASK GENMASK(7, 0)
+#define CTRL_SEG_WQE_HDR_WITH_IMMDT_MASK BIT(8)
+#define CTRL_SEG_WQE_HDR_DS_NUM_MASK GENMASK(15, 11)
+#define CTRL_SEG_WQE_HDR_WQE_ID_MASK GENMASK(31, 16)
+#define CTRL_SEG_DATA0_SE_MASK BIT(0)
+#define CTRL_SEG_DATA0_CE_MASK BIT(1)
+#define CTRL_SEG_DATA0_IN_LINE_MASK BIT(2)
+
+struct xsc_send_wqe_ctrl_seg {
+	__le32 wqe_hdr;
+	__le32 msg_len;
+	__le32 opcode_data;
+	__le32 data0;
+};
+
+#define DATA_SEG_DATA0_SEG_LEN_MASK GENMASK(31, 1)
+
+struct xsc_wqe_data_seg {
+	union {
+		struct {
+			__le32 data0;
+			__le32 mkey;
+			__le64 va;
+		};
+		struct {
+			u8 in_line_data[16];
+		};
+	};
+};
+
+#define CQE_DATA0_MSG_OPCODE_ANDES_MASK	GENMASK(7, 0)
+#define CQE_DATA0_ERROR_CODE_ANDES_MASK	GENMASK(6, 0)
+#define CQE_DATA0_IS_ERR_MASK		BIT(7)
+#define CQE_DATA0_QP_ID_MASK		GENMASK(22, 8)
+#define CQE_DATA0_SE_MASK		BIT(24)
+#define CQE_DATA0_HAS_PPH_MASK		BIT(25)
+#define CQE_DATA0_TYPE_MASK		BIT(26)
+#define CQE_DATA0_WITH_IMMDT_MASK	BIT(27)
+#define CQE_DATA0_CSUM_ERR_MASK		GENMASK(31, 28)
+#define CQE_DATA1_TS_MASK		GENMASK_ULL(47, 0)
+#define CQE_DATA1_WQE_ID_MASK		GENMASK_ULL(63, 48)
+#define CQE_DATA2_OWNER_MASK		BIT(31)
+
+struct xsc_cqe {
+	__le32 data0;
+	__le32 imm_data;
+	__le32 msg_len;
+	__le32 vni;
+	__le64 data1;
+	__le32 rsv;
+	__le32 data2;
+};
+
+#define ANDES_SEND_DB_NEXT_PID_MASK	GENMASK(15, 0)
+#define ANDES_SEND_DB_QP_ID_MASK	GENMASK(30, 16)
+#define ANDES_RECV_DB_NEXT_PID_MASK	GENMASK(12, 0)
+#define ANDES_RECV_DB_QP_ID_MASK	GENMASK(27, 13)
+#define ANDES_CQ_DB_NEXT_CID_MASK	GENMASK(15, 0)
+#define ANDES_CQ_DB_CQ_ID_MASK		GENMASK(30, 16)
+#define ANDES_CQ_DB_ARM_MASK		BIT(31)
+
+struct xsc_hw_ops {
+	void (*ring_tx_doorbell)(void *db, u32 sqn, u32 next_pid);
+	void (*ring_rx_doorbell)(void *db, u32 rqn, u32 next_pid);
+	void (*update_cq_db)(void *db, u32 cqn, u32 next_cid,
+			     u8 solicited);
+	void (*set_cq_ci)(void *db, u32 cqn, u32 next_cid);
+	bool (*is_err_cqe)(struct xsc_cqe *cqe);
+	u8 (*get_cqe_error_code)(struct xsc_cqe *cqe);
+	u8 (*get_cqe_msg_opcode)(struct xsc_cqe *cqe);
+};
+
+/* Size of CQE */
+#define XSC_CQE_SIZE sizeof(struct xsc_cqe)
+
+#define XSC_SEND_WQE_RING_DEPTH_MIN 16
+#define XSC_CQE_RING_DEPTH_MIN 2
+
+void xsc_init_hw_ops(struct xsc_context *ctx);
+static inline bool xsc_get_cqe_sw_own(struct xsc_cqe *cqe, int cid,
+				      int ring_sz) ALWAYS_INLINE;
+
+static inline bool xsc_get_cqe_sw_own(struct xsc_cqe *cqe, int cid, int ring_sz)
+{
+	return FIELD_GET(CQE_DATA2_OWNER_MASK, le32toh(cqe->data2)) == ((cid >> ring_sz) & 1);
+}
+#endif /* __XSC_HSI_H__ */
diff --git a/providers/xscale/xscale.c b/providers/xscale/xscale.c
index cdc37fbd..7b439f78 100644
--- a/providers/xscale/xscale.c
+++ b/providers/xscale/xscale.c
@@ -22,6 +22,7 @@
 
 #include "xscale.h"
 #include "xsc-abi.h"
+#include "xsc_hsi.h"
 
 static const struct verbs_match_ent hca_table[] = {
 	VERBS_MODALIAS_MATCH("*xscale*", NULL),
@@ -33,12 +34,19 @@ static void xsc_free_context(struct ibv_context *ibctx);
 
 static const struct verbs_context_ops xsc_ctx_common_ops = {
 	.query_port = xsc_query_port,
+	.query_device_ex = xsc_query_device_ex,
+	.free_context = xsc_free_context,
+
 	.alloc_pd = xsc_alloc_pd,
 	.dealloc_pd = xsc_free_pd,
 	.reg_mr = xsc_reg_mr,
 	.dereg_mr = xsc_dereg_mr,
-	.query_device_ex = xsc_query_device_ex,
-	.free_context = xsc_free_context,
+
+	.create_cq = xsc_create_cq,
+	.poll_cq = xsc_poll_cq,
+	.req_notify_cq = xsc_arm_cq,
+	.resize_cq = xsc_resize_cq,
+	.destroy_cq = xsc_destroy_cq,
 };
 
 static void open_debug_file(struct xsc_context *ctx)
@@ -202,6 +210,7 @@ static struct verbs_context *xsc_alloc_context(struct ibv_device *ibdev,
 	context->send_ds_shift = xsc_ilog2(resp.send_ds_num);
 	context->recv_ds_num = resp.recv_ds_num;
 	context->recv_ds_shift = xsc_ilog2(resp.recv_ds_num);
+	xsc_init_hw_ops(context);
 
 	xsc_dbg(context->dbg_fp, XSC_DBG_CTX,
 		"max_num_qps:%u, max_sq_desc_sz:%u max_rq_desc_sz:%u\n",
diff --git a/providers/xscale/xscale.h b/providers/xscale/xscale.h
index 3cef6781..1955f98d 100644
--- a/providers/xscale/xscale.h
+++ b/providers/xscale/xscale.h
@@ -79,11 +79,19 @@ enum {
 	XSC_QP_TABLE_SIZE = 1 << (24 - XSC_QP_TABLE_SHIFT),
 };
 
+struct xsc_resource {
+	u32 rsn;
+};
+
 struct xsc_device {
 	struct verbs_device verbs_dev;
 	int page_size;
 };
 
+struct xsc_spinlock {
+	pthread_spinlock_t lock;
+};
+
 #define NAME_BUFFER_SIZE 64
 
 struct xsc_context {
@@ -120,12 +128,47 @@ struct xsc_context {
 	struct xsc_hw_ops *hw_ops;
 };
 
+struct xsc_buf {
+	void *buf;
+	size_t length;
+};
+
 struct xsc_pd {
 	struct ibv_pd ibv_pd;
 	u32 pdn;
 	atomic_int refcount;
 };
 
+struct xsc_err_state_qp_node {
+	struct list_node entry;
+	u32 qp_id;
+	int is_sq;
+};
+
+struct xsc_cq {
+	/* ibv_cq should always be subset of ibv_cq_ex */
+	struct verbs_cq verbs_cq;
+	struct xsc_buf buf;
+	struct xsc_buf *active_buf;
+	struct xsc_buf *resize_buf;
+	int resize_cqes;
+	int active_cqes;
+	struct xsc_spinlock lock;
+	u32 cqn;
+	u32 cons_index;
+	__le32 *db;
+	__le32 *armdb;
+	u32 cqe_cnt;
+	int log2_cq_ring_sz;
+	int arm_sn;
+	int cqe_sz;
+	int resize_cqe_sz;
+	struct xsc_resource *cur_rsc;
+	u32 flags;
+	int disable_flush_error_cqe;
+	struct list_head err_state_qp_list;
+};
+
 struct xsc_mr {
 	struct verbs_mr vmr;
 	u32 alloc_flags;
@@ -171,11 +214,25 @@ static inline struct xsc_pd *to_xpd(struct ibv_pd *ibpd)
 	return container_of(ibpd, struct xsc_pd, ibv_pd);
 }
 
+static inline struct xsc_cq *to_xcq(struct ibv_cq *ibcq)
+{
+	return container_of((struct ibv_cq_ex *)ibcq, struct xsc_cq,
+			    verbs_cq.cq_ex);
+}
+
 static inline struct xsc_mr *to_xmr(struct ibv_mr *ibmr)
 {
 	return container_of(ibmr, struct xsc_mr, vmr.ibv_mr);
 }
 
+static inline struct xsc_qp *rsc_to_xqp(struct xsc_resource *rsc)
+{
+	return (struct xsc_qp *)rsc;
+}
+
+int xsc_alloc_buf(struct xsc_buf *buf, size_t size, int page_size);
+void xsc_free_buf(struct xsc_buf *buf);
+
 int xsc_query_device(struct ibv_context *context, struct ibv_device_attr *attr);
 int xsc_query_device_ex(struct ibv_context *context,
 			const struct ibv_query_device_ex_input *input,
@@ -189,5 +246,40 @@ int xsc_free_pd(struct ibv_pd *pd);
 struct ibv_mr *xsc_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 			  u64 hca_va, int access);
 int xsc_dereg_mr(struct verbs_mr *mr);
+struct ibv_cq *xsc_create_cq(struct ibv_context *context, int cqe,
+			     struct ibv_comp_channel *channel, int comp_vector);
+struct ibv_cq_ex *xsc_create_cq_ex(struct ibv_context *context,
+				   struct ibv_cq_init_attr_ex *cq_attr);
+int xsc_alloc_cq_buf(struct xsc_context *xctx, struct xsc_cq *cq,
+		     struct xsc_buf *buf, int nent, int cqe_sz);
+void xsc_free_cq_buf(struct xsc_context *ctx, struct xsc_buf *buf);
+int xsc_resize_cq(struct ibv_cq *cq, int cqe);
+int xsc_destroy_cq(struct ibv_cq *cq);
+int xsc_poll_cq(struct ibv_cq *cq, int ne, struct ibv_wc *wc);
+int xsc_arm_cq(struct ibv_cq *cq, int solicited);
+void __xsc_cq_clean(struct xsc_cq *cq, u32 qpn);
+void xsc_cq_clean(struct xsc_cq *cq, u32 qpn);
+int xsc_round_up_power_of_two(long long sz);
+void *xsc_get_send_wqe(struct xsc_qp *qp, int n);
+
+static inline int xsc_spin_lock(struct xsc_spinlock *lock)
+{
+	return pthread_spin_lock(&lock->lock);
+}
+
+static inline int xsc_spin_unlock(struct xsc_spinlock *lock)
+{
+	return pthread_spin_unlock(&lock->lock);
+}
+
+static inline int xsc_spinlock_init(struct xsc_spinlock *lock)
+{
+	return pthread_spin_init(&lock->lock, PTHREAD_PROCESS_PRIVATE);
+}
+
+static inline int xsc_spinlock_destroy(struct xsc_spinlock *lock)
+{
+	return pthread_spin_destroy(&lock->lock);
+}
 
 #endif /* XSC_H */
-- 
2.25.1

