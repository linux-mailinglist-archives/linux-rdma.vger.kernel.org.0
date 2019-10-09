Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB3D13B1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfJIQKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:09 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:40532 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbfJIQKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:09 -0400
Received: by mail-qt1-f178.google.com with SMTP id m61so4175663qte.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/j0iIjCAV3guwH2JWemOkxEcMYFTBSFzodnO6pq0KE=;
        b=TRfvwl+0l7jGtHSjVct1vpd947AbBZqHbHd6JOnCXrC+Ru/vMZWaNMqjjh/QjKskwa
         MG4qAyNWM7wny0zFRWuvWvEw+43lEaBmBiXTTpnuZgUsz2uZ65jhCWTjTvyxoSIdXgwG
         TasOf8T5l1KVIZlM8l53dURREt6Z5OQJSurlQyLkA+69gqyfyGozIAk2aWhsrgamDZWC
         6eXpUDcCU5Sr5NMpkAotDTJhnwOGRdA8JIlGlBVKiREBiazB7Zcu7Hw9SJP4tw+m6nKy
         tg3TPDP3a85wAKfnVt99lg2OoE+058YVVQPnqVr6d9QSyr8XEM8Rh9p/Bxo0sT28dirQ
         YXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/j0iIjCAV3guwH2JWemOkxEcMYFTBSFzodnO6pq0KE=;
        b=HekVvVQy+3n297I5D3hRd4ofeo3NvfRUGVIZySfWLKUizJoPO6PAkSOJYL4le4m4mh
         3WskmPXVMSwFaHC2RhQFciCzLMT50p4kW1XhEiPE9077TbFzBz0B1USrPvVm6l/mIW1g
         N5lLz+rgD+w9LyS+d3iz7icqHU+bxeasNiSCCugRiRN9l28NF3Bo1HfPlE74Wy8O6zio
         1MsJNB7T37HXkM/1sA6EZyGiJWFVtm5Iu9ePowTY9LbqyBxax6e3sueIyXza7nu9mXZy
         iGS3vEF992bkKG6RloZncW2RZrQS1Xg6jF4xf34zuPEYoPFJL35LOpR7jRgaESfYM95Z
         F3YQ==
X-Gm-Message-State: APjAAAX1R6IKeI0AUFGDxVFCiFbGJPdx1bmStb7QqrRKabROj2wQNPeP
        S2hLkpnfAlbeffm90Zk/Ms+UcLBdc94=
X-Google-Smtp-Source: APXvYqxIbppH9qjLrqtacu8iZtE5d7oG2KJtfoE7Y8YmjKJVuzvpF7/jMAaevFt/HsxO8aWKLc7i2g==
X-Received: by 2002:ac8:2e61:: with SMTP id s30mr4635884qta.251.1570637407291;
        Wed, 09 Oct 2019 09:10:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c14sm1293414qta.80.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qa-R8; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 04/15] RDMA/mlx5: Delete struct mlx5_priv->mkey_table
Date:   Wed,  9 Oct 2019 13:09:24 -0300
Message-Id: <20191009160934.3143-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No users are left, delete it.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c               |  9 ------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 ---
 drivers/net/ethernet/mellanox/mlx5/core/mr.c  | 28 +------------------
 include/linux/mlx5/driver.h                   |  4 ---
 4 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 60b12dc530049c..fd94838a8845d5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -90,8 +90,6 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	struct mlx5_cache_ent *ent = &cache->ent[c];
 	u8 key;
 	unsigned long flags;
-	struct xarray *mkeys = &dev->mdev->priv.mkey_table;
-	int err;
 
 	spin_lock_irqsave(&ent->lock, flags);
 	ent->pending--;
@@ -118,13 +116,6 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	ent->size++;
 	spin_unlock_irqrestore(&ent->lock, flags);
 
-	xa_lock_irqsave(mkeys, flags);
-	err = xa_err(__xa_store(mkeys, mlx5_base_mkey(mr->mmkey.key),
-				&mr->mmkey, GFP_ATOMIC));
-	xa_unlock_irqrestore(mkeys, flags);
-	if (err)
-		pr_err("Error inserting to mkey tree. 0x%x\n", -err);
-
 	if (!completion_done(&ent->compl))
 		complete(&ent->compl);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index e47dd7c1b909c6..d10051f39b9c8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -837,8 +837,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	mlx5_init_qp_table(dev);
 
-	mlx5_init_mkey_table(dev);
-
 	mlx5_init_reserved_gids(dev);
 
 	mlx5_init_clock(dev);
