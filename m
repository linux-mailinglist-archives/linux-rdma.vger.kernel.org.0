Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CEEC3941
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfJAPik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38597 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfJAPik (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so11656802qkc.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKdHuEV0TcgXHbIA+nzfMHJx5W8bR5+RCJ7HA5Fsyp8=;
        b=Ckgnye/spviyMCGY5BzcjAjVOC8Edeb/NOLsMXMa8uYmoahbA/2ZAKbsaKvWd0w+Zq
         vGWgCo/UcLvQImMFjF0oNsa1xY0v4eYqatRHYo0A29L5e9SdjqbolasFgKBmy4TpSkNQ
         kiGyYrb7tf9jW+p+SvD0N+s/DKJEGU1psiRvz3y9YDfq96Njt5JUcELRDPWIuPYzG178
         8cBtAf93ubYLIonJZtPNO61lGBU0hykorIb8aWXRy3Oloiv9GynezQsND785rPZIpYvF
         jH4t6uEDWS+zVc8tSrubLGZgKZK2YJUIo+Lg8zmYOGZqLL4jnU71BN56rqOgADYFMuXX
         r4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKdHuEV0TcgXHbIA+nzfMHJx5W8bR5+RCJ7HA5Fsyp8=;
        b=GZK98UpUClACRezA8XVA/hGvKDC9bMSeZv/6j6EpmK9de7ySU3srUmKAe6Xf3lzkvC
         +fgKjzCpQmQgOz0vqeyUeYzDvHpRmoXumpyI2IBga47nMClclccZ8HdzRCPSo6jKx/Oq
         MWsLJRHEEnKXV4OBERSiFXaM6HzLSFg+Drzlr+CdMESMgrhdQvqYh8WW5d5LYZojkOZN
         AF7VgEJDjJurn8jK71hTxM5V6O1At2tSdKpQ+/GG9EX5AJZZ/Y/PWiW5+gCKSpm9aUyy
         IY/8qsaU5YqYN/HS2mRbO5td/yVoWBGUJtxjnbcynDKS+/xmIft4jP2cEbwc4wusDJRc
         LNwg==
X-Gm-Message-State: APjAAAXf0iyklAChaskQBb6byRwTiFg04YgnSrnF+jpwKNBmGYH6dIo5
        UekJVMXxz93NrHDY3q6OPoEO0BSPePg=
X-Google-Smtp-Source: APXvYqwkWxJDVIU8/2SL3hSYNNB8vSwQDnZJqGeB47kGkPp/Iym973yd3aj9vHaOrcfdGgCVDvCg8g==
X-Received: by 2002:a37:6156:: with SMTP id v83mr6785365qkb.80.1569944318920;
        Tue, 01 Oct 2019 08:38:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v4sm7487811qkj.28.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKEU-0006F1-6d; Tue, 01 Oct 2019 12:38:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 6/6] RDMA/mlx5: Add missing synchronize_srcu() for MW cases
Date:   Tue,  1 Oct 2019 12:38:21 -0300
Message-Id: <20191001153821.23621-7-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

While MR uses live as the SRCU 'update', the MW case uses the xarray
directly, xa_erase() causes the MW to become inaccessible to the pagefault
thread.

Thus whenever a MW is removed from the xarray we must synchronize_srcu()
before freeing it.

This must be done before freeing the mkey as re-use of the mkey while the
pagefault thread is using the stale mkey is undesirable.

Add the missing synchronizes to MW and DEVX indirect mkey and delete the
bogus protection against double destroy in mlx5_core_destroy_mkey()

Fixes: 534fd7aac56a ("IB/mlx5: Manage indirection mkey upon DEVX flow for ODP")
Fixes: 6aec21f6a832 ("IB/mlx5: Page faults handling infrastructure")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c            | 58 ++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  1 -
 drivers/infiniband/hw/mlx5/mr.c              | 21 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/mr.c |  8 +--
 4 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 59022b7441448f..d609f4659afb7a 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1298,29 +1298,6 @@ static int devx_handle_mkey_create(struct mlx5_ib_dev *dev,
 	return 0;
 }
 
-static void devx_free_indirect_mkey(struct rcu_head *rcu)
-{
-	kfree(container_of(rcu, struct devx_obj, devx_mr.rcu));
-}
-
-/* This function to delete from the radix tree needs to be called before
- * destroying the underlying mkey. Otherwise a race might occur in case that
- * other thread will get the same mkey before this one will be deleted,
- * in that case it will fail via inserting to the tree its own data.
- *
- * Note:
- * An error in the destroy is not expected unless there is some other indirect
- * mkey which points to this one. In a kernel cleanup flow it will be just
- * destroyed in the iterative destruction call. In a user flow, in case
- * the application didn't close in the expected order it's its own problem,
- * the mkey won't be part of the tree, in both cases the kernel is safe.
- */
-static void devx_cleanup_mkey(struct devx_obj *obj)
-{
-	xa_erase(&obj->ib_dev->mdev->priv.mkey_table,
-		 mlx5_base_mkey(obj->devx_mr.mmkey.key));
-}
-
 static void devx_cleanup_subscription(struct mlx5_ib_dev *dev,
 				      struct devx_event_subscription *sub)
 {
@@ -1362,8 +1339,16 @@ static int devx_obj_cleanup(struct ib_uobject *uobject,
 	int ret;
 
 	dev = mlx5_udata_to_mdev(&attrs->driver_udata);
-	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY)
-		devx_cleanup_mkey(obj);
+	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
+		/*
+		 * The pagefault_single_data_segment() does commands against
+		 * the mmkey, we must wait for that to stop before freeing the
+		 * mkey, as another allocation could get the same mkey #.
+		 */
+		xa_erase(&obj->ib_dev->mdev->priv.mkey_table,
+			 mlx5_base_mkey(obj->devx_mr.mmkey.key));
+		synchronize_srcu(&dev->mr_srcu);
+	}
 
 	if (obj->flags & DEVX_OBJ_FLAGS_DCT)
 		ret = mlx5_core_destroy_dct(obj->ib_dev->mdev, &obj->core_dct);
