Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADA34D1EE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhC2NzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:10 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:33857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231932AbhC2NzD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJbUdfUW/eXSbD2WofWCNW4LSHzM7qTnl3djg3kwgycMOw0WH0r8PgnvD/BqRMkkDmGmqBNbYkRnKUWCiSUtqoZXmVcfEEITXYCAgyekfz0p3th9cl2Y3CQEQDGgl1YwQ7pZ3UeWakQ/JTrx/2iHEWyMjUEaoE+aXbTIMEHVM7xrvxyfWKRZUQ0VW+yulVPsH1PaPEINsy4N+5KqrHl+r0fpxTVwD1bSlgF6mdYrfJORZZeHa5J0KKpxB5XwFqxnmFpv4G/+kNYygJVL01V+1E/OVhA+0GK8A4emzNLfiD8lV1e7di/lNloCwcEWFW9aRPf1GJRP+S2QDDsX+zEOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gJLStY8HjQjyKzLnWTjmGHB9trP7eM2wVTKv10HclQ=;
 b=REn1FgLgVnqUO1MHD4UXO1xofp5wkzPUqF6WKf79pjJ6OfQlRKCLfjhE4C3ZGmHlkjSUMpulLSRhBrxTTg23a+p7UDf6w2hhYZ1s3gZsOIbC2Qer2jyNwRITQM4yQ2hTlzweqoPV3D3PacTiRUoNMx8NFv2c55SeirmZUimExzCtyH8+VxEyzIOmoHUAwlHSrkwdA9H9fvX5SUx1qmOj0xL85CB6OicT52y/LqaFqtl2bevVh5tHPZOkeFnMa3Ble9WRrWndHmLsguDXxqvUj25AEH9s4z2fxT5ouHyZcVvg+mhAwZIn9Apb41Zpl9ZtMxEcS/yVFGF1a8qW4KvF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gJLStY8HjQjyKzLnWTjmGHB9trP7eM2wVTKv10HclQ=;
 b=WtsHd2D5mJv1JgoP+2hXz/ATuN5+QFjIfS5mC1xoNLISL/Y9fVJYGezo6todcmOAV/8al3LqrsGNqvZ9pzNPaxjVpT39b1CbeMEDEJodeTYSe08T9uON8JmAGXDITkdVEZsl2rYlpgj3YmqqjOVt/JRSQcRAEUiGocgyp4es3wiDj3rePRJg9zoU9oKywq5KMQ72p5hI5GIjnyMqQuWzYbfZsbzFmESnkJ5+++/1JYzv9SyZHphPtU5efEBlrs8phIYWd37jmK3zIFb3GbLGNB5VmeL1957PfgIY/BDpDDcfwJ3DwIaOQZ2GEqewELuW60b7sdEqsFOG6Jq6p8q4iQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:55:01 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:01 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 02/10] IB/{ipoib,hfi1}: Add a timeout handler for rdma_netdev
