Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF425A771
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIBILj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBILi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49FFD2084C;
        Wed,  2 Sep 2020 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034298;
        bh=QVXrkytbyrpcq7hudaWALE5s9Sy6LPUcopzOGLyxnJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lv+j3Txk4QSVxAalZVs9ZHoeP+C0gpiZAcjbmCWZHF3qz5X/N8XQP9Gxn21pRU1JS
         0e6r3r8TNUCN21ZvvkZ/z2x3747HVeImApF/CajCAzQ4dKUjOpsUELE8Bcs1HTC84f
         YOdTEAUs1CLDSwgREvfO/Owk2dZuCgOXsGCTrojA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/8] RDMA/cma: Fix locking for the RDMA_CM_LISTEN state
Date:   Wed,  2 Sep 2020 11:11:17 +0300
Message-Id: <20200902081122.745412-4-leon@kernel.org>
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

There is a strange unlocked read of the ID state when checking for
reuseaddr. This is because an ID cannot be reusable once it becomes a
listening ID. Instead of using the state to exclude reuse, just clear it
as part of rdma_listen()'s flow to convert reusable into not reusable.

Once a ID goes to listen there is no way back out, and the only use of
reusable is on the bind_list check.

Finally, update the checks under handler_mutex to use READ_ONCE and audit
that once RDMA_CM_LISTEN is observed in a req callback it is stable under
the handler_mutex.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 901d1bd35603..1ab779e63762 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2215,7 +2215,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	}
 
 	mutex_lock(&listen_id->handler_mutex);
-	if (listen_id->state != RDMA_CM_LISTEN) {
+	if (READ_ONCE(listen_id->state) != RDMA_CM_LISTEN) {
 		ret = -ECONNABORTED;
 		goto err_unlock;
 	}
@@ -2393,7 +2393,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	listen_id = cm_id->context;
 
 	mutex_lock(&listen_id->handler_mutex);
-	if (listen_id->state != RDMA_CM_LISTEN)
+	if (READ_ONCE(listen_id->state) != RDMA_CM_LISTEN)
 		goto out;
 
 	/* Create a new RDMA id for the new IW CM ID */
@@ -3357,7 +3357,8 @@ int rdma_set_reuseaddr(struct rdma_cm_id *id, int reuse)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	spin_lock_irqsave(&id_priv->lock, flags);
-	if (reuse || id_priv->state == RDMA_CM_IDLE) {
+	if ((reuse && id_priv->state != RDMA_CM_LISTEN) ||
+	    id_priv->state == RDMA_CM_IDLE) {
 		id_priv->reuseaddr = reuse;
 		ret = 0;
 	} else {
@@ -3551,8 +3552,7 @@ static int cma_check_port(struct rdma_bind_list *bind_list,
 		if (id_priv == cur_id)
 			continue;
 
-		if ((cur_id->state != RDMA_CM_LISTEN) && reuseaddr &&
-		    cur_id->reuseaddr)
+		if (reuseaddr && cur_id->reuseaddr)
 			continue;
 
 		cur_addr = cma_src_addr(cur_id);
@@ -3593,18 +3593,6 @@ static int cma_use_port(enum rdma_ucm_port_space ps,
 	return ret;
 }
 
-static int cma_bind_listen(struct rdma_id_private *id_priv)
-{
-	struct rdma_bind_list *bind_list = id_priv->bind_list;
-	int ret = 0;
-
-	mutex_lock(&lock);
-	if (bind_list->owners.first->next)
-		ret = cma_check_port(bind_list, id_priv, 0);
-	mutex_unlock(&lock);
-	return ret;
-}
-
 static enum rdma_ucm_port_space
 cma_select_inet_ps(struct rdma_id_private *id_priv)
 {
@@ -3713,8 +3701,16 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 			return -EINVAL;
 	}
 
+	/*
+	 * Once the ID reaches RDMA_CM_LISTEN it is not allowed to be reusable
+	 * any more, and has to be unique in the bind list.
+	 */
 	if (id_priv->reuseaddr) {
-		ret = cma_bind_listen(id_priv);
+		mutex_lock(&lock);
+		ret = cma_check_port(id_priv->bind_list, id_priv, 0);
+		if (!ret)
+			id_priv->reuseaddr = 0;
+		mutex_unlock(&lock);
 		if (ret)
 			goto err;
 	}
@@ -3739,6 +3735,10 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 	return 0;
 err:
 	id_priv->backlog = 0;
+	/*
+	 * All the failure paths that lead here will not allow the req_handler's
+	 * to have run.
+	 */
 	cma_comp_exch(id_priv, RDMA_CM_LISTEN, RDMA_CM_ADDR_BOUND);
 	return ret;
 }
-- 
2.26.2

