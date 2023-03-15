Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2206BB6B3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjCOOzs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjCOOz2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:55:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEB11E91
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892073; x=1710428073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VC9vf+pZ8kV7hM/D8Xm0DQjYINcphuz+F0BEGj0tXDU=;
  b=K7abnaNCWrGE1Srz7DwBcdumn/4zeDfh8VCDpbJB+Zt69k91wHWwYS13
   7tAnnu+lY/sKAYbTNjCh66fDqjdbKG3IlqrYTtFsvM9bLMJxVZpVGoyNl
   xYRfo+FdPa6AatXMd1gMwk99HQkS0niGIFl2u5jFquysq1159lYGZBHXr
   Tp7FGOS8ENSUzuHq1BTUN03cuvbuLJ8dJ59uy34A6gFxiEstXwGKaNbyt
   wbi6FlKeA38thwarXhgAcF1ZnBiDCnxxpPPchOn7n9xKSJnZPle0M9yy1
   HpzkP7HQSot1lqD6MHtNk9JgDgttwIJeRo4nhfREHdQBps/v014KZd7+E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561526"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561526"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748457444"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748457444"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:45 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/4] RDMA/irdma: Do not generate SW completions for NOPs
Date:   Wed, 15 Mar 2023 09:52:28 -0500
Message-Id: <20230315145231.931-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145231.931-1-shiraz.saleem@intel.com>
References: <20230315145231.931-1-shiraz.saleem@intel.com>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>

Currently, artificial SW completions are generated for NOP wqes which can
generate unexpected completions with wr_id = 0. Skip the generation of
artificial completions for NOPs.

Fixes: 81091d7696ae ("RDMA/irdma: Add SW mechanism to generate completions on error")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 445e69e8..7887230 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2595,7 +2595,10 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 			/* remove the SQ WR by moving SQ tail*/
 			IRDMA_RING_SET_TAIL(*sq_ring,
 				sq_ring->tail + qp->sq_wrtrk_array[sq_ring->tail].quanta);
-
+			if (cmpl->cpi.op_type == IRDMAQP_OP_NOP) {
+				kfree(cmpl);
+				continue;
+			}
 			ibdev_dbg(iwqp->iwscq->ibcq.device,
 				  "DEV: %s: adding wr_id = 0x%llx SQ Completion to list qp_id=%d\n",
 				  __func__, cmpl->cpi.wr_id, qp->qp_id);
-- 
1.8.3.1

