Return-Path: <linux-rdma+bounces-6104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9E9D9215
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D8B24926
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771D192B77;
	Tue, 26 Nov 2024 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bo46w/oT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133ED1922E5
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604649; cv=none; b=MTzpZ37H5s9Ki8xGOzfccVfXxrnplTOvHwn6+zUR/xjdIui9QhoOVuN3yiEnam7ebxMVUAnKWo38DrXFLPTkkPsCU/QVUeaJi/SSqdkJxbLftXTCGEpnBgbK2bnsfP5sIzvSnRxUyoN3oyq+uRmNiKHTYVMtEP/kQQOLO874M2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604649; c=relaxed/simple;
	bh=fRwS+DzYPL6UBiw2611wS575SpO4WgndvASaels2SWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcGYrHRCOi+RzVHP9Ria9z1XiIYEiVwjKS6MfSElh4zmps8f9iGUoVM/u4oTdBAng9qkaKS6S5/qVwqL6zsDaGgDooPoZ5kHVhRIugYIo/VG5f47zODIwowtnCxd0gLb7VuoQic1+IkkJTvzPb5UYfnArEd+GSGBUsEkiJfDdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bo46w/oT; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732604639; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=L4GCGbL5e8LNi4UmZ65uunvu5nQlgXrIjHS6/yjL5wo=;
	b=bo46w/oTcSxbIHmH8vtr+oToj6mXeJN18FptC84t5MaHnmVcAtIgTNQaDDStiiN1W+HCYBNR0lasOB5ccMuLQI+nMqo1oWyUcI9xStp4Q8OTHDDTvvGUIKx0ooq5ndowrj5vqCmgBgp9J6srNjKMiuyXoMdaJoxhvey+SvBxye8=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKHMnQj_1732604638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 15:03:59 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 7/8] RDMA/erdma: Add the query_qp command to the cmdq
Date: Tue, 26 Nov 2024 14:59:13 +0800
Message-ID: <20241126070351.92787-8-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certian QP attributes, such as sq_draining, can only be obtained
by querying the hardware on the erdma RoCEv2 device. To address this,
we add the query_qp command to the cmdq and parse the response to
retrieve corresponding QP attributes.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    | 12 +++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 38 +++++++++++++++++++++--
 drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 3b0f7fc4ff31..809e77dde271 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -154,6 +154,7 @@ enum CMDQ_RDMA_OPCODE {
 	CMDQ_OPCODE_SET_GID = 14,
 	CMDQ_OPCODE_CREATE_AH = 15,
 	CMDQ_OPCODE_DESTROY_AH = 16,
+	CMDQ_OPCODE_QUERY_QP = 17,
 };
 
 enum CMDQ_COMMON_OPCODE {
@@ -362,6 +363,17 @@ struct erdma_cmdq_mod_qp_req_rocev2 {
 	struct erdma_av_cfg av_cfg;
 };
 
+/* query qp response mask */
+#define ERDMA_CMD_QUERY_QP_RESP_SQ_PSN_MASK GENMASK_ULL(23, 0)
+#define ERDMA_CMD_QUERY_QP_RESP_RQ_PSN_MASK GENMASK_ULL(47, 24)
+#define ERDMA_CMD_QUERY_QP_RESP_QP_STATE_MASK GENMASK_ULL(55, 48)
+#define ERDMA_CMD_QUERY_QP_RESP_SQ_DRAINING_MASK GENMASK_ULL(56, 56)
+
+struct erdma_cmdq_query_qp_req_rocev2 {
+	u64 hdr;
+	u32 qpn;
+};
+
 /* create qp cfg0 */
 #define ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK GENMASK(31, 20)
 #define ERDMA_CMD_CREATE_QP_QPN_MASK GENMASK(19, 0)
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index e382d6e243e9..28b792c31059 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1741,8 +1741,11 @@ static enum ib_qp_state query_qp_state(struct erdma_qp *qp)
 int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		   int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
+	struct erdma_cmdq_query_qp_req_rocev2 req;
 	struct erdma_dev *dev;
 	struct erdma_qp *qp;
+	u64 resp;
+	int ret;
 
 	if (ibqp && qp_attr && qp_init_attr) {
 		qp = to_eqp(ibqp);
@@ -1769,8 +1772,37 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	qp_init_attr->cap = qp_attr->cap;
 
-	qp_attr->qp_state = query_qp_state(qp);
-	qp_attr->cur_qp_state = query_qp_state(qp);
+	if (erdma_device_rocev2(dev)) {
+		/* Query hardware to get some attributes */
+		erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+					CMDQ_OPCODE_QUERY_QP);
+		req.qpn = QP_ID(qp);
+
+		ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp,
+					  NULL);
+		if (ret)
+			return ret;
+
+		qp_attr->sq_psn =
+			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_SQ_PSN_MASK, resp);
+		qp_attr->rq_psn =
+			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_RQ_PSN_MASK, resp);
+		qp_attr->qp_state = rocev2_to_ib_qps(
+			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_QP_STATE_MASK, resp));
+		qp_attr->cur_qp_state = qp_attr->qp_state;
+		qp_attr->sq_draining = FIELD_GET(
+			ERDMA_CMD_QUERY_QP_RESP_SQ_DRAINING_MASK, resp);
+
+		qp_attr->pkey_index = 0;
+		qp_attr->dest_qp_num = qp->attrs.rocev2.dst_qpn;
+
+		if (qp->ibqp.qp_type == IB_QPT_RC)
+			erdma_av_to_attr(&qp->attrs.rocev2.av,
+					 &qp_attr->ah_attr);
+	} else {
+		qp_attr->qp_state = query_qp_state(qp);
+		qp_attr->cur_qp_state = qp_attr->qp_state;
+	}
 
 	return 0;
 }
@@ -2095,7 +2127,7 @@ void erdma_attr_to_av(const struct rdma_ah_attr *ah_attr, struct erdma_av *av,
 		av->ntype = ERDMA_NETWORK_TYPE_IPV6;
 }
 
-static void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *attr)
+void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *attr)
 {
 	attr->type = RDMA_AH_ATTR_TYPE_ROCE;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 5d8cbac76434..4a506b960a44 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -485,6 +485,7 @@ int erdma_del_gid(const struct ib_gid_attr *attr, void **context);
 int erdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
 void erdma_attr_to_av(const struct rdma_ah_attr *ah_attr, struct erdma_av *av,
 		      u16 sport);
+void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *attr);
 void erdma_set_av_cfg(struct erdma_av_cfg *av_cfg, struct erdma_av *av);
 int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		    struct ib_udata *udata);
-- 
2.43.5


