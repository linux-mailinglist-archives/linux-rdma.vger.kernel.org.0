Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7C408E5C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbhIMNdS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:33:18 -0400
Received: from mail-bn8nam12on2124.outbound.protection.outlook.com ([40.107.237.124]:39182
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241571AbhIMNaL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:30:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtOd1WFAsXkOvKdDg76BBUtEZTxkXDL3LbJTFqIwRRFZnW9KPARoVxjuL0zBRTiQ7m9hlo/3jORE9wH7I2jv8f/6UX414ERMGfufXf7NLhuRyth+8XswXQTRMoGVdWU43iVOHIR2YDqoNb27EDYechgysB5y0fVnQpK7IfeE5XHH/6EQtBGDjpYFZuFfLLwwtab+99oZyWmosDrJ9pUx1bxiRF0gcrYb28KOl/KzNn/GWxweVQaPKGwp+nPxAHLeiY4KhiJhd6YvIC0miyGscued8n4hcY0jcaLKJ0fA90ppnL4XHwF+ASYxkJ9osSgX9RGLZuMq3ekjk0pqhe3MrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yeF8qyubKW7wuoh+cLRFOtKzzl4X7h3KTcNR2AlGHYE=;
 b=IRL8wLxs926HkzL2Y7C6AWUV0vnFjGER5Kz6XxQI7QOPx56K1hhnzFvt5YAmIyYQ6ZM9YtrIej+8SG1Dyo1Lvq7EIX8SvDvIV/Ymc2/10Jr1dx4YEAfnhcFqiuV5zb6kPdg5pGDabX9QolyM3F40O/w1b5Es/KaBoLuXVj5sU7YMZHtM3aGOZ3IGEjIk4blULg2Y7ZlYTWLIcblWXc76fT2Z9ojhLpD+OL7TZ/CqMg4pvtU+joQ4BX8yS5IYDidGhp4DQ4xlCpkejAIJtU62O0eWVAF412E6OlZIfeku1vXfBkcr03tx7//7K742COAimGvX4YTFYI/eG43N5WRsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeF8qyubKW7wuoh+cLRFOtKzzl4X7h3KTcNR2AlGHYE=;
 b=A1EHpRKYu9ezyyY4+de1Z3AaqQmSZcxzea/9pHkMctMTRFxmYw26IgIHILvLA83TH54BiTDFm4PZptuOuWRVVgRpmzn5ElYp3fUhvi+0BCGtfCmESY2NicgV1UH276iX4Be4v4J/rHWcLbmEjCSIns2MzfUiNfYtxrPwW3Ys62OsyosyrUp5F+ZoBMKxEjDRCrDNfX4RFPYgFI23mGXC7p1SQcAFylqTmI27nf9lu5nZxNnrYsf+08FksnKEo3TdVOZLyCtEWaynd2t/EBJGtABkBsD6hg7Jbc/v29pvx1+xK02gZUUFVMqP0qOFB4Qn3x4Nls4mwpHTmB4n/cr4Bw==
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by BL0PR0102MB3491.prod.exchangelabs.com (2603:10b6:207:38::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 13:28:53 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::44) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:53 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSq6U148226;
        Mon, 13 Sep 2021 09:28:52 -0400
Subject: [PATCH for-next 6/6] IB/hfi1: Add ring consumer and producers traces
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 13 Sep 2021 09:28:52 -0400
Message-ID: <20210913132852.131370.9664.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2e6ec2b-5330-4ee7-16b9-08d976ba6e11
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR0102MB349163842792E58B3190DC3CF4D99@BL0PR0102MB3491.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRuVpsGpIZ+zfQf4XkePC9hbVAD4w8CGDB5iLPoYU6pWTBRcLyhKACzPumFYcZSEejGHzOmeTDFDnIsqgyLvhJAqCecd7h9toZC0GASTaVnPRI4MovgjftVd7nj08Z6lCnmdltMumYjQLe09RHTyqOaQfUgv8vn9R3skXa5d36+1zXShvfPLBHd4WCZXCkKg37K6/+fBQzQtyiVHEXxgxgOBslD2FT4S1LdsnBS0UZBTDS4rJb3vpiWZJg8u09LKcaVp5zjEh2KgqTP8auSZYVW6RMObnjWmDsIjVDmOVxNFZ9IYjtG66ObD5np72om9ubAxZxydrsqeMiHX3ZpbjbQachjhsIZxafMz+W1CTniV5beKwRrn1wQN46iyy4KjpXoUp+rJ3Ii8BWsIrHSiFuZHr/YoCzB3a1Bal0eYw1m33/7yhXEYWYV7IkmLzuzycX8yqIx1QI4Oguik2l8LevvT9+5n3IeN2N9iUc0SLaQQX4JbRoAhy7MGsPi7oWxTCciWfKUzttz2YfUgcDzygo7xxrvD7YeGOA5b5NeOzK9HrQ6i8XqUSSKna8xZFQq9KkbOlkLioASp4fMybqENEv/40tJlxh2gVArObAUWb+OT7Uq3YALdfb5z0UiLBlsajKg9F4sp0mGHkjokha9VjuZlo+kTkdIV/FMJfmbmGHtrjf76THpQaaKe0024bYsCnZXzlDbBcdJIC4JOkdjzMFnh3divMsxvyKFl+8RLwdw=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39830400003)(346002)(376002)(396003)(46966006)(36840700001)(86362001)(26005)(36860700001)(82310400003)(7696005)(426003)(1076003)(44832011)(186003)(336012)(478600001)(47076005)(4326008)(81166007)(356005)(36906005)(5660300002)(55016002)(83380400001)(316002)(7126003)(107886003)(70586007)(70206006)(103116003)(8676002)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:53.1864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e6ec2b-5330-4ee7-16b9-08d976ba6e11
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3491
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

