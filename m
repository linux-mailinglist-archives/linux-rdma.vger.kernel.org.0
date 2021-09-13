Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A3408E62
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbhIMNdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:33:31 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com ([40.107.243.109]:7905
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242750AbhIMNaA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:30:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW2kVev2I3ixFCkkpeRF010lofVC3fpIdu8LIeqGRgxwhVcaL+4VAP0GVumLj7CbPSWSxdOFhjldysTDXTAcgvOVU1/snlUuoY9PNx6vQh1n9bHiMOY7hhZDC42fTrlmmLACQdXuhPqcC+j4kCk7DJ3oD5VM0oDLKiOkykD6Jfu+1LS33AXGU3ya1pK8q72DEMo1YLTCpOlKt18gvj+CvK0BD0TU60JqDlFURiCxc3/iOEhFg9ntmPCXV3n6DIqLI4NKfDNkOU/dm753gbj18a1OMMi6e5bsWdsY8/oveMMf5fFcxkHFNNPmuTkloE6nom/yfZ8FP6Qq7uPwXqFt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Gywo0aLQRFh+oZ0t4VwUFyfLN/KzV7ZNJuTCFiaomao=;
 b=lQyHsldpTk70Oqx7Vk1PuvILmDE3/2boci4MNvXTcc9nZQTkgsuPsy+5klrp4vEAcBCzlJDztHQtPfBDfqh2DdLAnMPvoK9Z3/qhoGPCV4qWzOluKTihPd+2RWIXlKFefrRkvDoaCgi0ddVzWfEZI4y5ZZ35cF4OjtNIS8YNlBHCR8AOtxkDzSdCCnuo1p/VBrF4mFOwKPPyGP0xrGZv0hZuCxFFNKokldfiyOKF1IiWH0dAG4PUgXr6LA8MPLu0T8/+UHr9LeG8iX2cELnOufUVTEazSpLfBLf1Ru5eBcMGp2C0WjMJgQfDXRHtEj86KlkQ0Z9XIOR8m+e6a+ZgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gywo0aLQRFh+oZ0t4VwUFyfLN/KzV7ZNJuTCFiaomao=;
 b=jDc/tBuy3i11x2cctm8asQao6ucf5G4z3Fp/5JdLpofiSkUQlZrvcZe+s7CCmn65i7bKgLXOLWUFJYWsKfsIVhox2Ran+rs9y4A4TAywq5cw4di9sVSAdRHGuaT7HW5X2hufsWmd44WhWVczJyavNGEG3ud+iodWG0845r+T66IauMFWPtz3CNVICFJwJye1YNj2Ig74G0Y5jYTiPhYXkKjZQIQzM08w4I4Yc31G0iPd3bB+FK2k6SvLzF9qQrpSaMWJeZY89NnSkgw9Mb87/TAls5V01+G/qwK5i6SLr6fzefUysP93zpDAWD+ozh1TS3ME4lQHOwBg0py1xjX1Gw==
Received: from BN9P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::6)
 by SA1PR01MB6797.prod.exchangelabs.com (2603:10b6:806:1a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Mon, 13 Sep 2021 13:28:42 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::8b) by BN9P221CA0013.outlook.office365.com
 (2603:10b6:408:10a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:42 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSg6R147684;
        Mon, 13 Sep 2021 09:28:42 -0400
Subject: [PATCH for-next 4/6] IB/hfi1: Tune netdev xmit cachelines
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 13 Sep 2021 09:28:42 -0400
Message-ID: <20210913132842.131370.15636.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c9e75ab-3098-4d25-7926-08d976ba67da
X-MS-TrafficTypeDiagnostic: SA1PR01MB6797:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR01MB6797484C3E5F138CEF93C68EF4D99@SA1PR01MB6797.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+MngaAN7yf9Au+bZOXhog0PyatD9NACNaucKMftnK2y2YWVc8eg2kyJkk5VEWA9jV9KmDg/jm9TUO5+4p2rY6e+QUef9NXm73EYC0S0eWIk/eaymlvbTZhx3zmp+n0vXKEpCAzKXhEFbfHzmRshZGAiCJIgZJ5gwRKY4KESCz8Ofmzf0B81PlRT5w2Eq+zY8tLih1VrObzJve+UfqCnIYaTvX3ORuOt6XoGgQupTuJgpNMYRdtCOHilf1zxjZEILuZppuMgNwhHzQXzFERWQaq4NTIUBhDIYStAWdrHSzFJs+Lly2SjQOF8kWCmgs7nmusriFnaFqzkwAHiTuLTsTwYvA4xR3rBQblHuGtOIw0IPO7G0418bkvXxBczxUFfg2KNDDiTRa1aAwQDuspuQo3zmUwQcUmrMws6PfhVQzS/Pi0hw1konU7OkuFjJDMacPsoyGUonvjW5mD0uLXnHS1IKAO3jcOAqI0XbDIAFlIzkh4j3Ul2ht7GmCZPKzqg8N25G70RThhE8/rsZEqVV3L0GARDSDj2CPBoI++mN/sqG/gx/l5MN09xWT9nwqqLh/wX7r9t3XGAGvFLKQ2MmmtFYltELdkKKpubbU5PRoLN0ZgYFtgJwYwYdH4dpEEN+ahwEIaAaky2K14r0aM/nx+luHdAonoQsMuI1IK2iSWwDp5dpNbYOfovAfd5lWfIUpeDzFSqlCKBvNmohYvvcJ7YCnPKg5lCnTV4dxBRAVo=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39830400003)(136003)(396003)(346002)(376002)(46966006)(36840700001)(7696005)(2906002)(36860700001)(70586007)(44832011)(70206006)(86362001)(1076003)(426003)(336012)(107886003)(55016002)(103116003)(186003)(26005)(8676002)(30864003)(82310400003)(5660300002)(316002)(4326008)(36906005)(478600001)(8936002)(356005)(81166007)(47076005)(7126003)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:42.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9e75ab-3098-4d25-7926-08d976ba67da
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6797
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

