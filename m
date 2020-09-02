Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993CE25A776
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBIL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgIBIL4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:56 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1AE42084C;
        Wed,  2 Sep 2020 08:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034315;
        bh=M2GcGMn/ZYFykgig27JGbWx0XHGq/2b3zb3gjm5bC+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owmB7ww9cEMU1Ek4+9z6V6NxvI+gfOuTsk1HUTY6xDU3XvxiANuffj/6wMtkhQIMm
         0SGs3UDhACQvFvIBKtHk3joZEZcngdS5HjrWPNYQcK6gktF2d6G4398dBJ1P2mq93w
         ySkvcZlAzMP0V/3eGdrfc5OG6Qh814W9NpTJr7q8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 7/8] RDMA/cma: Consolidate the destruction of a cma_multicast in one place
Date:   Wed,  2 Sep 2020 11:11:21 +0300
Message-Id: <20200902081122.745412-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902081122.745412-1-leon@kernel.org>
References: <20200902081122.745412-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Two places were open coding this sequence, and also pull in
cma_leave_roce_mc_group() which was called only once.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 63 +++++++++++++++++------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index b9d794ba9f6a..794b00056f59 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1795,19 +1795,30 @@ static void cma_release_port(struct rdma_id_private *id_priv)
 	mutex_unlock(&lock);
 }
 
-static void cma_leave_roce_mc_group(struct rdma_id_private *id_priv,
-				    struct cma_multicast *mc)
+static void destroy_mc(struct rdma_id_private *id_priv,
+		       struct cma_multicast *mc)
 {
-	struct rdma_dev_addr *dev_addr = &id_priv->id.route.addr.dev_addr;
-	struct net_device *ndev = NULL;
+	if (rdma_cap_ib_mcast(id_priv->id.device, id_priv->id.port_num)) {
+		ib_sa_free_multicast(mc->multicast.ib);
+		kfree(mc);
+		return;
+	}
 
-	if (dev_addr->bound_dev_if)
-		ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
-	if (ndev) {
-		cma_igmp_send(ndev, &mc->multicast.ib->rec.mgid, false);
-		dev_put(ndev);
+	if (rdma_protocol_roce(id_priv->id.device,
+				      id_priv->id.port_num)) {
+		struct rdma_dev_addr *dev_addr =
+			&id_priv->id.route.addr.dev_addr;
+		struct net_device *ndev = NULL;
+
+		if (dev_addr->bound_dev_if)
+			ndev = dev_get_by_index(dev_addr->net,
+						dev_addr->bound_dev_if);
+		if (ndev) {
+			cma_igmp_send(ndev, &mc->multicast.ib->rec.mgid, false);
+			dev_put(ndev);
+		}
+		kref_put(&mc->mcref, release_mc);
 	}
-	kref_put(&mc->mcref, release_mc);
 }
 
 static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
@@ -1815,16 +1826,10 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
 	struct cma_multicast *mc;
 
 	while (!list_empty(&id_priv->mc_list)) {
-		mc = container_of(id_priv->mc_list.next,
-				  struct cma_multicast, list);
+		mc = list_first_entry(&id_priv->mc_list, struct cma_multicast,
+				      list);
 		list_del(&mc->list);
-		if (rdma_cap_ib_mcast(id_priv->cma_dev->device,
-				      id_priv->id.port_num)) {
-			ib_sa_free_multicast(mc->multicast.ib);
-			kfree(mc);
-		} else {
-			cma_leave_roce_mc_group(id_priv, mc);
-		}
+		destroy_mc(id_priv, mc);
 	}
 }
 
@@ -4670,20 +4675,14 @@ void rdma_leave_multicast(struct rdma_cm_id *id, struct sockaddr *addr)
 	id_priv = container_of(id, struct rdma_id_private, id);
 	spin_lock_irq(&id_priv->lock);
 	list_for_each_entry(mc, &id_priv->mc_list, list) {
-		if (!memcmp(&mc->addr, addr, rdma_addr_size(addr))) {
-			list_del(&mc->list);
-			spin_unlock_irq(&id_priv->lock);
-
-			BUG_ON(id_priv->cma_dev->device != id->device);
+		if (memcmp(&mc->addr, addr, rdma_addr_size(addr)) != 0)
+			continue;
+		list_del(&mc->list);
+		spin_unlock_irq(&id_priv->lock);
 
-			if (rdma_cap_ib_mcast(id->device, id->port_num)) {
-				ib_sa_free_multicast(mc->multicast.ib);
-				kfree(mc);
-			} else if (rdma_protocol_roce(id->device, id->port_num)) {
-				cma_leave_roce_mc_group(id_priv, mc);
-			}
-			return;
-		}
+		WARN_ON(id_priv->cma_dev->device != id->device);
+		destroy_mc(id_priv, mc);
+		return;
 	}
 	spin_unlock_irq(&id_priv->lock);
 }
-- 
2.26.2

