Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DCD149B0B
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgAZO1H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgAZO1H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:07 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D925620720;
        Sun, 26 Jan 2020 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048826;
        bh=EVr3bwHzuMJmwIUx8zTWI3sAJZK5tcQ4/EtJIocspNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qW636FDHPYOmqEcbE2cHZx/1x82OSmLlAry+S/YTLYUDd49isg38dtIe9tu3Y9DBE
         O7GRjOgxbBCfam7gVXJeVDbkUFGoQ1MR7uR24ZOMI4yh4hFKzt0BC4jgBN5WzEFth6
         eVdhf6OPtafTyqsz17XfILR38K3PFlUq4cNReleA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 4/7] RDMA/cma: Rename cma_device ref/deref helpers to to get/put
Date:   Sun, 26 Jan 2020 16:26:49 +0200
Message-Id: <20200126142652.104803-5-leon@kernel.org>
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

Helper functions which increment/decrement reference count of the
structure are read better when they are named with get/put suffix.

Hence, rename cma_ref/deref_dev() to cma_dev_get/put().

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c          | 22 +++++++++++-----------
 drivers/infiniband/core/cma_configfs.c |  6 +++---
 drivers/infiniband/core/cma_priv.h     |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 34c62eae08d8..7e16d1b001ff 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -247,11 +247,17 @@ enum {
 	CMA_OPTION_AFONLY,
 };
 
-void cma_ref_dev(struct cma_device *cma_dev)
+void cma_dev_get(struct cma_device *cma_dev)
 {
 	atomic_inc(&cma_dev->refcount);
 }
 
+void cma_dev_put(struct cma_device *cma_dev)
+{
+	if (atomic_dec_and_test(&cma_dev->refcount))
+		complete(&cma_dev->comp);
+}
+
 struct cma_device *cma_enum_devices_by_ibdev(cma_device_filter	filter,
 					     void		*cookie)
 {
@@ -267,7 +273,7 @@ struct cma_device *cma_enum_devices_by_ibdev(cma_device_filter	filter,
 		}
 
 	if (found_cma_dev)
-		cma_ref_dev(found_cma_dev);
+		cma_dev_get(found_cma_dev);
 	mutex_unlock(&lock);
 	return found_cma_dev;
 }
@@ -463,7 +469,7 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
 static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 			       struct cma_device *cma_dev)
 {
-	cma_ref_dev(cma_dev);
+	cma_dev_get(cma_dev);
 	id_priv->cma_dev = cma_dev;
 	id_priv->id.device = cma_dev->device;
 	id_priv->id.route.addr.dev_addr.transport =
@@ -484,12 +490,6 @@ static void cma_attach_to_dev(struct rdma_id_private *id_priv,
 					  rdma_start_port(cma_dev->device)];
 }
 
-void cma_deref_dev(struct cma_device *cma_dev)
-{
-	if (atomic_dec_and_test(&cma_dev->refcount))
-		complete(&cma_dev->comp);
-}
-
 static inline void release_mc(struct kref *kref)
 {
 	struct cma_multicast *mc = container_of(kref, struct cma_multicast, mcref);
@@ -502,7 +502,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
 {
 	mutex_lock(&lock);
 	list_del(&id_priv->list);
-	cma_deref_dev(id_priv->cma_dev);
+	cma_dev_put(id_priv->cma_dev);
 	id_priv->cma_dev = NULL;
 	mutex_unlock(&lock);
 }
@@ -4728,7 +4728,7 @@ static void cma_process_remove(struct cma_device *cma_dev)
 	}
 	mutex_unlock(&lock);
 
-	cma_deref_dev(cma_dev);
+	cma_dev_put(cma_dev);
 	wait_for_completion(&cma_dev->comp);
 }
 
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 8b0b5ae22e4c..c672a4978bfd 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -94,7 +94,7 @@ static int cma_configfs_params_get(struct config_item *item,
 
 static void cma_configfs_params_put(struct cma_device *cma_dev)
 {
-	cma_deref_dev(cma_dev);
+	cma_dev_put(cma_dev);
 }
 
 static ssize_t default_roce_mode_show(struct config_item *item,
@@ -312,12 +312,12 @@ static struct config_group *make_cma_dev(struct config_group *group,
 	configfs_add_default_group(&cma_dev_group->ports_group,
 			&cma_dev_group->device_group);
 
-	cma_deref_dev(cma_dev);
+	cma_dev_put(cma_dev);
 	return &cma_dev_group->device_group;
 
 fail:
 	if (cma_dev)
-		cma_deref_dev(cma_dev);
+		cma_dev_put(cma_dev);
 	kfree(cma_dev_group);
 	return ERR_PTR(err);
 }
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index ca7307277518..4e04c442ff86 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -111,8 +111,8 @@ static inline void cma_configfs_exit(void)
 }
 #endif
 
-void cma_ref_dev(struct cma_device *dev);
-void cma_deref_dev(struct cma_device *dev);
+void cma_dev_get(struct cma_device *dev);
+void cma_dev_put(struct cma_device *dev);
 typedef bool (*cma_device_filter)(struct ib_device *, void *);
 struct cma_device *cma_enum_devices_by_ibdev(cma_device_filter filter,
 					     void *cookie);
-- 
2.24.1

