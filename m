Return-Path: <linux-rdma+bounces-5858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821979C18B6
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1115D1F2528A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601A1E0E0E;
	Fri,  8 Nov 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LDQqx4GG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40871E0E08
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056617; cv=none; b=mtUKt0mOeACULxsTkzHFgvkboi0ySXaPzte9b3SDxI/UC4tfElfAnYKiQ52ambJeh0zgXP/pKewFhpZR6emdVMwUK1c6TvEosqzcE7hsj1NY+e+xqCgiHnPTpzv9cDz4BasLB49uw716/qk/5P1nL1eYIQ1xSfzsm9ncN1tR19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056617; c=relaxed/simple;
	bh=qNRPQIORBgcz4jCTaxgAq7wuu3tqA/wu/tkeiihma14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dWysJ5Y8B1xiRE4Eal06HCJ76Tjbq+/JsXeDWJ+ZLkABEyLyQQ0xyBsP6nMkC6pRyqvIUyJqBdr4rAz0UKcmXDYMoIkLbT78yWaM9S74h5wSeOoKTdD3+jYz+GSOFsJQLoePkpkndoKPFS9AuHT7jYyA/EmJcFfjWEIitX91QWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LDQqx4GG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720e94d36c8so2693911b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 01:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731056614; x=1731661414; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBOh0S91H6Ors/aQIIqyUO1s8eympW4bsbC9JUijgSg=;
        b=LDQqx4GG5Rf2pWsgCV/LDCofKYkpBLdBefhgf9yhcZmoEz3xOPPzmsy99lBt9B7ZYf
         HfWr9TYG7K6OmMLU6PTbIdMQlJXg9sIaApg+BeyYfMMu5J0FOqJk9b8W1/t49Sl7Pbye
         4bVIsA6g3/Hq1+yOqDfNA/FeN3V4GvqA9ZWcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056614; x=1731661414;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBOh0S91H6Ors/aQIIqyUO1s8eympW4bsbC9JUijgSg=;
        b=pkkPB/NUB+utb35umF+o2Pv6Bc97h6Y+0cS3IeNUwfCxIP4Cch3ncwJvc6Lt5dtAhL
         xZ3tdLPGFvBuDP/DCCvGCm5Ef7SJKsLEUUCxOTas8jdWJAbXTqvj1MAzabfH+pVEZqsr
         YLJDxmfSUuYRGo4CL1fNUthTrNNq3wfN0ge1R1ZIzs7eIdtAiiMqizXNl1S0pLGMjrf6
         9Hr6c61878CtTz2AgBCpwqGpahfasoBxqBD/nmrKKygnU9xDGfi8kvdg+Z3CFkDAxdbV
         sbXkgXhkT9a1iaNfkT0FhZNChyMkMJbaLL+ZimlD6m9ANMI/jkf0Py3teyBBD1LKSUfF
         V4yA==
X-Gm-Message-State: AOJu0YyTHNLuEnCww00u65sQs8CM9j2dNyW+DiVcjNeCjmVfpI6+NIKJ
	NqfO83FmLm8qnCBKXRPVNzcZmDfA8k5YwN9U+Tr8gAscwEOR4g2Pg4upVUOemw==
X-Google-Smtp-Source: AGHT+IHNC3BZhic1Ax1/KlfIitsfa3KjCQtIdBoUkQTh/tKVqgwznuW+v1/VBtv6DIs7LFh8SXQcaQ==
X-Received: by 2002:a05:6a20:12ce:b0:1d9:15b2:83e with SMTP id adf61e73a8af0-1dc23322093mr3564084637.7.1731056613900;
        Fri, 08 Nov 2024 01:03:33 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffcdsm3096441b3a.31.2024.11.08.01.03.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:03:33 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma-next 2/5] RDMA/bnxt_re: Refactor NQ allocation
Date: Fri,  8 Nov 2024 00:42:36 -0800
Message-Id: <1731055359-12603-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Move NQ related data structures from rdev to a new structure
named "struct bnxt_re_nq_record" by keeping a pointer to in
the rdev structure. Allocate the memory for it dynamically.
This change is needed for subsequent patches in the series.

Also, removed the nq_task variable from rdev structure as it
is redundant and no longer used.

