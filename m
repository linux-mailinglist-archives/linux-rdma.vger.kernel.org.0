Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88B408E6F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbhIMNdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:33:53 -0400
Received: from mail-bn8nam12on2130.outbound.protection.outlook.com ([40.107.237.130]:22881
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242642AbhIMN3t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:29:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJqZDUUy7PUHn35R3XNvGOTKf//CzdbHKHFmRoIKrMVWTkh3Fa91wczIkWoYc8DvnG/zbjunFmuqL7TiDH+hh0Rlm1V44UtD31mxBZs2BHH70noKS9HRK/ScNGH09NZH0v8B8N9o5tiEtS2LshjrXm3YKtpzzM4Aox2h4qKjofTPI11o4SxFKZeN9dAiA3pN5KMlQ6MjVXZ5ZoIS5x4fQg7zvjYLBo69OZ6F+t8naB8YAu6cFhLU9d/TXG1bCUsrfYGPAHF7QPMvWoZ/tjbzRZ6jdQJ1pJspziCvP7xsaRByc0Z1Jb7MJdFYURtHPE4bq767uf8LtEnx74oCRV4hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qzId785fVI2WA82cwYMS1wfD6SqtSAmEPbM7nvR65jc=;
 b=WEC7c2Jnh2aZDB74CHOjHH4BptslJOWu9c7RrTtkEXlJkqWEs09oI6A6kPFdGDX2rjLMHcnpjCaYs7EDdxG1EPLaZ1w8KCoYn7lClbqUHfknFmbCvvIHtCmF+7GCtCFrckwSb847kudlDkbJmAjJCmeL0qlZ1FDHETUzAj00aRnd1sesK44lgQGboVm//lXcHHOHFnBZf+SFVXMe2W9gTC2KgtwdQMkE527Pn2H60kZkLXoLE6/xk/GiqqK67ep1WoLl3iRy1bVEv+qiNPW6sNUwCNRV6DWhyg0z0H7QVIdiospWDQ08hPBMC0xmVtsIEy7+kI1IndI9war2EaOmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzId785fVI2WA82cwYMS1wfD6SqtSAmEPbM7nvR65jc=;
 b=h0EZ5wd32vPxJ0GYR0pA/EFpyWJcu2s6rpV2a0PszflII2W30in0n3SnRigNfXepq8GllWa8cBL68IcwFQraF8bHXd4mbyTdX/dF3ntA1Deju4t6FDL4nrl7/WrD4LHL2k57ECpfs6IyYF8Q8oyU+toAGbxOTTTzuZ8f70YCuAFtSpQDWs9myxDVSvuBie/JEHpdWXijXqKY7xrKXN58R1FEfgeZng805MZYBCMFaPsNFdEOVQKmVM36dwd5LaKuFx02IKZiu0tIprXWn9A1Gcp7upEEDuMk2F5dgfIFpfgpWwteFHzNlZA0sSGB4cU0+Y78Q78JW3Lo5XCW1M3l4w==
Received: from BN6PR2001CA0016.namprd20.prod.outlook.com
 (2603:10b6:404:b4::26) by BL0PR01MB4708.prod.exchangelabs.com
 (2603:10b6:208:30::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Mon, 13 Sep
 2021 13:28:32 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::b) by BN6PR2001CA0016.outlook.office365.com
 (2603:10b6:404:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:32 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSVld147117;
        Mon, 13 Sep 2021 09:28:31 -0400
Subject: [PATCH for-next 2/6] IB/hfi1: Get rid of hot path divide
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 13 Sep 2021 09:28:31 -0400
Message-ID: <20210913132831.131370.3993.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c088b009-0f50-4d55-61b8-08d976ba619e
X-MS-TrafficTypeDiagnostic: BL0PR01MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR01MB470814B5B6E4CBB900489D3EF4D99@BL0PR01MB4708.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eh4acXfgVnunQmhNIQNvt+1Sh9tAuzAzNQOtG2HwOxIY/ktszCKtb6Z5xkvtcDCvmG5/fzz2N/r8KtuRjtFUCEk970BFcUNR+vKcug8Q4SNyO6MCVAEVASRBgLtqZg84I1M1UD9WHE/i3gTCRoDk7qkjDfHfeQad0H+U1lTl5A8dlhTvglr4+OrXLK8rhxBRXX0FG2dysbbpat724kfMzqQO6mqFEM2F21mBzHwiOpBDBOmekvO7GdlWJiLQuc/WYLATUU001jM+YghWwo9FD5WE7w773r/xmlXswQ1i92whsacDYJgfDLgam8qQBTRyClDqieohyQX0oEq2z9HIfTB2gmlhMIPx3ag7bq8nRZxMmJ3VmWgEZA+Ah0QmXsZ3CORrCexH4uzUZpewvjJI7G/fm9/RgfNCi4UuGiu9dLp6hdEXn12j03ukqnB0nqRhVR6NQvPUMyhWr+/Ge1l/q1Roswyuz5gcb3ujD/BJuadpic2en0luWLGnW71O0vUJs+476TISLg7fXpmoxcG1Y18cBJqFrQIudTeOYpVzdKD3kp99yud7e8Qwz8HO74bR9FdrR+7v2IDrJF0dHyooLoKKFDjK+FpHuAb2IeYwpv95xHRJtoef4iTBuMweCV/+tmOiwwpUM5K58WmEnCtZXzXQLgQgkzgefsqjjkkS6WLDW53UtVRb0LUq61g811Lu7yqBeXG0GkigHmggFIWiJvBFPWVrBt5z+r/bDdYXqsmhboJyqq0eu1qGh/fBBCj0baznz2KPwFv1T67TyTK4jw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(26005)(70586007)(2906002)(55016002)(47076005)(83380400001)(36860700001)(82310400003)(7696005)(508600001)(7126003)(107886003)(8676002)(103116003)(86362001)(1076003)(336012)(186003)(426003)(316002)(8936002)(5660300002)(44832011)(81166007)(4326008)(36906005)(70206006)(26583001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:32.3000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c088b009-0f50-4d55-61b8-08d976ba619e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4708
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The pointer math in this statemet does a divide;
	struct hfi1_ipoib_txq *txq = &priv->txqs[napi - priv->tx_napis];

Elminate the divide by embedding the struct napi_strut in the txq and
getting the txq with a container_of() using the newly embedded napi.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |    3 +--
 drivers/infiniband/hw/hfi1/ipoib_tx.c |   35 +++++++++------------------------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 4e91b70..71b102d 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -78,6 +78,7 @@ struct hfi1_ipoib_circ_buf {
  * @tx_ring: ring of ipoib txreqs to be reaped by napi callback
  */
 struct hfi1_ipoib_txq {
+	struct napi_struct napi;
 	struct hfi1_ipoib_dev_priv *priv;
 	struct sdma_engine *sde;
 	struct list_head tx_list;
@@ -91,7 +92,6 @@ struct hfi1_ipoib_txq {
 	struct iowait wait;
 
 	atomic64_t ____cacheline_aligned_in_smp complete_txreqs;
-	struct napi_struct *napi;
 	struct hfi1_ipoib_circ_buf tx_ring;
 };
 
@@ -100,7 +100,6 @@ struct hfi1_ipoib_dev_priv {
 	struct net_device   *netdev;
 	struct ib_device    *device;
 	struct hfi1_ipoib_txq *txqs;
-	struct napi_struct *tx_napis;
 	u16 pkey;
 	u16 pkey_index;
 	u32 qkey;
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 0a5d327..053eb43 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -172,8 +172,8 @@ static void hfi1_ipoib_drain_tx_ring(struct hfi1_ipoib_txq *txq)
 
 static int hfi1_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
 {
-	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(napi->dev);
-	struct hfi1_ipoib_txq *txq = &priv->txqs[napi - priv->tx_napis];
+	struct hfi1_ipoib_txq *txq =
+		container_of(napi, struct hfi1_ipoib_txq, napi);
 	struct hfi1_ipoib_circ_buf *tx_ring = &txq->tx_ring;
 	u32 head = tx_ring->head;
 	u32 max_tx = tx_ring->max_items;
@@ -211,7 +211,7 @@ static void hfi1_ipoib_sdma_complete(struct sdma_txreq *txreq, int status)
 	tx->sdma_status = status;
 	/* see hfi1_ipoib_poll_tx_ring */
 	smp_store_release(&tx->complete, 1);
-	napi_schedule_irqoff(tx->txq->napi);
+	napi_schedule_irqoff(&tx->txq->napi);
 }
 
 static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
@@ -505,7 +505,7 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 
 	/* mark complete and kick napi tx */
 	smp_store_release(&tx->complete, 1);
-	napi_schedule(tx->txq->napi);
+	napi_schedule(&tx->txq->napi);
 
 	++dev->stats.tx_carrier_errors;
 
@@ -693,13 +693,6 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 	u32 tx_ring_size, tx_item_size;
 	int i;
 
-	priv->tx_napis = kcalloc_node(dev->num_tx_queues,
-				      sizeof(struct napi_struct),
-				      GFP_KERNEL,
-				      priv->dd->node);
-	if (!priv->tx_napis)
-		return -ENOMEM;
-
 	/*
 	 * Ring holds 1 less than tx_ring_size
 	 * Round up to next power of 2 in order to hold at least tx_queue_len
@@ -712,7 +705,7 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 				  GFP_KERNEL,
 				  priv->dd->node);
 	if (!priv->txqs)
-		goto free_tx_napis;
+		return -ENOMEM;
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct hfi1_ipoib_txq *txq = &priv->txqs[i];
@@ -749,8 +742,7 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		txq->tx_ring.max_items = tx_ring_size;
 		txq->tx_ring.shift = ilog2(tx_ring_size);
 
-		txq->napi = &priv->tx_napis[i];
-		netif_tx_napi_add(dev, txq->napi,
+		netif_tx_napi_add(dev, &txq->napi,
 				  hfi1_ipoib_poll_tx_ring,
 				  NAPI_POLL_WEIGHT);
 	}
@@ -761,16 +753,12 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 	for (i--; i >= 0; i--) {
 		struct hfi1_ipoib_txq *txq = &priv->txqs[i];
 
-		netif_napi_del(txq->napi);
+		netif_napi_del(&txq->napi);
 		kfree(txq->tx_ring.items);
 	}
 
 	kfree(priv->txqs);
 	priv->txqs = NULL;
-
-free_tx_napis:
-	kfree(priv->tx_napis);
-	priv->tx_napis = NULL;
 	return -ENOMEM;
 }
 
@@ -809,16 +797,13 @@ void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv)
 		iowait_cancel_work(&txq->wait);
 		iowait_sdma_drain(&txq->wait);
 		hfi1_ipoib_drain_tx_list(txq);
-		netif_napi_del(txq->napi);
+		netif_napi_del(&txq->napi);
 		hfi1_ipoib_drain_tx_ring(txq);
 		kfree(txq->tx_ring.items);
 	}
 
 	kfree(priv->txqs);
 	priv->txqs = NULL;
-
-	kfree(priv->tx_napis);
-	priv->tx_napis = NULL;
 }
 
 void hfi1_ipoib_napi_tx_enable(struct net_device *dev)
@@ -829,7 +814,7 @@ void hfi1_ipoib_napi_tx_enable(struct net_device *dev)
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct hfi1_ipoib_txq *txq = &priv->txqs[i];
 
-		napi_enable(txq->napi);
+		napi_enable(&txq->napi);
 	}
 }
 
@@ -841,7 +826,7 @@ void hfi1_ipoib_napi_tx_disable(struct net_device *dev)
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct hfi1_ipoib_txq *txq = &priv->txqs[i];
 
-		napi_disable(txq->napi);
+		napi_disable(&txq->napi);
 		hfi1_ipoib_drain_tx_ring(txq);
 	}
 }

