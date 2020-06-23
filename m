Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4B20617D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392523AbgFWUnY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 16:43:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:41134 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392518AbgFWUnX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:23 -0400
IronPort-SDR: qs+BWjUy9EWK+9eSi3JXGd0FpI3849FZslNPGFEf4TA99U+6xCEAz3EKZyED9wsiG4bTWF5O6s
 Pj32uop0MQZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="145710791"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="145710791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 13:43:24 -0700
IronPort-SDR: vAcVqFqvwzFMtoJn+/xEAOlQpwl1MDcfBAHDVDqEo6CjHH38EQ4OS9qevo3lL9hKeWkX/abZmU
 qvXMZJnGSvBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="353920760"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 23 Jun 2020 13:43:23 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 05NKhNWS057776;
        Tue, 23 Jun 2020 13:43:23 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 05NKhMhU108178;
        Tue, 23 Jun 2020 16:43:22 -0400
Subject: [PATCH for-rc 1/2] IB/hfi1: Correct -EBUSY handling in tx code
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 23 Jun 2020 16:43:22 -0400
Message-ID: <20200623204321.108092.83898.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200623204237.108092.33229.stgit@awfm-01.aw.intel.com>
References: <20200623204237.108092.33229.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

The current code mishandles -EBUSY in two ways:
- The flow change doesn't test the return from the flush
  and runs on to process the current packet racing
  with the wakeup processing
- The -EBUSY handling for a single packet inserts the
  tx into the txlist after the submit call, racing
  with the same wakeup processing

Fix the first by dropping the skb and returning NETDEV_TX_OK.

Fix the second by insuring the the list entry within the txreq
is inited when allocated.   This enables the sleep routine to
detect that the txreq has used the non-list api and queue the packet
to the txlist.

Both flaws can lead to having the flushing thread executing in
causing two threads to manipulate the txlist.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c |   35 +++++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 175290c5..76dcb56 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -369,6 +369,7 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 	tx->priv = priv;
 	tx->txq = txp->txq;
 	tx->skb = skb;
+	INIT_LIST_HEAD(&tx->txreq.list);
 
 	hfi1_ipoib_build_ib_tx_headers(tx, txp);
 
@@ -469,6 +470,7 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 
 	ret = hfi1_ipoib_submit_tx(txq, tx);
 	if (likely(!ret)) {
+tx_ok:
 		trace_sdma_output_ibhdr(tx->priv->dd,
 					&tx->sdma_hdr.hdr,
 					ib_is_sc5(txp->flow.sc5));
@@ -478,20 +480,8 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 
 	txq->pkts_sent = false;
 
-	if (ret == -EBUSY) {
-		list_add_tail(&tx->txreq.list, &txq->tx_list);
-
-		trace_sdma_output_ibhdr(tx->priv->dd,
-					&tx->sdma_hdr.hdr,
-					ib_is_sc5(txp->flow.sc5));
-		hfi1_ipoib_check_queue_depth(txq);
-		return NETDEV_TX_OK;
-	}
-
-	if (ret == -ECOMM) {
-		hfi1_ipoib_check_queue_depth(txq);
-		return NETDEV_TX_OK;
-	}
+	if (ret == -EBUSY || ret == -ECOMM)
+		goto tx_ok;
 
 	sdma_txclean(priv->dd, &tx->txreq);
 	dev_kfree_skb_any(skb);
@@ -509,9 +499,17 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 	struct ipoib_txreq *tx;
 
 	/* Has the flow change ? */
-	if (txq->flow.as_int != txp->flow.as_int)
-		(void)hfi1_ipoib_flush_tx_list(dev, txq);
-
+	if (txq->flow.as_int != txp->flow.as_int) {
+		int ret;
+
+		ret = hfi1_ipoib_flush_tx_list(dev, txq);
+		if (unlikely(ret)) {
+			if (ret == -EBUSY)
+				++dev->stats.tx_dropped;
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+	}
 	tx = hfi1_ipoib_send_dma_common(dev, skb, txp);
 	if (IS_ERR(tx)) {
 		int ret = PTR_ERR(tx);
@@ -612,6 +610,9 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *sde,
 
 		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
 
+		if (list_empty(&txreq->list))
+			/* came from non-list submit */
+			list_add_tail(&txreq->list, &txq->tx_list);
 		if (list_empty(&txq->wait.list))
 			iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
 

