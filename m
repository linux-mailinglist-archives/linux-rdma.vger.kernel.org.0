Return-Path: <linux-rdma+bounces-6407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E8C9EC1F7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF2B281B79
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2121FC0E9;
	Wed, 11 Dec 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JfHs1ymT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A51FBCA7
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882988; cv=none; b=FAUsM9aAXtgYmVWMGamrdazo/nlrrYeuJCYkUrVUNGzKtKRaVdBs5dZJoP6wpIxBJvqTQ5nm6d3+Iq0VS2L2V8RM1n7oVbQZJr8TcitRv05ln+5IBQMk1uvBE7TmMvmzq3sQSOGSlxygaVn8yPtuwyEkMbT6Krg6kiAIO0izRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882988; c=relaxed/simple;
	bh=uYtjQkHvuPmBhtCWvTw7LUQoqirgAiurNkWkWVGbI2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB8j4W3DrWmbg3/LpNqcqGnURUGpBOcSO4sysBLr4LF23iWx8ixliq/kAxSLo/IzDHLyD2yqSCOcTPk1ErMIiSyL/cjQh8YlmDAKeDVJ76rNFp1sAuck4d//iL66VSsZQF/nhpyf0m41YtaNS+0XRuJHyOYCoJhi2Ok8Qryxw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JfHs1ymT; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882977; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7zfcGan3I6Khw9+w/tpnF0Q5x0VmWEoIMNkPcouCdIQ=;
	b=JfHs1ymTaeve2HoU5AcJbc2a2bhJGOPCJD4lVB5VQpn7B0CHoyJwk2xQdvuXcIuYRVkwtMPLtpHLHHaTH9ccO1eqVCtp0Bf4pQYiqC+kZAkzezv4Xa7fnVhk/gKsOEHXQKUD9N++P87VUJuWlC+RH3k2elXw0s3GtJsrIvqHw4k=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGVL2Z_1733882976 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:36 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 5/8] RDMA/erdma: Add erdma_modify_qp_rocev2() interface
Date: Wed, 11 Dec 2024 10:09:05 +0800
Message-ID: <20241211020930.68833-6-boshiyu@linux.alibaba.com>
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

The QP state machines in the RoCEv2 and iWARP protocols are
different. To handle these differences for the erdma RoCEv2
device, we provide the erdma_modify_qp_rocev2() interface,
which transitions the QP state and modifies QP attributes
accordingly.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cq.c    |  45 +++++
 drivers/infiniband/hw/erdma/erdma_hw.h    |  14 ++
 drivers/infiniband/hw/erdma/erdma_main.c  |   3 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    |  92 +++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 221 +++++++++++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.h |  44 +++++
 6 files changed, 388 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index 70f89f0162aa..eada882472a3 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -201,3 +201,48 @@ int erdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
 	return npolled;
 }
+
+void erdma_remove_cqes_of_qp(struct ib_cq *ibcq, u32 qpn)
+{
+	struct erdma_cq *cq = to_ecq(ibcq);
+	struct erdma_cqe *cqe, *dst_cqe;
+	u32 prev_cq_ci, cur_cq_ci;
+	u32 ncqe = 0, nqp_cqe = 0;
+	unsigned long flags;
+	u8 owner;
+
+	spin_lock_irqsave(&cq->kern_cq.lock, flags);
+
+	prev_cq_ci = cq->kern_cq.ci;
+
+	while (ncqe < cq->depth && (cqe = get_next_valid_cqe(cq)) != NULL) {
+		++cq->kern_cq.ci;
+		++ncqe;
+	}
+
+	while (ncqe > 0) {
+		cur_cq_ci = prev_cq_ci + ncqe - 1;
+		cqe = get_queue_entry(cq->kern_cq.qbuf, cur_cq_ci, cq->depth,
+				      CQE_SHIFT);
+
+		if (be32_to_cpu(cqe->qpn) == qpn) {
+			++nqp_cqe;
+		} else if (nqp_cqe) {
+			dst_cqe = get_queue_entry(cq->kern_cq.qbuf,
+						  cur_cq_ci + nqp_cqe,
+						  cq->depth, CQE_SHIFT);
+			owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK,
+					  be32_to_cpu(dst_cqe->hdr));
+			cqe->hdr = cpu_to_be32(
+				(be32_to_cpu(cqe->hdr) &
+				 ~ERDMA_CQE_HDR_OWNER_MASK) |
+				FIELD_PREP(ERDMA_CQE_HDR_OWNER_MASK, owner));
+			memcpy(dst_cqe, cqe, sizeof(*cqe));
+		}
+
+		--ncqe;
+	}
+
+	cq->kern_cq.ci = prev_cq_ci + nqp_cqe;
+	spin_unlock_irqrestore(&cq->kern_cq.lock, flags);
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 64d856494359..b5c1aca71144 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -347,6 +347,20 @@ struct erdma_cmdq_modify_qp_req {
 	u32 recv_nxt;
 };
 
