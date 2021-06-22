Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F593B0BE0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFVRz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 13:55:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:40104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232288AbhFVRzZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 13:55:25 -0400
IronPort-SDR: 67HyRQh6aw+7ZdYXhPAuxwQ/R95nSZnWxNrZOhG+0/NiT+dqQ70yTIyBgEcxvdyS+U99uWBw8R
 PWKansgugm3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="292738729"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292738729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:53:09 -0700
IronPort-SDR: NomDsF1iOTA/EV0u0tnzEUFiylCCohYETvqjSI7E5eSPQdLm/2tEJSEf+jfUAmaLBWYSbZJB1U
 utZYGETQBq8w==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="555863809"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.1.140])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:53:08 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 1/3] RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
Date:   Tue, 22 Jun 2021 12:52:30 -0500
Message-Id: <20210622175232.439-2-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
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
 drivers/infiniband/hw/irdma/verbs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e8b170f0d997..8bd31656a83a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2360,10 +2360,8 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	u64 *arr = iwmr->pgaddrmem;
 	u32 pg_size;
 	int err = 0;
-	int total;
 	bool ret = true;
 
-	total = req->sq_pages + req->rq_pages + req->cq_pages;
 	pg_size = iwmr->page_size;
 	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
 	if (err)
@@ -2381,7 +2379,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	switch (iwmr->type) {
 	case IRDMA_MEMREG_TYPE_QP:
 		hmc_p = &qpmr->sq_pbl;
-		qpmr->shadow = (dma_addr_t)arr[total];
+		qpmr->shadow = (dma_addr_t)arr[req->sq_pages + req->rq_pages];
 
 		if (use_pbles) {
 			ret = irdma_check_mem_contiguous(arr, req->sq_pages,
@@ -2406,7 +2404,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 		hmc_p = &cqmr->cq_pbl;
 
 		if (!cqmr->split)
-			cqmr->shadow = (dma_addr_t)arr[total];
+			cqmr->shadow = (dma_addr_t)arr[req->cq_pages];
 
 		if (use_pbles)
 			ret = irdma_check_mem_contiguous(arr, req->cq_pages,
@@ -2748,6 +2746,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct ib_umem *region;
 	struct irdma_mem_reg_req req;
 	u32 stag = 0;
+	u8 shadow_pgcnt = 1;
 	bool use_pbles = false;
 	unsigned long flags;
 	int err = -EINVAL;
@@ -2795,6 +2794,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
+		if (req.sq_pages + req.rq_pages + shadow_pgcnt > iwmr->page_cnt) {
+			err = -EINVAL;
+			goto error;
+		}
 		use_pbles = ((req.sq_pages + req.rq_pages) > 2);
 		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
 		if (err)
@@ -2808,6 +2811,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
 		break;
 	case IRDMA_MEMREG_TYPE_CQ:
+		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
+			shadow_pgcnt = 0;
+		if (req.cq_pages + shadow_pgcnt > iwmr->page_cnt) {
+			err = -EINVAL;
+			goto error;
+		}
+
 		use_pbles = (req.cq_pages > 1);
 		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
 		if (err)
-- 
2.27.0

