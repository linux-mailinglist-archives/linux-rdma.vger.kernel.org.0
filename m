Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B30427C37
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Oct 2021 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhJIRDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Oct 2021 13:03:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:65332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhJIRDt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 9 Oct 2021 13:03:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="224084140"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="224084140"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 10:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="440257526"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2021 10:01:50 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH 2/4] RDMA/irdma: compat the ctrl.c
Date:   Sat,  9 Oct 2021 20:41:08 -0400
Message-Id: <20211010004110.3842-3-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211010004110.3842-1-yanjun.zhu@linux.dev>
References: <20211010004110.3842-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function irdma_sc_send_lsmm_nostag is not used. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/ctrl.c | 38 ------------------------------
 drivers/infiniband/hw/irdma/type.h |  2 +-
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index f1e5515256e0..729fa8a3f6f8 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1419,44 +1419,6 @@ void irdma_sc_send_lsmm(struct irdma_sc_qp *qp, void *lsmm_buf, u32 size,
 		irdma_sc_gen_rts_ae(qp);
 }
 
-/**
- * irdma_sc_send_lsmm_nostag - for privilege qp
- * @qp: sc qp struct
- * @lsmm_buf: buffer with lsmm message
- * @size: size of lsmm buffer
- */
-void irdma_sc_send_lsmm_nostag(struct irdma_sc_qp *qp, void *lsmm_buf, u32 size)
-{
-	__le64 *wqe;
-	u64 hdr;
-	struct irdma_qp_uk *qp_uk;
-
-	qp_uk = &qp->qp_uk;
-	wqe = qp_uk->sq_base->elem;
-
-	set_64bit_val(wqe, 0, (uintptr_t)lsmm_buf);
-
-	if (qp->qp_uk.uk_attrs->hw_rev == IRDMA_GEN_1)
-		set_64bit_val(wqe, 8,
-			      FIELD_PREP(IRDMAQPSQ_GEN1_FRAG_LEN, size));
-	else
-		set_64bit_val(wqe, 8,
-			      FIELD_PREP(IRDMAQPSQ_FRAG_LEN, size) |
-			      FIELD_PREP(IRDMAQPSQ_VALID, qp->qp_uk.swqe_polarity));
-	set_64bit_val(wqe, 16, 0);
-
-	hdr = FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMAQP_OP_RDMA_SEND) |
-	      FIELD_PREP(IRDMAQPSQ_STREAMMODE, 1) |
-	      FIELD_PREP(IRDMAQPSQ_WAITFORRCVPDU, 1) |
-	      FIELD_PREP(IRDMAQPSQ_VALID, qp->qp_uk.swqe_polarity);
-	dma_wmb(); /* make sure WQE is written before valid bit is set */
-
-	set_64bit_val(wqe, 24, hdr);
-
-	print_hex_dump_debug("WQE: SEND_LSMM_NOSTAG WQE", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_QP_WQE_MIN_SIZE, false);
-}
-
 /**
  * irdma_sc_send_rtt - send last read0 or write0
  * @qp: sc qp struct
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 874bc25a938b..4312f2070534 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1256,7 +1256,7 @@ enum irdma_status_code irdma_sc_qp_modify(struct irdma_sc_qp *qp,
 					  u64 scratch, bool post_sq);
 void irdma_sc_send_lsmm(struct irdma_sc_qp *qp, void *lsmm_buf, u32 size,
 			irdma_stag stag);
-void irdma_sc_send_lsmm_nostag(struct irdma_sc_qp *qp, void *lsmm_buf, u32 size);
+
 void irdma_sc_send_rtt(struct irdma_sc_qp *qp, bool read);
 void irdma_sc_qp_setctx(struct irdma_sc_qp *qp, __le64 *qp_ctx,
 			struct irdma_qp_host_ctx_info *info);
-- 
2.27.0

