Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05093149B09
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAZO1B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbgAZO1A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:00 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81AE720720;
        Sun, 26 Jan 2020 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048820;
        bh=nu6GeEjHu9OjWJHxf4G/po8ZIDLpUTIC4Q8+9Wbluz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vn8WZfdoqqRoflAypUQ9fqzzakpi6dNY5a1/xJOM8Opm/q+doCPGunghViv+mEEih
         KqKzCSKT75t3jRdcs36marH64qzg3oe7m7kIUpjARXy/6GdHBKE6RLebisCqdFXCi8
         v6dqVCjIRo1MJ08DRm5KUE52TvUksbW235bJTB2o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 2/7] RDMA/cma: Use helper function to enqueue resolve work item
Date:   Sun, 26 Jan 2020 16:26:47 +0200
Message-Id: <20200126142652.104803-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126142652.104803-1-leon@kernel.org>
References: <20200126142652.104803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

To avoid errors, to attach ownership of work item and its cm_id
refcount which is decremented in work handler, tie them up in single
helper function. Also avoid code duplication.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 72f032160c4b..8f16ebb413c2 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2687,14 +2687,18 @@ static void cma_init_resolve_route_work(struct cma_work *work,
 	work->event.event = RDMA_CM_EVENT_ROUTE_RESOLVED;
 }
 
-static void cma_init_resolve_addr_work(struct cma_work *work,
-				       struct rdma_id_private *id_priv)
+static void enqueue_resolve_addr_work(struct cma_work *work,
+				      struct rdma_id_private *id_priv)
 {
+	atomic_inc(&id_priv->refcount);
+
 	work->id = id_priv;
 	INIT_WORK(&work->work, cma_work_handler);
 	work->old_state = RDMA_CM_ADDR_QUERY;
 	work->new_state = RDMA_CM_ADDR_RESOLVED;
 	work->event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
+
+	queue_work(cma_wq, &work->work);
 }
 
 static int cma_resolve_ib_route(struct rdma_id_private *id_priv,
@@ -3148,9 +3152,7 @@ static int cma_resolve_loopback(struct rdma_id_private *id_priv)
 	rdma_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid);
 	rdma_addr_set_dgid(&id_priv->id.route.addr.dev_addr, &gid);
 
-	atomic_inc(&id_priv->refcount);
-	cma_init_resolve_addr_work(work, id_priv);
-	queue_work(cma_wq, &work->work);
+	enqueue_resolve_addr_work(work, id_priv);
 	return 0;
 err:
 	kfree(work);
@@ -3175,9 +3177,7 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
 	rdma_addr_set_dgid(&id_priv->id.route.addr.dev_addr, (union ib_gid *)
 		&(((struct sockaddr_ib *) &id_priv->id.route.addr.dst_addr)->sib_addr));
 
-	atomic_inc(&id_priv->refcount);
-	cma_init_resolve_addr_work(work, id_priv);
-	queue_work(cma_wq, &work->work);
+	enqueue_resolve_addr_work(work, id_priv);
 	return 0;
 err:
 	kfree(work);
-- 
2.24.1

