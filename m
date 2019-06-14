Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334F64643A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfFNQcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:32:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:38127 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNQcr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:32:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:32:47 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2019 09:32:46 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGWjEU060983;
        Fri, 14 Jun 2019 09:32:46 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGWirZ045045;
        Fri, 14 Jun 2019 12:32:44 -0400
Subject: [PATCH for-rc 4/7] IB/hfi1: Use aborts to trigger RC throttling
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Fri, 14 Jun 2019 12:32:44 -0400
Message-ID: <20190614163244.44927.82183.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
References: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

SDMA and pio flushes will cause a lot of packets to be transmitted
after a link has gone down, using a lot of CPU to retransmit
packets.

Fix for RC QPs by recognizing the flush status and:
- Forcing a timer start
- Putting the QP into a "send one" mode

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/rc.c    |   30 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/verbs.c |   10 ++++++----
 drivers/infiniband/hw/hfi1/verbs.h |    1 +
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 2a7861f..4532d3c 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1701,6 +1701,36 @@ static void reset_sending_psn(struct rvt_qp *qp, u32 psn)
 	}
 }
 
+/**
+ * hfi1_rc_verbs_aborted - handle abort status
+ * @qp: the QP
+ * @opah: the opa header
+ *
+ * This code modifies both ACK bit in BTH[2]
+ * and the s_flags to go into send one mode.
+ *
+ * This serves to throttle the send engine to only
+ * send a single packet in the likely case the
+ * a link has gone down.
+ */
+void hfi1_rc_verbs_aborted(struct rvt_qp *qp, struct hfi1_opa_header *opah)
+{
+	struct ib_other_headers *ohdr = hfi1_get_rc_ohdr(opah);
+	u8 opcode = ib_bth_get_opcode(ohdr);
+	u32 psn;
+
+	/* ignore responses */
+	if ((opcode >= OP(RDMA_READ_RESPONSE_FIRST) &&
+	     opcode <= OP(ATOMIC_ACKNOWLEDGE)) ||
+	    opcode == TID_OP(READ_RESP) ||
+	    opcode == TID_OP(WRITE_RESP))
+		return;
+
+	psn = ib_bth_get_psn(ohdr) | IB_BTH_REQ_ACK;
+	ohdr->bth[2] = cpu_to_be32(psn);
+	qp->s_flags |= RVT_S_SEND_ONE;
+}
+
 /*
  * This should be called with the QP s_lock held and interrupts disabled.
  */
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 1eb4105..1241ea6 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -638,6 +638,8 @@ static void verbs_sdma_complete(
 		struct hfi1_opa_header *hdr;
 
 		hdr = &tx->phdr.hdr;
+		if (unlikely(status == SDMA_TXREQ_S_ABORTED))
+			hfi1_rc_verbs_aborted(qp, hdr);
 		hfi1_rc_send_complete(qp, hdr);
 	}
 	spin_unlock(&qp->s_lock);
@@ -1095,15 +1097,15 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 			       &ps->s_txreq->phdr.hdr, ib_is_sc5(sc5));
 
 pio_bail:
+	spin_lock_irqsave(&qp->s_lock, flags);
 	if (qp->s_wqe) {
-		spin_lock_irqsave(&qp->s_lock, flags);
 		rvt_send_complete(qp, qp->s_wqe, wc_status);
-		spin_unlock_irqrestore(&qp->s_lock, flags);
 	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
-		spin_lock_irqsave(&qp->s_lock, flags);
+		if (unlikely(wc_status == IB_WC_GENERAL_ERR))
+			hfi1_rc_verbs_aborted(qp, &ps->s_txreq->phdr.hdr);
 		hfi1_rc_send_complete(qp, &ps->s_txreq->phdr.hdr);
-		spin_unlock_irqrestore(&qp->s_lock, flags);
 	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
 
 	ret = 0;
 
diff --git a/drivers/infiniband/hw/hfi1/verbs.h b/drivers/infiniband/hw/hfi1/verbs.h
index 7ecb8ed..ae9582d 100644
--- a/drivers/infiniband/hw/hfi1/verbs.h
+++ b/drivers/infiniband/hw/hfi1/verbs.h
@@ -416,6 +416,7 @@ void hfi1_rc_hdrerr(
 
 u8 ah_to_sc(struct ib_device *ibdev, struct rdma_ah_attr *ah_attr);
 
+void hfi1_rc_verbs_aborted(struct rvt_qp *qp, struct hfi1_opa_header *opah);
 void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah);
 
 void hfi1_ud_rcv(struct hfi1_packet *packet);

