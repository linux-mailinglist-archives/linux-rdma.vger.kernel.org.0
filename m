Return-Path: <linux-rdma+bounces-14748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27243C83259
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1643ADF7F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2901F099C;
	Tue, 25 Nov 2025 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO230Rkb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98811E7C12
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039303; cv=none; b=eT9lQeuYBMWPx7hBem9qAa2EReMEDiMSy66iWP6ZnEMFRRw0qdCNUqq+oi517/SJWmR0OM5akcWpMuSr0XyvtlT2dYU7cemCxLVW+x10JAU8qLHVhQojtWiEfnBAOtygVFIyIzhdY7oWysTycx0ZXE2+iIWsqOUtJ/1RLJR+M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039303; c=relaxed/simple;
	bh=ZnRtfkMnTkAqz8Whx57mMkWOrPJoIFYr7sWJce3MBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA7zjSzkM4k3CXqjpjI1bqRLcOA7D/CHi1T1Mnw3e6+NSvWWxxVVX+y8hfQc+6u2k3JxM40d725C9/PX6QHGh4scm8eScj1wOKaK+GBMGqUGyOzs4k0K7gwRLx+zQm3ZsW07+6NM6eIZRD6dTZo8nNNvbiAL9VQbX9LbUC+QpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO230Rkb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039302; x=1795575302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnRtfkMnTkAqz8Whx57mMkWOrPJoIFYr7sWJce3MBk8=;
  b=fO230RkbvSbCsofsGU3WD1kV4Fy0wiyNThQd/K5YYooE5tqybNmpGjed
   ESDRQKWPFar74As+oFV5aknwHjtYF4y2zT84Dt2Zmf+icCybEIjRNgYx4
   A6BP3HK28kT5aGYmuoBZ1qFDRTUhK2t84fAa5jWPfAa2d/SbLQFwPqPXT
   ZMJBXNFtJ2r1rb6020SsuU8BrNFPwxbe+7qKbttBXW+0Okvub0xKsvScs
   aLkSHGiluEaCR9cVMhMYUBzy5gI2mROFRr9BFbhrzNH4fd3P5vHbej7zq
   psNp2IcEHGdqON0WFXshvo4ORRz9ghMAlKNfu3T58gO86pb0WHVpVC6WD
   w==;
X-CSE-ConnectionGUID: oITzyDx/STyApyCbnByE7A==
X-CSE-MsgGUID: KVFhEXXfQUKS8SA85aTovA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942227"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942227"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:55:01 -0800
X-CSE-ConnectionGUID: FcbOBpg3RvGoFSWvd5tCvw==
X-CSE-MsgGUID: vvppXfJtRI+3Mu908+79FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800322"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:55:00 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 8/9] RDMA/irdma: Remove doorbell elision logic
Date: Mon, 24 Nov 2025 20:53:49 -0600
Message-ID: <20251125025350.180-9-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
References: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
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