+/* modify qp cfg1 for roce device */
+#define ERDMA_CMD_MODIFY_QP_DQPN_MASK GENMASK(19, 0)
+
+struct erdma_cmdq_mod_qp_req_rocev2 {
+	u64 hdr;
+	u32 cfg0;
+	u32 cfg1;
+	u32 attr_mask;
+	u32 qkey;
+	u32 rq_psn;
+	u32 sq_psn;
+	struct erdma_av_cfg av_cfg;
+};
+
 /* create qp cfg0 */
 #define ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK GENMASK(31, 20)
 #define ERDMA_CMD_CREATE_QP_QPN_MASK GENMASK(19, 0)
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index d632c09c9acd..2fca163b1744 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -486,6 +486,7 @@ static const struct ib_device_ops erdma_device_ops_rocev2 = {
 	.query_pkey = erdma_query_pkey,
 	.create_ah = erdma_create_ah,
 	.destroy_ah = erdma_destroy_ah,
+	.modify_qp = erdma_modify_qp_rocev2,
 };
 
 static const struct ib_device_ops erdma_device_ops_iwarp = {
@@ -497,6 +498,7 @@ static const struct ib_device_ops erdma_device_ops_iwarp = {
 	.iw_get_qp = erdma_get_ibqp,
 	.iw_reject = erdma_reject,
 	.iw_rem_ref = erdma_qp_put_ref,
+	.modify_qp = erdma_modify_qp,
 };
 
 static const struct ib_device_ops erdma_device_ops = {
@@ -522,7 +524,6 @@ static const struct ib_device_ops erdma_device_ops = {
 	.map_mr_sg = erdma_map_mr_sg,
 	.mmap = erdma_mmap,
 	.mmap_free = erdma_mmap_free,
-	.modify_qp = erdma_modify_qp,
 	.post_recv = erdma_post_recv,
 	.post_send = erdma_post_send,
 	.poll_cq = erdma_poll_cq,
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 4d1f9114cd97..13977f4e9463 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -186,6 +186,98 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 	return ret;
 }
 
+static int modify_qp_cmd_rocev2(struct erdma_qp *qp,
+				struct erdma_mod_qp_params_rocev2 *params,
+				enum erdma_qpa_mask_rocev2 attr_mask)
+{
+	struct erdma_cmdq_mod_qp_req_rocev2 req;
+
+	memset(&req, 0, sizeof(req));
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_MODIFY_QP);
+
+	req.cfg0 = FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_STATE)
+		req.cfg0 |= FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK,
+				       params->state);
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_DST_QPN)
+		req.cfg1 = FIELD_PREP(ERDMA_CMD_MODIFY_QP_DQPN_MASK,
+				      params->dst_qpn);
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_QKEY)
+		req.qkey = params->qkey;
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_AV)
+		erdma_set_av_cfg(&req.av_cfg, &params->av);
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_SQ_PSN)
+		req.sq_psn = params->sq_psn;
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_RQ_PSN)
+		req.rq_psn = params->rq_psn;
+
+	req.attr_mask = attr_mask;
+
+	return erdma_post_cmd_wait(&qp->dev->cmdq, &req, sizeof(req), NULL,
+				   NULL);
+}
+
+static void erdma_reset_qp(struct erdma_qp *qp)
+{
+	qp->kern_qp.sq_pi = 0;
+	qp->kern_qp.sq_ci = 0;
+	qp->kern_qp.rq_pi = 0;
+	qp->kern_qp.rq_ci = 0;
+	memset(qp->kern_qp.swr_tbl, 0, qp->attrs.sq_size * sizeof(u64));
+	memset(qp->kern_qp.rwr_tbl, 0, qp->attrs.rq_size * sizeof(u64));
+	memset(qp->kern_qp.sq_buf, 0, qp->attrs.sq_size << SQEBB_SHIFT);
+	memset(qp->kern_qp.rq_buf, 0, qp->attrs.rq_size << RQE_SHIFT);
+	erdma_remove_cqes_of_qp(&qp->scq->ibcq, QP_ID(qp));
+	if (qp->rcq != qp->scq)
+		erdma_remove_cqes_of_qp(&qp->rcq->ibcq, QP_ID(qp));
+}
+
+int erdma_modify_qp_state_rocev2(struct erdma_qp *qp,
+				 struct erdma_mod_qp_params_rocev2 *params,
+				 int attr_mask)
+{
+	struct erdma_dev *dev = to_edev(qp->ibqp.device);
+	int ret;
+
+	ret = modify_qp_cmd_rocev2(qp, params, attr_mask);
+	if (ret)
+		return ret;
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_STATE)
+		qp->attrs.rocev2.state = params->state;
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_QKEY)
+		qp->attrs.rocev2.qkey = params->qkey;
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_DST_QPN)
+		qp->attrs.rocev2.dst_qpn = params->dst_qpn;
+
+	if (attr_mask & ERDMA_QPA_ROCEV2_AV)
+		memcpy(&qp->attrs.rocev2.av, &params->av,
+		       sizeof(struct erdma_av));
+
+	if (rdma_is_kernel_res(&qp->ibqp.res) &&
+	    params->state == ERDMA_QPS_ROCEV2_RESET)
+		erdma_reset_qp(qp);
+
+	if (rdma_is_kernel_res(&qp->ibqp.res) &&
+	    params->state == ERDMA_QPS_ROCEV2_ERROR) {
+		qp->flags |= ERDMA_QP_IN_FLUSHING;
+		mod_delayed_work(dev->reflush_wq, &qp->reflush_dwork,
+				 usecs_to_jiffies(100));
+	}
+
+	return 0;
+}
+
 static void erdma_qp_safe_free(struct kref *ref)
 {
 	struct erdma_qp *qp = container_of(ref, struct erdma_qp, ref);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 19483667c989..79693fb40aec 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -121,7 +121,7 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 
 	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
 				  &resp1);
