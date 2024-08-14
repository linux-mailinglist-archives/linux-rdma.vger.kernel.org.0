Return-Path: <linux-rdma+bounces-4363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4C95160D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5731F230E7
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744613E020;
	Wed, 14 Aug 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E8UKK87K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBB13D529
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622588; cv=none; b=U1z1cFXKOlvytgv0eMWybyplyeVG5k/tKEq5TK74Oz1zTf9YM+lJAyVwLarWIbho4F5xhjt/qcBx6dT7jCy/mAVrxZ4OJub5Q2gawQCvqZQtfrwqwVY5hcryaKhQV2XhhOFSLijsUH+gsvRGuGcN1lclaz+eOf3Vjgrvf9kmtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622588; c=relaxed/simple;
	bh=wJau1CGI8Z7xYhLh9jqTxMKYoyFdiQRcxr3DiUqu40U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BGfDAOKwBQ+QqlRMnHiBXV5pOt0Ht4Dvn/juj1vMu1HjtXMegHjvTgpm46nskeDlY0GI8qLC/fEpBqprmZ7FmMcTHx9hFdjUCfF7Gy94UOEEdkdjhZ9OSrXwPUcJ6f6URb7kXLJzmjzfLbtViYQhYc6/ewfh9xWGOgLVk1l8cKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E8UKK87K; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so5656848b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723622586; x=1724227386; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DRShLuYYtRg4SRqkseurOZAdIC22Jk03HrL99oA88gM=;
        b=E8UKK87K3G4XsMsLDuyvzGRd0UfPhAm8ZHDgAcS7/HJlSdguhPo2+DxzNfR80caxaV
         g/asr9QyJg7o1Gd+KEvfyZvzz12ffwWUC6pqywiAr/2Rzm0WQKWprge/UQ0PKPAYVM1Y
         mnVzUxy9/4xipKkg33wzAzOpC9QX4erATzKFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622586; x=1724227386;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRShLuYYtRg4SRqkseurOZAdIC22Jk03HrL99oA88gM=;
        b=qp+Z7SCRggOaSXJDMxR4ZuogFedRb15EBcQxD9bMx5rM5TR+c96TrLyPQ6TZsopGkm
         CgyhlRdrAJFB6fupr1omJXzxNPeUtitzZzXfzcoE0vRxo5TdeGIQWh4VV1XAdTFSZTos
         ZdKF50/QggJ6U1Pa/dXkyeacRuiSiQDzWbMpOq5LzZJLMpQ0ibfayFyUlqHGIxLw+o69
         YphsQdefkFxILkvU2U6LQHGRBOIwhdxfYJY28xMey1tdfS4FnlkUfK+d4H61ImlHWjRo
         CZEWVWycUcc256k8lo25eRqKvXewWw98V1MpgW4P6YWViplOn6pDSSNlGiKx5I8ESK3P
         Khaw==
X-Gm-Message-State: AOJu0Ywz3ry6YjcxbjUmOv3v690NdGLcef5rt3pr7ahv/rMZ+PzphmXr
	qn3R0krVJYqDTc9Sky4Y9z78eHLRQ6FGtTWFePXlQIPIOWM/1Au8e514T0V0ww==
