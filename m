Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43E515A1ED
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgBLH0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgBLH0x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:26:53 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECE720848;
        Wed, 12 Feb 2020 07:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492412;
        bh=MSU1rNtQhwV5+WcvT9QipiGmRds857+slycHbAgGCRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1B5QrEHHyvjRQ3lssGIHIhXFgh8Gq9yRWgyuEQZF2oGaiyJz+S4nwT/1/PQmdEOy
         8CNtPlM66RHF4xxa7Le/WVz6scuXv8MKsHYKOgn4J6Gwepqf+1iB2+7L3FcVnBPeTG
         iJzOMh8u0y5dzNNKKrTh6+IJXnBCtyiI5B7H+4c8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 4/9] IB/ipoib: Fix double free of skb in case of multicast traffic in CM mode
Date:   Wed, 12 Feb 2020 09:26:30 +0200
Message-Id: <20200212072635.682689-5-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Valentine Fatiev <valentinef@mellanox.com>

While connected mode set and we have connected and datagram traffic
in parallel it might end with double free of datagram skb.

Current mechanism assumes that order in completion queue is the same as
theorder of sent packets for all QPs. Order is kept only for specific QP,
in case of mixed UD and CM traffic we have few QPs(one UD and few CM's)
in parallel.

The problem:
----------------------------------------------------------

Transmit queue:
-----------------
UD skb pointer kept in queue itself , CM skb kept in spearate queue and
use transmit queue as a placeholder to count number of transmitted packets.

0   1   2   3   4  5  6  7  8   9  10  11 12 13 .........127
------------------------------------------------------------
NL ud1 UD2 CM1 ud3 cm2 cm3 ud4 cm4 ud5 NL NL NL ...........
--------------------------------------------------------------
    ^                                  ^
   tail                               head

Completion queue(problematic scenario) - order not the same as in
transmit queue

  1  2  3  4  5  6  7  8  9
----------------------------
 ud1 CM1 UD2 ud3 cm2 cm3 ud4 cm4 ud5
----------------------------

1. CM1 'wc' processing
   - skb freed in cm separate ring.
   - tx_tail of transmit queue increased although UD2 not freed.
     Now driver assume UD2 index is already freed and it could be used
     for new transmitted skb.

0   1   2   3   4  5  6  7  8   9  10  11 12 13 .........127
------------------------------------------------------------
NL NL  UD2 CM1 ud3 cm2 cm3 ud4 cm4 ud5 NL NL NL ...........
--------------------------------------------------------------
        ^   ^                       ^
      (Bad)tail                    head
(Bad - Could be used for new SKB)

In this case (due to heavy load) UD2 skb pointer could be replaced by
new transmitted packet UD_NEW , as driver assume its free.
At this point we will have to process two 'wc' with same index but we
have only one pointer to free.
During second attempt to free same skb we will have NULL pointer exception.

2. UD2 'wc' processing
   - skb freed according the index we got from 'wc' ,but
     it was already overwritten by mistake.So actually skb that was
     released its skb of new transmitted packet and no the original one.

3. UD_NEW 'wc' processing
   - attempt to free already freed skb. NUll pointer exception.

Fix:
-----------------------------------------------------------------------
The fix is to stop using UD ring also as placeholder for CM packets,
instead using atomic counter to keep total packets sent value and use it
to stop/wake queue.

Fixes: 2c104ea68350 ("IB/ipoib: Get rid of the tx_outstanding variable in all modes")
Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
Reviewed-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h      |  1 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c   | 15 ++++++++-------
 drivers/infiniband/ulp/ipoib/ipoib_ib.c   |  8 ++++++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c |  1 +
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 2aa3457a30ce..c614cb87d09b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -379,6 +379,7 @@ struct ipoib_dev_priv {
 	struct ipoib_tx_buf *tx_ring;
 	unsigned int	     tx_head;
 	unsigned int	     tx_tail;
+	atomic_t             tx_outstanding;
 	struct ib_sge	     tx_sge[MAX_SKB_FRAGS + 1];
 	struct ib_ud_wr      tx_wr;
 	struct ib_wc	     send_wc[MAX_SEND_CQE];
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index c59e00a0881f..db6aace83fe5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -756,7 +756,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
 		return;
 	}
 
-	if ((priv->tx_head - priv->tx_tail) == ipoib_sendq_size - 1) {
+	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
 		ipoib_dbg(priv, "TX ring 0x%x full, stopping kernel net queue\n",
 			  tx->qp->qp_num);
 		netif_stop_queue(dev);
@@ -786,7 +786,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
 	} else {
 		netif_trans_update(dev);
 		++tx->tx_head;
-		++priv->tx_head;
+		atomic_inc(&priv->tx_outstanding);
 	}
 }
 