-	if (!err)
+	if (!err && erdma_device_iwarp(dev))
 		qp->attrs.cookie =
 			FIELD_GET(ERDMA_CMDQ_CREATE_QP_RESP_COOKIE_MASK, resp0);
 
@@ -1017,7 +1017,12 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
 	qp->attrs.max_send_sge = attrs->cap.max_send_sge;
 	qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;
-	qp->attrs.state = ERDMA_QP_STATE_IDLE;
+
+	if (erdma_device_iwarp(qp->dev))
+		qp->attrs.state = ERDMA_QP_STATE_IDLE;
+	else
+		qp->attrs.rocev2.state = ERDMA_QPS_ROCEV2_RESET;
+
 	INIT_DELAYED_WORK(&qp->reflush_dwork, erdma_flush_worker);
 
 	ret = create_qp_cmd(uctx, qp);
@@ -1291,13 +1296,20 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct erdma_dev *dev = to_edev(ibqp->device);
 	struct erdma_ucontext *ctx = rdma_udata_to_drv_context(
 		udata, struct erdma_ucontext, ibucontext);
+	struct erdma_mod_qp_params_rocev2 rocev2_params;
 	struct erdma_qp_attrs qp_attrs;
 	int err;
 	struct erdma_cmdq_destroy_qp_req req;
 
 	down_write(&qp->state_lock);
