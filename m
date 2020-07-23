Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB322A955
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgGWHHR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 03:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWHHQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Jul 2020 03:07:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9772C20888;
        Thu, 23 Jul 2020 07:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595488036;
        bh=JpFmZGGd9quVWTdECsH61o+DeQTzwiWRyfjmO6uwkp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLrIQJQzE3GeUxGFT9MXOTdLSWabN1IU+f0sevaxzFpDB7pXPeevknkcZnALaOpCh
         IaU/HY0CKqOu4Z6Nt3JBHWdid+eYtEh5YAk3vPULd0PgwEsQSMzQHc+Jlx/diSM8Zg
         r937Ouq63S7dv0WL+RniQbghjl5FUleK04KWRers=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/4] RDMA/cma: Using the standard locking pattern when delivering the removal event
Date:   Thu, 23 Jul 2020 10:07:05 +0300
Message-Id: <20200723070707.1771101-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723070707.1771101-1-leon@kernel.org>
References: <20200723070707.1771101-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Whenever an event is delivered to the handler it should be done under the
handler_mutex and upon any non-zero return from the handler it should
trigger destruction of the cm_id.

cma_process_remove() skips some steps here, it is not necessarily wrong
since the state change should prevent any races, but it is confusing and
unnecessary.

Follow the standard pattern here, with the slight twist that the
transition to RDMA_CM_DEVICE_REMOVAL includes a cma_cancel_operation().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 62 ++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 537eeebde5f4..04151c301e85 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1925,6 +1925,8 @@ static int cma_cm_event_handler(struct rdma_id_private *id_priv,
 {
 	int ret;
 
+	lockdep_assert_held(&id_priv->handler_mutex);
+
 	trace_cm_event_handler(id_priv, event);
 	ret = id_priv->id.event_handler(&id_priv->id, event);
 	trace_cm_event_done(id_priv, event, ret);
@@ -4793,50 +4795,58 @@ static int cma_add_one(struct ib_device *device)
 	return ret;
 }
 
-static int cma_remove_id_dev(struct rdma_id_private *id_priv)
+static void cma_send_device_removal_put(struct rdma_id_private *id_priv)
 {
-	struct rdma_cm_event event = {};
+	struct rdma_cm_event event = { .event = RDMA_CM_EVENT_DEVICE_REMOVAL };
 	enum rdma_cm_state state;
-	int ret = 0;
-
-	/* Record that we want to remove the device */
-	state = cma_exch(id_priv, RDMA_CM_DEVICE_REMOVAL);
-	if (state == RDMA_CM_DESTROYING)
-		return 0;
+	unsigned long flags;
 
-	cma_cancel_operation(id_priv, state);
 	mutex_lock(&id_priv->handler_mutex);
+	/* Record that we want to remove the device */
+	spin_lock_irqsave(&id_priv->lock, flags);
+	state = id_priv->state;
+	if (state == RDMA_CM_DESTROYING || state == RDMA_CM_DEVICE_REMOVAL) {
+		spin_unlock_irqrestore(&id_priv->lock, flags);
+		mutex_unlock(&id_priv->handler_mutex);
+		cma_id_put(id_priv);
+		return;
+	}
+	id_priv->state = RDMA_CM_DEVICE_REMOVAL;
+	spin_unlock_irqrestore(&id_priv->lock, flags);
 
-	/* Check for destruction from another callback. */
-	if (!cma_comp(id_priv, RDMA_CM_DEVICE_REMOVAL))
-		goto out;
-
-	event.event = RDMA_CM_EVENT_DEVICE_REMOVAL;
-	ret = cma_cm_event_handler(id_priv, &event);
-out:
+	if (cma_cm_event_handler(id_priv, &event)) {
+		/*
+		 * At this point the ULP promises it won't call
+		 * rdma_destroy_id() concurrently
+		 */
+		cma_id_put(id_priv);
+		mutex_unlock(&id_priv->handler_mutex);
+		rdma_destroy_id(&id_priv->id);
+		return;
+	}
 	mutex_unlock(&id_priv->handler_mutex);
-	return ret;
+
+	/*
+	 * If this races with destroy then the thread that first assigns state
+	 * to a destroying does the cancel.
+	 */
+	cma_cancel_operation(id_priv, state);
+	cma_id_put(id_priv);
 }
 
 static void cma_process_remove(struct cma_device *cma_dev)
 {
-	struct rdma_id_private *id_priv;
-	int ret;
-
 	mutex_lock(&lock);
 	while (!list_empty(&cma_dev->id_list)) {
-		id_priv = list_entry(cma_dev->id_list.next,
-				     struct rdma_id_private, list);
+		struct rdma_id_private *id_priv = list_first_entry(
+			&cma_dev->id_list, struct rdma_id_private, list);
 
 		list_del(&id_priv->listen_list);
 		list_del_init(&id_priv->list);
 		cma_id_get(id_priv);
 		mutex_unlock(&lock);
 
-		ret = cma_remove_id_dev(id_priv);
-		cma_id_put(id_priv);
-		if (ret)
-			rdma_destroy_id(&id_priv->id);
+		cma_send_device_removal_put(id_priv);
 
 		mutex_lock(&lock);
 	}
-- 
2.26.2

