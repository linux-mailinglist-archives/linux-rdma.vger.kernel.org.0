Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55F9157A0A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJNUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:20:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:43828 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730988AbgBJNT7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:19:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="431599943"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2020 05:19:58 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADJwHB008132;
        Mon, 10 Feb 2020 06:19:58 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADJuEf088475;
        Mon, 10 Feb 2020 08:19:56 -0500
Subject: [PATCH for-next 15/16] IB/ipoib: Add capability to switch between
 datagram and connected mode
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:19:56 -0500
Message-ID: <20200210131956.87776.1388.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
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
Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index ddb896f..149c9b1 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -533,6 +533,7 @@ int ipoib_set_mode(struct net_device *dev, const char *buf)
 			   "will cause multicast packet drops\n");
 		netdev_update_features(dev);
 		dev_set_mtu(dev, ipoib_cm_max_mtu(dev));
+		netif_set_real_num_tx_queues(dev, 1);
 		rtnl_unlock();
 		priv->tx_wr.wr.send_flags &= ~IB_SEND_IP_CSUM;
 
@@ -544,6 +545,7 @@ int ipoib_set_mode(struct net_device *dev, const char *buf)
 		clear_bit(IPOIB_FLAG_ADMIN_CM, &priv->flags);
 		netdev_update_features(dev);
 		dev_set_mtu(dev, min(priv->mcast_mtu, dev->mtu));
+		netif_set_real_num_tx_queues(dev, dev->num_tx_queues);
 		rtnl_unlock();
 		ipoib_flush_paths(dev);
 		return (!rtnl_trylock()) ? -EBUSY : 0;
@@ -2081,9 +2083,17 @@ static int ipoib_get_vf_stats(struct net_device *dev, int vf,
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
 
@@ -2133,13 +2143,6 @@ static void ipoib_build_priv(struct net_device *dev)
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
@@ -2177,7 +2180,6 @@ int ipoib_intf_init(struct ib_device *hca, u8 port, const char *name,
 		if (rc != -EOPNOTSUPP)
 			goto out;
 
-		dev->netdev_ops = &ipoib_netdev_default_pf;
 		rn->send = ipoib_send;
 		rn->attach_mcast = ipoib_mcast_attach;
 		rn->detach_mcast = ipoib_mcast_detach;

