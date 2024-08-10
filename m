Return-Path: <linux-rdma+bounces-4298-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53F94DE4B
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 21:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00857282CAB
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EB13C9D5;
	Sat, 10 Aug 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TFeaPMYN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005F4644E
	for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318812; cv=none; b=PJLNMVjdT90BpP4QNjs1eX8G2pCcMSE3sA48yCYuAxwTk3588lZ+/wMq02RYan5ekmgJp2QsN4ta2tyM60Kq4hc2yHTwcqYZFjlwkd/qIpTQxZNPEAWlAgTl+kjx5YdUNGa8msm/ryVWnp85Nk0ApfpEnOL/8qc697swd5fP1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318812; c=relaxed/simple;
	bh=R4fkHB8Tvr5/l8b4BhtewZUZo4hZLpZ1TRd53xxg15Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Bc5y/0lxtecbjdDu374K6VP6mm3PsBAC7eMve+ePYGr9CxOYD1fIyb8N5kL5fmAUfJvlI42D8M+WF2O+PoANbeqDnXRGCI1zhy9yK6xMvNLLY6iryXwdoPKAnofDXMozztbP6BiGwkDAgzUQ9ebxjs4qUoQesLdhkgwxImV/Om4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TFeaPMYN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260f863109cso1846821fac.1
        for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723318809; x=1723923609; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=asSOP3AWK79b8AbU9ZiBfPa675PwEVNGQIpGMKJmngI=;
        b=TFeaPMYN/mA+/FhiVGH7EhyGcnwB8C7gdS+SOcuHiOvsYDuYybVjSg9RtoZbaFbBti
         VrgoyADNqEYgufjUoSNHfMRJByp1+0jk2ttj4ZSxzYDt0PHcXmdBQ5S1K3DP+xHTtteO
         7dAXlTRNuo7+KaOo+hNyPbZNkP4i0vruGHCyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723318809; x=1723923609;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asSOP3AWK79b8AbU9ZiBfPa675PwEVNGQIpGMKJmngI=;
        b=msrtgpLSx4Wluj7oi6SggqRUgoWjxw4zLONzHyJ2kRtk6AZiaPibl13IM4rJrDRTyF
         6/RA4LCiisR0kHutzGz9jMKnSpkurbQnjPTZPjmr787sMOfkpOL6VUiO4Sxy7aFhNx0f
         EMfKUFFiJL58bjPjMj9vK5z6uDECsKLgBtFvpPLzWAqsThwXx7JRaGDZRKSmYLBh8NY7
         6VQpdWJ4O2+Y5XMdXTx2mnPh014wqQh3Mj7kLk/44sUdgsPjJOscJFRobhdDWqEfqvmL
         paOvZVRzU8SE9QLitRc4levwsI0mlfOHlX236KzAgG8N91PXEbjSTGvUmaMs7vs1/Tf0
         BhEw==
X-Gm-Message-State: AOJu0YygtS8I64c7aAq7w1TVS2iZ8EerEUIBTkEHrzOV4AaDIYB+0s7r
	Hi5qUnkHQq9Teu1sbx5k07R/d51iFJgsvc6spo8D65jd1x5189cjidY5FCU1SBr7q2MZtH4mvIk
	=
X-Google-Smtp-Source: AGHT+IG2OIpeMa5M8W/0eh09zexAhDgp7uV0kEyaX+LQ6wV27LBXsvO4U9EI8ppjwldw9yuhgtJ/kQ==
X-Received: by 2002:a05:6870:7012:b0:268:b4b6:91ab with SMTP id 586e51a60fabf-26c62c69c74mr5878411fac.18.1723318807820;
        Sat, 10 Aug 2024 12:40:07 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a437b7sm1541513b3a.128.2024.08.10.12.40.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 12:40:07 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