This patch moves fields in the ring and creates a line for
the producer and the consumer.

The adds a consumer side variable that tracks the
ring avail so that the code doesn't have the read the other
cacheline to get a count for every packet. A read now only
occurs when the avail is at 0.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |   39 ++++++++++--------
 drivers/infiniband/hw/hfi1/ipoib_tx.c |   71 +++++++++++++++++++--------------
 drivers/infiniband/hw/hfi1/trace_tx.h |    8 ++--
 3 files changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 71b102d..8d9a03a 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -46,18 +46,31 @@
 /**
  * struct hfi1_ipoib_circ_buf - List of items to be processed
  * @items: ring of items each a power of two size
- * @head: ring head
- * @tail: ring tail
  * @max_items: max items + 1 that the ring can contain
  * @shift: log2 of size for getting txreq
+ * @sent_txreqs: count of txreqs posted to sdma
+ * @tail: ring tail
+ * @stops: count of stops of queue
+ * @ring_full: ring has been filled
+ * @no_desc: descriptor shortage seen
+ * @complete_txreqs: count of txreqs completed by sdma
+ * @head: ring head
  */
 struct ipoib_txreq;
 struct hfi1_ipoib_circ_buf {
 	void *items;
-	u32 head;
-	u32 tail;
 	u32 max_items;
 	u32 shift;
+	/* consumer cache line */
+	u64 ____cacheline_aligned_in_smp sent_txreqs;
+	u32 avail;
+	u32 tail;
+	atomic_t stops;
+	atomic_t ring_full;
+	atomic_t no_desc;
+	/* producer cache line */
+	atomic64_t ____cacheline_aligned_in_smp complete_txreqs;
+	u32 head;
 };
 
 /**
@@ -66,14 +79,10 @@ struct hfi1_ipoib_circ_buf {
  * @sde: sdma engine
  * @tx_list: tx request list
  * @sent_txreqs: count of txreqs posted to sdma
- * @stops: count of stops of queue
- * @ring_full: ring has been filled
- * @no_desc: descriptor shortage seen
  * @flow: tracks when list needs to be flushed for a flow change
  * @q_idx: ipoib Tx queue index
  * @pkts_sent: indicator packets have been sent from this queue
  * @wait: iowait structure
- * @complete_txreqs: count of txreqs completed by sdma
  * @napi: pointer to tx napi interface
  * @tx_ring: ring of ipoib txreqs to be reaped by napi callback
  */
