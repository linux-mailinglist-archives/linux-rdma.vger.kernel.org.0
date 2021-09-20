Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9199141285B
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 23:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhITVpl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 17:45:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:61581 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343965AbhITVni (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 17:43:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="220046445"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="220046445"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 14:37:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="701274480"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.251.129.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 14:37:53 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-core] irdma: Remove optimization algorithm for QP doorbell
Date:   Mon, 20 Sep 2021 16:37:23 -0500
Message-Id: <20210920213723.1279-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove optimization algorithm for QP doorbell, because
without an mfence the algorithm incorrectly skips ringing
the doorbell. This causes applicaitons like OpenMPI with
high number of connections to stall waiting for completion.

Enforcing the order of the write of the WQE valid bit
and the read of the SQ tail is required by the algorithm,
but furher investigation is necessary because this does not
appear sufficient for the algorithm to work. In the meantime,
remove the doorbell optimization and fix the MPI failures.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 providers/irdma/uk.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/providers/irdma/uk.c b/providers/irdma/uk.c
index c7053c52..098b8682 100644
--- a/providers/irdma/uk.c
+++ b/providers/irdma/uk.c
@@ -113,35 +113,10 @@ void irdma_clr_wqes(struct irdma_qp_uk *qp, __u32 qp_wqe_idx)
  */
 void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 {
-	__u64 temp;
-	__u32 hw_sq_tail;
-	__u32 sw_sq_head;
-
-	/* valid bit is written and loads completed before reading shadow */
+	/* valid bit is written before ringing doorbell */
 	udma_to_device_barrier();
 
-	/* read the doorbell shadow area */
-	get_64bit_val(qp->shadow_area, 0, &temp);
-
-	hw_sq_tail = (__u32)FIELD_GET(IRDMA_QP_DBSA_HW_SQ_TAIL, temp);
-	sw_sq_head = IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
-	if (sw_sq_head != qp->initial_ring.head) {
-		if (qp->push_dropped) {
-			db_wr32(qp->qp_id, qp->wqe_alloc_db);
-			qp->push_dropped = false;
-		} else if (sw_sq_head != hw_sq_tail) {
-			if (sw_sq_head > qp->initial_ring.head) {
-				if (hw_sq_tail >= qp->initial_ring.head &&
-				    hw_sq_tail < sw_sq_head)
-					db_wr32(qp->qp_id, qp->wqe_alloc_db);
-			} else {
-				if (hw_sq_tail >= qp->initial_ring.head ||
-				    hw_sq_tail < sw_sq_head)
-					db_wr32(qp->qp_id, qp->wqe_alloc_db);
-			}
-		}
-	}
-
+	db_wr32(qp->qp_id, qp->wqe_alloc_db);
 	qp->initial_ring.head = qp->sq_ring.head;
 }
 
-- 
2.27.0

