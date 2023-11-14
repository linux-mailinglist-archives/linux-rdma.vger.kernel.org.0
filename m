Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56187EB54D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjKNRET (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 12:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjKNRES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 12:04:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DCB8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Nov 2023 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699981454; x=1731517454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zxOmDSB1bXtZ53v8/lq3lTjX4uGLeopnE556jUM0y2s=;
  b=EVYqeeR5rXmLSW/3l4/ze1NBoW1gkwngnU6cr00ctd+J+d63cc9XhOed
   UoxC05ym2g7i0tLa+J/J62EcEnh7nrj0guLDXPGUWKKm7q5RzEm3KQSUy
   stSvK6ALj7HIF+JtD91ThS97QAB/UxBezZ1O5ouG8LGUltibOCwnWBWdq
   YPc9DXMpyumzbDZBi/L8cJm3W7I2+i+09bPVEcX/8Ko/Ywxf7ob9DpdBB
   TbHs+pwvCJopIWGc79EfvCFwhPQsjMgF04R6ZaUVrhcvcqI9xtHhFAUyZ
   QDgHpM43HBL/OeCmjJqikeGB2vwIWXw1YuXV5WvAyOrhgO4qG4m6EVraK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394614918"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="394614918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908450235"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="908450235"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:16 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/2] RDMA/irdma: Add wait for suspend on SQD
Date:   Tue, 14 Nov 2023 11:02:46 -0600
Message-Id: <20231114170246.238-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231114170246.238-1-shiraz.saleem@intel.com>
References: <20231114170246.238-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Currently, there is no wait for the QP suspend to complete on a modify
to SQD state. Add a wait, after the modify to SQD state, for the Suspend
Complete AE. While we are at it, update the suspend timeout value in
irdma_prep_tc_change to use IRDMA_EVENT_TIMEOUT_MS too.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    |  6 +++++-
 drivers/infiniband/hw/irdma/main.c  |  2 +-
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 21 +++++++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.h |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 8fa7e4a18e73..74f6bc7b7ad1 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -321,7 +321,11 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			break;
 		case IRDMA_AE_QP_SUSPEND_COMPLETE:
 			if (iwqp->iwdev->vsi.tc_change_pending) {
-				atomic_dec(&iwqp->sc_qp.vsi->qp_suspend_reqs);
+				if (!atomic_dec_return(&qp->vsi->qp_suspend_reqs))
+					wake_up(&iwqp->iwdev->suspend_wq);
+			}
+			if (iwqp->suspend_pending) {
+				iwqp->suspend_pending = false;
 				wake_up(&iwqp->iwdev->suspend_wq);
 			}
 			break;
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 9ac48b4dab41..3f13200ff71b 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -48,7 +48,7 @@ static void irdma_prep_tc_change(struct irdma_device *iwdev)
 	/* Wait for all qp's to suspend */
 	wait_event_timeout(iwdev->suspend_wq,
 			   !atomic_read(&iwdev->vsi.qp_suspend_reqs),
-			   IRDMA_EVENT_TIMEOUT);
+			   msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS));
 	irdma_ws_reset(&iwdev->vsi);
 }
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index d66d87bb8bc4..b65bc2ea542f 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -78,7 +78,7 @@
 
 #define MAX_DPC_ITERATIONS	128
 
-#define IRDMA_EVENT_TIMEOUT		50000
+#define IRDMA_EVENT_TIMEOUT_MS		5000
 #define IRDMA_VCHNL_EVENT_TIMEOUT	100000
 #define IRDMA_RST_TIMEOUT_HZ		4
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 77a4a12a6493..cb828e3da478 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1159,6 +1159,21 @@ static u8 irdma_roce_get_vlan_prio(const struct ib_gid_attr *attr, u8 prio)
 	return prio;
 }
 
+static int irdma_wait_for_suspend(struct irdma_qp *iwqp)
+{
+	if (!wait_event_timeout(iwqp->iwdev->suspend_wq,
+				!iwqp->suspend_pending,
+				msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS))) {
+		iwqp->suspend_pending = false;
+		ibdev_warn(&iwqp->iwdev->ibdev,
+			   "modify_qp timed out waiting for suspend. qp_id = %d, last_ae = 0x%x\n",
+			   iwqp->ibqp.qp_num, iwqp->last_aeq);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * irdma_modify_qp_roce - modify qp request
  * @ibqp: qp's pointer for modify
@@ -1422,6 +1437,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 			info.next_iwarp_state = IRDMA_QP_STATE_SQD;
 			issue_modify_qp = 1;
+			iwqp->suspend_pending = true;
 			break;
 		case IB_QPS_SQE:
 		case IB_QPS_ERR:
@@ -1462,6 +1478,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			ctx_info->rem_endpoint_idx = udp_info->arp_idx;
 			if (irdma_hw_modify_qp(iwdev, iwqp, &info, true))
 				return -EINVAL;
+			if (info.next_iwarp_state == IRDMA_QP_STATE_SQD) {
+				ret = irdma_wait_for_suspend(iwqp);
+				if (ret)
+					return ret;
+			}
 			spin_lock_irqsave(&iwqp->lock, flags);
 			if (iwqp->iwarp_state == info.curr_iwarp_state) {
 				iwqp->iwarp_state = info.next_iwarp_state;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index c42ac22de00e..cfa140b36395 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -198,6 +198,7 @@ struct irdma_qp {
 	u8 flush_issued : 1;
 	u8 sig_all : 1;
 	u8 pau_mode : 1;
+	u8 suspend_pending : 1;
 	u8 rsvd : 1;
 	u8 iwarp_state;
 	u16 term_sq_flush_code;
-- 
1.8.3.1

