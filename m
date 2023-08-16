Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16677DAB7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjHPGwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbjHPGwn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 02:52:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD719A1
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 23:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6709564E24
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 06:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48707C433C8;
        Wed, 16 Aug 2023 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692168760;
        bh=abWiWPKwcgaHPVQRZlXrDvbyWt7euJGqA6mcYi7jVrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFijh41P+NVInGCZcyfdxuBf//Px+ckUMXhH7J8rIx6rDJjNftufP8KaOabxNSxU7
         dP0iw22bl4SxL/4LlTlrh8BWuvb8dC0VJk3ZwKIQOCDoRlYwppQ6Z/SR5bXYJUg/v8
         3HOvfu4kCpElSjr2ExTJTzo1Mfeu3CXivpwRaYUdJYL62M/o5gxsfMNLFI7WbUJ9jD
         ZnhLPAx3krpbFIdN+A3AZ0Ime770idL/pEewkGzw4oZ0qWfCpsMhYNrSb15SFkan+W
         B87xC9OnaJT9Cak37It9O6F+iDgr83SjohhdPv9uwZCk71Kcd77S4H9zITqrlCJx++
         MeHwUOkat4z+A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Send correct port events
Date:   Wed, 16 Aug 2023 09:52:24 +0300
Message-ID: <86a8473d0ccea1b66e59eb86457359be9005cfcb.1692168533.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692168533.git.leon@kernel.org>
References: <cover.1692168533.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

When operating in switchdev mode and with an active LAG, the function
mlx5_lag_get_roce_netdev() fails to return a valid net device as this
function is designed specifically for RoCE LAGs.

Consequently, this issue resulted in the driver sending incorrect event
reports. To address this, a new API is introduced to properly obtain the
net device. Additionally, some code logic is cleaned up during this
modification.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c             | 39 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 29 ++++++++++++++
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 215d7b0add8f..8b98200bd94c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -159,6 +159,29 @@ static struct mlx5_roce *mlx5_get_rep_roce(struct mlx5_ib_dev *dev,
 	return NULL;
 }
 
+static bool mlx5_netdev_send_event(struct mlx5_ib_dev *dev,
+				   struct net_device *ndev,
+				   struct net_device *upper,
+				   struct mlx5_roce *roce)
+{
+	if (!dev->ib_active)
+		return false;
+
+	/* Event is about our upper device */
+	if (upper == ndev)
+		return true;
+
+	/* RDMA device not in lag and not in switchdev */
+	if (!dev->is_rep && !upper && ndev == roce->netdev)
+		return true;
+
+	/* RDMA device in switchdev */
+	if (dev->is_rep && ndev == roce->netdev)
+		return true;
+
+	return false;
+}
+
 static int mlx5_netdev_event(struct notifier_block *this,
 			     unsigned long event, void *ptr)
 {
@@ -200,7 +223,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		if (ibdev->lag_active) {
 			struct net_device *lag_ndev;
 
-			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			lag_ndev = mlx5_lag_get_netdev(mdev);
 			if (lag_ndev) {
 				upper = netdev_master_upper_dev_get(lag_ndev);
 				dev_put(lag_ndev);
@@ -209,13 +232,13 @@ static int mlx5_netdev_event(struct notifier_block *this,
 			}
 		}
 
-		if (ibdev->is_rep)
+		if (ibdev->is_rep) {
 			roce = mlx5_get_rep_roce(ibdev, ndev, upper, &port_num);
-		if (!roce)
-			return NOTIFY_DONE;
-		if ((upper == ndev ||
-		     ((!upper || ibdev->is_rep) && ndev == roce->netdev)) &&
-		    ibdev->ib_active) {
+			if (!roce)
+				return NOTIFY_DONE;
+		}
+
+		if (mlx5_netdev_send_event(ibdev, ndev, upper, roce)) {
 			struct ib_event ibev = { };
 			enum ib_port_state port_state;
 
@@ -260,7 +283,7 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	if (!mdev)
 		return NULL;
 
-	if (ibdev->lag_active) {
+	if (!ibdev->is_rep && ibdev->lag_active) {
 		ndev = mlx5_lag_get_roce_netdev(mdev);
 		if (ndev)
 			goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index f0a074b2fcdf..83298e9addd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1498,6 +1498,35 @@ struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_lag_get_roce_netdev);
 
+struct net_device *mlx5_lag_get_netdev(struct mlx5_core_dev *dev)
+{
+	struct net_device *ndev = NULL;
+	struct mlx5_lag *ldev;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&lag_lock, flags);
+	ldev = mlx5_lag_dev(dev);
+
+	if (!(ldev && __mlx5_lag_is_active(ldev)))
+		goto unlock;
+
+	for (i = 0; i < ldev->ports; i++) {
+		if (ldev->pf[i].dev == dev) {
+			ndev = ldev->pf[i].netdev;
+			break;
+		}
+	}
+
+	if (ndev)
+		dev_hold(ndev);
+
+unlock:
+	spin_unlock_irqrestore(&lag_lock, flags);
+	return ndev;
+}
+EXPORT_SYMBOL(mlx5_lag_get_netdev);
+
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave)
 {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 25d0528f9219..bc7e3a974f62 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1160,6 +1160,8 @@ bool mlx5_lag_is_master(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);
 struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev);
+
+struct net_device *mlx5_lag_get_netdev(struct mlx5_core_dev *dev);
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave);
 int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
-- 
2.41.0

