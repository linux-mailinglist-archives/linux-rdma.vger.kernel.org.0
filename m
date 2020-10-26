Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0802298DBE
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421312AbgJZNX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421516AbgJZNX0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:23:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8DD20809;
        Mon, 26 Oct 2020 13:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718606;
        bh=kO40AJsaHqpSgCtFdiKsTi5Kb54CFxGHjDJThsEHT1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mx6/Ib/xqK3KPWJhmDJ+A0CyeWMAA0wVLr/iraBhHijYu+JZPSBc3S76f+24x852b
         kJnq+irpiXZp+s3JBKD/Bj7rBPpvio+593Pk0l96mDz7hAko5NTVTVNXfKzsUHiKOA
         tkp7tXRGwVYMLmkFLvT2LD9mcwfhn50Ll36Z1pBA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/5] RDMA/mlx5: Move xlt_emergency_page_mutex into mr.c
Date:   Mon, 26 Oct 2020 15:23:11 +0200
Message-Id: <20201026132314.1336717-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132314.1336717-1-leon@kernel.org>
References: <20201026132314.1336717-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is the only user, so remove the wrappers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 20 --------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 +--
 drivers/infiniband/hw/mlx5/mr.c      | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index bca57c7661eb..b7eb977eb869 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -75,12 +75,6 @@ static LIST_HEAD(mlx5_ib_dev_list);
  */
 static DEFINE_MUTEX(mlx5_ib_multiport_mutex);
 
-/* We can't use an array for xlt_emergency_page because dma_map_single
- * doesn't work on kernel modules memory
- */
-static unsigned long xlt_emergency_page;
-static struct mutex xlt_emergency_page_mutex;
-
 struct mlx5_ib_dev *mlx5_ib_get_ibdev_from_mpi(struct mlx5_ib_multiport_info *mpi)
 {
 	struct mlx5_ib_dev *dev;
@@ -4877,17 +4871,6 @@ static struct mlx5_interface mlx5_ib_interface = {
 	.protocol	= MLX5_INTERFACE_PROTOCOL_IB,
 };
 
-unsigned long mlx5_ib_get_xlt_emergency_page(void)
-{
-	mutex_lock(&xlt_emergency_page_mutex);
-	return xlt_emergency_page;
-}
-
-void mlx5_ib_put_xlt_emergency_page(void)
-{
-	mutex_unlock(&xlt_emergency_page_mutex);
-}
-
 static int __init mlx5_ib_init(void)
 {
 	int err;
@@ -4896,8 +4879,6 @@ static int __init mlx5_ib_init(void)
 	if (!xlt_emergency_page)
 		return -ENOMEM;
 
-	mutex_init(&xlt_emergency_page_mutex);
-
 	mlx5_ib_event_wq = alloc_ordered_workqueue("mlx5_ib_event_wq", 0);
 	if (!mlx5_ib_event_wq) {
 		free_page(xlt_emergency_page);
@@ -4915,7 +4896,6 @@ static void __exit mlx5_ib_cleanup(void)
 {
 	mlx5_unregister_interface(&mlx5_ib_interface);
 	destroy_workqueue(mlx5_ib_event_wq);
-	mutex_destroy(&xlt_emergency_page_mutex);
 	free_page(xlt_emergency_page);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b043a178e95b..8f728b98f9a6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1454,8 +1454,7 @@ static inline int get_num_static_uars(struct mlx5_ib_dev *dev,
 	return get_uars_per_sys_page(dev, bfregi->lib_uar_4k) * bfregi->num_static_sys_pages;
 }
 
-unsigned long mlx5_ib_get_xlt_emergency_page(void);
-void mlx5_ib_put_xlt_emergency_page(void);
+extern unsigned long xlt_emergency_page;
 
 int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			struct mlx5_bfreg_info *bfregi, u32 bfregn,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b7119722a54a..2971e7f48d40 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -41,6 +41,13 @@
 #include <rdma/ib_verbs.h>
 #include "mlx5_ib.h"
 
+/*
+ * We can't use an array for xlt_emergency_page because dma_map_single doesn't
+ * work on kernel modules memory
+ */
+unsigned long xlt_emergency_page;
+static DEFINE_MUTEX(xlt_emergency_page_mutex);
+
 enum {
 	MAX_PENDING_REG_MR = 8,
 };
@@ -992,6 +999,17 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 			    MLX5_UMR_MTT_ALIGNMENT)
 #define MLX5_SPARE_UMR_CHUNK 0x10000
 
+static unsigned long mlx5_ib_get_xlt_emergency_page(void)
+{
+	mutex_lock(&xlt_emergency_page_mutex);
+	return xlt_emergency_page;
+}
+
+static void mlx5_ib_put_xlt_emergency_page(void)
+{
+	mutex_unlock(&xlt_emergency_page_mutex);
+}
+
 int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags)
 {
-- 
2.26.2

