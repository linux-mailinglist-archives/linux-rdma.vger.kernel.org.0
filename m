Return-Path: <linux-rdma+bounces-6408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1D9EC1F9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44595188B96B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055541FC7D7;
	Wed, 11 Dec 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vo0+iLfc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981A1FC111
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882988; cv=none; b=ctW5NR641Znaibv72fCbmiX/w8Yyu4m1dn0DrFhxx6GKXMksrG/2X2BhTgibtqrHiJmiPar45Pck0ppFD2JC+8wROub92Gp6W3LwiC71CIoDYV25lATFJekRQLFPWFv3G2jTqNQwXBJtEG6TFRejhDVXCOMOQr7WNbWdsYHDuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882988; c=relaxed/simple;
	bh=1FLUoHSDJkoAoSI//rYXSoQBuy3pX40KNwTi68l9mEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4+pD5HtoVBDA3u1nIBUstJuWXLeAyMjDMVDCd84odzqss84eBqWoMjfGibCd4rRulocdyVYHWQyBK5jTICkmnLbaV4//07AwIqdaqlo/w99U1wpp3AQLDo34tpjUudiphV6J7MXJMFpeaO/alqy0snLdKFmzCcwHdPY8+I6jHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vo0+iLfc; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882978; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=glrpYI6/qiCM6ps07ichd4BnacevnQUSKB6eWQltXPs=;
	b=vo0+iLfc324fv/nF1EbeW0TEEfDK8/+wWFlNMm53ImlhjuqyMNnkiuAhfiFp8+ivSA1qIvowCCmmGuS/Fkbf49pq8afqvb389vsPNklx7pNDWRByKVpsQ/ENpeR+GzEIPvCX9sjCO6iBjCezxk3EWmfGk4jO2Ys8+FmVvmFAgNI=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGVL3L_1733882977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:37 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 6/8] RDMA/erdma: Refactor the code of the modify_qp interface
Date: Wed, 11 Dec 2024 10:09:06 +0800
Message-ID: <20241211020930.68833-7-boshiyu@linux.alibaba.com>
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

The procedure for modifying QP is similar for both the iWARP and
RoCEv2 protocols. Therefore, we unify the code and provide the
erdma_modify_qp() interface for both protocols.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cm.c    |  71 ++++----
 drivers/infiniband/hw/erdma/erdma_hw.h    |   1 +
 drivers/infiniband/hw/erdma/erdma_main.c  |   3 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    | 136 ++++++++------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 210 +++++++++++-----------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  75 +++++---
 6 files changed, 276 insertions(+), 220 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 771059a8eb7d..1b23c698ec25 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -567,7 +567,8 @@ static int erdma_proc_mpareq(struct erdma_cep *cep)
 
 static int erdma_proc_mpareply(struct erdma_cep *cep)
 {
-	struct erdma_qp_attrs qp_attrs;
+	enum erdma_qpa_mask_iwarp to_modify_attrs = 0;
+	struct erdma_mod_qp_params_iwarp params;
 	struct erdma_qp *qp = cep->qp;
 	struct mpa_rr *rep;
 	int ret;
@@ -597,26 +598,29 @@ static int erdma_proc_mpareply(struct erdma_cep *cep)
 		return -EINVAL;
 	}
 
-	memset(&qp_attrs, 0, sizeof(qp_attrs));
-	qp_attrs.irq_size = cep->ird;
-	qp_attrs.orq_size = cep->ord;
-	qp_attrs.state = ERDMA_QP_STATE_RTS;
+	memset(&params, 0, sizeof(params));
+	params.state = ERDMA_QPS_IWARP_RTS;
+	params.irq_size = cep->ird;
+	params.orq_size = cep->ord;
 
 	down_write(&qp->state_lock);
-	if (qp->attrs.state > ERDMA_QP_STATE_RTR) {
+	if (qp->attrs.iwarp.state > ERDMA_QPS_IWARP_RTR) {
 		ret = -EINVAL;
 		up_write(&qp->state_lock);
 		goto out_err;
 	}
 
-	qp->attrs.qp_type = ERDMA_QP_ACTIVE;
-	if (__mpa_ext_cc(cep->mpa.ext_data.bits) != qp->attrs.cc)
-		qp->attrs.cc = COMPROMISE_CC;
+	to_modify_attrs = ERDMA_QPA_IWARP_STATE | ERDMA_QPA_IWARP_LLP_HANDLE |
+			  ERDMA_QPA_IWARP_MPA | ERDMA_QPA_IWARP_IRD |
+			  ERDMA_QPA_IWARP_ORD;
 
-	ret = erdma_modify_qp_internal(qp, &qp_attrs,
-				       ERDMA_QP_ATTR_STATE |
-				       ERDMA_QP_ATTR_LLP_HANDLE |
-				       ERDMA_QP_ATTR_MPA);
+	params.qp_type = ERDMA_QP_ACTIVE;
+	if (__mpa_ext_cc(cep->mpa.ext_data.bits) != qp->attrs.cc) {
+		to_modify_attrs |= ERDMA_QPA_IWARP_CC;
+		params.cc = COMPROMISE_CC;
+	}
+
+	ret = erdma_modify_qp_state_iwarp(qp, &params, to_modify_attrs);
 
 	up_write(&qp->state_lock);
 
@@ -722,7 +726,7 @@ static int erdma_newconn_connected(struct erdma_cep *cep)
 	__mpa_rr_set_revision(&cep->mpa.hdr.params.bits, MPA_REVISION_EXT_1);
 
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, MPA_KEY_SIZE);
-	cep->mpa.ext_data.cookie = cpu_to_be32(cep->qp->attrs.cookie);
+	cep->mpa.ext_data.cookie = cpu_to_be32(cep->qp->attrs.iwarp.cookie);
 	__mpa_ext_set_cc(&cep->mpa.ext_data.bits, cep->qp->attrs.cc);
 
 	ret = erdma_send_mpareqrep(cep, cep->private_data, cep->pd_len);
