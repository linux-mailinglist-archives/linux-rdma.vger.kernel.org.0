Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62792761DC0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjGYPzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGYPzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55F2106
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300516; x=1721836516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75F9+AHzzf3YdFiu/nNXnRy8hMsSrWVZj8uVrhLOHt8=;
  b=fe4jwx3ewWIMKzhaQeFloJ13/HQSNdMDgxx4mcQVsddRl69vXH/oMv9k
   HZh3owpn6bwzHiwc7vseqc4veSudLyTKGBSgPD9Vu1gpr2fnf/58UpJ6F
   kF2EbRSWkEEHmKCGzv6dUxIuZ3sIt5IpAgcJsYN+1oE14ymHEoXN9vlPb
   AV2WJPbzP9/uuU6SnKrtHSQzXe8j3fo1hDZbVYLTvk90skJuZzPs0A6JT
   rgFfukaVy/w/XyqjMi17kZcDiwmBV6FI69SeH6p3WKIOHWb4aYGoSNNLK
   lQpwGpu9RzGuoFNK10Y1S4mC86RnbAR3Tp00u59GXXk2O2g3gy3K6DwiK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574676"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574676"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743800"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743800"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:14 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/4] RDMA/irdma: Drop a local in irdma_sc_get_next_aeqe
Date:   Tue, 25 Jul 2023 10:55:02 -0500
Message-Id: <20230725155505.1069-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725155505.1069-1-shiraz.saleem@intel.com>
References: <20230725155505.1069-1-shiraz.saleem@intel.com>
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

Drop the local wqe_idx in irdma_sc_get_next_aeqe and instead
store the wqe_idx in the info structure for all asynchronous events(AE)
received. There is no reason it should be tied to a specific AE source.

Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index d88c9184007e..b90abdc85057 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -4004,7 +4004,6 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 {
 	u64 temp, compl_ctx;
 	__le64 *aeqe;
-	u16 wqe_idx;
 	u8 ae_src;
 	u8 polarity;
 
@@ -4020,7 +4019,7 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 			     aeqe, 16, false);
 
 	ae_src = (u8)FIELD_GET(IRDMA_AEQE_AESRC, temp);
-	wqe_idx = (u16)FIELD_GET(IRDMA_AEQE_WQDESCIDX, temp);
+	info->wqe_idx = (u16)FIELD_GET(IRDMA_AEQE_WQDESCIDX, temp);
 	info->qp_cq_id = (u32)FIELD_GET(IRDMA_AEQE_QPCQID_LOW, temp) |
 			 ((u32)FIELD_GET(IRDMA_AEQE_QPCQID_HI, temp) << 18);
 	info->ae_id = (u16)FIELD_GET(IRDMA_AEQE_AECODE, temp);
@@ -4103,7 +4102,6 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	case IRDMA_AE_SOURCE_RQ_0011:
 		info->qp = true;
 		info->rq = true;
-		info->wqe_idx = wqe_idx;
 		info->compl_ctx = compl_ctx;
 		break;
 	case IRDMA_AE_SOURCE_CQ:
@@ -4117,7 +4115,6 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	case IRDMA_AE_SOURCE_SQ_0111:
 		info->qp = true;
 		info->sq = true;
-		info->wqe_idx = wqe_idx;
 		info->compl_ctx = compl_ctx;
 		break;
 	case IRDMA_AE_SOURCE_IN_RR_WR:
-- 
1.8.3.1

