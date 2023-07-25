Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36165761DC2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGYPzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjGYPzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36660BC
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300517; x=1721836517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VCne5BgcBRMQrkrIzVsi6M+GcomSael39Xm/FDPp5s=;
  b=nEJE9OqS/4A05J9CDhSeaZlk3NCaOOOwub4x+I1YHW7ftu6hZYrDAFTB
   /JRzG087E8FvRkqDjxqw0muBTRQFHCH8z70kkB486KEIobyPT0iPV4pfh
   tD79U9kRuOPtxWhCmiYeAxNDc5/clQjYibOrsPuTKoehuuGysHZ5t/soe
   Up832vdpCieI4+LUYM0bdA8LMaOG4WpUi3CR0NHq3pIBs5Q+RxPRJMtiW
   i4HH+xAYkCX+lZbp277wxd2M/vQ6Y6hZdAo8sqnoAOuTFzmpd1iVx7R1f
   nRl9wx82ZxF/rh/7SpkMcW+rSFvDoTpqVzt/Esk+U5ryCo22ci333w1fT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574682"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574682"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743806"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743806"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:15 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 3/4] RDMA/irdma: Add table based lookup for CQ pointer during an event
Date:   Tue, 25 Jul 2023 10:55:04 -0500
Message-Id: <20230725155505.1069-4-shiraz.saleem@intel.com>
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

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Add a CQ table based loookup to allow quick search
for CQ pointer having CQ ID in case of CQ related
asynchrononous event. The table is implemented in a
similar fashion to QP table.

Also add a reference counters for CQ. This is to prevent
destroying CQ while an asynchronous event is being processed.

The memory resource table size is sized higher with this update,
and this table doesn't need to be physically contiguous, so use
a vzalloc vs kzalloc to allocate the table.

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    | 27 +++++++++++++++++++--------
 drivers/infiniband/hw/irdma/main.h  |  4 ++++
 drivers/infiniband/hw/irdma/utils.c | 25 +++++++++++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.c |  7 +++++++
 drivers/infiniband/hw/irdma/verbs.h |  2 ++
 5 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 369eb6b6536d..8519495d23ce 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -218,7 +218,6 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 	struct irdma_aeqe_info *info = &aeinfo;
 	int ret;
 	struct irdma_qp *iwqp = NULL;
-	struct irdma_sc_cq *cq = NULL;
 	struct irdma_cq *iwcq = NULL;
 	struct irdma_sc_qp *qp = NULL;
 	struct irdma_qp_host_ctx_info *ctx_info = NULL;
@@ -335,10 +334,18 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			ibdev_err(&iwdev->ibdev,
 				  "Processing an iWARP related AE for CQ misc = 0x%04X\n",
 				  info->ae_id);
-			cq = (struct irdma_sc_cq *)(unsigned long)
-			     info->compl_ctx;
 
-			iwcq = cq->back_cq;
+			spin_lock_irqsave(&rf->cqtable_lock, flags);
+			iwcq = rf->cq_table[info->qp_cq_id];
+			if (!iwcq) {
+				spin_unlock_irqrestore(&rf->cqtable_lock,
+						       flags);
+				ibdev_dbg(to_ibdev(dev),
+					  "cq_id %d is already freed\n", info->qp_cq_id);
+				continue;
+			}
+			irdma_cq_add_ref(&iwcq->ibcq);
+			spin_unlock_irqrestore(&rf->cqtable_lock, flags);
 
 			if (iwcq->ibcq.event_handler) {
 				struct ib_event ibevent;
@@ -349,6 +356,7 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 				iwcq->ibcq.event_handler(&ibevent,
 							 iwcq->ibcq.cq_context);
 			}
+			irdma_cq_rem_ref(&iwcq->ibcq);
 			break;
 		case IRDMA_AE_RESET_NOT_SENT:
 		case IRDMA_AE_LLP_DOUBT_REACHABILITY:
@@ -1555,7 +1563,7 @@ static void irdma_del_init_mem(struct irdma_pci_f *rf)
 
 	kfree(dev->hmc_info->sd_table.sd_entry);
 	dev->hmc_info->sd_table.sd_entry = NULL;
-	kfree(rf->mem_rsrc);
+	vfree(rf->mem_rsrc);
 	rf->mem_rsrc = NULL;
 	dma_free_coherent(rf->hw.device, rf->obj_mem.size, rf->obj_mem.va,
 			  rf->obj_mem.pa);
@@ -1951,10 +1959,12 @@ static void irdma_set_hw_rsrc(struct irdma_pci_f *rf)
 	rf->allocated_arps = &rf->allocated_mcgs[BITS_TO_LONGS(rf->max_mcg)];
 	rf->qp_table = (struct irdma_qp **)
 		(&rf->allocated_arps[BITS_TO_LONGS(rf->arp_table_size)]);
+	rf->cq_table = (struct irdma_cq **)(&rf->qp_table[rf->max_qp]);
 
 	spin_lock_init(&rf->rsrc_lock);
 	spin_lock_init(&rf->arp_lock);
 	spin_lock_init(&rf->qptable_lock);
+	spin_lock_init(&rf->cqtable_lock);
 	spin_lock_init(&rf->qh_list_lock);
 }
 