@@ -82,17 +91,12 @@ struct hfi1_ipoib_txq {
 	struct hfi1_ipoib_dev_priv *priv;
 	struct sdma_engine *sde;
 	struct list_head tx_list;
-	u64 sent_txreqs;
-	atomic_t stops;
-	atomic_t ring_full;
-	atomic_t no_desc;
 	union hfi1_ipoib_flow flow;
 	u8 q_idx;
 	bool pkts_sent;
 	struct iowait wait;
 
-	atomic64_t ____cacheline_aligned_in_smp complete_txreqs;
-	struct hfi1_ipoib_circ_buf tx_ring;
+	struct hfi1_ipoib_circ_buf ____cacheline_aligned_in_smp tx_ring;
 };
 
 struct hfi1_ipoib_dev_priv {
@@ -100,13 +104,12 @@ struct hfi1_ipoib_dev_priv {
 	struct net_device   *netdev;
 	struct ib_device    *device;
 	struct hfi1_ipoib_txq *txqs;
+	const struct net_device_ops *netdev_ops;
+	struct rvt_qp *qp;
+	u32 qkey;
 	u16 pkey;
 	u16 pkey_index;
-	u32 qkey;
 	u8 port_num;
-
-	const struct net_device_ops *netdev_ops;
-	struct rvt_qp *qp;
 };
 
 /* hfi1 ipoib rdma netdev's private data structure */
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 734b91d..c3e43da 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -66,21 +66,21 @@ static u32 hfi1_ipoib_txreqs(const u64 sent, const u64 completed)
 
 static u64 hfi1_ipoib_used(struct hfi1_ipoib_txq *txq)
 {
-	return hfi1_ipoib_txreqs(txq->sent_txreqs,
-				 atomic64_read(&txq->complete_txreqs));
+	return hfi1_ipoib_txreqs(txq->tx_ring.sent_txreqs,
+				 atomic64_read(&txq->tx_ring.complete_txreqs));
 }
 
 static void hfi1_ipoib_stop_txq(struct hfi1_ipoib_txq *txq)
 {
 	trace_hfi1_txq_stop(txq);
-	if (atomic_inc_return(&txq->stops) == 1)
+	if (atomic_inc_return(&txq->tx_ring.stops) == 1)
 		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
 }
 
 static void hfi1_ipoib_wake_txq(struct hfi1_ipoib_txq *txq)
 {
 	trace_hfi1_txq_wake(txq);
-	if (atomic_dec_and_test(&txq->stops))
+	if (atomic_dec_and_test(&txq->tx_ring.stops))
 		netif_wake_subqueue(txq->priv->netdev, txq->q_idx);
 }
 
@@ -98,9 +98,9 @@ static uint hfi1_ipoib_ring_lwat(struct hfi1_ipoib_txq *txq)
 
 static void hfi1_ipoib_check_queue_depth(struct hfi1_ipoib_txq *txq)
 {
-	++txq->sent_txreqs;
+	++txq->tx_ring.sent_txreqs;
 	if (hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq) &&
-	    !atomic_xchg(&txq->ring_full, 1)) {
+	    !atomic_xchg(&txq->tx_ring.ring_full, 1)) {
 		trace_hfi1_txq_full(txq);
 		hfi1_ipoib_stop_txq(txq);
 	}
@@ -125,7 +125,7 @@ static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
 	 * to protect against ring overflow.
 	 */
 	if (hfi1_ipoib_used(txq) < hfi1_ipoib_ring_lwat(txq) &&
-	    atomic_xchg(&txq->ring_full, 0)) {
+	    atomic_xchg(&txq->tx_ring.ring_full, 0)) {
 		trace_hfi1_txq_xmit_unstopped(txq);
 		hfi1_ipoib_wake_txq(txq);
 	}
@@ -168,6 +168,7 @@ static void hfi1_ipoib_drain_tx_ring(struct hfi1_ipoib_txq *txq)
 	tx_ring->tail = 0;
 	atomic64_set(&txq->complete_txreqs, 0);
 	txq->sent_txreqs = 0;
+	tx_ring->avail = hfi1_ipoib_ring_hwat(txq);
 }
 
 static int hfi1_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