Date: Sat, 10 Aug 2024 12:19:10 -0700
Message-Id: <1723317553-13002-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
References: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Variable size WQE  means that each send Work Queue Entry to
HW can use different WQE sizes as opposed to the static WQE
size on the current devices. Set variable WQE mode for Gen P7
devices. Depth of the Queue will be a multiple of slot which
is 16 bytes. The number of slots should be a multiple of 256
as per the HW requirement.
Initialize the Software shadow queue to hold requests equal to
the number of slots. Also, do not expose the variable size
WQE capability until the last patch in the series.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  8 +++++---
 drivers/infiniband/hw/bnxt_re/main.c     | 21 +++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 18 +++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 14 +++++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  7 +++++--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  6 ++++++
 6 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7c75735..5073ab1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1156,6 +1156,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	/* Shadow QP SQ depth should be same as QP1 RQ depth */
 	qp->qplib_qp.sq.wqe_size = bnxt_re_get_wqe_size(0, 6);
 	qp->qplib_qp.sq.max_wqe = qp1_qp->rq.max_wqe;
+	qp->qplib_qp.sq.max_sw_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.sq.max_sge = 2;
 	/* Q full delta can be 1 since it is internal QP */
 	qp->qplib_qp.sq.q_full_delta = 1;
@@ -1167,6 +1168,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 
 	qp->qplib_qp.rq.wqe_size = bnxt_re_get_rwqe_size(6);
 	qp->qplib_qp.rq.max_wqe = qp1_qp->rq.max_wqe;
+	qp->qplib_qp.rq.max_sw_wqe = qp1_qp->rq.max_wqe;
 	qp->qplib_qp.rq.max_sge = qp1_qp->rq.max_sge;
 	/* Q full delta can be 1 since it is internal QP */
 	qp->qplib_qp.rq.q_full_delta = 1;
@@ -1228,6 +1230,7 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		 */
 		entries = bnxt_re_init_depth(init_attr->cap.max_recv_wr + 1, uctx);
 		rq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
+		rq->max_sw_wqe = rq->max_wqe;
 		rq->q_full_delta = 0;
 		rq->sg_info.pgsize = PAGE_SIZE;
 		rq->sg_info.pgshft = PAGE_SHIFT;
@@ -1287,6 +1290,7 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 		0 : BNXT_QPLIB_RESERVED_QP_WRS;
 	entries = bnxt_re_init_depth(entries + diff + 1, uctx);
 	sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
