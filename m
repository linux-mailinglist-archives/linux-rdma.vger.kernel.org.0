Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FDD4659AC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 00:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhLAXTD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Dec 2021 18:19:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:3171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbhLAXTD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Dec 2021 18:19:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235311176"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="235311176"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 15:15:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="459428395"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.41.105])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 15:15:41 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/2] RDMA/irdma: Report correct WC errors
Date:   Wed,  1 Dec 2021 17:15:08 -0600
Message-Id: <20211201231509.1930-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Return IBV_WC_REM_OP_ERR for responder QP errors instead of
IBV_WC_REM_ACCESS_ERR.

Return IBV_WC_LOC_QP_OP_ERR for errors detected on the SQ with bad opcodes

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 4108dca..1bae1dc 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -146,6 +146,7 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 		qp->flush_code = FLUSH_PROT_ERR;
 		break;
 	case IRDMA_AE_AMP_BAD_QP:
+	case IRDMA_AE_WQE_UNEXPECTED_OPCODE:
 		qp->flush_code = FLUSH_LOC_QP_OP_ERR;
 		break;
 	case IRDMA_AE_AMP_BAD_STAG_KEY:
@@ -156,7 +157,6 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	case IRDMA_AE_PRIV_OPERATION_DENIED:
 	case IRDMA_AE_IB_INVALID_REQUEST:
 	case IRDMA_AE_IB_REMOTE_ACCESS_ERROR:
-	case IRDMA_AE_IB_REMOTE_OP_ERROR:
 		qp->flush_code = FLUSH_REM_ACCESS_ERR;
 		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
@@ -184,6 +184,9 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
 		qp->flush_code = FLUSH_MW_BIND_ERR;
 		break;
+	case IRDMA_AE_IB_REMOTE_OP_ERROR:
+		qp->flush_code = FLUSH_REM_OP_ERR;
+		break;
 	default:
 		qp->flush_code = FLUSH_FATAL_ERR;
 		break;
-- 
1.8.3.1

