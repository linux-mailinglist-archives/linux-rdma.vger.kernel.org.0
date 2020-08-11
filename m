Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89153241F68
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgHKRwj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 13:52:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:6541 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgHKRwj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Aug 2020 13:52:39 -0400
IronPort-SDR: mnWInFjpMz9PszliSvwqk68AdrEmBMidNdG54xq/qAGeem/8GIN2CgkisdCrKCWxb0yRsryuf7
 8ke7vt0vgUKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153017032"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="153017032"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 10:49:35 -0700
IronPort-SDR: JyTOtJ9Ntv2/iB6qeLHBq/st9+3jhpJzqRl8XxCk2ybVOtPgUd0XoIorLXM5R9iYUX9c5mcWke
 cKxE1dy0gTRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="308473524"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2020 10:49:35 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 07BHnX7m056643;
        Tue, 11 Aug 2020 10:49:34 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 07BHnV8d191232;
        Tue, 11 Aug 2020 13:49:32 -0400
Subject: [PATCH for-rc] IB/hfi1: Correct an interlock issue for TID RDMA
 WRITE request
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Aug 2020 13:49:31 -0400
Message-ID: <20200811174931.191210.84093.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

The following message occurs when running an AI application
with TID RDMA enabled:

hfi1 0000:7f:00.0: hfi1_0: [QP74] hfi1_tid_timeout 4084
hfi1 0000:7f:00.0: hfi1_0: [QP70] hfi1_tid_timeout 4084

The issue happens when TID RDMA WRITE request is followed by an
IB_WR_RDMA_WRITE_WITH_IMM request, the latter could be completed
first on the responder side. As a result, no ACK packet for the
latter could be sent because the TID RDMA WRITE request is still
being processed on the responder side.

When the TID RDMA WRITE request is eventually completed, the requester
will wait for the IB_WR_RDMA_WRITE_WITH_IMM request to be acknowledged.

If the next request is another TID RDMA WRITE request, no
TID RDMA WRITE DATA packet could be sent because the preceding
IB_WR_RDMA_WRITE_WITH_IMM request is not completed yet.

Consequently the IB_WR_RDMA_WRITE_WITH_IMM will be retried but
it will be ignored on the responder side because the responder
thinks it has already been completed. Eventually the retry will
be exhausted and the qp will be put into error state on the requester
side. On the responder side, the TID resource timer will eventually
expire because no TID RDMA WRITE DATA packets will be received for
the second TID RDMA WRITE request.  There is also risk of a
write-after-write memory corruption due to the issue.

Fix by adding a requester side interlock to prevent any potential
data corruption and TID RDMA protocol error.

Fixes: a0b34f75ec20 ("IB/hfi1: Add interlock between a TID RDMA request and other requests")
Cc: <stable@vger.kernel.org> # 5.4.x+
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 9af82ff..73d197e 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -3215,6 +3215,7 @@ bool hfi1_tid_rdma_wqe_interlock(struct rvt_qp *qp, struct rvt_swqe *wqe)
 	case IB_WR_ATOMIC_CMP_AND_SWP:
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
 	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
 		switch (prev->wr.opcode) {
 		case IB_WR_TID_RDMA_WRITE:
 			req = wqe_to_tid_req(prev);

