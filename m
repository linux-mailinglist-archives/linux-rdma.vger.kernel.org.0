Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0D761DC9
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjGYPz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjGYPzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531A213F
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300547; x=1721836547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/vcg6+8c9IU23bulU5kDxprLscwAIF8cc1Cckk/jBY=;
  b=i1ljdgZXBAyeJinWUQ9xv+8grrTgbzbWKKiQKQrP89d0XhRhl4CgNFzN
   lki+FE1HIi1l1hKdOuFZC8skjeXAXzXYoPXvQcsbdjSOwuQeOWPDpl/A9
   bK1rYUs0LVECcoPMs9R/gHoqTX2SuKbClFTEmc4MSg8ceyjitfZ4CWVpl
   k0j3B5gUpeyfFftkho7d92Cc7u6TMGyuWFG0lk+qLqbBuDks2KMmOnRE3
   jl5O9MWAKkmgF0PDuFjtAS6pWflPT28pDQZWHJPA65PTRiEmWHf8W1V+6
   jsDD6pcZqAHNFNVuDZoRzs+NOZflSWpNRU4gi/9gJ5zzN+UOZd1iYI74+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574805"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574805"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743880"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743880"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:36 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 2/2] RDMA/irdma: Use HW specific minimum WQ size
Date:   Tue, 25 Jul 2023 10:55:25 -0500
Message-Id: <20230725155525.1081-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725155525.1081-1-shiraz.saleem@intel.com>
References: <20230725155525.1081-1-shiraz.saleem@intel.com>
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

HW GEN1 and GEN2 have different min WQ sizes but they are
currently set to the same value.

Use a gen specific attribute min_hw_wq_size and extend ABI to
pass it to user-space.

Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/i40iw_hw.c  |  1 +
 drivers/infiniband/hw/irdma/i40iw_hw.h  |  2 +-
 drivers/infiniband/hw/irdma/icrdma_hw.c |  1 +
 drivers/infiniband/hw/irdma/icrdma_hw.h |  1 +
 drivers/infiniband/hw/irdma/irdma.h     |  1 +
 drivers/infiniband/hw/irdma/uk.c        | 12 ++++++++----
 drivers/infiniband/hw/irdma/user.h      |  1 +
 drivers/infiniband/hw/irdma/verbs.c     |  2 ++
 include/uapi/rdma/irdma-abi.h           |  3 +++
 9 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.c b/drivers/infiniband/hw/irdma/i40iw_hw.c
index 37a40fb4d0d7..638d127fb3e0 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.c
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.c
@@ -254,5 +254,6 @@ void i40iw_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.max_stat_idx = IRDMA_HW_STAT_INDEX_MAX_GEN_1;
 	dev->hw_attrs.max_hw_outbound_msg_size = I40IW_MAX_OUTBOUND_MSG_SIZE;
 	dev->hw_attrs.max_hw_inbound_msg_size = I40IW_MAX_INBOUND_MSG_SIZE;
+	dev->hw_attrs.uk_attrs.min_hw_wq_size = I40IW_MIN_WQ_SIZE;
 	dev->hw_attrs.max_qp_wr = I40IW_MAX_QP_WRS;
 }
diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.h b/drivers/infiniband/hw/irdma/i40iw_hw.h
index 1c438b3593ea..10afc165f5ea 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.h
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.h
@@ -140,11 +140,11 @@ enum i40iw_device_caps_const {
 	I40IW_MAX_CQ_SIZE			= 1048575,
 	I40IW_MAX_OUTBOUND_MSG_SIZE		= 2147483647,
 	I40IW_MAX_INBOUND_MSG_SIZE		= 2147483647,
+	I40IW_MIN_WQ_SIZE                       = 4 /* WQEs */,
 };
 
 #define I40IW_QP_WQE_MIN_SIZE   32
 #define I40IW_QP_WQE_MAX_SIZE   128
-#define I40IW_QP_SW_MIN_WQSIZE  4
 #define I40IW_MAX_RQ_WQE_SHIFT  2
 #define I40IW_MAX_QUANTA_PER_WR 2
 
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.c b/drivers/infiniband/hw/irdma/icrdma_hw.c
index 298d14905993..10ccf4bc3f2d 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.c
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.c
@@ -195,6 +195,7 @@ void icrdma_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.max_stat_inst = ICRDMA_MAX_STATS_COUNT;
 	dev->hw_attrs.max_stat_idx = IRDMA_HW_STAT_INDEX_MAX_GEN_2;
 