This change would help to reduce the size of the driver private
structure as well.

Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 13 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  6 +--
 drivers/infiniband/hw/bnxt_re/main.c     | 74 +++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 7abc37b..d1c839e 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -155,6 +155,11 @@ struct bnxt_re_pacing {
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
 #define BNXT_RE_MIN_MSIX		2
+#define BNXT_RE_MAX_MSIX		BNXT_MAX_ROCE_MSIX
+struct bnxt_re_nq_record {
+	struct bnxt_qplib_nq	nq[BNXT_RE_MAX_MSIX];
+	int			num_msix;
+};
 
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
@@ -183,21 +188,17 @@ struct bnxt_re_dev {
 	unsigned int			version, major, minor;
 	struct bnxt_qplib_chip_ctx	*chip_ctx;
 	struct bnxt_en_dev		*en_dev;
-	int				num_msix;
 
 	int				id;
 
 	struct delayed_work		worker;
 	u8				cur_prio_map;
 
-	/* FP Notification Queue (CQ & SRQ) */
-	struct tasklet_struct		nq_task;
-
 	/* RCFW Channel */
 	struct bnxt_qplib_rcfw		rcfw;
 
-	/* NQ */
-	struct bnxt_qplib_nq		nq[BNXT_MAX_ROCE_MSIX];
+	/* NQ record */
+	struct bnxt_re_nq_record	*nqr;
 
 	/* Device Resources */
 	struct bnxt_qplib_dev_attr	dev_attr;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9a188cc..a9c32c0 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1872,8 +1872,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size(dev_attr->max_srq_sges);
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
-	srq->qplib_srq.eventq_hw_ring_id = rdev->nq[0].ring_id;
-	nq = &rdev->nq[0];
+	srq->qplib_srq.eventq_hw_ring_id = rdev->nqr->nq[0].ring_id;
+	nq = &rdev->nqr->nq[0];
 
 	if (udata) {
 		rc = bnxt_re_init_user_srq(rdev, pd, srq, udata);
@@ -3122,7 +3122,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * used for getting the NQ index.
 	 */
 	nq_alloc_cnt = atomic_inc_return(&rdev->nq_alloc_cnt);
-	nq = &rdev->nq[nq_alloc_cnt % (rdev->num_msix - 1)];
+	nq = &rdev->nqr->nq[nq_alloc_cnt % (rdev->nqr->num_msix - 1)];
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.cnq_hw_ring_id = nq->ring_id;
 	cq->qplib_cq.nq	= nq;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index f9826c4..9acc0e2 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -326,8 +326,8 @@ static void bnxt_re_stop_irq(void *handle)
 	rdev = en_info->rdev;
 	rcfw = &rdev->rcfw;
 
-	for (indx = BNXT_RE_NQ_IDX; indx < rdev->num_msix; indx++) {
-		nq = &rdev->nq[indx - 1];
+	for (indx = BNXT_RE_NQ_IDX; indx < rdev->nqr->num_msix; indx++) {
+		nq = &rdev->nqr->nq[indx - 1];
 		bnxt_qplib_nq_stop_irq(nq, false);
 	}
 
@@ -362,7 +362,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	/* Vectors may change after restart, so update with new vectors
 	 * in device sctructure.
 	 */
-	for (indx = 0; indx < rdev->num_msix; indx++)
+	for (indx = 0; indx < rdev->nqr->num_msix; indx++)
 		rdev->en_dev->msix_entries[indx].vector = ent[indx].vector;
 
 	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
@@ -371,8 +371,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
 		return;
 	}
-	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->num_msix; indx++) {
-		nq = &rdev->nq[indx - 1];
+	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->nqr->num_msix; indx++) {
+		nq = &rdev->nqr->nq[indx - 1];
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
 		if (rc) {
@@ -1206,7 +1206,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 
 	addrconf_addr_eui48((u8 *)&ibdev->node_guid, rdev->netdev->dev_addr);
 
-	ibdev->num_comp_vectors	= rdev->num_msix - 1;
+	ibdev->num_comp_vectors	= rdev->nqr->num_msix - 1;
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
@@ -1551,8 +1551,8 @@ static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
 {
 	int i;
 
-	for (i = 1; i < rdev->num_msix; i++)
-		bnxt_qplib_disable_nq(&rdev->nq[i - 1]);
+	for (i = 1; i < rdev->nqr->num_msix; i++)
+		bnxt_qplib_disable_nq(&rdev->nqr->nq[i - 1]);
 
 	if (rdev->qplib_res.rcfw)
 		bnxt_qplib_cleanup_res(&rdev->qplib_res);
@@ -1566,9 +1566,9 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 
 	bnxt_qplib_init_res(&rdev->qplib_res);
 
-	for (i = 1; i < rdev->num_msix ; i++) {
+	for (i = 1; i < rdev->nqr->num_msix ; i++) {
 		db_offt = rdev->en_dev->msix_entries[i].db_offset;
-		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nq[i - 1],
+		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nqr->nq[i - 1],
 					  i - 1, rdev->en_dev->msix_entries[i].vector,
 					  db_offt, &bnxt_re_cqn_handler,
 					  &bnxt_re_srqn_handler);
@@ -1582,20 +1582,22 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 	return 0;
 fail:
 	for (i = num_vec_enabled; i >= 0; i--)
-		bnxt_qplib_disable_nq(&rdev->nq[i]);
+		bnxt_qplib_disable_nq(&rdev->nqr->nq[i]);
 	return rc;
 }
 
 static void bnxt_re_free_nq_res(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_nq *nq;
 	u8 type;
 	int i;
 
-	for (i = 0; i < rdev->num_msix - 1; i++) {
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nq[i]);
-		rdev->nq[i].res = NULL;
+		nq = &rdev->nqr->nq[i];
+		bnxt_re_net_ring_free(rdev, nq->ring_id, type);
+		bnxt_qplib_free_nq(nq);
+		nq->res = NULL;
 	}
 }
 
@@ -1637,12 +1639,12 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto dealloc_res;
 
-	for (i = 0; i < rdev->num_msix - 1; i++) {
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
 		struct bnxt_qplib_nq *nq;
 
-		nq = &rdev->nq[i];
+		nq = &rdev->nqr->nq[i];
 		nq->hwq.max_elements = BNXT_QPLIB_NQE_MAX_CNT;
-		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
+		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, nq);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Alloc Failed NQ%d rc:%#x",
 				  i, rc);
@@ -1650,7 +1652,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		}
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
-		rattr.pages = nq->hwq.pbl[rdev->nq[i].hwq.level].pg_count;
+		rattr.pages = nq->hwq.pbl[rdev->nqr->nq[i].hwq.level].pg_count;
 		rattr.type = type;
 		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
@@ -1660,7 +1662,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 			ibdev_err(&rdev->ibdev,
 				  "Failed to allocate NQ fw id with rc = 0x%x",
 				  rc);
-			bnxt_qplib_free_nq(&rdev->nq[i]);
+			bnxt_qplib_free_nq(nq);
 			goto free_nq;
 		}
 		num_vec_created++;
@@ -1669,8 +1671,8 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 free_nq:
 	for (i = num_vec_created - 1; i >= 0; i--) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nq[i]);
