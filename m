Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50BC1CE001
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgEKQHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:07:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:64704 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgEKQHE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:07:04 -0400
IronPort-SDR: FVOsytQ7gFPt4958vqUZ8PpfznLl/9lhdCF4h6xRHJuwwRVpT8BfjUPhZaUqhigjVC1oMYt1wO
 9670ykQn9zog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:06:57 -0700
IronPort-SDR: 1YvGdeiSpKMzWT0sSfWSPPW2LzcSALYDlmHdFjV1vJbxIC5IfDJrtI/MxlzgQvq05i92SQuo5L
 84SefQBILOMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="408966475"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2020 09:06:56 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 04BG6ubG061714;
        Mon, 11 May 2020 09:06:56 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 04BG6t04174216;
        Mon, 11 May 2020 12:06:55 -0400
Subject: [PATCH v3 for-next 13/16] IB/{hfi1, ipoib,
 rdma}: Broadcast ping sent packets which exceeded mtu size
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 11 May 2020 12:06:55 -0400
Message-ID: <20200511160655.173205.14546.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
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
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    2 ++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 22216f1..a6c4322 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1896,6 +1896,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(ndev);
 	int rc;
+	struct rdma_netdev *rn = netdev_priv(ndev);
 
 	if (priv->parent) {
 		ipoib_child_init(ndev);
@@ -1908,6 +1909,7 @@ static int ipoib_ndo_init(struct net_device *ndev)
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