@@ -896,7 +894,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 err_tables_cleanup:
 	mlx5_geneve_destroy(dev->geneve);
 	mlx5_vxlan_destroy(dev->vxlan);
-	mlx5_cleanup_mkey_table(dev);
 	mlx5_cleanup_qp_table(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_events_cleanup(dev);
@@ -924,7 +921,6 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_vxlan_destroy(dev->vxlan);
 	mlx5_cleanup_clock(dev);
 	mlx5_cleanup_reserved_gids(dev);
-	mlx5_cleanup_mkey_table(dev);
 	mlx5_cleanup_qp_table(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_events_cleanup(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mr.c b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
index c501bf2a025210..42cc3c7ac5b680 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
@@ -36,16 +36,6 @@
 #include <linux/mlx5/cmd.h>
 #include "mlx5_core.h"
 
-void mlx5_init_mkey_table(struct mlx5_core_dev *dev)
-{
-	xa_init_flags(&dev->priv.mkey_table, XA_FLAGS_LOCK_IRQ);
-}
-
-void mlx5_cleanup_mkey_table(struct mlx5_core_dev *dev)
-{
-	WARN_ON(!xa_empty(&dev->priv.mkey_table));
-}
-
 int mlx5_core_create_mkey_cb(struct mlx5_core_dev *dev,
 			     struct mlx5_core_mkey *mkey,
 			     struct mlx5_async_ctx *async_ctx, u32 *in,
@@ -54,7 +44,6 @@ int mlx5_core_create_mkey_cb(struct mlx5_core_dev *dev,
 			     struct mlx5_async_work *context)
 {
 	u32 lout[MLX5_ST_SZ_DW(create_mkey_out)] = {0};
-	struct xarray *mkeys = &dev->priv.mkey_table;
 	u32 mkey_index;
 	void *mkc;
 	int err;
@@ -84,16 +73,7 @@ int mlx5_core_create_mkey_cb(struct mlx5_core_dev *dev,
 
 	mlx5_core_dbg(dev, "out 0x%x, key 0x%x, mkey 0x%x\n",
 		      mkey_index, key, mkey->key);
-
-	err = xa_err(xa_store_irq(mkeys, mlx5_base_mkey(mkey->key), mkey,
-				  GFP_KERNEL));
-	if (err) {
-		mlx5_core_warn(dev, "failed xarray insert of mkey 0x%x, %d\n",
-			       mlx5_base_mkey(mkey->key), err);
-		mlx5_core_destroy_mkey(dev, mkey);
-	}
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(mlx5_core_create_mkey_cb);
 
@@ -111,12 +91,6 @@ int mlx5_core_destroy_mkey(struct mlx5_core_dev *dev,
 {
 	u32 out[MLX5_ST_SZ_DW(destroy_mkey_out)] = {0};
 	u32 in[MLX5_ST_SZ_DW(destroy_mkey_in)]   = {0};
-	struct xarray *mkeys = &dev->priv.mkey_table;
-	unsigned long flags;
-
-	xa_lock_irqsave(mkeys, flags);
-	__xa_erase(mkeys, mlx5_base_mkey(mkey->key));
-	xa_unlock_irqrestore(mkeys, flags);
 
 	MLX5_SET(destroy_mkey_in, in, opcode, MLX5_CMD_OP_DESTROY_MKEY);
 	MLX5_SET(destroy_mkey_in, in, mkey_index, mlx5_mkey_to_idx(mkey->key));
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 3e80f03a387f73..8288b62b8f375a 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -556,8 +556,6 @@ struct mlx5_priv {
 	struct dentry	       *cmdif_debugfs;
 	/* end: qp staff */
 
-	struct xarray           mkey_table;
-
 	/* start: alloc staff */
 	/* protect buffer alocation according to numa node */
 	struct mutex            alloc_mutex;
@@ -942,8 +940,6 @@ struct mlx5_cmd_mailbox *mlx5_alloc_cmd_mailbox_chain(struct mlx5_core_dev *dev,
 						      gfp_t flags, int npages);
 void mlx5_free_cmd_mailbox_chain(struct mlx5_core_dev *dev,
 				 struct mlx5_cmd_mailbox *head);
-void mlx5_init_mkey_table(struct mlx5_core_dev *dev);
-void mlx5_cleanup_mkey_table(struct mlx5_core_dev *dev);
 int mlx5_core_create_mkey_cb(struct mlx5_core_dev *dev,
 			     struct mlx5_core_mkey *mkey,
 			     struct mlx5_async_ctx *async_ctx, u32 *in,
-- 
2.23.0