These traces are used to debugging ring issues.

The ipoib_txreq needed to be moved to a header file to
allow access from the trace header file.

The trace changes include:
- new producer/consumer traces
- new allocation deallocation traces
- additional fidelity for SDMA engine prints

Fixes: 4bd00b55c978 ("IB/hfi1: Add AIP tx traces")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |   21 ++++++++++-
 drivers/infiniband/hw/hfi1/ipoib_tx.c |   23 ++----------
 drivers/infiniband/hw/hfi1/trace_tx.h |   63 ++++++++++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index eb5c251..9091229 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -44,6 +44,26 @@
 };
 
 /**
+ * struct ipoib_txreq - IPOIB transmit descriptor
+ * @txreq: sdma transmit request
+ * @sdma_hdr: 9b ib headers
+ * @sdma_status: status returned by sdma engine
+ * @complete: non-zero implies complete
+ * @priv: ipoib netdev private data
+ * @txq: txq on which skb was output
+ * @skb: skb to send
+ */
+struct ipoib_txreq {
+	struct sdma_txreq           txreq;
+	struct hfi1_sdma_header     sdma_hdr;
+	int                         sdma_status;
+	int                         complete;
+	struct hfi1_ipoib_dev_priv *priv;
+	struct hfi1_ipoib_txq      *txq;
+	struct sk_buff             *skb;
+};
+
+/**
  * struct hfi1_ipoib_circ_buf - List of items to be processed
  * @items: ring of items each a power of two size
  * @max_items: max items + 1 that the ring can contain
@@ -56,7 +76,6 @@
  * @complete_txreqs: count of txreqs completed by sdma
  * @head: ring head
  */
