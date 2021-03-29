Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25F34D1E7
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhC2NzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:10 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:33857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231934AbhC2NzE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjs2Pf9o6oLKx5oPkhcFL7zjQgiNfBH36nfFPiyYVR8mYKfVf3GDjYsEFuFRFFoh4Rz8bCkuk0BAPCEO15KwhMWlrZGaAAZN+ISsRlGmMX8fNKR6VLQu7U0k6mKFj17FambVnu/O0cR3tFJ5kH9AzhCs3LaK3rMG2UcSSfFjdCbn1Nbo5FKI9f6XtqNArMLPktwIr5mioPb7bthHbTSg8i8F+jWKPgtO6FgvsCNrlTNrjde6XjCeaMuQGOYiWBukvNK3hd/qKO1nLu3N3Gvdq1JD9nkXyWrI6cbq/jRhAAILGIUiHhKFBMKs/mB0X+KW0xy1Pb5FIjRGMjmwttEICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6sW7eHePmpg0qDS0MGA5Fe22kM2wRiLX5hkpdvX0z8=;
 b=WKlhAtMzhjY8Vrwv2RelAJ4LWeb9ZbqU0LkNMTcDHNZgtIRDz2q2xfszEbJCGoj79WkVyRZ4vBenhp7R3zpQ5hKxofsJXGgvvihRMXVJRdTT8Ja2GAFMpzh+AAScEM8zOX/z5qKIrKlje0PzHHCX07s3R3Aukxt8HFdRSZ9y/94xfsEGCe2ZRMgc3aC5FBkhzCtfl0GBTiAfWB6PndHuArznnhaFPBSTp8QycAQjE1l4wtVkCDDazZAvYzztoUTIOUe2insGnT9vyslChUy8UklYF9jJkZ4KGVYCEFmUK5GbwrVdmn328zaeffukTlEddr6XMpWf2AXN29AKvLSDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6sW7eHePmpg0qDS0MGA5Fe22kM2wRiLX5hkpdvX0z8=;
 b=R+xuZ32M1jOlFp6PjhnPW5BX1yLgCehyUEBCJ2Wfuc3aEW2DrDMF/3rEOm6HePVfOXtIhBI5LEefKE+mcPZ3sFBtr+dCDbCEXHezZ8gR3X6MVRslpSJPT1Rjv0u8q43F2iQbbyM4IvwDUxBGMnkz2bHpGjX3RujEicJDoYBD0TC7AgohEnuFL0uZG88Hv+uMWFMdTMtzK12/SY9bFpRF00/AJ1B21qrmBcdfQHIOwo0RXOMbykvGyQyNxk9B8KWx01B6SVA718+wROjuQTGPF1kKQs4Vu1sX8/O0GB4D673XGpkaSGKojmkQ21LrqxgruOgBx2Ws0/JLFXdqXSKR0w==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:55:02 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:02 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 03/10] IB/hfi1: Correct oversized ring allocation
