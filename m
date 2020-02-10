Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26659157A04
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBJNTs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:19:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:31840 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgBJNTr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:19:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226147078"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga008.jf.intel.com with ESMTP; 10 Feb 2020 05:19:46 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADJjaY008109;
        Mon, 10 Feb 2020 06:19:45 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADJiqS088447;
        Mon, 10 Feb 2020 08:19:44 -0500
Subject: [PATCH for-next 13/16] IB/{hfi1, ipoib,
 rdma}: Broadcast ping sent packets which exceeded mtu size
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:19:44 -0500
Message-ID: <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
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

When in connected mode ipoib sent broadcast pings which exceeded the mtu
size for broadcast addresses.

Add an mtu attribute to the rdma_netdev structure which ipoib sets to its
mcast mtu size.

The RDMA netdev uses this value to determine if the skb length is too long
for the mtu specified and if it is, drops the packet and logs an error
about the errant packet.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    2 ++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 5c1cf68..ddb896f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1906,6 +1906,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(ndev);
 	int rc;
+	struct rdma_netdev *rn = netdev_priv(ndev);
 
 	if (priv->parent) {
 		ipoib_child_init(ndev);
@@ -1918,6 +1919,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
 	/* MTU will be reset when mcast join happens */
 	ndev->mtu = IPOIB_UD_MTU(priv->max_ib_mtu);
 	priv->mcast_mtu = priv->admin_mtu = ndev->mtu;
+	rn->mtu = priv->mcast_mtu;
 	ndev->max_mtu = IPOIB_CM_MTU;
 
 	ndev->neigh_priv_len = sizeof(struct ipoib_neigh);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 7166ee9b..3d5f6b8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -246,6 +246,7 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
 		if (priv->mcast_mtu == priv->admin_mtu)
 			priv->admin_mtu = IPOIB_UD_MTU(mtu);
 		priv->mcast_mtu = IPOIB_UD_MTU(mtu);
+		rn->mtu = priv->mcast_mtu;
 
 		priv->qkey = be32_to_cpu(priv->broadcast->mcmember.qkey);
 		spin_unlock_irq(&priv->lock);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 8ac8e18..3086560 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -97,6 +97,7 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
 {
 	struct net_device *ndev = priv->dev;
 	int result;
+	struct rdma_netdev *rn = netdev_priv(ndev);
 
 	ASSERT_RTNL();
 
@@ -117,6 +118,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
 		goto out_early;
 	}
 
+	rn->mtu = priv->mcast_mtu;
+
 	priv->parent = ppriv->dev;
 	priv->pkey = pkey;
 	priv->child_type = type;

