Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF53408EAD
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbhIMNgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:36:18 -0400
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:65407
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242611AbhIMN3q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:29:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukw0Lomvl+oZjD5Xd0tWkXlGBm9MMi9cKwmYcXrpLdwk+nyvpzTJ+lUnpBSxhScJypr71J9Qu2/n4igC01keTvybc9ae7slG9bDY5+Czf5jRmJIi2iQBmPcb6PEMtvIfaSDuyDQFhOYyjVt6V+9h+CE5skdq8IwEhcEzKMLedMAAjdSsvh0wEHwFGK2uheiXX6nVVEQODeJzayIvDszUWe48at9KZUS9wD0gHu4bt3KmJQ4Xak7OtmShJcTalIo1pS9qSx445N43lepfdWo0RMc2FVoX1kIWjqXjDqzZ2K9Aw3nZB/3RbEXdSb89QZ1j28343hp2Fs+STvVoZcduuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gtnNN7MYW/KYbpedMrTYpuT1KuhqzmVc8W4r92+535U=;
 b=a0xVJObZIbMNLTrzeyVJc1qNc2NDM9DvH+p9wWZA5LR3CVbMrFDayOmhhBqVgEI06ChlRohVuZmZqCUIcQzC8XRPCH9Lcv1u5ix1gPd6q5Cohn5tcDBokn1Hl9Rl/d9IJEojbWk5BH5KYv2dyIOk+ZOpM3i2cb7i6oQDKeBz4/91fG/qG5zB4iEeF8oZOsqlDtplnK502RyxyCIfSkEnW/Qt0s50uSY+NqNUpXJdIl9VfG7/FkNumWwjZkEgkPJz80/2fwAq5eLHoVLgt3uHiXVhfzZvlxG8kLqgerYAl1APBGorcR+iITkokh9wWP+gdEwb5GzRgs+f8r9Sqsgtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtnNN7MYW/KYbpedMrTYpuT1KuhqzmVc8W4r92+535U=;
 b=dTMgvKGN0dvJAg5VtViw9Fj7n0EAn8a7qK9woZRj3BsayjfDdq/LVx8IbLopnuFr7KuoiYfxYSdiMhE12DEQ16+wCRSzDZuR91W7yhT0IkrtCIOJvKR1OdBGp/Wj6TdqMk/SCrA8zbkypn4N65wysYH3TF8D1TN+Kv2S13AU4qhkocp0Ou8TISkw0tyPBt11KLptKY2vdqNA18i68oEv21grDu6UzEX1vHIj2TwUmfAma8Nk0x9Qdl/DlWmh5PjybKmyBgKkdceGF7y+EIcMFnjRijyOko2tWBY3s5b5Sw2dn2SH5svxiV5FkxiFTJSjCTh302cfQZSUtPTzz3XTbA==