@@ -1126,10 +1130,11 @@ int erdma_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 int erdma_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 {
-	struct erdma_dev *dev = to_edev(id->device);
 	struct erdma_cep *cep = (struct erdma_cep *)id->provider_data;
+	struct erdma_mod_qp_params_iwarp mod_qp_params;
+	enum erdma_qpa_mask_iwarp to_modify_attrs = 0;
+	struct erdma_dev *dev = to_edev(id->device);
 	struct erdma_qp *qp;
-	struct erdma_qp_attrs qp_attrs;
 	int ret;
 
 	erdma_cep_set_inuse(cep);
@@ -1156,7 +1161,7 @@ int erdma_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	erdma_qp_get(qp);
 
 	down_write(&qp->state_lock);
-	if (qp->attrs.state > ERDMA_QP_STATE_RTR) {
+	if (qp->attrs.iwarp.state > ERDMA_QPS_IWARP_RTR) {
 		ret = -EINVAL;
 		up_write(&qp->state_lock);
 		goto error;
@@ -1181,11 +1186,11 @@ int erdma_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->cm_id = id;
 	id->add_ref(id);
 
-	memset(&qp_attrs, 0, sizeof(qp_attrs));
-	qp_attrs.orq_size = params->ord;
-	qp_attrs.irq_size = params->ird;
+	memset(&mod_qp_params, 0, sizeof(mod_qp_params));
 
-	qp_attrs.state = ERDMA_QP_STATE_RTS;
+	mod_qp_params.irq_size = params->ird;
+	mod_qp_params.orq_size = params->ord;
+	mod_qp_params.state = ERDMA_QPS_IWARP_RTS;
 
 	/* Associate QP with CEP */
 	erdma_cep_get(cep);
@@ -1194,19 +1199,21 @@ int erdma_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	cep->state = ERDMA_EPSTATE_RDMA_MODE;
 
-	qp->attrs.qp_type = ERDMA_QP_PASSIVE;
-	qp->attrs.pd_len = params->private_data_len;
+	mod_qp_params.qp_type = ERDMA_QP_PASSIVE;
+	mod_qp_params.pd_len = params->private_data_len;
 
-	if (qp->attrs.cc != __mpa_ext_cc(cep->mpa.ext_data.bits))
-		qp->attrs.cc = COMPROMISE_CC;
+	to_modify_attrs = ERDMA_QPA_IWARP_STATE | ERDMA_QPA_IWARP_ORD |
+			  ERDMA_QPA_IWARP_LLP_HANDLE | ERDMA_QPA_IWARP_IRD |
+			  ERDMA_QPA_IWARP_MPA;
+
+	if (qp->attrs.cc != __mpa_ext_cc(cep->mpa.ext_data.bits)) {
+		to_modify_attrs |= ERDMA_QPA_IWARP_CC;
+		mod_qp_params.cc = COMPROMISE_CC;
+	}
 
 	/* move to rts */
-	ret = erdma_modify_qp_internal(qp, &qp_attrs,
-				       ERDMA_QP_ATTR_STATE |
-				       ERDMA_QP_ATTR_ORD |
-				       ERDMA_QP_ATTR_LLP_HANDLE |
-				       ERDMA_QP_ATTR_IRD |
-				       ERDMA_QP_ATTR_MPA);
+	ret = erdma_modify_qp_state_iwarp(qp, &mod_qp_params, to_modify_attrs);
+
 	up_write(&qp->state_lock);
 
 	if (ret)
@@ -1214,7 +1221,7 @@ int erdma_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	cep->mpa.ext_data.bits = 0;
 	__mpa_ext_set_cc(&cep->mpa.ext_data.bits, qp->attrs.cc);
-	cep->mpa.ext_data.cookie = cpu_to_be32(cep->qp->attrs.cookie);
+	cep->mpa.ext_data.cookie = cpu_to_be32(cep->qp->attrs.iwarp.cookie);
 
 	ret = erdma_send_mpareqrep(cep, params->private_data,
 				   params->private_data_len);
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index b5c1aca71144..3b0f7fc4ff31 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -31,6 +31,7 @@
 enum erdma_proto_type {
 	ERDMA_PROTO_IWARP = 0,
 	ERDMA_PROTO_ROCEV2 = 1,
+	ERDMA_PROTO_COUNT = 2,
 };
 
 /* PCIe Bar0 Registers. */
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 2fca163b1744..51cc8b17b9e9 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -486,7 +486,6 @@ static const struct ib_device_ops erdma_device_ops_rocev2 = {
 	.query_pkey = erdma_query_pkey,
 	.create_ah = erdma_create_ah,
 	.destroy_ah = erdma_destroy_ah,
-	.modify_qp = erdma_modify_qp_rocev2,
 };
 
 static const struct ib_device_ops erdma_device_ops_iwarp = {
@@ -498,7 +497,6 @@ static const struct ib_device_ops erdma_device_ops_iwarp = {
 	.iw_get_qp = erdma_get_ibqp,
 	.iw_reject = erdma_reject,
 	.iw_rem_ref = erdma_qp_put_ref,
-	.modify_qp = erdma_modify_qp,
 };
 
 static const struct ib_device_ops erdma_device_ops = {
@@ -533,6 +531,7 @@ static const struct ib_device_ops erdma_device_ops = {
 	.query_qp = erdma_query_qp,
 	.req_notify_cq = erdma_req_notify_cq,
 	.reg_user_mr = erdma_reg_user_mr,
+	.modify_qp = erdma_modify_qp,
 
 	INIT_RDMA_OBJ_SIZE(ib_cq, erdma_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, erdma_pd, ibpd),
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 13977f4e9463..03d93f026fca 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -11,20 +11,20 @@
 
 void erdma_qp_llp_close(struct erdma_qp *qp)
 {
-	struct erdma_qp_attrs qp_attrs;
+	struct erdma_mod_qp_params_iwarp params;
 
 	down_write(&qp->state_lock);
 
-	switch (qp->attrs.state) {
-	case ERDMA_QP_STATE_RTS:
-	case ERDMA_QP_STATE_RTR:
-	case ERDMA_QP_STATE_IDLE:
-	case ERDMA_QP_STATE_TERMINATE:
-		qp_attrs.state = ERDMA_QP_STATE_CLOSING;
-		erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
+	switch (qp->attrs.iwarp.state) {
+	case ERDMA_QPS_IWARP_RTS:
+	case ERDMA_QPS_IWARP_RTR:
+	case ERDMA_QPS_IWARP_IDLE:
+	case ERDMA_QPS_IWARP_TERMINATE:
+		params.state = ERDMA_QPS_IWARP_CLOSING;
+		erdma_modify_qp_state_iwarp(qp, &params, ERDMA_QPA_IWARP_STATE);
 		break;
-	case ERDMA_QP_STATE_CLOSING:
-		qp->attrs.state = ERDMA_QP_STATE_IDLE;
+	case ERDMA_QPS_IWARP_CLOSING:
+		qp->attrs.iwarp.state = ERDMA_QPS_IWARP_IDLE;
 		break;
 	default:
 		break;
@@ -48,9 +48,10 @@ struct ib_qp *erdma_get_ibqp(struct ib_device *ibdev, int id)
 	return NULL;
 }
 
-static int erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
-					struct erdma_qp_attrs *attrs,
-					enum erdma_qp_attr_mask mask)
+static int
+erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
+			     struct erdma_mod_qp_params_iwarp *params,
+			     enum erdma_qpa_mask_iwarp mask)
 {
 	int ret;
 	struct erdma_dev *dev = qp->dev;
@@ -59,12 +60,15 @@ static int erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
 	struct erdma_cep *cep = qp->cep;
 	struct sockaddr_storage local_addr, remote_addr;
 
-	if (!(mask & ERDMA_QP_ATTR_LLP_HANDLE))
+	if (!(mask & ERDMA_QPA_IWARP_LLP_HANDLE))
 		return -EINVAL;
 
-	if (!(mask & ERDMA_QP_ATTR_MPA))
+	if (!(mask & ERDMA_QPA_IWARP_MPA))
 		return -EINVAL;
 
+	if (!(mask & ERDMA_QPA_IWARP_CC))
+		params->cc = qp->attrs.cc;
+
 	ret = getname_local(cep->sock, &local_addr);
 	if (ret < 0)
 		return ret;
@@ -73,18 +77,16 @@ static int erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
 	if (ret < 0)
 		return ret;
 
-	qp->attrs.state = ERDMA_QP_STATE_RTS;
-
 	tp = tcp_sk(qp->cep->sock->sk);
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
 				CMDQ_OPCODE_MODIFY_QP);
 
-	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, qp->attrs.state) |
-		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_CC_MASK, qp->attrs.cc) |
+	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, params->state) |
+		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_CC_MASK, params->cc) |
 		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
 
-	req.cookie = be32_to_cpu(qp->cep->mpa.ext_data.cookie);
+	req.cookie = be32_to_cpu(cep->mpa.ext_data.cookie);
 	req.dip = to_sockaddr_in(remote_addr).sin_addr.s_addr;
 	req.sip = to_sockaddr_in(local_addr).sin_addr.s_addr;
 	req.dport = to_sockaddr_in(remote_addr).sin_port;
@@ -92,33 +94,55 @@ static int erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
 
 	req.send_nxt = tp->snd_nxt;
 	/* rsvd tcp seq for mpa-rsp in server. */
-	if (qp->attrs.qp_type == ERDMA_QP_PASSIVE)
-		req.send_nxt += MPA_DEFAULT_HDR_LEN + qp->attrs.pd_len;
+	if (params->qp_type == ERDMA_QP_PASSIVE)
+		req.send_nxt += MPA_DEFAULT_HDR_LEN + params->pd_len;
 	req.recv_nxt = tp->rcv_nxt;
 
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	if (ret)
+		return ret;
+
+	if (mask & ERDMA_QPA_IWARP_IRD)
+		qp->attrs.irq_size = params->irq_size;
+
+	if (mask & ERDMA_QPA_IWARP_ORD)
+		qp->attrs.orq_size = params->orq_size;
+
+	if (mask & ERDMA_QPA_IWARP_CC)
+		qp->attrs.cc = params->cc;
+
+	qp->attrs.iwarp.state = ERDMA_QPS_IWARP_RTS;
+
+	return 0;
 }
 
-static int erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
-					 struct erdma_qp_attrs *attrs,
-					 enum erdma_qp_attr_mask mask)
+static int
+erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
+			      struct erdma_mod_qp_params_iwarp *params,
+			      enum erdma_qpa_mask_iwarp mask)
 {
 	struct erdma_dev *dev = qp->dev;
 	struct erdma_cmdq_modify_qp_req req;
-
-	qp->attrs.state = attrs->state;
+	int ret;
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
 				CMDQ_OPCODE_MODIFY_QP);
 
