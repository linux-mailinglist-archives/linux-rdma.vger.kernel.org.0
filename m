Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E041C3AEE
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEDNJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 09:09:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:6612 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDNJV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 09:09:21 -0400
IronPort-SDR: QMt+sXJKcNQg9193GhvysJbxmUdUbXXra+ejxhIEyQ3IO5qGiKt3XEJD+i3ujyoAzswVMANLdp
 xkokgxUvO0lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 06:09:20 -0700
IronPort-SDR: aMlgCEpDAV87RqyAefB5vJxsZH0JTXK4osIcY8UA1D5if7jChWTKxAG/H+qbzO3A6FItVWGRg1
 JW+qIKcMwTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="369086277"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2020 06:09:20 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 044D9Jfm034924;
        Mon, 4 May 2020 06:09:19 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 044D9HYg175635;
        Mon, 4 May 2020 09:09:17 -0400
Subject: [PATCH for-rc] IB/hfi1: Fix another case where pq is left on
 waitlist
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 04 May 2020 09:09:17 -0400
Message-ID: <20200504130917.175613.43231.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The commit noted below fixed a case where a pq is left on
the sdma wait list.

It however missed another case.

user_sdma_send_pkts() has two calls from hfi1_user_sdma_process_request().

If the first one fails as indicated by -EBUSY, the pq will be placed on
the waitlist as by design.

If the second call then succeeds, the pq is still on the waitlist
setting up a race with the interrupt handler if a subsequent request uses
a different SDMA engine

Fix by deleting the first call.

The use of pcount and the intent to send a short burst of packets followed
by the larger balance of packets was never correctly implemented, because
the two calls always send pcount packets no matter what.  A subsequent
patch will correct that issue.

Fixes: 9a293d1e21a6 ("IB/hfi1: Ensure pq is not left on waitlist")
Cc: <stable@vger.kernel.org>
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/user_sdma.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 13e4203..a92346e 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -589,10 +589,6 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 
 	set_comp_state(pq, cq, info.comp_idx, QUEUED, 0);
 	pq->state = SDMA_PKT_Q_ACTIVE;
-	/* Send the first N packets in the request to buy us some time */
-	ret = user_sdma_send_pkts(req, pcount);
-	if (unlikely(ret < 0 && ret != -EBUSY))
-		goto free_req;
 
 	/*
 	 * This is a somewhat blocking send implementation.