@@ -190,7 +191,7 @@ static int hfi1_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
 		head = CIRC_NEXT(head, max_tx);
 		tx =  hfi1_txreq_from_idx(tx_ring, head);
 	}
-	atomic64_add(work_done, &txq->complete_txreqs);
+	atomic64_add(work_done, &txq->tx_ring.complete_txreqs);
 
 	/* Finished freeing tx items so store the head value. */
 	smp_store_release(&tx_ring->head, head);
@@ -344,7 +345,7 @@ static void hfi1_ipoib_build_ib_tx_headers(struct ipoib_txreq *tx,
 
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	ohdr->bth[1] = cpu_to_be32(txp->dqpn);
-	ohdr->bth[2] = cpu_to_be32(mask_psn((u32)txp->txq->sent_txreqs));
+	ohdr->bth[2] = cpu_to_be32(mask_psn((u32)txp->txq->tx_ring.sent_txreqs));
 
 	/* Build the deth */
 	ohdr->u.ud.deth[0] = cpu_to_be32(priv->qkey);
@@ -369,16 +370,25 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 	struct hfi1_ipoib_txq *txq = txp->txq;
 	struct ipoib_txreq *tx;
-	struct hfi1_ipoib_circ_buf *tx_ring;
-	u32 tail;
+	struct hfi1_ipoib_circ_buf *tx_ring = &txq->tx_ring;
+	u32 tail = tx_ring->tail;
 	int ret;
 
-	if (unlikely(hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq)))
-		/* This shouldn't happen with a stopped queue */
-		return ERR_PTR(-ENOMEM);
-	tx_ring = &txq->tx_ring;
-	tail = tx_ring->tail;
-	tx = hfi1_txreq_from_idx(tx_ring, tx_ring->tail);
+	if (unlikely(!tx_ring->avail)) {
+		u32 head;
+
+		if (hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq))
+			/* This shouldn't happen with a stopped queue */
+			return ERR_PTR(-ENOMEM);
+		/* See hfi1_ipoib_poll_tx_ring() */
+		head = smp_load_acquire(&tx_ring->head);
+		tx_ring->avail =
+			min_t(u32, hfi1_ipoib_ring_hwat(txq),
+			      CIRC_CNT(head, tail, tx_ring->max_items));
+	} else {
+		tx_ring->avail--;
+	}
+	tx = hfi1_txreq_from_idx(tx_ring, tail);
 	trace_hfi1_txq_alloc_tx(txq);
 
 	/* so that we can test if the sdma descriptors are there */