X-Google-Smtp-Source: AGHT+IHMBbZig63EwR+DXMSvPCqym8csfUBwvkwyNOZMgQiJ2X+8kT0rt0Mkuf1dLYoaSwInOCtRCw==
X-Received: by 2002:a05:6a21:151a:b0:1c4:944c:41e2 with SMTP id adf61e73a8af0-1c8eb0470bemr2788623637.51.1723622586219;
        Wed, 14 Aug 2024 01:03:06 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([115.110.236.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac40e0sm6782479b3a.216.2024.08.14.01.03.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 01:03:05 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next v2 3/4] RDMA/bnxt_re: Handle variable WQE support for user applications
Date: Wed, 14 Aug 2024 00:42:01 -0700
Message-Id: <1723621322-6920-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
References: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

User library calculates the number of slots required for user
applications and it can pass that information to the driver.
Driver can use this value and update the HW directly. This
mechanism is currently used only for the newly introduced variable
size WQEs.

Extend the bnxt_re_qp_req structure to pass the Send Queue slot count.
Reorganize the code to get the sq_slots before initializing the Send Queue
attributes.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 108 ++++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  16 ++++-
 include/uapi/rdma/bnxt_re-abi.h          |   6 ++
 3 files changed, 84 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5073ab1..2932db1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1017,20 +1017,15 @@ static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
 }
 
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
-				struct bnxt_re_qp *qp, struct ib_udata *udata)
+				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
+				struct bnxt_re_qp_req *ureq)
 {
 	struct bnxt_qplib_qp *qplib_qp;
-	struct bnxt_re_ucontext *cntx;
-	struct bnxt_re_qp_req ureq;
 	int bytes = 0, psn_sz;
 	struct ib_umem *umem;
 	int psn_nume;
 
 	qplib_qp = &qp->qplib_qp;
-	cntx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,
-					 ib_uctx);
-	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-		return -EFAULT;
 
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
@@ -1038,15 +1033,20 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 						   sizeof(struct sq_psn_search_ext) :
 						   sizeof(struct sq_psn_search);
-		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
-			    qplib_qp->sq.max_wqe :
-			    ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
-			      sizeof(struct bnxt_qplib_sge));
+		if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
+			psn_nume = ureq->sq_slots;
+		} else {
+			psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+			qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
+				 sizeof(struct bnxt_qplib_sge));
+		}
+		if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
+			psn_nume = roundup_pow_of_two(psn_nume);
 		bytes += (psn_nume * psn_sz);
 	}
 
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq.qpsva, bytes,
+	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
 			   IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
@@ -1055,12 +1055,12 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qplib_qp->sq.sg_info.umem = umem;
 	qplib_qp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplib_qp->sq.sg_info.pgshft = PAGE_SHIFT;
-	qplib_qp->qp_handle = ureq.qp_handle;
+	qplib_qp->qp_handle = ureq->qp_handle;
 
 	if (!qp->qplib_qp.srq) {
 		bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
 		bytes = PAGE_ALIGN(bytes);
-		umem = ib_umem_get(&rdev->ibdev, ureq.qprva, bytes,
+		umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
 				   IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(umem))
 			goto rqfail;
@@ -1259,14 +1259,15 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
-				struct bnxt_re_ucontext *uctx)
+				struct bnxt_re_ucontext *uctx,
+				struct bnxt_re_qp_req *ureq)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_q *sq;
+	int diff = 0;
 	int entries;
-	int diff;
 	int rc;
 
 	rdev = qp->rdev;
@@ -1275,22 +1276,28 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	dev_attr = &rdev->dev_attr;
 
 	sq->max_sge = init_attr->cap.max_send_sge;
