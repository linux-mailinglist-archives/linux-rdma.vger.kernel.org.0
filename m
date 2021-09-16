Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED240EAB4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 21:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhIPTOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 15:14:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:63939 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233819AbhIPTOO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 15:14:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="220757289"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="220757289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 12:12:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545830745"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.81.178])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 12:12:36 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        LiLiang <liali@redhat.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 1/4] RDMA/irdma: Skip CQP ring during a reset
Date:   Thu, 16 Sep 2021 14:12:19 -0500
Message-Id: <20210916191222.824-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210916191222.824-1-shiraz.saleem@intel.com>
References: <20210916191222.824-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

Due to duplicate reset flags, CQP commands are processed during reset.

This leads CQP failures such as below:
irdma0: [Delete Local MAC Entry Cmd Error][op_code=49] status=-27 waiting=1 completion_err=0 maj=0x0 min=0x0

Remove the redundant flag and set the correct reset flag so CPQ is
paused during reset

Fixes: 8498a30e1b94 ("RDMA/irdma: Register auxiliary driver and implement private channel OPs")
Reported-by: LiLiang <liali@redhat.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c       | 4 ++--
 drivers/infiniband/hw/irdma/hw.c       | 6 +++---
 drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
 drivers/infiniband/hw/irdma/main.h     | 1 -
 drivers/infiniband/hw/irdma/utils.c    | 2 +-
 drivers/infiniband/hw/irdma/verbs.c    | 3 +--
 6 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 6b62299abfbb..6dea0a49d171 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3496,7 +3496,7 @@ static void irdma_cm_disconn_true(struct irdma_qp *iwqp)
 	     original_hw_tcp_state == IRDMA_TCP_STATE_TIME_WAIT ||
 	     last_ae == IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE ||
 	     last_ae == IRDMA_AE_BAD_CLOSE ||
-	     last_ae == IRDMA_AE_LLP_CONNECTION_RESET || iwdev->reset)) {
+	     last_ae == IRDMA_AE_LLP_CONNECTION_RESET || iwdev->rf->reset)) {
 		issue_close = 1;
 		iwqp->cm_id = NULL;
 		qp->term_flags = 0;
@@ -4250,7 +4250,7 @@ void irdma_cm_teardown_connections(struct irdma_device *iwdev, u32 *ipaddr,
 				       teardown_entry);
 		attr.qp_state = IB_QPS_ERR;
 		irdma_modify_qp(&cm_node->iwqp->ibqp, &attr, IB_QP_STATE, NULL);
-		if (iwdev->reset)
+		if (iwdev->rf->reset)
 			irdma_cm_disconn(cm_node->iwqp);
 		irdma_rem_ref_cm_node(cm_node);
 	}
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 00de5ee9a260..33c06a3a4f63 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1489,7 +1489,7 @@ void irdma_reinitialize_ieq(struct irdma_sc_vsi *vsi)
 
 	irdma_puda_dele_rsrc(vsi, IRDMA_PUDA_RSRC_TYPE_IEQ, false);
 	if (irdma_initialize_ieq(iwdev)) {
-		iwdev->reset = true;
+		iwdev->rf->reset = true;
 		rf->gen_ops.request_reset(rf);
 	}
 }
@@ -1632,13 +1632,13 @@ void irdma_rt_deinit_hw(struct irdma_device *iwdev)
 	case IEQ_CREATED:
 		if (!iwdev->roce_mode)
 			irdma_puda_dele_rsrc(&iwdev->vsi, IRDMA_PUDA_RSRC_TYPE_IEQ,
-					     iwdev->reset);
+					     iwdev->rf->reset);
 		fallthrough;
 	case ILQ_CREATED:
 		if (!iwdev->roce_mode)
 			irdma_puda_dele_rsrc(&iwdev->vsi,
 					     IRDMA_PUDA_RSRC_TYPE_ILQ,
-					     iwdev->reset);
+					     iwdev->rf->reset);
 		break;
 	default:
 		ibdev_warn(&iwdev->ibdev, "bad init_state = %d\n", iwdev->init_state);
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index bddf88194d09..d219f64b2c3d 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -55,7 +55,7 @@ static void i40iw_close(struct i40e_info *cdev_info, struct i40e_client *client,
 
 	iwdev = to_iwdev(ibdev);
 	if (reset)
-		iwdev->reset = true;
+		iwdev->rf->reset = true;
 
 	iwdev->iw_status = 0;
 	irdma_port_ibevent(iwdev);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 743d9e143a99..b678fe712447 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -346,7 +346,6 @@ struct irdma_device {
 	bool roce_mode:1;
 	bool roce_dcqcn_en:1;
 	bool dcb:1;
-	bool reset:1;
 	bool iw_ooo:1;
 	enum init_completion_state init_state;
 
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index e94470991fe0..ac91ea5296db 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2507,7 +2507,7 @@ void irdma_modify_qp_to_err(struct irdma_sc_qp *sc_qp)
 	struct irdma_qp *qp = sc_qp->qp_uk.back_qp;
 	struct ib_qp_attr attr;
 
-	if (qp->iwdev->reset)
+	if (qp->iwdev->rf->reset)
 		return;
 	attr.qp_state = IB_QPS_ERR;
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 4fc323402073..829ddfa7e144 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -535,8 +535,7 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	irdma_qp_rem_ref(&iwqp->ibqp);
 	wait_for_completion(&iwqp->free_qp);
 	irdma_free_lsmm_rsrc(iwqp);
-	if (!iwdev->reset)
-		irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
+	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
 
 	if (!iwqp->user_mode) {
 		if (iwqp->iwscq) {
-- 
2.27.0

