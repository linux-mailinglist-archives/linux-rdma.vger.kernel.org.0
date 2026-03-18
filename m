Return-Path: <linux-rdma+bounces-18300-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NKLLFN4ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18300-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:02:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B12B99A8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 875DA3006B6A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36CB38E13B;
	Wed, 18 Mar 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBXg2jhh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B73ACA71;
	Wed, 18 Mar 2026 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828170; cv=none; b=G8dQd/I8JxA6UP0zWNpTyFWm10857qJP4cgohjKummJuxoLfYjiDaVSy3Q45NSM5GwJWyhjcAVg5Q8AT+O7zyNz7d+3PKI78zy72M2RCY/2d9ibIvFIChjf1TsnQvx2ZfglDbIBiw71DWBPZeK74YRXq/CywFcZn0nsw2My05lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828170; c=relaxed/simple;
	bh=TTtvF/ZGtyq8qjPdXOa1ktPKUlhQfIsBy+rOy9ceiaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9nExkSY3IFCbOLcHub25Rtq2WTbhcZlXodzCdKgYHpW/uIVnw43WOAi/UUk9t93EHlZtlgxSv9Wvwco9KTNz5Ny0Ikfp0AmX7F48ekkwlktMeLIAXrThR/ULf69gPcrS7NGamgaU+aXfUtDjEOPUW6VioiofBwzanWIZ+WHbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBXg2jhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF164C19424;
	Wed, 18 Mar 2026 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828169;
	bh=TTtvF/ZGtyq8qjPdXOa1ktPKUlhQfIsBy+rOy9ceiaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBXg2jhhMBKtadJAWkHSvbu3xeOpRhS9R3m8tmuYU0c6evaBAxamkqcwAXFTou/Ua
	 wi+LzykhG0def7Gpct4WwK4ryAJFtPJrgwt6Ewk/fSSyJVbbijEU68sC37GU3pKVLu
	 RBXXxvuoDcL6XMqQZ2WeOg8NMEPEZR7YBcw2A1fVJpjBbnLdWdCfvgw324ouKtfIX3
	 U9P1TN0AytcwKlBstN8oLaVvmsmupNDVZgi8n8PBwl3e3wEKUXeBFAnI083y95dT3r
	 UFVwCkecdPbDh51P8787dirFQqBUpqa8dzuxEsBLnRESSiY8UYj1e9xVnH4ONKauGE
	 dJzmAt04xRmRw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: =?utf-8?q?=5BPATCH_rdma-next_2/2=5D_RDMA=3A_Clarify_that_CQ_resi?= =?utf-8?q?ze_is_a_user=E2=80=91space_verb?=
Date: Wed, 18 Mar 2026 12:02:37 +0200
Message-ID: <20260318-resize_cq-type-v1-2-b2846ed18846@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318-resize_cq-type-v1-0-b2846ed18846@nvidia.com>
References: <20260318-resize_cq-type-v1-0-b2846ed18846@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18300-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,intel.com,nvidia.com,cornelisnetworks.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 560B12B99A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

The CQ resize operation is used only by uverbs. Make this explicit.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c             | 2 +-
 drivers/infiniband/core/uverbs_cmd.c         | 4 ++--
 drivers/infiniband/hw/bnxt_re/main.c         | 2 +-
 drivers/infiniband/hw/irdma/verbs.c          | 2 +-
 drivers/infiniband/hw/mlx4/main.c            | 2 +-
 drivers/infiniband/hw/mlx5/main.c            | 2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c   | 2 +-
 drivers/infiniband/sw/rdmavt/vt.c            | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        | 2 +-
 include/rdma/ib_verbs.h                      | 3 ++-
 11 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 236061a33bf67..4c174f7f1070c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2832,7 +2832,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
-	SET_DEVICE_OP(dev_ops, resize_cq);
+	SET_DEVICE_OP(dev_ops, resize_user_cq);
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index f31650ef7bc34..25741db2c8f64 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1142,7 +1142,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(cq))
 		return PTR_ERR(cq);
 
-	ret = cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata);
+	ret = cq->device->ops.resize_user_cq(cq, cmd.cqe, &attrs->driver_udata);
 	if (ret)
 		goto out;
 
