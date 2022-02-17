Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B344BA41E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiBQPTR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 10:19:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBQPTR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 10:19:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F841A4D5D
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645111142; x=1676647142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y4dJZ4wOiY2Lg18h1+yM06kx9p+IHoN6xlGl6TDLKiI=;
  b=oDtS5bW0mNMK7l0FRb8qCKPqvxyljC651WsPjdmjy//z4z94xKxzE4+9
   sBZXYpofi9r9a2GJ+SrrEffrl84i8wYxbG0XMRklsvkK43JLRmnH52/0y
   r+q62CM8RZ4UcOTBOyPisYmwrWoK3FeEkPJBPaiZ+UVMHsm0Hajenfymy
   0PvbvhAEcR9gJIrgTZiclfmQPK61+G4O1OmlyQ9y6FEJvXkD/baZiFivW
   88wvm1OQRZbBLvp4JccmhoWp3sWVYgP0Qn2pKtk+f0/QQg7O8cpT54FpS
   j/AmOzIrVHoKsA6DjgMvfzMrNNAXxDjRTrpt2cdfPTqDpwCM5DQzhdshn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="238299016"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238299016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:19:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545657261"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.39.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:19:01 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 2/3] RDMA/irdma: Propagate error codes
Date:   Thu, 17 Feb 2022 09:18:50 -0600
Message-Id: <20220217151851.1518-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220217151851.1518-1-shiraz.saleem@intel.com>
References: <20220217151851.1518-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

All functions now return linux error codes. Propagate
the return from these functions as opposed to converting
them to generic values.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    |  2 +-
 drivers/infiniband/hw/irdma/main.c  | 12 +++++-------
 drivers/infiniband/hw/irdma/verbs.c | 16 +++++++---------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index cd0d409..93b7135 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1099,7 +1099,7 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	irq_update_affinity_hint(msix_vec->irq, &msix_vec->mask);
 	if (status) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: ceq irq config fail\n");
-		return -EINVAL;
+		return status;
 	}
 
 	msix_vec->ceq_id = ceq_id;
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 6558d5e..babbe8a 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -176,7 +176,7 @@ static int irdma_lan_register_qset(struct irdma_sc_vsi *vsi,
 	ret = ice_add_rdma_qset(pf, &qset);
 	if (ret) {
 		ibdev_dbg(&iwdev->ibdev, "WS: LAN alloc_res for rdma qset failed.\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	tc_node->l2_sched_node_id = qset.teid;
@@ -280,10 +280,9 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 	irdma_fill_device_info(iwdev, pf, vsi);
 	rf = iwdev->rf;
 
-	if (irdma_ctrl_init_hw(rf)) {
-		err = -EIO;
+	err = irdma_ctrl_init_hw(rf);
+	if (err)
 		goto err_ctrl_init;
-	}
 
 	l2params.mtu = iwdev->netdev->mtu;
 	ice_get_qos_params(pf, &qos_info);
@@ -291,10 +290,9 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
 		iwdev->dcb_vlan_mode = l2params.num_tc > 1 && !l2params.dscp_mode;
 
-	if (irdma_rt_init_hw(iwdev, &l2params)) {
-		err = -EIO;
+	err = irdma_rt_init_hw(iwdev, &l2params);
+	if (err)
 		goto err_rt_init;
-	}
 
 	err = irdma_ib_register_device(iwdev);
 	if (err)
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6ab56a2..3a5f41b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -603,7 +603,7 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 	status = irdma_get_sqdepth(uk_attrs, ukinfo->sq_size, sqshift,
 				   &sqdepth);
 	if (status)
-		return -ENOMEM;
+		return status;
 
 	if (uk_attrs->hw_rev == IRDMA_GEN_1)
 		rqshift = IRDMA_MAX_RQ_WQE_SHIFT_GEN1;
@@ -614,7 +614,7 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 	status = irdma_get_rqdepth(uk_attrs, ukinfo->rq_size, rqshift,
 				   &rqdepth);
 	if (status)
-		return -ENOMEM;
+		return status;
 
 	iwqp->kqp.sq_wrid_mem =
 		kcalloc(sqdepth, sizeof(*iwqp->kqp.sq_wrid_mem), GFP_KERNEL);
@@ -688,7 +688,7 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
 	status = irdma_handle_cqp_op(rf, cqp_request);
 	irdma_put_cqp_request(&rf->cqp, cqp_request);
 
-	return status ? -ENOMEM : 0;
+	return status;
 }
 
 static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
@@ -2316,7 +2316,7 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 		status = irdma_get_pble(rf->pble_rsrc, palloc, iwmr->page_cnt,
 					false);
 		if (status)
-			return -ENOMEM;
+			return status;
 
 		iwpbl->pbl_allocated = true;
 		level = palloc->level;
@@ -2457,7 +2457,7 @@ static int irdma_hw_alloc_mw(struct irdma_device *iwdev, struct irdma_mr *iwmr)
 	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
 
-	return status ? -ENOMEM : 0;
+	return status;
 }
 
 /**
@@ -3553,7 +3553,7 @@ static int __irdma_poll_cq(struct irdma_cq *iwcq, int num_entries, struct ib_wc
 	ibdev_dbg(&iwdev->ibdev, "%s: Error polling CQ, irdma_err: %d\n",
 		  __func__, ret);
 
-	return -EINVAL;
+	return ret;
 }
 
 /**
@@ -3873,10 +3873,8 @@ static int irdma_mcast_cqp_op(struct irdma_device *iwdev,
 	cqp_info->in.u.mc_create.cqp = &iwdev->rf->cqp.sc_cqp;
 	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
-	if (status)
-		return -ENOMEM;
 
-	return 0;
+	return status;
 }
 
 /**
-- 
1.8.3.1

