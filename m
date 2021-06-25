Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660EE3B475E
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFYQ0l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 12:26:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:59672 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFYQ0k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 12:26:40 -0400
IronPort-SDR: 1EipeLo81/DeofpfTS75LXZ29e8HwGrG8vylNms61z8Z0OVB3afeVcPcjzBUihR2pImFFdm6yL
 hFFDNZzHgKOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="268831263"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="268831263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 09:24:19 -0700
IronPort-SDR: axhnRLiET8aERvx7CJDBSwEmoUgHbXk2Ea5bxJ9NDS+ufDhGoRo8Z/JyjP9cGPgzwyA/JurVJN
 fj9vkT8irQXA==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="624564420"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.85.35])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 09:24:18 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH v2 rdma-next 1/2] RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
Date:   Fri, 25 Jun 2021 11:23:28 -0500
Message-Id: <20210625162329.1654-2-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210625162329.1654-1-tatyana.e.nikolova@intel.com>
References: <20210625162329.1654-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shiraz Saleem <shiraz.saleem@intel.com>

The contents of user-space req object is used in array indexing
in irdma_handle_q_mem without checking for valid values.

Guard against bad input on each of these req object pages by
limiting them to number of pages that make up the region.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1505160 ("TAINTED_SCALAR")
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 5bb46a4d26ff..9712f6902ba8 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2358,12 +2358,10 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	struct irdma_cq_mr *cqmr = &iwpbl->cq_mr;
 	struct irdma_hmc_pble *hmc_p;
 	u64 *arr = iwmr->pgaddrmem;
-	u32 pg_size;
+	u32 pg_size, total;
 	int err = 0;
-	int total;
 	bool ret = true;
 
-	total = req->sq_pages + req->rq_pages + req->cq_pages;
 	pg_size = iwmr->page_size;
 	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
 	if (err)
@@ -2380,6 +2378,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 
 	switch (iwmr->type) {
 	case IRDMA_MEMREG_TYPE_QP:
+		total = req->sq_pages + req->rq_pages;
 		hmc_p = &qpmr->sq_pbl;
 		qpmr->shadow = (dma_addr_t)arr[total];
 
@@ -2406,7 +2405,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 		hmc_p = &cqmr->cq_pbl;
 
 		if (!cqmr->split)
-			cqmr->shadow = (dma_addr_t)arr[total];
+			cqmr->shadow = (dma_addr_t)arr[req->cq_pages];
 
 		if (use_pbles)
 			ret = irdma_check_mem_contiguous(arr, req->cq_pages,
@@ -2747,7 +2746,8 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct irdma_mr *iwmr;
 	struct ib_umem *region;
 	struct irdma_mem_reg_req req;
-	u32 stag = 0;
+	u32 total, stag = 0;
+	u8 shadow_pgcnt = 1;
 	bool use_pbles = false;
 	unsigned long flags;
 	int err = -EINVAL;
@@ -2801,7 +2801,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
-		use_pbles = ((req.sq_pages + req.rq_pages) > 2);
+		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
+		if (total > iwmr->page_cnt) {
+			err = -EINVAL;
+			goto error;
+		}
+		total = req.sq_pages + req.rq_pages;
+		use_pbles = (total > 2);
 		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
 		if (err)
 			goto error;
@@ -2814,6 +2820,14 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
 		break;
 	case IRDMA_MEMREG_TYPE_CQ:
+		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
+			shadow_pgcnt = 0;
+		total = req.cq_pages + shadow_pgcnt;
+		if (total > iwmr->page_cnt) {
+			err = -EINVAL;
+			goto error;
+		}
+
 		use_pbles = (req.cq_pages > 1);
 		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
 		if (err)
-- 
2.27.0

