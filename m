Return-Path: <linux-rdma+bounces-6201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD49E20C3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 16:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D794AB606CB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C481F4712;
	Tue,  3 Dec 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMnxaMJq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175561F12FC
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234238; cv=none; b=kHO5Nv00h1BlGaCul9dB/Xjd1ujndrF2FGpr9wz6sC1bhS+fYdzn7DKQerI/MYEjuG3J7dPQ0Bd72pdxkpoG3RW2Coge0aAPAHCN44zc35riptuYg0dw2TpObrT1tV8d2C5iIhcwnr5XsVWDfWifKA0xkmCPMuGImOCJnAK+Yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234238; c=relaxed/simple;
	bh=GZOx8AQUGLuF8wE1I1EJ2WOfMbXAdc0rEOqp/hysqDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zt2ZA/P610CmYAI5TxMQnRHi47Gdji8CZJbztf9sOJaUY7TxbkXLgHFRqeKrD111u9dFHogKcG4wG1d4WlruAgXE4MY5kI3Ex2qZygJS2E23D+qG8TXZ+ASQUpJE8r/VL8B56f4s3VjJ+/jV5nWNyGHyinS6cceHfKtcsYHyPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMnxaMJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53131C4CECF;
	Tue,  3 Dec 2024 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733234237;
	bh=GZOx8AQUGLuF8wE1I1EJ2WOfMbXAdc0rEOqp/hysqDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZMnxaMJq/xCxoSr1nfESLNAbR1cOaIJSKcxhkyN+fsW4ji7eA+q0YX5CqVKUSRmcQ
	 d4yiPPHTyra2ztsqOl2RLv3Z41kxw3qAOz/LPFAIAZ2BoSkMJZGVAWHbjr9RMKuhVG
	 tdrp6QK7Vq3w2AWU8tZSx+r9BmhB2MKa+k/N8XYbuhDVfQsUvGPVOOgQwXax9MExzm
	 3p8tun6HG/UYzaMwWmluXt8LJZR1koVkIMaR30C1ZQQkPnk7D18rL3g++659EXHNtH
	 mI4vHnG/nonVzMrtHpLb6mnSgCP1glQvBnCOnhsO6n2VhqYpE9doSgpYJR9Q9gmyCy
	 uqN0AM8CoWOyA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Extend ODP statistics with operation count
Date: Tue,  3 Dec 2024 15:57:11 +0200
Message-ID: <b18f29ed1392996ade66e9e6c45f018925253f6a.1733234165.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

The current ODP counters represent the total number of pages
handled, but it is not enough to understand the effectiveness
of these operations.

Extend the ODP counters to include the number of times page fault
and invalidation events were handled.

Example for a single page fault handling 512 pages:
- page_fault: incremented by 512 (total pages)
- page_fault_handled: incremented by 1 (operation count)

The same example is applicable for page invalidation too.

Previous output:
$ rdma stat mr
dev rocep8s0f0 mrn 8 page_faults 27 page_invalidations 0 page_prefetch 29

New output:
$ rdma stat mr
dev rocep8s0f0 mrn 21 page_faults 512 page_faults_handled 1
page_invalidations 0 page_invalidations_handled 0 page_prefetch 51200

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 6 ++++++
 drivers/infiniband/hw/mlx5/odp.c      | 6 +++---
 drivers/infiniband/hw/mlx5/restrack.c | 9 +++++++++
 include/rdma/ib_verbs.h               | 2 ++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d6b045276244..73577360b265 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -669,6 +669,12 @@ struct mlx5_ib_mkey {
 #define mlx5_update_odp_stats(mr, counter_name, value)		\
 	atomic64_add(value, &((mr)->odp_stats.counter_name))
 
+#define mlx5_update_odp_stats_with_handled(mr, counter_name, value)         \
+	do {                                                                \
+		mlx5_update_odp_stats(mr, counter_name, value);             \
+		atomic64_add(1, &((mr)->odp_stats.counter_name##_handled)); \
+	} while (0)
+
 struct mlx5_ib_mr {
 	struct ib_mr ibmr;
 	struct mlx5_ib_mkey mmkey;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4b37446758fd..4eb03fc0d302 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -313,7 +313,7 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				     MLX5_IB_UPD_XLT_ZAP |
 				     MLX5_IB_UPD_XLT_ATOMIC);
 
-	mlx5_update_odp_stats(mr, invalidations, invalidations);
+	mlx5_update_odp_stats_with_handled(mr, invalidations, invalidations);
 
 	/*
 	 * We are now sure that the device will not access the
@@ -997,7 +997,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 		if (ret < 0)
 			goto end;
 
-		mlx5_update_odp_stats(mr, faults, ret);
+		mlx5_update_odp_stats_with_handled(mr, faults, ret);
 
 		npages += ret;
 		ret = 0;
@@ -1529,7 +1529,7 @@ static void mlx5_ib_mr_memory_pfault_handler(struct mlx5_ib_dev *dev,
 			goto err;
 	}
 
-	mlx5_update_odp_stats(mr, faults, ret);
+	mlx5_update_odp_stats_with_handled(mr, faults, ret);
 	mlx5r_deref_odp_mkey(mmkey);
 
 	if (pfault->memory.flags & MLX5_MEMORY_PAGE_FAULT_FLAGS_LAST)
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index affcf8fe943c..67841922c7b8 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -95,10 +95,19 @@ static int fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 	if (rdma_nl_stat_hwcounter_entry(msg, "page_faults",
 					 atomic64_read(&mr->odp_stats.faults)))
 		goto err_table;
+	if (rdma_nl_stat_hwcounter_entry(
+		    msg, "page_faults_handled",
+		    atomic64_read(&mr->odp_stats.faults_handled)))
+		goto err_table;
 	if (rdma_nl_stat_hwcounter_entry(
 		    msg, "page_invalidations",
 		    atomic64_read(&mr->odp_stats.invalidations)))
 		goto err_table;
+	if (rdma_nl_stat_hwcounter_entry(
+		    msg, "page_invalidations_handled",
+		    atomic64_read(&mr->odp_stats.invalidations_handled)))
+		goto err_table;
+
 	if (rdma_nl_stat_hwcounter_entry(msg, "page_prefetch",
 					 atomic64_read(&mr->odp_stats.prefetch)))
 		goto err_table;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3417636da960..6ddd5e3bb884 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2256,7 +2256,9 @@ struct rdma_netdev_alloc_params {
 
 struct ib_odp_counters {
 	atomic64_t faults;
+	atomic64_t faults_handled;
 	atomic64_t invalidations;
+	atomic64_t invalidations_handled;
 	atomic64_t prefetch;
 };
 
-- 
2.47.0


