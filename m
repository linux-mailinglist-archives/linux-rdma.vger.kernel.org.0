Return-Path: <linux-rdma+bounces-14561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D9C66359
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1A824EDD7D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF934CFD3;
	Mon, 17 Nov 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO9PZ6BM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D134D3AB
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413695; cv=none; b=SAAbgmVVu9X49xOiMAcanElLsNxZMdn1XJp8lHSvmj3S0B9WnpDGnOb54CC1+xNHf83Oett99i1NQpZwNquf0x1nsm2MPjWIsbsoXqZwysckiLaARfRMGvceFFVZqfHwmaj9clN8a4ytMSlscCkgQPJ8XwW3rvBm7aKQrZmyi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413695; c=relaxed/simple;
	bh=ZnRtfkMnTkAqz8Whx57mMkWOrPJoIFYr7sWJce3MBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLFe9RU+ga6Ag6Tis2R8cJek3Imv8XiyxUISzIfVckTdjpq2AB+50SoaDmmpytcaEj2u+ydnjZmDjIlDUBv241wadYUC8J3Qmg5sE85WWfpKrSjBliZI542kb/9/kdxzRWVdPJUD7cffMkkmUy9pwPt+3OLh6kWE4w1hVAECEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO9PZ6BM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413694; x=1794949694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnRtfkMnTkAqz8Whx57mMkWOrPJoIFYr7sWJce3MBk8=;
  b=LO9PZ6BMC/m9CzpML4ofZ6EtukwITosAAZLwpGsVGnwGwhOvKxwnRCfv
   XrN4ApEPNdmjEhIm2ArfNymPY+LgS7vgxzLIhLZGQMKz7XC1IyK8dULBJ
   WZnNuTiabdesxpXm9pMrvTp4CwRwrFDBTAPKvnHhjQWDDGkJHrnUQtRVH
   Q09RcVqqxrO+TQGw8PFtlQ7Kfw7w0E8QRLdjEH8cphdjB5AdyAqx39N7M
   vx2oaadOdd/VQon6MKZSgX951tkT7w0JOhHxpnWR26bx845YgcZSHb79o
   3WLERTq3Pxz+WMskVm6gua61ggbopobNn49mwSe1PLNyP0+6Y5ljeEcPj
   Q==;
X-CSE-ConnectionGUID: DNg1lg9wSAG7YfO+DqpIDQ==
X-CSE-MsgGUID: +3J72BJUSO2Q4iLmKmMyKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051140"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051140"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:13 -0800
X-CSE-ConnectionGUID: PYDh3sXzR8aT9sDiBK1V/g==
X-CSE-MsgGUID: /gnZDs01R7aYT67oezR3zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583669"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:13 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Jacob Moroni <jmoroni@google.com>
Subject: [PATCH] RDMA/irdma: Remove doorbell elision logic
Date: Mon, 17 Nov 2025 15:07:56 -0600
Message-ID: <20251117210756.723-8-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
References: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

In some cases, this logic can result in doorbell writes being
skipped when they should not have been (at least on GEN3 HW),
so remove it. This also means that the mb() can be safely
downgraded to dma_wmb().

Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/puda.c |  1 -
 drivers/infiniband/hw/irdma/uk.c   | 31 ++----------------------------
 drivers/infiniband/hw/irdma/user.h |  1 -
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 3c29e2289322..cee47ddbd1b5 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -685,7 +685,6 @@ static int irdma_puda_qp_create(struct irdma_puda_rsrc *rsrc)
 	ukqp->rq_size = rsrc->rq_size;
 
 	IRDMA_RING_INIT(ukqp->sq_ring, ukqp->sq_size);
-	IRDMA_RING_INIT(ukqp->initial_ring, ukqp->sq_size);
 	IRDMA_RING_INIT(ukqp->rq_ring, ukqp->rq_size);
 	ukqp->wqe_alloc_db = qp->pd->dev->wqe_alloc_db;
 
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 8a463b3d4c83..f0846b800913 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -114,33 +114,8 @@ void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)
  */
 void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 {
-	u64 temp;
-	u32 hw_sq_tail;
-	u32 sw_sq_head;
-
-	/* valid bit is written and loads completed before reading shadow */
-	mb();
-
-	/* read the doorbell shadow area */
-	get_64bit_val(qp->shadow_area, 0, &temp);
-
-	hw_sq_tail = (u32)FIELD_GET(IRDMA_QP_DBSA_HW_SQ_TAIL, temp);
-	sw_sq_head = IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
-	if (sw_sq_head != qp->initial_ring.head) {
-		if (sw_sq_head != hw_sq_tail) {
-			if (sw_sq_head > qp->initial_ring.head) {
-				if (hw_sq_tail >= qp->initial_ring.head &&
-				    hw_sq_tail < sw_sq_head)
-					writel(qp->qp_id, qp->wqe_alloc_db);
-			} else {
-				if (hw_sq_tail >= qp->initial_ring.head ||
-				    hw_sq_tail < sw_sq_head)
-					writel(qp->qp_id, qp->wqe_alloc_db);
-			}
-		}
-	}
-
-	qp->initial_ring.head = qp->sq_ring.head;
+	dma_wmb();
+	writel(qp->qp_id, qp->wqe_alloc_db);
 }
 
 /**
@@ -1606,7 +1581,6 @@ static void irdma_setup_connection_wqes(struct irdma_qp_uk *qp,
 	qp->conn_wqes = move_cnt;
 	IRDMA_RING_MOVE_HEAD_BY_COUNT_NOCHECK(qp->sq_ring, move_cnt);
 	IRDMA_RING_MOVE_TAIL_BY_COUNT(qp->sq_ring, move_cnt);
-	IRDMA_RING_MOVE_HEAD_BY_COUNT_NOCHECK(qp->initial_ring, move_cnt);
 }
 
 /**
@@ -1751,7 +1725,6 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct irdma_qp_uk_init_info *info)
 	qp->max_sq_frag_cnt = info->max_sq_frag_cnt;
 	sq_ring_size = qp->sq_size << info->sq_shift;
 	IRDMA_RING_INIT(qp->sq_ring, sq_ring_size);
-	IRDMA_RING_INIT(qp->initial_ring, sq_ring_size);
 	if (info->first_sq_wq) {
 		irdma_setup_connection_wqes(qp, info);
 		qp->swqe_polarity = 1;
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 3a27cce3c3db..9eb7fd0b1cbf 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -457,7 +457,6 @@ struct irdma_srq_uk {
 	struct irdma_uk_attrs *uk_attrs;
 	__le64 *shadow_area;
 	struct irdma_ring srq_ring;
-	struct irdma_ring initial_ring;
 	u32 srq_id;
 	u32 srq_size;
 	u32 max_srq_frag_cnt;
-- 
2.31.1


