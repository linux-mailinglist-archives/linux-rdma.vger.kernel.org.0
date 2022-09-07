Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AEE5B0CF1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 21:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIGTNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIGTNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 15:13:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5652497D6C
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578017; x=1694114017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjWeA4fsSR/WCNKixitK6nIW/I7IcR5x7sb3O17bLoE=;
  b=n/ze/Pmt/ScQDp5XSZX28ZFCEfuDVBLbo8OtVnsy2uPINzHzJNjp6LNt
   sRUsNPx23UBDIWgdSrBGJC0vzDi3ntNiGt1rW4fNMEzAnopPCeWKGM12f
   5vmrIDSOjm/YcUNr52c2fQ7BYSG27BYqFdNC6yRBJZQ9Y6N1QnAnI5kbL
   pfYhNQpoikjs+Itakk4HvK56UdakrFgyDAd3ImMn4twcMaJQs5T8lm4PL
   L5P3neTRUAgDL2hsNFvB6pzWdkCro1Bvwg1PyfykNIUtBds0mzACin673
   O4yNDYXtpqmPAwx+pgVmz5LhqYbAk/zjl2D22gNv88IRvFEqqjDroTAcS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295709242"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295709242"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:13:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676339039"
Received: from sveedu-mobl.amr.corp.intel.com (HELO ssaleem-mobl1.amr.corp.intel.com) ([10.255.37.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:13:36 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/2] RDMA/irdma: Align AE id codes to correct flush code and event
Date:   Wed,  7 Sep 2022 14:13:23 -0500
Message-Id: <20220907191324.1173-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220907191324.1173-1-shiraz.saleem@intel.com>
References: <20220907191324.1173-1-shiraz.saleem@intel.com>
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

From: Sindhu-Devale <sindhu.devale@intel.com>

A number of asynchronous event (AE) ids were not aligned to the
correct flush_code and event_type. Fix these up so that the
correct IBV error and event codes are returned to application.

Also, add handling for new AE ids like IRDMA_AE_INVALID_REQUEST to
return the correct WC error code.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Sindhu-Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/defs.h  |  1 +
 drivers/infiniband/hw/irdma/hw.c    | 51 ++++++++++++++++++++++---------------
 drivers/infiniband/hw/irdma/type.h  |  1 +
 drivers/infiniband/hw/irdma/user.h  |  1 +
 drivers/infiniband/hw/irdma/utils.c |  3 +++
 drivers/infiniband/hw/irdma/verbs.c |  2 ++
 6 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index e03e030..c1906ca 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -314,6 +314,7 @@ enum irdma_cqp_op_type {
 #define IRDMA_AE_IB_REMOTE_ACCESS_ERROR					0x020d
 #define IRDMA_AE_IB_REMOTE_OP_ERROR					0x020e
 #define IRDMA_AE_WQE_LSMM_TOO_LONG					0x0220
+#define IRDMA_AE_INVALID_REQUEST					0x0223
 #define IRDMA_AE_DDP_INVALID_MSN_GAP_IN_MSN				0x0301
 #define IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER	0x0303
 #define IRDMA_AE_DDP_UBE_INVALID_DDP_VERSION				0x0304
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 4f132c6..ab24644 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -138,59 +138,68 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
 
 	switch (info->ae_id) {
-	case IRDMA_AE_AMP_UNALLOCATED_STAG:
 	case IRDMA_AE_AMP_BOUNDS_VIOLATION:
 	case IRDMA_AE_AMP_INVALID_STAG:
-		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
-		fallthrough;
+	case IRDMA_AE_AMP_RIGHTS_VIOLATION:
+	case IRDMA_AE_AMP_UNALLOCATED_STAG:
 	case IRDMA_AE_AMP_BAD_PD:
-	case IRDMA_AE_UDA_XMIT_BAD_PD:
+	case IRDMA_AE_AMP_BAD_QP:
+	case IRDMA_AE_AMP_BAD_STAG_KEY:
+	case IRDMA_AE_AMP_BAD_STAG_INDEX:
+	case IRDMA_AE_AMP_TO_WRAP:
+	case IRDMA_AE_PRIV_OPERATION_DENIED:
 		qp->flush_code = FLUSH_PROT_ERR;
+		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
-	case IRDMA_AE_AMP_BAD_QP:
+	case IRDMA_AE_UDA_XMIT_BAD_PD:
 	case IRDMA_AE_WQE_UNEXPECTED_OPCODE:
 		qp->flush_code = FLUSH_LOC_QP_OP_ERR;
+		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
+	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_SHORT:
+	case IRDMA_AE_UDA_L4LEN_INVALID:
+	case IRDMA_AE_DDP_UBE_INVALID_MO:
+	case IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER:
+		qp->flush_code = FLUSH_LOC_LEN_ERR;
+		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
 		break;
-	case IRDMA_AE_AMP_BAD_STAG_KEY:
-	case IRDMA_AE_AMP_BAD_STAG_INDEX:
-	case IRDMA_AE_AMP_TO_WRAP:
-	case IRDMA_AE_AMP_RIGHTS_VIOLATION:
 	case IRDMA_AE_AMP_INVALIDATE_NO_REMOTE_ACCESS_RIGHTS:
-	case IRDMA_AE_PRIV_OPERATION_DENIED:
-	case IRDMA_AE_IB_INVALID_REQUEST:
 	case IRDMA_AE_IB_REMOTE_ACCESS_ERROR:
 		qp->flush_code = FLUSH_REM_ACCESS_ERR;
 		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
 	case IRDMA_AE_LLP_SEGMENT_TOO_SMALL:
-	case IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER:
-	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
-	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_SHORT:
-	case IRDMA_AE_UDA_L4LEN_INVALID:
+	case IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR:
 	case IRDMA_AE_ROCE_RSP_LENGTH_ERROR:
-		qp->flush_code = FLUSH_LOC_LEN_ERR;
+	case IRDMA_AE_IB_REMOTE_OP_ERROR:
+		qp->flush_code = FLUSH_REM_OP_ERR;
+		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
 		break;
 	case IRDMA_AE_LCE_QP_CATASTROPHIC:
 		qp->flush_code = FLUSH_FATAL_ERR;
+		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
 		break;
-	case IRDMA_AE_DDP_UBE_INVALID_MO:
 	case IRDMA_AE_IB_RREQ_AND_Q1_FULL:
-	case IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR:
 		qp->flush_code = FLUSH_GENERAL_ERR;
 		break;
 	case IRDMA_AE_LLP_TOO_MANY_RETRIES:
 		qp->flush_code = FLUSH_RETRY_EXC_ERR;
+		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
 		break;
 	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
 	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
 	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
 		qp->flush_code = FLUSH_MW_BIND_ERR;
+		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
-	case IRDMA_AE_IB_REMOTE_OP_ERROR:
-		qp->flush_code = FLUSH_REM_OP_ERR;
+	case IRDMA_AE_IB_INVALID_REQUEST:
+		qp->flush_code = FLUSH_REM_INV_REQ_ERR;
+		qp->event_type = IRDMA_QP_EVENT_REQ_ERR;
 		break;
 	default:
-		qp->flush_code = FLUSH_FATAL_ERR;
+		qp->flush_code = FLUSH_GENERAL_ERR;
+		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
 		break;
 	}
 }
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 9e7b8ec..517d41a 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -98,6 +98,7 @@ enum irdma_term_mpa_errors {
 enum irdma_qp_event_type {
 	IRDMA_QP_EVENT_CATASTROPHIC,
 	IRDMA_QP_EVENT_ACCESS_ERR,
+	IRDMA_QP_EVENT_REQ_ERR,
 };
 
 enum irdma_hw_stats_index_32b {
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index ddd0ebb..2ef6192 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -103,6 +103,7 @@ enum irdma_flush_opcode {
 	FLUSH_FATAL_ERR,
 	FLUSH_RETRY_EXC_ERR,
 	FLUSH_MW_BIND_ERR,
+	FLUSH_REM_INV_REQ_ERR,
 };
 
 enum irdma_cmpl_status {
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index fdf4cc8..dac939c 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2476,6 +2476,9 @@ void irdma_ib_qp_event(struct irdma_qp *iwqp, enum irdma_qp_event_type event)
 	case IRDMA_QP_EVENT_ACCESS_ERR:
 		ibevent.event = IB_EVENT_QP_ACCESS_ERR;
 		break;
+	case IRDMA_QP_EVENT_REQ_ERR:
+		ibevent.event = IB_EVENT_QP_REQ_ERR;
+		break;
 	}
 	ibevent.device = iwqp->ibqp.device;
 	ibevent.element.qp = &iwqp->ibqp;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9b07b8a..f3925f1 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3308,6 +3308,8 @@ static enum ib_wc_status irdma_flush_err_to_ib_wc_status(enum irdma_flush_opcode
 		return IB_WC_RETRY_EXC_ERR;
 	case FLUSH_MW_BIND_ERR:
 		return IB_WC_MW_BIND_ERR;
+	case FLUSH_REM_INV_REQ_ERR:
+		return IB_WC_REM_INV_REQ_ERR;
 	case FLUSH_FATAL_ERR:
 	default:
 		return IB_WC_FATAL_ERR;
-- 
1.8.3.1

