Return-Path: <linux-rdma+bounces-6403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9299EC1F3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538C3166C70
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37841FBEB1;
	Wed, 11 Dec 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gr88Z1ex"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F31FAC5D
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882983; cv=none; b=Xi684l2wGUS4hk+izZjwjPLqckcQGg7QMiJB8zFKZ7Z+z2Zk56rO5yabJzqbOMHUmujwGksCC0NxNjcSuFBYmTWGq2UnMWNqu9AWDqr0AQfEAj5OnDg2pemDv5rWGVC4Bdl6LqOnsHczdgoLR8tYSJD9XlVGVGUJG+TOLT2ED0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882983; c=relaxed/simple;
	bh=Wou3Rb7FNBBrGG0/aVPDfE6DmRKCIrOnAjgjbwt3wc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebn5jwB9siwD0u4n+gK4nkUw3mrlkuQIOrcBtcoN1MlXsESMlljqSCufR3qU+jclXBWqO9HUAxfXbo7sXN26nsLybZZFtKhphvSYKB9PCMNR/WxWb6ReU6cT+aUldZCUXeS5jhaWsIgwH/IIpSRIqXBNS0QpMjF7szMF+4a1ZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gr88Z1ex; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882979; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=p+TEDhvp7etbr2vhVKRRF1R0B1jBE2sB+9nHA22TqEw=;
	b=gr88Z1ex063IC/DbtnLt9rBwD/14fLZFs/6+Axp0IfpGYsyL4KDLYzCK2qJo3OPr6+lHIfv3RiE+KjVCa+H6wUEdRbZ3MaQ1/vtl6JzEn/Be7oBge2EjiVfPdpKKfOquda1KUhyss4e6uhsN4u6DxAR88Nq4kSYQ9fBXsECxaRQ=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGPQHd_1733882978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:38 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 7/8] RDMA/erdma: Add the query_qp command to the cmdq
Date: Wed, 11 Dec 2024 10:09:07 +0800
Message-ID: <20241211020930.68833-8-boshiyu@linux.alibaba.com>
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

Certian QP attributes, such as sq_draining, can only be obtained
by querying the hardware on the erdma RoCEv2 device. To address this,
we add the query_qp command to the cmdq and parse the response to
retrieve corresponding QP attributes.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    | 12 +++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 58 +++++++++++++++++++----
 2 files changed, 60 insertions(+), 10 deletions(-)

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
index 0543ff972247..e7fd3b948688 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1563,6 +1563,19 @@ static void erdma_attr_to_av(const struct rdma_ah_attr *ah_attr,
 		av->ntype = ERDMA_NETWORK_TYPE_IPV6;
 }
 
+static void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *ah_attr)
+{
+	ah_attr->type = RDMA_AH_ATTR_TYPE_ROCE;
+
+	rdma_ah_set_sl(ah_attr, av->sl);
+	rdma_ah_set_port_num(ah_attr, av->port);
+	rdma_ah_set_ah_flags(ah_attr, IB_AH_GRH);
+
+	rdma_ah_set_grh(ah_attr, NULL, av->flow_label, av->sgid_index,
+			av->hop_limit, av->traffic_class);
+	rdma_ah_set_dgid_raw(ah_attr, av->dgid);
+}
+
 static int ib_qps_to_erdma_qps[ERDMA_PROTO_COUNT][IB_QPS_ERR + 1] = {
 	[ERDMA_PROTO_IWARP] = {
 		[IB_QPS_RESET] = ERDMA_QPS_IWARP_IDLE,
@@ -1764,8 +1777,11 @@ static enum ib_qp_state query_qp_state(struct erdma_qp *qp)
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
@@ -1792,8 +1808,37 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
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
@@ -2185,14 +2230,7 @@ int erdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 	struct erdma_ah *ah = to_eah(ibah);
 
 	memset(ah_attr, 0, sizeof(*ah_attr));
-
-	ah_attr->type = RDMA_AH_ATTR_TYPE_ROCE;
-	rdma_ah_set_sl(ah_attr, ah->av.sl);
-	rdma_ah_set_port_num(ah_attr, ah->av.port);
-	rdma_ah_set_ah_flags(ah_attr, IB_AH_GRH);
-	rdma_ah_set_grh(ah_attr, NULL, ah->av.flow_label, ah->av.sgid_index,
-			ah->av.hop_limit, ah->av.traffic_class);
-	rdma_ah_set_dgid_raw(ah_attr, ah->av.dgid);
+	erdma_av_to_attr(&ah->av, ah_attr);
 
 	return 0;
 }
-- 
2.43.5


