Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173F50E7EF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbiDYSUT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiDYSUT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 14:20:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028293B28B
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910635; x=1682446635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Tbq8hEjCHTn0hqCh6+mAIGAPWI62oyksZcO3JD0MPE=;
  b=Im2/H7eb6vgf3XVD1/AR3PF/CJGU66IM24ckUJ4pMjnL4Qt0zsyVDxwR
   aUR3gSGWh+dP9TzL3Mf3S6AhOhJylUODcfS/bgdWGpdLYEj5JrU+9Cu9J
   3gKhdY24Sm/UVx5VSsrFL3h6ruO/wdyvI186v/ALo3JKFnGm0+w3CAz8o
   XYKxIvb0ciaEZm/isqNBp9A5+JQOZ5UAgtWDkrKr6UkABFoXO5sHx1f7I
   nFGzu1Rz/XGa0V2WrwzVjlQiPOoURSlT010eyvyR3xej5kg200g7XR3tc
   SoXsgIp7PAjlhDsQ/P6n0oF1qPP0vBG8ihlcKvOQhAUN1XP3YBE3sMcDr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252697319"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="252697319"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537708092"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.50.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:13 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/3] RDMA/irdma: Flush iWARP QP if modified to ERR from RTR state
Date:   Mon, 25 Apr 2022 13:17:01 -0500
Message-Id: <20220425181703.1634-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220425181703.1634-1-shiraz.saleem@intel.com>
References: <20220425181703.1634-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

When connection establishment fails in iWARP mode, an app can drain the
QPs and hang because flush isn't issued when the QP is modified from RTR
state to error. Issue a flush in this case using function
irdma_cm_disconn().

Update irdma_cm_disconn() to do flush when cm_id is NULL, which is the
case when the QP is in RTR state and there is an error in the connection
establishment.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c    | 16 +++++-----------
 drivers/infiniband/hw/irdma/verbs.c |  4 ++--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index dedb3b7..d185f3a0 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3467,12 +3467,6 @@ static void irdma_cm_disconn_true(struct irdma_qp *iwqp)
 	}
 
 	cm_id = iwqp->cm_id;
-	/* make sure we havent already closed this connection */
-	if (!cm_id) {
-		spin_unlock_irqrestore(&iwqp->lock, flags);
-		return;
-	}
-
 	original_hw_tcp_state = iwqp->hw_tcp_state;
 	original_ibqp_state = iwqp->ibqp_state;
 	last_ae = iwqp->last_aeq;
@@ -3494,11 +3488,11 @@ static void irdma_cm_disconn_true(struct irdma_qp *iwqp)
 			disconn_status = -ECONNRESET;
 	}
 
-	if ((original_hw_tcp_state == IRDMA_TCP_STATE_CLOSED ||
-	     original_hw_tcp_state == IRDMA_TCP_STATE_TIME_WAIT ||
-	     last_ae == IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE ||
-	     last_ae == IRDMA_AE_BAD_CLOSE ||
-	     last_ae == IRDMA_AE_LLP_CONNECTION_RESET || iwdev->rf->reset)) {
+	if (original_hw_tcp_state == IRDMA_TCP_STATE_CLOSED ||
+	    original_hw_tcp_state == IRDMA_TCP_STATE_TIME_WAIT ||
+	    last_ae == IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE ||
+	    last_ae == IRDMA_AE_BAD_CLOSE ||
+	    last_ae == IRDMA_AE_LLP_CONNECTION_RESET || iwdev->rf->reset || !cm_id) {
 		issue_close = 1;
 		iwqp->cm_id = NULL;
 		qp->term_flags = 0;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 46f4753..52f3e88 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1618,13 +1618,13 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 
 	if (issue_modify_qp && iwqp->ibqp_state > IB_QPS_RTS) {
 		if (dont_wait) {
-			if (iwqp->cm_id && iwqp->hw_tcp_state) {
+			if (iwqp->hw_tcp_state) {
 				spin_lock_irqsave(&iwqp->lock, flags);
 				iwqp->hw_tcp_state = IRDMA_TCP_STATE_CLOSED;
 				iwqp->last_aeq = IRDMA_AE_RESET_SENT;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
-				irdma_cm_disconn(iwqp);
 			}
+			irdma_cm_disconn(iwqp);
 		} else {
 			int close_timer_started;
 
-- 
1.8.3.1

