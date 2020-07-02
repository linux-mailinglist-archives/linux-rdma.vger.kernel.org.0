Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D482C211DEB
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGBIS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgGBIS3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A45720720;
        Thu,  2 Jul 2020 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593677908;
        bh=A4z+5/FiVnLJ3sUW77otsYo3836vsyoAvA7O/I/8qNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSb7UOm5uRKF2gy1ME91JH5zGEqB7/wdEvo0sEUIODwHJhSvmh5/yRNS+vfdKpznm
         QBMFU51hUJTylPRrc3Hc4ODT8AJj2de4LGLF4evALXVcivULXSEnvPRORKcgcD9aZc
         l4mkZYI0hdorhKYepdaNB//+xmt9lDc+UftXygqk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/6] RDMA/mlx5: Cleanup DEVX initialization flow
Date:   Thu,  2 Jul 2020 11:18:08 +0300
Message-Id: <20200702081809.423482-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702081809.423482-1-leon@kernel.org>
References: <20200702081809.423482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Move DEVX initialization and cleanup flows to the devx.c instead of
having almost empty functions in main.c

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c    | 43 +++++++++++++++++-----------
 drivers/infiniband/hw/mlx5/devx.h    | 19 ++++++++++++
 drivers/infiniband/hw/mlx5/main.c    | 29 ++++---------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 ---------
 4 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index c7dffd799d16..e9cf294f8529 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2362,17 +2362,24 @@ static int devx_event_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-void mlx5_ib_devx_init_event_table(struct mlx5_ib_dev *dev)
+int mlx5_ib_devx_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_devx_event_table *table = &dev->devx_event_table;
+	int uid;
+
+	uid = mlx5_ib_devx_create(dev, false);
+	if (uid > 0) {
+		dev->devx_whitelist_uid = uid;
+		xa_init(&table->event_xa);
+		mutex_init(&table->event_xa_lock);
+		MLX5_NB_INIT(&table->devx_nb, devx_event_notifier, NOTIFY_ANY);
+		mlx5_eq_notifier_register(dev->mdev, &table->devx_nb);
+	}
 
-	xa_init(&table->event_xa);
-	mutex_init(&table->event_xa_lock);
-	MLX5_NB_INIT(&table->devx_nb, devx_event_notifier, NOTIFY_ANY);
-	mlx5_eq_notifier_register(dev->mdev, &table->devx_nb);
+	return 0;
 }
 
-void mlx5_ib_devx_cleanup_event_table(struct mlx5_ib_dev *dev)
+void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_devx_event_table *table = &dev->devx_event_table;
 	struct devx_event_subscription *sub, *tmp;
@@ -2380,17 +2387,21 @@ void mlx5_ib_devx_cleanup_event_table(struct mlx5_ib_dev *dev)
 	void *entry;
 	unsigned long id;
 
-	mlx5_eq_notifier_unregister(dev->mdev, &table->devx_nb);
-	mutex_lock(&dev->devx_event_table.event_xa_lock);
-	xa_for_each(&table->event_xa, id, entry) {
-		event = entry;
-		list_for_each_entry_safe(sub, tmp, &event->unaffiliated_list,
-					 xa_list)
-			devx_cleanup_subscription(dev, sub);
-		kfree(entry);
+	if (dev->devx_whitelist_uid) {
+		mlx5_eq_notifier_unregister(dev->mdev, &table->devx_nb);
+		mutex_lock(&dev->devx_event_table.event_xa_lock);
+		xa_for_each(&table->event_xa, id, entry) {
+			event = entry;
+			list_for_each_entry_safe(
+				sub, tmp, &event->unaffiliated_list, xa_list)
+				devx_cleanup_subscription(dev, sub);
+			kfree(entry);
+		}
+		mutex_unlock(&dev->devx_event_table.event_xa_lock);
+		xa_destroy(&table->event_xa);
+
+		mlx5_ib_devx_destroy(dev, dev->devx_whitelist_uid);
 	}
-	mutex_unlock(&dev->devx_event_table.event_xa_lock);
-	xa_destroy(&table->event_xa);
 }
 
 static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
