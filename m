Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6169952
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfGOQpt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 12:45:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:30287 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGOQps (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 12:45:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="168996016"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2019 09:45:48 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x6FGjlik033159;
        Mon, 15 Jul 2019 09:45:48 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x6FGjkS1074296;
        Mon, 15 Jul 2019 12:45:46 -0400
Subject: [PATCH 5/6] IB/hfi1: Do not update hcrc for a KDETH packet during
 fault injection
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:45:46 -0400
Message-ID: <20190715164546.74174.99296.stgit@awfm-01.aw.intel.com>
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

When a KDETH packet is subject to fault injection during transmission,
HCRC is supposed to be omitted from the packet so that the hardware on
the receiver side would drop the packet. When creating pbc, the
PbcInsertHcrc field is set to be PBC_IHCRC_NONE if the KDETH packet is
subject to fault injection, but overwritten with PBC_IHCRC_LKDETH when
update_hcrc() is called later.

This problem is fixed by not calling update_hcrc() when the packet is
subject to fault injection.

Fixes: 6b6cf9357f78 ("IB/hfi1: Set PbcInsertHcrc for TID RDMA packets")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/verbs.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index c4b243f..f4ca436 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -873,16 +873,17 @@ int hfi1_verbs_send_dma(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 			else
 				pbc |= (ib_is_sc5(sc5) << PBC_DC_INFO_SHIFT);
 
-			if (unlikely(hfi1_dbg_should_fault_tx(qp, ps->opcode)))
-				pbc = hfi1_fault_tx(qp, ps->opcode, pbc);
 			pbc = create_pbc(ppd,
 					 pbc,
 					 qp->srate_mbps,
 					 vl,
 					 plen);
 
-			/* Update HCRC based on packet opcode */
-			pbc = update_hcrc(ps->opcode, pbc);
+			if (unlikely(hfi1_dbg_should_fault_tx(qp, ps->opcode)))
+				pbc = hfi1_fault_tx(qp, ps->opcode, pbc);
+			else
+				/* Update HCRC based on packet opcode */
+				pbc = update_hcrc(ps->opcode, pbc);
 		}
 		tx->wqe = qp->s_wqe;
 		ret = build_verbs_tx_desc(tx->sde, len, tx, ahg_info, pbc);
@@ -1029,12 +1030,12 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 		else
 			pbc |= (ib_is_sc5(sc5) << PBC_DC_INFO_SHIFT);
 
+		pbc = create_pbc(ppd, pbc, qp->srate_mbps, vl, plen);
 		if (unlikely(hfi1_dbg_should_fault_tx(qp, ps->opcode)))
 			pbc = hfi1_fault_tx(qp, ps->opcode, pbc);
-		pbc = create_pbc(ppd, pbc, qp->srate_mbps, vl, plen);
-
-		/* Update HCRC based on packet opcode */
-		pbc = update_hcrc(ps->opcode, pbc);
+		else
+			/* Update HCRC based on packet opcode */
+			pbc = update_hcrc(ps->opcode, pbc);
 	}
 	if (cb)
 		iowait_pio_inc(&priv->s_iowait);