-	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, attrs->state) |
+	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, params->state) |
 		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
 
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	if (ret)
+		return ret;
+
+	qp->attrs.iwarp.state = params->state;
+
+	return 0;
 }
 
-int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
-			     enum erdma_qp_attr_mask mask)
+int erdma_modify_qp_state_iwarp(struct erdma_qp *qp,
+				struct erdma_mod_qp_params_iwarp *params,
+				int mask)
 {
 	bool need_reflush = false;
 	int drop_conn, ret = 0;
@@ -126,31 +150,31 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 	if (!mask)
 		return 0;
 
-	if (!(mask & ERDMA_QP_ATTR_STATE))
+	if (!(mask & ERDMA_QPA_IWARP_STATE))
 		return 0;
 
-	switch (qp->attrs.state) {
-	case ERDMA_QP_STATE_IDLE:
-	case ERDMA_QP_STATE_RTR:
-		if (attrs->state == ERDMA_QP_STATE_RTS) {
-			ret = erdma_modify_qp_state_to_rts(qp, attrs, mask);
-		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
-			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+	switch (qp->attrs.iwarp.state) {
+	case ERDMA_QPS_IWARP_IDLE:
+	case ERDMA_QPS_IWARP_RTR:
+		if (params->state == ERDMA_QPS_IWARP_RTS) {
+			ret = erdma_modify_qp_state_to_rts(qp, params, mask);
+		} else if (params->state == ERDMA_QPS_IWARP_ERROR) {
+			qp->attrs.iwarp.state = ERDMA_QPS_IWARP_ERROR;
 			need_reflush = true;
 			if (qp->cep) {
 				erdma_cep_put(qp->cep);
 				qp->cep = NULL;
 			}
-			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+			ret = erdma_modify_qp_state_to_stop(qp, params, mask);
 		}
 		break;
-	case ERDMA_QP_STATE_RTS:
+	case ERDMA_QPS_IWARP_RTS:
 		drop_conn = 0;
 
-		if (attrs->state == ERDMA_QP_STATE_CLOSING ||
-		    attrs->state == ERDMA_QP_STATE_TERMINATE ||
-		    attrs->state == ERDMA_QP_STATE_ERROR) {
-			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
+		if (params->state == ERDMA_QPS_IWARP_CLOSING ||
+		    params->state == ERDMA_QPS_IWARP_TERMINATE ||
+		    params->state == ERDMA_QPS_IWARP_ERROR) {
+			ret = erdma_modify_qp_state_to_stop(qp, params, mask);
 			drop_conn = 1;
 			need_reflush = true;
 		}
@@ -159,17 +183,17 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 			erdma_qp_cm_drop(qp);
 
 		break;
-	case ERDMA_QP_STATE_TERMINATE:
-		if (attrs->state == ERDMA_QP_STATE_ERROR)
-			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+	case ERDMA_QPS_IWARP_TERMINATE:
+		if (params->state == ERDMA_QPS_IWARP_ERROR)
+			qp->attrs.iwarp.state = ERDMA_QPS_IWARP_ERROR;
 		break;
-	case ERDMA_QP_STATE_CLOSING:
-		if (attrs->state == ERDMA_QP_STATE_IDLE) {
-			qp->attrs.state = ERDMA_QP_STATE_IDLE;
-		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
-			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
-			qp->attrs.state = ERDMA_QP_STATE_ERROR;
-		} else if (attrs->state != ERDMA_QP_STATE_CLOSING) {
+	case ERDMA_QPS_IWARP_CLOSING:
+		if (params->state == ERDMA_QPS_IWARP_IDLE) {
+			qp->attrs.iwarp.state = ERDMA_QPS_IWARP_IDLE;
+		} else if (params->state == ERDMA_QPS_IWARP_ERROR) {
+			ret = erdma_modify_qp_state_to_stop(qp, params, mask);
+			qp->attrs.iwarp.state = ERDMA_QPS_IWARP_ERROR;
+		} else if (params->state != ERDMA_QPS_IWARP_CLOSING) {
 			return -ECONNABORTED;
 		}
 		break;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 79693fb40aec..0543ff972247 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -122,7 +122,7 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
 				  &resp1);
 	if (!err && erdma_device_iwarp(dev))
-		qp->attrs.cookie =
+		qp->attrs.iwarp.cookie =
 			FIELD_GET(ERDMA_CMDQ_CREATE_QP_RESP_COOKIE_MASK, resp0);
 
 	return err;
@@ -1019,7 +1019,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;
 
 	if (erdma_device_iwarp(qp->dev))
-		qp->attrs.state = ERDMA_QP_STATE_IDLE;
+		qp->attrs.iwarp.state = ERDMA_QPS_IWARP_IDLE;
 	else
 		qp->attrs.rocev2.state = ERDMA_QPS_ROCEV2_RESET;
 
@@ -1296,18 +1296,18 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct erdma_dev *dev = to_edev(ibqp->device);
 	struct erdma_ucontext *ctx = rdma_udata_to_drv_context(
 		udata, struct erdma_ucontext, ibucontext);
-	struct erdma_mod_qp_params_rocev2 rocev2_params;
-	struct erdma_qp_attrs qp_attrs;
-	int err;
 	struct erdma_cmdq_destroy_qp_req req;
+	union erdma_mod_qp_params params;
+	int err;
 
 	down_write(&qp->state_lock);
 	if (erdma_device_iwarp(dev)) {
-		qp_attrs.state = ERDMA_QP_STATE_ERROR;
-		erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
+		params.iwarp.state = ERDMA_QPS_IWARP_ERROR;
+		erdma_modify_qp_state_iwarp(qp, &params.iwarp,
+					    ERDMA_QPA_IWARP_STATE);
 	} else {
-		rocev2_params.state = ERDMA_QPS_ROCEV2_ERROR;
-		erdma_modify_qp_state_rocev2(qp, &rocev2_params,
+		params.rocev2.state = ERDMA_QPS_ROCEV2_ERROR;
+		erdma_modify_qp_state_rocev2(qp, &params.rocev2,
 					     ERDMA_QPA_ROCEV2_STATE);
 	}
 	up_write(&qp->state_lock);
@@ -1563,38 +1563,69 @@ static void erdma_attr_to_av(const struct rdma_ah_attr *ah_attr,
 		av->ntype = ERDMA_NETWORK_TYPE_IPV6;
 }
 
-static int ib_qp_state_to_erdma_qp_state[IB_QPS_ERR + 1] = {
-	[IB_QPS_RESET] = ERDMA_QP_STATE_IDLE,
-	[IB_QPS_INIT] = ERDMA_QP_STATE_IDLE,
-	[IB_QPS_RTR] = ERDMA_QP_STATE_RTR,
-	[IB_QPS_RTS] = ERDMA_QP_STATE_RTS,
-	[IB_QPS_SQD] = ERDMA_QP_STATE_CLOSING,
-	[IB_QPS_SQE] = ERDMA_QP_STATE_TERMINATE,
-	[IB_QPS_ERR] = ERDMA_QP_STATE_ERROR
+static int ib_qps_to_erdma_qps[ERDMA_PROTO_COUNT][IB_QPS_ERR + 1] = {
+	[ERDMA_PROTO_IWARP] = {
+		[IB_QPS_RESET] = ERDMA_QPS_IWARP_IDLE,
+		[IB_QPS_INIT] = ERDMA_QPS_IWARP_IDLE,
+		[IB_QPS_RTR] = ERDMA_QPS_IWARP_RTR,
+		[IB_QPS_RTS] = ERDMA_QPS_IWARP_RTS,
+		[IB_QPS_SQD] = ERDMA_QPS_IWARP_CLOSING,
+		[IB_QPS_SQE] = ERDMA_QPS_IWARP_TERMINATE,
+		[IB_QPS_ERR] = ERDMA_QPS_IWARP_ERROR,
+	},
+	[ERDMA_PROTO_ROCEV2] = {
+		[IB_QPS_RESET] = ERDMA_QPS_ROCEV2_RESET,
+		[IB_QPS_INIT] = ERDMA_QPS_ROCEV2_INIT,
+		[IB_QPS_RTR] = ERDMA_QPS_ROCEV2_RTR,
+		[IB_QPS_RTS] = ERDMA_QPS_ROCEV2_RTS,
+		[IB_QPS_SQD] = ERDMA_QPS_ROCEV2_SQD,
+		[IB_QPS_SQE] = ERDMA_QPS_ROCEV2_SQE,
+		[IB_QPS_ERR] = ERDMA_QPS_ROCEV2_ERROR,
+	},
 };
 
-static int ib_qps_to_erdma_qps_rocev2[IB_QPS_ERR + 1] = {
-	[IB_QPS_RESET] = ERDMA_QPS_ROCEV2_RESET,
-	[IB_QPS_INIT] = ERDMA_QPS_ROCEV2_INIT,
-	[IB_QPS_RTR] = ERDMA_QPS_ROCEV2_RTR,
-	[IB_QPS_RTS] = ERDMA_QPS_ROCEV2_RTS,
-	[IB_QPS_SQD] = ERDMA_QPS_ROCEV2_SQD,
-	[IB_QPS_SQE] = ERDMA_QPS_ROCEV2_SQE,
-	[IB_QPS_ERR] = ERDMA_QPS_ROCEV2_ERROR,
+static int erdma_qps_to_ib_qps[ERDMA_PROTO_COUNT][ERDMA_QPS_ROCEV2_COUNT] = {
+	[ERDMA_PROTO_IWARP] = {
+		[ERDMA_QPS_IWARP_IDLE] = IB_QPS_INIT,
+		[ERDMA_QPS_IWARP_RTR] = IB_QPS_RTR,
+		[ERDMA_QPS_IWARP_RTS] = IB_QPS_RTS,
+		[ERDMA_QPS_IWARP_CLOSING] = IB_QPS_ERR,
+		[ERDMA_QPS_IWARP_TERMINATE] = IB_QPS_ERR,
+		[ERDMA_QPS_IWARP_ERROR] = IB_QPS_ERR,
+	},
+	[ERDMA_PROTO_ROCEV2] = {
+		[ERDMA_QPS_ROCEV2_RESET] = IB_QPS_RESET,
+		[ERDMA_QPS_ROCEV2_INIT] = IB_QPS_INIT,
+		[ERDMA_QPS_ROCEV2_RTR] = IB_QPS_RTR,
+		[ERDMA_QPS_ROCEV2_RTS] = IB_QPS_RTS,
+		[ERDMA_QPS_ROCEV2_SQD] = IB_QPS_SQD,
+		[ERDMA_QPS_ROCEV2_SQE] = IB_QPS_SQE,
+		[ERDMA_QPS_ROCEV2_ERROR] = IB_QPS_ERR,
+	},
 };
 
-static int erdma_qps_to_ib_qps_rocev2[ERDMA_QPS_ROCEV2_COUNT] = {
-	[ERDMA_QPS_ROCEV2_RESET] = IB_QPS_RESET,
-	[ERDMA_QPS_ROCEV2_INIT] = IB_QPS_INIT,
-	[ERDMA_QPS_ROCEV2_RTR] = IB_QPS_RTR,
-	[ERDMA_QPS_ROCEV2_RTS] = IB_QPS_RTS,
-	[ERDMA_QPS_ROCEV2_SQD] = IB_QPS_SQD,
-	[ERDMA_QPS_ROCEV2_SQE] = IB_QPS_SQE,
-	[ERDMA_QPS_ROCEV2_ERROR] = IB_QPS_ERR,
-};
+static inline enum erdma_qps_iwarp ib_to_iwarp_qps(enum ib_qp_state state)
+{
+	return ib_qps_to_erdma_qps[ERDMA_PROTO_IWARP][state];
+}
 
-static int erdma_check_qp_attr_rocev2(struct erdma_qp *qp,
-				      struct ib_qp_attr *attr, int attr_mask)
+static inline enum erdma_qps_rocev2 ib_to_rocev2_qps(enum ib_qp_state state)
+{
+	return ib_qps_to_erdma_qps[ERDMA_PROTO_ROCEV2][state];
+}
+
+static inline enum ib_qp_state iwarp_to_ib_qps(enum erdma_qps_iwarp state)
+{
+	return erdma_qps_to_ib_qps[ERDMA_PROTO_IWARP][state];
+}
+
+static inline enum ib_qp_state rocev2_to_ib_qps(enum erdma_qps_rocev2 state)
+{
+	return erdma_qps_to_ib_qps[ERDMA_PROTO_ROCEV2][state];
+}
+
+static int erdma_check_qp_attrs(struct erdma_qp *qp, struct ib_qp_attr *attr,
+				int attr_mask)
 {
 	enum ib_qp_state cur_state, nxt_state;
 	struct erdma_dev *dev = qp->dev;
@@ -1605,27 +1636,31 @@ static int erdma_check_qp_attr_rocev2(struct erdma_qp *qp,
 		goto out;
 	}
 
-	if ((attr_mask & IB_QP_PKEY_INDEX) &&
-	    attr->pkey_index >= ERDMA_MAX_PKEYS)
-		goto out;
-
 	if ((attr_mask & IB_QP_PORT) &&
 	    !rdma_is_port_valid(&dev->ibdev, attr->port_num))
 		goto out;
 
-	cur_state = (attr_mask & IB_QP_CUR_STATE) ?
-			    attr->cur_qp_state :
-			    erdma_qps_to_ib_qps_rocev2[qp->attrs.rocev2.state];
+	if (erdma_device_rocev2(dev)) {
+		cur_state = (attr_mask & IB_QP_CUR_STATE) ?
+				    attr->cur_qp_state :
+				    rocev2_to_ib_qps(qp->attrs.rocev2.state);
 
-	nxt_state = (attr_mask & IB_QP_STATE) ? attr->qp_state : cur_state;
+		nxt_state = (attr_mask & IB_QP_STATE) ? attr->qp_state :
+							cur_state;
 
-	if (!ib_modify_qp_is_ok(cur_state, nxt_state, qp->ibqp.qp_type,
-				attr_mask))
-		goto out;
+		if (!ib_modify_qp_is_ok(cur_state, nxt_state, qp->ibqp.qp_type,
+					attr_mask))
+			goto out;
 
-	if ((attr_mask & IB_QP_AV) &&
-	    erdma_check_gid_attr(rdma_ah_read_grh(&attr->ah_attr)->sgid_attr))
-		goto out;
+		if ((attr_mask & IB_QP_AV) &&
+		    erdma_check_gid_attr(
+			    rdma_ah_read_grh(&attr->ah_attr)->sgid_attr))
+			goto out;
+
+		if ((attr_mask & IB_QP_PKEY_INDEX) &&
+		    attr->pkey_index >= ERDMA_MAX_PKEYS)
+			goto out;
+	}
 
 	return 0;
 
@@ -1642,12 +1677,12 @@ static void erdma_init_mod_qp_params_rocev2(
 	u16 udp_sport;
 
 	if (ib_attr_mask & IB_QP_CUR_STATE)
-		cur_state = ib_qps_to_erdma_qps_rocev2[attr->cur_qp_state];
+		cur_state = ib_to_rocev2_qps(attr->cur_qp_state);
 	else
 		cur_state = qp->attrs.rocev2.state;
 
 	if (ib_attr_mask & IB_QP_STATE)
-		nxt_state = ib_qps_to_erdma_qps_rocev2[attr->qp_state];
+		nxt_state = ib_to_rocev2_qps(attr->qp_state);
 	else
 		nxt_state = cur_state;
 
@@ -1684,75 +1719,46 @@ static void erdma_init_mod_qp_params_rocev2(
 	*erdma_attr_mask = to_modify_attrs;
 }
 
-int erdma_modify_qp_rocev2(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-			   int attr_mask, struct ib_udata *udata)
+int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
+		    struct ib_udata *udata)
 {
-	struct erdma_mod_qp_params_rocev2 params;
 	struct erdma_qp *qp = to_eqp(ibqp);
+	union erdma_mod_qp_params params;
 	int ret = 0, erdma_attr_mask = 0;
 
 	down_write(&qp->state_lock);
 
-	ret = erdma_check_qp_attr_rocev2(qp, attr, attr_mask);
+	ret = erdma_check_qp_attrs(qp, attr, attr_mask);
 	if (ret)
 		goto out;
 
-	erdma_init_mod_qp_params_rocev2(qp, &params, &erdma_attr_mask, attr,
-					attr_mask);
-
-	ret = erdma_modify_qp_state_rocev2(qp, &params, erdma_attr_mask);
-
-out:
-	up_write(&qp->state_lock);
-	return ret;
-}
-
-int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
-		    struct ib_udata *udata)
-{
-	struct erdma_qp_attrs new_attrs;
-	enum erdma_qp_attr_mask erdma_attr_mask = 0;
-	struct erdma_qp *qp = to_eqp(ibqp);
-	int ret = 0;
-
-	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
-		return -EOPNOTSUPP;
-
-	memset(&new_attrs, 0, sizeof(new_attrs));
+	if (erdma_device_iwarp(qp->dev)) {
+		if (attr_mask & IB_QP_STATE) {
+			erdma_attr_mask |= ERDMA_QPA_IWARP_STATE;
+			params.iwarp.state = ib_to_iwarp_qps(attr->qp_state);
+		}
 
-	if (attr_mask & IB_QP_STATE) {
-		new_attrs.state = ib_qp_state_to_erdma_qp_state[attr->qp_state];
+		ret = erdma_modify_qp_state_iwarp(qp, &params.iwarp,
+						  erdma_attr_mask);
+	} else {
+		erdma_init_mod_qp_params_rocev2(
+			qp, &params.rocev2, &erdma_attr_mask, attr, attr_mask);
 
-		erdma_attr_mask |= ERDMA_QP_ATTR_STATE;
+		ret = erdma_modify_qp_state_rocev2(qp, &params.rocev2,
+						   erdma_attr_mask);
 	}
 
-	down_write(&qp->state_lock);
-
-	ret = erdma_modify_qp_internal(qp, &new_attrs, erdma_attr_mask);
-
+out:
 	up_write(&qp->state_lock);
-
 	return ret;
 }
 
 static enum ib_qp_state query_qp_state(struct erdma_qp *qp)
 {
-	switch (qp->attrs.state) {
-	case ERDMA_QP_STATE_IDLE:
-		return IB_QPS_INIT;
-	case ERDMA_QP_STATE_RTR:
-		return IB_QPS_RTR;
-	case ERDMA_QP_STATE_RTS:
-		return IB_QPS_RTS;
-	case ERDMA_QP_STATE_CLOSING:
-		return IB_QPS_ERR;
-	case ERDMA_QP_STATE_TERMINATE:
-		return IB_QPS_ERR;
-	case ERDMA_QP_STATE_ERROR:
-		return IB_QPS_ERR;
-	default:
-		return IB_QPS_ERR;
-	}
+	if (erdma_device_iwarp(qp->dev))
+		return iwarp_to_ib_qps(qp->attrs.iwarp.state);
+	else
+		return rocev2_to_ib_qps(qp->attrs.rocev2.state);
 }
 
 int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index fad3e475d8f1..f9408ccc8bad 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -195,25 +195,26 @@ struct erdma_kqp {
 	u8 sig_all;
 };
 
-enum erdma_qp_state {
-	ERDMA_QP_STATE_IDLE = 0,
-	ERDMA_QP_STATE_RTR = 1,
-	ERDMA_QP_STATE_RTS = 2,
-	ERDMA_QP_STATE_CLOSING = 3,
-	ERDMA_QP_STATE_TERMINATE = 4,
-	ERDMA_QP_STATE_ERROR = 5,
-	ERDMA_QP_STATE_UNDEF = 7,
-	ERDMA_QP_STATE_COUNT = 8
+enum erdma_qps_iwarp {
+	ERDMA_QPS_IWARP_IDLE = 0,
+	ERDMA_QPS_IWARP_RTR = 1,
+	ERDMA_QPS_IWARP_RTS = 2,
+	ERDMA_QPS_IWARP_CLOSING = 3,
+	ERDMA_QPS_IWARP_TERMINATE = 4,
+	ERDMA_QPS_IWARP_ERROR = 5,
+	ERDMA_QPS_IWARP_UNDEF = 6,
+	ERDMA_QPS_IWARP_COUNT = 7,
 };
 
-enum erdma_qp_attr_mask {
-	ERDMA_QP_ATTR_STATE = (1 << 0),
-	ERDMA_QP_ATTR_LLP_HANDLE = (1 << 2),
-	ERDMA_QP_ATTR_ORD = (1 << 3),
-	ERDMA_QP_ATTR_IRD = (1 << 4),
-	ERDMA_QP_ATTR_SQ_SIZE = (1 << 5),
-	ERDMA_QP_ATTR_RQ_SIZE = (1 << 6),
-	ERDMA_QP_ATTR_MPA = (1 << 7)
+enum erdma_qpa_mask_iwarp {
+	ERDMA_QPA_IWARP_STATE = (1 << 0),
+	ERDMA_QPA_IWARP_LLP_HANDLE = (1 << 2),
+	ERDMA_QPA_IWARP_ORD = (1 << 3),
+	ERDMA_QPA_IWARP_IRD = (1 << 4),
+	ERDMA_QPA_IWARP_SQ_SIZE = (1 << 5),
+	ERDMA_QPA_IWARP_RQ_SIZE = (1 << 6),
+	ERDMA_QPA_IWARP_MPA = (1 << 7),
+	ERDMA_QPA_IWARP_CC = (1 << 8),
 };
 
 enum erdma_qps_rocev2 {
@@ -240,6 +241,23 @@ enum erdma_qp_flags {
 	ERDMA_QP_IN_FLUSHING = (1 << 0),
 };
 
+#define ERDMA_QP_ACTIVE 0
+#define ERDMA_QP_PASSIVE 1
+
+struct erdma_mod_qp_params_iwarp {
+	enum erdma_qps_iwarp state;
+	enum erdma_cc_alg cc;
+	u8 qp_type;
+	u8 pd_len;
+	u32 irq_size;
+	u32 orq_size;
+};
+
+struct erdma_qp_attrs_iwarp {
+	enum erdma_qps_iwarp state;
+	u32 cookie;
+};
+
 struct erdma_mod_qp_params_rocev2 {
 	enum erdma_qps_rocev2 state;
 	u32 qkey;
@@ -249,6 +267,11 @@ struct erdma_mod_qp_params_rocev2 {
 	struct erdma_av av;
 };
 
+union erdma_mod_qp_params {
+	struct erdma_mod_qp_params_iwarp iwarp;
+	struct erdma_mod_qp_params_rocev2 rocev2;
+};
+
 struct erdma_qp_attrs_rocev2 {
 	enum erdma_qps_rocev2 state;
 	u32 qkey;
@@ -257,7 +280,6 @@ struct erdma_qp_attrs_rocev2 {
 };
 
 struct erdma_qp_attrs {
-	enum erdma_qp_state state;
 	enum erdma_cc_alg cc; /* Congestion control algorithm */
 	u32 sq_size;
 	u32 rq_size;
@@ -265,12 +287,10 @@ struct erdma_qp_attrs {
 	u32 irq_size;
 	u32 max_send_sge;
 	u32 max_recv_sge;
-	u32 cookie;
-#define ERDMA_QP_ACTIVE 0
-#define ERDMA_QP_PASSIVE 1
-	u8 qp_type;
-	u8 pd_len;
-	struct erdma_qp_attrs_rocev2 rocev2;
+	union {
+		struct erdma_qp_attrs_iwarp iwarp;
+		struct erdma_qp_attrs_rocev2 rocev2;
+	};
 };
 
 struct erdma_qp {
@@ -342,8 +362,9 @@ static inline struct erdma_cq *find_cq_by_cqn(struct erdma_dev *dev, int id)
 
 void erdma_qp_get(struct erdma_qp *qp);
 void erdma_qp_put(struct erdma_qp *qp);
-int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
-			     enum erdma_qp_attr_mask mask);
+int erdma_modify_qp_state_iwarp(struct erdma_qp *qp,
+				struct erdma_mod_qp_params_iwarp *params,
+				int mask);
 int erdma_modify_qp_state_rocev2(struct erdma_qp *qp,
 				 struct erdma_mod_qp_params_rocev2 *params,
 				 int attr_mask);
@@ -426,8 +447,6 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		   struct ib_qp_init_attr *init_attr);
 int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		    struct ib_udata *data);
-int erdma_modify_qp_rocev2(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-			   int mask, struct ib_udata *udata);
 int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext);
-- 
2.43.5


