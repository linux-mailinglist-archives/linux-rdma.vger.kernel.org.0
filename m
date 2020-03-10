Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6917F372
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJJZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgCJJZx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:25:53 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC20024681;
        Tue, 10 Mar 2020 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832353;
        bh=jbe9gQWS+pR8frnf2g+TsUntqed43HTOxvl4JNm6eQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DW+asawUc+DphcgKC47kjKvUeEOHEx7HQZiGiV4VA2M+XuAQR61ZSxBcJI9l9Cwkn
         cMnWN4Y6uR9HBeAMhBoTy4w5aZ5o5k/MJ7rhFO1nePbzXL41LpW7Vx5c8YwD8NeYny
         iBmph/gAXqywQzqwFZEbhT7gzoH1l7R69fInY+NM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next 01/15] RDMA/cm: Fix ordering of xa_alloc_cyclic() in ib_create_cm_id()
Date:   Tue, 10 Mar 2020 11:25:31 +0200
Message-Id: <20200310092545.251365-2-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

xa_alloc_cyclic() is a SMP release to be paired with some later acquire
during xa_load() as part of cm_acquire_id().

As such, xa_alloc_cyclic() must be done after the cm_id is fully
initialized, in particular, it absolutely must be after the
refcount_set(), otherwise the refcount_inc() in cm_acquire_id() may not
see the set.

As there are several cases where a reader will be able to use the
id.local_id after cm_acquire_id in the IB_CM_IDLE state there needs to be
an unfortunate split into a NULL allocate and a finalizing xa_store.

Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c9bd9589bd5a..b1fccbf6ebd8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -575,18 +575,6 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	return 0;
 }

-static int cm_alloc_id(struct cm_id_private *cm_id_priv)
-{
-	int err;
-	u32 id;
-
-	err = xa_alloc_cyclic_irq(&cm.local_id_table, &id, cm_id_priv,
-			xa_limit_32b, &cm.local_id_next, GFP_KERNEL);
-
-	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
-	return err;
-}
-
 static u32 cm_local_id(__be32 local_id)
 {
 	return (__force u32) (local_id ^ cm.random_id_operand);
@@ -828,6 +816,7 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 				 void *context)
 {
 	struct cm_id_private *cm_id_priv;
+	u32 id;
 	int ret;

 	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);
@@ -839,9 +828,6 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 	cm_id_priv->id.cm_handler = cm_handler;
 	cm_id_priv->id.context = context;
 	cm_id_priv->id.remote_cm_qpn = 1;
-	ret = cm_alloc_id(cm_id_priv);
-	if (ret)
-		goto error;

 	spin_lock_init(&cm_id_priv->lock);
 	init_completion(&cm_id_priv->comp);
@@ -850,11 +836,20 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 	INIT_LIST_HEAD(&cm_id_priv->altr_list);
 	atomic_set(&cm_id_priv->work_count, -1);
 	refcount_set(&cm_id_priv->refcount, 1);
+
+	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
+				  &cm.local_id_next, GFP_KERNEL);
+	if (ret)
+		goto error;
+	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
+	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
+		     cm_id_priv, GFP_KERNEL);
+
 	return &cm_id_priv->id;

 error:
 	kfree(cm_id_priv);
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(ib_create_cm_id);

--
2.24.1