Date:   Mon, 29 Mar 2021 09:54:09 -0400
Message-Id: <1617026056-50483-4-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942c25d7-00d4-4680-6097-08d8f2ba3ffd
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6618F5A0A6F8DE5E89E9B7F2F47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsJ3Aqfl9NdlRLpyFNU7jXG5bRC2EdNh+nzAXwBzfULkWOIww+h5ewg8t+ZTUoG4uB4exlO3rByvoNkx797UAQNGoFpQ311Z8ExSpVYJb0hkVoew7W6SHtJJqbu2Q6A4gqoz4Z7fpDxZ2pJbpVqTQ90DIdPJc304ISaOuZmalkMaQwR7lgi0G+0geKXndQy/+vCw2REK+GYsQQ/M0LbxdjfBBa01mqkOT15DzbeH4eGwwozoFIFEiH2OSglSLm3DdDPRxaUHOXKRExQl6ouKnvcePClh+BhSB8ZCtKJKBwgV/aiU60kI0IrALTv6DewfjFNFS23UVCmnIi6hjG70b0qU00g97/p3eCFfMc9Of49JQVUBJRPr8gvServWT7VYq+MTOZXsN4OE6qG1tpp4BXY0nY4ysjiL88goYdxU1+SlAOQBWNelQQ5fJ3ClR6jFwHhogh4YBCWyyfHcgRJs8cbhObtjxe7gaqIAjhnif1ZJBJ17V+Qwn6/h0LV0uqz1c+254EF+YI18OMwBAJ14A2rGrgfW0DTuTrN69VtfsqiiLrG/Vz2b3hX0Px1ROGLdQJWzH71K/0xMSFdP6nBG0AdQfeNeifJQYI1hcWl7C2Z1LwnhUJpdtszGwQV+2gSyiuX4lR11cVS54XrvOKGh2d4uH53XdBpxuB9JAsE+P+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(54906003)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(9686003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bZq3TuEPAmKt37n1QAWduu0US0IZ4fBICmY7zQ/iVwUotJdhD32GIqjZfT6/?=
 =?us-ascii?Q?8bdDaNJ7xYt5HTG3XbuXlbPOiDwWEnayCIENlVFdokY5QPxvpMII+MatNDdi?=
 =?us-ascii?Q?cHnLX0FXrBCZzUlS7a2yu9vn+oxlV7/G0TvarIxKShH+3K67AGb5iRn6fEZY?=
 =?us-ascii?Q?Fck1Be4vkp1kl9IjEF20Uuq+hhZX9iMGOX3z9QkJCKppxSagJtzJWZOzSKu2?=
 =?us-ascii?Q?573gcqZu7Fwpy6jpP4EdiM3DDyVm4p1CYmADSSEf74Ib5mmll4ud+/RphpzJ?=
 =?us-ascii?Q?LJeXKmQR+XKDw+Y8EHQ3bmocAIyoAfHYTxMrCf/wWwRvtP6Hf8c6LI/R0Tdn?=
 =?us-ascii?Q?ROQyreHCCFltwDEGwpyr8qYqKbjz7xSSmARY6f+eyWzy0ceREU1hUGbxiNrH?=
 =?us-ascii?Q?GaOr3p+/GU2oeDFMSdWTQ9iUwj2Q4a3ezFPFzCgEe9f4OH2sonHp3jWAms5w?=
 =?us-ascii?Q?aKGb5l3HWvY0HFYxB0QYsVHK/KuK6A7j/xz6+VzLCsc4M/olyQAPHkZ/JGGI?=
 =?us-ascii?Q?oXCr06TvW/Em0LpbLqVmZWmd+XkzH98XS0lYhGu3UtqsK4aJLVbgBQZhu8H/?=
 =?us-ascii?Q?qJsPq8RgwaU/d8QVlbSpIqha8qHn43KgejzUKxjMBV1EZkh45WM8yVRM2b+W?=
 =?us-ascii?Q?W91jHbqm6ilVdP43jqShoMeZM0AazD9d58rhqvkVMOvbVMDitmPr/uq0pWfv?=
 =?us-ascii?Q?kwnbN1vSwWEh319ubi1pL6ZfGbTHDxYX1taeL3FxPkY/h63c9XfSCfFjIK3X?=
 =?us-ascii?Q?SC4Y6H9KKzcIu/0yrSPqy50E8j4uCGR8vKedbjuDI7c7fQAjy+ZbdVacwUm9?=
 =?us-ascii?Q?yWFsc3tZHDQKqbjE6XKp1ZxUouGE3hqAqowfOhI6ooy+4CmfSCevvcNUgnMX?=
 =?us-ascii?Q?S6wVY5elo8KtUyoTGj+9SBiRUXa7ZysSpNNmQBRwWYt/6+kx+31KA2C6zVUo?=
 =?us-ascii?Q?CRLusYjcSp72Vus+jmTCvEwn4dlvn8/YhYTpkWus07RQ1S72KIQ9wx/5NcFM?=
 =?us-ascii?Q?Q5tXSpuZwpnhMjvtQqN0tKuUfHfa4Z4HBYIMXxWNJ5Norg8y5MtRSJpoGpBP?=
 =?us-ascii?Q?F2MR5L90JSih6EVwqilQ6c/+aZCbiVdF4g4YlDVGLRhqOmgbDdJzTv00hl3i?=
 =?us-ascii?Q?u0Kse8WesC8TWSaalz/PD7pVxzSLgRQJ2KPtasJQsdaoafrBv1E+fuOOikOv?=
 =?us-ascii?Q?JlGPOkA2Th2rDF/I3aOjF2a9+I2Cf4161Jm6AQp48lnDltJ1X83JTruwoi6+?=
 =?us-ascii?Q?U7Fr0TPyIgE/szKeH08CUoGYCj855oPRHlhMI/A7YnTbhSGrLtS9TTRueRg0?=
 =?us-ascii?Q?EfQJo46DNLiS6x88nzyAbv6U?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942c25d7-00d4-4680-6097-08d8f2ba3ffd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:02.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aicHK1KmrmAHSrpwF3ggm4+lgSMl11wY9P19ZT0ipCU5MvdYBhYUj6otQSQUrgtibD847Oq51HZQqK7J65H9XGvvBYO9nfdjZl/QRkcP7UgYyHYwCW12s732gdiLFauA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The completion ring for tx is using the wrong size to size the
ring, oversizing the ring by two orders of magniture.

Correct the allocation size and use kcalloc_node() to allocate
the ring.  Fix mistaken GFP defines in similar allocations.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h    |  3 ++-
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 1659beb..39c8909 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -52,8 +52,9 @@
  * @producer_lock: producer sync lock
  * @consumer_lock: consumer sync lock
  */
+struct ipoib_txreq;
 struct hfi1_ipoib_circ_buf {
-	void **items;
+	struct ipoib_txreq **items;
 	unsigned long head;
 	unsigned long tail;
 	unsigned long max_items;
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index e8dece5..1c38c38 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -714,14 +714,14 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 
 	priv->tx_napis = kcalloc_node(dev->num_tx_queues,
 				      sizeof(struct napi_struct),
-				      GFP_ATOMIC,
+				      GFP_KERNEL,
 				      priv->dd->node);
 	if (!priv->tx_napis)
 		goto free_txreq_cache;
 
 	priv->txqs = kcalloc_node(dev->num_tx_queues,
 				  sizeof(struct hfi1_ipoib_txq),
-				  GFP_ATOMIC,
+				  GFP_KERNEL,
 				  priv->dd->node);
 	if (!priv->txqs)
 		goto free_tx_napis;
@@ -753,9 +753,9 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 					     priv->dd->node);
 
 		txq->tx_ring.items =
-			vzalloc_node(array_size(tx_ring_size,
-						sizeof(struct ipoib_txreq)),
-				     priv->dd->node);
+			kcalloc_node(tx_ring_size,
+				     sizeof(struct ipoib_txreq *),
+				     GFP_KERNEL, priv->dd->node);
 		if (!txq->tx_ring.items)
 			goto free_txqs;
 
@@ -776,7 +776,7 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		struct hfi1_ipoib_txq *txq = &priv->txqs[i];
 
 		netif_napi_del(txq->napi);
-		vfree(txq->tx_ring.items);
+		kfree(txq->tx_ring.items);
 	}
 
 	kfree(priv->txqs);
@@ -829,7 +829,7 @@ void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv)
 		hfi1_ipoib_drain_tx_list(txq);
 		netif_napi_del(txq->napi);
 		(void)hfi1_ipoib_drain_tx_ring(txq, txq->tx_ring.max_items);
-		vfree(txq->tx_ring.items);
+		kfree(txq->tx_ring.items);
 	}
 
 	kfree(priv->txqs);
-- 
1.8.3.1

