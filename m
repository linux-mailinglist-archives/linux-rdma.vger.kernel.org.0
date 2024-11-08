Return-Path: <linux-rdma+bounces-5861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6519C18B9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294B21F25304
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68091E0DB8;
	Fri,  8 Nov 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R4JMJMX2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F461E0E1A
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056624; cv=none; b=Py+05w9aQZ4Uc6MXdxgw4vt44VSB8Ut7cp4pHe9dUfKhKlEzuyqlo87Wjyh4LMBwjlQJa0OssIqYLCuRrdVEpWZLj5ztckoJl9UJF9OnZfD2m+raayn2tUf8cHtV7+20UWBRsVePec2O+AhR5NeUM9c4PT50+s5+jyuSZSa6/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056624; c=relaxed/simple;
	bh=yOIDLEjI3vxQA9zW3pmPy5EhQizV8Gjb21bFQuQ/5CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oQ2gzBHSOyopcfGsQY+8ajrlT+tn7vKye1v0s0RTOL0fPEmvKZoiEAOk9T+KK5dW4VKUzsANnIMmQw94T0JVy88TTz0SGBFp/lPL7SR+CePpkf8WLyiVBBaeEesK/TvJRYoFRQT8KwI9V+kFZK/aO+UGCPp/WnAjgGLQql5rZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R4JMJMX2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1537194b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731056622; x=1731661422; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1eyU60NWYoe5mjRm3PZbwmcZTns/IyuFInWVURn8jxc=;
        b=R4JMJMX2tiE3WLa6G8195y0eQs2HaqOv2TMXUUEzsuFnPPLfgSUsyNA2AJsdDXJOeY
         aBwVDnb2xzrhlV5XXD0gDTJ5T10EWXxLl69pJSg+OfYPVoLAp04yOqNyG3+jLZZTnahu
         cUOW2XlCtICbqLMG2yF+kDEBrFpiTSf2xdayE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056622; x=1731661422;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eyU60NWYoe5mjRm3PZbwmcZTns/IyuFInWVURn8jxc=;
        b=h/7EuDG8Lk4P4mS/pnpGVZFuDRMH3B1TacQtdR8ImWnznC7tNReeGSz73eSafMGTWG
         aX+ly5rdocFvfKbuDNgrsIdqPMazXCk7aONdjilIy6itxqsxmj2IXN/SRkiZliL2oarn
         /tqKrSLgKw0DOiwY/57MfMTbHAvnASM6n1ju/oPl8ahV6dfWXgvIUMXXKRq9PmoYvQ2t
         HciKWWfM0/Pgg/oIIwF2oowNF45V9leC54BTNy0rzWUHzEfIlNFxYUp4RoL/diov1UjJ
         SABtyH+OKZAlJCM7M4JIdZ3+SDR1XA1oZX/01Y+vxzqs820YS2ETcioZqTwW2BApgw5u
         9ivA==
X-Gm-Message-State: AOJu0YxWkzQzLVBrXLJwHc4YTIq3XJQ9PhxcN5DXDPwSugpZhnuUZ3ku
	7VuV79Mqo9Y2dhsHOPuyVEgrOfXMsfbF/IqcyLs9hqYMtPb/Qnvtuv3eZroYCg==
X-Google-Smtp-Source: AGHT+IGNSAsZOQOOB87mzYLojkJ0FiwN7aZ5GRMfA8dFHQOYN0H4YqYtDPsic3e5rQTwrRiASmH5IQ==
X-Received: by 2002:a05:6a20:3d86:b0:1db:e5b0:4a6 with SMTP id adf61e73a8af0-1dc22b1a3bbmr2246519637.28.1731056621961;
        Fri, 08 Nov 2024 01:03:41 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffcdsm3096441b3a.31.2024.11.08.01.03.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:03:41 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma-next 5/5] RDMA/bnxt_re: Add new function to setup NQs
