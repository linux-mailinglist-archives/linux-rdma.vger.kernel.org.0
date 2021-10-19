Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421C8433049
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhJSIAc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 04:00:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:60009 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhJSIAa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 04:00:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208549502"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="208549502"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 00:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="526563383"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2021 00:58:12 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 1/1] RDMA/irdma: remove the check to the returned value of irdma_uk_cq_init
Date:   Tue, 19 Oct 2021 11:37:17 -0400
Message-Id: <20211019153717.3836-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Since the function irdma_uk_cq_init always returns 0, so remove the check
to the returned value of the function irdma_uk_cq_init.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/ctrl.c | 5 +----
 drivers/infiniband/hw/irdma/uk.c   | 6 ++----
 drivers/infiniband/hw/irdma/user.h | 4 ++--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 729fa8a3f6f8..7264f8c2f7d5 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2463,7 +2463,6 @@ static inline void irdma_sc_cq_ack(struct irdma_sc_cq *cq)
 enum irdma_status_code irdma_sc_cq_init(struct irdma_sc_cq *cq,
 					struct irdma_cq_init_info *info)
 {
-	enum irdma_status_code ret_code;
 	u32 pble_obj_cnt;
 
 	pble_obj_cnt = info->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].cnt;
@@ -2475,9 +2474,7 @@ enum irdma_status_code irdma_sc_cq_init(struct irdma_sc_cq *cq,
 	cq->ceq_id = info->ceq_id;
 	info->cq_uk_init_info.cqe_alloc_db = cq->dev->cq_arm_db;
 	info->cq_uk_init_info.cq_ack_db = cq->dev->cq_ack_db;
-	ret_code = irdma_uk_cq_init(&cq->cq_uk, &info->cq_uk_init_info);
-	if (ret_code)
-		return ret_code;
+	irdma_uk_cq_init(&cq->cq_uk, &info->cq_uk_init_info);
 
 	cq->virtual_map = info->virtual_map;
 	cq->pbl_chunk_size = info->pbl_chunk_size;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index ebcd93bb9e9d..cc578974ad0e 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1446,8 +1446,8 @@ enum irdma_status_code irdma_uk_qp_init(struct irdma_qp_uk *qp,
  * @cq: hw cq
  * @info: hw cq initialization info
  */
-enum irdma_status_code irdma_uk_cq_init(struct irdma_cq_uk *cq,
-					struct irdma_cq_uk_init_info *info)
+void irdma_uk_cq_init(struct irdma_cq_uk *cq,
+		      struct irdma_cq_uk_init_info *info)
 {
 	cq->cq_base = info->cq_base;
 	cq->cq_id = info->cq_id;
@@ -1458,8 +1458,6 @@ enum irdma_status_code irdma_uk_cq_init(struct irdma_cq_uk *cq,
 	cq->avoid_mem_cflct = info->avoid_mem_cflct;
 	IRDMA_RING_INIT(cq->cq_ring, cq->cq_size);
 	cq->polarity = 1;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 31d5e4e3f442..66e00660fbaa 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -316,8 +316,8 @@ void irdma_uk_cq_request_notification(struct irdma_cq_uk *cq,
 				      enum irdma_cmpl_notify cq_notify);
 void irdma_uk_cq_resize(struct irdma_cq_uk *cq, void *cq_base, int size);
 void irdma_uk_cq_set_resized_cnt(struct irdma_cq_uk *qp, u16 cnt);
-enum irdma_status_code irdma_uk_cq_init(struct irdma_cq_uk *cq,
-					struct irdma_cq_uk_init_info *info);
+void irdma_uk_cq_init(struct irdma_cq_uk *cq,
+		      struct irdma_cq_uk_init_info *info);
 enum irdma_status_code irdma_uk_qp_init(struct irdma_qp_uk *qp,
 					struct irdma_qp_uk_init_info *info);
 struct irdma_sq_uk_wr_trk_info {
-- 
2.27.0

