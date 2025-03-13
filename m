Return-Path: <linux-rdma+bounces-8662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6CA5F76C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204C717B8DA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07925267B15;
	Thu, 13 Mar 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbjHZVAL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD268261389
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875540; cv=none; b=c49TFQE8CcqJtFHevusIFg8EFFLjCyQ1vlYw86r6OvjeVbuW2eaVgIyGql9DeMjHoq9Ryt6xUzoTddS1BB1XM4mZJW3Ek2O8CzPVLacgq09iVPkJryztCxzSZNPcdoGONS0ZOQdpJwbmMF8XcOaIl5m+sW+yWz9Ezrg9/D0uSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875540; c=relaxed/simple;
	bh=g5Db0RxCh8IN/6FVbMRC0A7Hz0c9BrspRo8DEmLXa18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9lzJCbeBhzkBE6/E3e6tDb1X2LbF8Ml5TmK3sTSBsFw+ql75VsMxX4KQ3qCznUTY/gYIzwu/agyiaZE1Ig0sNKhGpZMB5H6qpOlmuS9ZC1jlFenGPA0fqoL8W4Ux3FZSdxrC9KMRrvwCb1W/uY2xsjldX7s71iSeItG8kGRYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbjHZVAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F3DC4CEE5;
	Thu, 13 Mar 2025 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875540;
	bh=g5Db0RxCh8IN/6FVbMRC0A7Hz0c9BrspRo8DEmLXa18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbjHZVALtRArowG8ftPyqto7ZuS6VqlFThW7wNzlsdm/O2+mdY6mBXIKh2QTd6Gpk
	 LXDVaY1yZCoXV4VfaL+8UHPSH1G658OTibFLG7rw/eSIhQYAndA+828QvivesE0ePA
	 yYb/r6Yr3LI5BZavV3gdxI46tbq4L0rgrmYOry5f9z40KwyZkHNCSup9WX+XQpE30D
	 D8E40sOi5ynnC8kaeymjpgN62nE4dCOse/d+uvXoEeiHym+zypYhegBcmw9YSMWUxP
	 ziI5dwvODCxulclSvTZxmQC9A6tCgIirUv/sUEIXU4rzTnzEaqJmQGsbITP5+EmNB8
	 7nhUfD0nfDoEw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 2/6] RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_obj()
Date: Thu, 13 Mar 2025 16:18:42 +0200
Message-ID: <a5a484f421fc2e5595158e61a354fba43272b02d.1741875070.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875070.git.leon@kernel.org>
References: <cover.1741875070.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Change rdma_counter allocation to use rdma_zalloc_drv_obj() instead of,
explicitly allocating at core, in order to be contained inside driver
specific structures.

Adjust all drivers that use it to have their containing structure, and
add driver specific initialization operation.

This change is needed to allow upcoming patches to implement
optional-counters binding whereas inside each driver specific counter
struct his bound optional-counters will be maintained.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c    |  4 +++-
 drivers/infiniband/core/device.c      |  2 ++
 drivers/infiniband/hw/mlx5/counters.c |  8 ++++++++
 drivers/infiniband/hw/mlx5/counters.h | 11 +++++++++++
 include/rdma/ib_verbs.h               |  6 ++++++
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index af59486fe418..981d5a28614a 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -149,13 +149,15 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
 	if (!dev->ops.counter_dealloc || !dev->ops.counter_alloc_stats)
 		return NULL;
 
-	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
+	counter = rdma_zalloc_drv_obj(dev, rdma_counter);
 	if (!counter)
 		return NULL;
 
 	counter->device    = dev;
 	counter->port      = port;
 
+	dev->ops.counter_init(counter);
+
 	rdma_restrack_new(&counter->res, RDMA_RESTRACK_COUNTER);
 	counter->stats = dev->ops.counter_alloc_stats(counter);
 	if (!counter->stats)
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ee75b99f84bc..b4e3e4beb7f4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2683,6 +2683,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, counter_alloc_stats);
 	SET_DEVICE_OP(dev_ops, counter_bind_qp);
 	SET_DEVICE_OP(dev_ops, counter_dealloc);
