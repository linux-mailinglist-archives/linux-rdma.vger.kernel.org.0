Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCD20617E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbgFWUnb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 16:43:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:56837 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392532AbgFWUna (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:30 -0400
IronPort-SDR: rYYwruwQeF4Sk3wdAZm5d3aGsJgas3Uq0BVb/+MWbSgtSFIkkGpUOS6kq+GhXOA56KAoMPG993
 Lmpj1rm1AORQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="209407147"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="209407147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 13:43:30 -0700
IronPort-SDR: tpoFV9lqte6gvRGBWKxqeU82cRsdpb9tTMCbrA3qnHBEdc8blN3PvDnXPtRujgvFrw2Zcehfyb
 573DmCBBl9uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="452377492"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 13:43:29 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 05NKhTJ1057781;
        Tue, 23 Jun 2020 13:43:29 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 05NKhS3h108191;
        Tue, 23 Jun 2020 16:43:28 -0400
Subject: [PATCH for-rc 2/2] IB/hfi1: Add atomic triggered sleep/wakeup
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 23 Jun 2020 16:43:28 -0400
Message-ID: <20200623204327.108092.4024.stgit@awfm-01.aw.intel.com>
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

When running iperf in a two host configuration the
following trace can occur:

[  319.728730] NETDEV WATCHDOG: ib0 (hfi1): transmit queue 0 timed out

The issue happens because the current implementation relies on the
netif txq being stopped to control the flushing of the tx list.

There are two resources that the transmit logic can
wait on and stop the txq:
- SDMA descriptors
- Ring space to hold completions

The ring space is tested on the sending side and relieved
when the ring is consumed in the napi tx reaping.

Unfortunately, that reaping can run conncurrently with the
workqueue flushing of the txlist.   If the txq is started
just before the workitem executes, the txlist will never be
flushed, leading to the txq being stuck.

Fix by:
- Adding sleep/wakeup wrappers
  * Use an atomic to control the call to the netif routines
    inside the wrappers
- Use another atomic to record ring space exhaustion
  * Only wakeup when the a ring space exhaustion has
    happened and it relieved

Add additional wrappers to clarify the ring space
resource handling.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |    6 +++
 drivers/infiniband/hw/hfi1/ipoib_tx.c |   67 +++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 185c9b0..b8c9d0a 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -67,6 +67,9 @@ struct hfi1_ipoib_circ_buf {
  * @sde: sdma engine
  * @tx_list: tx request list
  * @sent_txreqs: count of txreqs posted to sdma
+ * @stops: count of stops of queue
+ * @ring_full: ring has been filled
+ * @no_desc: descriptor shortage seen
  * @flow: tracks when list needs to be flushed for a flow change
  * @q_idx: ipoib Tx queue index
  * @pkts_sent: indicator packets have been sent from this queue
@@ -80,6 +83,9 @@ struct hfi1_ipoib_txq {
 	struct sdma_engine *sde;
 	struct list_head tx_list;
 	u64 sent_txreqs;
+	atomic_t stops;
+	atomic_t ring_full;
+	atomic_t no_desc;
 	union hfi1_ipoib_flow flow;
 	u8 q_idx;
 	bool pkts_sent;
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 76dcb56..9df292b5 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -55,23 +55,48 @@ static u64 hfi1_ipoib_txreqs(const u64 sent, const u64 completed)
 	return sent - completed;
 }
 
-static void hfi1_ipoib_check_queue_depth(struct hfi1_ipoib_txq *txq)
+static u64 hfi1_ipoib_used(struct hfi1_ipoib_txq *txq)
+{
+	return hfi1_ipoib_txreqs(txq->sent_txreqs,
+				 atomic64_read(&txq->complete_txreqs));
+}
+
+static void hfi1_ipoib_stop_txq(struct hfi1_ipoib_txq *txq)
 {
-	if (unlikely(hfi1_ipoib_txreqs(++txq->sent_txreqs,
-				       atomic64_read(&txq->complete_txreqs)) >=
-	    min_t(unsigned int, txq->priv->netdev->tx_queue_len,
-		  txq->tx_ring.max_items - 1)))
+	if (atomic_inc_return(&txq->stops) == 1)
 		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
 }
 
+static void hfi1_ipoib_wake_txq(struct hfi1_ipoib_txq *txq)
+{
+	if (atomic_dec_and_test(&txq->stops))
+		netif_wake_subqueue(txq->priv->netdev, txq->q_idx);
+}
+
+static uint hfi1_ipoib_ring_hwat(struct hfi1_ipoib_txq *txq)
+{
+	return min_t(uint, txq->priv->netdev->tx_queue_len,
+		     txq->tx_ring.max_items - 1);
+}
+
+static uint hfi1_ipoib_ring_lwat(struct hfi1_ipoib_txq *txq)
+{
+	return min_t(uint, txq->priv->netdev->tx_queue_len,
+		     txq->tx_ring.max_items) >> 1;
+}
+
+static void hfi1_ipoib_check_queue_depth(struct hfi1_ipoib_txq *txq)
+{
+	++txq->sent_txreqs;
+	if (hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq) &&
+	    !atomic_xchg(&txq->ring_full, 1))
+		hfi1_ipoib_stop_txq(txq);
+}
+
 static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
 {
 	struct net_device *dev = txq->priv->netdev;
 
-	/* If the queue is already running just return */
-	if (likely(!__netif_subqueue_stopped(dev, txq->q_idx)))
-		return;
-
 	/* If shutting down just return as queue state is irrelevant */
 	if (unlikely(dev->reg_state != NETREG_REGISTERED))
 		return;
@@ -86,11 +111,9 @@ static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
 	 * Use the minimum of the current tx_queue_len or the rings max txreqs
 	 * to protect against ring overflow.
 	 */
-	if (hfi1_ipoib_txreqs(txq->sent_txreqs,
-			      atomic64_read(&txq->complete_txreqs))
-	    < min_t(unsigned int, dev->tx_queue_len,
-		    txq->tx_ring.max_items) >> 1)
-		netif_wake_subqueue(dev, txq->q_idx);
+	if (hfi1_ipoib_used(txq) < hfi1_ipoib_ring_lwat(txq) &&
+	    atomic_xchg(&txq->ring_full, 0))
+		hfi1_ipoib_wake_txq(txq);
 }
 
 static void hfi1_ipoib_free_tx(struct ipoib_txreq *tx, int budget)
@@ -608,13 +631,14 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *sde,
 			return -EAGAIN;
 		}
 
