Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD18F461
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfHOTUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 15:20:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:1770 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfHOTUy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 15:20:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 12:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="171202932"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 12:20:52 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x7FJKr7R038486;
        Thu, 15 Aug 2019 12:20:53 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x7FJKpp5106026;
        Thu, 15 Aug 2019 15:20:51 -0400
Subject: [PATCH for-rc 4/5] IB/hfi1: Add additional checks when handling TID
 RDMA WRITE DATA packet
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 15 Aug 2019 15:20:51 -0400
Message-ID: <20190815192051.105923.69979.stgit@awfm-01.aw.intel.com>
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
packets could be delivered out of order, which could cause incorrect
processing of stale packets. For stale TID RDMA WRITE DATA packets that
cause KDETH EFLAGS errors, this patch adds additional checks before
processing the packets.

Fixes: d72fe7d5008b ("IB/hfi1: Add a function to receive TID RDMA WRITE DATA packet")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 23bb249..7bccb59 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2945,8 +2945,15 @@ bool hfi1_handle_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 	 */
 	spin_lock(&qp->s_lock);
 	qpriv = qp->priv;
+	if (qpriv->r_tid_tail == HFI1_QP_WQE_INVALID ||
+	    qpriv->r_tid_tail == qpriv->r_tid_head)
+		goto unlock;
 	e = &qp->s_ack_queue[qpriv->r_tid_tail];
+	if (e->opcode != TID_OP(WRITE_REQ))
+		goto unlock;
 	req = ack_to_tid_req(e);
+	if (req->comp_seg == req->cur_seg)
+		goto unlock;
 	flow = &req->flows[req->clear_tail];
 	trace_hfi1_eflags_err_write(qp, rcv_type, rte, psn);
 	trace_hfi1_rsp_handle_kdeth_eflags(qp, psn);

