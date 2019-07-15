Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8A69950
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfGOQph (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 12:45:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:8894 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGOQph (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 12:45:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="167385036"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2019 09:45:36 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x6FGjZPi033149;
        Mon, 15 Jul 2019 09:45:35 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x6FGjY11074277;
        Mon, 15 Jul 2019 12:45:34 -0400
Subject: [PATCH 3/6] IB/hfi1: Field not zero-ed when allocating TID flow
 memory
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:45:34 -0400
Message-ID: <20190715164534.74174.6177.stgit@awfm-01.aw.intel.com>
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

The field flow->resync_npkts is added for TID RDMA WRITE request and
zero-ed when a TID RDMA WRITE RESP packet is received by the requester.
This field is used to rewind a request during retry in the function
hfi1_tid_rdma_restart_req() shared by both TID RDMA WRITE and TID RDMA
READ requests. Therefore, when a TID RDMA READ request is retried,
this field may not be initialized at all, which causes the retry to
start at an incorrect psn, leading to the drop of the retry request
by the responder.

This patch fixes the problem by zeroing out the field when the flow
memory is allocated.

Fixes: 838b6fd2d9ca ("IB/hfi1: TID RDMA RcvArray programming and TID allocation")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 92accca..7fcbeee 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -1620,6 +1620,7 @@ static int hfi1_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
 		flows[i].req = req;
 		flows[i].npagesets = 0;
 		flows[i].pagesets[0].mapped =  0;
+		flows[i].resync_npkts = 0;
 	}
 	req->flows = flows;
 	return 0;