@@ -639,7 +649,7 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *sde,
 		if (list_empty(&txq->wait.list)) {
 			struct hfi1_ibport *ibp = &sde->ppd->ibport_data;
 
-			if (!atomic_xchg(&txq->no_desc, 1)) {
+			if (!atomic_xchg(&txq->tx_ring.no_desc, 1)) {
 				trace_hfi1_txq_queued(txq);
 				hfi1_ipoib_stop_txq(txq);
 			}
@@ -682,7 +692,7 @@ static void hfi1_ipoib_flush_txq(struct work_struct *work)
 
 	if (likely(dev->reg_state == NETREG_REGISTERED) &&
 	    likely(!hfi1_ipoib_flush_tx_list(dev, txq)))
-		if (atomic_xchg(&txq->no_desc, 0))
+		if (atomic_xchg(&txq->tx_ring.no_desc, 0))
 			hfi1_ipoib_wake_txq(txq);
 }
 
@@ -720,10 +730,10 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		txq->priv = priv;
 		txq->sde = NULL;
 		INIT_LIST_HEAD(&txq->tx_list);
-		atomic64_set(&txq->complete_txreqs, 0);
-		atomic_set(&txq->stops, 0);
-		atomic_set(&txq->ring_full, 0);
-		atomic_set(&txq->no_desc, 0);
+		atomic64_set(&txq->tx_ring.complete_txreqs, 0);
+		atomic_set(&txq->tx_ring.stops, 0);
+		atomic_set(&txq->tx_ring.ring_full, 0);
+		atomic_set(&txq->tx_ring.no_desc, 0);
 		txq->q_idx = i;
 		txq->flow.tx_queue = 0xff;
 		txq->flow.sc5 = 0xff;
@@ -740,6 +750,7 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 
 		txq->tx_ring.max_items = tx_ring_size;
 		txq->tx_ring.shift = ilog2(tx_ring_size);
+		txq->tx_ring.avail = hfi1_ipoib_ring_hwat(txq);
 
 		netif_tx_napi_add(dev, &txq->napi,
 				  hfi1_ipoib_poll_tx_ring,
@@ -765,7 +776,7 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 {
 	struct sdma_txreq *txreq;
 	struct sdma_txreq *txreq_tmp;
-	atomic64_t *complete_txreqs = &txq->complete_txreqs;
+	atomic64_t *complete_txreqs = &txq->tx_ring.complete_txreqs;
 
 	list_for_each_entry_safe(txreq, txreq_tmp, &txq->tx_list, list) {
 		struct ipoib_txreq *tx =
@@ -782,7 +793,7 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 		dd_dev_warn(txq->priv->dd,
 			    "txq %d not empty found %u requests\n",
 			    txq->q_idx,
-			    hfi1_ipoib_txreqs(txq->sent_txreqs,
+			    hfi1_ipoib_txreqs(txq->tx_ring.sent_txreqs,
 					      atomic64_read(complete_txreqs)));
 }
 
@@ -834,20 +845,20 @@ void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 	struct hfi1_ipoib_txq *txq = &priv->txqs[q];
-	u64 completed = atomic64_read(&txq->complete_txreqs);
+	u64 completed = atomic64_read(&txq->tx_ring.complete_txreqs);
 
 	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d no_desc %d ring_full %d\n",
 		    (unsigned long long)txq, q,
 		    __netif_subqueue_stopped(dev, txq->q_idx),
-		    atomic_read(&txq->stops),
-		    atomic_read(&txq->no_desc),
-		    atomic_read(&txq->ring_full));
+		    atomic_read(&txq->tx_ring.stops),
+		    atomic_read(&txq->tx_ring.no_desc),
+		    atomic_read(&txq->tx_ring.ring_full));
 	dd_dev_info(priv->dd, "sde %llx engine %u\n",
 		    (unsigned long long)txq->sde,
 		    txq->sde ? txq->sde->this_idx : 0);
 	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
 	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
-		    txq->sent_txreqs, completed, hfi1_ipoib_used(txq));
+		    txq->tx_ring.sent_txreqs, completed, hfi1_ipoib_used(txq));
 	dd_dev_info(priv->dd, "tx_queue_len %u max_items %u\n",
 		    dev->tx_queue_len, txq->tx_ring.max_items);
 	dd_dev_info(priv->dd, "head %u tail %u\n",
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index 7318aa6..c9b1cd0 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -917,11 +917,11 @@
 		__entry->tail = txq->tx_ring.tail;
 		__entry->idx = txq->q_idx;
 		__entry->used =
-			txq->sent_txreqs -
-			atomic64_read(&txq->complete_txreqs);
+			txq->tx_ring.sent_txreqs -
+			atomic64_read(&txq->tx_ring.complete_txreqs);
 		__entry->flow = txq->flow.as_int;
-		__entry->stops = atomic_read(&txq->stops);
-		__entry->no_desc = atomic_read(&txq->no_desc);
+		__entry->stops = atomic_read(&txq->tx_ring.stops);
+		__entry->no_desc = atomic_read(&txq->tx_ring.no_desc);
 		__entry->stopped =
 		 __netif_subqueue_stopped(txq->priv->netdev, txq->q_idx);
 	),

