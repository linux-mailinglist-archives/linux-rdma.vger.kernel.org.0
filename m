Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA77D46439
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFNQcl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:32:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:38873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNQcl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:32:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:32:41 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2019 09:32:40 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGWdSC060980;
        Fri, 14 Jun 2019 09:32:39 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGWcSf045035;
        Fri, 14 Jun 2019 12:32:38 -0400
Subject: [PATCH for-rc 3/7] IB/hfi1: Create inline to get extended headers
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 14 Jun 2019 12:32:38 -0400
Message-ID: <20190614163238.44927.83576.stgit@awfm-01.aw.intel.com>
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

This paves the way for another patch that reacts to a
flush sdma completion for RC.

Fixes: 81cd3891f021 ("IB/hfi1: Add support for 16B Management Packets")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/hfi.h |   31 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/rc.c  |   21 +--------------------
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index b458c21..fa45350 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -539,6 +539,37 @@ static inline void hfi1_16B_set_qpn(struct opa_16b_mgmt *mgmt,
 	mgmt->src_qpn = cpu_to_be32(src_qp & OPA_16B_MGMT_QPN_MASK);
 }
 
+/**
+ * hfi1_get_rc_ohdr - get extended header
+ * @opah - the opaheader
+ */
+static inline struct ib_other_headers *
+hfi1_get_rc_ohdr(struct hfi1_opa_header *opah)
+{
+	struct ib_other_headers *ohdr;
+	struct ib_header *hdr = NULL;
+	struct hfi1_16b_header *hdr_16b = NULL;
+
+	/* Find out where the BTH is */
+	if (opah->hdr_type == HFI1_PKT_TYPE_9B) {
+		hdr = &opah->ibh;
+		if (ib_get_lnh(hdr) == HFI1_LRH_BTH)
+			ohdr = &hdr->u.oth;
+		else
+			ohdr = &hdr->u.l.oth;
+	} else {
+		u8 l4;
+
+		hdr_16b = &opah->opah;
+		l4  = hfi1_16B_get_l4(hdr_16b);
+		if (l4 == OPA_16B_L4_IB_LOCAL)
+			ohdr = &hdr_16b->u.oth;
+		else
+			ohdr = &hdr_16b->u.l.oth;
+	}
+	return ohdr;
+}
+
 struct rvt_sge_state;
 
 /*
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index b99b22b..2a7861f 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1709,8 +1709,6 @@ void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah)
 	struct ib_other_headers *ohdr;
 	struct hfi1_qp_priv *priv = qp->priv;
 	struct rvt_swqe *wqe;
-	struct ib_header *hdr = NULL;
-	struct hfi1_16b_header *hdr_16b = NULL;
 	u32 opcode, head, tail;
 	u32 psn;
 	struct tid_rdma_request *req;
@@ -1719,24 +1717,7 @@ void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah)
 	if (!(ib_rvt_state_ops[qp->state] & RVT_SEND_OR_FLUSH_OR_RECV_OK))
 		return;
 
-	/* Find out where the BTH is */
-	if (priv->hdr_type == HFI1_PKT_TYPE_9B) {
-		hdr = &opah->ibh;
-		if (ib_get_lnh(hdr) == HFI1_LRH_BTH)
-			ohdr = &hdr->u.oth;
-		else
-			ohdr = &hdr->u.l.oth;
-	} else {
-		u8 l4;
-
-		hdr_16b = &opah->opah;
-		l4  = hfi1_16B_get_l4(hdr_16b);
-		if (l4 == OPA_16B_L4_IB_LOCAL)
-			ohdr = &hdr_16b->u.oth;
-		else
-			ohdr = &hdr_16b->u.l.oth;
-	}
-
+	ohdr = hfi1_get_rc_ohdr(opah);
 	opcode = ib_bth_get_opcode(ohdr);
 	if ((opcode >= OP(RDMA_READ_RESPONSE_FIRST) &&
 	     opcode <= OP(ATOMIC_ACKNOWLEDGE)) ||

