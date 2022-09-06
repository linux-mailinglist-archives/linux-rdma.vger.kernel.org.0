Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2599A5AF804
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiIFWdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIFWdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 18:33:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BD8A7FE
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662503588; x=1694039588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=We8I9TKpkY1YIiwn67wtVkhDva/IN2Wj3b1wIOlLRqI=;
  b=cZ9uGpvoNQHoUJqFhWZIudg6ecUiv6dwkSKVy4v4761YDX/iEt1NcUMi
   usYW68RB0jcVV3s/BasMCvaHjZ+9VEJ+2cAafFRrTgxQK8T80In4VcUwm
   Ax18j+e5VrVbOUXRDJO0gKpNBYTVabyW0jaC54osWtEtUcMKCGpuRgXUj
   NhYNhrDeRgFRUEu3aBYFrg9haXHSs+5rNGJFOGmaDntWRpl80Ao8dNQb2
   q1o86WybOFbqS02J8rz/XAuaFDVQ/j2BerVG9hA6F0b2fszg01kQ1YWLS
   JOxLCfi7/26RzSQgtov4C4B+fRwB+cysuNjMiy1Fzl6qA2hLo8zAIkiHT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296724569"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296724569"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675898227"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:07 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/5] RDMA/irdma: Return error on MR deregister CQP failure
Date:   Tue,  6 Sep 2022 17:32:41 -0500
Message-Id: <20220906223244.1119-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220906223244.1119-1-shiraz.saleem@intel.com>
References: <20220906223244.1119-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu-Devale <sindhu.devale@intel.com>

The MR deregister CQP can fail if an MW is bound to it.
Return an appropriate error for this case.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Sindhu-Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/utils.c | 13 ++++++++-----
 drivers/infiniband/hw/irdma/verbs.c |  6 +++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index c8b9235..075defa 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -590,11 +590,14 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	cqp_error = cqp_request->compl_info.error;
 	if (cqp_error) {
 		err_code = -EIO;
-		if (cqp_request->compl_info.maj_err_code == 0xFFFF &&
-		    cqp_request->compl_info.min_err_code == 0x8029) {
-			if (!rf->reset) {
-				rf->reset = true;
-				rf->gen_ops.request_reset(rf);
+		if (cqp_request->compl_info.maj_err_code == 0xFFFF) {
+			if (cqp_request->compl_info.min_err_code == 0x8002)
+				err_code = -EBUSY;
+			else if (cqp_request->compl_info.min_err_code == 0x8029) {
+				if (!rf->reset) {
+					rf->reset = true;
+					rf->gen_ops.request_reset(rf);
+				}
 			}
 		}
 	}
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f272a32..892467c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3009,6 +3009,7 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
+	int status;
 
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
@@ -3039,8 +3040,11 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	cqp_info->post_sq = 1;
 	cqp_info->in.u.dealloc_stag.dev = &iwdev->rf->sc_dev;
 	cqp_info->in.u.dealloc_stag.scratch = (uintptr_t)cqp_request;
-	irdma_handle_cqp_op(iwdev->rf, cqp_request);
+	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
+	if (status)
+		return status;
+
 	irdma_free_stag(iwdev, iwmr->stag);
 done:
 	if (iwpbl->pbl_allocated)
-- 
1.8.3.1