Date: Fri,  8 Nov 2024 00:42:39 -0800
Message-Id: <1731055359-12603-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Move the logic to setup and enable NQs to a new function.
Similarly moved the NQ cleanup logic to a common function.
Introdued a flag to keep track of NQ allocation status
and added sanity checks inside bnxt_re_stop_irq() and
bnxt_re_start_irq() to avoid possible race conditions.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
 drivers/infiniband/hw/bnxt_re/main.c    | 204 +++++++++++++++++++-------------
 2 files changed, 123 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2975b11..74a340f 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -160,6 +160,7 @@ struct bnxt_re_nq_record {
 	struct bnxt_msix_entry	msix_entries[BNXT_RE_MAX_MSIX];
 	struct bnxt_qplib_nq	nq[BNXT_RE_MAX_MSIX];
 	int			num_msix;
+	int			max_init;
 	/* serialize NQ access */
 	struct mutex		load_lock;
 };
@@ -178,6 +179,7 @@ struct bnxt_re_dev {
 	struct list_head		list;
 	unsigned long			flags;
 #define BNXT_RE_FLAG_NETDEV_REGISTERED		0
+#define BNXT_RE_FLAG_SETUP_NQ			1
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
 #define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
 #define BNXT_RE_FLAG_QOS_WORK_REG		5
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1c7171a..87a54db 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -324,13 +324,19 @@ static void bnxt_re_stop_irq(void *handle)
 		return;
 
 	rdev = en_info->rdev;
+	if (!rdev)
+		return;
 	rcfw = &rdev->rcfw;
 
+	if (!test_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
+		goto free_rcfw_irq;
+
 	for (indx = BNXT_RE_NQ_IDX; indx < rdev->nqr->num_msix; indx++) {
 		nq = &rdev->nqr->nq[indx - 1];
 		bnxt_qplib_nq_stop_irq(nq, false);
 	}
 
+free_rcfw_irq:
 	bnxt_qplib_rcfw_stop_irq(rcfw, false);
 }
 
@@ -341,12 +347,18 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	struct bnxt_qplib_rcfw *rcfw;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_nq *nq;
-	int indx, rc;
+	int indx, rc, vec;
 
 	if (!en_info)
 		return;
 
 	rdev = en_info->rdev;
+	if (!rdev)
+		return;
+
+	if (!test_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
+		return;
+
 	msix_ent = rdev->nqr->msix_entries;
 	rcfw = &rdev->rcfw;
 	if (!ent) {
@@ -360,7 +372,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	}
 
 	/* Vectors may change after restart, so update with new vectors
-	 * in device sctructure.
+	 * in device structure.
 	 */
 	for (indx = 0; indx < rdev->nqr->num_msix; indx++)
 		rdev->nqr->msix_entries[indx].vector = ent[indx].vector;
@@ -371,10 +383,11 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
 		return;
 	}
-	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->nqr->num_msix; indx++) {
-		nq = &rdev->nqr->nq[indx - 1];
-		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
-					     msix_ent[indx].vector, false);
+	for (indx = 0 ; indx < rdev->nqr->max_init; indx++) {
+		nq = &rdev->nqr->nq[indx];
+		vec = indx + 1;
+		rc = bnxt_qplib_nq_start_irq(nq, indx,
+					     msix_ent[vec].vector, false);
 		if (rc) {
 			ibdev_warn(&rdev->ibdev, "Failed to reinit NQ index %d\n",
 				   indx - 1);
@@ -1549,64 +1562,39 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 
 static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
 {
-	int i;
-
-	for (i = 1; i < rdev->nqr->num_msix; i++)
-		bnxt_qplib_disable_nq(&rdev->nqr->nq[i - 1]);
-
 	if (rdev->qplib_res.rcfw)
 		bnxt_qplib_cleanup_res(&rdev->qplib_res);
 }
 
 static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 {
-	int num_vec_enabled = 0;
-	int rc = 0, i;
-	u32 db_offt;
-
 	bnxt_qplib_init_res(&rdev->qplib_res);
 
-	mutex_init(&rdev->nqr->load_lock);
-
-	for (i = 1; i < rdev->nqr->num_msix ; i++) {
-		db_offt = rdev->nqr->msix_entries[i].db_offset;
-		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nqr->nq[i - 1],
-					  i - 1, rdev->nqr->msix_entries[i].vector,
-					  db_offt, &bnxt_re_cqn_handler,
-					  &bnxt_re_srqn_handler);
-		if (rc) {
-			ibdev_err(&rdev->ibdev,
-				  "Failed to enable NQ with rc = 0x%x", rc);
-			goto fail;
-		}
-		num_vec_enabled++;
-	}
 	return 0;
-fail:
-	for (i = num_vec_enabled; i >= 0; i--)
-		bnxt_qplib_disable_nq(&rdev->nqr->nq[i]);
-	return rc;
 }
 
-static void bnxt_re_free_nq_res(struct bnxt_re_dev *rdev)
+static void bnxt_re_clean_nqs(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_nq *nq;
 	u8 type;
 	int i;
 
-	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
+	if (!rdev->nqr->max_init)
+		return;
+
+	for (i = (rdev->nqr->max_init - 1); i >= 0; i--) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		nq = &rdev->nqr->nq[i];
+		bnxt_qplib_disable_nq(nq);
 		bnxt_re_net_ring_free(rdev, nq->ring_id, type);
 		bnxt_qplib_free_nq(nq);
 		nq->res = NULL;
 	}
+	rdev->nqr->max_init = 0;
 }
 
 static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
 {
-	bnxt_re_free_nq_res(rdev);
-
 	if (rdev->qplib_res.dpi_tbl.max) {
 		bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
 				       &rdev->dpi_privileged);
@@ -1619,10 +1607,7 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
 
 static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 {
-	struct bnxt_re_ring_attr rattr = {};
-	int num_vec_created = 0;
-	int rc, i;
-	u8 type;
+	int rc;
 
 	/* Configure and allocate resources for qplib */
 	rdev->qplib_res.rcfw = &rdev->rcfw;
@@ -1641,43 +1626,8 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto dealloc_res;
 
-	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
-		struct bnxt_qplib_nq *nq;
-
-		nq = &rdev->nqr->nq[i];
-		nq->hwq.max_elements = BNXT_QPLIB_NQE_MAX_CNT;
-		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, nq);
-		if (rc) {
-			ibdev_err(&rdev->ibdev, "Alloc Failed NQ%d rc:%#x",
-				  i, rc);
-			goto free_nq;
-		}
-		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
-		rattr.pages = nq->hwq.pbl[rdev->nqr->nq[i].hwq.level].pg_count;
-		rattr.type = type;
-		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
-		rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
-		rattr.lrid = rdev->nqr->msix_entries[i + 1].ring_idx;
-		rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
-		if (rc) {
-			ibdev_err(&rdev->ibdev,
-				  "Failed to allocate NQ fw id with rc = 0x%x",
-				  rc);
-			bnxt_qplib_free_nq(nq);
-			goto free_nq;
-		}
-		num_vec_created++;
-	}
 	return 0;