Received: from MWHPR20CA0013.namprd20.prod.outlook.com (2603:10b6:300:13d::23)
 by DM8PR01MB7109.prod.exchangelabs.com (2603:10b6:8:a::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15; Mon, 13 Sep 2021 13:28:28 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::63) by MWHPR20CA0013.outlook.office365.com
 (2603:10b6:300:13d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:27 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSQBf146867;
        Mon, 13 Sep 2021 09:28:26 -0400
Subject: [PATCH for-next 1/6] IB/hfi1: Remove cache and embed txreq in ring
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 13 Sep 2021 09:28:26 -0400
Message-ID: <20210913132826.131370.4397.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c51c60-e5e2-49b2-7f9c-08d976ba5eea
X-MS-TrafficTypeDiagnostic: DM8PR01MB7109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR01MB71091DEBF2E24A83F91B47FCF4D99@DM8PR01MB7109.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+ayscpl3SJVkA4BXBb2mO+sIvYbzqvJph+jHhY5jLafkLh5OqUd2E0kwWlYWPL0M5Meuzz6IeLYNYQzaU4mFUZLSGDhxYn4O12xTLJptTsc4CvOPaPL5Pl8cqq55CBeOciDos0LLs91O1AjyTQVrq+o92J6eUgWYxFx2gpofU/0/nSSsibc+n294kVwxTBnFgcbyKHqvqB2qGg0wBpyxOX2SRbaOHdN2kbx+DaEy9FDLU5SpX7XFfE6nHPwL/8wmNeDLNedluFibdsKf6qhbLxU8uM5RM+TYs3kwq8QRgErhkaaLp0ei2leV2DXbrWDy4KiLV1up+6w/Tb5KVuCwE3lbosK+DkM/8vrTbP1DzgzlkXUigZzTfqxFb8XaLi1yy3DzOCXG3Fi54Vl4vyI41nt4kPP5DY2uwHct13yO0NHiTUUIAePOxUZiLI39fVCbXDhZmf+4xWQ/dTitlmc9DfhVjHd84+1K2ha/OBwPIlyvcH+pToJaSxA42qLGdDnrcj8De/XTQAIxJrZZddTtF528+2ouwdP+BMzkzAPi4e4ewttbTP8crIAVZxcp+sjqCyuzNks/EvOh8W90jT/ivH6dzTI8MA5Cpv90xKcpwa8XNamaexoUEa13/AFj6F6ahvzx7uS/AxHW3lpzhknL+DCMyvhb3du06FRMaOlPoDdF3wpisI+kcPQhuVVCd4D65O7SVyOFvDER3A3i6YJN1AdV9OinxlPgDUyuS57yUA=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(8676002)(55016002)(2906002)(186003)(356005)(70586007)(83380400001)(47076005)(30864003)(86362001)(36860700001)(44832011)(7126003)(508600001)(316002)(103116003)(5660300002)(7696005)(8936002)(426003)(107886003)(82310400003)(1076003)(70206006)(336012)(26005)(36906005)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:27.6147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c51c60-e5e2-49b2-7f9c-08d976ba5eea
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

This patch removes kmem cache allocation and deallocation in
favor of having the ipoib_txreq in the ring.

The consumer is now the packet sending side allocating tx descriptors
from ring and the producer is the napi interrupt handling freeing
tx descriptors.

The locks are now eliminated because the napi tx lock insures a single
consumer and the napi handling insures a single producer.

The napi poll is converted to memory poll looking for items that have been
marked completed.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |   17 +--
 drivers/infiniband/hw/hfi1/ipoib_tx.c |  212 +++++++++++++++------------------
 2 files changed, 101 insertions(+), 128 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 2cff38b..4e91b70 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -45,21 +45,19 @@
 
 /**
  * struct hfi1_ipoib_circ_buf - List of items to be processed
- * @items: ring of items
+ * @items: ring of items each a power of two size
  * @head: ring head
  * @tail: ring tail
  * @max_items: max items + 1 that the ring can contain
- * @producer_lock: producer sync lock
- * @consumer_lock: consumer sync lock
+ * @shift: log2 of size for getting txreq
  */
 struct ipoib_txreq;
 struct hfi1_ipoib_circ_buf {
-	struct ipoib_txreq **items;
-	unsigned long head;
-	unsigned long tail;
-	unsigned long max_items;
-	spinlock_t producer_lock; /* head sync lock */
-	spinlock_t consumer_lock; /* tail sync lock */
+	void *items;
+	u32 head;
+	u32 tail;
+	u32 max_items;
+	u32 shift;
 };
 
 /**
@@ -102,7 +100,6 @@ struct hfi1_ipoib_dev_priv {
 	struct net_device   *netdev;
 	struct ib_device    *device;
 	struct hfi1_ipoib_txq *txqs;
-	struct kmem_cache *txreq_cache;
 	struct napi_struct *tx_napis;
 	u16 pkey;
 	u16 pkey_index;
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index e74ddbe..0a5d327 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -27,6 +27,7 @@
  * @txreq: sdma transmit request
  * @sdma_hdr: 9b ib headers
  * @sdma_status: status returned by sdma engine
+ * @complete: non-zero implies complete
  * @priv: ipoib netdev private data
  * @txq: txq on which skb was output
  * @skb: skb to send
@@ -35,6 +36,7 @@ struct ipoib_txreq {
 	struct sdma_txreq           txreq;
 	struct hfi1_sdma_header     sdma_hdr;
 	int                         sdma_status;
+	int                         complete;
 	struct hfi1_ipoib_dev_priv *priv;
 	struct hfi1_ipoib_txq      *txq;
 	struct sk_buff             *skb;
@@ -51,7 +53,13 @@ struct ipoib_txparms {
 	u8                          entropy;
 };
 
-static u64 hfi1_ipoib_txreqs(const u64 sent, const u64 completed)
+static struct ipoib_txreq *
+hfi1_txreq_from_idx(struct hfi1_ipoib_circ_buf *r, u32 idx)
+{
+	return (struct ipoib_txreq *)(r->items + (idx << r->shift));
+}
+
+static u32 hfi1_ipoib_txreqs(const u64 sent, const u64 completed)
 {
 	return sent - completed;
 }
@@ -139,51 +147,55 @@ static void hfi1_ipoib_free_tx(struct ipoib_txreq *tx, int budget)
 	}
 
 	napi_consume_skb(tx->skb, budget);
+	tx->skb = NULL;
 	sdma_txclean(priv->dd, &tx->txreq);
-	kmem_cache_free(priv->txreq_cache, tx);
 }
 
-static int hfi1_ipoib_drain_tx_ring(struct hfi1_ipoib_txq *txq, int budget)
+static void hfi1_ipoib_drain_tx_ring(struct hfi1_ipoib_txq *txq)
 {
 	struct hfi1_ipoib_circ_buf *tx_ring = &txq->tx_ring;
-	unsigned long head;
-	unsigned long tail;
-	unsigned int max_tx;
-	int work_done;
-	int tx_count;
-
-	spin_lock_bh(&tx_ring->consumer_lock);
-
-	/* Read index before reading contents at that index. */
-	head = smp_load_acquire(&tx_ring->head);
-	tail = tx_ring->tail;
-	max_tx = tx_ring->max_items;
-
-	work_done = min_t(int, CIRC_CNT(head, tail, max_tx), budget);
+	int i;
+	struct ipoib_txreq *tx;
 
-	for (tx_count = work_done; tx_count; tx_count--) {
-		hfi1_ipoib_free_tx(tx_ring->items[tail], budget);
-		tail = CIRC_NEXT(tail, max_tx);
+	for (i = 0; i < tx_ring->max_items; i++) {
+		tx = hfi1_txreq_from_idx(tx_ring, i);
+		tx->complete = 0;
+		dev_kfree_skb_any(tx->skb);
+		tx->skb = NULL;
+		sdma_txclean(txq->priv->dd, &tx->txreq);
 	}
-
-	atomic64_add(work_done, &txq->complete_txreqs);
-
-	/* Finished freeing tx items so store the tail value. */
-	smp_store_release(&tx_ring->tail, tail);
-
-	spin_unlock_bh(&tx_ring->consumer_lock);
-
-	hfi1_ipoib_check_queue_stopped(txq);
-
-	return work_done;
+	tx_ring->head = 0;
+	tx_ring->tail = 0;
+	atomic64_set(&txq->complete_txreqs, 0);
+	txq->sent_txreqs = 0;
 }
 
-static int hfi1_ipoib_process_tx_ring(struct napi_struct *napi, int budget)
+static int hfi1_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(napi->dev);
 	struct hfi1_ipoib_txq *txq = &priv->txqs[napi - priv->tx_napis];
+	struct hfi1_ipoib_circ_buf *tx_ring = &txq->tx_ring;
+	u32 head = tx_ring->head;
+	u32 max_tx = tx_ring->max_items;
+	int work_done;
+	struct ipoib_txreq *tx =  hfi1_txreq_from_idx(tx_ring, head);
 
-	int work_done = hfi1_ipoib_drain_tx_ring(txq, budget);
+	trace_hfi1_txq_poll(txq);
+	for (work_done = 0; work_done < budget; work_done++) {
+		/* See hfi1_ipoib_sdma_complete() */
+		if (!smp_load_acquire(&tx->complete))
+			break;
+		tx->complete = 0;
+		hfi1_ipoib_free_tx(tx, budget);
+		head = CIRC_NEXT(head, max_tx);
+		tx =  hfi1_txreq_from_idx(tx_ring, head);
+	}
+	atomic64_add(work_done, &txq->complete_txreqs);
+
+	/* Finished freeing tx items so store the head value. */
+	smp_store_release(&tx_ring->head, head);
+
+	hfi1_ipoib_check_queue_stopped(txq);
 
 	if (work_done < budget)
 		napi_complete_done(napi, work_done);
@@ -191,45 +203,15 @@ static int hfi1_ipoib_process_tx_ring(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static void hfi1_ipoib_add_tx(struct ipoib_txreq *tx)
-{
-	struct hfi1_ipoib_circ_buf *tx_ring = &tx->txq->tx_ring;
-	unsigned long head;
-	unsigned long tail;
-	size_t max_tx;
-
-	spin_lock(&tx_ring->producer_lock);
-
-	head = tx_ring->head;
-	tail = READ_ONCE(tx_ring->tail);
-	max_tx = tx_ring->max_items;
-
-	if (likely(CIRC_SPACE(head, tail, max_tx))) {
-		tx_ring->items[head] = tx;
-
-		/* Finish storing txreq before incrementing head. */
-		smp_store_release(&tx_ring->head, CIRC_ADD(head, 1, max_tx));
-		napi_schedule_irqoff(tx->txq->napi);
-	} else {
-		struct hfi1_ipoib_txq *txq = tx->txq;
-		struct hfi1_ipoib_dev_priv *priv = tx->priv;
-
-		/* Ring was full */
-		hfi1_ipoib_free_tx(tx, 0);
-		atomic64_inc(&txq->complete_txreqs);
-		dd_dev_dbg(priv->dd, "txq %d full.\n", txq->q_idx);
-	}
-
-	spin_unlock(&tx_ring->producer_lock);
-}
-
 static void hfi1_ipoib_sdma_complete(struct sdma_txreq *txreq, int status)
 {
 	struct ipoib_txreq *tx = container_of(txreq, struct ipoib_txreq, txreq);
 
+	trace_hfi1_txq_complete(tx->txq);
 	tx->sdma_status = status;
-
-	hfi1_ipoib_add_tx(tx);
+	/* see hfi1_ipoib_poll_tx_ring */
+	smp_store_release(&tx->complete, 1);
+	napi_schedule_irqoff(tx->txq->napi);
 }
 
 static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
@@ -385,19 +367,24 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 						      struct ipoib_txparms *txp)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	struct hfi1_ipoib_txq *txq = txp->txq;
 	struct ipoib_txreq *tx;
+	struct hfi1_ipoib_circ_buf *tx_ring;
+	u32 tail;
 	int ret;
 
-	tx = kmem_cache_alloc_node(priv->txreq_cache,
-				   GFP_ATOMIC,
-				   priv->dd->node);
-	if (unlikely(!tx))
+	if (unlikely(hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq)))
+		/* This shouldn't happen with a stopped queue */
 		return ERR_PTR(-ENOMEM);