+	SET_DEVICE_OP(dev_ops, counter_init);
 	SET_DEVICE_OP(dev_ops, counter_unbind_qp);
 	SET_DEVICE_OP(dev_ops, counter_update_stats);
 	SET_DEVICE_OP(dev_ops, create_ah);
@@ -2797,6 +2798,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_srq);
 	SET_OBJ_SIZE(dev_ops, ib_ucontext);
 	SET_OBJ_SIZE(dev_ops, ib_xrcd);
+	SET_OBJ_SIZE(dev_ops, rdma_counter);
 }
 EXPORT_SYMBOL(ib_set_device_ops);
 
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index e2a54c1dbc7a..018bb96bdbf4 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -1105,6 +1105,8 @@ static int mlx5_ib_modify_stat(struct ib_device *device, u32 port,
 	return 0;
 }
 
+static void mlx5_ib_counter_init(struct rdma_counter *counter) {}
+
 static const struct ib_device_ops hw_stats_ops = {
 	.alloc_hw_port_stats = mlx5_ib_alloc_hw_port_stats,
 	.get_hw_stats = mlx5_ib_get_hw_stats,
@@ -1115,6 +1117,9 @@ static const struct ib_device_ops hw_stats_ops = {
 	.counter_update_stats = mlx5_ib_counter_update_stats,
 	.modify_hw_stat = IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS) ?
 			  mlx5_ib_modify_stat : NULL,
+	.counter_init = mlx5_ib_counter_init,
+
+	INIT_RDMA_OBJ_SIZE(rdma_counter, mlx5_rdma_counter, rdma_counter),
 };
 
 static const struct ib_device_ops hw_switchdev_vport_op = {
@@ -1129,6 +1134,9 @@ static const struct ib_device_ops hw_switchdev_stats_ops = {
 	.counter_dealloc = mlx5_ib_counter_dealloc,
 	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
 	.counter_update_stats = mlx5_ib_counter_update_stats,
+	.counter_init = mlx5_ib_counter_init,
+
+	INIT_RDMA_OBJ_SIZE(rdma_counter, mlx5_rdma_counter, rdma_counter),
 };
 
 static const struct ib_device_ops counters_ops = {
diff --git a/drivers/infiniband/hw/mlx5/counters.h b/drivers/infiniband/hw/mlx5/counters.h
index 6bcaaa52e2b2..f153901a43be 100644
--- a/drivers/infiniband/hw/mlx5/counters.h
+++ b/drivers/infiniband/hw/mlx5/counters.h
@@ -8,6 +8,17 @@
 
 #include "mlx5_ib.h"
 
+
+struct mlx5_rdma_counter {
+	struct rdma_counter rdma_counter;
+};
+
+static inline struct mlx5_rdma_counter *
+to_mcounter(struct rdma_counter *counter)
+{
+	return container_of(counter, struct mlx5_rdma_counter, rdma_counter);
+}
+
 int mlx5_ib_counters_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_counters_cleanup(struct mlx5_ib_dev *dev);
 void mlx5_ib_counters_clear_description(struct ib_counters *counters);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9941f4185c79..90e93297d59e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2665,6 +2665,11 @@ struct ib_device_ops {
 	 */
 	int (*counter_update_stats)(struct rdma_counter *counter);
 
+	/**
+	 * counter_init - Initialize the driver specific rdma counter struct.
+	 */
+	void (*counter_init)(struct rdma_counter *counter);
+
 	/**
 	 * Allows rdma drivers to add their own restrack attributes
 	 * dumped via 'rdma stat' iproute2 command.
@@ -2716,6 +2721,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
 	DECLARE_RDMA_OBJ_SIZE(ib_xrcd);
+	DECLARE_RDMA_OBJ_SIZE(rdma_counter);
 };
 
 struct ib_core_device {
-- 
2.48.1


