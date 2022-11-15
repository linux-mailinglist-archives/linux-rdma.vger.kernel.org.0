Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B962628F10
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 02:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKOBRR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 20:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiKOBRO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 20:17:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA61758B
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668475031; x=1700011031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Giy4X5f9Bhf9PNFjXowIL9rUj9vHuwQWhhuOShu7uLQ=;
  b=LKbNWGNLJqShAX8u8yCkMXNIjS02er5hWKXV6gua4upVC80a1RcQTrHj
   c/uLuA2uyPiJijK1VA08iFmaMOaScuGEKWMBIliUG1sY8UtXT0iC9jB97
   HTlUpR9/6Bc6ngLUGCkMhk43RB5OfShxr2/AT5CeSGUoYK7X6OfJRghNv
   xTYFFgoCzj+SErPu7LTPNYEOrxfq38h4qXV00A8g3+aMyhtU5ZuxI7jKK
   Ss66RlCKuvjgwFxm+lrt57GQIfTwrkdAqV55Bc+nPhKtIitYJ/ZAPMkrC
   k6iR9+eGlEQpXwFivzWBB8LrYUmFObGB3bKuWzWtNzWS8d7XMmMiye/8s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309755413"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309755413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727755024"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727755024"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:10 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 3/3] RDMA/irdma: Do not request 2-level PBLEs for CQ alloc
Date:   Mon, 14 Nov 2022 19:17:01 -0600
Message-Id: <20221115011701.1379-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221115011701.1379-1-shiraz.saleem@intel.com>
References: <20221115011701.1379-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

When allocating PBLE's for a large CQ, it is possible
that a 2-level PBLE is returned which would cause the
CQ allocation to fail since 1-level is assumed and checked for.
Fix this by requesting a level one PBLE only.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 01d0dc4..dc3f5f3 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2329,9 +2329,10 @@ static bool irdma_check_mr_contiguous(struct irdma_pble_alloc *palloc,
  * @rf: RDMA PCI function
  * @iwmr: mr pointer for this memory registration
  * @use_pbles: flag if to use pble's
+ * @lvl_1_only: request only level 1 pble if true
  */
 static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
-			     bool use_pbles)
+			     bool use_pbles, bool lvl_1_only)
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
@@ -2342,7 +2343,7 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 
 	if (use_pbles) {
 		status = irdma_get_pble(rf->pble_rsrc, palloc, iwmr->page_cnt,
-					false);
+					lvl_1_only);
 		if (status)
 			return status;
 
@@ -2385,16 +2386,10 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	bool ret = true;
 
 	pg_size = iwmr->page_size;
-	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
+	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, true);
 	if (err)
 		return err;
 
-	if (use_pbles && palloc->level != PBLE_LEVEL_1) {
-		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
-		iwpbl->pbl_allocated = false;
-		return -ENOMEM;
-	}
-
 	if (use_pbles)
 		arr = palloc->level1.addr;
 
@@ -2870,7 +2865,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	case IRDMA_MEMREG_TYPE_MEM:
 		use_pbles = (iwmr->page_cnt != 1);
 
-		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
+		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
 		if (err)
 			goto error;
 
-- 
1.8.3.1

