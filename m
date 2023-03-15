Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA56BB6BA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjCOO4w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjCOO4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:56:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B5B8FBF9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892155; x=1710428155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITjaVN9jfWhz2poej8dQmfGty39nDEqPm+IsmjNf9EE=;
  b=MJh4NZ3ffsR535ugXZnoNh/WaHed8e50wKQUHexZHQaQ47DiumVpzdug
   /hItHmH/C1YZpXcFMkC+fkwdaw5659LF4QHrrGe6PokR1NZv6zjU3fAGM
   nW+sLbE+yra+yQjZbcrGwjQ6NDCIGsN5tql3Db09HtCwLoDVXmsgExODi
   v3cveCH0jTtmoWCsOp/XhDzjFdAHsRQTLMU+/g/ufBz8grd1kL/WQqxMa
   E9JByHHcEThKfivea0ZsTCI8pAzDmjjcQSqy2EaC0ZN2a9cLACj9oFY+l
   BDMlnqKNy5rZNQ1C4cnqRqG2aPi60ZmqqjFJ0Xb+bDRAmPlNoE+yD4ftk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561731"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561731"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743714362"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743714362"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:32 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH for-next 4/4] RDMA/irdma: Refactor PBLE functions
Date:   Wed, 15 Mar 2023 09:53:05 -0500
Message-Id: <20230315145305.955-5-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145305.955-1-shiraz.saleem@intel.com>
References: <20230315145305.955-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

Refactor PBLE functions using a bit mask to represent the PBLE level
desired versus 2 parameters use_pble and lvl_one_only which makes the
code confusing.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/pble.c  | 16 ++++++-------
 drivers/infiniband/hw/irdma/pble.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 45 ++++++++++++++++++-------------------
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index cdc0b8a..c0bef114 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -423,15 +423,15 @@ static int get_lvl1_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
  * get_lvl1_lvl2_pble - calls get_lvl1 and get_lvl2 pble routine
  * @pble_rsrc: pble resources
  * @palloc: contains all inforamtion regarding pble (idx + pble addr)
- * @level1_only: flag for a level 1 PBLE
+ * @lvl: Bitmask for requested pble level
  */
 static int get_lvl1_lvl2_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
-			      struct irdma_pble_alloc *palloc, bool level1_only)
+			      struct irdma_pble_alloc *palloc, u8 lvl)
 {
 	int status = 0;
 
 	status = get_lvl1_pble(pble_rsrc, palloc);
-	if (!status || level1_only || palloc->total_cnt <= PBLE_PER_PAGE)
+	if (!status || lvl == PBLE_LEVEL_1 || palloc->total_cnt <= PBLE_PER_PAGE)
 		return status;
 
 	status = get_lvl2_pble(pble_rsrc, palloc);
@@ -444,11 +444,11 @@ static int get_lvl1_lvl2_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
  * @pble_rsrc: pble resources
  * @palloc: contains all inforamtion regarding pble (idx + pble addr)
  * @pble_cnt: #of pbles requested
- * @level1_only: true if only pble level 1 to acquire
+ * @lvl: requested pble level mask
  */
 int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		   struct irdma_pble_alloc *palloc, u32 pble_cnt,
-		   bool level1_only)
+		   u8 lvl)
 {
 	int status = 0;
 	int max_sds = 0;
@@ -462,7 +462,7 @@ int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 	/*check first to see if we can get pble's without acquiring
 	 * additional sd's
 	 */
-	status = get_lvl1_lvl2_pble(pble_rsrc, palloc, level1_only);
+	status = get_lvl1_lvl2_pble(pble_rsrc, palloc, lvl);
 	if (!status)
 		goto exit;
 
@@ -472,9 +472,9 @@ int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		if (status)
 			break;
 
-		status = get_lvl1_lvl2_pble(pble_rsrc, palloc, level1_only);
+		status = get_lvl1_lvl2_pble(pble_rsrc, palloc, lvl);
 		/* if level1_only, only go through it once */
-		if (!status || level1_only)
+		if (!status || lvl)
 			break;
 	}
 
diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
index 29d29546..b31b7c5 100644
--- a/drivers/infiniband/hw/irdma/pble.h
+++ b/drivers/infiniband/hw/irdma/pble.h
@@ -114,7 +114,7 @@ void irdma_free_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		     struct irdma_pble_alloc *palloc);
 int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		   struct irdma_pble_alloc *palloc, u32 pble_cnt,
-		   bool level1_only);
+		   u8 lvl);
 int irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
 			   struct irdma_chunk *pchunk);
 int irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index d906f59..ab5cdf7 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2325,11 +2325,10 @@ static bool irdma_check_mr_contiguous(struct irdma_pble_alloc *palloc,
  * irdma_setup_pbles - copy user pg address to pble's
  * @rf: RDMA PCI function
  * @iwmr: mr pointer for this memory registration
- * @use_pbles: flag if to use pble's
- * @lvl_1_only: request only level 1 pble if true
+ * @lvl: requested pble levels
  */
 static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
-			     bool use_pbles, bool lvl_1_only)
+			     u8 lvl)
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
@@ -2338,9 +2337,9 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 	int status;
 	enum irdma_pble_level level = PBLE_LEVEL_1;
 
