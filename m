Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677B74F78D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGKRxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGKRxQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 13:53:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185EE6F
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689097995; x=1720633995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwvrV7ClSP8Dm1EuJES8KTdYFZ0HFJmM4MHfnwhgvLQ=;
  b=AcWwfMMp0JZVe6vXcI5Ss0e366TGwzKMD/vKdGwc0x2hC5VzNg26bWdO
   2zZuA+SjblI0sTyZBN0IezZWQgBNevYpy09cLyTmz4MeDRXx0YuDuTMB5
   g4bobSlIcQMlP3yqytBP9aE6+ympyzkjJ9mbhS37dR7kDeke8z1bjFfAH
   ixpDngSRAYi6v103o+zWVITnuT6wzbbuN//BfpLWL5dn+gfiyYhoKk/15
   ZC3Lu1pxn+d8xv7tEakrcFFSHsR5pI7teHkFtyMo3sLzqluIq+qJ8Nffd
   K3YaKr8uRig+FqnHCk0nwCLPeA2mo0Ac+bqZKE8yN+kTmrFb5Kzc+vDKM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395482611"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="395482611"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724542502"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="724542502"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.33.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:07 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/3] RDMA/irdma: Fix data race on CQP completion stats
Date:   Tue, 11 Jul 2023 12:52:52 -0500
Message-Id: <20230711175253.1289-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711175253.1289-1-shiraz.saleem@intel.com>
References: <20230711175253.1289-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CQP completion statistics is read lockesly in irdma_wait_event and
irdma_check_cqp_progress while it can be updated in the completion
thread irdma_sc_ccq_get_cqe_info on another CPU as KCSAN reports.

Make completion statistics an atomic variable to reflect coherent updates
to it. This will also avoid load/store tearing logic bug potentially
possible by compiler optimizations.

[77346.170861] BUG: KCSAN: data-race in irdma_handle_cqp_op [irdma] / irdma_sc_ccq_get_cqe_info [irdma]

[77346.171383] write to 0xffff8a3250b108e0 of 8 bytes by task 9544 on cpu 4:
[77346.171483]  irdma_sc_ccq_get_cqe_info+0x27a/0x370 [irdma]
[77346.171658]  irdma_cqp_ce_handler+0x164/0x270 [irdma]
[77346.171835]  cqp_compl_worker+0x1b/0x20 [irdma]
[77346.172009]  process_one_work+0x4d1/0xa40
[77346.172024]  worker_thread+0x319/0x700
[77346.172037]  kthread+0x180/0x1b0
[77346.172054]  ret_from_fork+0x22/0x30

[77346.172136] read to 0xffff8a3250b108e0 of 8 bytes by task 9838 on cpu 2:
[77346.172234]  irdma_handle_cqp_op+0xf4/0x4b0 [irdma]
[77346.172413]  irdma_cqp_aeq_cmd+0x75/0xa0 [irdma]
[77346.172592]  irdma_create_aeq+0x390/0x45a [irdma]
[77346.172769]  irdma_rt_init_hw.cold+0x212/0x85d [irdma]
[77346.172944]  irdma_probe+0x54f/0x620 [irdma]
[77346.173122]  auxiliary_bus_probe+0x66/0xa0
[77346.173137]  really_probe+0x140/0x540
[77346.173154]  __driver_probe_device+0xc7/0x220
[77346.173173]  driver_probe_device+0x5f/0x140
[77346.173190]  __driver_attach+0xf0/0x2c0
[77346.173208]  bus_for_each_dev+0xa8/0xf0
[77346.173225]  driver_attach+0x29/0x30
[77346.173240]  bus_add_driver+0x29c/0x2f0
[77346.173255]  driver_register+0x10f/0x1a0
[77346.173272]  __auxiliary_driver_register+0xbc/0x140
[77346.173287]  irdma_init_module+0x55/0x1000 [irdma]
[77346.173460]  do_one_initcall+0x7d/0x410
[77346.173475]  do_init_module+0x81/0x2c0
[77346.173491]  load_module+0x1232/0x12c0
[77346.173506]  __do_sys_finit_module+0x101/0x180
[77346.173522]  __x64_sys_finit_module+0x3c/0x50
[77346.173538]  do_syscall_64+0x39/0x90
[77346.173553]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[77346.173634] value changed: 0x0000000000000094 -> 0x0000000000000095

Fixes: 915cc7ac0f8 ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c  | 22 +++++++++---------
 drivers/infiniband/hw/irdma/defs.h  | 46 ++++++++++++++++++-------------------
 drivers/infiniband/hw/irdma/type.h  |  2 ++
 drivers/infiniband/hw/irdma/utils.c |  2 +-
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index c91439f..45e3344 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2712,13 +2712,13 @@ static int irdma_sc_cq_modify(struct irdma_sc_cq *cq,
  */
 void irdma_check_cqp_progress(struct irdma_cqp_timeout *timeout, struct irdma_sc_dev *dev)
 {
-	if (timeout->compl_cqp_cmds != dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]) {
-		timeout->compl_cqp_cmds = dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	u64 completed_ops = atomic64_read(&dev->cqp->completed_ops);
+
+	if (timeout->compl_cqp_cmds != completed_ops) {
+		timeout->compl_cqp_cmds = completed_ops;
 		timeout->count = 0;
-	} else {
-		if (dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] !=
-		    timeout->compl_cqp_cmds)
-			timeout->count++;
+	} else if (timeout->compl_cqp_cmds != dev->cqp->requested_ops) {
+		timeout->count++;
 	}
 }
 
