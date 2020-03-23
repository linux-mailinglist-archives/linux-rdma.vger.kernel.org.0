Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8761901C3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 00:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCWXQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 19:16:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:13963 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCWXQE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 19:16:04 -0400
IronPort-SDR: gnsi4m2DbMVaKs6WOcAhtMJkf+B2JZ+pKs/TZxb6cnuAdHkECL/4ruKgtBvGySJBulQu75susa
 dQEBzKJIpCvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:16:03 -0700
IronPort-SDR: lzy0tWXFakXUlJw4cliZUTvXTjJhgjJppq59W8dB4Omw/F/CRI70FHIHMpHD+ESFwnaMkRm6lN
 mIraLmE5PR6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="447633502"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2020 16:16:03 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02NNG2Q2014107;
        Mon, 23 Mar 2020 16:16:03 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02NNG1jI064555;
        Mon, 23 Mar 2020 19:16:01 -0400
Subject: [PATCH v2 for-next 15/16] IB/ipoib: Add capability to switch
 between datagram and connected mode
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 23 Mar 2020 19:16:01 -0400
Message-ID: <20200323231601.64035.11505.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gary Leshner <Gary.S.Leshner@intel.com>

This is the prerequisite modification to the ipoib ulp to allow a
rdma netdev to obtain the default ndo ops for init/uninit/open/close.

This is accomplished by setting the netdev ops field within the
callback function passed to the netdev allocation routine which
in turn was passed into the rdma netdev allocation routine.

This allows the rdma netdev to call back into the ulp to create the
resources required for connected mode operation.

Additionally as the ulp is not re-entrant, when switching modes,
the number of real tx queues is set to 1 for the connected mode.

For datagram mode the number of real tx queues is set to the
actual number of tx queues specified at the netdev's allocation.

For the internal ulp netdev the number of tx queues defaults to 1.

It is up to the rdma netdev to specify the actual number it can support.

When the driver does not support a rdma netdev for acceleration,
(-ENOTSUPPORTED return code or the verbs function for allocation is
NULL) the ipoib ulp functions are unaffected by using the internal
netdev allocated by the ipoib ulp.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index a02e5f2..e07aea8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -529,6 +529,7 @@ int ipoib_set_mode(struct net_device *dev, const char *buf)
 			   "will cause multicast packet drops\n");
 		netdev_update_features(dev);
 		dev_set_mtu(dev, ipoib_cm_max_mtu(dev));
+		netif_set_real_num_tx_queues(dev, 1);
 		rtnl_unlock();
 		priv->tx_wr.wr.send_flags &= ~IB_SEND_IP_CSUM;
 
@@ -540,6 +541,7 @@ int ipoib_set_mode(struct net_device *dev, const char *buf)
 		clear_bit(IPOIB_FLAG_ADMIN_CM, &priv->flags);
 		netdev_update_features(dev);
 		dev_set_mtu(dev, min(priv->mcast_mtu, dev->mtu));
+		netif_set_real_num_tx_queues(dev, dev->num_tx_queues);
 		rtnl_unlock();
 		ipoib_flush_paths(dev);
 		return (!rtnl_trylock()) ? -EBUSY : 0;
@@ -2074,9 +2076,17 @@ static int ipoib_get_vf_stats(struct net_device *dev, int vf,
 	.ndo_do_ioctl		 = ipoib_ioctl,
 };
 
+static const struct net_device_ops ipoib_netdev_default_pf = {
+	.ndo_init		 = ipoib_dev_init_default,
+	.ndo_uninit		 = ipoib_dev_uninit_default,
+	.ndo_open		 = ipoib_ib_dev_open_default,
+	.ndo_stop		 = ipoib_ib_dev_stop_default,
+};
+
 void ipoib_setup_common(struct net_device *dev)
 {
 	dev->header_ops		 = &ipoib_header_ops;
+	dev->netdev_ops          = &ipoib_netdev_default_pf;
 
 	ipoib_set_ethtool_ops(dev);
 
@@ -2126,13 +2136,6 @@ static void ipoib_build_priv(struct net_device *dev)
 	INIT_DELAYED_WORK(&priv->neigh_reap_task, ipoib_reap_neigh);
 }
 
-static const struct net_device_ops ipoib_netdev_default_pf = {
-	.ndo_init		 = ipoib_dev_init_default,
-	.ndo_uninit		 = ipoib_dev_uninit_default,
-	.ndo_open		 = ipoib_ib_dev_open_default,
-	.ndo_stop		 = ipoib_ib_dev_stop_default,
-};
-
 static struct net_device *ipoib_alloc_netdev(struct ib_device *hca, u8 port,
 					     const char *name)
 {
@@ -2170,7 +2173,6 @@ int ipoib_intf_init(struct ib_device *hca, u8 port, const char *name,
 		if (rc != -EOPNOTSUPP)
 			goto out;
 
-		dev->netdev_ops = &ipoib_netdev_default_pf;
 		rn->send = ipoib_send;
 		rn->attach_mcast = ipoib_mcast_attach;
 		rn->detach_mcast = ipoib_mcast_detach;