+	sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qplqp->wqe_mode, true);
 	sq->q_full_delta = diff + 1;
 	/*
 	 * Reserving one slot for Phantom WQE. Application can
@@ -2155,6 +2159,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 			entries = bnxt_re_init_depth(qp_attr->cap.max_recv_wr, uctx);
 			qp->qplib_qp.rq.max_wqe =
 				min_t(u32, entries, dev_attr->max_qp_wqes + 1);
+			qp->qplib_qp.rq.max_sw_wqe = qp->qplib_qp.rq.max_wqe;
 			qp->qplib_qp.rq.q_full_delta = qp->qplib_qp.rq.max_wqe -
 						       qp_attr->cap.max_recv_wr;
 			qp->qplib_qp.rq.max_sge = qp_attr->cap.max_recv_sge;
@@ -4187,9 +4192,6 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.cqe_sz = sizeof(struct cq_base);
 	resp.max_cqd = dev_attr->max_cq_wqes;
 
-	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
-	resp.mode = rdev->chip_ctx->modes.wqe_mode;
-
 	if (rdev->chip_ctx->modes.db_push)
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED;
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9714b9a..31ba89c 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -129,13 +129,13 @@ static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 	}
 }
 
-static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
+static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *cctx;
 
 	cctx = rdev->chip_ctx;
-	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
-			       mode : BNXT_QPLIB_WQE_MODE_STATIC;
+	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx) ?
+			       BNXT_QPLIB_WQE_MODE_VARIABLE : BNXT_QPLIB_WQE_MODE_STATIC;
 	if (bnxt_re_hwrm_qcaps(rdev))
 		dev_err(rdev_to_dev(rdev),
 			"Failed to query hwrm qcaps\n");
@@ -158,7 +158,7 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 	kfree(chip_ctx);
 }
 
-static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
+static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
@@ -180,7 +180,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	rdev->qplib_res.dattr = &rdev->dev_attr;
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 
-	bnxt_re_set_drv_mode(rdev, wqe_mode);
+	bnxt_re_set_drv_mode(rdev);
 
 	bnxt_re_set_db_offset(rdev);
 	rc = bnxt_qplib_map_db_bar(&rdev->qplib_res);
@@ -1620,7 +1620,7 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
-static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
+static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_re_ring_attr rattr = {};
 	struct bnxt_qplib_creq_ctx *creq;
@@ -1638,7 +1638,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
-	rc = bnxt_re_setup_chip_ctx(rdev, wqe_mode);
+	rc = bnxt_re_setup_chip_ctx(rdev);
 	if (rc) {
 		bnxt_unregister_dev(rdev->en_dev);
 		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
@@ -1790,7 +1790,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	return rc;
 }
 
-static int bnxt_re_add_device(struct auxiliary_device *adev, u8 wqe_mode)
+static int bnxt_re_add_device(struct auxiliary_device *adev)
 {
 	struct bnxt_aux_priv *aux_priv =
 		container_of(adev, struct bnxt_aux_priv, aux_dev);
@@ -1807,7 +1807,7 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 wqe_mode)
 		goto exit;
 	}
 
-	rc = bnxt_re_dev_init(rdev, wqe_mode);
+	rc = bnxt_re_dev_init(rdev);
 	if (rc)
 		goto re_dev_dealloc;
 
@@ -1937,7 +1937,8 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 	int rc;
 
 	mutex_lock(&bnxt_re_mutex);
-	rc = bnxt_re_add_device(adev, BNXT_QPLIB_WQE_MODE_STATIC);
+
+	rc = bnxt_re_add_device(adev);
 	if (rc) {
 		mutex_unlock(&bnxt_re_mutex);
 		return rc;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 49e4a4a..0af09e7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -809,13 +809,13 @@ static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 {
 	int indx;
 
-	que->swq = kcalloc(que->max_wqe, sizeof(*que->swq), GFP_KERNEL);
+	que->swq = kcalloc(que->max_sw_wqe, sizeof(*que->swq), GFP_KERNEL);
 	if (!que->swq)
 		return -ENOMEM;
 
 	que->swq_start = 0;
-	que->swq_last = que->max_wqe - 1;
-	for (indx = 0; indx < que->max_wqe; indx++)
+	que->swq_last = que->max_sw_wqe - 1;
+	for (indx = 0; indx < que->max_sw_wqe; indx++)
 		que->swq[indx].next_idx = indx + 1;
 	que->swq[que->swq_last].next_idx = 0; /* Make it circular */
 	que->swq_last = 0;
@@ -851,7 +851,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
 	hwq_attr.stride = sizeof(struct sq_sge);
-	hwq_attr.depth = bnxt_qplib_get_depth(sq);
+	hwq_attr.depth = bnxt_qplib_get_depth(sq, qp->wqe_mode, false);
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -879,7 +879,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
 		hwq_attr.stride = sizeof(struct sq_sge);
-		hwq_attr.depth = bnxt_qplib_get_depth(rq);
+		hwq_attr.depth = bnxt_qplib_get_depth(rq, qp->wqe_mode, false);
 		hwq_attr.type = HWQ_TYPE_QUEUE;
 		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
 		if (rc)
@@ -1011,7 +1011,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
 	hwq_attr.stride = sizeof(struct sq_sge);
-	hwq_attr.depth = bnxt_qplib_get_depth(sq);
+	hwq_attr.depth = bnxt_qplib_get_depth(sq, qp->wqe_mode, true);
 	hwq_attr.aux_stride = psn_sz;
 	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
 				    : 0;
@@ -1052,7 +1052,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
 		hwq_attr.stride = sizeof(struct sq_sge);
-		hwq_attr.depth = bnxt_qplib_get_depth(rq);
+		hwq_attr.depth = bnxt_qplib_get_depth(rq, qp->wqe_mode, false);
 		hwq_attr.aux_stride = 0;
 		hwq_attr.aux_depth = 0;
 		hwq_attr.type = HWQ_TYPE_QUEUE;
