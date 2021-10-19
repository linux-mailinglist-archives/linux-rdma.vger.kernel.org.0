Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C81433E5C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 20:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhJSS2q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 14:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhJSS2o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 14:28:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22F7A6139F;
        Tue, 19 Oct 2021 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634667991;
        bh=ex5LtUKszeDij/67FPwn+ikY92pGm1C3wisa6bsJ5OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huCCeinlk+cv7xXX8w/csL2miApL49itVm0X/d6pDJ87vIR9qA58CbAwilTmi55t8
         bUSqgE0JGpgbZSHZI/1QFdPZ8f+qG+mogmUAYjxlk7BXsrYu+D1Ds17MhszEXd99vi
         fKq9SrrqUD6LgvAOVO0CAFHW1DU0fdkfhYTDiXMYoS6AihLd/tMJMvEr5k1ZKuRIXR
         xeZ+YG0xuwqqR8T2+X5bX4HO85xFdaeRpqnGZAAuxd7F7N28SAWPrBH4iZRbd4Wjca
         diaqJiJYgv+5J+Lr+lQ5FdZwIu+xbr4qddalx+9QcIZmDarV2flO7QRokgs14gp+xB
         Di44iHihXRaRg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        jgg@ziepe.ca, yuehaibing@huawei.com, manjunath.b.patil@oracle.com,
        leon@kernel.org, mbloch@nvidia.com, jinpu.wang@ionos.com,
        mike.marciniszyn@cornelisnetworks.com, liweihang@huawei.com
Subject: [PATCH rdma-next 1/3] ipoib: use dev_addr_mod()
Date:   Tue, 19 Oct 2021 11:26:02 -0700
Message-Id: <20211019182604.1441387-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019182604.1441387-1-kuba@kernel.org>
References: <20211019182604.1441387-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dledford@redhat.com
CC: jgg@ziepe.ca
CC: yuehaibing@huawei.com
CC: manjunath.b.patil@oracle.com
CC: leon@kernel.org
CC: mbloch@nvidia.com
CC: jinpu.wang@ionos.com
CC: mike.marciniszyn@cornelisnetworks.com
CC: liweihang@huawei.com
CC: linux-rdma@vger.kernel.org
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c   |  4 +++-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c   |  9 ++++-----
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 17 +++++++++--------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 684c2ddb16f5..fd9d7f2c4d64 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1583,6 +1583,7 @@ int ipoib_cm_dev_init(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	int max_srq_sge, i;
+	u8 addr;
 
 	INIT_LIST_HEAD(&priv->cm.passive_ids);
 	INIT_LIST_HEAD(&priv->cm.reap_list);
@@ -1636,7 +1637,8 @@ int ipoib_cm_dev_init(struct net_device *dev)
 		}
 	}
 
