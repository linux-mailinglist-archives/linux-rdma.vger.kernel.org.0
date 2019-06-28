Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32C25A365
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfF1SWn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:22:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:53766 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1SWn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:22:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="314206011"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2019 11:22:42 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SIMfOH061165;
        Fri, 28 Jun 2019 11:22:41 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SIMdp1067979;
        Fri, 28 Jun 2019 14:22:39 -0400
Subject: [PATCH for-next v2 8/9] IB/rdmavt: Add trace for map_mr_sg
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Fri, 28 Jun 2019 14:22:39 -0400
Message-ID: <20190628182239.67786.10986.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
References: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Add trace to debug map_mr_sg handling.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/sw/rdmavt/mr.c       |    1 +
 drivers/infiniband/sw/rdmavt/trace_mr.h |   36 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 23ddc63..a6a39f0 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -642,6 +642,7 @@ int rvt_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 	mr->mr.iova = ibmr->iova;
 	mr->mr.offset = ibmr->iova - (u64)mr->mr.map[0]->segs[0].vaddr;
 	mr->mr.length = (size_t)ibmr->length;
+	trace_rvt_map_mr_sg(ibmr, sg_nents, sg_offset);
 	return ret;
 }
 
diff --git a/drivers/infiniband/sw/rdmavt/trace_mr.h b/drivers/infiniband/sw/rdmavt/trace_mr.h
index f43e477..95b8a0e 100644
--- a/drivers/infiniband/sw/rdmavt/trace_mr.h
+++ b/drivers/infiniband/sw/rdmavt/trace_mr.h
@@ -54,6 +54,8 @@
 #include <rdma/rdma_vt.h>
 #include <rdma/rdmavt_mr.h>
 
+#include "mr.h"
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM rvt_mr
 DECLARE_EVENT_CLASS(
@@ -179,6 +181,40 @@
 	TP_PROTO(struct rvt_sge *sge, struct ib_sge *isge),
 	TP_ARGS(sge, isge));
 
+TRACE_EVENT(
+	rvt_map_mr_sg,
+	TP_PROTO(struct ib_mr *ibmr, int sg_nents, unsigned int *sg_offset),
+	TP_ARGS(ibmr, sg_nents, sg_offset),
+	TP_STRUCT__entry(
+		RDI_DEV_ENTRY(ib_to_rvt(to_imr(ibmr)->mr.pd->device))
+		__field(u64, iova)
+		__field(u64, ibmr_iova)
+		__field(u64, user_base)
+		__field(u64, ibmr_length)
+		__field(int, sg_nents)
+		__field(uint, sg_offset)
+	),
+	TP_fast_assign(
+		RDI_DEV_ASSIGN(ib_to_rvt(to_imr(ibmr)->mr.pd->device))
+		__entry->ibmr_iova = ibmr->iova;
+		__entry->iova = to_imr(ibmr)->mr.iova;
+		__entry->user_base = to_imr(ibmr)->mr.user_base;
+		__entry->ibmr_length = to_imr(ibmr)->mr.length;
+		__entry->sg_nents = sg_nents;
+		__entry->sg_offset = sg_offset ? *sg_offset : 0;
+	),
+	TP_printk(
+		"[%s] ibmr_iova %llx iova %llx user_base %llx length %llx sg_nents %d sg_offset %u",
+		__get_str(dev),
+		__entry->ibmr_iova,
+		__entry->iova,
+		__entry->user_base,
+		__entry->ibmr_length,
+		__entry->sg_nents,
+		__entry->sg_offset
+	)
+);
+
 #endif /* __RVT_TRACE_MR_H */
 
 #undef TRACE_INCLUDE_PATH