+	tx_ring = &txq->tx_ring;
+	tail = tx_ring->tail;
+	tx = hfi1_txreq_from_idx(tx_ring, tx_ring->tail);
+	trace_hfi1_txq_alloc_tx(txq);
 
 	/* so that we can test if the sdma descriptors are there */
 	tx->txreq.num_desc = 0;
 	tx->priv = priv;
-	tx->txq = txp->txq;
+	tx->txq = txq;
 	tx->skb = skb;
 	INIT_LIST_HEAD(&tx->txreq.list);
 
@@ -405,21 +392,20 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 
 	ret = hfi1_ipoib_build_tx_desc(tx, txp);
 	if (likely(!ret)) {
-		if (txp->txq->flow.as_int != txp->flow.as_int) {
-			txp->txq->flow.tx_queue = txp->flow.tx_queue;
-			txp->txq->flow.sc5 = txp->flow.sc5;
-			txp->txq->sde =
+		if (txq->flow.as_int != txp->flow.as_int) {
+			txq->flow.tx_queue = txp->flow.tx_queue;
+			txq->flow.sc5 = txp->flow.sc5;
+			txq->sde =
 				sdma_select_engine_sc(priv->dd,
 						      txp->flow.tx_queue,
 						      txp->flow.sc5);
-			trace_hfi1_flow_switch(txp->txq);
+			trace_hfi1_flow_switch(txq);
 		}
 
 		return tx;
 	}
 
 	sdma_txclean(priv->dd, &tx->txreq);
-	kmem_cache_free(priv->txreq_cache, tx);
 
 	return ERR_PTR(ret);
 }