diff --git a/drivers/infiniband/hw/mlx5/devx.h b/drivers/infiniband/hw/mlx5/devx.h
index 9afaa5d22797..1f69866aed16 100644
--- a/drivers/infiniband/hw/mlx5/devx.h
+++ b/drivers/infiniband/hw/mlx5/devx.h
@@ -23,4 +23,23 @@ struct devx_obj {
 	};
 	struct list_head event_sub; /* holds devx_event_subscription entries */
 };
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
+void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid);
+int mlx5_ib_devx_init(struct mlx5_ib_dev *dev);
+void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev);
+#else
+static inline int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
+{
+	return -EOPNOTSUPP;
+}
+static inline void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid) {}
+static inline int mlx5_ib_devx_init(struct mlx5_ib_dev *dev)
+{
+	return 0;
+}
+static inline void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev)
+{
+}
+#endif
 #endif /* _MLX5_IB_DEVX_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fc84264939a2..882755f7adf0 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -32,6 +32,7 @@
 #include "mlx5_ib.h"
 #include "ib_rep.h"
 #include "cmd.h"
+#include "devx.h"
 #include "fs.h"
 #include "srq.h"
 #include "qp.h"
@@ -4666,26 +4667,6 @@ static void mlx5_ib_stage_dev_notifier_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_notifier_unregister(dev->mdev, &dev->mdev_events);
 }
 
-static int mlx5_ib_stage_devx_init(struct mlx5_ib_dev *dev)
-{
-	int uid;
-
-	uid = mlx5_ib_devx_create(dev, false);
-	if (uid > 0) {
-		dev->devx_whitelist_uid = uid;
-		mlx5_ib_devx_init_event_table(dev);
-	}
-
-	return 0;
-}
-static void mlx5_ib_stage_devx_cleanup(struct mlx5_ib_dev *dev)
-{
-	if (dev->devx_whitelist_uid) {
-		mlx5_ib_devx_cleanup_event_table(dev);
-		mlx5_ib_devx_destroy(dev, dev->devx_whitelist_uid);
-	}
-}
-
 void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
 		      const struct mlx5_ib_profile *profile,
 		      int stage)
@@ -4776,8 +4757,8 @@ static const struct mlx5_ib_profile pf_profile = {
 		     NULL,
 		     mlx5_ib_stage_pre_ib_reg_umr_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_WHITELIST_UID,
-		     mlx5_ib_stage_devx_init,
-		     mlx5_ib_stage_devx_cleanup),
+		     mlx5_ib_devx_init,
+		     mlx5_ib_devx_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
 		     mlx5_ib_stage_ib_reg_init,
 		     mlx5_ib_stage_ib_reg_cleanup),
@@ -4836,8 +4817,8 @@ const struct mlx5_ib_profile raw_eth_profile = {
 		     NULL,
 		     mlx5_ib_stage_pre_ib_reg_umr_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_WHITELIST_UID,
-		     mlx5_ib_stage_devx_init,
-		     mlx5_ib_stage_devx_cleanup),
+		     mlx5_ib_devx_init,
+		     mlx5_ib_devx_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
 		     mlx5_ib_stage_ib_reg_init,
 		     mlx5_ib_stage_ib_reg_cleanup),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3196fbe89818..6c3bd129e30a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1352,20 +1352,6 @@ extern const struct uapi_definition mlx5_ib_flow_defs[];
 extern const struct uapi_definition mlx5_ib_qos_defs[];
 extern const struct uapi_definition mlx5_ib_std_types_defs[];
 
-
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
-void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid);
-void mlx5_ib_devx_init_event_table(struct mlx5_ib_dev *dev);
-void mlx5_ib_devx_cleanup_event_table(struct mlx5_ib_dev *dev);
-#else
-static inline int
-mlx5_ib_devx_create(struct mlx5_ib_dev *dev,
-			   bool is_user) { return -EOPNOTSUPP; }
-static inline void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid) {}
-static inline void mlx5_ib_devx_init_event_table(struct mlx5_ib_dev *dev) {}
-static inline void mlx5_ib_devx_cleanup_event_table(struct mlx5_ib_dev *dev) {}
-#endif
 static inline void init_query_mad(struct ib_smp *mad)
 {
 	mad->base_version  = 1;
-- 
2.26.2