-free_nq:
-	for (i = num_vec_created - 1; i >= 0; i--) {
-		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nqr->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nqr->nq[i]);
-	}
-	bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
-			       &rdev->dpi_privileged);
+
 dealloc_res:
 	bnxt_qplib_free_res(&rdev->qplib_res);
 
@@ -1884,6 +1834,71 @@ static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
 	rdev->nqr = NULL;
 }
 
+static int bnxt_re_setup_nqs(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_re_ring_attr rattr = {};
+	struct bnxt_qplib_nq *nq;
+	int rc, i;
+	int depth;
+	u32 offt;
+	u16 vec;
+	u8 type;
+
+	mutex_init(&rdev->nqr->load_lock);
+
+	depth = BNXT_QPLIB_NQE_MAX_CNT;
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
+		nq = &rdev->nqr->nq[i];
+		vec = rdev->nqr->msix_entries[i + 1].vector;
+		offt = rdev->nqr->msix_entries[i + 1].db_offset;
+		nq->hwq.max_elements = depth;
+		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, nq);
+		if (rc) {
+			dev_err(rdev_to_dev(rdev),
+				"Failed to get mem for NQ %d, rc = 0x%x",
+				i, rc);
+			goto fail_mem;
+		}
+
+		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
+		rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
+		rattr.pages = nq->hwq.pbl[rdev->nqr->nq[i].hwq.level].pg_count;
+		rattr.type = type;
+		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+		rattr.depth = nq->hwq.max_elements - 1;
+		rattr.lrid = rdev->nqr->msix_entries[i + 1].ring_idx;
+
+		rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
+		if (rc) {
+			nq->ring_id = 0xffff; /* Invalid ring-id */
+			dev_err(rdev_to_dev(rdev),
+				"Failed to get fw id for NQ %d, rc = 0x%x",
+				i, rc);
+			goto fail_ring;
+		}
+
+		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, nq, i, vec, offt,
+					  &bnxt_re_cqn_handler,
+					  &bnxt_re_srqn_handler);
+		if (rc) {
+			dev_err(rdev_to_dev(rdev),
+				"Failed to enable NQ %d, rc = 0x%x", i, rc);
+			goto fail_en;
+		}
+	}
+
+	rdev->nqr->max_init = i;
+	return 0;
+fail_en:
+	/* *nq was i'th nq */
+	bnxt_re_net_ring_free(rdev, nq->ring_id, type);
+fail_ring:
+	bnxt_qplib_free_nq(nq);
+fail_mem:
+	rdev->nqr->max_init = i;
+	return rc;
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -1894,6 +1909,11 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
+	rtnl_lock();
+	if (test_and_clear_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
+		bnxt_re_clean_nqs(rdev);
+	rtnl_unlock();
+
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED,
 			       &rdev->flags))
 		bnxt_re_cleanup_res(rdev);
