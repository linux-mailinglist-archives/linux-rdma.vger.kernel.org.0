Return-Path: <linux-rdma+bounces-301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB6808651
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184281F2265A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2936B00;
	Thu,  7 Dec 2023 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gt1LBaYg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C142D1
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 03:04:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28654179ec0so779557a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Dec 2023 03:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701947065; x=1702551865; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXn/wb3f+v0fowQZgmb7JJ5OinWbVHxEio4VwnkchCo=;
        b=gt1LBaYgOnK+H/VNEXYUFlXrrmBhF6dWVB6w+oZKRsasVyxu3AgTO12ZKxnNvVH3Fw
         c/USzlRpo7ipn6X+pa3oXkCg5g3T+MAH5FKAmNlq8OEvgJUwnS2Iz/9OB8Ry9SMIhViN
         XJi0ykyNN8eFTkyFRsXtwSo3BIQ1olPar895Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947065; x=1702551865;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXn/wb3f+v0fowQZgmb7JJ5OinWbVHxEio4VwnkchCo=;
        b=hpQgCwgkLconfIusFAMm1SR9Sat+K/nJlmffKe/sU4OEG3imAyqYNiTrCUVjNdgnjc
         HgM1FXjCM6FDyrQX8Fr9YzS0lZ/8PVoLeJw9FoemVL/ivitwi6pLRkEo2dB8we6K5q7q
         Rh4ON56RyMuDRwD8dOyKsEGxO958Y/eXDYowd72mTqls0L1FMFSGoA1H+TBCDJm/FVU2
         XwWWZsat9Xuv1Vz+b7NSxH8PJCGmuuEajUpJ62Y68unH+/tiUBdZcXOD5RLzEO0S43Yx
         UkNbQfqA3omqylRh4ZDkGdBe7raDr4svuW6jhhFjlyYPSnzOmMbC1OFwd77ekhj1eeEq
         o9+A==
X-Gm-Message-State: AOJu0YwBMmLYNZn2o//qChR7aAsWBcW9l8Efm6cDWK8oBlNmA2xZ+paC
	QxCPDh6xcx0o0R8Blv00gfiO8w==
X-Google-Smtp-Source: AGHT+IEJvnHeCXOnhKmJ6UFCKxbYDDpHKwcu4jWvdgtzQeNi2iM1dFpH9sm3dog9C1F+RES2fkYezQ==
X-Received: by 2002:a17:90a:e:b0:286:a6bf:2a16 with SMTP id 14-20020a17090a000e00b00286a6bf2a16mr2201423pja.51.1701947064772;
        Thu, 07 Dec 2023 03:04:24 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id pm2-20020a17090b3c4200b00285db538b17sm1034254pjb.41.2023.12.07.03.04.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:04:24 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/6] RDMA/bnxt_re: Support new 5760X P7 devices
Date: Thu,  7 Dec 2023 02:47:35 -0800
Message-Id: <1701946060-13931-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
References: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004055e6060be96e0c"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--0000000000004055e6060be96e0c

Add basic support for 5760X P7 devices. Add new chip
revisions. The first version support is similar to
the existing P5 adapters. Extend the current support
for P5 adapters to P7 also.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  4 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 10 +++++-----
 drivers/infiniband/hw/bnxt_re/main.c        | 14 +++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c    |  4 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h   | 20 +++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  6 +++---
 8 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 9357240..128651c 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -371,7 +371,7 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 	}
 
 done:
-	return bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 		BNXT_RE_NUM_EXT_COUNTERS : BNXT_RE_NUM_STD_COUNTERS;
 }
 
@@ -381,7 +381,7 @@ struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	int num_counters = 0;
 