@@ -480,8 +466,8 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 				      struct sk_buff *skb,
 				      struct ipoib_txparms *txp)
 {
-	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 	struct hfi1_ipoib_txq *txq = txp->txq;
+	struct hfi1_ipoib_circ_buf *tx_ring;
 	struct ipoib_txreq *tx;
 	int ret;
 
@@ -499,6 +485,9 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 		return NETDEV_TX_OK;
 	}
 
+	tx_ring = &txq->tx_ring;
+	/* consume tx */
+	smp_store_release(&tx_ring->tail, CIRC_NEXT(tx_ring->tail, tx_ring->max_items));
 	ret = hfi1_ipoib_submit_tx(txq, tx);
 	if (likely(!ret)) {
 tx_ok:
@@ -514,9 +503,10 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 	if (ret == -EBUSY || ret == -ECOMM)
 		goto tx_ok;
 
-	sdma_txclean(priv->dd, &tx->txreq);
-	dev_kfree_skb_any(skb);
-	kmem_cache_free(priv->txreq_cache, tx);
+	/* mark complete and kick napi tx */
+	smp_store_release(&tx->complete, 1);
+	napi_schedule(tx->txq->napi);
+
 	++dev->stats.tx_carrier_errors;
 
 	return NETDEV_TX_OK;
@@ -527,6 +517,7 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 				    struct ipoib_txparms *txp)
 {
 	struct hfi1_ipoib_txq *txq = txp->txq;
+	struct hfi1_ipoib_circ_buf *tx_ring;
 	struct ipoib_txreq *tx;
 
 	/* Has the flow change ? */
@@ -556,6 +547,9 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 		return NETDEV_TX_OK;
 	}
 