-	priv->dev->dev_addr[0] = IPOIB_FLAGS_RC;
+	addr = IPOIB_FLAGS_RC;
+	dev_addr_mod(dev, 0, &addr, 1);
 	return 0;
 }
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index ceabfb0b0a83..2c3dca41d3bd 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1057,13 +1057,11 @@ static bool ipoib_dev_addr_changed_valid(struct ipoib_dev_priv *priv)
 {
 	union ib_gid search_gid;
 	union ib_gid gid0;
-	union ib_gid *netdev_gid;
 	int err;
 	u16 index;
 	u32 port;
 	bool ret = false;
 
-	netdev_gid = (union ib_gid *)(priv->dev->dev_addr + 4);
 	if (rdma_query_gid(priv->ca, priv->port, 0, &gid0))
 		return false;
 
@@ -1073,7 +1071,8 @@ static bool ipoib_dev_addr_changed_valid(struct ipoib_dev_priv *priv)
 	 * to do it later
 	 */
 	priv->local_gid.global.subnet_prefix = gid0.global.subnet_prefix;
-	netdev_gid->global.subnet_prefix = gid0.global.subnet_prefix;
+	dev_addr_mod(priv->dev, 4, (u8 *)&gid0.global.subnet_prefix,
+		     sizeof(gid0.global.subnet_prefix));
 	search_gid.global.subnet_prefix = gid0.global.subnet_prefix;
 
 	search_gid.global.interface_id = priv->local_gid.global.interface_id;
@@ -1135,8 +1134,8 @@ static bool ipoib_dev_addr_changed_valid(struct ipoib_dev_priv *priv)
 			if (!test_bit(IPOIB_FLAG_DEV_ADDR_CTRL, &priv->flags)) {
 				memcpy(&priv->local_gid, &gid0,
 				       sizeof(priv->local_gid));
-				memcpy(priv->dev->dev_addr + 4, &gid0,
-				       sizeof(priv->local_gid));
+				dev_addr_mod(priv->dev, 4, (u8 *)&gid0,
+					     sizeof(priv->local_gid));
 				ret = true;
 			}
 		}
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 9c9da5aa592a..9934b8bd7f56 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1696,6 +1696,7 @@ static void ipoib_dev_uninit_default(struct net_device *dev)
 static int ipoib_dev_init_default(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
+	u8 addr_mod[3];
 
 	ipoib_napi_add(dev);
 
@@ -1723,9 +1724,10 @@ static int ipoib_dev_init_default(struct net_device *dev)
 	}
 
 	/* after qp created set dev address */
-	priv->dev->dev_addr[1] = (priv->qp->qp_num >> 16) & 0xff;
-	priv->dev->dev_addr[2] = (priv->qp->qp_num >>  8) & 0xff;
-	priv->dev->dev_addr[3] = (priv->qp->qp_num) & 0xff;
+	addr_mod[0] = (priv->qp->qp_num >> 16) & 0xff;
+	addr_mod[1] = (priv->qp->qp_num >>  8) & 0xff;
+	addr_mod[2] = (priv->qp->qp_num) & 0xff;
+	dev_addr_mod(priv->dev, 1, addr_mod, sizeof(addr_mod));
 
 	return 0;
 
@@ -1886,8 +1888,7 @@ static int ipoib_parent_init(struct net_device *ndev)
 			priv->ca->name, priv->port, result);
 		return result;
 	}
-	memcpy(priv->dev->dev_addr + 4, priv->local_gid.raw,
-	       sizeof(union ib_gid));
+	dev_addr_mod(priv->dev, 4, priv->local_gid.raw, sizeof(union ib_gid));
 
 	SET_NETDEV_DEV(priv->dev, priv->ca->dev.parent);
 	priv->dev->dev_port = priv->port - 1;
@@ -1908,8 +1909,8 @@ static void ipoib_child_init(struct net_device *ndev)
 		memcpy(&priv->local_gid, priv->dev->dev_addr + 4,
 		       sizeof(priv->local_gid));
 	else {
-		memcpy(priv->dev->dev_addr, ppriv->dev->dev_addr,
-		       INFINIBAND_ALEN);
+		__dev_addr_set(priv->dev, ppriv->dev->dev_addr,
+			       INFINIBAND_ALEN);
 		memcpy(&priv->local_gid, &ppriv->local_gid,
 		       sizeof(priv->local_gid));
 	}
@@ -2326,7 +2327,7 @@ static void set_base_guid(struct ipoib_dev_priv *priv, union ib_gid *gid)
 	memcpy(&priv->local_gid.global.interface_id,
 	       &gid->global.interface_id,
 	       sizeof(gid->global.interface_id));
-	memcpy(netdev->dev_addr + 4, &priv->local_gid, sizeof(priv->local_gid));
+	dev_addr_mod(netdev, 4, (u8 *)&priv->local_gid, sizeof(priv->local_gid));
 	clear_bit(IPOIB_FLAG_DEV_ADDR_SET, &priv->flags);
 
 	netif_addr_unlock_bh(netdev);
-- 
2.31.1

