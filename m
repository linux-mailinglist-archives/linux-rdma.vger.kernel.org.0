Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4D567A89
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiGEXIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiGEXI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324F1007
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062508; x=1688598508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HsX13ASJ1D/BNbI3VCXTybuv+UArrS0tThSSv1xTcBQ=;
  b=OgGO2XYCbKuvoGOvpv5YX1W5IE++KtmJQ83Z3Y4Z5Q2zUryoHhDqICiZ
   UKX8n3JWKxBHwKD4/gkCdY0m0FehBnijldDqSxMfEWglFWduq3ReWZfkn
   jNfy7I16SLPtSWbEZ65kieXaG9j1SYvblMyALeGZL+yx3ASPuAR5TgZZy
   N3PRhmTuaL9SOz7shfvue70Mp+fbxJjrrdAZ8XwbpIH87VTe3v0tiDpET
   rYDhngoMhIE9ApW9u3nx9gsfEaeB1kTtyRUkZWDTE908aq470bLatOzA+
   X0qfm8cgadthwng3pHP5xfTSbKlPfh0yn2+OOazjGr1fjXfXPOd2/d2MN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588439"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588439"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047564"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:27 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 7/7] RDMA/irdma: Fix setting of QP context err_rq_idx_valid field
Date:   Tue,  5 Jul 2022 18:08:15 -0500
Message-Id: <20220705230815.265-8-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220705230815.265-1-shiraz.saleem@intel.com>
References: <20220705230815.265-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Setting err_rq_idx_valid field in QP context when the AE source of the
AEQE is not associated with an RQ causes the firmware flush to fail.

Set err_rq_idx_valid field in QP context only if it is associated with an
RQ. Additionally, cleanup the redundant setting of this field in
irdma_process_aeq.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 8abbd50..e041ed3 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -257,10 +257,6 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 				iwqp->last_aeq = info->ae_id;
 			spin_unlock_irqrestore(&iwqp->lock, flags);
 			ctx_info = &iwqp->ctx_info;
-			if (rdma_protocol_roce(&iwqp->iwdev->ibdev, 1))
-				ctx_info->roce_info->err_rq_idx_valid = true;
-			else
-				ctx_info->iwarp_info->err_rq_idx_valid = true;
 		} else {
 			if (info->ae_id != IRDMA_AE_CQ_OPERATION_ERROR)
 				continue;
@@ -370,16 +366,12 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		case IRDMA_AE_LCE_FUNCTION_CATASTROPHIC:
 		case IRDMA_AE_LCE_CQ_CATASTROPHIC:
 		case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
-			if (rdma_protocol_roce(&iwdev->ibdev, 1))
-				ctx_info->roce_info->err_rq_idx_valid = false;
-			else
-				ctx_info->iwarp_info->err_rq_idx_valid = false;
-			fallthrough;
 		default:
 			ibdev_err(&iwdev->ibdev, "abnormal ae_id = 0x%x bool qp=%d qp_id = %d, ae_src=%d\n",
 				  info->ae_id, info->qp, info->qp_cq_id, info->ae_src);
 			if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
-				if (!info->sq && ctx_info->roce_info->err_rq_idx_valid) {
+				ctx_info->roce_info->err_rq_idx_valid = info->rq;
+				if (info->rq) {
 					ctx_info->roce_info->err_rq_idx = info->wqe_idx;
 					irdma_sc_qp_setctx_roce(&iwqp->sc_qp, iwqp->host_ctx.va,
 								ctx_info);
@@ -388,7 +380,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 				irdma_cm_disconn(iwqp);
 				break;
 			}
-			if (!info->sq && ctx_info->iwarp_info->err_rq_idx_valid) {
+			ctx_info->iwarp_info->err_rq_idx_valid = info->rq;
+			if (info->rq) {
 				ctx_info->iwarp_info->err_rq_idx = info->wqe_idx;
 				ctx_info->tcp_info_valid = false;
 				ctx_info->iwarp_info_valid = true;
-- 
1.8.3.1