+		bnxt_re_net_ring_free(rdev, rdev->nqr->nq[i].ring_id, type);
+		bnxt_qplib_free_nq(&rdev->nqr->nq[i]);
 	}
 	bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
 			       &rdev->dpi_privileged);
@@ -1865,6 +1867,21 @@ static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
+static int bnxt_re_alloc_nqr_mem(struct bnxt_re_dev *rdev)
+{
+	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
+	if (!rdev->nqr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
+{
+	kfree(rdev->nqr);
+	rdev->nqr = NULL;
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -1894,11 +1911,12 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
 
-	rdev->num_msix = 0;
+	rdev->nqr->num_msix = 0;
 
 	if (rdev->pacing.dbr_pacing)
 		bnxt_re_deinitialize_dbr_pacing(rdev);
 
+	bnxt_re_free_nqr_mem(rdev);
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (op_type == BNXT_RE_COMPLETE_REMOVE) {
 		if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
@@ -1945,7 +1963,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
 		  rdev->en_dev->ulp_tbl->msix_requested);
-	rdev->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
 
 	rc = bnxt_re_setup_chip_ctx(rdev);
 	if (rc) {
@@ -1955,6 +1972,15 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		return -EINVAL;
 	}
 
+	rc = bnxt_re_alloc_nqr_mem(rdev);
+	if (rc) {
+		bnxt_re_destroy_chip_ctx(rdev);
+		bnxt_unregister_dev(rdev->en_dev);
+		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return rc;
+	}
+	rdev->nqr->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
+
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
 
-- 
2.5.5


