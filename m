Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352EA69951
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfGOQpn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 12:45:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:25464 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGOQpn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 12:45:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="169659552"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2019 09:45:42 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x6FGjf57033153;
        Mon, 15 Jul 2019 09:45:42 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x6FGjexd074286;
        Mon, 15 Jul 2019 12:45:40 -0400
Subject: [PATCH 4/6] IB/hfi1: Drop all TID RDMA READ RESP packets after
 r_next_psn
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:45:40 -0400
Message-ID: <20190715164540.74174.54702.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

When a TID sequence error occurs while receiving TID RDMA READ RESP
packets, all packets after flow->flow_state.r_next_psn should be
dropped, including those response packets for subsequent segments.

The current implementation will drop the subsequent response packets
for the segment to complete next, but may accept packets for subsequent
segments and therefore mistakenly advance the r_next_psn fields
for the corresponding software flows. This may result in failures
to complete subsequent segments after the current segment is completed.

The fix is to only use the flow pointed by req->clear_tail for checking
KDETH PSN instead of finding a flow from the request's flow array.

Fixes: b885d5be9ca1 ("IB/hfi1: Unify the software PSN check for TID RDMA READ/WRITE")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |   42 +--------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 7fcbeee..996fc2982 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -1674,34 +1674,6 @@ static struct tid_rdma_flow *find_flow_ib(struct tid_rdma_request *req,
 	return NULL;
 }
 
-static struct tid_rdma_flow *
-__find_flow_ranged(struct tid_rdma_request *req, u16 head, u16 tail,
-		   u32 psn, u16 *fidx)
-{
-	for ( ; CIRC_CNT(head, tail, MAX_FLOWS);
-	      tail = CIRC_NEXT(tail, MAX_FLOWS)) {
-		struct tid_rdma_flow *flow = &req->flows[tail];
-		u32 spsn, lpsn;
-
-		spsn = full_flow_psn(flow, flow->flow_state.spsn);
-		lpsn = full_flow_psn(flow, flow->flow_state.lpsn);
-
-		if (cmp_psn(psn, spsn) >= 0 && cmp_psn(psn, lpsn) <= 0) {
-			if (fidx)
-				*fidx = tail;
-			return flow;
-		}
-	}
-	return NULL;
-}
-
-static struct tid_rdma_flow *find_flow(struct tid_rdma_request *req,
-				       u32 psn, u16 *fidx)
-{
-	return __find_flow_ranged(req, req->setup_head, req->clear_tail, psn,
-				  fidx);
-}
-
 /* TID RDMA READ functions */
 u32 hfi1_build_tid_rdma_read_packet(struct rvt_swqe *wqe,
 				    struct ib_other_headers *ohdr, u32 *bth1,
@@ -2789,19 +2761,7 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 			 * to prevent continuous Flow Sequence errors for any
 			 * packets that could be still in the fabric.
 			 */
-			flow = find_flow(req, psn, NULL);
-			if (!flow) {
-				/*
-				 * We can't find the IB PSN matching the
-				 * received KDETH PSN. The only thing we can
-				 * do at this point is report the error to
-				 * the QP.
-				 */
-				hfi1_kern_read_tid_flow_free(qp);
-				spin_unlock(&qp->s_lock);
-				rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
-				return ret;
-			}
+			flow = &req->flows[req->clear_tail];
 			if (priv->s_flags & HFI1_R_TID_SW_PSN) {
 				diff = cmp_psn(psn,
 					       flow->flow_state.r_next_psn);