@@ -1975,6 +1985,7 @@ static u32 irdma_calc_mem_rsrc_size(struct irdma_pci_f *rf)
 	rsrc_size += sizeof(unsigned long) * BITS_TO_LONGS(rf->max_ah);
 	rsrc_size += sizeof(unsigned long) * BITS_TO_LONGS(rf->max_mcg);
 	rsrc_size += sizeof(struct irdma_qp **) * rf->max_qp;
+	rsrc_size += sizeof(struct irdma_cq **) * rf->max_cq;
 
 	return rsrc_size;
 }
@@ -2008,10 +2019,10 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 	rf->max_mcg = rf->max_qp;
 
 	rsrc_size = irdma_calc_mem_rsrc_size(rf);
-	rf->mem_rsrc = kzalloc(rsrc_size, GFP_KERNEL);
+	rf->mem_rsrc = vzalloc(rsrc_size);
 	if (!rf->mem_rsrc) {
 		ret = -ENOMEM;
-		goto mem_rsrc_kzalloc_fail;
+		goto mem_rsrc_vzalloc_fail;
 	}
 
 	rf->arp_table = (struct irdma_arp_entry *)rf->mem_rsrc;
@@ -2039,7 +2050,7 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 
 	return 0;
 
-mem_rsrc_kzalloc_fail:
+mem_rsrc_vzalloc_fail:
 	bitmap_free(rf->allocated_ws_nodes);
 	rf->allocated_ws_nodes = NULL;
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index def6dd58dcd4..d3bddd48e864 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -309,7 +309,9 @@ struct irdma_pci_f {
 	spinlock_t arp_lock; /*protect ARP table access*/
 	spinlock_t rsrc_lock; /* protect HW resource array access */
 	spinlock_t qptable_lock; /*protect QP table access*/
+	spinlock_t cqtable_lock; /*protect CQ table access*/
 	struct irdma_qp **qp_table;
+	struct irdma_cq **cq_table;
 	spinlock_t qh_list_lock; /* protect mc_qht_list */
 	struct mc_table_list mc_qht_list;
 	struct irdma_msix_vector *iw_msixtbl;
@@ -500,6 +502,8 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 		    struct ib_udata *udata);
 int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			 int attr_mask, struct ib_udata *udata);
+void irdma_cq_add_ref(struct ib_cq *ibcq);
+void irdma_cq_rem_ref(struct ib_cq *ibcq);
 void irdma_cq_wq_destroy(struct irdma_pci_f *rf, struct irdma_sc_cq *cq);
 
 void irdma_cleanup_pending_cqp_op(struct irdma_pci_f *rf);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 71e1c5d34709..1008e158bba2 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -760,6 +760,31 @@ void irdma_qp_rem_ref(struct ib_qp *ibqp)
 	complete(&iwqp->free_qp);
 }
 
+void irdma_cq_add_ref(struct ib_cq *ibcq)
+{
+	struct irdma_cq *iwcq = to_iwcq(ibcq);
+
+	refcount_inc(&iwcq->refcnt);
+}
+
+void irdma_cq_rem_ref(struct ib_cq *ibcq)
+{
+	struct ib_device *ibdev = ibcq->device;
+	struct irdma_device *iwdev = to_iwdev(ibdev);
+	struct irdma_cq *iwcq = to_iwcq(ibcq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&iwdev->rf->cqtable_lock, flags);
+	if (!refcount_dec_and_test(&iwcq->refcnt)) {
+		spin_unlock_irqrestore(&iwdev->rf->cqtable_lock, flags);
+		return;
+	}
+
+	iwdev->rf->cq_table[iwcq->cq_num] = NULL;
+	spin_unlock_irqrestore(&iwdev->rf->cqtable_lock, flags);
+	complete(&iwcq->free_cq);
+}
+
 struct ib_device *to_ibdev(struct irdma_sc_dev *dev)
 {
 	return &(container_of(dev, struct irdma_pci_f, sc_dev))->iwdev->ibdev;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index a7b82aea4d08..2009819bfad9 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1805,6 +1805,9 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		irdma_process_resize_list(iwcq, iwdev, NULL);
 	spin_unlock_irqrestore(&iwcq->lock, flags);
 
+	irdma_cq_rem_ref(ib_cq);
+	wait_for_completion(&iwcq->free_cq);
+
 	irdma_cq_wq_destroy(iwdev->rf, cq);
 
 	spin_lock_irqsave(&iwceq->ce_lock, flags);
@@ -2014,6 +2017,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 
 	cq = &iwcq->sc_cq;
 	cq->back_cq = iwcq;
+	refcount_set(&iwcq->refcnt, 1);
 	spin_lock_init(&iwcq->lock);
 	INIT_LIST_HEAD(&iwcq->resize_list);
 	INIT_LIST_HEAD(&iwcq->cmpl_generated);
@@ -2165,6 +2169,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			goto cq_destroy;
 		}
 	}
+	rf->cq_table[cq_num] = iwcq;
+	init_completion(&iwcq->free_cq);
+
 	return 0;
 cq_destroy:
 	irdma_cq_wq_destroy(rf, cq);
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index a536e9fa85eb..9de7217df357 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -122,6 +122,8 @@ struct irdma_cq {
 	u32 cq_mem_size;
 	struct irdma_dma_mem kmem;
 	struct irdma_dma_mem kmem_shadow;
+	struct completion free_cq;
+	refcount_t refcnt;
 	spinlock_t lock; /* for poll cq */
 	struct irdma_pbl *iwpbl;
 	struct irdma_pbl *iwpbl_shadow;
-- 
1.8.3.1

