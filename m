Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB24F6116
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Apr 2022 16:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiDFN7X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Apr 2022 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiDFN6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Apr 2022 09:58:42 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D101F620C
        for <linux-rdma@vger.kernel.org>; Tue,  5 Apr 2022 19:35:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V9JW3sf_1649212500;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V9JW3sf_1649212500)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 10:35:00 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: [PATCH for-next v5 08/12] RDMA/erdma: Add verbs implementation
Date:   Wed,  6 Apr 2022 10:34:46 +0800
Message-Id: <20220406023450.56683-9-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220406023450.56683-1-chengyou@linux.alibaba.com>
References: <20220406023450.56683-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The RDMA verbs implementation of erdma is divided into three files:
erdma_qp.c, erdma_cq.c, and erdma_verbs.c. Internal used functions and
datapath functions of QP/CQ are put in erdma_qp.c and erdma_cq.c, the rest
is in erdma_verbs.c.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cq.c    |  205 +++
 drivers/infiniband/hw/erdma/erdma_qp.c    |  564 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 1454 +++++++++++++++++++++
 3 files changed, 2223 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c

diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
new file mode 100644
index 000000000000..d7cf42b5271c
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+
+/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
+/*          Kai Shen <kaishen@linux.alibaba.com> */
+/* Copyright (c) 2020-2022, Alibaba Group. */
+
+#include <rdma/ib_verbs.h>
+
+#include "erdma_hw.h"
+#include "erdma_verbs.h"
+
+static void *get_next_valid_cqe(struct erdma_cq *cq)
+{
+	__be32 *cqe = get_queue_entry(cq->kern_cq.qbuf, cq->kern_cq.ci,
+				      cq->depth, CQE_SHIFT);
+	u32 owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK,
+			      __be32_to_cpu(READ_ONCE(*cqe)));
+
+	return owner ^ !!(cq->kern_cq.ci & cq->depth) ? cqe : NULL;
+}
+
+static void notify_cq(struct erdma_cq *cq, u8 solcitied)
+{
+	u64 db_data =
+		FIELD_PREP(ERDMA_CQDB_IDX_MASK, (cq->kern_cq.notify_cnt)) |
+		FIELD_PREP(ERDMA_CQDB_CQN_MASK, cq->cqn) |
+		FIELD_PREP(ERDMA_CQDB_ARM_MASK, 1) |
+		FIELD_PREP(ERDMA_CQDB_SOL_MASK, solcitied) |
+		FIELD_PREP(ERDMA_CQDB_CMDSN_MASK, cq->kern_cq.cmdsn) |
+		FIELD_PREP(ERDMA_CQDB_CI_MASK, cq->kern_cq.ci);
+
+	*cq->kern_cq.db_record = db_data;
+	writeq(db_data, cq->kern_cq.db);
+}
+
+int erdma_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
+{
+	struct erdma_cq *cq = to_ecq(ibcq);
+	unsigned long irq_flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&cq->kern_cq.lock, irq_flags);
+
+	notify_cq(cq, (flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED);
+
+	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && get_next_valid_cqe(cq))
+		ret = 1;
+
+	cq->kern_cq.notify_cnt++;
+
+	spin_unlock_irqrestore(&cq->kern_cq.lock, irq_flags);
+
+	return ret;
+}
+
+static const enum ib_wc_opcode wc_mapping_table[ERDMA_NUM_OPCODES] = {
+	[ERDMA_OP_WRITE] = IB_WC_RDMA_WRITE,
+	[ERDMA_OP_READ] = IB_WC_RDMA_READ,
+	[ERDMA_OP_SEND] = IB_WC_SEND,
+	[ERDMA_OP_SEND_WITH_IMM] = IB_WC_SEND,
+	[ERDMA_OP_RECEIVE] = IB_WC_RECV,
+	[ERDMA_OP_RECV_IMM] = IB_WC_RECV_RDMA_WITH_IMM,
+	[ERDMA_OP_RECV_INV] = IB_WC_RECV,
+	[ERDMA_OP_WRITE_WITH_IMM] = IB_WC_RDMA_WRITE,
+	[ERDMA_OP_INVALIDATE] = IB_WC_LOCAL_INV,
+	[ERDMA_OP_RSP_SEND_IMM] = IB_WC_RECV,
+	[ERDMA_OP_SEND_WITH_INV] = IB_WC_SEND,
+	[ERDMA_OP_REG_MR] = IB_WC_REG_MR,
+	[ERDMA_OP_LOCAL_INV] = IB_WC_LOCAL_INV,
+	[ERDMA_OP_READ_WITH_INV] = IB_WC_RDMA_READ,
+};
+
+static const struct {
+	enum erdma_wc_status erdma;
+	enum ib_wc_status base;
+	enum erdma_vendor_err vendor;
+} map_cqe_status[ERDMA_NUM_WC_STATUS] = {
+	{ ERDMA_WC_SUCCESS, IB_WC_SUCCESS, ERDMA_WC_VENDOR_NO_ERR },
+	{ ERDMA_WC_GENERAL_ERR, IB_WC_GENERAL_ERR, ERDMA_WC_VENDOR_NO_ERR },
+	{ ERDMA_WC_RECV_WQE_FORMAT_ERR, IB_WC_GENERAL_ERR,
+	  ERDMA_WC_VENDOR_INVALID_RQE },
+	{ ERDMA_WC_RECV_STAG_INVALID_ERR, IB_WC_REM_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_RQE_INVALID_STAG },
+	{ ERDMA_WC_RECV_ADDR_VIOLATION_ERR, IB_WC_REM_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_RQE_ADDR_VIOLATION },
+	{ ERDMA_WC_RECV_RIGHT_VIOLATION_ERR, IB_WC_REM_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_RQE_ACCESS_RIGHT_ERR },
+	{ ERDMA_WC_RECV_PDID_ERR, IB_WC_REM_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_RQE_INVALID_PD },
+	{ ERDMA_WC_RECV_WARRPING_ERR, IB_WC_REM_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_RQE_WRAP_ERR },
+	{ ERDMA_WC_SEND_WQE_FORMAT_ERR, IB_WC_LOC_QP_OP_ERR,
+	  ERDMA_WC_VENDOR_INVALID_SQE },
+	{ ERDMA_WC_SEND_WQE_ORD_EXCEED, IB_WC_GENERAL_ERR,
+	  ERDMA_WC_VENDOR_ZERO_ORD },
+	{ ERDMA_WC_SEND_STAG_INVALID_ERR, IB_WC_LOC_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_SQE_INVALID_STAG },
+	{ ERDMA_WC_SEND_ADDR_VIOLATION_ERR, IB_WC_LOC_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_SQE_ADDR_VIOLATION },
+	{ ERDMA_WC_SEND_RIGHT_VIOLATION_ERR, IB_WC_LOC_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_SQE_ACCESS_ERR },
+	{ ERDMA_WC_SEND_PDID_ERR, IB_WC_LOC_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_SQE_INVALID_PD },
+	{ ERDMA_WC_SEND_WARRPING_ERR, IB_WC_LOC_ACCESS_ERR,
+	  ERDMA_WC_VENDOR_SQE_WARP_ERR },
+	{ ERDMA_WC_FLUSH_ERR, IB_WC_WR_FLUSH_ERR, ERDMA_WC_VENDOR_NO_ERR },
+	{ ERDMA_WC_RETRY_EXC_ERR, IB_WC_RETRY_EXC_ERR, ERDMA_WC_VENDOR_NO_ERR },
+};
+
+#define ERDMA_POLLCQ_NO_QP 1
+
+static int erdma_poll_one_cqe(struct erdma_cq *cq, struct ib_wc *wc)
+{
+	struct erdma_dev *dev = to_edev(cq->ibcq.device);
+	u8 opcode, syndrome, qtype;
+	struct erdma_kqp *kern_qp;
+	struct erdma_cqe *cqe;
+	struct erdma_qp *qp;
+	u16 wqe_idx, depth;
+	u32 qpn, cqe_hdr;
+	u64 *id_table;
+	u64 *wqe_hdr;
+
+	cqe = get_next_valid_cqe(cq);
+	if (!cqe)
+		return -EAGAIN;
+
+	cq->kern_cq.ci++;
+
+	/* cqbuf should be ready when we poll */
+	dma_rmb();
+
+	qpn = be32_to_cpu(cqe->qpn);
+	wqe_idx = be32_to_cpu(cqe->qe_idx);
+	cqe_hdr = be32_to_cpu(cqe->hdr);
+
+	qp = find_qp_by_qpn(dev, qpn);
+	if (!qp)
+		return ERDMA_POLLCQ_NO_QP;
+
+	kern_qp = &qp->kern_qp;
+
+	qtype = FIELD_GET(ERDMA_CQE_HDR_QTYPE_MASK, cqe_hdr);
+	syndrome = FIELD_GET(ERDMA_CQE_HDR_SYNDROME_MASK, cqe_hdr);
+	opcode = FIELD_GET(ERDMA_CQE_HDR_OPCODE_MASK, cqe_hdr);
+
+	if (qtype == ERDMA_CQE_QTYPE_SQ) {
+		id_table = kern_qp->swr_tbl;
+		depth = qp->attrs.sq_size;
+		wqe_hdr = get_queue_entry(qp->kern_qp.sq_buf, wqe_idx,
+					  qp->attrs.sq_size, SQEBB_SHIFT);
+		kern_qp->sq_ci =
+			FIELD_GET(ERDMA_SQE_HDR_WQEBB_CNT_MASK, *wqe_hdr) +
+			wqe_idx + 1;
+	} else {
+		id_table = kern_qp->rwr_tbl;
+		depth = qp->attrs.rq_size;
+	}
+	wc->wr_id = id_table[wqe_idx & (depth - 1)];
+	wc->byte_len = be32_to_cpu(cqe->size);
+
+	wc->wc_flags = 0;
+
+	wc->opcode = wc_mapping_table[opcode];
+	if (opcode == ERDMA_OP_RECV_IMM || opcode == ERDMA_OP_RSP_SEND_IMM) {
+		wc->ex.imm_data = cpu_to_be32(cqe->imm_data);
+		wc->wc_flags |= IB_WC_WITH_IMM;
+	} else if (opcode == ERDMA_OP_RECV_INV) {
+		wc->ex.invalidate_rkey = be32_to_cpu(cqe->inv_rkey);
+		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
+	}
+
+	if (syndrome >= ERDMA_NUM_WC_STATUS)
+		syndrome = ERDMA_WC_GENERAL_ERR;
+
+	wc->status = map_cqe_status[syndrome].base;
+	wc->vendor_err = map_cqe_status[syndrome].vendor;
+	wc->qp = &qp->ibqp;
+
+	return 0;
+}
+
+int erdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
+{
+	struct erdma_cq *cq = to_ecq(ibcq);
+	unsigned long flags;
+	int npolled, ret;
+
+	spin_lock_irqsave(&cq->kern_cq.lock, flags);
+
+	for (npolled = 0; npolled < num_entries;) {
+		ret = erdma_poll_one_cqe(cq, wc + npolled);
+
+		if (ret == -EAGAIN) /* no received new CQEs. */
+			break;
+		else if (ret) /* ignore invalid CQEs. */
+			continue;
+
+		npolled++;
+	}
+
+	spin_unlock_irqrestore(&cq->kern_cq.lock, flags);
+
+	return npolled;
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
new file mode 100644
index 000000000000..44bafb4b8c65
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+
+/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
+/*          Kai Shen <kaishen@linux.alibaba.com> */
+/* Copyright (c) 2020-2021, Alibaba Group */
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/scatterlist.h>
+#include <linux/types.h>
+
+#include <rdma/iw_cm.h>
+#include <rdma/ib_user_verbs.h>
+#include <rdma/ib_verbs.h>
+
+#include "erdma.h"
+#include "erdma_cm.h"
+#include "erdma_verbs.h"
+
+void erdma_qp_llp_close(struct erdma_qp *qp)
+{
+	struct erdma_qp_attrs qp_attrs;
+
+	down_write(&qp->state_lock);
+
+	switch (qp->attrs.state) {
+	case ERDMA_QP_STATE_RTS:
+	case ERDMA_QP_STATE_RTR:
+	case ERDMA_QP_STATE_IDLE:
+	case ERDMA_QP_STATE_TERMINATE:
+		qp_attrs.state = ERDMA_QP_STATE_CLOSING;
+		erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
+		break;
+	case ERDMA_QP_STATE_CLOSING:
+		qp->attrs.state = ERDMA_QP_STATE_IDLE;
+		break;
+	default:
+		break;
+	}
+
+	if (qp->cep) {
+		erdma_cep_put(qp->cep);
+		qp->cep = NULL;
+	}
+
+	up_write(&qp->state_lock);
+}
+
+struct ib_qp *erdma_get_ibqp(struct ib_device *ibdev, int id)
+{
+	struct erdma_qp *qp = find_qp_by_qpn(to_edev(ibdev), id);
+
+	if (qp)
+		return &qp->ibqp;
+
+	return NULL;
+}
+
+static int erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
+					struct erdma_qp_attrs *attrs,
+					enum erdma_qp_attr_mask mask)
+{
+	int ret;
+	struct erdma_dev *dev = qp->dev;
+	struct erdma_cmdq_modify_qp_req req;
+	struct tcp_sock *tp;
+	struct erdma_cep *cep = qp->cep;
+	struct sockaddr_storage local_addr, remote_addr;
+
+	if (!(mask & ERDMA_QP_ATTR_LLP_HANDLE))
+		return -EINVAL;
+
+	if (!(mask & ERDMA_QP_ATTR_MPA))
+		return -EINVAL;
+
+	ret = getname_local(cep->sock, &local_addr);
+	if (ret < 0)
+		return ret;
+
+	ret = getname_peer(cep->sock, &remote_addr);
+	if (ret < 0)
+		return ret;
+
+	qp->attrs.state = ERDMA_QP_STATE_RTS;
+
+	tp = tcp_sk(qp->cep->sock->sk);
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_MODIFY_QP);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, qp->attrs.state) |
+		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_CC_MASK, qp->attrs.cc) |
+		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
+
+	req.cookie = qp->cep->mpa.ext_data.cookie;
+	req.dip = to_sockaddr_in(remote_addr).sin_addr.s_addr;
+	req.sip = to_sockaddr_in(local_addr).sin_addr.s_addr;
+	req.dport = to_sockaddr_in(remote_addr).sin_port;
+	req.sport = to_sockaddr_in(local_addr).sin_port;
+
+	req.send_nxt = tp->snd_nxt;
+	/* rsvd tcp seq for mpa-rsp in server. */
+	if (qp->attrs.qp_type == ERDMA_QP_PASSIVE)
+		req.send_nxt += MPA_DEFAULT_HDR_LEN + qp->attrs.pd_len;
+	req.recv_nxt = tp->rcv_nxt;
+
+	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				   NULL);
+}
+
+static int erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
+					 struct erdma_qp_attrs *attrs,
+					 enum erdma_qp_attr_mask mask)
+{
+	struct erdma_dev *dev = qp->dev;
+	struct erdma_cmdq_modify_qp_req req;
+
+	qp->attrs.state = attrs->state;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_MODIFY_QP);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, attrs->state) |
+		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
+
+	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				   NULL);
+}
+
+int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
+			     enum erdma_qp_attr_mask mask)
+{
+	int drop_conn, ret = 0;
+
+	if (!mask)
+		return 0;
+
+	if (!(mask & ERDMA_QP_ATTR_STATE))
+		return 0;
+
+	switch (qp->attrs.state) {
+	case ERDMA_QP_STATE_IDLE:
+	case ERDMA_QP_STATE_RTR:
+		if (attrs->state == ERDMA_QP_STATE_RTS) {
+			ret = erdma_modify_qp_state_to_rts(qp, attrs, mask);
+		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
+			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+			if (qp->cep) {
+				erdma_cep_put(qp->cep);
+				qp->cep = NULL;
+			}
+			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+		}
+		break;
+	case ERDMA_QP_STATE_RTS:
+		drop_conn = 0;
+
+		if (attrs->state == ERDMA_QP_STATE_CLOSING) {
+			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+			drop_conn = 1;
+		} else if (attrs->state == ERDMA_QP_STATE_TERMINATE) {
+			qp->attrs.state = ERDMA_QP_STATE_TERMINATE;
+			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+			drop_conn = 1;
+		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
+			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+			drop_conn = 1;
+		}
+
+		if (drop_conn)
+			erdma_qp_cm_drop(qp);
+
+		break;
+	case ERDMA_QP_STATE_TERMINATE:
+		if (attrs->state == ERDMA_QP_STATE_ERROR)
+			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+		break;
+	case ERDMA_QP_STATE_CLOSING:
+		if (attrs->state == ERDMA_QP_STATE_IDLE) {
+			qp->attrs.state = ERDMA_QP_STATE_IDLE;
+		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
+			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+		} else if (attrs->state != ERDMA_QP_STATE_CLOSING) {
+			return -ECONNABORTED;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void erdma_qp_safe_free(struct kref *ref)
+{
+	struct erdma_qp *qp = container_of(ref, struct erdma_qp, ref);
+
+	complete(&qp->safe_free);
+}
+
+void erdma_qp_put(struct erdma_qp *qp)
+{
+	WARN_ON(kref_read(&qp->ref) < 1);
+	kref_put(&qp->ref, erdma_qp_safe_free);
+}
+
+void erdma_qp_get(struct erdma_qp *qp)
+{
+	kref_get(&qp->ref);
+}
+
+static int fill_inline_data(struct erdma_qp *qp,
+			    const struct ib_send_wr *send_wr, u16 wqe_idx,
+			    u32 sgl_offset, u32 *length_field)
+{
+	int i = 0;
+	char *data;
+	u32 remain_size, copy_size, data_off, bytes = 0;
+
+	wqe_idx += (sgl_offset >> SQEBB_SHIFT);
+	sgl_offset &= (SQEBB_SIZE - 1);
+	data = get_queue_entry(qp->kern_qp.sq_buf, wqe_idx, qp->attrs.sq_size,
+			       SQEBB_SHIFT);
+
+	while (i < send_wr->num_sge) {
+		bytes += send_wr->sg_list[i].length;
+		if (bytes > (int)ERDMA_MAX_INLINE)
+			return -EINVAL;
+
+		remain_size = send_wr->sg_list[i].length;
+		data_off = 0;
+
+		while (1) {
+			copy_size = min(remain_size, SQEBB_SIZE - sgl_offset);
+
+			memcpy(data + sgl_offset,
+			       (void *)(uintptr_t)send_wr->sg_list[i].addr +
+				       data_off,
+			       copy_size);
+			remain_size -= copy_size;
+			data_off += copy_size;
+			sgl_offset += copy_size;
+			wqe_idx += (sgl_offset >> SQEBB_SHIFT);
+			sgl_offset &= (SQEBB_SIZE - 1);
+
+			data = get_queue_entry(qp->kern_qp.sq_buf, wqe_idx,
+					       qp->attrs.sq_size, SQEBB_SHIFT);
+			if (!remain_size)
+				break;
+		};
+
+		i++;
+	}
+	*length_field = bytes;
+
+	return bytes;
+}
+
+static int fill_sgl(struct erdma_qp *qp, const struct ib_send_wr *send_wr,
+		    u16 wqe_idx, u32 sgl_offset, u32 *length_field)
+{
+	int i = 0;
+	u32 bytes = 0;
+	char *sgl;
+
+	if (send_wr->num_sge > qp->dev->attrs.max_send_sge)
+		return -EINVAL;
+
+	if (sgl_offset & 0xF)
+		return -EINVAL;
+
+	while (i < send_wr->num_sge) {
+		wqe_idx += (sgl_offset >> SQEBB_SHIFT);
+		sgl_offset &= (SQEBB_SIZE - 1);
+		sgl = get_queue_entry(qp->kern_qp.sq_buf, wqe_idx,
+				      qp->attrs.sq_size, SQEBB_SHIFT);
+
+		bytes += send_wr->sg_list[i].length;
+		memcpy(sgl + sgl_offset, &send_wr->sg_list[i],
+		       sizeof(struct ib_sge));
+
+		sgl_offset += sizeof(struct ib_sge);
+		i++;
+	}
+
+	*length_field = bytes;
+	return 0;
+}
+
+static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
+			      const struct ib_send_wr *send_wr)
+{
+	u32 wqe_size, wqebb_cnt, hw_op, flags, sgl_offset, *length_field;
+	u32 idx = *pi & (qp->attrs.sq_size - 1);
+	enum ib_wr_opcode op = send_wr->opcode;
+	struct erdma_readreq_sqe *read_sqe;
+	struct erdma_reg_mr_sqe *regmr_sge;
+	struct erdma_write_sqe *write_sqe;
+	struct erdma_send_sqe *send_sqe;
+	struct ib_rdma_wr *rdma_wr;
+	struct erdma_mr *mr;
+	u64 wqe_hdr, *entry;
+	struct ib_sge *sge;
+	int ret;
+
+	entry = get_queue_entry(qp->kern_qp.sq_buf, idx, qp->attrs.sq_size,
+				SQEBB_SHIFT);
+
+	/* Clear the SQE header section. */
+	*entry = 0;
+
+	qp->kern_qp.swr_tbl[idx] = send_wr->wr_id;
+	flags = send_wr->send_flags;
+	wqe_hdr = FIELD_PREP(
+		ERDMA_SQE_HDR_CE_MASK,
+		((flags & IB_SEND_SIGNALED) || qp->kern_qp.sig_all) ? 1 : 0);
+	wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_SE_MASK,
+			      flags & IB_SEND_SOLICITED ? 1 : 0);
+	wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_FENCE_MASK,
+			      flags & IB_SEND_FENCE ? 1 : 0);
+	wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_INLINE_MASK,
+			      flags & IB_SEND_INLINE ? 1 : 0);
+	wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, QP_ID(qp));
+
+	switch (op) {
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		hw_op = ERDMA_OP_WRITE;
+		if (op == IB_WR_RDMA_WRITE_WITH_IMM)
+			hw_op = ERDMA_OP_WRITE_WITH_IMM;
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK, hw_op);
+		rdma_wr = container_of(send_wr, struct ib_rdma_wr, wr);
+		write_sqe = (struct erdma_write_sqe *)entry;
+
+		write_sqe->imm_data = send_wr->ex.imm_data;
+		write_sqe->sink_stag = rdma_wr->rkey;
+		write_sqe->sink_to_h = upper_32_bits(rdma_wr->remote_addr);
+		write_sqe->sink_to_l = lower_32_bits(rdma_wr->remote_addr);
+
+		length_field = &write_sqe->length;
+		wqe_size = sizeof(struct erdma_write_sqe);
+		sgl_offset = wqe_size;
+		break;
+	case IB_WR_RDMA_READ:
+	case IB_WR_RDMA_READ_WITH_INV:
+		read_sqe = (struct erdma_readreq_sqe *)entry;
+		if (unlikely(send_wr->num_sge != 1))
+			return -EINVAL;
+		hw_op = ERDMA_OP_READ;
+		if (op == IB_WR_RDMA_READ_WITH_INV) {
+			hw_op = ERDMA_OP_READ_WITH_INV;
+			read_sqe->invalid_stag = send_wr->ex.invalidate_rkey;
+		}
+
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK, hw_op);
+		rdma_wr = container_of(send_wr, struct ib_rdma_wr, wr);
+		read_sqe->length = send_wr->sg_list[0].length;
+		read_sqe->sink_stag = send_wr->sg_list[0].lkey;
+		read_sqe->sink_to_l = lower_32_bits(send_wr->sg_list[0].addr);
+		read_sqe->sink_to_h = upper_32_bits(send_wr->sg_list[0].addr);
+
+		sge = get_queue_entry(qp->kern_qp.sq_buf, idx + 1,
+				      qp->attrs.sq_size, SQEBB_SHIFT);
+		sge->addr = rdma_wr->remote_addr;
+		sge->lkey = rdma_wr->rkey;
+		sge->length = send_wr->sg_list[0].length;
+		wqe_size = sizeof(struct erdma_readreq_sqe) +
+			   send_wr->num_sge * sizeof(struct ib_sge);
+
+		goto out;
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+	case IB_WR_SEND_WITH_INV:
+		send_sqe = (struct erdma_send_sqe *)entry;
+		hw_op = ERDMA_OP_SEND;
+		if (op == IB_WR_SEND_WITH_IMM) {
+			hw_op = ERDMA_OP_SEND_WITH_IMM;
+			send_sqe->imm_data = send_wr->ex.imm_data;
+		} else if (op == IB_WR_SEND_WITH_INV) {
+			hw_op = ERDMA_OP_SEND_WITH_INV;
+			send_sqe->imm_data = send_wr->ex.invalidate_rkey;
+		}
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK, hw_op);
+		length_field = &send_sqe->length;
+		wqe_size = sizeof(struct erdma_send_sqe);
+		sgl_offset = wqe_size;
+
+		break;
+	case IB_WR_REG_MR:
+		wqe_hdr |=
+			FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK, ERDMA_OP_REG_MR);
+		regmr_sge = (struct erdma_reg_mr_sqe *)entry;
+		mr = to_emr(reg_wr(send_wr)->mr);
+
+		mr->access = ERDMA_MR_ACC_LR |
+			     to_erdma_access_flags(reg_wr(send_wr)->access);
+		regmr_sge->addr = mr->ibmr.iova;
+		regmr_sge->length = mr->ibmr.length;
+		regmr_sge->stag = mr->ibmr.lkey;
+		regmr_sge->attrs =
+			FIELD_PREP(ERDMA_SQE_MR_MODE_MASK, 0) |
+			FIELD_PREP(ERDMA_SQE_MR_ACCESS_MASK, mr->access) |
+			FIELD_PREP(ERDMA_SQE_MR_MTT_CNT_MASK,
+				   mr->mem.mtt_nents);
+
+		if (mr->mem.mtt_nents < ERDMA_MAX_INLINE_MTT_ENTRIES) {
+			regmr_sge->attrs |=
+				FIELD_PREP(ERDMA_SQE_MR_MTT_TYPE_MASK, 0);
+			/* Copy SGLs to SQE content to accelerate */
+			memcpy(get_queue_entry(qp->kern_qp.sq_buf, idx + 1,
+					       qp->attrs.sq_size, SQEBB_SHIFT),
+			       mr->mem.mtt_buf, MTT_SIZE(mr->mem.mtt_nents));
+			wqe_size = sizeof(struct erdma_reg_mr_sqe) +
+				   MTT_SIZE(mr->mem.mtt_nents);
+		} else {
+			regmr_sge->attrs |=
+				FIELD_PREP(ERDMA_SQE_MR_MTT_TYPE_MASK, 1);
+			wqe_size = sizeof(struct erdma_reg_mr_sqe);
+		}
+
+		goto out;
+	case IB_WR_LOCAL_INV:
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
+				      ERDMA_OP_LOCAL_INV);
+		regmr_sge = (struct erdma_reg_mr_sqe *)entry;
+		regmr_sge->stag = send_wr->ex.invalidate_rkey;
+		wqe_size = sizeof(struct erdma_reg_mr_sqe);
+		goto out;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (flags & IB_SEND_INLINE) {
+		ret = fill_inline_data(qp, send_wr, idx, sgl_offset,
+				       length_field);
+		if (ret < 0)
+			return -EINVAL;
+		wqe_size += ret;
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_SGL_LEN_MASK, ret);
+	} else {
+		ret = fill_sgl(qp, send_wr, idx, sgl_offset, length_field);
+		if (ret)
+			return -EINVAL;
+		wqe_size += send_wr->num_sge * sizeof(struct ib_sge);
+		wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_SGL_LEN_MASK,
+				      send_wr->num_sge);
+	}
+
+out:
+	wqebb_cnt = SQEBB_COUNT(wqe_size);
+	wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_WQEBB_CNT_MASK, wqebb_cnt - 1);
+	*pi += wqebb_cnt;
+	wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK, *pi);
+
+	*entry = wqe_hdr;
+
+	return 0;
+}
+
+static void kick_sq_db(struct erdma_qp *qp, u16 pi)
+{
+	u64 db_data = FIELD_PREP(ERDMA_SQE_HDR_QPN_MASK, QP_ID(qp)) |
+		      FIELD_PREP(ERDMA_SQE_HDR_WQEBB_INDEX_MASK, pi);
+
+	*(u64 *)qp->kern_qp.sq_db_info = db_data;
+	writeq(db_data, qp->kern_qp.hw_sq_db);
+}
+
+int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
+		    const struct ib_send_wr **bad_send_wr)
+{
+	struct erdma_qp *qp = to_eqp(ibqp);
+	int ret = 0;
+	const struct ib_send_wr *wr = send_wr;
+	unsigned long flags;
+	u16 sq_pi;
+
+	if (!send_wr)
+		return -EINVAL;
+
+	spin_lock_irqsave(&qp->lock, flags);
+	sq_pi = qp->kern_qp.sq_pi;
+
+	while (wr) {
+		if ((u16)(sq_pi - qp->kern_qp.sq_ci) >= qp->attrs.sq_size) {
+			ret = -ENOMEM;
+			*bad_send_wr = send_wr;
+			break;
+		}
+
+		ret = erdma_push_one_sqe(qp, &sq_pi, wr);
+		if (ret) {
+			*bad_send_wr = wr;
+			break;
+		}
+		qp->kern_qp.sq_pi = sq_pi;
+		kick_sq_db(qp, sq_pi);
+
+		wr = wr->next;
+	}
+	spin_unlock_irqrestore(&qp->lock, flags);
+
+	return ret;
+}
+
+static int erdma_post_recv_one(struct erdma_qp *qp,
+			       const struct ib_recv_wr *recv_wr)
+{
+	struct erdma_rqe *rqe;
+	unsigned int rq_pi;
+	u16 idx;
+
+	rq_pi = qp->kern_qp.rq_pi;
+	idx = rq_pi & (qp->attrs.rq_size - 1);
+	rqe = (struct erdma_rqe *)qp->kern_qp.rq_buf + idx;
+
+	rqe->qe_idx = rq_pi + 1;
+	rqe->qpn = QP_ID(qp);
+
+	if (recv_wr->num_sge == 0) {
+		rqe->length = 0;
+	} else if (recv_wr->num_sge == 1) {
+		rqe->stag = recv_wr->sg_list[0].lkey;
+		rqe->to = recv_wr->sg_list[0].addr;
+		rqe->length = recv_wr->sg_list[0].length;
+	} else {
+		return -EINVAL;
+	}
+
+	*(u64 *)qp->kern_qp.rq_db_info = *(u64 *)rqe;
+	writeq(*(u64 *)rqe, qp->kern_qp.hw_rq_db);
+
+	qp->kern_qp.rwr_tbl[idx] = recv_wr->wr_id;
+	qp->kern_qp.rq_pi = rq_pi + 1;
+
+	return 0;
+}
+
+int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
+		    const struct ib_recv_wr **bad_recv_wr)
+{
+	const struct ib_recv_wr *wr = recv_wr;
+	struct erdma_qp *qp = to_eqp(ibqp);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&qp->lock, flags);
+
+	while (wr) {
+		ret = erdma_post_recv_one(qp, wr);
+		if (ret) {
+			*bad_recv_wr = wr;
+			break;
+		}
+		wr = wr->next;
+	}
+
+	spin_unlock_irqrestore(&qp->lock, flags);
+	return ret;
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
new file mode 100644
index 000000000000..d45b7bd44cec
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -0,0 +1,1454 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
+/*          Kai Shen <kaishen@linux.alibaba.com> */
+/* Copyright (c) 2020-2022, Alibaba Group. */
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+/* Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved. */
+
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <net/addrconf.h>
+#include <rdma/erdma-abi.h>
+#include <rdma/iw_cm.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_smi.h>
+#include <rdma/ib_umem.h>
+#include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
+
+#include "erdma.h"
+#include "erdma_cm.h"
+#include "erdma_hw.h"
+#include "erdma_verbs.h"
+
+static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
+{
+	struct erdma_cmdq_create_qp_req req;
+	struct erdma_pd *pd = to_epd(qp->ibqp.pd);
+	struct erdma_uqp *user_qp;
+	u64 resp0, resp1;
+	int err;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_CREATE_QP);
+
+	req.cfg0 = FIELD_PREP(ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK,
+			      ilog2(qp->attrs.sq_size)) |
+		   FIELD_PREP(ERDMA_CMD_CREATE_QP_QPN_MASK, QP_ID(qp));
+	req.cfg1 = FIELD_PREP(ERDMA_CMD_CREATE_QP_RQ_DEPTH_MASK,
+			      ilog2(qp->attrs.rq_size)) |
+		   FIELD_PREP(ERDMA_CMD_CREATE_QP_PD_MASK, pd->pdn);
+
+	if (rdma_is_kernel_res(&qp->ibqp.res)) {
+		u32 pgsz_range = ilog2(SZ_1M) - PAGE_SHIFT;
+
+		req.sq_cqn_mtt_cfg =
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
+				   pgsz_range) |
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->scq->cqn);
+		req.rq_cqn_mtt_cfg =
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
+				   pgsz_range) |
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->rcq->cqn);
+
+		req.sq_mtt_cfg =
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_OFFSET_MASK, 0) |
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_CNT_MASK, 1) |
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
+				   ERDMA_MR_INLINE_MTT);
+		req.rq_mtt_cfg = req.sq_mtt_cfg;
+
+		req.rq_buf_addr = qp->kern_qp.rq_buf_dma_addr;
+		req.sq_buf_addr = qp->kern_qp.sq_buf_dma_addr;
+		req.sq_db_info_dma_addr = qp->kern_qp.sq_buf_dma_addr +
+					  (SQEBB_SHIFT << qp->attrs.sq_size);
+		req.rq_db_info_dma_addr = qp->kern_qp.rq_buf_dma_addr +
+					  (RQE_SHIFT << qp->attrs.rq_size);
+	} else {
+		user_qp = &qp->user_qp;
+		req.sq_cqn_mtt_cfg = FIELD_PREP(
+			ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
+			ilog2(user_qp->sq_mtt.page_size) - PAGE_SHIFT);
+		req.sq_cqn_mtt_cfg |=
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->scq->cqn);
+
+		req.rq_cqn_mtt_cfg = FIELD_PREP(
+			ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
+			ilog2(user_qp->rq_mtt.page_size) - PAGE_SHIFT);
+		req.rq_cqn_mtt_cfg |=
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->rcq->cqn);
+
+		req.sq_mtt_cfg = user_qp->sq_mtt.page_offset;
+		req.sq_mtt_cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_CNT_MASK,
+					     user_qp->sq_mtt.mtt_nents) |
+				  FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
+					     user_qp->sq_mtt.mtt_type);
+
+		req.rq_mtt_cfg = user_qp->rq_mtt.page_offset;
+		req.rq_mtt_cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_CNT_MASK,
+					     user_qp->rq_mtt.mtt_nents) |
+				  FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
+					     user_qp->rq_mtt.mtt_type);
+
+		req.sq_buf_addr = user_qp->sq_mtt.mtt_entry[0];
+		req.rq_buf_addr = user_qp->rq_mtt.mtt_entry[0];
+
+		req.sq_db_info_dma_addr = user_qp->sq_db_info_dma_addr;
+		req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
+	}
+
+	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), &resp0,
+				  &resp1);
+
+	qp->attrs.cookie =
+		FIELD_GET(ERDMA_CMDQ_CREATE_QP_RESP_COOKIE_MASK, resp0);
+
+	return err;
+}
+
+static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
+{
+	struct erdma_cmdq_reg_mr_req req;
+	struct erdma_pd *pd = to_epd(mr->ibmr.pd);
+	u64 *phy_addr;
+	int i;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA, CMDQ_OPCODE_REG_MR);
+
+	req.cfg0 = FIELD_PREP(ERDMA_CMD_MR_VALID_MASK, mr->valid) |
+		   FIELD_PREP(ERDMA_CMD_MR_KEY_MASK, mr->ibmr.lkey & 0xFF) |
+		   FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, mr->ibmr.lkey >> 8);
+	req.cfg1 = FIELD_PREP(ERDMA_CMD_REGMR_PD_MASK, pd->pdn) |
+		   FIELD_PREP(ERDMA_CMD_REGMR_TYPE_MASK, mr->type) |
+		   FIELD_PREP(ERDMA_CMD_REGMR_RIGHT_MASK, mr->access) |
+		   FIELD_PREP(ERDMA_CMD_REGMR_ACC_MODE_MASK, 0);
+	req.cfg2 = FIELD_PREP(ERDMA_CMD_REGMR_PAGESIZE_MASK,
+			      ilog2(mr->mem.page_size)) |
+		   FIELD_PREP(ERDMA_CMD_REGMR_MTT_TYPE_MASK, mr->mem.mtt_type) |
+		   FIELD_PREP(ERDMA_CMD_REGMR_MTT_CNT_MASK, mr->mem.page_cnt);
+
+	if (mr->type == ERDMA_MR_TYPE_DMA)
+		goto post_cmd;
+
+	if (mr->type == ERDMA_MR_TYPE_NORMAL) {
+		req.start_va = mr->mem.va;
+		req.size = mr->mem.len;
+	}
+
+	if (mr->type == ERDMA_MR_TYPE_FRMR ||
+	    mr->mem.mtt_type == ERDMA_MR_INDIRECT_MTT) {
+		phy_addr = req.phy_addr;
+		*phy_addr = mr->mem.mtt_entry[0];
+	} else {
+		phy_addr = req.phy_addr;
+		for (i = 0; i < mr->mem.mtt_nents; i++)
+			*phy_addr++ = mr->mem.mtt_entry[i];
+	}
+
+post_cmd:
+	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				   NULL);
+}
+
+static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
+{
+	struct erdma_cmdq_create_cq_req req;
+	u32 page_size;
+	struct erdma_mem *mtt;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_CREATE_CQ);
+
+	req.cfg0 = FIELD_PREP(ERDMA_CMD_CREATE_CQ_CQN_MASK, cq->cqn) |
+		   FIELD_PREP(ERDMA_CMD_CREATE_CQ_DEPTH_MASK, ilog2(cq->depth));
+	req.cfg1 = FIELD_PREP(ERDMA_CMD_CREATE_CQ_EQN_MASK, cq->assoc_eqn);
+
+	if (rdma_is_kernel_res(&cq->ibcq.res)) {
+		page_size = SZ_32M;
+		req.cfg0 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
+				       ilog2(page_size) - PAGE_SHIFT);
+		req.qbuf_addr_l = lower_32_bits(cq->kern_cq.qbuf_dma_addr);
+		req.qbuf_addr_h = upper_32_bits(cq->kern_cq.qbuf_dma_addr);
+
+		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK, 1) |
+			    FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_TYPE_MASK,
+				       ERDMA_MR_INLINE_MTT);
+
+		req.first_page_offset = 0;
+		req.cq_db_info_addr =
+			cq->kern_cq.qbuf_dma_addr + (cq->depth << CQE_SHIFT);
+	} else {
+		mtt = &cq->user_cq.qbuf_mtt;
+		req.cfg0 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
+				       ilog2(mtt->page_size) - PAGE_SHIFT);
+		if (mtt->mtt_nents == 1) {
+			req.qbuf_addr_l = lower_32_bits(*(u64 *)mtt->mtt_buf);
+			req.qbuf_addr_h = upper_32_bits(*(u64 *)mtt->mtt_buf);
+		} else {
+			req.qbuf_addr_l = lower_32_bits(mtt->mtt_entry[0]);
+			req.qbuf_addr_h = upper_32_bits(mtt->mtt_entry[0]);
+		}
+		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK,
+				       mtt->mtt_nents);
+		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_TYPE_MASK,
+				       mtt->mtt_type);
+
+		req.first_page_offset = mtt->page_offset;
+		req.cq_db_info_addr = cq->user_cq.db_info_dma_addr;
+	}
+
+	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				   NULL);
+}
+
+static int erdma_alloc_idx(struct erdma_resource_cb *res_cb)
+{
+	int idx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&res_cb->lock, flags);
+	idx = find_next_zero_bit(res_cb->bitmap, res_cb->max_cap,
+				 res_cb->next_alloc_idx);
+	if (idx == res_cb->max_cap) {
+		idx = find_first_zero_bit(res_cb->bitmap, res_cb->max_cap);
+		if (idx == res_cb->max_cap) {
+			res_cb->next_alloc_idx = 1;
+			spin_unlock_irqrestore(&res_cb->lock, flags);
+			return -ENOSPC;
+		}
+	}
+
+	set_bit(idx, res_cb->bitmap);
+	res_cb->next_alloc_idx = idx + 1;
+	spin_unlock_irqrestore(&res_cb->lock, flags);
+
+	return idx;
+}
+
+static inline void erdma_free_idx(struct erdma_resource_cb *res_cb, u32 idx)
+{
+	unsigned long flags;
+	u32 used;
+
+	spin_lock_irqsave(&res_cb->lock, flags);
+	used = test_and_clear_bit(idx, res_cb->bitmap);
+	spin_unlock_irqrestore(&res_cb->lock, flags);
+	WARN_ON(!used);
+}
+
+static struct rdma_user_mmap_entry *
+erdma_user_mmap_entry_insert(struct erdma_ucontext *uctx, void *address,
+			     u32 size, u8 mmap_flag, u64 *mmap_offset)
+{
+	struct erdma_user_mmap_entry *entry =
+		kzalloc(sizeof(*entry), GFP_KERNEL);
+	int ret;
+
+	if (!entry)
+		return NULL;
+
+	entry->address = (u64)address;
+	entry->mmap_flag = mmap_flag;
+
+	size = PAGE_ALIGN(size);
+
+	ret = rdma_user_mmap_entry_insert(&uctx->ibucontext, &entry->rdma_entry,
+					  size);
+	if (ret) {
+		kfree(entry);
+		return NULL;
+	}
+
+	*mmap_offset = rdma_user_mmap_get_offset(&entry->rdma_entry);
+
+	return &entry->rdma_entry;
+}
+
+int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
+		       struct ib_udata *unused)
+{
+	struct erdma_dev *dev = to_edev(ibdev);
+
+	memset(attr, 0, sizeof(*attr));
+
+	attr->max_mr_size = dev->attrs.max_mr_size;
+	attr->vendor_id = PCI_VENDOR_ID_ALIBABA;
+	attr->vendor_part_id = dev->pdev->device;
+	attr->hw_ver = dev->pdev->revision;
+	attr->max_qp = dev->attrs.max_qp;
+	attr->max_qp_wr = min(dev->attrs.max_send_wr, dev->attrs.max_recv_wr);
+	attr->max_qp_rd_atom = dev->attrs.max_ord;
+	attr->max_qp_init_rd_atom = dev->attrs.max_ird;
+	attr->max_res_rd_atom = dev->attrs.max_qp * dev->attrs.max_ird;
+	attr->device_cap_flags = dev->attrs.cap_flags;
+	ibdev->local_dma_lkey = dev->attrs.local_dma_key;
+	attr->max_send_sge = dev->attrs.max_send_sge;
+	attr->max_recv_sge = dev->attrs.max_recv_sge;
+	attr->max_sge_rd = dev->attrs.max_sge_rd;
+	attr->max_cq = dev->attrs.max_cq;
+	attr->max_cqe = dev->attrs.max_cqe;
+	attr->max_mr = dev->attrs.max_mr;
+	attr->max_pd = dev->attrs.max_pd;
+	attr->max_mw = dev->attrs.max_mw;
+	attr->max_fast_reg_page_list_len = ERDMA_MAX_FRMR_PA;
+	attr->page_size_cap = ERDMA_PAGE_SIZE_SUPPORT;
+	attr->fw_ver = dev->attrs.fw_version;
+
+	if (dev->netdev)
+		addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
+				    dev->netdev->dev_addr);
+
+	return 0;
+}
+
+int erdma_query_gid(struct ib_device *ibdev, u32 port, int idx,
+		    union ib_gid *gid)
+{
+	struct erdma_dev *dev = to_edev(ibdev);
+
+	memset(gid, 0, sizeof(*gid));
+	ether_addr_copy(gid->raw, dev->attrs.peer_addr);
+
+	return 0;
+}
+
+int erdma_query_port(struct ib_device *ibdev, u32 port,
+		     struct ib_port_attr *attr)
+{
+	struct erdma_dev *dev = to_edev(ibdev);
+
+	memset(attr, 0, sizeof(*attr));
+
+	attr->state = dev->state;
+	if (dev->netdev) {
+		ib_get_eth_speed(ibdev, port, &attr->active_speed,
+				 &attr->active_width);
+		attr->max_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
+		attr->active_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
+	}
+
+	attr->gid_tbl_len = 1;
+	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
+	attr->max_msg_sz = -1;
+	if (dev->state == IB_PORT_ACTIVE)
+		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
+	else
+		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
+
+	return 0;
+}
+
+int erdma_get_port_immutable(struct ib_device *ibdev, u32 port,
+			     struct ib_port_immutable *port_immutable)
+{
+	port_immutable->gid_tbl_len = 1;
+	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
+
+	return 0;
+}
+
+int erdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+{
+	struct erdma_pd *pd = to_epd(ibpd);
+	struct erdma_dev *dev = to_edev(ibpd->device);
+	int pdn;
+
+	pdn = erdma_alloc_idx(&dev->res_cb[ERDMA_RES_TYPE_PD]);
+	if (pdn < 0)
+		return pdn;
+
+	pd->pdn = pdn;
+
+	return 0;
+}
+
+int erdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+{
+	struct erdma_pd *pd = to_epd(ibpd);
+	struct erdma_dev *dev = to_edev(ibpd->device);
+
+	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_PD], pd->pdn);
+
+	return 0;
+}
+
+static int erdma_qp_validate_cap(struct erdma_dev *dev,
+				 struct ib_qp_init_attr *attrs)
+{
+	if ((attrs->cap.max_send_wr > dev->attrs.max_send_wr) ||
+	    (attrs->cap.max_recv_wr > dev->attrs.max_recv_wr) ||
+	    (attrs->cap.max_send_sge > dev->attrs.max_send_sge) ||
+	    (attrs->cap.max_recv_sge > dev->attrs.max_recv_sge) ||
+	    (attrs->cap.max_inline_data > ERDMA_MAX_INLINE) ||
+	    !attrs->cap.max_send_wr || !attrs->cap.max_recv_wr) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int erdma_qp_validate_attr(struct erdma_dev *dev,
+				  struct ib_qp_init_attr *attrs)
+{
+	if (attrs->qp_type != IB_QPT_RC)
+		return -EOPNOTSUPP;
+
+	if (attrs->srq)
+		return -EOPNOTSUPP;
+
+	if (!attrs->send_cq || !attrs->recv_cq)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void free_kernel_qp(struct erdma_qp *qp)
+{
+	struct erdma_dev *dev = qp->dev;
+
+	vfree(qp->kern_qp.swr_tbl);
+	vfree(qp->kern_qp.rwr_tbl);
+
+	if (qp->kern_qp.sq_buf)
+		dma_free_coherent(
+			&dev->pdev->dev,
+			WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
+			qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
+
+	if (qp->kern_qp.rq_buf)
+		dma_free_coherent(
+			&dev->pdev->dev,
+			WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
+			qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
+}
+
+static int init_kernel_qp(struct erdma_dev *dev, struct erdma_qp *qp,
+			  struct ib_qp_init_attr *attrs)
+{
+	struct erdma_kqp *kqp = &qp->kern_qp;
+	int size;
+
+	if (attrs->sq_sig_type == IB_SIGNAL_ALL_WR)
+		kqp->sig_all = 1;
+
+	kqp->sq_pi = 0;
+	kqp->sq_ci = 0;
+	kqp->rq_pi = 0;
+	kqp->rq_ci = 0;
+	kqp->hw_sq_db =
+		dev->func_bar + (ERDMA_SDB_SHARED_PAGE_INDEX << PAGE_SHIFT);
+	kqp->hw_rq_db = dev->func_bar + ERDMA_BAR_RQDB_SPACE_OFFSET;
+
+	kqp->swr_tbl = vmalloc(qp->attrs.sq_size * sizeof(u64));
+	kqp->rwr_tbl = vmalloc(qp->attrs.rq_size * sizeof(u64));
+	if (!kqp->swr_tbl || !kqp->rwr_tbl)
+		goto err_out;
+
+	size = (qp->attrs.sq_size << SQEBB_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
+	kqp->sq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
+					 &kqp->sq_buf_dma_addr, GFP_KERNEL);
+	if (!kqp->sq_buf)
+		goto err_out;
+
+	size = (qp->attrs.rq_size << RQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
+	kqp->rq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
+					 &kqp->rq_buf_dma_addr, GFP_KERNEL);
+	if (!kqp->rq_buf)
+		goto err_out;
+
+	kqp->sq_db_info = kqp->sq_buf + (qp->attrs.sq_size << SQEBB_SHIFT);
+	kqp->rq_db_info = kqp->rq_buf + (qp->attrs.rq_size << RQE_SHIFT);
+
+	return 0;
+
+err_out:
+	free_kernel_qp(qp);
+	return -ENOMEM;
+}
+
+static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
+			   u64 start, u64 len, int access, u64 virt,
+			   unsigned long req_page_size, u8 force_indirect_mtt)
+{
+	struct ib_block_iter biter;
+	uint64_t *phy_addr = NULL;
+	int ret = 0;
+
+	mem->umem = ib_umem_get(&dev->ibdev, start, len, access);
+	if (IS_ERR(mem->umem)) {
+		ret = PTR_ERR(mem->umem);
+		mem->umem = NULL;
+		return ret;
+	}
+
+	mem->va = virt;
+	mem->len = len;
+	mem->page_size = ib_umem_find_best_pgsz(mem->umem, req_page_size, virt);
+	mem->page_offset = start & (mem->page_size - 1);
+	mem->mtt_nents = ib_umem_num_dma_blocks(mem->umem, mem->page_size);
+	mem->page_cnt = mem->mtt_nents;
+
+	if (mem->page_cnt > ERDMA_MAX_INLINE_MTT_ENTRIES ||
+	    force_indirect_mtt) {
+		mem->mtt_type = ERDMA_MR_INDIRECT_MTT;
+		mem->mtt_buf =
+			alloc_pages_exact(MTT_SIZE(mem->page_cnt), GFP_KERNEL);
+		if (!mem->mtt_buf) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+		phy_addr = mem->mtt_buf;
+	} else {
+		mem->mtt_type = ERDMA_MR_INLINE_MTT;
+		phy_addr = mem->mtt_entry;
+	}
+
+	rdma_umem_for_each_dma_block(mem->umem, &biter, mem->page_size) {
+		*phy_addr = rdma_block_iter_dma_address(&biter);
+		phy_addr++;
+	}
+
+	if (mem->mtt_type == ERDMA_MR_INDIRECT_MTT) {
+		mem->mtt_entry[0] =
+			dma_map_single(&dev->pdev->dev, mem->mtt_buf,
+				       MTT_SIZE(mem->page_cnt), DMA_TO_DEVICE);
+		if (dma_mapping_error(&dev->pdev->dev, mem->mtt_entry[0])) {
+			free_pages_exact(mem->mtt_buf, MTT_SIZE(mem->page_cnt));
+			mem->mtt_buf = NULL;
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+	}
+
+	return 0;
+
+error_ret:
+	if (mem->umem) {
+		ib_umem_release(mem->umem);
+		mem->umem = NULL;
+	}
+
+	return ret;
+}
+
+static void put_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem)
+{
+	if (mem->mtt_buf) {
+		dma_unmap_single(&dev->pdev->dev, mem->mtt_entry[0],
+				 MTT_SIZE(mem->page_cnt), DMA_TO_DEVICE);
+		free_pages_exact(mem->mtt_buf, MTT_SIZE(mem->page_cnt));
+	}
+
+	if (mem->umem) {
+		ib_umem_release(mem->umem);
+		mem->umem = NULL;
+	}
+}
+
+static int erdma_map_user_dbrecords(struct erdma_ucontext *ctx,
+				    u64 dbrecords_va,
+				    struct erdma_user_dbrecords_page **dbr_page,
+				    dma_addr_t *dma_addr)
+{
+	struct erdma_user_dbrecords_page *page = NULL;
+	int rv = 0;
+
+	mutex_lock(&ctx->dbrecords_page_mutex);
+
+	list_for_each_entry(page, &ctx->dbrecords_page_list, list)
+		if (page->va == (dbrecords_va & PAGE_MASK))
+			goto found;
+
+	page = kmalloc(sizeof(*page), GFP_KERNEL);
+	if (!page) {
+		rv = -ENOMEM;
+		goto out;
+	}
+
+	page->va = (dbrecords_va & PAGE_MASK);
+	page->refcnt = 0;
+
+	page->umem = ib_umem_get(ctx->ibucontext.device,
+				 dbrecords_va & PAGE_MASK, PAGE_SIZE, 0);
+	if (IS_ERR(page->umem)) {
+		rv = PTR_ERR(page->umem);
+		kfree(page);
+		goto out;
+	}
+
+	list_add(&page->list, &ctx->dbrecords_page_list);
+
+found:
+	*dma_addr = sg_dma_address(page->umem->sgt_append.sgt.sgl) +
+		    (dbrecords_va & ~PAGE_MASK);
+	*dbr_page = page;
+	page->refcnt++;
+
+out:
+	mutex_unlock(&ctx->dbrecords_page_mutex);
+	return rv;
+}
+
+static void
+erdma_unmap_user_dbrecords(struct erdma_ucontext *ctx,
+			   struct erdma_user_dbrecords_page **dbr_page)
+{
+	if (!ctx || !(*dbr_page))
+		return;
+
+	mutex_lock(&ctx->dbrecords_page_mutex);
+	if (--(*dbr_page)->refcnt == 0) {
+		list_del(&(*dbr_page)->list);
+		ib_umem_release((*dbr_page)->umem);
+		kfree(*dbr_page);
+	}
+
+	*dbr_page = NULL;
+	mutex_unlock(&ctx->dbrecords_page_mutex);
+}
+
+static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
+			u64 va, u32 len, u64 db_info_va)
+{
+	dma_addr_t db_info_dma_addr;
+	u32 rq_offset;
+	int ret;
+
+	if (len < (PAGE_ALIGN(qp->attrs.sq_size * SQEBB_SIZE) +
+		   qp->attrs.rq_size * RQE_SIZE))
+		return -EINVAL;
+
+	ret = get_mtt_entries(qp->dev, &qp->user_qp.sq_mtt, va,
+			      qp->attrs.sq_size << SQEBB_SHIFT, 0, va,
+			      (SZ_1M - SZ_4K), 1);
+	if (ret)
+		return ret;
+
+	rq_offset = PAGE_ALIGN(qp->attrs.sq_size << SQEBB_SHIFT);
+	qp->user_qp.rq_offset = rq_offset;
+
+	ret = get_mtt_entries(qp->dev, &qp->user_qp.rq_mtt, va + rq_offset,
+			      qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
+			      (SZ_1M - SZ_4K), 1);
+	if (ret)
+		goto put_sq_mtt;
+
+	ret = erdma_map_user_dbrecords(uctx, db_info_va,
+				       &qp->user_qp.user_dbr_page,
+				       &db_info_dma_addr);
+	if (ret)
+		goto put_rq_mtt;
+
+	qp->user_qp.sq_db_info_dma_addr = db_info_dma_addr;
+	qp->user_qp.rq_db_info_dma_addr = db_info_dma_addr + ERDMA_DB_SIZE;
+
+	return 0;
+
+put_rq_mtt:
+	put_mtt_entries(qp->dev, &qp->user_qp.rq_mtt);
+
+put_sq_mtt:
+	put_mtt_entries(qp->dev, &qp->user_qp.sq_mtt);
+
+	return ret;
+}
+
+static void free_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx)
+{
+	put_mtt_entries(qp->dev, &qp->user_qp.sq_mtt);
+	put_mtt_entries(qp->dev, &qp->user_qp.rq_mtt);
+	erdma_unmap_user_dbrecords(uctx, &qp->user_qp.user_dbr_page);
+}
+
+int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
+		    struct ib_udata *udata)
+{
+	struct erdma_qp *qp = to_eqp(ibqp);
+	struct erdma_dev *dev = to_edev(ibqp->device);
+	struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
+		udata, struct erdma_ucontext, ibucontext);
+	struct erdma_ureq_create_qp ureq;
+	struct erdma_uresp_create_qp uresp;
+	int ret;
+
+	ret = erdma_qp_validate_cap(dev, attrs);
+	if (ret)
+		goto err_out;
+
+	ret = erdma_qp_validate_attr(dev, attrs);
+	if (ret)
+		goto err_out;
+
+	qp->scq = to_ecq(attrs->send_cq);
+	qp->rcq = to_ecq(attrs->recv_cq);
+	qp->dev = dev;
+	qp->attrs.cc = dev->attrs.cc;
+
+	init_rwsem(&qp->state_lock);
+	kref_init(&qp->ref);
+	init_completion(&qp->safe_free);
+
+	ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
+			      XA_LIMIT(1, dev->attrs.max_qp - 1),
+			      &dev->next_alloc_qpn, GFP_KERNEL);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	qp->attrs.sq_size = roundup_pow_of_two(attrs->cap.max_send_wr *
+					       ERDMA_MAX_WQEBB_PER_SQE);
+	qp->attrs.rq_size = roundup_pow_of_two(attrs->cap.max_recv_wr);
+
+	if (uctx) {
+		ret = ib_copy_from_udata(&ureq, udata,
+					 min(sizeof(ureq), udata->inlen));
+		if (ret)
+			goto err_out_xa;
+
+		ret = init_user_qp(qp, uctx, ureq.qbuf_va, ureq.qbuf_len,
+				   ureq.db_record_va);
+		if (ret)
+			goto err_out_xa;
+
+		memset(&uresp, 0, sizeof(uresp));
+
+		uresp.num_sqe = qp->attrs.sq_size;
+		uresp.num_rqe = qp->attrs.rq_size;
+		uresp.qp_id = QP_ID(qp);
+		uresp.rq_offset = qp->user_qp.rq_offset;
+
+		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		if (ret)
+			goto err_out_cmd;
+	} else {
+		init_kernel_qp(dev, qp, attrs);
+	}
+
+	qp->attrs.max_send_sge = attrs->cap.max_send_sge;
+	qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;
+	qp->attrs.state = ERDMA_QP_STATE_IDLE;
+
+	ret = create_qp_cmd(dev, qp);
+	if (ret)
+		goto err_out_cmd;
+
+	spin_lock_init(&qp->lock);
+
+	return 0;
+
+err_out_cmd:
+	if (uctx)
+		free_user_qp(qp, uctx);
+	else
+		free_kernel_qp(qp);
+err_out_xa:
+	xa_erase(&dev->qp_xa, QP_ID(qp));
+err_out:
+	return ret;
+}
+
+static int erdma_create_stag(struct erdma_dev *dev, u32 *stag)
+{
+	int stag_idx;
+
+	stag_idx = erdma_alloc_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX]);
+	if (stag_idx < 0)
+		return stag_idx;
+
+	/* For now, we always let key field be zero. */
+	*stag = (stag_idx << 8);
+
+	return 0;
+}
+
+struct ib_mr *erdma_get_dma_mr(struct ib_pd *ibpd, int acc)
+{
+	struct erdma_mr *mr;
+	struct erdma_dev *dev = to_edev(ibpd->device);
+	int ret;
+	u32 stag;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	ret = erdma_create_stag(dev, &stag);
+	if (ret)
+		goto out_free;
+
+	mr->type = ERDMA_MR_TYPE_DMA;
+
+	mr->ibmr.lkey = stag;
+	mr->ibmr.rkey = stag;
+	mr->ibmr.pd = ibpd;
+	mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(acc);
+	ret = regmr_cmd(dev, mr);
+	if (ret) {
+		ret = -EIO;
+		goto out_remove_stag;
+	}
+
+	return &mr->ibmr;
+
+out_remove_stag:
+	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX],
+		       mr->ibmr.lkey >> 8);
+
+out_free:
+	kfree(mr);
+
+	return ERR_PTR(ret);
+}
+
+struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
+				u32 max_num_sg)
+{
+	struct erdma_mr *mr;
+	struct erdma_dev *dev = to_edev(ibpd->device);
+	int ret;
+	u32 stag;
+
+	if (mr_type != IB_MR_TYPE_MEM_REG)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (max_num_sg > ERDMA_MR_MAX_MTT_CNT)
+		return ERR_PTR(-EINVAL);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	ret = erdma_create_stag(dev, &stag);
+	if (ret)
+		goto out_free;
+
+	mr->type = ERDMA_MR_TYPE_FRMR;
+
+	mr->ibmr.lkey = stag;
+	mr->ibmr.rkey = stag;
+	mr->ibmr.pd = ibpd;
+	/* update it in FRMR. */
+	mr->access = ERDMA_MR_ACC_LR | ERDMA_MR_ACC_LW | ERDMA_MR_ACC_RR |
+		     ERDMA_MR_ACC_RW;
+
+	mr->mem.page_size = PAGE_SIZE; /* update it later. */
+	mr->mem.page_cnt = max_num_sg;
+	mr->mem.mtt_type = ERDMA_MR_INDIRECT_MTT;
+	mr->mem.mtt_buf =
+		alloc_pages_exact(MTT_SIZE(mr->mem.page_cnt), GFP_KERNEL);
+	if (!mr->mem.mtt_buf) {
+		ret = -ENOMEM;
+		goto out_remove_stag;
+	}
+
+	mr->mem.mtt_entry[0] =
+		dma_map_single(&dev->pdev->dev, mr->mem.mtt_buf,
+			       MTT_SIZE(mr->mem.page_cnt), DMA_TO_DEVICE);
+	if (dma_mapping_error(&dev->pdev->dev, mr->mem.mtt_entry[0])) {
+		ret = -ENOMEM;
+		goto out_free_mtt;
+	}
+
+	ret = regmr_cmd(dev, mr);
+	if (ret) {
+		ret = -EIO;
+		goto out_dma_unmap;
+	}
+
+	return &mr->ibmr;
+
+out_dma_unmap:
+	dma_unmap_single(&dev->pdev->dev, mr->mem.mtt_entry[0],
+			 MTT_SIZE(mr->mem.page_cnt), DMA_TO_DEVICE);
+out_free_mtt:
+	free_pages_exact(mr->mem.mtt_buf, MTT_SIZE(mr->mem.page_cnt));
+
+out_remove_stag:
+	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX],
+		       mr->ibmr.lkey >> 8);
+
+out_free:
+	kfree(mr);
+
+	return ERR_PTR(ret);
+}
+
+static int erdma_set_page(struct ib_mr *ibmr, u64 addr)
+{
+	struct erdma_mr *mr = to_emr(ibmr);
+
+	if (mr->mem.mtt_nents >= mr->mem.page_cnt)
+		return -1;
+
+	*((u64 *)mr->mem.mtt_buf + mr->mem.mtt_nents) = addr;
+	mr->mem.mtt_nents++;
+
+	return 0;
+}
+
+int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
+		    unsigned int *sg_offset)
+{
+	struct erdma_mr *mr = to_emr(ibmr);
+	int num;
+
+	mr->mem.mtt_nents = 0;
+
+	num = ib_sg_to_pages(&mr->ibmr, sg, sg_nents, sg_offset,
+			     erdma_set_page);
+
+	return num;
+}
+
+struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
+				u64 virt, int access, struct ib_udata *udata)
+{
+	struct erdma_mr *mr = NULL;
+	struct erdma_dev *dev = to_edev(ibpd->device);
+	u32 stag;
+	int ret;
+
+	if (!len || len > dev->attrs.max_mr_size)
+		return ERR_PTR(-EINVAL);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	ret = get_mtt_entries(dev, &mr->mem, start, len, access, virt,
+			      SZ_2G - SZ_4K, 0);
+	if (ret)
+		goto err_out_free;
+
+	ret = erdma_create_stag(dev, &stag);
+	if (ret)
+		goto err_out_put_mtt;
+
+	mr->ibmr.lkey = mr->ibmr.rkey = stag;
+	mr->ibmr.pd = ibpd;
+	mr->mem.va = virt;
+	mr->mem.len = len;
+	mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(access);
+	mr->valid = 1;
+	mr->type = ERDMA_MR_TYPE_NORMAL;
+
+	ret = regmr_cmd(dev, mr);
+	if (ret) {
+		ret = -EIO;
+		goto err_out_mr;
+	}
+
+	return &mr->ibmr;
+
+err_out_mr:
+	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX],
+		       mr->ibmr.lkey >> 8);
+
+err_out_put_mtt:
+	put_mtt_entries(dev, &mr->mem);
+
+err_out_free:
+	kfree(mr);
+
+	return ERR_PTR(ret);
+}
+
+int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
+{
+	struct erdma_mr *mr;
+	struct erdma_dev *dev = to_edev(ibmr->device);
+	struct erdma_cmdq_dereg_mr_req req;
+	int ret;
+
+	mr = to_emr(ibmr);
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_DEREG_MR);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, ibmr->lkey >> 8) |
+		  FIELD_PREP(ERDMA_CMD_MR_KEY_MASK, ibmr->lkey & 0xFF);
+
+	ret = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				  NULL);
+	if (ret)
+		return ret;
+
+	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX], ibmr->lkey >> 8);
+
+	put_mtt_entries(dev, &mr->mem);
+
+	kfree(mr);
+	return 0;
+}
+
+int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+{
+	struct erdma_cq *cq = to_ecq(ibcq);
+	struct erdma_dev *dev = to_edev(ibcq->device);
+	struct erdma_ucontext *ctx = rdma_udata_to_drv_context(
+		udata, struct erdma_ucontext, ibucontext);
+	int err;
+	struct erdma_cmdq_destroy_cq_req req;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_DESTROY_CQ);
+	req.cqn = cq->cqn;
+
+	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				  NULL);
+	if (err)
+		return err;
+
+	if (rdma_is_kernel_res(&cq->ibcq.res)) {
+		dma_free_coherent(&dev->pdev->dev,
+				  WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
+				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
+	} else {
+		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
+		put_mtt_entries(dev, &cq->user_cq.qbuf_mtt);
+	}
+
+	xa_erase(&dev->cq_xa, cq->cqn);
+
+	return 0;
+}
+
+int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
+{
+	struct erdma_qp *qp = to_eqp(ibqp);
+	struct erdma_dev *dev = to_edev(ibqp->device);
+	struct erdma_ucontext *ctx = rdma_udata_to_drv_context(
+		udata, struct erdma_ucontext, ibucontext);
+	struct erdma_qp_attrs qp_attrs;
+	int err;
+	struct erdma_cmdq_destroy_qp_req req;
+
+	down_write(&qp->state_lock);
+	qp_attrs.state = ERDMA_QP_STATE_ERROR;
+	erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
+	up_write(&qp->state_lock);
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_DESTROY_QP);
+	req.qpn = QP_ID(qp);
+
+	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				  NULL);
+	if (err)
+		return err;
+
+	erdma_qp_put(qp);
+	wait_for_completion(&qp->safe_free);
+
+	if (rdma_is_kernel_res(&qp->ibqp.res)) {
+		vfree(qp->kern_qp.swr_tbl);
+		vfree(qp->kern_qp.rwr_tbl);
+		dma_free_coherent(
+			&dev->pdev->dev,
+			WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
+			qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
+		dma_free_coherent(
+			&dev->pdev->dev,
+			WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
+			qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
+	} else {
+		put_mtt_entries(dev, &qp->user_qp.sq_mtt);
+		put_mtt_entries(dev, &qp->user_qp.rq_mtt);
+		erdma_unmap_user_dbrecords(ctx, &qp->user_qp.user_dbr_page);
+	}
+
+	if (qp->cep)
+		erdma_cep_put(qp->cep);
+	xa_erase(&dev->qp_xa, QP_ID(qp));
+
+	return 0;
+}
+
+void erdma_qp_get_ref(struct ib_qp *ibqp)
+{
+	erdma_qp_get(to_eqp(ibqp));
+}
+
+void erdma_qp_put_ref(struct ib_qp *ibqp)
+{
+	erdma_qp_put(to_eqp(ibqp));
+}
+
+int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
+{
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct erdma_user_mmap_entry *entry;
+	pgprot_t prot;
+	int err;
+
+	rdma_entry = rdma_user_mmap_entry_get(ctx, vma);
+	if (!rdma_entry)
+		return -EINVAL;
+
+	entry = to_emmap(rdma_entry);
+
+	switch (entry->mmap_flag) {
+	case ERDMA_MMAP_IO_NC:
+		/* map doorbell. */
+		prot = pgprot_device(vma->vm_page_prot);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = rdma_user_mmap_io(ctx, vma, PFN_DOWN(entry->address), PAGE_SIZE,
+				prot, rdma_entry);
+
+	rdma_user_mmap_entry_put(rdma_entry);
+	return err;
+}
+
+#define ERDMA_SDB_PAGE 0
+#define ERDMA_SDB_ENTRY 1
+#define ERDMA_SDB_SHARED 2
+
+static void alloc_db_resources(struct erdma_dev *dev,
+			       struct erdma_ucontext *ctx)
+{
+	u32 bitmap_idx;
+	struct erdma_devattr *attrs = &dev->attrs;
+
+	if (attrs->disable_dwqe)
+		goto alloc_normal_db;
+
+	/* Try to alloc independent SDB page. */
+	spin_lock(&dev->db_bitmap_lock);
+	bitmap_idx = find_first_zero_bit(dev->sdb_page, attrs->dwqe_pages);
+	if (bitmap_idx != attrs->dwqe_pages) {
+		set_bit(bitmap_idx, dev->sdb_page);
+		spin_unlock(&dev->db_bitmap_lock);
+
+		ctx->sdb_type = ERDMA_SDB_PAGE;
+		ctx->sdb_idx = bitmap_idx;
+		ctx->sdb_page_idx = bitmap_idx;
+		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET +
+			   (bitmap_idx << PAGE_SHIFT);
+		ctx->sdb_page_off = 0;
+
+		return;
+	}
+
+	bitmap_idx = find_first_zero_bit(dev->sdb_entry, attrs->dwqe_entries);
+	if (bitmap_idx != attrs->dwqe_entries) {
+		set_bit(bitmap_idx, dev->sdb_entry);
+		spin_unlock(&dev->db_bitmap_lock);
+
+		ctx->sdb_type = ERDMA_SDB_ENTRY;
+		ctx->sdb_idx = bitmap_idx;
+		ctx->sdb_page_idx = attrs->dwqe_pages +
+				    bitmap_idx / ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
+		ctx->sdb_page_off = bitmap_idx % ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
+
+		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET +
+			   (ctx->sdb_page_idx << PAGE_SHIFT);
+
+		return;
+	}
+
+	spin_unlock(&dev->db_bitmap_lock);
+
+alloc_normal_db:
+	ctx->sdb_type = ERDMA_SDB_SHARED;
+	ctx->sdb_idx = 0;
+	ctx->sdb_page_idx = ERDMA_SDB_SHARED_PAGE_INDEX;
+	ctx->sdb_page_off = 0;
+
+	ctx->sdb = dev->func_bar_addr + (ctx->sdb_page_idx << PAGE_SHIFT);
+}
+
+static void erdma_uctx_user_mmap_entries_remove(struct erdma_ucontext *uctx)
+{
+	rdma_user_mmap_entry_remove(uctx->sq_db_mmap_entry);
+	rdma_user_mmap_entry_remove(uctx->rq_db_mmap_entry);
+	rdma_user_mmap_entry_remove(uctx->cq_db_mmap_entry);
+}
+
+int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
+{
+	struct erdma_ucontext *ctx = to_ectx(ibctx);
+	struct erdma_dev *dev = to_edev(ibctx->device);
+	int ret;
+	struct erdma_uresp_alloc_ctx uresp = {};
+
+	if (atomic_inc_return(&dev->num_ctx) > ERDMA_MAX_CONTEXT) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	INIT_LIST_HEAD(&ctx->dbrecords_page_list);
+	mutex_init(&ctx->dbrecords_page_mutex);
+	ctx->dev = dev;
+
+	alloc_db_resources(dev, ctx);
+
+	ctx->rdb = dev->func_bar_addr + ERDMA_BAR_RQDB_SPACE_OFFSET;
+	ctx->cdb = dev->func_bar_addr + ERDMA_BAR_CQDB_SPACE_OFFSET;
+
+	if (udata->outlen < sizeof(uresp)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	ctx->sq_db_mmap_entry = erdma_user_mmap_entry_insert(
+		ctx, (void *)ctx->sdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.sdb);
+	if (!ctx->sq_db_mmap_entry) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	ctx->rq_db_mmap_entry = erdma_user_mmap_entry_insert(
+		ctx, (void *)ctx->rdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.rdb);
+	if (!ctx->sq_db_mmap_entry) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	ctx->cq_db_mmap_entry = erdma_user_mmap_entry_insert(
+		ctx, (void *)ctx->cdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.cdb);
+	if (!ctx->cq_db_mmap_entry) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	uresp.dev_id = dev->pdev->device;
+	uresp.sdb_type = ctx->sdb_type;
+	uresp.sdb_offset = ctx->sdb_page_off;
+
+	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	if (ret)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	erdma_uctx_user_mmap_entries_remove(ctx);
+	atomic_dec(&dev->num_ctx);
+	return ret;
+}
+
+void erdma_dealloc_ucontext(struct ib_ucontext *ibctx)
+{
+	struct erdma_ucontext *ctx = to_ectx(ibctx);
+	struct erdma_dev *dev = ctx->dev;
+
+	spin_lock(&dev->db_bitmap_lock);
+	if (ctx->sdb_type == ERDMA_SDB_PAGE)
+		clear_bit(ctx->sdb_idx, dev->sdb_page);
+	else if (ctx->sdb_type == ERDMA_SDB_ENTRY)
+		clear_bit(ctx->sdb_idx, dev->sdb_entry);
+
+	erdma_uctx_user_mmap_entries_remove(ctx);
+
+	spin_unlock(&dev->db_bitmap_lock);
+
+	atomic_dec(&ctx->dev->num_ctx);
+}
+
+static int ib_qp_state_to_erdma_qp_state[IB_QPS_ERR + 1] = {
+	[IB_QPS_RESET] = ERDMA_QP_STATE_IDLE,
+	[IB_QPS_INIT] = ERDMA_QP_STATE_IDLE,
+	[IB_QPS_RTR] = ERDMA_QP_STATE_RTR,
+	[IB_QPS_RTS] = ERDMA_QP_STATE_RTS,
+	[IB_QPS_SQD] = ERDMA_QP_STATE_CLOSING,
+	[IB_QPS_SQE] = ERDMA_QP_STATE_TERMINATE,
+	[IB_QPS_ERR] = ERDMA_QP_STATE_ERROR
+};
+
+int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
+		    struct ib_udata *udata)
+{
+	struct erdma_qp_attrs new_attrs;
+	enum erdma_qp_attr_mask erdma_attr_mask = 0;
+	struct erdma_qp *qp = to_eqp(ibqp);
+	int ret = 0;
+
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+		return -EOPNOTSUPP;
+
+	memset(&new_attrs, 0, sizeof(new_attrs));
+
+	if (attr_mask & IB_QP_STATE) {
+		new_attrs.state = ib_qp_state_to_erdma_qp_state[attr->qp_state];
+
+		erdma_attr_mask |= ERDMA_QP_ATTR_STATE;
+	}
+
+	down_write(&qp->state_lock);
+
+	ret = erdma_modify_qp_internal(qp, &new_attrs, erdma_attr_mask);
+
+	up_write(&qp->state_lock);
+
+	return ret;
+}
+
+int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
+		   int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
+{
+	struct erdma_qp *qp;
+	struct erdma_dev *dev;
+
+	if (ibqp && qp_attr && qp_init_attr) {
+		qp = to_eqp(ibqp);
+		dev = to_edev(ibqp->device);
+	} else {
+		return -EINVAL;
+	}
+
+	qp_attr->cap.max_inline_data = ERDMA_MAX_INLINE;
+	qp_init_attr->cap.max_inline_data = ERDMA_MAX_INLINE;
+
+	qp_attr->cap.max_send_wr = qp->attrs.sq_size;
+	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
+	qp_attr->cap.max_send_sge = qp->attrs.max_send_sge;
+	qp_attr->cap.max_recv_sge = qp->attrs.max_recv_sge;
+
+	qp_attr->path_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
+	qp_attr->max_rd_atomic = qp->attrs.irq_size;
+	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
+
+	qp_attr->qp_access_flags = IB_ACCESS_LOCAL_WRITE |
+				   IB_ACCESS_REMOTE_WRITE |
+				   IB_ACCESS_REMOTE_READ;
+
+	qp_init_attr->cap = qp_attr->cap;
+
+	return 0;
+}
+
+static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
+			      struct erdma_ureq_create_cq *ureq)
+{
+	int ret;
+	struct erdma_dev *dev = to_edev(cq->ibcq.device);
+
+	ret = get_mtt_entries(dev, &cq->user_cq.qbuf_mtt, ureq->qbuf_va,
+			      ureq->qbuf_len, 0, ureq->qbuf_va, SZ_64M - SZ_4K,
+			      1);
+	if (ret)
+		return ret;
+
+	ret = erdma_map_user_dbrecords(ctx, ureq->db_record_va,
+				       &cq->user_cq.user_dbr_page,
+				       &cq->user_cq.db_info_dma_addr);
+	if (ret)
+		put_mtt_entries(dev, &cq->user_cq.qbuf_mtt);
+
+	return ret;
+}
+
+static int erdma_init_kernel_cq(struct erdma_cq *cq)
+{
+	struct erdma_dev *dev = to_edev(cq->ibcq.device);
+
+	cq->kern_cq.qbuf =
+		dma_alloc_coherent(&dev->pdev->dev,
+				   WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
+				   &cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);
+	if (!cq->kern_cq.qbuf)
+		return -ENOMEM;
+
+	cq->kern_cq.db_record =
+		(u64 *)(cq->kern_cq.qbuf + (cq->depth << CQE_SHIFT));
+	spin_lock_init(&cq->kern_cq.lock);
+	/* use default cqdb addr */
+	cq->kern_cq.db = dev->func_bar + ERDMA_BAR_CQDB_SPACE_OFFSET;
+
+	return 0;
+}
+
+int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		    struct ib_udata *udata)
+{
+	struct erdma_cq *cq = to_ecq(ibcq);
+	struct erdma_dev *dev = to_edev(ibcq->device);
+	unsigned int depth = attr->cqe;
+	int ret;
+	struct erdma_ucontext *ctx = rdma_udata_to_drv_context(
+		udata, struct erdma_ucontext, ibucontext);
+
+	if (depth > dev->attrs.max_cqe)
+		return -EINVAL;
+
+	depth = roundup_pow_of_two(depth);
+	cq->ibcq.cqe = depth;
+	cq->depth = depth;
+	cq->assoc_eqn = attr->comp_vector + 1;
+
+	ret = xa_alloc_cyclic(&dev->cq_xa, &cq->cqn, cq,
+			      XA_LIMIT(1, dev->attrs.max_cq - 1),
+			      &dev->next_alloc_cqn, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	if (!rdma_is_kernel_res(&ibcq->res)) {
+		struct erdma_ureq_create_cq ureq;
+		struct erdma_uresp_create_cq uresp;
+
+		ret = ib_copy_from_udata(&ureq, udata,
+					 min(udata->inlen, sizeof(ureq)));
+		if (ret)
+			goto err_out_xa;
+
+		ret = erdma_init_user_cq(ctx, cq, &ureq);
+		if (ret)
+			goto err_out_xa;
+
+		uresp.cq_id = cq->cqn;
+		uresp.num_cqe = depth;
+
+		ret = ib_copy_to_udata(udata, &uresp,
+				       min(sizeof(uresp), udata->outlen));
+		if (ret)
+			goto err_free_res;
+	} else {
+		ret = erdma_init_kernel_cq(cq);
+		if (ret)
+			goto err_out_xa;
+	}
+
+	ret = create_cq_cmd(dev, cq);
+	if (ret)
+		goto err_free_res;
+
+	return 0;
+
+err_free_res:
+	if (!rdma_is_kernel_res(&ibcq->res)) {
+		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
+		put_mtt_entries(dev, &cq->user_cq.qbuf_mtt);
+	} else {
+		dma_free_coherent(&dev->pdev->dev,
+				  WARPPED_BUFSIZE(depth << CQE_SHIFT),
+				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
+	}
+
+err_out_xa:
+	xa_erase(&dev->cq_xa, cq->cqn);
+
+	return ret;
+}
+
+void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason)
+{
+	struct ib_event event;
+
+	event.device = &dev->ibdev;
+	event.element.port_num = 1;
+	event.event = reason;
+
+	ib_dispatch_event(&event);
+}
-- 
2.27.0