-	if (bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+	if (bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		num_counters = BNXT_RE_NUM_EXT_COUNTERS;
 	else
 		num_counters = BNXT_RE_NUM_STD_COUNTERS;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b2467de..e7ef099 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1023,7 +1023,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 						   sizeof(struct sq_psn_search_ext) :
 						   sizeof(struct sq_psn_search);
 		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
@@ -1234,7 +1234,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
 		if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
 			qplqp->rq.max_sge = dev_attr->max_qp_sges;
@@ -1301,7 +1301,7 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
 		qplqp->sq.max_wqe = min_t(u32, entries,
 					  dev_attr->max_qp_wqes + 1);
@@ -1328,7 +1328,7 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 		goto out;
 	}
 
-	if (bnxt_qplib_is_chip_gen_p5(chip_ctx) &&
+	if (bnxt_qplib_is_chip_gen_p5_p7(chip_ctx) &&
 	    init_attr->qp_type == IB_QPT_GSI)
 		qptype = CMDQ_CREATE_QP_TYPE_GSI;
 out:
@@ -1527,7 +1527,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		goto fail;
 
 	if (qp_init_attr->qp_type == IB_QPT_GSI &&
-	    !(bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))) {
+	    !(bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))) {
 		rc = bnxt_re_create_gsi_qp(qp, pd, qp_init_attr);
 		if (rc == -ENODEV)
 			goto qp_destroy;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index f79369c..09c0b2e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -128,7 +128,7 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 	struct bnxt_qplib_chip_ctx *cctx;
 
 	cctx = rdev->chip_ctx;
-	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 			       mode : BNXT_QPLIB_WQE_MODE_STATIC;
 	if (bnxt_re_hwrm_qcaps(rdev))
 		dev_err(rdev_to_dev(rdev),
@@ -215,7 +215,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	ctx->srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
 				attr->max_srq);
 	ctx->cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT, attr->max_cq);
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
 			rdev->qplib_ctx.tqm_ctx.qcount[i] =
 			rdev->dev_attr.tqm_alloc_reqs[i];
@@ -264,7 +264,7 @@ static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
 	memset(&rdev->qplib_ctx.vf_res, 0, sizeof(struct bnxt_qplib_vf_res));
 	bnxt_re_limit_pf_res(rdev);
 
-	num_vfs =  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	num_vfs =  bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 			BNXT_RE_GEN_P5_MAX_VF : rdev->num_vfs;
 	if (num_vfs)
 		bnxt_re_limit_vf_res(&rdev->qplib_ctx, num_vfs);
@@ -276,7 +276,7 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return;
 	rdev->num_vfs = pci_sriov_get_totalvfs(rdev->en_dev->pdev);
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		bnxt_re_set_resource_limits(rdev);
 		bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
 					      &rdev->qplib_ctx);
@@ -1216,7 +1216,7 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 #define BNXT_RE_GEN_P5_VF_NQ_DB		0x4000
 static u32 bnxt_re_get_nqdb_offset(struct bnxt_re_dev *rdev, u16 indx)
 {
-	return bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 		(rdev->is_virtfn ? BNXT_RE_GEN_P5_VF_NQ_DB :
 				   BNXT_RE_GEN_P5_PF_NQ_DB) :
 				   rdev->en_dev->msix_entries[indx].db_offset;
@@ -1681,7 +1681,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	bnxt_re_set_resource_limits(rdev);
 
 	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
-				  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx));
+				  bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx));
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate QPLIB context: %#x\n", rc);
@@ -1804,7 +1804,7 @@ static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
 		return;
 
 	/* Currently enabling only for GenP5 adapters */
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		return;
 
 	if (enable) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index b821c37..1b7e950 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -991,7 +991,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* SQ */
 	if (qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5(res->cctx) ?
+		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
 			 sizeof(struct sq_psn_search_ext) :
 			 sizeof(struct sq_psn_search);
 	}
@@ -1605,7 +1605,7 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	flg_npsn = ((swq->next_psn << SQ_PSN_SEARCH_NEXT_PSN_SFT) &
 		     SQ_PSN_SEARCH_NEXT_PSN_MASK);
 
