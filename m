Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79920A431
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405353AbgFYRmf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405282AbgFYRme (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jun 2020 13:42:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52719C08C5C1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2020 10:42:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so6755920wrn.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2020 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rx8LbV0YvZlCGDt0SfMioqGuFLMkEVXnwpQX1iYnDCk=;
        b=qZVqLV3MGIJLd8OTF/YEMFcyDd7+IY92t2lUBSTKL6fivYEonMtClqTT/lh3uzi1mE
         jGNVTnT31z2eaQ1p36IEMiVD+t5I4qqpxWgDJvXi9yy6mG8bqhCjianDpaM8Q2po536X
         7oHArc3CUFgsFIaJ0aO0DozXvKxqelWxYkf4JXd16WZp9hPPN7E6gwaAn0/BTjynFf5q
         rXVW6e6ecfm9CHJNwsStAqIX+WW01eAqGdPBZLmMvD2qx9LQSaKlJT9r04eLNeyBgi2C
         jp3r14HOFUFnYXvxYyIiuiKC00bh/Mn0X6WKRowtPX1x80Pz8otI0PSu2DlBLwR90WLB
         MvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rx8LbV0YvZlCGDt0SfMioqGuFLMkEVXnwpQX1iYnDCk=;
        b=B31FbcV3t3jhqqwjRM9hF3phAv3X+EpeS+r2YXXKEp8VsHm1G2/4oCIhhLwF/AogqZ
         smnVR+rLzm1XFxSYxYj0r3HI64k/ovoGnlrFTpH4C9hB5W38yVPuSGwUX+jXdv5OcGEE
         sa1abAtVa1+6ybW2+M4aW71QQnjBC9jDs9kn7rdsSf4UM5Y/esPlt5iPyDQFUodVvKGK
         PeBvcVm9OkxUIO12BoCcvl/VmVon5P8PcAHZ3sPB0+7mqqlEEw6jA9XwseEDNmSYQGMR
         bsDfYys8iXHHY7Qy65ml2n2eaGxUBFLPZKIM/hm5pl7siVkQ5ILCOP+brY14r3Zs4tZs
         ce1w==
X-Gm-Message-State: AOAM531Ut7VXM2zVMobSQf1A1FP88zNXP8dj9W3doCOjT430EFuSN6Sd
        i2einZ6MQKO/ukuHdc3PJSZPidrT
X-Google-Smtp-Source: ABdhPJyJLwfnv6Hn0ZlgjxQbDliGVHmzjRU0R/J+Cz7VB5tQT/Kf8e+xkEkJh5xhNHBfJeH2NWsOhA==
X-Received: by 2002:a05:6000:341:: with SMTP id e1mr38178016wre.1.1593106952645;
        Thu, 25 Jun 2020 10:42:32 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([77.137.115.112])
        by smtp.gmail.com with ESMTPSA id b10sm13036427wmj.30.2020.06.25.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:42:31 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-next] RDMA/ipoib: Fix ABBA deadlock with ipoib_reap_ah()
Date:   Thu, 25 Jun 2020 20:42:19 +0300
Message-Id: <20200625174219.290842-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

ipoib_mcast_carrier_on_task() insanely open codes a rtnl_lock() such that
the ony time flush_workqueue() can be called is if it also clears
IPOIB_FLAG_OPER_UP.

Thus the flush inside ipoib_flush_ah() will deadlock if it gets unlucky
enough, and lockdep doesn't help us to find it early:

          CPU0               CPU1          CPU2
   __ipoib_ib_dev_flush()
      down_read(vlan_rwsem)

                         ipoib_vlan_add()
                           rtnl_trylock()
                           down_write(vlan_rwsem)

				      ipoib_mcast_carrier_on_task()
					 while (!rtnl_trylock())
					      msleep(20);

      ipoib_flush_ah()
	flush_workqueue(priv->wq)

Clean up the ah_reaper related functions and lifecycle to make sense:

 - Start/Stop of the reaper should only be done in open/stop NDOs, not in
   any other places

 - cancel and flush of the reaper should only happen in the stop NDO.
   cancel is only functional when combined with IPOIB_STOP_REAPER.

 - Non-stop places were flushing the AH's just need to flush out dead AH's
   synchronously and ignore the background task completely. It is fully
   locked and harmless to leave running.

Which ultimately fixes the ABBA deadlock by removing the unnecessary
flush_workqueue() from the problematic place under the vlan_rwsem.

Fixes: efc82eeeae4e ("IB/ipoib: No longer use flush as a parameter")
Reported-by: Kamal Heib <kheib@redhat.com>
Tested-by: Kamal Heib <kheib@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c   | 65 ++++++++++-------------
 drivers/infiniband/ulp/ipoib/ipoib_main.c |  2 +
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 6ee64c25aaff..494f413dc3c6 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -670,13 +670,12 @@ int ipoib_send(struct net_device *dev, struct sk_buff *skb,
 	return rc;
 }
 
