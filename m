Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553125A772
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIBILn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBILm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D132087C;
        Wed,  2 Sep 2020 08:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034301;
        bh=02rC8BVDX5stCPNWHlSzlH+l+Z8JNZkDFCGOqCoDwUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwA4j/WvqQVqLqZBSW39NvqtmMKse68i34ZtLj6fHMz0Q6IUignFa9qYQmPIOvppw
         TRSK9Ns9Q5e15IBdJgObs2M9SKrcilmxV0NuTqQxW9IoJ3su6yZEaV3wq2V0oUiD8P
         exmd3B9Nq8w1fsmUeaWtj/Fm2xScLdZ+1DE6PzGc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/8] RDMA/cma: Combine cma_ndev_work with cma_work
Date:   Wed,  2 Sep 2020 11:11:19 +0300
Message-Id: <20200902081122.745412-6-leon@kernel.org>
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

These are the same thing, except that cma_ndev_work doesn't have a state
transition. Signal no state transition by setting old_state and new_state
== 0.

In all cases the handler function should not be called once
rdma_destroy_id() has progressed passed setting the state.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 38 +++++++----------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1d5781f507e9..088981db10f7 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -363,12 +363,6 @@ struct cma_work {
 	struct rdma_cm_event	event;
 };
 
-struct cma_ndev_work {
-	struct work_struct	work;
-	struct rdma_id_private	*id;
-	struct rdma_cm_event	event;
-};
-
 struct iboe_mcast_work {
 	struct work_struct	 work;
 	struct rdma_id_private	*id;
@@ -2675,32 +2669,14 @@ static void cma_work_handler(struct work_struct *_work)
 	struct rdma_id_private *id_priv = work->id;
 
 	mutex_lock(&id_priv->handler_mutex);
-	if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
+	if (READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING ||
+	    READ_ONCE(id_priv->state) == RDMA_CM_DEVICE_REMOVAL)
 		goto out_unlock;
-
-	if (cma_cm_event_handler(id_priv, &work->event)) {
-		cma_id_put(id_priv);
-		destroy_id_handler_unlock(id_priv);
-		goto out_free;
+	if (work->old_state != 0 || work->new_state != 0) {
+		if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
+			goto out_unlock;
 	}
 
-out_unlock:
-	mutex_unlock(&id_priv->handler_mutex);
-	cma_id_put(id_priv);
-out_free:
-	kfree(work);
-}
-
-static void cma_ndev_work_handler(struct work_struct *_work)
-{
-	struct cma_ndev_work *work = container_of(_work, struct cma_ndev_work, work);
-	struct rdma_id_private *id_priv = work->id;
-
-	mutex_lock(&id_priv->handler_mutex);
-	if (id_priv->state == RDMA_CM_DESTROYING ||
-	    id_priv->state == RDMA_CM_DEVICE_REMOVAL)
-		goto out_unlock;
-
 	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_id_put(id_priv);
 		destroy_id_handler_unlock(id_priv);
@@ -4727,7 +4703,7 @@ EXPORT_SYMBOL(rdma_leave_multicast);
 static int cma_netdev_change(struct net_device *ndev, struct rdma_id_private *id_priv)
 {
 	struct rdma_dev_addr *dev_addr;
-	struct cma_ndev_work *work;
+	struct cma_work *work;
 
 	dev_addr = &id_priv->id.route.addr.dev_addr;
 
@@ -4740,7 +4716,7 @@ static int cma_netdev_change(struct net_device *ndev, struct rdma_id_private *id
 		if (!work)
 			return -ENOMEM;
 
-		INIT_WORK(&work->work, cma_ndev_work_handler);
+		INIT_WORK(&work->work, cma_work_handler);
 		work->id = id_priv;
 		work->event.event = RDMA_CM_EVENT_ADDR_CHANGE;
 		cma_id_get(id_priv);
-- 
2.26.2