Date:   Mon, 29 Mar 2021 09:54:08 -0400
Message-Id: <1617026056-50483-3-git-send-email-dennis.dalessandro@cornelisnetworks.com>
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
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f852e6a8-2cea-4416-e384-08d8f2ba3f67
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6618329EAF6BE4A4A09BCA9AF47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDIw5p7h7xhOhnOFUtmyKXn7BJeY1nIAJ5iwrnqpTlrI7O4BJQdm+5OwYKuXAxiUbl3URPli48aiXl71A9xYFP6P9+TtEPTtRZluxTmi5+VixaYE98vDQis5buUzldESXmMKE/Lt97EdpFWz7qZSpg0eBW9kpQm78g7imTdlMXFlMvqTuK22s6veLZU3LPJbj+fX/blhLLN3+aqB9A52kN9F1k0oljFSmjhUAQXGGrU+ymz055KDz0R2EKfQys4l1ObbRx1mSTl6Lluwp4Db3pl4jhaWIrDu3jPldUzXsujKpu5TjV9jcI1i/WSxYw7ahQTBjny+mnn5h1B1UfstEVdLmF3jK2GhO3b5tB8x+z9AKNdrNVyNhUwfLiLpbBuFOrspaXquzmP1SsafeXxSgBnIqSsCAuXL55I1MXPXgPE3ZjqMAI+pw+zaaYV1KUuq2KpLlpECDOM3UYQ22d5j7A0dWp/+tddlYsn0Tu/b5aa9SS5xrHm1hrK2BIAaM+U7Gm4PPRGQoCV7s31EOd+NO6/Mtw4IAgs1XNEQS3X/kQkqc6VoWYkt32tVS5AWHkYoQ35NGWwuTdAxyW0ukVbdeumB+LPlS8a8n7WoPPS9ukX17JjyQdguk9BXXLvnXEjDoJOod2zlLON8MJC5p3FSzCUyVz44uLDa1h5RlqRBnm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(54906003)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(9686003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vq6xvnINvAqIub9FoLNDO4TxdqcTmlGOPhkEHz8x4eLxJznE4h/PEWKeiKoS?=
 =?us-ascii?Q?ZZKVTgXuc8I2fd3UYtKYtcYcyUXlpezRKwfOkgF88VGnRGJWjsfbUpiPA/IO?=
 =?us-ascii?Q?mviU/EX+Kcw8qvUnYteXlKm4SG4LgcCt1hHHC3sdTxx5FJpcG89mhlSQjwB6?=
 =?us-ascii?Q?9GLM24eZR73MpHLoy1NHFdysD4nqbzbJB13uqyslo9meBmwOsVUMwzSalKxq?=
 =?us-ascii?Q?ipcgkWJIufXJAxVMjG5xBIuoptxRU1RcxxvdcFYQkJyi8ceYRmvX0G5AmdHp?=
 =?us-ascii?Q?N7uqxgFD+FhpVmvKLg3i4QMojtRjUHRfZeppOP2QYft6Qkn0bUcm24t7ExP6?=
 =?us-ascii?Q?/u7FS+xbys6e0i+rPKgY74o/b/Wkk6qU4kpUjcgGw+6a2ins4MAW2Xvq0RIs?=
 =?us-ascii?Q?egzTc3e3BYnRE7nWUav1Dl7DHC3+Mp63cki45tFUQu4H+dRVwJyy1R0+/0/B?=
 =?us-ascii?Q?mx9JqR+f1rcA5UQifveInnlLX0KUHKI7KmhQ2cpSuTo7fn9fjjeEYcdXO3G/?=
 =?us-ascii?Q?TjnZ0SREiUKs5BlrZILHHB7y3QgMLHrVpfoikBeNNPG0RUmqa6FKnMz5TxpY?=
 =?us-ascii?Q?Wpo7DNwM9wtPuRTctDxwz3k0T33tReI5CfNyvwiXFDxHHfOApVfgJpFwFIX+?=
 =?us-ascii?Q?8kQfqObg0Y7YeETViIT2UdC2U6JV7TWLQrmucc/mcB0CseX4OAwrwTm7eXhf?=
 =?us-ascii?Q?c35flkI4xmOSjq+Bia5Z4QsuOOqQBS4wWS5DEzDt+PuU+7y/xHMV7rtRI8BH?=
 =?us-ascii?Q?8wa5/2/4kTWfOD5KVYF9YeQSMQm99NjyHxEMzpyBzvXyVP5usnA1UbGULxdT?=
 =?us-ascii?Q?a01wot9Bip8l5RTvaG+9CHH+jQtHPp0I81kat/4uez/gWFuISxIMDxlCH+Li?=
 =?us-ascii?Q?6re1I1NRYuLIK2QeZb86DEnUq/cmUHPXE3johFbr4vj2yYsvxD3wu6tTbetQ?=
 =?us-ascii?Q?o5RAJHnog4w8nrADV6ZGNaN2EHSlwlf8fDdv8IhPg+9eLsa1Mn1tN6Us7hNM?=
 =?us-ascii?Q?4A3TAZRJuid/F+TK/YFLhc+dO2apJ3gcNQiNO0BCJVjX2Is+iZkoQJrmU3CB?=
 =?us-ascii?Q?FlR6B9rykuBzbgj5ig6DjoyqS72Pkn0Xs5JMTpyxY0Tlbq/LegD8xLUQ8BBB?=
 =?us-ascii?Q?axLqJYsxDWNwZS2tfnyqE3stSzwuciuPZgJDjs0zDCRzEQdhAXo41FlBE6i2?=
 =?us-ascii?Q?FNelbjjTuRcZAkCIlfcSZaGr3aB42tlTy6FitGWjzWK42NvXGLfuCPyi0hus?=
 =?us-ascii?Q?3MvzWWlvsJoTJZdosXuHotgQdz4lux8OYuH/TBMbH1sb+z9LMshED+TWjnBG?=
 =?us-ascii?Q?mIWVnix7A5SLcT2ReFztl1SY?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f852e6a8-2cea-4416-e384-08d8f2ba3f67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:01.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWWwdN/swFc3MPGnF/Wojj1yJ0+BqaX4xXOk+tAgOiLtyDFs7aN1/6rIf30Y2siu6CwM9XpcCT6+YB9iNdc9H5yrRFW8RLlTjCyv/kIKrvDec2/IMJCv/HODV9VtyLtU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The current rdma_netdev handling in ipoib hooks the
tx_timeout handler, but prints out a totally useless
message that prevents effective debugging especially when
multiple transmit queues are being used.

Add a tx_timeout rdma_netdev hook and implement the
callback in the hfi1 to print additional information.

The existing non-helpful message is avoided when the driver
has presented a callback.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h        |  2 ++
 drivers/infiniband/hw/hfi1/ipoib_main.c   |  1 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c     | 29 +++++++++++++++++++++++++++++
 drivers/infiniband/ulp/ipoib/ipoib_main.c |  5 +++++
 include/rdma/ib_verbs.h                   |  2 ++
 5 files changed, 39 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index f650cac..1659beb 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -147,4 +147,6 @@ int hfi1_ipoib_rn_get_params(struct ib_device *device,
 			     enum rdma_netdev_t type,
 			     struct rdma_netdev_alloc_params *params);
 
+void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q);
+
 #endif /* _IPOIB_H */
diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index 3242290..b8838fa 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -204,6 +204,7 @@ static int hfi1_ipoib_setup_rn(struct ib_device *device,
 	int rc;
 
 	rn->send = hfi1_ipoib_send;
+	rn->tx_timeout = hfi1_ipoib_tx_timeout;
 	rn->attach_mcast = hfi1_ipoib_mcast_attach;
 	rn->detach_mcast = hfi1_ipoib_mcast_detach;
 	rn->set_id = hfi1_ipoib_set_id;
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 5129dc9..e8dece5 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -866,3 +866,32 @@ void hfi1_ipoib_napi_tx_disable(struct net_device *dev)
 		(void)hfi1_ipoib_drain_tx_ring(txq, txq->tx_ring.max_items);
 	}
 }
+
+void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	struct hfi1_ipoib_txq *txq = &priv->txqs[q];
+	u64 completed = atomic64_read(&txq->complete_txreqs);
+
+	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d no_desc %d ring_full %d\n",
+		    (unsigned long long)txq, q,
+		    __netif_subqueue_stopped(dev, txq->q_idx),
+		    atomic_read(&txq->stops),
+		    atomic_read(&txq->no_desc),
+		    atomic_read(&txq->ring_full));
+	dd_dev_info(priv->dd, "sde %llx engine %u\n",
+		    (unsigned long long)txq->sde,
+		    txq->sde ? txq->sde->this_idx : 0);
+	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
+	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
+		    txq->sent_txreqs, completed, hfi1_ipoib_used(txq));
+	dd_dev_info(priv->dd, "tx_queue_len %u max_items %lu\n",
+		    dev->tx_queue_len, txq->tx_ring.max_items);
+	dd_dev_info(priv->dd, "head %lu tail %lu\n",
+		    txq->tx_ring.head, txq->tx_ring.tail);
+	dd_dev_info(priv->dd, "wait queued %u\n",
+		    !list_empty(&txq->wait.list));
+	dd_dev_info(priv->dd, "tx_list empty %u\n",
+		    list_empty(&txq->tx_list));
+}
+
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index e16b40c..2fb2fa16 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1181,7 +1181,12 @@ static netdev_tx_t ipoib_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void ipoib_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
+	struct rdma_netdev *rn = netdev_priv(dev);
 
+	if (rn->tx_timeout) {
+		rn->tx_timeout(dev, txqueue);
+		return;
+	}
 	ipoib_warn(priv, "transmit timeout: latency %d msecs\n",
 		   jiffies_to_msecs(jiffies - dev_trans_start(dev)));
 	ipoib_warn(priv,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 21c19b1..84f7084 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2215,6 +2215,8 @@ struct rdma_netdev {
 			    int set_qkey, u32 qkey);
 	int (*detach_mcast)(struct net_device *dev, struct ib_device *hca,
 			    union ib_gid *gid, u16 mlid);
+	/* timeout */
+	void (*tx_timeout)(struct net_device *dev, unsigned int txqueue);
 };
 
 struct rdma_netdev_alloc_params {
-- 
1.8.3.1