-static void __ipoib_reap_ah(struct net_device *dev)
+static void ipoib_reap_dead_ahs(struct ipoib_dev_priv *priv)
 {
-	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ipoib_ah *ah, *tah;
 	unsigned long flags;
 
-	netif_tx_lock_bh(dev);
+	netif_tx_lock_bh(priv->dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	list_for_each_entry_safe(ah, tah, &priv->dead_ahs, list)
@@ -687,37 +686,37 @@ static void __ipoib_reap_ah(struct net_device *dev)
 		}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(priv->dev);
 }
 
 void ipoib_reap_ah(struct work_struct *work)
 {
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, ah_reap_task.work);
-	struct net_device *dev = priv->dev;
 
-	__ipoib_reap_ah(dev);
+	ipoib_reap_dead_ahs(priv);
 
 	if (!test_bit(IPOIB_STOP_REAPER, &priv->flags))
 		queue_delayed_work(priv->wq, &priv->ah_reap_task,
 				   round_jiffies_relative(HZ));
 }
 
-static void ipoib_flush_ah(struct net_device *dev)
+static void ipoib_start_ah_reaper(struct ipoib_dev_priv *priv)
 {
-	struct ipoib_dev_priv *priv = ipoib_priv(dev);
-
-	cancel_delayed_work(&priv->ah_reap_task);
-	flush_workqueue(priv->wq);
-	ipoib_reap_ah(&priv->ah_reap_task.work);
+	clear_bit(IPOIB_STOP_REAPER, &priv->flags);
+	queue_delayed_work(priv->wq, &priv->ah_reap_task,
+			   round_jiffies_relative(HZ));
 }
 
-static void ipoib_stop_ah(struct net_device *dev)
+static void ipoib_stop_ah_reaper(struct ipoib_dev_priv *priv)
 {
-	struct ipoib_dev_priv *priv = ipoib_priv(dev);
-
 	set_bit(IPOIB_STOP_REAPER, &priv->flags);
-	ipoib_flush_ah(dev);
+	cancel_delayed_work(&priv->ah_reap_task);
+	/*
+	 * After ipoib_stop_ah_reaper() we always go through
+	 * ipoib_reap_dead_ahs() which ensures the work is really stopped and
+	 * does a final flush out of the dead_ah's list
+	 */
 }
 
 static int recvs_pending(struct net_device *dev)
@@ -846,16 +845,6 @@ int ipoib_ib_dev_stop_default(struct net_device *dev)
 	return 0;
 }
 
-void ipoib_ib_dev_stop(struct net_device *dev)
-{
-	struct ipoib_dev_priv *priv = ipoib_priv(dev);
-
-	priv->rn_ops->ndo_stop(dev);
-
-	clear_bit(IPOIB_FLAG_INITIALIZED, &priv->flags);
-	ipoib_flush_ah(dev);
-}
-
 int ipoib_ib_dev_open_default(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -899,10 +888,7 @@ int ipoib_ib_dev_open(struct net_device *dev)
 		return -1;
 	}
 
-	clear_bit(IPOIB_STOP_REAPER, &priv->flags);
-	queue_delayed_work(priv->wq, &priv->ah_reap_task,
-			   round_jiffies_relative(HZ));
-
+	ipoib_start_ah_reaper(priv);
 	if (priv->rn_ops->ndo_open(dev)) {
 		pr_warn("%s: Failed to open dev\n", dev->name);
 		goto dev_stop;
@@ -913,13 +899,20 @@ int ipoib_ib_dev_open(struct net_device *dev)
 	return 0;
 
 dev_stop:
-	set_bit(IPOIB_STOP_REAPER, &priv->flags);
-	cancel_delayed_work(&priv->ah_reap_task);
-	set_bit(IPOIB_FLAG_INITIALIZED, &priv->flags);
-	ipoib_ib_dev_stop(dev);
+	ipoib_stop_ah_reaper(priv);
 	return -1;
 }
 
+void ipoib_ib_dev_stop(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = ipoib_priv(dev);
+
+	priv->rn_ops->ndo_stop(dev);
+
+	clear_bit(IPOIB_FLAG_INITIALIZED, &priv->flags);
+	ipoib_stop_ah_reaper(priv);
+}
+
 void ipoib_pkey_dev_check_presence(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -1230,7 +1223,7 @@ static void __ipoib_ib_dev_flush(struct ipoib_dev_priv *priv,
 		ipoib_mcast_dev_flush(dev);
 		if (oper_up)
 			set_bit(IPOIB_FLAG_OPER_UP, &priv->flags);
-		ipoib_flush_ah(dev);
+		ipoib_reap_dead_ahs(priv);
 	}
 
 	if (level >= IPOIB_FLUSH_NORMAL)
@@ -1305,7 +1298,7 @@ void ipoib_ib_dev_cleanup(struct net_device *dev)
 	 * the neighbor garbage collection is stopped and reaped.
 	 * That should all be done now, so make a final ah flush.
 	 */
-	ipoib_stop_ah(dev);
+	ipoib_reap_dead_ahs(priv);
 
 	clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 3cfb682b91b0..ef60e8e4ae67 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1976,6 +1976,8 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 
 	/* no more works over the priv->wq */
 	if (priv->wq) {
+		/* See ipoib_mcast_carrier_on_task() */
+		WARN_ON(test_bit(IPOIB_FLAG_OPER_UP, &priv->flags));
 		flush_workqueue(priv->wq);
 		destroy_workqueue(priv->wq);
 		priv->wq = NULL;
-- 
2.25.4