-	if (sq->max_sge > dev_attr->max_qp_sges) {
-		sq->max_sge = dev_attr->max_qp_sges;
-		init_attr->cap.max_send_sge = sq->max_sge;
-	}
+	entries = init_attr->cap.max_send_wr;
+	if (uctx && qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) {
+		sq->max_wqe = ureq->sq_slots;
+		sq->max_sw_wqe = ureq->sq_slots;
+		sq->wqe_size = sizeof(struct sq_sge);
+	} else {
+		if (sq->max_sge > dev_attr->max_qp_sges) {
+			sq->max_sge = dev_attr->max_qp_sges;
+			init_attr->cap.max_send_sge = sq->max_sge;
+		}
 
-	rc = bnxt_re_setup_swqe_size(qp, init_attr);
-	if (rc)
-		return rc;
+		rc = bnxt_re_setup_swqe_size(qp, init_attr);
+		if (rc)
+			return rc;
 
-	entries = init_attr->cap.max_send_wr;
-	/* Allocate 128 + 1 more than what's provided */
-	diff = (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) ?
-		0 : BNXT_QPLIB_RESERVED_QP_WRS;
-	entries = bnxt_re_init_depth(entries + diff + 1, uctx);
-	sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
-	sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qplqp->wqe_mode, true);
+		/* Allocate 128 + 1 more than what's provided */
+		diff = (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) ?
+			0 : BNXT_QPLIB_RESERVED_QP_WRS;
+		entries = bnxt_re_init_depth(entries + diff + 1, uctx);
+		sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
+		sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qplqp->wqe_mode, true);
+	}
 	sq->q_full_delta = diff + 1;
 	/*
 	 * Reserving one slot for Phantom WQE. Application can
@@ -1353,10 +1360,10 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
-				struct ib_udata *udata)
+				struct bnxt_re_ucontext *uctx,
+				struct bnxt_re_qp_req *ureq)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
-	struct bnxt_re_ucontext *uctx;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
@@ -1366,7 +1373,6 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
 	qplqp->pd = &pd->qplib_pd;
@@ -1379,8 +1385,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		goto out;
 	}
 	qplqp->type = (u8)qptype;
-	qplqp->wqe_mode = rdev->chip_ctx->modes.wqe_mode;
-
+	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
 	if (init_attr->qp_type == IB_QPT_RC) {
 		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
 		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
@@ -1415,14 +1420,14 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
 	if (rc)
 		goto out;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
-	if (udata) /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, udata);
+	if (uctx) /* This will update DPI and qp_handle */
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
 out:
 	return rc;
 }
@@ -1523,14 +1528,27 @@ static bool bnxt_re_test_qp_limits(struct bnxt_re_dev *rdev,
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
-	struct ib_pd *ib_pd = ib_qp->pd;
-	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
-	struct bnxt_re_dev *rdev = pd->rdev;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_re_ucontext *uctx;
+	struct bnxt_re_qp_req ureq;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_pd *pd;
+	struct bnxt_re_qp *qp;
+	struct ib_pd *ib_pd;
 	u32 active_qps;
 	int rc;
 
+	ib_pd = ib_qp->pd;
+	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
+	rdev = pd->rdev;
+	dev_attr = &rdev->dev_attr;
+	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	if (udata)
+		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
+			return -EFAULT;
+
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
 		rc = -EINVAL;
@@ -1538,7 +1556,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, udata);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
 	if (rc)
 		goto fail;
 
@@ -4213,7 +4231,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
 			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_POW2_DISABLED;
-			uctx->cmask |= BNXT_RE_UCNTX_CMASK_POW2_DISABLED;
+			uctx->cmask |= BNXT_RE_UCNTX_CAP_POW2_DISABLED;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index e98cb17..7c8350f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -171,12 +171,26 @@ static inline u16 bnxt_re_get_rwqe_size(int nsge)
 	return sizeof(struct rq_wqe_hdr) + (nsge * sizeof(struct sq_sge));
 }
 
+enum {
+	BNXT_RE_UCNTX_CAP_POW2_DISABLED = 0x1ULL,
+	BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED = 0x2ULL,
+};
+
 static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *uctx)
 {
-	return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CMASK_POW2_DISABLED) ?
+	return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED) ?
 		ent : roundup_pow_of_two(ent) : ent;
 }
 
+static inline bool bnxt_re_is_var_size_supported(struct bnxt_re_dev *rdev,
+						 struct bnxt_re_ucontext *uctx)
+{
+	if (uctx)
+		return uctx->cmask & BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
+	else
+		return rdev->chip_ctx->modes.wqe_mode;
+}
+
 int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_device_attr *ib_attr,
 			 struct ib_udata *udata);
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index e61104f..7114061 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -118,10 +118,16 @@ struct bnxt_re_resize_cq_req {
 	__aligned_u64 cq_va;
 };
 
+enum bnxt_re_qp_mask {
+	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+};
+
 struct bnxt_re_qp_req {
 	__aligned_u64 qpsva;
 	__aligned_u64 qprva;
 	__aligned_u64 qp_handle;
+	__aligned_u64 comp_mask;
+	__u32 sq_slots;
 };
 
 struct bnxt_re_qp_resp {
-- 
2.5.5


