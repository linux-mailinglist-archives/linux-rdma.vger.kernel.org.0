Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8D149B0E
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgAZO1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgAZO1Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:16 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55EC320708;
        Sun, 26 Jan 2020 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048835;
        bh=wGkZ23IalwW9I8cuTTpVX55HMIsqGmryUlJlZ07S5Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RshZFLxVRr6NgRn+slM7WSrg1qHs5wQhtCCsA+usBBu3+YlyuIM9HD9eS8vT8hXr7
         kAwXssQDpqH/ybBQzFx4S0CEojO0zwrQB9t3TVPMTp9CjT/fDzdd+vyoh3ehLps9V7
         YhgeRnB84nlZwf3nPi0W86NcTmSVVe5EyLRY3aBk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 7/7] RDMA/cma: Use refcount API to reflect refcount
Date:   Sun, 26 Jan 2020 16:26:52 +0200
Message-Id: <20200126142652.104803-8-leon@kernel.org>
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

Use the refcount variant to capture the reference counting of the
cm_id structure.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c      | 6 +++---
 drivers/infiniband/core/cma_priv.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index d6355e21cc87..af96675e31c4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -843,12 +843,12 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 static void cma_id_get(struct rdma_id_private *id_priv)
 {
-	atomic_inc(&id_priv->refcount);
+	refcount_inc(&id_priv->refcount);
 }
 
 static void cma_id_put(struct rdma_id_private *id_priv)
 {
-	if (atomic_dec_and_test(&id_priv->refcount))
+	if (refcount_dec_and_test(&id_priv->refcount))
 		complete(&id_priv->comp);
 }
 
@@ -876,7 +876,7 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
 	init_completion(&id_priv->comp);
-	atomic_set(&id_priv->refcount, 1);
+	refcount_set(&id_priv->refcount, 1);
 	mutex_init(&id_priv->handler_mutex);
 	INIT_LIST_HEAD(&id_priv->listen_list);
 	INIT_LIST_HEAD(&id_priv->mc_list);
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 4e04c442ff86..5edcf44a9307 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -66,7 +66,7 @@ struct rdma_id_private {
 	struct mutex		qp_mutex;
 
 	struct completion	comp;
-	atomic_t		refcount;
+	refcount_t refcount;
 	struct mutex		handler_mutex;
 
 	int			backlog;
-- 
2.24.1

