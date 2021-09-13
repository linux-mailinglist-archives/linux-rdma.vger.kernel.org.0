Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E31408E5A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhIMNdR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:33:17 -0400
Received: from mail-mw2nam10on2120.outbound.protection.outlook.com ([40.107.94.120]:31776
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242819AbhIMNaG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:30:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdbvnEwHF5X+5c/92z0zhRAJd3vgC0cS35jS3eZ/PKMje35BRTu7daPZiiShWRD/fHL5FFUU6c1jHgwnvmiYdqxH8+D1EgUTnCy6YOLbvJbyhbL42fxbyaNuPfXyqfHpEft4dIE58ItJhiU0RJS5yuFonJSegLXMeB9jBffql8SIqEpB6a/LuDQSa7+GbdxddcGzvyNuixe2WHoQvib4sNDQO+iqArNBqBLg6Lx7+wxlpHS3IK+q6J0CjZrZLRGQvnBH3Jz+WjhtCh+YwPvZM+e7RfbXW1eD132vur3VHeghuKOKBU+Wf8/bBeQJduVQzrvJR2xRYTOqTIfw1EI4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NoO4+i9amwtGx1SOyAciQ+Xvn/ADiv2xAncIe73D52U=;
 b=nTY9cMPbruuqAP8trMd4klYsbT+Z/yZzS+T0GcmaXXNzm7LNhqfUcyrSbbC4ZMh4kZx+4XGwiamq1OTX6Z87NqtMSnYgz4H6pCok/QxvyjQaAoJZqROJ55+Xt5i8NeUMAG65uUFg6woDD/xRnm2/rfsusiUs/qLYZvuo5yWgCNESmYyamwxU5aCF0K8D1MeIoo2P2+wKcw7gR+yZW1fKp/lgu3QuJ03AYp7CijkLOf1OmRRASzPdwpQFnEi7PJMFL+5KFdEF4yR3QCzSOUgIeR4+3VEAMUbLwDQC13wLes8xKXXTEjjo9KxE5bLmBwFMl9B3E1Mb6dJ4Is+DGHzziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoO4+i9amwtGx1SOyAciQ+Xvn/ADiv2xAncIe73D52U=;
 b=OooZa/+IHpD2lGmQopRzbrgwDr9LUNj2Iv7+lHbRkgF4KDykHjkYw8Lfj+c0GqL/JvuhW3wrI3gecmVaJlNn4C6XLcIetf834B8B3IfrP0Cuv35IxhntpYxEdP1A4v4u4r57k8IciSOgRk4rBPpR88Y6VDFPPgpdc9+qBIzs2QdQYyoYMIEqx58J8DCIfPFHEGKXxeq+9OTVn9/DFzlHA39fsKoraHgQmKb+gxTEzMuWPqgGZDAFT/+3mg1MVr1vEQsDXUl2FrSEBPjxb+bDVbYh0EZODr2ZpZqW/RWHYHbMTdYH8Vxf/j0IfoX78RU0vOa77dZxDQoAj5Bp/6HJew==
Received: from BN6PR13CA0044.namprd13.prod.outlook.com (2603:10b6:404:13e::30)
 by SN6PR01MB4669.prod.exchangelabs.com (2603:10b6:805:da::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.17; Mon, 13 Sep 2021 13:28:48 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::b) by BN6PR13CA0044.outlook.office365.com
 (2603:10b6:404:13e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:47 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSlEa147959;
        Mon, 13 Sep 2021 09:28:47 -0400
Subject: [PATCH for-next 5/6] IB/hfi1: Remove atomic completion count
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 13 Sep 2021 09:28:47 -0400
Message-ID: <20210913132847.131370.54250.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a699d84f-a4a8-46ae-adaf-08d976ba6af8
X-MS-TrafficTypeDiagnostic: SN6PR01MB4669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR01MB4669FBEA7D26654F21CB0BFFF4D99@SN6PR01MB4669.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqMkcKzN3YRAHqnzXpf8hJ2EfE4P/EqR+VQ7Y2lxP6f8T1dirvv0RNqiSeVcbM0iWHFR6jPgge0qu53ygjobhVfFTOzFUHCZdxUT24l0VuvnTFE3hs+HgJJ3nxeBSqiYNaZnXS+JlqrGF3Gm75rkwt0XXIkUCiwDOV9iHEsSvf+VwsNNPP+qM0iGDS+pccY+LdC/igql1W9zwlqWAmcWJ34cRX7BvrwL2wP5mRxraL4YmrVfoPrfRLJ4U+Mfh5hpLyfCe5aSqZ0QFTu611VSXvMvi7gKONbZGXh8uIPDIqMj9438EpXCU7r58O3RkuG7zZDZdoW7b5YCyk0HvUfw9WdsaD0loejXN9Qwqh+P91DIEdAAoJMrlGRa4I4CCClykDDHHp2kVyBfgyv/wj4784bpjLNg6iCrsw6v7cE2jWKWNlhUcxRLOSDgopECqPCiY7COOYEDmfpfhcCbPKcwGie+haugAA12CUgivc29EwTze+l2xeewZhpLdYABwr92XIvcIw39Uc2hD5xUkcS16vZV9B6OKuO+aj/ixNu6W0AvuADtZ0kijXFyKlyua1CuRXpAx4v4SdYSgkUsv5bWe320do1Yccm70+/gfA6vuTIBtjbut02wGIfmdqsA4b/m3FMbIc82wUwtPB7Xr0vh92pb+AUHU0mGpIwW385fNMoHT9JolBSRU+NRYplkUcVb8uUBH1jshIXL8J/Ti4RZ0g3ow9KzFNWhdKqIJSFtNpM=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39830400003)(346002)(376002)(36840700001)(46966006)(7126003)(4326008)(5660300002)(47076005)(86362001)(82310400003)(478600001)(1076003)(44832011)(107886003)(70206006)(8676002)(70586007)(2906002)(55016002)(316002)(36906005)(36860700001)(356005)(7696005)(336012)(81166007)(426003)(83380400001)(8936002)(103116003)(26005)(186003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:47.9912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a699d84f-a4a8-46ae-adaf-08d976ba6af8
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4669
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The atomic is not needed.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |    2 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c |   18 ++++++++----------
 drivers/infiniband/hw/hfi1/trace_tx.h |    2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 8d9a03a..eb5c251 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -69,7 +69,7 @@ struct hfi1_ipoib_circ_buf {
 	atomic_t ring_full;
 	atomic_t no_desc;
 	/* producer cache line */
-	atomic64_t ____cacheline_aligned_in_smp complete_txreqs;
+	u64 ____cacheline_aligned_in_smp complete_txreqs;
 	u32 head;
 };
 
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index c3e43da..1a7a837 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -67,7 +67,7 @@ static u32 hfi1_ipoib_txreqs(const u64 sent, const u64 completed)
 static u64 hfi1_ipoib_used(struct hfi1_ipoib_txq *txq)
 {
 	return hfi1_ipoib_txreqs(txq->tx_ring.sent_txreqs,
-				 atomic64_read(&txq->tx_ring.complete_txreqs));
+				 txq->tx_ring.complete_txreqs);
 }
 
 static void hfi1_ipoib_stop_txq(struct hfi1_ipoib_txq *txq)
@@ -166,8 +166,8 @@ static void hfi1_ipoib_drain_tx_ring(struct hfi1_ipoib_txq *txq)
 	}
 	tx_ring->head = 0;
 	tx_ring->tail = 0;