-	qp_attrs.state = ERDMA_QP_STATE_ERROR;
-	erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
+	if (erdma_device_iwarp(dev)) {
+		qp_attrs.state = ERDMA_QP_STATE_ERROR;
+		erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
+	} else {
+		rocev2_params.state = ERDMA_QPS_ROCEV2_ERROR;
+		erdma_modify_qp_state_rocev2(qp, &rocev2_params,
+					     ERDMA_QPA_ROCEV2_STATE);
+	}
 	up_write(&qp->state_lock);
 
 	cancel_delayed_work_sync(&qp->reflush_dwork);
@@ -1528,6 +1540,29 @@ void erdma_dealloc_ucontext(struct ib_ucontext *ibctx)
 	atomic_dec(&dev->num_ctx);
 }
 
+static void erdma_attr_to_av(const struct rdma_ah_attr *ah_attr,
+			     struct erdma_av *av, u16 sport)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
+
+	av->port = rdma_ah_get_port_num(ah_attr);
+	av->sgid_index = grh->sgid_index;
+	av->hop_limit = grh->hop_limit;
+	av->traffic_class = grh->traffic_class;
+	av->sl = rdma_ah_get_sl(ah_attr);
+
+	av->flow_label = grh->flow_label;
+	av->udp_sport = sport;
+
+	ether_addr_copy(av->dmac, ah_attr->roce.dmac);
+	memcpy(av->dgid, grh->dgid.raw, ERDMA_ROCEV2_GID_SIZE);
+
+	if (ipv6_addr_v4mapped((struct in6_addr *)&grh->dgid))
+		av->ntype = ERDMA_NETWORK_TYPE_IPV4;
+	else
+		av->ntype = ERDMA_NETWORK_TYPE_IPV6;
+}
+
 static int ib_qp_state_to_erdma_qp_state[IB_QPS_ERR + 1] = {
 	[IB_QPS_RESET] = ERDMA_QP_STATE_IDLE,
 	[IB_QPS_INIT] = ERDMA_QP_STATE_IDLE,
@@ -1538,6 +1573,140 @@ static int ib_qp_state_to_erdma_qp_state[IB_QPS_ERR + 1] = {
 	[IB_QPS_ERR] = ERDMA_QP_STATE_ERROR
 };
 
+static int ib_qps_to_erdma_qps_rocev2[IB_QPS_ERR + 1] = {
+	[IB_QPS_RESET] = ERDMA_QPS_ROCEV2_RESET,
+	[IB_QPS_INIT] = ERDMA_QPS_ROCEV2_INIT,
+	[IB_QPS_RTR] = ERDMA_QPS_ROCEV2_RTR,
+	[IB_QPS_RTS] = ERDMA_QPS_ROCEV2_RTS,
+	[IB_QPS_SQD] = ERDMA_QPS_ROCEV2_SQD,
+	[IB_QPS_SQE] = ERDMA_QPS_ROCEV2_SQE,
+	[IB_QPS_ERR] = ERDMA_QPS_ROCEV2_ERROR,
+};
+
+static int erdma_qps_to_ib_qps_rocev2[ERDMA_QPS_ROCEV2_COUNT] = {
+	[ERDMA_QPS_ROCEV2_RESET] = IB_QPS_RESET,
+	[ERDMA_QPS_ROCEV2_INIT] = IB_QPS_INIT,
+	[ERDMA_QPS_ROCEV2_RTR] = IB_QPS_RTR,
+	[ERDMA_QPS_ROCEV2_RTS] = IB_QPS_RTS,
+	[ERDMA_QPS_ROCEV2_SQD] = IB_QPS_SQD,
+	[ERDMA_QPS_ROCEV2_SQE] = IB_QPS_SQE,
+	[ERDMA_QPS_ROCEV2_ERROR] = IB_QPS_ERR,
+};
+
+static int erdma_check_qp_attr_rocev2(struct erdma_qp *qp,
+				      struct ib_qp_attr *attr, int attr_mask)
+{
+	enum ib_qp_state cur_state, nxt_state;
+	struct erdma_dev *dev = qp->dev;
+	int ret = -EINVAL;
+
+	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if ((attr_mask & IB_QP_PKEY_INDEX) &&
+	    attr->pkey_index >= ERDMA_MAX_PKEYS)
+		goto out;
+
+	if ((attr_mask & IB_QP_PORT) &&
+	    !rdma_is_port_valid(&dev->ibdev, attr->port_num))
+		goto out;
+
+	cur_state = (attr_mask & IB_QP_CUR_STATE) ?
+			    attr->cur_qp_state :
+			    erdma_qps_to_ib_qps_rocev2[qp->attrs.rocev2.state];
+
+	nxt_state = (attr_mask & IB_QP_STATE) ? attr->qp_state : cur_state;
+
+	if (!ib_modify_qp_is_ok(cur_state, nxt_state, qp->ibqp.qp_type,
+				attr_mask))
+		goto out;
+
+	if ((attr_mask & IB_QP_AV) &&
+	    erdma_check_gid_attr(rdma_ah_read_grh(&attr->ah_attr)->sgid_attr))
+		goto out;
+
+	return 0;
+
+out:
+	return ret;
+}
+
+static void erdma_init_mod_qp_params_rocev2(
+	struct erdma_qp *qp, struct erdma_mod_qp_params_rocev2 *params,
+	int *erdma_attr_mask, struct ib_qp_attr *attr, int ib_attr_mask)
+{
+	enum erdma_qpa_mask_rocev2 to_modify_attrs = 0;
+	enum erdma_qps_rocev2 cur_state, nxt_state;
+	u16 udp_sport;
+
+	if (ib_attr_mask & IB_QP_CUR_STATE)
+		cur_state = ib_qps_to_erdma_qps_rocev2[attr->cur_qp_state];
+	else
+		cur_state = qp->attrs.rocev2.state;
+
+	if (ib_attr_mask & IB_QP_STATE)
+		nxt_state = ib_qps_to_erdma_qps_rocev2[attr->qp_state];
+	else
+		nxt_state = cur_state;
+
+	to_modify_attrs |= ERDMA_QPA_ROCEV2_STATE;
+	params->state = nxt_state;
+
+	if (ib_attr_mask & IB_QP_QKEY) {
+		to_modify_attrs |= ERDMA_QPA_ROCEV2_QKEY;
+		params->qkey = attr->qkey;
+	}
+
+	if (ib_attr_mask & IB_QP_SQ_PSN) {
+		to_modify_attrs |= ERDMA_QPA_ROCEV2_SQ_PSN;
+		params->sq_psn = attr->sq_psn;
+	}
+
+	if (ib_attr_mask & IB_QP_RQ_PSN) {
+		to_modify_attrs |= ERDMA_QPA_ROCEV2_RQ_PSN;
+		params->rq_psn = attr->rq_psn;
+	}
+
+	if (ib_attr_mask & IB_QP_DEST_QPN) {
+		to_modify_attrs |= ERDMA_QPA_ROCEV2_DST_QPN;
+		params->dst_qpn = attr->dest_qp_num;
+	}
+
+	if (ib_attr_mask & IB_QP_AV) {
+		to_modify_attrs |= ERDMA_QPA_ROCEV2_AV;
+		udp_sport = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
+					       QP_ID(qp), params->dst_qpn);
+		erdma_attr_to_av(&attr->ah_attr, &params->av, udp_sport);
+	}
+
+	*erdma_attr_mask = to_modify_attrs;
+}
+
+int erdma_modify_qp_rocev2(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+			   int attr_mask, struct ib_udata *udata)
+{
+	struct erdma_mod_qp_params_rocev2 params;
+	struct erdma_qp *qp = to_eqp(ibqp);
+	int ret = 0, erdma_attr_mask = 0;
+
+	down_write(&qp->state_lock);
+
+	ret = erdma_check_qp_attr_rocev2(qp, attr, attr_mask);
+	if (ret)
+		goto out;
+
+	erdma_init_mod_qp_params_rocev2(qp, &params, &erdma_attr_mask, attr,
+					attr_mask);
+
+	ret = erdma_modify_qp_state_rocev2(qp, &params, erdma_attr_mask);
+
+out:
+	up_write(&qp->state_lock);
+	return ret;
+}
+
 int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 		    struct ib_udata *udata)
 {
@@ -1920,6 +2089,22 @@ int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
 	return 0;
 }
 