@@ -1906,10 +1926,12 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to deinitialize RCFW: %#x", rc);
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
+		rtnl_lock();
 		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
+		rtnl_unlock();
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
 
@@ -1974,6 +1996,11 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		return -EINVAL;
 	}
 
+	/* Check whether VF or PF */
+	bnxt_re_get_sriov_func_type(rdev);
+
+	bnxt_re_query_hwrm_intf_version(rdev);
+
 	rc = bnxt_re_alloc_nqr_mem(rdev);
 	if (rc) {
 		bnxt_re_destroy_chip_ctx(rdev);
@@ -1981,15 +2008,11 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 		return rc;
 	}
+	rtnl_lock();
 	rdev->nqr->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
 	memcpy(rdev->nqr->msix_entries, rdev->en_dev->msix_entries,
 	       sizeof(struct bnxt_msix_entry) * rdev->nqr->num_msix);
 
-	/* Check whether VF or PF */
-	bnxt_re_get_sriov_func_type(rdev);
-
-	bnxt_re_query_hwrm_intf_version(rdev);
-
 	/* Establish RCFW Communication Channel to initialize the context
 	 * memory for the function and all child VFs
 	 */
@@ -2083,6 +2106,20 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 
 	set_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED, &rdev->flags);
+	rc = bnxt_re_setup_nqs(rdev);
+	if (rc) {
+		if (rdev->nqr->max_init == 0) {
+			dev_err(rdev_to_dev(rdev),
+				"Failed to setup NQs rc = %#x\n", rc);
+			goto fail;
+		}
+
+		dev_warn(rdev_to_dev(rdev),
+			 "expected nqs %d available nqs %d\n",
+			 rdev->nqr->num_msix, rdev->nqr->max_init);
+	}
+	set_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags);
+	rtnl_unlock();
 
 	if (!rdev->is_virtfn) {
 		rc = bnxt_re_setup_qos(rdev);
@@ -2116,6 +2153,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 free_rcfw:
 	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 fail:
+	rtnl_unlock();
 	bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
 
 	return rc;
-- 
2.5.5