@@ -3801,7 +3801,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 				     UAPI_DEF_WRITE_UDATA_IO(
 					     struct ib_uverbs_resize_cq,
 					     struct ib_uverbs_resize_cq_resp),
-				     UAPI_DEF_METHOD_NEEDS_FN(resize_cq)),
+				     UAPI_DEF_METHOD_NEEDS_FN(resize_user_cq)),
 		DECLARE_UVERBS_WRITE_EX(
 			IB_USER_VERBS_EX_CMD_CREATE_CQ,
 			ib_uverbs_ex_create_cq,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 13ad63b9b1de7..0578114730b0e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1374,7 +1374,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.reg_user_mr = bnxt_re_reg_user_mr,
 	.reg_user_mr_dmabuf = bnxt_re_reg_user_mr_dmabuf,
 	.req_notify_cq = bnxt_re_req_notify_cq,
-	.resize_cq = bnxt_re_resize_cq,
+	.resize_user_cq = bnxt_re_resize_cq,
 	.create_flow = bnxt_re_create_flow,
 	.destroy_flow = bnxt_re_destroy_flow,
 	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1d0c2d8453a8a..740a770199f7f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5461,7 +5461,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
 	.rereg_user_mr = irdma_rereg_user_mr,
 	.req_notify_cq = irdma_req_notify_cq,
-	.resize_cq = irdma_resize_cq,
+	.resize_user_cq = irdma_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, irdma_ucontext, ibucontext),
 	INIT_RDMA_OBJ_SIZE(ib_ah, irdma_ah, ibah),
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 73e17b4339eb6..900637e4db0ed 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2568,7 +2568,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.reg_user_mr = mlx4_ib_reg_user_mr,
 	.req_notify_cq = mlx4_ib_arm_cq,
 	.rereg_user_mr = mlx4_ib_rereg_user_mr,
-	.resize_cq = mlx4_ib_resize_cq,
+	.resize_user_cq = mlx4_ib_resize_cq,
 	.report_port_event = mlx4_ib_port_event,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ff2c02c85625c..b74bf26976550 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4612,7 +4612,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.reg_user_mr_dmabuf = mlx5_ib_reg_user_mr_dmabuf,
 	.req_notify_cq = mlx5_ib_arm_cq,
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
-	.resize_cq = mlx5_ib_resize_cq,
+	.resize_user_cq = mlx5_ib_resize_cq,
 	.ufile_hw_cleanup = mlx5_ib_ufile_hw_cleanup,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 6a0795332616d..d81806ef12e53 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1096,7 +1096,7 @@ static const struct ib_device_ops mthca_dev_ops = {
 	.query_port = mthca_query_port,
 	.query_qp = mthca_query_qp,
 	.reg_user_mr = mthca_reg_user_mr,
-	.resize_cq = mthca_resize_cq,
+	.resize_user_cq = mthca_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mthca_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mthca_cq, ibcq),
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index b62a9bf160c52..a448748472082 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -166,7 +166,7 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.query_qp = ocrdma_query_qp,
 	.reg_user_mr = ocrdma_reg_user_mr,
 	.req_notify_cq = ocrdma_arm_cq,
-	.resize_cq = ocrdma_resize_cq,
+	.resize_user_cq = ocrdma_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, ocrdma_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, ocrdma_cq, ibcq),
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 033d8932aff16..40aa642083647 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -375,7 +375,7 @@ static const struct ib_device_ops rvt_dev_ops = {
 	.query_srq = rvt_query_srq,
 	.reg_user_mr = rvt_reg_user_mr,
 	.req_notify_cq = rvt_req_notify_cq,
-	.resize_cq = rvt_resize_cq,
+	.resize_user_cq = rvt_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rvt_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rvt_cq, ibcq),
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fe41362c51444..2be4fd68276dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1519,7 +1519,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
 	.rereg_user_mr = rxe_rereg_user_mr,
-	.resize_cq = rxe_resize_cq,
+	.resize_user_cq = rxe_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 37260d37144c5..e53c6ed66f34a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2634,7 +2634,8 @@ struct ib_device_ops {
 			      struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
-	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
+	int (*resize_user_cq)(struct ib_cq *cq, int cqe,
+			      struct ib_udata *udata);
 	/*
 	 * pre_destroy_cq - Prevent a cq from generating any new work
 	 * completions, but not free any kernel resources

-- 
2.53.0