@@ -820,11 +820,11 @@ void ipoib_cm_handle_tx_wc(struct net_device *dev, struct ib_wc *wc)
 	netif_tx_lock(dev);
 
 	++tx->tx_tail;
-	++priv->tx_tail;
+	atomic_dec(&priv->tx_outstanding);
 
 	if (unlikely(netif_queue_stopped(dev) &&
-		     (priv->tx_head - priv->tx_tail) <= ipoib_sendq_size >> 1 &&
-		     test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)))
+	    (atomic_read(&priv->tx_outstanding) <= ipoib_sendq_size >> 1) &&
+	    test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)))
 		netif_wake_queue(dev);
 
 	if (wc->status != IB_WC_SUCCESS &&
@@ -1232,8 +1232,9 @@ static void ipoib_cm_tx_destroy(struct ipoib_cm_tx *p)
 		dev_kfree_skb_any(tx_req->skb);
 		netif_tx_lock_bh(p->dev);
 		++p->tx_tail;
-		++priv->tx_tail;
-		if (unlikely(priv->tx_head - priv->tx_tail == ipoib_sendq_size >> 1) &&
+		atomic_dec(&priv->tx_outstanding);
+		if (unlikely(atomic_read(&priv->tx_outstanding) <=
+			     ipoib_sendq_size >> 1) &&
 		    netif_queue_stopped(p->dev) &&
 		    test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
 			netif_wake_queue(p->dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index c332b4761816..0652f25e8d0f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -407,9 +407,11 @@ static void ipoib_ib_handle_tx_wc(struct net_device *dev, struct ib_wc *wc)
 	dev_kfree_skb_any(tx_req->skb);
 
 	++priv->tx_tail;
+	atomic_dec(&priv->tx_outstanding);
 
 	if (unlikely(netif_queue_stopped(dev) &&
-		     ((priv->tx_head - priv->tx_tail) <= ipoib_sendq_size >> 1) &&
+		     (atomic_read(&priv->tx_outstanding) <= ipoib_sendq_size >>
+		      1) &&
 		     test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)))
 		netif_wake_queue(dev);
 
@@ -634,7 +636,7 @@ int ipoib_send(struct net_device *dev, struct sk_buff *skb,
 	else
 		priv->tx_wr.wr.send_flags &= ~IB_SEND_IP_CSUM;
 	/* increase the tx_head after send success, but use it for queue state */
-	if (priv->tx_head - priv->tx_tail == ipoib_sendq_size - 1) {
+	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
 		ipoib_dbg(priv, "TX ring full, stopping kernel net queue\n");
 		netif_stop_queue(dev);
 	}
@@ -662,6 +664,7 @@ int ipoib_send(struct net_device *dev, struct sk_buff *skb,
 
 		rc = priv->tx_head;
 		++priv->tx_head;
+		atomic_inc(&priv->tx_outstanding);
 	}
 	return rc;
 }
@@ -807,6 +810,7 @@ int ipoib_ib_dev_stop_default(struct net_device *dev)
 				ipoib_dma_unmap_tx(priv, tx_req);
 				dev_kfree_skb_any(tx_req->skb);
 				++priv->tx_tail;
+				atomic_dec(&priv->tx_outstanding);
 			}
 
 			for (i = 0; i < ipoib_recvq_size; ++i) {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 4a0d3a9e72e1..0d98886cfef8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1706,6 +1706,7 @@ static int ipoib_dev_init_default(struct net_device *dev)
 	}
 
 	/* priv->tx_head, tx_tail & tx_outstanding are already 0 */
+	atomic_set(&priv->tx_outstanding, 0);
 
 	if (ipoib_transport_dev_init(dev, priv->ca)) {
 		pr_warn("%s: ipoib_transport_dev_init failed\n",
-- 
2.24.1