+void erdma_set_av_cfg(struct erdma_av_cfg *av_cfg, struct erdma_av *av)
+{
+	av_cfg->cfg0 = FIELD_PREP(ERDMA_CMD_CREATE_AV_FL_MASK, av->flow_label) |
+		       FIELD_PREP(ERDMA_CMD_CREATE_AV_NTYPE_MASK, av->ntype);
+
+	av_cfg->traffic_class = av->traffic_class;
+	av_cfg->hop_limit = av->hop_limit;
+	av_cfg->sl = av->sl;
+
+	av_cfg->udp_sport = av->udp_sport;
+	av_cfg->sgid_index = av->sgid_index;
+
+	ether_addr_copy(av_cfg->dmac, av->dmac);
+	memcpy(av_cfg->dgid, av->dgid, ERDMA_ROCEV2_GID_SIZE);
+}
+
 int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		    struct ib_udata *udata)
 {
@@ -1948,38 +2133,14 @@ int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		udp_sport =
 			IB_ROCE_UDP_ENCAP_VALID_PORT_MIN + (ah->ahn & 0x3FFF);
 
-	ah->av.port = rdma_ah_get_port_num(init_attr->ah_attr);
-	ah->av.sgid_index = grh->sgid_index;
-	ah->av.hop_limit = grh->hop_limit;
-	ah->av.traffic_class = grh->traffic_class;
-	ah->av.sl = rdma_ah_get_sl(init_attr->ah_attr);
-	ah->av.flow_label = grh->flow_label;
-	ah->av.udp_sport = udp_sport;
-
-	ether_addr_copy(ah->av.dmac, init_attr->ah_attr->roce.dmac);
-	memcpy(ah->av.dgid, grh->dgid.raw, ERDMA_ROCEV2_GID_SIZE);
-
-	if (ipv6_addr_v4mapped((struct in6_addr *)&grh->dgid))
-		ah->av.ntype = ERDMA_NETWORK_TYPE_IPV4;
-	else
-		ah->av.ntype = ERDMA_NETWORK_TYPE_IPV6;
+	erdma_attr_to_av(init_attr->ah_attr, &ah->av, udp_sport);
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
 				CMDQ_OPCODE_CREATE_AH);
 
 	req.pdn = pd->pdn;
 	req.ahn = ah->ahn;
