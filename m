Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE24643B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFNQc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:32:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:48870 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNQc5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:32:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,373,1557212400"; 
   d="scan'208";a="185010380"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2019 09:32:56 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGWtkj060986;
        Fri, 14 Jun 2019 09:32:55 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGWoq1045057;
        Fri, 14 Jun 2019 12:32:51 -0400
Subject: [PATCH for-rc 5/7] IB/hfi1: Wakeup QPs orphaned on wait list after
 flush
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Fri, 14 Jun 2019 12:32:50 -0400
Message-ID: <20190614163250.44927.99792.stgit@awfm-01.aw.intel.com>
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

Once an SDMA engine is taken down due to a link failure, any waiting QPs
that do not have outstanding descriptors in the ring will stay
on the dmawait list as long as the port is down.

Since there is no timer running, they will stay there for a long time.

The fix is to wake up all iowaits linked to dmawait. The send engine
will build and post packets that get flushed back.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/sdma.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 70828de..28b66bd 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -405,6 +405,7 @@ static void sdma_flush(struct sdma_engine *sde)
 	struct sdma_txreq *txp, *txp_next;
 	LIST_HEAD(flushlist);
 	unsigned long flags;
+	uint seq;
 
 	/* flush from head to tail */
 	sdma_flush_descq(sde);
@@ -415,6 +416,22 @@ static void sdma_flush(struct sdma_engine *sde)
 	/* flush from flush list */
 	list_for_each_entry_safe(txp, txp_next, &flushlist, list)
 		complete_tx(sde, txp, SDMA_TXREQ_S_ABORTED);
+	/* wakeup QPs orphaned on the dmawait list */
+	do {
+		struct iowait *w, *nw;
+
+		seq = read_seqbegin(&sde->waitlock);
+		if (!list_empty(&sde->dmawait)) {
+			write_seqlock(&sde->waitlock);
+			list_for_each_entry_safe(w, nw, &sde->dmawait, list) {
+				if (w->wakeup) {
+					w->wakeup(w, SDMA_AVAIL_REASON);
+					list_del_init(&w->list);
+				}
+			}
+			write_sequnlock(&sde->waitlock);
+		}
+	} while (read_seqretry(&sde->waitlock, seq));
 }
 
 /*