+	tx_ring = &txq->tx_ring;
+	/* consume tx */
+	smp_store_release(&tx_ring->tail, CIRC_NEXT(tx_ring->tail, tx_ring->max_items));
 	list_add_tail(&tx->txreq.list, &txq->tx_list);
 
 	hfi1_ipoib_check_queue_depth(txq);
@@ -696,31 +690,22 @@ static void hfi1_ipoib_flush_txq(struct work_struct *work)
 int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 {
 	struct net_device *dev = priv->netdev;
-	char buf[HFI1_IPOIB_TXREQ_NAME_LEN];
-	unsigned long tx_ring_size;
+	u32 tx_ring_size, tx_item_size;
 	int i;
 
-	/*
-	 * Ring holds 1 less than tx_ring_size
-	 * Round up to next power of 2 in order to hold at least tx_queue_len
-	 */
-	tx_ring_size = roundup_pow_of_two((unsigned long)dev->tx_queue_len + 1);
-
-	snprintf(buf, sizeof(buf), "hfi1_%u_ipoib_txreq_cache", priv->dd->unit);
-	priv->txreq_cache = kmem_cache_create(buf,
-					      sizeof(struct ipoib_txreq),
-					      0,
-					      0,
-					      NULL);
-	if (!priv->txreq_cache)
-		return -ENOMEM;
-
 	priv->tx_napis = kcalloc_node(dev->num_tx_queues,
 				      sizeof(struct napi_struct),
 				      GFP_KERNEL,
 				      priv->dd->node);
 	if (!priv->tx_napis)
-		goto free_txreq_cache;
+		return -ENOMEM;
+
+	/*
+	 * Ring holds 1 less than tx_ring_size
+	 * Round up to next power of 2 in order to hold at least tx_queue_len
+	 */
+	tx_ring_size = roundup_pow_of_two(dev->tx_queue_len + 1);
+	tx_item_size = roundup_pow_of_two(sizeof(struct ipoib_txreq));
 
 	priv->txqs = kcalloc_node(dev->num_tx_queues,
 				  sizeof(struct hfi1_ipoib_txq),
@@ -756,19 +741,17 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 					     priv->dd->node);
 
 		txq->tx_ring.items =
-			kcalloc_node(tx_ring_size,
-				     sizeof(struct ipoib_txreq *),
+			kcalloc_node(tx_ring_size, tx_item_size,
 				     GFP_KERNEL, priv->dd->node);
 		if (!txq->tx_ring.items)
 			goto free_txqs;
 
-		spin_lock_init(&txq->tx_ring.producer_lock);
-		spin_lock_init(&txq->tx_ring.consumer_lock);
 		txq->tx_ring.max_items = tx_ring_size;
+		txq->tx_ring.shift = ilog2(tx_ring_size);
 
 		txq->napi = &priv->tx_napis[i];
 		netif_tx_napi_add(dev, txq->napi,
-				  hfi1_ipoib_process_tx_ring,
+				  hfi1_ipoib_poll_tx_ring,
 				  NAPI_POLL_WEIGHT);
 	}
 
@@ -788,10 +771,6 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 free_tx_napis:
 	kfree(priv->tx_napis);
 	priv->tx_napis = NULL;
-
-free_txreq_cache:
-	kmem_cache_destroy(priv->txreq_cache);
-	priv->txreq_cache = NULL;
 	return -ENOMEM;
 }
 