@@ -2761,7 +2761,7 @@ static int irdma_cqp_poll_registers(struct irdma_sc_cqp *cqp, u32 tail,
 		if (newtail != tail) {
 			/* SUCCESS */
 			IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-			cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+			atomic64_inc(&cqp->completed_ops);
 			return 0;
 		}
 		udelay(cqp->dev->hw_attrs.max_sleep_count);
@@ -3121,8 +3121,8 @@ int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 	info->dev->cqp = cqp;
 
 	IRDMA_RING_INIT(cqp->sq_ring, cqp->sq_size);
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] = 0;
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS] = 0;
+	cqp->requested_ops = 0;
+	atomic64_set(&cqp->completed_ops, 0);
 	/* for the cqp commands backlog. */
 	INIT_LIST_HEAD(&cqp->dev->cqp_cmd_head);
 
@@ -3274,7 +3274,7 @@ __le64 *irdma_sc_cqp_get_next_send_wqe_idx(struct irdma_sc_cqp *cqp, u64 scratch
 	if (ret_code)
 		return NULL;
 
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS]++;
+	cqp->requested_ops++;
 	if (!*wqe_idx)
 		cqp->polarity = !cqp->polarity;
 	wqe = cqp->sq_base[*wqe_idx].elem;
@@ -3400,7 +3400,7 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	dma_wmb(); /* make sure shadow area is updated before moving tail */
 
 	IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-	ccq->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+	atomic64_inc(&cqp->completed_ops);
 
 	return ret_code;
 }
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 6014b9d..d06e45d 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -191,32 +191,30 @@ enum irdma_cqp_op_type {
 	IRDMA_OP_MANAGE_VF_PBLE_BP		= 25,
 	IRDMA_OP_QUERY_FPM_VAL			= 26,
 	IRDMA_OP_COMMIT_FPM_VAL			= 27,
-	IRDMA_OP_REQ_CMDS			= 28,
-	IRDMA_OP_CMPL_CMDS			= 29,
-	IRDMA_OP_AH_CREATE			= 30,
-	IRDMA_OP_AH_MODIFY			= 31,
-	IRDMA_OP_AH_DESTROY			= 32,
-	IRDMA_OP_MC_CREATE			= 33,
-	IRDMA_OP_MC_DESTROY			= 34,
-	IRDMA_OP_MC_MODIFY			= 35,
-	IRDMA_OP_STATS_ALLOCATE			= 36,
-	IRDMA_OP_STATS_FREE			= 37,
-	IRDMA_OP_STATS_GATHER			= 38,
-	IRDMA_OP_WS_ADD_NODE			= 39,
-	IRDMA_OP_WS_MODIFY_NODE			= 40,
-	IRDMA_OP_WS_DELETE_NODE			= 41,
-	IRDMA_OP_WS_FAILOVER_START		= 42,
-	IRDMA_OP_WS_FAILOVER_COMPLETE		= 43,
-	IRDMA_OP_SET_UP_MAP			= 44,
-	IRDMA_OP_GEN_AE				= 45,
-	IRDMA_OP_QUERY_RDMA_FEATURES		= 46,
-	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 47,
-	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 48,
-	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 49,
-	IRDMA_OP_CQ_MODIFY			= 50,
+	IRDMA_OP_AH_CREATE			= 28,
+	IRDMA_OP_AH_MODIFY			= 29,
+	IRDMA_OP_AH_DESTROY			= 30,
+	IRDMA_OP_MC_CREATE			= 31,
+	IRDMA_OP_MC_DESTROY			= 32,
+	IRDMA_OP_MC_MODIFY			= 33,
+	IRDMA_OP_STATS_ALLOCATE			= 34,
+	IRDMA_OP_STATS_FREE			= 35,
+	IRDMA_OP_STATS_GATHER			= 36,
+	IRDMA_OP_WS_ADD_NODE			= 37,
+	IRDMA_OP_WS_MODIFY_NODE			= 38,
+	IRDMA_OP_WS_DELETE_NODE			= 39,
+	IRDMA_OP_WS_FAILOVER_START		= 40,
+	IRDMA_OP_WS_FAILOVER_COMPLETE		= 41,
+	IRDMA_OP_SET_UP_MAP			= 42,
+	IRDMA_OP_GEN_AE				= 43,
+	IRDMA_OP_QUERY_RDMA_FEATURES		= 44,
+	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 45,
+	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 46,
+	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 47,
+	IRDMA_OP_CQ_MODIFY			= 48,
 
 	/* Must be last entry*/
-	IRDMA_MAX_CQP_OPS			= 51,
+	IRDMA_MAX_CQP_OPS			= 49,
 };
 
 /* CQP SQ WQES */
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 5ee6860..a207095 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -365,6 +365,8 @@ struct irdma_sc_cqp {
 	struct irdma_dcqcn_cc_params dcqcn_params;
 	__le64 *host_ctx;
 	u64 *scratch_array;
+	u64 requested_ops;
+	atomic64_t completed_ops;
 	u32 cqp_id;
 	u32 sq_size;
 	u32 hw_sq_size;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 71e1c5d..775a799 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -567,7 +567,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	bool cqp_error = false;
 	int err_code = 0;
 
-	cqp_timeout.compl_cqp_cmds = rf->sc_dev.cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	cqp_timeout.compl_cqp_cmds = atomic64_read(&rf->sc_dev.cqp->completed_ops);
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-- 
1.8.3.1