-	atomic64_set(&txq->complete_txreqs, 0);
-	txq->sent_txreqs = 0;
+	tx_ring->complete_txreqs = 0;
+	tx_ring->sent_txreqs = 0;
 	tx_ring->avail = hfi1_ipoib_ring_hwat(txq);
 }
 
@@ -191,7 +191,7 @@ static int hfi1_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
 		head = CIRC_NEXT(head, max_tx);
 		tx =  hfi1_txreq_from_idx(tx_ring, head);
 	}
-	atomic64_add(work_done, &txq->tx_ring.complete_txreqs);
+	tx_ring->complete_txreqs += work_done;
 
 	/* Finished freeing tx items so store the head value. */
 	smp_store_release(&tx_ring->head, head);
@@ -730,7 +730,6 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		txq->priv = priv;
 		txq->sde = NULL;
 		INIT_LIST_HEAD(&txq->tx_list);
-		atomic64_set(&txq->tx_ring.complete_txreqs, 0);
 		atomic_set(&txq->tx_ring.stops, 0);
 		atomic_set(&txq->tx_ring.ring_full, 0);
 		atomic_set(&txq->tx_ring.no_desc, 0);
@@ -776,7 +775,6 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 {
 	struct sdma_txreq *txreq;
 	struct sdma_txreq *txreq_tmp;
-	atomic64_t *complete_txreqs = &txq->tx_ring.complete_txreqs;
 
 	list_for_each_entry_safe(txreq, txreq_tmp, &txq->tx_list, list) {
 		struct ipoib_txreq *tx =
@@ -786,7 +784,7 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 		sdma_txclean(txq->priv->dd, &tx->txreq);
 		dev_kfree_skb_any(tx->skb);
 		tx->skb = NULL;
-		atomic64_inc(complete_txreqs);
+		txq->tx_ring.complete_txreqs++;
 	}
 
 	if (hfi1_ipoib_used(txq))
@@ -794,7 +792,7 @@ static void hfi1_ipoib_drain_tx_list(struct hfi1_ipoib_txq *txq)
 			    "txq %d not empty found %u requests\n",
 			    txq->q_idx,
 			    hfi1_ipoib_txreqs(txq->tx_ring.sent_txreqs,
-					      atomic64_read(complete_txreqs)));
+					      txq->tx_ring.complete_txreqs));
 }
 
 void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv)
@@ -845,7 +843,6 @@ void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 	struct hfi1_ipoib_txq *txq = &priv->txqs[q];
-	u64 completed = atomic64_read(&txq->tx_ring.complete_txreqs);
 
 	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d no_desc %d ring_full %d\n",
 		    (unsigned long long)txq, q,
@@ -858,7 +855,8 @@ void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
 		    txq->sde ? txq->sde->this_idx : 0);
 	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
 	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
-		    txq->tx_ring.sent_txreqs, completed, hfi1_ipoib_used(txq));
+		    txq->tx_ring.sent_txreqs, txq->tx_ring.complete_txreqs,
+		    hfi1_ipoib_used(txq));
 	dd_dev_info(priv->dd, "tx_queue_len %u max_items %u\n",
 		    dev->tx_queue_len, txq->tx_ring.max_items);
 	dd_dev_info(priv->dd, "head %u tail %u\n",
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index c9b1cd0..f00696f 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -918,7 +918,7 @@
 		__entry->idx = txq->q_idx;
 		__entry->used =
 			txq->tx_ring.sent_txreqs -
-			atomic64_read(&txq->tx_ring.complete_txreqs);
+			txq->tx_ring.complete_txreqs;
 		__entry->flow = txq->flow.as_int;
 		__entry->stops = atomic_read(&txq->tx_ring.stops);
 		__entry->no_desc = atomic_read(&txq->tx_ring.no_desc);