-
-	req.av_cfg.cfg0 =
-		FIELD_PREP(ERDMA_CMD_CREATE_AV_FL_MASK, ah->av.flow_label) |
-		FIELD_PREP(ERDMA_CMD_CREATE_AV_NTYPE_MASK, ah->av.ntype);
-	req.av_cfg.traffic_class = ah->av.traffic_class;
-	req.av_cfg.hop_limit = ah->av.hop_limit;
-	req.av_cfg.sl = ah->av.sl;
-	req.av_cfg.udp_sport = ah->av.udp_sport;
-	req.av_cfg.sgid_index = ah->av.sgid_index;
-	ether_addr_copy(req.av_cfg.dmac, ah->av.dmac);
-	memcpy(req.av_cfg.dgid, ah->av.dgid, ERDMA_ROCEV2_GID_SIZE);
+	erdma_set_av_cfg(&req.av_cfg, &ah->av);
 
 	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 	if (ret) {
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 78a6c35cf1a5..fad3e475d8f1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -216,10 +216,46 @@ enum erdma_qp_attr_mask {
 	ERDMA_QP_ATTR_MPA = (1 << 7)
 };
 
+enum erdma_qps_rocev2 {
+	ERDMA_QPS_ROCEV2_RESET = 0,
+	ERDMA_QPS_ROCEV2_INIT = 1,
+	ERDMA_QPS_ROCEV2_RTR = 2,
+	ERDMA_QPS_ROCEV2_RTS = 3,
+	ERDMA_QPS_ROCEV2_SQD = 4,
+	ERDMA_QPS_ROCEV2_SQE = 5,
+	ERDMA_QPS_ROCEV2_ERROR = 6,
+	ERDMA_QPS_ROCEV2_COUNT = 7,
+};
+
+enum erdma_qpa_mask_rocev2 {
+	ERDMA_QPA_ROCEV2_STATE = (1 << 0),
+	ERDMA_QPA_ROCEV2_QKEY = (1 << 1),
+	ERDMA_QPA_ROCEV2_AV = (1 << 2),
+	ERDMA_QPA_ROCEV2_SQ_PSN = (1 << 3),
+	ERDMA_QPA_ROCEV2_RQ_PSN = (1 << 4),
+	ERDMA_QPA_ROCEV2_DST_QPN = (1 << 5),
+};
+
 enum erdma_qp_flags {
 	ERDMA_QP_IN_FLUSHING = (1 << 0),
 };
 
+struct erdma_mod_qp_params_rocev2 {
+	enum erdma_qps_rocev2 state;
+	u32 qkey;
+	u32 sq_psn;
+	u32 rq_psn;
+	u32 dst_qpn;
+	struct erdma_av av;
+};
+
+struct erdma_qp_attrs_rocev2 {
+	enum erdma_qps_rocev2 state;
+	u32 qkey;
+	u32 dst_qpn;
+	struct erdma_av av;
+};
+
 struct erdma_qp_attrs {
 	enum erdma_qp_state state;
 	enum erdma_cc_alg cc; /* Congestion control algorithm */
@@ -234,6 +270,7 @@ struct erdma_qp_attrs {
 #define ERDMA_QP_PASSIVE 1
 	u8 qp_type;
 	u8 pd_len;
+	struct erdma_qp_attrs_rocev2 rocev2;
 };
 
 struct erdma_qp {
@@ -307,6 +344,9 @@ void erdma_qp_get(struct erdma_qp *qp);
 void erdma_qp_put(struct erdma_qp *qp);
 int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 			     enum erdma_qp_attr_mask mask);
+int erdma_modify_qp_state_rocev2(struct erdma_qp *qp,
+				 struct erdma_mod_qp_params_rocev2 *params,
+				 int attr_mask);
 void erdma_qp_llp_close(struct erdma_qp *qp);
 void erdma_qp_cm_drop(struct erdma_qp *qp);
 
@@ -386,6 +426,8 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		   struct ib_qp_init_attr *init_attr);
 int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		    struct ib_udata *data);
+int erdma_modify_qp_rocev2(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+			   int mask, struct ib_udata *udata);
 int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext);
@@ -404,6 +446,7 @@ int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
 int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 		    const struct ib_recv_wr **bad_recv_wr);
 int erdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
+void erdma_remove_cqes_of_qp(struct ib_cq *ibcq, u32 qpn);
 struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				u32 max_num_sg);
 int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
@@ -419,6 +462,7 @@ enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
 int erdma_add_gid(const struct ib_gid_attr *attr, void **context);
 int erdma_del_gid(const struct ib_gid_attr *attr, void **context);
 int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
+void erdma_set_av_cfg(struct erdma_av_cfg *av_cfg, struct erdma_av *av);
 int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		    struct ib_udata *udata);
 int erdma_destroy_ah(struct ib_ah *ibah, u32 flags);
-- 
2.43.5


