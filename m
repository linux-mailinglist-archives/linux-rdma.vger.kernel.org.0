Return-Path: <linux-rdma+bounces-6409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FADE9EC1F8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D86166CD3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C61FBEBB;
	Wed, 11 Dec 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x7/4u4ZO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FA44384
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882990; cv=none; b=jI2QkjJ53wOgMDjR44EYXliQjZ/fFCI6vR4v7RtXr0GdECNR03Bmb1x9r2KU0C3E+KOuIMQkYjGEO8E+GUOQCQ+uLGOpRGwTSIhN2oaJxCQXFYzF+lWUWDK7pw+ZyO7aZpe2vdhzcVqdtnLCrAPylKJhzfKEsDuX5ol0WnH9LEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882990; c=relaxed/simple;
	bh=Ym4y0/UN4kOjiif5uNVmaqo+rr2k5CJsOvRGYY4Z6dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRxo1kpnJtUZUatgSYgHGuqYe2gWb2YYVVaHVJV4vPhO1yi/h/xoqkC9fkCeX3vSCa4iVKOJd2lKxGjL9RC5QfXnXGx88VvugD8mEYHRhsbj0NfjFIAM++4Ri575FWHfj+whDVMQ4jL+pE2qSk1izO497PUlRbZmoVFk7WGpcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x7/4u4ZO; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882980; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZZhaQHFu/ZAQDn85t9/t3vJ63cZkvDY/A2XNNyrpNos=;
	b=x7/4u4ZOeHtLdpfYj/1SolXEHEbm++Q0GZvfjW2BdWGiOQ0jWMq5EmpG/nMkRZzZ0LYvM1Y1S/4/xurskJ7DuakxhZzeXHh2hScFloyeVAc0oWpsbkVPkba+fo2vcOZa7815es+tfj0fRa0eM9YkHFexLaigCa90igozkPNszjE=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGVL55_1733882979 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:39 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 8/8] RDMA/erdma: Support UD QPs and UD WRs
Date: Wed, 11 Dec 2024 10:09:08 +0800
Message-ID: <20241211020930.68833-9-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
References: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iWARP protocol supports only RC QPs previously. Now we add UD QPs
and UD WRs support for the RoCEv2 protocol.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cq.c    | 20 +++++++
 drivers/infiniband/hw/erdma/erdma_hw.h    | 37 +++++++++++-
 drivers/infiniband/hw/erdma/erdma_qp.c    | 71 ++++++++++++++++++-----
 drivers/infiniband/hw/erdma/erdma_verbs.c | 29 +++++++--
 4 files changed, 136 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index eada882472a3..1f456327e63c 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -105,6 +105,22 @@ static const struct {
 	{ ERDMA_WC_RETRY_EXC_ERR, IB_WC_RETRY_EXC_ERR, ERDMA_WC_VENDOR_NO_ERR },
 };
 
+static void erdma_process_ud_cqe(struct erdma_cqe *cqe, struct ib_wc *wc)
+{
+	u32 ud_info;
+
+	wc->wc_flags |= (IB_WC_GRH | IB_WC_WITH_NETWORK_HDR_TYPE);
+	ud_info = be32_to_cpu(cqe->ud.info);
+	wc->network_hdr_type = FIELD_GET(ERDMA_CQE_NTYPE_MASK, ud_info);
+	if (wc->network_hdr_type == ERDMA_NETWORK_TYPE_IPV4)
+		wc->network_hdr_type = RDMA_NETWORK_IPV4;
+	else
+		wc->network_hdr_type = RDMA_NETWORK_IPV6;
+	wc->src_qp = FIELD_GET(ERDMA_CQE_SQPN_MASK, ud_info);
+	wc->sl = FIELD_GET(ERDMA_CQE_SL_MASK, ud_info);
+	wc->pkey_index = 0;
+}
+
 #define ERDMA_POLLCQ_NO_QP 1
 
 static int erdma_poll_one_cqe(struct erdma_cq *cq, struct ib_wc *wc)
@@ -168,6 +184,10 @@ static int erdma_poll_one_cqe(struct erdma_cq *cq, struct ib_wc *wc)
 		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 	}
 
+	if (erdma_device_rocev2(dev) &&
+	    (qp->ibqp.qp_type == IB_QPT_UD || qp->ibqp.qp_type == IB_QPT_GSI))
+		erdma_process_ud_cqe(cqe, wc);
+
 	if (syndrome >= ERDMA_NUM_WC_STATUS)
 		syndrome = ERDMA_WC_GENERAL_ERR;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 809e77dde271..ea4db53901a4 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -374,6 +374,11 @@ struct erdma_cmdq_query_qp_req_rocev2 {
 	u32 qpn;
 };
 
+enum erdma_qp_type {
+	ERDMA_QPT_RC = 0,
+	ERDMA_QPT_UD = 1,
+};
+
 /* create qp cfg0 */
 #define ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK GENMASK(31, 20)
 #define ERDMA_CMD_CREATE_QP_QPN_MASK GENMASK(19, 0)
