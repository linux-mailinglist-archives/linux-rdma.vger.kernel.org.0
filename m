Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533942858B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 05:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJKDYN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 23:24:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:47094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231578AbhJKDYN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Oct 2021 23:24:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226688600"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="226688600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 20:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="479677441"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga007.jf.intel.com with ESMTP; 10 Oct 2021 20:22:11 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        leonro@nvidia.com, yanjun.zhu@linux.dev
Subject: [PATCH 1/4] RDMA/irdma: compact the uk.c file
Date:   Mon, 11 Oct 2021 07:01:25 -0400
Message-Id: <20211011110128.4057-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011110128.4057-1-yanjun.zhu@linux.dev>
References: <20211011110128.4057-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function irdma_uk_mw_bind is not used. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/uk.c   | 57 ------------------------------
 drivers/infiniband/hw/irdma/user.h |  4 +--
 2 files changed, 1 insertion(+), 60 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 5fb92de1f015..ebcd93bb9e9d 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -866,63 +866,6 @@ irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 	return 0;
 }
 
-/**
- * irdma_uk_mw_bind - bind Memory Window
- * @qp: hw qp ptr
- * @info: post sq information
- * @post_sq: flag to post sq
- */
-enum irdma_status_code irdma_uk_mw_bind(struct irdma_qp_uk *qp,
-					struct irdma_post_sq_info *info,
-					bool post_sq)
-{
-	__le64 *wqe;
-	struct irdma_bind_window *op_info;
-	u64 hdr;
-	u32 wqe_idx;
-	bool local_fence = false;
-
-	info->push_wqe = qp->push_db ? true : false;
-	op_info = &info->op.bind_window;
-	local_fence |= info->local_fence;
-
-	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, IRDMA_QP_WQE_MIN_QUANTA,
-					 0, info);
-	if (!wqe)
-		return IRDMA_ERR_QP_TOOMANY_WRS_POSTED;
-
-	irdma_clr_wqes(qp, wqe_idx);
-
-	qp->wqe_ops.iw_set_mw_bind_wqe(wqe, op_info);
-
-	hdr = FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMA_OP_TYPE_BIND_MW) |
-	      FIELD_PREP(IRDMAQPSQ_STAGRIGHTS,
-			 ((op_info->ena_reads << 2) | (op_info->ena_writes << 3))) |
-	      FIELD_PREP(IRDMAQPSQ_VABASEDTO,
-			 (op_info->addressing_type == IRDMA_ADDR_TYPE_VA_BASED ? 1 : 0)) |
-	      FIELD_PREP(IRDMAQPSQ_MEMWINDOWTYPE,
-			 (op_info->mem_window_type_1 ? 1 : 0)) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
-	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
-	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, local_fence) |
-	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
-	      FIELD_PREP(IRDMAQPSQ_VALID, qp->swqe_polarity);
-
-	dma_wmb(); /* make sure WQE is populated before valid bit is set */
-
-	set_64bit_val(wqe, 24, hdr);
-
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, IRDMA_QP_WQE_MIN_QUANTA, wqe_idx,
-				  post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
-
-	return 0;
-}
-
 /**
  * irdma_uk_post_receive - post receive wqe
  * @qp: hw qp ptr
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 3dcbb1fbf2c6..31d5e4e3f442 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -283,9 +283,7 @@ enum irdma_status_code irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 enum irdma_status_code irdma_uk_inline_send(struct irdma_qp_uk *qp,
 					    struct irdma_post_sq_info *info,
 					    bool post_sq);
-enum irdma_status_code irdma_uk_mw_bind(struct irdma_qp_uk *qp,
-					struct irdma_post_sq_info *info,
-					bool post_sq);
+
 enum irdma_status_code irdma_uk_post_nop(struct irdma_qp_uk *qp, u64 wr_id,
 					 bool signaled, bool post_sq);
 enum irdma_status_code irdma_uk_post_receive(struct irdma_qp_uk *qp,
-- 
2.27.0

