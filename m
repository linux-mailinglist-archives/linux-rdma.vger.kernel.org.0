Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E347A8F462
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfHOTVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 15:21:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:24905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfHOTVD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 15:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 12:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="260905426"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2019 12:21:00 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x7FJKx4u038489;
        Thu, 15 Aug 2019 12:20:59 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x7FJKwic106036;
        Thu, 15 Aug 2019 15:20:58 -0400
Subject: [PATCH for-rc 5/5] IB/hfi1: Drop stale TID RDMA packets that cause
 TIDErr
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 15 Aug 2019 15:20:58 -0400
Message-ID: <20190815192058.105923.72324.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
References: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

In a congested fabric with adaptive routing enabled, traces show that
packets could be delivered out of order. A stale TID RDMA data packet
could lead to TidErr if the TID entries have been released by duplicate
data packets generated from retries, and subsequently erroneously force
the qp into error state in the current implementation.

Since the payload has already been dropped by hardware, the packet can
be simply dropped and it is no longer necessary to put the qp into
error state.

Fixes: 9905bf06e890 ("IB/hfi1: Add functions to receive TID RDMA READ response")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |   47 ++-------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 7bccb59..6141f4e 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2574,18 +2574,9 @@ void hfi1_kern_read_tid_flow_free(struct rvt_qp *qp)
 	hfi1_kern_clear_hw_flow(priv->rcd, qp);
 }
 
-static bool tid_rdma_tid_err(struct hfi1_ctxtdata *rcd,
-			     struct hfi1_packet *packet, u8 rcv_type,
-			     u8 opcode)
+static bool tid_rdma_tid_err(struct hfi1_packet *packet, u8 rcv_type)
 {
 	struct rvt_qp *qp = packet->qp;
-	struct hfi1_qp_priv *qpriv = qp->priv;
-	u32 ipsn;
-	struct ib_other_headers *ohdr = packet->ohdr;
-	struct rvt_ack_entry *e;
-	struct tid_rdma_request *req;
-	struct rvt_dev_info *rdi = ib_to_rvt(qp->ibqp.device);
-	u32 i;
 
 	if (rcv_type >= RHF_RCV_TYPE_IB)
 		goto done;
@@ -2602,41 +2593,9 @@ static bool tid_rdma_tid_err(struct hfi1_ctxtdata *rcd,
 	if (rcv_type == RHF_RCV_TYPE_EAGER) {
 		hfi1_restart_rc(qp, qp->s_last_psn + 1, 1);
 		hfi1_schedule_send(qp);
-		goto done_unlock;
 	}
 
-	/*
-	 * For TID READ response, error out QP after freeing the tid
-	 * resources.
-	 */
-	if (opcode == TID_OP(READ_RESP)) {
-		ipsn = mask_psn(be32_to_cpu(ohdr->u.tid_rdma.r_rsp.verbs_psn));
-		if (cmp_psn(ipsn, qp->s_last_psn) > 0 &&
-		    cmp_psn(ipsn, qp->s_psn) < 0) {
-			hfi1_kern_read_tid_flow_free(qp);
-			spin_unlock(&qp->s_lock);
-			rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
-			goto done;
-		}
-		goto done_unlock;
-	}
-
-	/*
-	 * Error out the qp for TID RDMA WRITE
-	 */
-	hfi1_kern_clear_hw_flow(qpriv->rcd, qp);
-	for (i = 0; i < rvt_max_atomic(rdi); i++) {
-		e = &qp->s_ack_queue[i];
-		if (e->opcode == TID_OP(WRITE_REQ)) {
-			req = ack_to_tid_req(e);
-			hfi1_kern_exp_rcv_clear_all(req);
-		}
-	}
-	spin_unlock(&qp->s_lock);
-	rvt_rc_error(qp, IB_WC_LOC_LEN_ERR);
-	goto done;
-
-done_unlock:
+	/* Since no payload is delivered, just drop the packet */
 	spin_unlock(&qp->s_lock);
 done:
 	return true;
@@ -2925,7 +2884,7 @@ bool hfi1_handle_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 		if (lnh == HFI1_LRH_GRH)
 			goto r_unlock;
 
-		if (tid_rdma_tid_err(rcd, packet, rcv_type, opcode))
+		if (tid_rdma_tid_err(packet, rcv_type))
 			goto r_unlock;
 	}
 