-		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
-
 		if (list_empty(&txreq->list))
 			/* came from non-list submit */
 			list_add_tail(&txreq->list, &txq->tx_list);
-		if (list_empty(&txq->wait.list))
+		if (list_empty(&txq->wait.list)) {
+			if (!atomic_xchg(&txq->no_desc, 1))
+				hfi1_ipoib_stop_txq(txq);
 			iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
+		}
 
 		write_sequnlock(&sde->waitlock);
 		return -EBUSY;
@@ -649,9 +673,9 @@ static void hfi1_ipoib_flush_txq(struct work_struct *work)
 	struct net_device *dev = txq->priv->netdev;
 
 	if (likely(dev->reg_state == NETREG_REGISTERED) &&
-	    likely(__netif_subqueue_stopped(dev, txq->q_idx)) &&
 	    likely(!hfi1_ipoib_flush_tx_list(dev, txq)))
-		netif_wake_subqueue(dev, txq->q_idx);
+		if (atomic_xchg(&txq->no_desc, 0))
+			hfi1_ipoib_wake_txq(txq);
 }
 
 int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
@@ -705,6 +729,9 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		txq->sde = NULL;
 		INIT_LIST_HEAD(&txq->tx_list);
 		atomic64_set(&txq->complete_txreqs, 0);
+		atomic_set(&txq->stops, 0);
+		atomic_set(&txq->ring_full, 0);
+		atomic_set(&txq->no_desc, 0);
 		txq->q_idx = i;
 		txq->flow.tx_queue = 0xff;
 		txq->flow.sc5 = 0xff;
@@ -770,7 +797,7 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 		atomic64_inc(complete_txreqs);
 	}
 
-	if (hfi1_ipoib_txreqs(txq->sent_txreqs, atomic64_read(complete_txreqs)))
+	if (hfi1_ipoib_used(txq))
 		dd_dev_warn(txq->priv->dd,
 			    "txq %d not empty found %llu requests\n",
 			    txq->q_idx,