@@ -808,13 +787,13 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 		list_del(&txreq->list);
 		sdma_txclean(txq->priv->dd, &tx->txreq);
 		dev_kfree_skb_any(tx->skb);
-		kmem_cache_free(txq->priv->txreq_cache, tx);
+		tx->skb = NULL;
 		atomic64_inc(complete_txreqs);
 	}
 
 	if (hfi1_ipoib_used(txq))
 		dd_dev_warn(txq->priv->dd,
-			    "txq %d not empty found %llu requests\n",
+			    "txq %d not empty found %u requests\n",
 			    txq->q_idx,
 			    hfi1_ipoib_txreqs(txq->sent_txreqs,
 					      atomic64_read(complete_txreqs)));
@@ -831,7 +810,7 @@ void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv)
 		iowait_sdma_drain(&txq->wait);
 		hfi1_ipoib_drain_tx_list(txq);
 		netif_napi_del(txq->napi);
-		(void)hfi1_ipoib_drain_tx_ring(txq, txq->tx_ring.max_items);
+		hfi1_ipoib_drain_tx_ring(txq);
 		kfree(txq->tx_ring.items);
 	}
 
@@ -840,9 +819,6 @@ void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv)
 
 	kfree(priv->tx_napis);
 	priv->tx_napis = NULL;
-
-	kmem_cache_destroy(priv->txreq_cache);
-	priv->txreq_cache = NULL;
 }
 
 void hfi1_ipoib_napi_tx_enable(struct net_device *dev)
@@ -866,7 +842,7 @@ void hfi1_ipoib_napi_tx_disable(struct net_device *dev)
 		struct hfi1_ipoib_txq *txq = &priv->txqs[i];
 
 		napi_disable(txq->napi);
-		(void)hfi1_ipoib_drain_tx_ring(txq, txq->tx_ring.max_items);
+		hfi1_ipoib_drain_tx_ring(txq);
 	}
 }
 
@@ -888,9 +864,9 @@ void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
 	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
 	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
 		    txq->sent_txreqs, completed, hfi1_ipoib_used(txq));
-	dd_dev_info(priv->dd, "tx_queue_len %u max_items %lu\n",
+	dd_dev_info(priv->dd, "tx_queue_len %u max_items %u\n",
 		    dev->tx_queue_len, txq->tx_ring.max_items);
-	dd_dev_info(priv->dd, "head %lu tail %lu\n",
+	dd_dev_info(priv->dd, "head %u tail %u\n",
 		    txq->tx_ring.head, txq->tx_ring.tail);
 	dd_dev_info(priv->dd, "wait queued %u\n",
 		    !list_empty(&txq->wait.list));