@@ -1382,12 +1367,6 @@ static int devx_obj_cleanup(struct ib_uobject *uobject,
 		devx_cleanup_subscription(dev, sub_entry);
 	mutex_unlock(&devx_event_table->event_xa_lock);
 
-	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
-		call_srcu(&dev->mr_srcu, &obj->devx_mr.rcu,
-			  devx_free_indirect_mkey);
-		return ret;
-	}
-
 	kfree(obj);
 	return ret;
 }
@@ -1491,26 +1470,21 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 				   &obj_id);
 	WARN_ON(obj->dinlen > MLX5_MAX_DESTROY_INBOX_SIZE_DW * sizeof(u32));
 
-	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
-		err = devx_handle_mkey_indirect(obj, dev, cmd_in, cmd_out);
-		if (err)
-			goto obj_destroy;
-	}
-
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_DEVX_OBJ_CREATE_CMD_OUT, cmd_out, cmd_out_len);
 	if (err)
-		goto err_copy;
+		goto obj_destroy;
 
 	if (opcode == MLX5_CMD_OP_CREATE_GENERAL_OBJECT)
 		obj_type = MLX5_GET(general_obj_in_cmd_hdr, cmd_in, obj_type);
-
 	obj->obj_id = get_enc_obj_id(opcode | obj_type << 16, obj_id);
 
+	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
+		err = devx_handle_mkey_indirect(obj, dev, cmd_in, cmd_out);
+		if (err)
+			goto obj_destroy;
+	}
 	return 0;
 
-err_copy:
-	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY)
-		devx_cleanup_mkey(obj);
 obj_destroy:
 	if (obj->flags & DEVX_OBJ_FLAGS_DCT)
 		mlx5_core_destroy_dct(obj->ib_dev->mdev, &obj->core_dct);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 15e42825cc976e..1a98ee2e01c4b9 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -639,7 +639,6 @@ struct mlx5_ib_mw {
 struct mlx5_ib_devx_mr {
 	struct mlx5_core_mkey	mmkey;
 	int			ndescs;
-	struct rcu_head		rcu;
 };
 
 struct mlx5_ib_umr_context {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3a27bddfcf31f5..630599311586ec 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1962,14 +1962,25 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 
 int mlx5_ib_dealloc_mw(struct ib_mw *mw)
 {
+	struct mlx5_ib_dev *dev = to_mdev(mw->device);
 	struct mlx5_ib_mw *mmw = to_mmw(mw);
 	int err;
 
-	err =  mlx5_core_destroy_mkey((to_mdev(mw->device))->mdev,
-				      &mmw->mmkey);
-	if (!err)
-		kfree(mmw);
-	return err;
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
+		xa_erase(&dev->mdev->priv.mkey_table,
+			 mlx5_base_mkey(mmw->mmkey.key));
+		/*
+		 * pagefault_single_data_segment() may be accessing mmw under
+		 * SRCU if the user bound an ODP MR to this MW.
+		 */
+		synchronize_srcu(&dev->mr_srcu);
+	}
+
+	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
+	if (err)
+		return err;
+	kfree(mmw);
+	return 0;
 }
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mr.c b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
index 9231b39d18b21c..c501bf2a025210 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
@@ -112,17 +112,11 @@ int mlx5_core_destroy_mkey(struct mlx5_core_dev *dev,
 	u32 out[MLX5_ST_SZ_DW(destroy_mkey_out)] = {0};
 	u32 in[MLX5_ST_SZ_DW(destroy_mkey_in)]   = {0};
 	struct xarray *mkeys = &dev->priv.mkey_table;
-	struct mlx5_core_mkey *deleted_mkey;
 	unsigned long flags;
 
 	xa_lock_irqsave(mkeys, flags);
-	deleted_mkey = __xa_erase(mkeys, mlx5_base_mkey(mkey->key));
+	__xa_erase(mkeys, mlx5_base_mkey(mkey->key));
 	xa_unlock_irqrestore(mkeys, flags);
-	if (!deleted_mkey) {
-		mlx5_core_dbg(dev, "failed xarray delete of mkey 0x%x\n",
-			      mlx5_base_mkey(mkey->key));
-		return -ENOENT;
-	}
 
 	MLX5_SET(destroy_mkey_in, in, opcode, MLX5_CMD_OP_DESTROY_MKEY);
 	MLX5_SET(destroy_mkey_in, in, mkey_index, mlx5_mkey_to_idx(mkey->key));
-- 
2.23.0