-	if (use_pbles) {
+	if (lvl) {
 		status = irdma_get_pble(rf->pble_rsrc, palloc, iwmr->page_cnt,
-					lvl_1_only);
+					lvl);
 		if (status)
 			return status;
 
@@ -2355,7 +2354,7 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 
 	irdma_copy_user_pgaddrs(iwmr, pbl, level);
 
-	if (use_pbles)
+	if (lvl)
 		iwmr->pgaddrmem[0] = *pbl;
 
 	return 0;
@@ -2366,11 +2365,11 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
  * @iwdev: irdma device
  * @req: information for q memory management
  * @iwpbl: pble struct
- * @use_pbles: flag to use pble
+ * @lvl: pble level mask
  */
 static int irdma_handle_q_mem(struct irdma_device *iwdev,
 			      struct irdma_mem_reg_req *req,
-			      struct irdma_pbl *iwpbl, bool use_pbles)
+			      struct irdma_pbl *iwpbl, u8 lvl)
 {
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
 	struct irdma_mr *iwmr = iwpbl->iwmr;
@@ -2383,11 +2382,11 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	bool ret = true;
 
 	pg_size = iwmr->page_size;
-	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, true);
+	err = irdma_setup_pbles(iwdev->rf, iwmr, lvl);
 	if (err)
 		return err;
 
-	if (use_pbles)
+	if (lvl)
 		arr = palloc->level1.addr;
 
 	switch (iwmr->type) {
@@ -2396,7 +2395,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 		hmc_p = &qpmr->sq_pbl;
 		qpmr->shadow = (dma_addr_t)arr[total];
 
-		if (use_pbles) {
+		if (lvl) {
 			ret = irdma_check_mem_contiguous(arr, req->sq_pages,
 							 pg_size);
 			if (ret)
@@ -2421,7 +2420,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 		if (!cqmr->split)
 			cqmr->shadow = (dma_addr_t)arr[req->cq_pages];
 
-		if (use_pbles)
+		if (lvl)
 			ret = irdma_check_mem_contiguous(arr, req->cq_pages,
 							 pg_size);
 
@@ -2435,7 +2434,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 		err = -EINVAL;
 	}
 
-	if (use_pbles && ret) {
+	if (lvl && ret) {
 		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
 		iwpbl->pbl_allocated = false;
 	}
@@ -2745,17 +2744,17 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
 {
 	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
-	bool use_pbles;
 	u32 stag;
+	u8 lvl;
 	int err;
 
-	use_pbles = iwmr->page_cnt != 1;
+	lvl = iwmr->page_cnt != 1 ? PBLE_LEVEL_1 | PBLE_LEVEL_2 : PBLE_LEVEL_0;
 
-	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
+	err = irdma_setup_pbles(iwdev->rf, iwmr, lvl);
 	if (err)
 		return err;
 
-	if (use_pbles) {
+	if (lvl) {
 		err = irdma_check_mr_contiguous(&iwpbl->pble_alloc,
 						iwmr->page_size);
 		if (err) {
@@ -2839,17 +2838,17 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_ucontext *ucontext = NULL;
 	unsigned long flags;
-	bool use_pbles;
 	u32 total;
 	int err;
+	u8 lvl;
 
 	total = req.sq_pages + req.rq_pages + 1;
 	if (total > iwmr->page_cnt)
 		return -EINVAL;
 
 	total = req.sq_pages + req.rq_pages;
-	use_pbles = total > 2;
-	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+	lvl = total > 2 ? PBLE_LEVEL_1 : PBLE_LEVEL_0;
+	err = irdma_handle_q_mem(iwdev, &req, iwpbl, lvl);
 	if (err)
 		return err;
 
@@ -2872,9 +2871,9 @@ static int irdma_reg_user_mr_type_cq(struct irdma_mem_reg_req req,
 	struct irdma_ucontext *ucontext = NULL;
 	u8 shadow_pgcnt = 1;
 	unsigned long flags;
-	bool use_pbles;
 	u32 total;
 	int err;
+	u8 lvl;
 
 	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
 		shadow_pgcnt = 0;
@@ -2882,8 +2881,8 @@ static int irdma_reg_user_mr_type_cq(struct irdma_mem_reg_req req,
 	if (total > iwmr->page_cnt)
 		return -EINVAL;
 
-	use_pbles = req.cq_pages > 1;
-	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+	lvl = req.cq_pages > 1 ? PBLE_LEVEL_1 : PBLE_LEVEL_0;
+	err = irdma_handle_q_mem(iwdev, &req, iwpbl, lvl);
 	if (err)
 		return err;
 
-- 
1.8.3.1