-struct ipoib_txreq;
 struct hfi1_ipoib_circ_buf {
 	void *items;
 	u32 max_items;
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 1a7a837..d1c2cf5 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -22,26 +22,6 @@
 #define CIRC_NEXT(val, size) CIRC_ADD(val, 1, size)
 #define CIRC_PREV(val, size) CIRC_ADD(val, -1, size)
 
-/**
- * struct ipoib_txreq - IPOIB transmit descriptor
- * @txreq: sdma transmit request
- * @sdma_hdr: 9b ib headers
- * @sdma_status: status returned by sdma engine
- * @complete: non-zero implies complete
- * @priv: ipoib netdev private data
- * @txq: txq on which skb was output
- * @skb: skb to send
- */
-struct ipoib_txreq {
-	struct sdma_txreq           txreq;
-	struct hfi1_sdma_header     sdma_hdr;
-	int                         sdma_status;
-	int                         complete;
-	struct hfi1_ipoib_dev_priv *priv;
-	struct hfi1_ipoib_txq      *txq;
-	struct sk_buff             *skb;
-};
-
 struct ipoib_txparms {
 	struct hfi1_devdata        *dd;
 	struct rdma_ah_attr        *ah_attr;
@@ -187,6 +167,7 @@ static int hfi1_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
 		if (!smp_load_acquire(&tx->complete))
 			break;
 		tx->complete = 0;
+		trace_hfi1_tx_produce(tx, head);
 		hfi1_ipoib_free_tx(tx, budget);
 		head = CIRC_NEXT(head, max_tx);
 		tx =  hfi1_txreq_from_idx(tx_ring, head);
@@ -495,6 +476,7 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 	}
 
 	tx_ring = &txq->tx_ring;
+	trace_hfi1_tx_consume(tx, tx_ring->tail);
 	/* consume tx */
 	smp_store_release(&tx_ring->tail, CIRC_NEXT(tx_ring->tail, tx_ring->max_items));
 	ret = hfi1_ipoib_submit_tx(txq, tx);
@@ -557,6 +539,7 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 	}
 
 	tx_ring = &txq->tx_ring;
+	trace_hfi1_tx_consume(tx, tx_ring->tail);
 	/* consume tx */
 	smp_store_release(&tx_ring->tail, CIRC_NEXT(tx_ring->tail, tx_ring->max_items));
 	list_add_tail(&tx->txreq.list, &txq->tx_list);
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index f00696f..ed1b9e1 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -926,11 +926,13 @@
 		 __netif_subqueue_stopped(txq->priv->netdev, txq->q_idx);
 	),
 	TP_printk(/* print  */
-		"[%s] txq %llx idx %u sde %llx head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
+		"[%s] txq %llx idx %u sde %llx:%u cpu %d head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
 		__get_str(dev),
 		(unsigned long long)__entry->txq,
 		__entry->idx,
 		(unsigned long long)__entry->sde,
+		__entry->sde ? __entry->sde->this_idx : 0,
+		__entry->sde ? __entry->sde->cpu : 0,
 		__entry->head,
 		__entry->tail,
 		__entry->flow,
@@ -995,6 +997,65 @@
 	TP_ARGS(txq)
 );
 
+DECLARE_EVENT_CLASS(/* AIP  */
+	hfi1_ipoib_tx_template,
+	TP_PROTO(struct ipoib_txreq *tx, u32 idx),
+	TP_ARGS(tx, idx),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(tx->txq->priv->dd)
+		__field(struct ipoib_txreq *, tx)
+		__field(struct hfi1_ipoib_txq *, txq)
+		__field(struct sk_buff *, skb)
+		__field(ulong, idx)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(tx->txq->priv->dd);
+		__entry->tx = tx;
+		__entry->skb = tx->skb;
+		__entry->txq = tx->txq;
+		__entry->idx = idx;
+	),
+	TP_printk(/* print  */
+		"[%s] tx %llx txq %llx,%u skb %llx idx %lu",
+		__get_str(dev),
+		(unsigned long long)__entry->tx,
+		(unsigned long long)__entry->txq,
+		__entry->txq ? __entry->txq->q_idx : 0,
+		(unsigned long long)__entry->skb,
+		__entry->idx
+	)
+);
+
+DEFINE_EVENT(/* produce */
+	hfi1_ipoib_tx_template, hfi1_tx_produce,
+	TP_PROTO(struct ipoib_txreq *tx, u32 idx),
+	TP_ARGS(tx, idx)
+);
+
+DEFINE_EVENT(/* consume */
+	hfi1_ipoib_tx_template, hfi1_tx_consume,
+	TP_PROTO(struct ipoib_txreq *tx, u32 idx),
+	TP_ARGS(tx, idx)
+);
+
+DEFINE_EVENT(/* alloc_tx */
+	hfi1_ipoib_txq_template, hfi1_txq_alloc_tx,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* poll */
+	hfi1_ipoib_txq_template, hfi1_txq_poll,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* complete */
+	hfi1_ipoib_txq_template, hfi1_txq_complete,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
 #endif /* __HFI1_TRACE_TX_H */
 
 #undef TRACE_INCLUDE_PATH

