Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE58F45D
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfHOTUs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 15:20:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:39922 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfHOTUs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 15:20:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 12:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="377186480"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 15 Aug 2019 12:20:48 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x7FJKkMX038480;
        Thu, 15 Aug 2019 12:20:46 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x7FJKjXp106016;
        Thu, 15 Aug 2019 15:20:45 -0400
Subject: [PATCH for-rc 3/5] IB/hfi1: Add additional checks when handling TID
 RDMA READ RESP packet
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 15 Aug 2019 15:20:45 -0400
Message-ID: <20190815192045.105923.59813.stgit@awfm-01.aw.intel.com>
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
processing of stale packets. For stale TID RDMA READ RESP packets that
cause KDETH EFLAGS errors, this patch adds additional checks before
processing the packets.

Fixes: 9905bf06e890 ("IB/hfi1: Add functions to receive TID RDMA READ response")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 01c8b02..23bb249 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2740,9 +2740,12 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 
 		wqe = do_rc_completion(qp, wqe, ibp);
 		if (qp->s_acked == qp->s_tail)
-			break;
+			goto s_unlock;
 	}
 
+	if (qp->s_acked == qp->s_tail)
+		goto s_unlock;
+
 	/* Handle the eflags for the request */
 	if (wqe->wr.opcode != IB_WR_TID_RDMA_READ)
 		goto s_unlock;