@@ -382,6 +387,9 @@ struct erdma_cmdq_query_qp_req_rocev2 {
 #define ERDMA_CMD_CREATE_QP_RQ_DEPTH_MASK GENMASK(31, 20)
 #define ERDMA_CMD_CREATE_QP_PD_MASK GENMASK(19, 0)
 
+/* create qp cfg2 */
+#define ERDMA_CMD_CREATE_QP_TYPE_MASK GENMASK(3, 0)
+
 /* create qp cqn_mtt_cfg */
 #define ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK GENMASK(31, 28)
 #define ERDMA_CMD_CREATE_QP_DB_CFG_MASK BIT(25)
@@ -415,6 +423,7 @@ struct erdma_cmdq_create_qp_req {
 	u64 rq_mtt_entry[3];
 
 	u32 db_cfg;
+	u32 cfg2;
 };
 
 struct erdma_cmdq_destroy_qp_req {
@@ -522,6 +531,10 @@ enum {
 #define ERDMA_CQE_QTYPE_RQ 1
 #define ERDMA_CQE_QTYPE_CMDQ 2
 
+#define ERDMA_CQE_NTYPE_MASK BIT(31)
+#define ERDMA_CQE_SL_MASK GENMASK(27, 20)
+#define ERDMA_CQE_SQPN_MASK GENMASK(19, 0)
+
 struct erdma_cqe {
 	__be32 hdr;
 	__be32 qe_idx;
@@ -531,7 +544,16 @@ struct erdma_cqe {
 		__be32 inv_rkey;
 	};
 	__be32 size;
-	__be32 rsvd[3];
+	union {
+		struct {
+			__be32 rsvd[3];
+		} rc;
+
+		struct {
+			__be32 rsvd[2];
+			__be32 info;
+		} ud;
+	};
 };
 
 struct erdma_sge {
@@ -583,7 +605,7 @@ struct erdma_write_sqe {
 	struct erdma_sge sgl[];
 };
 
-struct erdma_send_sqe {
+struct erdma_send_sqe_rc {
 	__le64 hdr;
 	union {
 		__be32 imm_data;
@@ -594,6 +616,17 @@ struct erdma_send_sqe {
 	struct erdma_sge sgl[];
 };
 
+struct erdma_send_sqe_ud {
+	__le64 hdr;
+	__be32 imm_data;
+	__le32 length;
+	__le32 qkey;
+	__le32 dst_qpn;
+	__le32 ahn;
+	__le32 rsvd;
+	struct erdma_sge sgl[];
+};
+
 struct erdma_readreq_sqe {
 	__le64 hdr;
 	__le32 invalid_stag;
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 03d93f026fca..4dfb4272ad86 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -398,17 +398,57 @@ static int fill_sgl(struct erdma_qp *qp, const struct ib_send_wr *send_wr,
 	return 0;
 }
 
+static void init_send_sqe_rc(struct erdma_qp *qp, struct erdma_send_sqe_rc *sqe,
+			     const struct ib_send_wr *wr, u32 *hw_op)
+{
+	u32 op = ERDMA_OP_SEND;
+
+	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
+		op = ERDMA_OP_SEND_WITH_IMM;
+		sqe->imm_data = wr->ex.imm_data;
+	} else if (op == IB_WR_SEND_WITH_INV) {
+		op = ERDMA_OP_SEND_WITH_INV;
+		sqe->invalid_stag = cpu_to_le32(wr->ex.invalidate_rkey);
+	}
+
+	*hw_op = op;
+}
+
+static void init_send_sqe_ud(struct erdma_qp *qp, struct erdma_send_sqe_ud *sqe,
+			     const struct ib_send_wr *wr, u32 *hw_op)
+{
+	const struct ib_ud_wr *uwr = ud_wr(wr);
+	struct erdma_ah *ah = to_eah(uwr->ah);
+	u32 op = ERDMA_OP_SEND;
+
+	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
+		op = ERDMA_OP_SEND_WITH_IMM;
+		sqe->imm_data = wr->ex.imm_data;
+	}
+
+	*hw_op = op;
+
+	sqe->ahn = cpu_to_le32(ah->ahn);
+	sqe->dst_qpn = cpu_to_le32(uwr->remote_qpn);
+	/* Not allowed to send control qkey */
+	if (uwr->remote_qkey & 0x80000000)
+		sqe->qkey = cpu_to_le32(qp->attrs.rocev2.qkey);
+	else
+		sqe->qkey = cpu_to_le32(uwr->remote_qkey);
+}
+
 static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 			      const struct ib_send_wr *send_wr)
 {
 	u32 wqe_size, wqebb_cnt, hw_op, flags, sgl_offset;
 	u32 idx = *pi & (qp->attrs.sq_size - 1);
 	enum ib_wr_opcode op = send_wr->opcode;
+	struct erdma_send_sqe_rc *rc_send_sqe;
+	struct erdma_send_sqe_ud *ud_send_sqe;
 	struct erdma_atomic_sqe *atomic_sqe;
 	struct erdma_readreq_sqe *read_sqe;
 	struct erdma_reg_mr_sqe *regmr_sge;
 	struct erdma_write_sqe *write_sqe;
-	struct erdma_send_sqe *send_sqe;
 	struct ib_rdma_wr *rdma_wr;
 	struct erdma_sge *sge;
 	__le32 *length_field;
@@ -417,6 +457,10 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 	u32 attrs;
 	int ret;
 
+	if (qp->ibqp.qp_type != IB_QPT_RC && send_wr->opcode != IB_WR_SEND &&
+	    send_wr->opcode != IB_WR_SEND_WITH_IMM)
+		return -EINVAL;
+
 	entry = get_queue_entry(qp->kern_qp.sq_buf, idx, qp->attrs.sq_size,
 				SQEBB_SHIFT);
 
@@ -490,21 +534,20 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 	case IB_WR_SEND:
 	case IB_WR_SEND_WITH_IMM:
 	case IB_WR_SEND_WITH_INV:
-		send_sqe = (struct erdma_send_sqe *)entry;
-		hw_op = ERDMA_OP_SEND;
-		if (op == IB_WR_SEND_WITH_IMM) {
-			hw_op = ERDMA_OP_SEND_WITH_IMM;
-			send_sqe->imm_data = send_wr->ex.imm_data;
-		} else if (op == IB_WR_SEND_WITH_INV) {
-			hw_op = ERDMA_OP_SEND_WITH_INV;
-			send_sqe->invalid_stag =
-				cpu_to_le32(send_wr->ex.invalidate_rkey);
+		if (qp->ibqp.qp_type == IB_QPT_RC) {
+			rc_send_sqe = (struct erdma_send_sqe_rc *)entry;
+			init_send_sqe_rc(qp, rc_send_sqe, send_wr, &hw_op);
+			length_field = &rc_send_sqe->length;
+			wqe_size = sizeof(struct erdma_send_sqe_rc);
+		} else {
+			ud_send_sqe = (struct erdma_send_sqe_ud *)entry;
+			init_send_sqe_ud(qp, ud_send_sqe, send_wr, &hw_op);
+			length_field = &ud_send_sqe->length;
+			wqe_size = sizeof(struct erdma_send_sqe_ud);
 		}
-		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK, hw_op);
-		length_field = &send_sqe->length;
-		wqe_size = sizeof(struct erdma_send_sqe);
-		sgl_offset = wqe_size;
 
+		sgl_offset = wqe_size;
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK, hw_op);
 		break;
 	case IB_WR_REG_MR:
 		wqe_hdr |=
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index e7fd3b948688..e7967193ac82 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -55,6 +55,13 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 			      ilog2(qp->attrs.rq_size)) |
 		   FIELD_PREP(ERDMA_CMD_CREATE_QP_PD_MASK, pd->pdn);
 
+	if (qp->ibqp.qp_type == IB_QPT_RC)
+		req.cfg2 = FIELD_PREP(ERDMA_CMD_CREATE_QP_TYPE_MASK,
+				      ERDMA_QPT_RC);
+	else
+		req.cfg2 = FIELD_PREP(ERDMA_CMD_CREATE_QP_TYPE_MASK,
+				      ERDMA_QPT_UD);
+
 	if (rdma_is_kernel_res(&qp->ibqp.res)) {
 		u32 pgsz_range = ilog2(SZ_1M) - ERDMA_HW_PAGE_SHIFT;
 
@@ -481,7 +488,11 @@ static int erdma_qp_validate_cap(struct erdma_dev *dev,
 static int erdma_qp_validate_attr(struct erdma_dev *dev,
 				  struct ib_qp_init_attr *attrs)
 {
-	if (attrs->qp_type != IB_QPT_RC)
+	if (erdma_device_iwarp(dev) && attrs->qp_type != IB_QPT_RC)
+		return -EOPNOTSUPP;
+
+	if (erdma_device_rocev2(dev) && attrs->qp_type != IB_QPT_RC &&
+	    attrs->qp_type != IB_QPT_UD && attrs->qp_type != IB_QPT_GSI)
 		return -EOPNOTSUPP;
 
 	if (attrs->srq)
@@ -959,7 +970,8 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		udata, struct erdma_ucontext, ibucontext);
 	struct erdma_ureq_create_qp ureq;
 	struct erdma_uresp_create_qp uresp;
-	int ret;
+	void *old_entry;
+	int ret = 0;
 
 	ret = erdma_qp_validate_cap(dev, attrs);
 	if (ret)
@@ -978,9 +990,16 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	kref_init(&qp->ref);
 	init_completion(&qp->safe_free);
 
-	ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
-			      XA_LIMIT(1, dev->attrs.max_qp - 1),
-			      &dev->next_alloc_qpn, GFP_KERNEL);
+	if (qp->ibqp.qp_type == IB_QPT_GSI) {
+		old_entry = xa_store(&dev->qp_xa, 1, qp, GFP_KERNEL);
+		if (xa_is_err(old_entry))
+			ret = xa_err(old_entry);
+	} else {
+		ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
+				      XA_LIMIT(1, dev->attrs.max_qp - 1),
+				      &dev->next_alloc_qpn, GFP_KERNEL);
+	}
+
 	if (ret < 0) {
 		ret = -ENOMEM;
 		goto err_out;
-- 
2.43.5