@@ -2492,7 +2492,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 	}
 	sq = &qp->sq;
 
-	cqe_sq_cons = le16_to_cpu(hwcqe->sq_cons_idx) % sq->max_wqe;
+	cqe_sq_cons = le16_to_cpu(hwcqe->sq_cons_idx) % sq->max_sw_wqe;
 	if (qp->sq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
@@ -2882,7 +2882,7 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 	cqe_cons = le16_to_cpu(hwcqe->sq_cons_idx);
 	if (cqe_cons == 0xFFFF)
 		goto do_rq;
-	cqe_cons %= sq->max_wqe;
+	cqe_cons %= sq->max_sw_wqe;
 
 	if (qp->sq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 56538b9..f54d7a0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -251,6 +251,7 @@ struct bnxt_qplib_q {
 	struct bnxt_qplib_db_info	dbinfo;
 	struct bnxt_qplib_sg_info	sg_info;
 	u32				max_wqe;
+	u32				max_sw_wqe;
 	u16				wqe_size;
 	u16				q_full_delta;
 	u16				max_sge;
@@ -586,15 +587,22 @@ static inline void bnxt_qplib_swq_mod_start(struct bnxt_qplib_q *que, u32 idx)
 	que->swq_start = que->swq[idx].next_idx;
 }
 
-static inline u32 bnxt_qplib_get_depth(struct bnxt_qplib_q *que)
+static inline u32 bnxt_qplib_get_depth(struct bnxt_qplib_q *que, u8 wqe_mode, bool is_sq)
 {
-	return (que->wqe_size * que->max_wqe) / sizeof(struct sq_sge);
+	u32 slots;
+
+	/* Queue depth is the number of slots. */
+	slots = (que->wqe_size * que->max_wqe) / sizeof(struct sq_sge);
+	/* For variable WQE mode, need to align the slots to 256 */
+	if (wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE && is_sq)
+		slots = ALIGN(slots, BNXT_VAR_MAX_SLOT_ALIGN);
+	return slots;
 }
 
 static inline u32 bnxt_qplib_set_sq_size(struct bnxt_qplib_q *que, u8 wqe_mode)
 {
 	return (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
-		que->max_wqe : bnxt_qplib_get_depth(que);
+		que->max_wqe : bnxt_qplib_get_depth(que, wqe_mode, true);
 }
 
 static inline u32 bnxt_qplib_set_sq_max_slot(u8 wqe_mode)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 9328db9..ca2aa35 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -95,11 +95,13 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct creq_query_func_resp_sb *sb;
 	struct bnxt_qplib_rcfw_sbuf sbuf;
+	struct bnxt_qplib_chip_ctx *cctx;
 	struct cmdq_query_func req = {};
 	u8 *tqm_alloc;
 	int i, rc;
 	u32 temp;
 
+	cctx = rcfw->res->cctx;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_FUNC,
 				 sizeof(req));
@@ -133,8 +135,9 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	 * reporting the max number
 	 */
 	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
-	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx) ?
-			    6 : sb->max_sge;
+
+	attr->max_qp_sges = cctx->modes.wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE ?
+			    min_t(u32, sb->max_sge_var_wqe, BNXT_VAR_MAX_SGE) : 6;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
 	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
 	attr->max_cq_sges = attr->max_qp_sges;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 16a67d7..a633e2a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -40,6 +40,7 @@
 #ifndef __BNXT_QPLIB_SP_H__
 #define __BNXT_QPLIB_SP_H__
 
+#include <rdma/bnxt_re-abi.h>
 #define BNXT_QPLIB_RESERVED_QP_WRS	128
 
 struct bnxt_qplib_dev_attr {
@@ -351,4 +352,9 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_cc_param *cc_param);
 
+#define BNXT_VAR_MAX_WQE       4352
+#define BNXT_VAR_MAX_SLOT_ALIGN 256
+#define BNXT_VAR_MAX_SGE        13
+#define BNXT_RE_MAX_RQ_WQES     65536
+
 #endif /* __BNXT_QPLIB_SP_H__*/
-- 
2.5.5


