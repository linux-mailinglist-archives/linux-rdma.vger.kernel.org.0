Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB637B9EF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhELKHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 06:07:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2642 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhELKHE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 06:07:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg9MD0RF3zQmKm;
        Wed, 12 May 2021 18:02:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 18:05:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/2] RDMA/cm: Optimise rbtree searching
Date:   Wed, 12 May 2021 18:05:37 +0800
Message-ID: <20210512100537.6273-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210512100537.6273-1-thunder.leizhen@huawei.com>
References: <20210512100537.6273-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rewrite the rbtree traversing in the normal pattern:
if (a < b)
    ..
else if (a > b)
    ..
else // a == b
    ..

This gives us some performance improvement. Because the search complexity
of the rbtree is log(N). That is, after an average of "log(N) - 1" search
failures, a success or failure is known only in the last round. That is,
the (a == b) only needs to be compared once, whereas our current writing
compares log(N) times on average.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/infiniband/core/cm.c | 50 +++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 510beb25f5b8a0b..2198de857a06591 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -643,29 +643,14 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 		parent = *link;
 		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
 					  service_node);
-		if ((cur_cm_id_priv->id.service_mask & service_id) ==
-		    (service_mask & cur_cm_id_priv->id.service_id) &&
-		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
-			/*
-			 * Sharing an ib_cm_id with different handlers is not
-			 * supported
-			 */
-			if (cur_cm_id_priv->id.cm_handler != shared_handler ||
-			    cur_cm_id_priv->id.context ||
-			    WARN_ON(!cur_cm_id_priv->id.cm_handler)) {
-				spin_unlock_irqrestore(&cm.lock, flags);
-				return NULL;
-			}
-			refcount_inc(&cur_cm_id_priv->refcount);
-			cur_cm_id_priv->listen_sharecount++;
-			spin_unlock_irqrestore(&cm.lock, flags);
-			return cur_cm_id_priv;
-		}
 
 		if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
 			link = &(*link)->rb_left;
 		else if (cm_id_priv->id.device > cur_cm_id_priv->id.device)
 			link = &(*link)->rb_right;
+		else if ((cur_cm_id_priv->id.service_mask & service_id) ==
+			 (service_mask & cur_cm_id_priv->id.service_id))
+			goto found;
 		else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
 			link = &(*link)->rb_left;
 		else
@@ -676,6 +661,22 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 	rb_insert_color(&cm_id_priv->service_node, &cm.listen_service_table);
 	spin_unlock_irqrestore(&cm.lock, flags);
 	return cm_id_priv;
+
+found:
+	/*
+	 * Sharing an ib_cm_id with different handlers is not
+	 * supported
+	 */
+	if (cur_cm_id_priv->id.cm_handler != shared_handler ||
+	    cur_cm_id_priv->id.context ||
+	    WARN_ON(!cur_cm_id_priv->id.cm_handler)) {
+		spin_unlock_irqrestore(&cm.lock, flags);
+		return NULL;
+	}
+	refcount_inc(&cur_cm_id_priv->refcount);
+	cur_cm_id_priv->listen_sharecount++;
+	spin_unlock_irqrestore(&cm.lock, flags);
+	return cur_cm_id_priv;
 }
 
 static struct cm_id_private *cm_find_listen(struct ib_device *device,
@@ -686,22 +687,23 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
 
 	while (node) {
 		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
-		if ((cm_id_priv->id.service_mask & service_id) ==
-		     cm_id_priv->id.service_id &&
-		    (cm_id_priv->id.device == device)) {
-			refcount_inc(&cm_id_priv->refcount);
-			return cm_id_priv;
-		}
+
 		if (device < cm_id_priv->id.device)
 			node = node->rb_left;
 		else if (device > cm_id_priv->id.device)
 			node = node->rb_right;
+		else if ((cm_id_priv->id.service_mask & service_id) == cm_id_priv->id.service_id)
+			goto found;
 		else if (be64_lt(service_id, cm_id_priv->id.service_id))
 			node = node->rb_left;
 		else
 			node = node->rb_right;
 	}
 	return NULL;
+
+found:
+	refcount_inc(&cm_id_priv->refcount);
+	return cm_id_priv;
 }
 
 static struct cm_timewait_info *
-- 
2.26.0.106.g9fadedd


