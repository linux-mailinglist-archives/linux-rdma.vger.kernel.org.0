Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D8761DBD
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjGYPzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjGYPy6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:54:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E352118
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300492; x=1721836492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zLE/qcxGiaNxcBS0l4xBLagXc0eljieXYtezaqqtuNA=;
  b=lcXR1m9IsyXcl3xUWa1f6TQoeYt6JryuVDnD/rpgyAGLPd1lKbEhBXGL
   Ric+UgSv0D29RzIoxbgFOcIjr7T1xuwgYTWnWwlB4RdKrYvsDCHNJEDRZ
   CowX43xMZ7vva1/yaLI5JPEN6sUInjvMKp2Ly28CWE7mlhkHSwPBr1TSf
   x/A/uTFecVR4YdLfM9z6KtfBVZvvkKMZE0Z93brAHmAF8HGwk4RqGFEHG
   fUPDHq3o1kqkb/TyJtFX2ttt0PUw9cjguAkgowJ0DExY8QRvQjpNPOgAt
   miFyDVD+hi62vqZoj7AScXemB5swLFI/4z8BaG74zrG/NfxatLUVfPKPm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367795428"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367795428"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755808766"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="755808766"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:54:45 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/2] RDMA/irdma: Fix op_type reporting in CQEs
Date:   Tue, 25 Jul 2023 10:54:37 -0500
Message-Id: <20230725155439.1057-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

The op_type field CQ poll info structure is incorrectly
filled in with the queue type as opposed to the op_type
received in the CQEs. The wrong opcode could be decoded
and returned to the ULP.

Copy the op_type field received in the CQE in the CQ poll
info structure.

Fixes: 24419777e943 ("RDMA/irdma: Fix RQ completion opcode")
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index ea2c07751245..280d633d4ec4 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1161,7 +1161,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	}
 	wqe_idx = (u32)FIELD_GET(IRDMA_CQ_WQEIDX, qword3);
 	info->qp_handle = (irdma_qp_handle)(unsigned long)qp;
-	info->op_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
+	info->op_type = (u8)FIELD_GET(IRDMACQ_OP, qword3);
 
 	if (info->q_type == IRDMA_CQE_QTYPE_RQ) {
 		u32 array_idx;
-- 
1.8.3.1

