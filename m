Return-Path: <linux-rdma+bounces-4411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E1956307
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 07:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265E71F2224B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 05:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A514A09C;
	Mon, 19 Aug 2024 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X/xbyOLt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C314A0B9
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044137; cv=none; b=cmrlUPvAKsONAaQmTBPrWcnE7WUK6wtRuKcMFdkK9dvqFV3t6Wng8w8wKPl0NlSWZePEwNcFsAW0boxp3o6DGx3G9sVnU3K2LtwNytSPb05T7vLTNKngRv0YIPb6UT36Ps0Vr2y5dK1+6az+P9WvkmucbpKDFf7Y0KgEC1BLfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044137; c=relaxed/simple;
	bh=v7nZDKAqLK2Ey0TRKv+HyCljEK+XIgACJYBjHj3gx3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IjhQXd9xxlJNMqQiclvZ6DYBqNqjmzXAmfYXCvji/u/oRTLccgsWZ4bfa0e7ce9UGGnWBcAGku2RBHZoVSahg3HjZXn7G69GZ8PK0iJ6F+hzb/hd/in1wJsY2Rkd+KXb8lxDr0Hbfn26bvhuE3JO6rPLxVM0UkxmWfKOMqsktZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X/xbyOLt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-710d0995e21so2831002b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 22:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724044135; x=1724648935; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=An7ht5yhz9XZPhxRnRN9qqRfbMXY428fZ5j0ExIEwQs=;
        b=X/xbyOLtzR2hjtBFaaDL8WeqKhokUtEXARbJWAWuPrrVpZEP0RpBMOBis3wk2nI537
         s4ZkK5kX/6/lzZkcGtRRANMeVVb6L7CcN+87oilb/wxp+5rtlUsdtHAyUmklofQ0aojy
         MlGgUJqNbvDkySiWeZrAoG/tLCw/xKYCFYCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044135; x=1724648935;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An7ht5yhz9XZPhxRnRN9qqRfbMXY428fZ5j0ExIEwQs=;
        b=EBJ8JvRVAXjRWQS4jER83Wo4OEHhj3QxZE4I3uDFAK57w/Y7Yme0SgLM3vdi1NSSuu
         hSHb74Zy9NxQAtrOjZQPR/LW+tR2kGWQvXgE828zfY/qnTItaticXqCuB/hcnwhTzFgq
         0T0WahaWQmcno8AJGj7buY/T9+ZgX+EnKGTD/NuO6bnMjxmUcmnRE3daDOlZAeX5fEEC
         73LZbWgDVJWtC0xgco+q5lRm0ciUhcaPW7UsK/uEe4AuuQldl0J8onxOF15rAQcd3GmX
         bKHPxQnRo9snMwMv8GyX9K8OY8ypfTxC0bT2F8rxQ9DZM47Flm+ZEEX0RIl8ADYoDMlL
         yBsw==
X-Gm-Message-State: AOJu0YwBk/Is3TPKZl7X8JZwVblGu00BD1uaUV5jgHKk5ySMCTjmayQJ
	6z3Oc9/OJZHEQuFFdLuy6qYpTnvpQgTsPEFtIzCUXgmvdkiH0TySRvYrGMF3LQ==
X-Google-Smtp-Source: AGHT+IF/N+KhWQLtI9x+5u7Fm1w4adznR3VTrcoa8DQl54rk1blw+zS0TC8r5XF8RceGmo7xbRfY/A==
X-Received: by 2002:a05:6a00:1acf:b0:712:7414:8837 with SMTP id d2e1a72fcca58-713c4e3e116mr9368568b3a.12.1724044134832;
        Sun, 18 Aug 2024 22:08:54 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm6908021a12.4.2024.08.18.22.08.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:08:54 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next v3 4/5] RDMA/bnxt_re: Handle variable WQE support for user applications
Date: Sun, 18 Aug 2024 21:47:26 -0700
Message-Id: <1724042847-1481-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 106 ++++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  16 ++++-
 include/uapi/rdma/bnxt_re-abi.h          |   6 ++
 3 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 4dd137b..2932db1 100644
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
@@ -1038,17 +1033,20 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
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
 		if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
 			psn_nume = roundup_pow_of_two(psn_nume);
 		bytes += (psn_nume * psn_sz);
 	}
 
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq.qpsva, bytes,
+	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
 			   IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
@@ -1057,12 +1055,12 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
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
@@ -1261,14 +1259,15 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 
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
@@ -1277,22 +1276,28 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
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
@@ -1355,10 +1360,10 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 
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
@@ -1368,7 +1373,6 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
 	qplqp->pd = &pd->qplib_pd;
@@ -1381,8 +1385,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		goto out;
 	}
 	qplqp->type = (u8)qptype;
-	qplqp->wqe_mode = rdev->chip_ctx->modes.wqe_mode;
-
+	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
 	if (init_attr->qp_type == IB_QPT_RC) {
 		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
 		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
@@ -1417,14 +1420,14 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
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
@@ -1525,14 +1528,27 @@ static bool bnxt_re_test_qp_limits(struct bnxt_re_dev *rdev,
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
@@ -1540,7 +1556,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, udata);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
 	if (rc)
 		goto fail;
 
@@ -4215,7 +4231,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
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


