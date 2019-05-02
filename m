Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1584111487
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBHs2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHs2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:28 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA56720873;
        Thu,  2 May 2019 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783307;
        bh=x3Lw1j7e72jJWOxouv1nSKL02iYxEUO7byGDTuy2SiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEqTTCzGPry3METbiT7kRyBA4QFKFWQThlvyOhuve3MIZl20QAkSbVQ0ojh5Z0gLW
         7qd6OrPWF4fsD56qUFyUsnUDHOFR4d1oTTDkhVxlo8L4Yh5mKf2sY7iXibdOP+W+Jo
         oDMaFgNL39sPnUpsshUNmc1nwllyn2J3weV8a0+Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 4/7] RDMA/cma: Use rdma_read_gid_attr_ndev_rcu to access netdev
Date:   Thu,  2 May 2019 10:48:04 +0300
Message-Id: <20190502074807.26566-5-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
References: <20190502074807.26566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

To access the netdevice of the GID attribute, use an existing API
rdma_read_gid_attr_ndev_rcu().

This further reduces dependency on open access to netdevice of GID
attribute.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/addr.c  |  1 +
 drivers/infiniband/core/cache.c |  1 +
 drivers/infiniband/core/cma.c   | 12 ++++++++++--
 include/rdma/ib_cache.h         |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 0dce94e3c495..2b791ce7597f 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -45,6 +45,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <rdma/ib_addr.h>
+#include <rdma/ib_cache.h>
 #include <rdma/ib_sa.h>
 #include <rdma/ib.h>
 #include <rdma/rdma_netlink.h>
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c164e377e563..a53c7713d77a 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1249,6 +1249,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr)
 	read_unlock_irqrestore(&table->rwlock, flags);
 	return ndev;
 }
+EXPORT_SYMBOL(rdma_read_gid_attr_ndev_rcu);
 
 static int get_lower_dev_vlan(struct net_device *lower_dev, void *data)
 {
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 088b5495e199..19f1730a4f24 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1486,6 +1486,7 @@ static struct net_device *
 roce_get_net_dev_by_cm_event(const struct ib_cm_event *ib_event)
 {
 	const struct ib_gid_attr *sgid_attr = NULL;
+	struct net_device *ndev;
 
 	if (ib_event->event == IB_CM_REQ_RECEIVED)
 		sgid_attr = ib_event->param.req_rcvd.ppath_sgid_attr;
@@ -1494,8 +1495,15 @@ roce_get_net_dev_by_cm_event(const struct ib_cm_event *ib_event)
 
 	if (!sgid_attr)
 		return NULL;
-	dev_hold(sgid_attr->ndev);
-	return sgid_attr->ndev;
+
+	rcu_read_lock();
+	ndev = rdma_read_gid_attr_ndev_rcu(sgid_attr);
+	if (IS_ERR(ndev))
+		ndev = NULL;
+	else
+		dev_hold(ndev);
+	rcu_read_unlock();
+	return ndev;
 }
 
 static struct net_device *cma_get_net_dev(const struct ib_cm_event *ib_event,
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 730a65ad8c74..870b5e6c06db 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -56,6 +56,7 @@ const struct ib_gid_attr *rdma_find_gid_by_filter(
 
 int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
 			    u16 *vlan_id, u8 *smac);
+struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
 
 /**
  * ib_get_cached_pkey - Returns a cached PKey table entry
-- 
2.20.1