+	dev->hw_attrs.uk_attrs.min_hw_wq_size = ICRDMA_MIN_WQ_SIZE;
 	dev->hw_attrs.uk_attrs.max_hw_sq_chunk = IRDMA_MAX_QUANTA_PER_WR;
 	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_RTS_AE |
 						IRDMA_FEATURE_CQ_RESIZE;
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.h b/drivers/infiniband/hw/irdma/icrdma_hw.h
index b65c463abf0b..54035a08cc93 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.h
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.h
@@ -64,6 +64,7 @@ enum icrdma_device_caps_const {
 
 	ICRDMA_MAX_IRD_SIZE			= 127,
 	ICRDMA_MAX_ORD_SIZE			= 255,
+	ICRDMA_MIN_WQ_SIZE                      = 8 /* WQEs */,
 
 };
 
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 173e2dc2fc35..3237fa64bc8f 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -119,6 +119,7 @@ struct irdma_uk_attrs {
 	u32 min_hw_cq_size;
 	u32 max_hw_cq_size;
 	u16 max_hw_sq_chunk;
+	u16 min_hw_wq_size;
 	u8 hw_rev;
 };
 
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a45112a41f59..2986aee3a429 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1349,10 +1349,12 @@ void irdma_get_wqe_shift(struct irdma_uk_attrs *uk_attrs, u32 sge,
 int irdma_get_sqdepth(struct irdma_uk_attrs *uk_attrs, u32 sq_size, u8 shift,
 		      u32 *sqdepth)
 {
+	u32 min_size = (u32)uk_attrs->min_hw_wq_size << shift;
+
 	*sqdepth = irdma_qp_round_up((sq_size << shift) + IRDMA_SQ_RSVD);
 
-	if (*sqdepth < (IRDMA_QP_SW_MIN_WQSIZE << shift))
-		*sqdepth = IRDMA_QP_SW_MIN_WQSIZE << shift;
+	if (*sqdepth < min_size)
+		*sqdepth = min_size;
 	else if (*sqdepth > uk_attrs->max_hw_wq_quanta)
 		return -EINVAL;
 
@@ -1369,10 +1371,12 @@ int irdma_get_sqdepth(struct irdma_uk_attrs *uk_attrs, u32 sq_size, u8 shift,
 int irdma_get_rqdepth(struct irdma_uk_attrs *uk_attrs, u32 rq_size, u8 shift,
 		      u32 *rqdepth)
 {
+	u32 min_size = (u32)uk_attrs->min_hw_wq_size << shift;
+
 	*rqdepth = irdma_qp_round_up((rq_size << shift) + IRDMA_RQ_RSVD);
 
-	if (*rqdepth < (IRDMA_QP_SW_MIN_WQSIZE << shift))
-		*rqdepth = IRDMA_QP_SW_MIN_WQSIZE << shift;
+	if (*rqdepth < min_size)
+		*rqdepth = min_size;
 	else if (*rqdepth > uk_attrs->max_hw_rq_quanta)
 		return -EINVAL;
 
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 1e0e1a71dbad..dd145ec72a91 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -85,6 +85,7 @@ enum irdma_device_caps_const {
 	IRDMA_Q2_BUF_SIZE =			256,
 	IRDMA_QP_CTX_SIZE =			256,
 	IRDMA_MAX_PDS =				262144,
+	IRDMA_MIN_WQ_SIZE_GEN2 =                8,
 };
 
 enum irdma_addressing_type {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7efe3587690f..ec773de31be6 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -330,6 +330,8 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.min_hw_cq_size = uk_attrs->min_hw_cq_size;
 		uresp.hw_rev = uk_attrs->hw_rev;
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_USE_RAW_ATTR;
+		uresp.min_hw_wq_size = uk_attrs->min_hw_wq_size;
+		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE;
 		if (ib_copy_to_udata(udata, &uresp,
 				     min(sizeof(uresp), udata->outlen))) {
 			rdma_user_mmap_entry_remove(ucontext->db_mmap_entry);
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index 3a0cde4dcf33..bb18f15489e3 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -24,6 +24,7 @@ enum irdma_memreg_type {
 
 enum {
 	IRDMA_ALLOC_UCTX_USE_RAW_ATTR = 1 << 0,
+	IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE = 1 << 1,
 };
 
 struct irdma_alloc_ucontext_req {
@@ -52,6 +53,8 @@ struct irdma_alloc_ucontext_resp {
 	__u8 hw_rev;
 	__u8 rsvd2;
 	__aligned_u64 comp_mask;
+	__u16 min_hw_wq_size;
+	__u8 rsvd3[6];
 };
 
 struct irdma_alloc_pd_resp {
-- 
1.8.3.1