-	if (bnxt_qplib_is_chip_gen_p5(qp->cctx)) {
+	if (bnxt_qplib_is_chip_gen_p5_p7(qp->cctx)) {
 		psns_ext->opcode_start_psn = cpu_to_le32(op_spsn);
 		psns_ext->flags_next_psn = cpu_to_le32(flg_npsn);
 		psns_ext->start_slot_idx = cpu_to_le16(swq->slot_idx);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 15e6d2b..403b679 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -852,7 +852,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	 */
 	if (is_virtfn)
 		goto skip_ctx_setup;
-	if (bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+	if (bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
 		goto config_vf_res;
 
 	lvl = ctx->qpc_tbl.level;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index ae2bde3..dfc943f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -805,7 +805,7 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res *res,
 	dpit = &res->dpi_tbl;
 	reg = &dpit->wcreg;
 
-	if (!bnxt_qplib_is_chip_gen_p5(res->cctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(res->cctx)) {
 		/* Offest should come from L2 driver */
 		dbr_offset = dev_attr->l2_db_size;
 		dpit->ucreg.offset = dbr_offset;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 3e3383b..397846b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -44,6 +44,9 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 #define CHIP_NUM_57508		0x1750
 #define CHIP_NUM_57504		0x1751
 #define CHIP_NUM_57502		0x1752
+#define CHIP_NUM_58818          0xd818
+#define CHIP_NUM_57608          0x1760
+
 
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
@@ -296,6 +299,12 @@ struct bnxt_qplib_res {
 	struct bnxt_qplib_db_pacing_data *pacing_data;
 };
 
+static inline bool bnxt_qplib_is_chip_gen_p7(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return (cctx->chip_num == CHIP_NUM_58818 ||
+		cctx->chip_num == CHIP_NUM_57608);
+}
+
 static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
 {
 	return (cctx->chip_num == CHIP_NUM_57508 ||
@@ -303,15 +312,20 @@ static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
 		cctx->chip_num == CHIP_NUM_57502);
 }
 
+static inline bool bnxt_qplib_is_chip_gen_p5_p7(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return bnxt_qplib_is_chip_gen_p5(cctx) || bnxt_qplib_is_chip_gen_p7(cctx);
+}
+
 static inline u8 bnxt_qplib_get_hwq_type(struct bnxt_qplib_res *res)
 {
-	return bnxt_qplib_is_chip_gen_p5(res->cctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
 					HWQ_TYPE_QUEUE : HWQ_TYPE_L2_CMPL;
 }
 
 static inline u8 bnxt_qplib_get_ring_type(struct bnxt_qplib_chip_ctx *cctx)
 {
-	return bnxt_qplib_is_chip_gen_p5(cctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(cctx) ?
 	       RING_ALLOC_REQ_RING_TYPE_NQ :
 	       RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL;
 }
@@ -488,7 +502,7 @@ static inline void bnxt_qplib_ring_nq_db(struct bnxt_qplib_db_info *info,
 	u32 type;
 
 	type = arm ? DBC_DBC_TYPE_NQ_ARM : DBC_DBC_TYPE_NQ;
-	if (bnxt_qplib_is_chip_gen_p5(cctx))
+	if (bnxt_qplib_is_chip_gen_p5_p7(cctx))
 		bnxt_qplib_ring_db(info, type);
 	else
 		bnxt_qplib_ring_db32(info, arm);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index a27b685..c580bf7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -59,7 +59,7 @@ static bool bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
 {
 	u16 pcie_ctl2 = 0;
 
-	if (!bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
 		return false;
 
 	pcie_capability_read_word(rcfw->pdev, PCI_EXP_DEVCTL2, &pcie_ctl2);
@@ -133,7 +133,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	 * reporting the max number
 	 */
 	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
-	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx) ?
+	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx) ?
 			    6 : sb->max_sge;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
 	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
@@ -934,7 +934,7 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 	req->inactivity_th = cpu_to_le16(cc_param->inact_th);
 
 	/* For chip gen P5 onwards fill extended cmd and header */
-	if (bnxt_qplib_is_chip_gen_p5(res->cctx)) {
+	if (bnxt_qplib_is_chip_gen_p5_p7(res->cctx)) {
 		struct roce_tlv *hdr;
 		u32 payload;
 		u32 chunks;
-- 
2.5.5


--0000000000004055e6060be96e0c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPDdwQzmNTNO
1oXeXgXsMTu/FJKVX0oUDyfYQtHJQ2SyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIwNzExMDQyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCiYdpdZ6od51M8Zo02kyBryp2j/owG
TXBnWf2JoUhPqrYlHVnXeh6RXXsHv8O0Ff4jlWg5o/uOd0YkBhG2aTuKdxe4KcAHwLShM29gvf7V
MaJKeb/k1/3Ew1kl5qRqn8M8+dTs/nJrkhaNJ3LaVqN5Gao/gv+NU1Pysm7jId31ivfDxLFCXGPt
vlltZC1HTYUuVVpx2uncSQjRWyLrXIii7v/3NJHJPpcsHO/buRtXeKvfq6hlVG5OfHxtkFZsNuj4
eMcvTXTf/uxw09Ntp+yefJ2sov8ysmQ7m189msLb4gjp9MT5CzMTwxdg4wLs1b7qKl8m+9QU/hws
xCOFgMmS
--0000000000004055e6060be96e0c--

